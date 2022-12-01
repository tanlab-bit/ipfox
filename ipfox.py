#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import configparser
import logging
import smtplib
import socket
from datetime import datetime
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


class IPFox:
    def __init__(self, path):
        logging.info(f"Reading config file: {path}")
        config = configparser.ConfigParser()
        config.read(path)

        self.remote_ip = config["Connection"]["RemoteIP"]
        self.remote_port = int(config["Connection"]["RemotePort"])

        self.hostname = config["Email"]["Hostname"]
        self.subject = config["Email"]["Subject"]

        self.sender_host = config["Email"]["SenderHost"]
        self.sender_user = config["Email"]["SenderUser"]
        self.sender_auth = config["Email"]["SenderAuth"]
        self.receivers = [mail for _, mail in config.items("ReceiverList")]

    def get_ip(self):
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect((self.remote_ip, self.remote_port))
        ip = s.getsockname()[0]
        logging.info(f"Current host IP: {ip}")
        return ip

    def send_mail(self):
        # Get current time
        def now():
            return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        content = f"{self.hostname} rebooted at UTC {now()}, ip: {self.get_ip()}"
        logging.info(f"Email content: {content}")

        message = MIMEMultipart()
        message["From"] = Header(self.sender_user)
        message["To"] = Header(",".join(self.receivers))
        message["Subject"] = Header(self.subject)

        message.attach(MIMEText(content, "plain", "utf-8"))

        logging.info("Sending email...")
        with smtplib.SMTP(self.sender_host) as smtp:
            smtp.login(self.sender_user, self.sender_auth)
            smtp.sendmail(self.sender_user, self.receivers, message.as_string())
            logging.info(f"Done, email sent at time {now()}.")


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-c",
        "--config",
        type=str,
        default="ipfox.ini",
        metavar="STRING",
        help="path to config file",
    )
    args = parser.parse_args()
    path = args.config

    ipfox = IPFox(path)
    ipfox.send_mail()
