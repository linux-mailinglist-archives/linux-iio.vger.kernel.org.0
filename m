Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8663EC307
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhHNN4V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 09:56:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:37597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238523AbhHNN4V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Aug 2021 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628949327;
        bh=oirWK8f53ZhGtQZRUdXIiwXN3jynfvqqDCGUwEMI3IE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TjwoWCOGX4Y2yAtLejBCAlcqr12vaSceXnzM2yYFMXJw9X3s90Sf9qY8cWGCaFL+j
         xTgVwzgu/LHv34Wp4Kusdmf/Tym6cLTjxnJX4txV/7Fme6EnEL2fpcaFfvyBxezMmz
         J8wygowy/tHPTGgFG5hHnL2SXJN72HUISCbBI7Xw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Ma24s-1mZn2p00MW-00VzQC; Sat, 14 Aug 2021 15:55:27 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] drivers/iio: Remove all strcpy() uses
Date:   Sat, 14 Aug 2021 15:55:09 +0200
Message-Id: <20210814135509.4500-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wbAZIvOyO/2NXW+GZdxft/SGny5ZuRJgvK+wr/u1uLz1G2lP8ss
 jLbRjodMtUcXyJYn0VSRKxVqCJk8tCsNDJZTmBDGWDkBw3rstrha39n08YnUoob18tnXDoi
 txp/51jbDH+kUqSsWdkIDFJkyF72oJJY9dhroNuIWYzYaEk6ovWzN8wI5KsGV2WMILkbOir
 e6YrEyzc5Tm7fTL5umFgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K1/PrZK0DaQ=:TC03UH+ejTIVRLIqpormzx
 Bl8npx9Nq83jwG7rdkdbn4UwzbRqc7ROxHHiCM1LUNmy1TYvFnsOZC/0bFAZt2O22l3YDiJUK
 jtUXWw3nudhotEsaZzVYox5UfF23YtlpumhV6UAYdemybtpGN3kuYz2jyKqLrqwFJ0weE7T/M
 F/C1YdZSW6AYYQ190rVgPi00fQBpgewecZn6WetOIFOOOLmRamxmL6DrD6vRXIEW1kAVKSOBe
 XdD7mBGFEc4ouI6MCrUFUMBziXJh6GFWHf/tEQsu6MKxw6B+SaTaiT7X7ZR8Vw/zd0x5YYi++
 RmZftFublOfb3NDPlA5jv8EB6mw9lgO3HcjUY3OuNJDcD4NCqX97VH/IpqhXUSpH5Y8RzHGt6
 ZJCk3oA8W1NIb8+fY+oCi0RgYI9FK+zT4k7qsTFAMX/WI0gO7kG3JmNUQfya2WvhSIRrTFW3c
 U8CBw3YxAWNtY6URrmI3An/7PNyuHQ5sxbutvdhJ6QHulrQ38K4T6pmi0cf8O05iUZU4eWmoN
 ELOvv/8s3UlTwAnaP3eF1lffGDgMJF+diEc4cNTtvMY4gRZSkKNfel+3bHt88Zb/ywM/05PkW
 M8gLfdDiUYzvOJeyhETjGUmIrAUe4+RGEKGqX0HJYkwkJK/0vkpMSvgJL38naBLZrXVohpqLE
 ts3rjE/OjwlGq591TUskjXOX+Ljhif68ToBVArNSNhSbG9uqSOpbiRHbgPWPWAQO0H7lP79ZA
 YsPHbtDn2BA1CWIhkH5NX0tX3nUiUxiJxnUezMRi27UThshOJIcif9PJ6ADThtbC5z4Nyars2
 lJ9R8G+qLrljsedcnQ+HDWUA2of2lWvP4ITfXkJVAfc4QaZvtk+0dJwMFCDeYSTZGfAs6R15Y
 MqTzmJV6pEvX08zk6ghg5nZXGs7HO9TsfhJ3XB5aLbjZhvGoPGmuJ7e8UPYzQ0sp7V1o2qkB2
 UtYxjr4Cd2mprEFLF0aLIgH6zIDQRzOfM02hVKykB8Rv8exuErA1Vqr4PxXnQmQTso2PUzcOA
 1U4ey6oKUZsYKOD/fMyUB+VEuF5tmmpDGtRnmNWivqdR6cavLLS4n2gKP6dt7AZqAJmsjksLt
 olAg/euqwEY8juWoxynNcScfEFyqoJvzWBYiS6yViuWm7zgmTNP54EEhA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. So, remove all the uses and add
devm_kstrdup() or devm_kasprintf() instead.

This patch is an effort to clean up the proliferation of str*()
functions in the kernel and a previous step in the path to remove
the strcpy function from the kernel entirely [1].

[1] https://github.com/KSPP/linux/issues/88

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
The previous versions can be found in:

v1
https://lore.kernel.org/linux-hardening/20210801171157.17858-1-len.baker@g=
mx.com/

v2
https://lore.kernel.org/linux-hardening/20210807152225.9403-1-len.baker@gm=
x.com/

v3
https://lore.kernel.org/linux-hardening/20210814090618.8920-1-len.baker@gm=
x.com/

Changelog v1 -> v2
- Modify the commit changelog to inform that the motivation of this
  patch is to remove the strcpy() function from the kernel entirely
  (Jonathan Cameron).

Changelog v2 -> v3
- Rewrite the code using devm_kstrdup() and devm_kasprintf() functions
  (Andy Shevchenko).
- Rebase against v5.14-rc5.

Changelog v3 -> v4
- Reorder the variables (Andy Shevchenko).
- Get the device in the definition block (Andy Shevchenko).
- Reword the comment (Andy Shevchenko).
- Change the conditions in the "if" statement to clarify the "0" check
  (Andy Shevchenko).

 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 30 +++++++++++++---------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_magn.c
index f282e9cc34c5..7eceae0012c9 100644
=2D-- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -261,6 +261,7 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_sta=
te *st, int fifo_rate)
  */
 int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
 {
+	struct device *dev =3D regmap_get_device(st->map);
 	const char *orient;
 	char *str;
 	int i;
@@ -281,19 +282,24 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state=
 *st)
 		/* z <- -z */
 		for (i =3D 0; i < 3; ++i) {
 			orient =3D st->orientation.rotation[6 + i];
-			/* use length + 2 for adding minus sign if needed */
-			str =3D devm_kzalloc(regmap_get_device(st->map),
-					   strlen(orient) + 2, GFP_KERNEL);
-			if (str =3D=3D NULL)
+
+			/*
+			 * The value is negated according to one of the following
+			 * rules:
+			 *
+			 * 1) Drop leading minus.
+			 * 2) Leave 0 as is.
+			 * 3) Add leading minus.
+			 */
+			if (orient[0] =3D=3D '-')
+				str =3D devm_kstrdup(dev, orient + 1, GFP_KERNEL);
+			else if (orient[0] =3D=3D '0' && orient[1] =3D=3D '\0')
+				str =3D devm_kstrdup(dev, orient, GFP_KERNEL);
+			else
+				str =3D devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
+			if (!str)
 				return -ENOMEM;
-			if (strcmp(orient, "0") =3D=3D 0) {
-				strcpy(str, orient);
-			} else if (orient[0] =3D=3D '-') {
-				strcpy(str, &orient[1]);
-			} else {
-				str[0] =3D '-';
-				strcpy(&str[1], orient);
-			}
+
 			st->magn_orient.rotation[6 + i] =3D str;
 		}
 		break;
=2D-
2.25.1

