Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8443ECA79
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhHORnY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 13:43:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:57577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbhHORnX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 13:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629049343;
        bh=6AoH7oZM1JjIXr4zjh57kW/A2WvS24w8B79q66WMeGg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NquAJy1fIDyTBftP9G5DP8bBtwNtb/8YcV+sQyBeUmpMVMgkubLlADRJ/ghxzizTA
         do61Z5K33kHDYC3WMXB+7Gch3hldQgm8/MDsQ0t9aq/KDzLULuKD5nJu04+W4zRLGL
         foixHv1kR1dqEsBgU7diV2kpQpNe2pZYUJ9Cj1d0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N1wlv-1nCYSt3hxB-012HpN; Sun, 15 Aug 2021 19:42:23 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Len Baker <len.baker@gmx.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] drivers/iio: Remove all strcpy() uses
Date:   Sun, 15 Aug 2021 19:42:04 +0200
Message-Id: <20210815174204.126593-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ihbIysr7KBRuZcDvcUmXQJ6flnrpBiKvZBXqpJUrNTQwLUvI7H
 YfGUHa+lA4T6ve7RST0S0O6Hbvu1BjKcp0OcevpVd9aPqaEdyR9W3aw9OlD0u2Mh4pdeh1Q
 SNpx/cV6WtX/99B1FRLQbJcAVjW/ABrsIyY9BEACdvf8NCBwhmQkasjOu9s0GTVcEvrmxfp
 WT/7fU42gWNfs1i3dvrhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lFDMZyzasTs=:JVu8vw5VRgml2djeJgDtOX
 LyPZ2vJzsiu1QvJ2H0cOkSulhlotO703WBrxwyP9QKguHLfYBVQBrT1PiUTsGsLcNZLabYxQh
 IUc/oIj1Uvs//0XIh3ZsWox+r1nlAB7sRAiB/zgySvrg3zUs0Y+EK8nWpHtsb8rINLdVyx98Z
 35bwnWJFMDcPf3lJOpO/lJMQcAvQ6ndLx0o+3feqnuyWgyPAS+amVYxfkEhTTtgx4iqKDMVB5
 c5NyU+u4x4EOcV+HcVT83BWnrBq+4GHctvd1idF6PpBo/iTYTOrq9q6w5IxhCyzdPJPNnJb6d
 OA45J/CMIVJeQqUBKCF8n6wo9kSblSFdvko6xntALQFLX6RRQwZQORsKqr1rFoXZUy6F3hVas
 aAvC3lSQrXmwu2tOSKEF9dB4EUJYwFUnHZLnoOLiwIBS8weh2uVLdsOWNS4bNnkp2RveIRa6q
 GT/qs5Ttq9CMyRclTr4NgQBAxa5LWIeu1QEdBbi0ZrZ8yDNzoO5p4oYKSU08EhhkBTllpnMgl
 3Tr9+W1JEkknhwyaGQG86KrSac+SfVoSVIduXJxfwWZWDSXgaDoSqdJTsZxfagPQBAtn4/NoC
 XK5r7OI5Y03CpHvBn89s2FwE4NRBu49oaESNWNa+wJRoXRC72zUlTqqOKZy+x7XterUCOecmQ
 Hzb2yMtD7mm5WMluwk6SBZlTSFdkdEDKNnAmZOELwgZWTSMuuwuIwhAD3jsDGGgQu6waGGjZ7
 8R1JeO0ROEu4maUAe9Satdtxn8vK7+vBtXvzR7CvvM/6QbWZr7eoryZZ24U03ATKKed+2gqu1
 jRldDzjVjYsIU6b8KpbLJYxoVkHHrS0eg/W3iDNrXA7+t9DN9w5M/ExT+kQ1gNdArageTylh5
 hPz5MbDDZLB8IEyVO++fyFcG3WQDDGaqZPwMiYuSKHQCHXf1wqyVIeV3XnzGxeCT2poXprJJG
 N6s2HFWABwedVQVG5yhBXs1p1nFWxiLDZMLaAAhRPGom6o3x6Lv34yP7U4O65RNIZJHSMo2pu
 J1TyU4wL99Fy5Y9aKTiYWKjTG3rymxZg+uMPu77K02Mz2n10h7gnAom/cfsHvOJ6jXOGDpn2S
 S8njPJfS9MGYCzgmZ6HoBKvwXilQ473LfPZXzb+n1ZdAXZ0VfBftK4IuQ==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. So, remove all the uses and add
devm_kstrdup() or devm_kasprintf() instead.

Also, modify the "for" loop conditions to clarify the access to the
st->orientation.rotation buffer.

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

v4
https://lore.kernel.org/linux-hardening/20210814135509.4500-1-len.baker@gm=
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

Changelog v4 -> v5
- Use the strcmp() function to clarify the "0" check (Joe Perches).
- Modify the "for" loop conditions to clarify the access to the
  st->orientation.rotation buffer (Joe Perches).

 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 36 +++++++++++++---------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_magn.c
index f282e9cc34c5..6aee6c989485 100644
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
@@ -279,22 +280,27 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state=
 *st)
 		st->magn_orient.rotation[4] =3D st->orientation.rotation[1];
 		st->magn_orient.rotation[5] =3D st->orientation.rotation[2];
 		/* z <- -z */
-		for (i =3D 0; i < 3; ++i) {
-			orient =3D st->orientation.rotation[6 + i];
-			/* use length + 2 for adding minus sign if needed */
-			str =3D devm_kzalloc(regmap_get_device(st->map),
-					   strlen(orient) + 2, GFP_KERNEL);
-			if (str =3D=3D NULL)
+		for (i =3D 6; i < 9; ++i) {
+			orient =3D st->orientation.rotation[i];
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
+			else if (!strcmp(orient, "0"))
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
-			st->magn_orient.rotation[6 + i] =3D str;
+
+			st->magn_orient.rotation[i] =3D str;
 		}
 		break;
 	default:
=2D-
2.25.1

