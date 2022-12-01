#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import smtplib
import socket
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from time import asctime
import argparse
import configparser


parser = argparse.ArgumentParser()
parser.add_argument('-c','--path', 
						type=str, 
						default='ipfox.ini', 
						metavar='STRING',
						help='init'
					)
args = parser.parse_args()
path = args.path

config = configparser.ConfigParser()
config.read(path) 
RemoteIP = config['Connection']['RemoteIP']
RemotePort = int(config['Connection']['RemotePort'])
Hostname = config['Email']['Hostname']
SenderHost = config['Email']['SenderHost']
SenderUser = config['Email']['SenderUser']
SenderAuth = config['Email']['SenderAuth']
ReceiverList1 = config['Email']['ReceiverList1']
ReceiverList2 = config['Email']['ReceiverList2']

def send_an_email(email_content):
    mail_host = SenderHost
    mail_user = SenderUser
    mail_auth_code = SenderAuth
    mail_sender = mail_user  
    mail_receivers = [ReceiverList1,ReceiverList2]
    message = MIMEMultipart()
    message["From"] = Header(mail_sender)
    message["Subject"] = Header(f"{Hostname} IP Address")
    message.attach(MIMEText(asctime(), "plain", "utf-8"))
    message.attach(MIMEText(email_content, "plain", "utf-8"))
    print("message is {}".format(message.as_string()))
    smtpObj = smtplib.SMTP(mail_host)
    # smtpObj.set_debuglevel(1)
    smtpObj.login(mail_user, mail_auth_code)
    smtpObj.sendmail(mail_sender, mail_receivers, message.as_string())


def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect((RemoteIP, RemotePort))
    res = s.getsockname()[0]
    print(res)
    send_ip = res
    whether_to_send = True
    return whether_to_send, send_ip


if __name__ == "__main__":
    whether_to_send, global_ips = get_ip()
    if whether_to_send:
        send_an_email(global_ips)
    else:
        print("wait and no send")
