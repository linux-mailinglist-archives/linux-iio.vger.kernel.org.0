Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015193DCCD6
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 19:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhHARMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 13:12:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:42587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhHARMb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Aug 2021 13:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627837931;
        bh=fMjtxvQOIw1SnIwi4nyIOF/OnCL2DunPqIBE+G3CAQM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lv68nNY7VyrmSlDpjwfqvCjEJRqKEkwAnOZics5nPZufrdor9jr0j9CpLj2OWKdL/
         cD5tND8X52aYLw3VAmP8kvvRBAV0Z0ZjrWc6s2Ozt3xw2bDLvOg5/1MZVW+o+ugBxT
         9rv/yBQdRdwppqaJPzSzyB/2AlTPIB3dB4lvxc0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MAfUo-1mLHcI33c0-00B1h3; Sun, 01 Aug 2021 19:12:10 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Len Baker <len.baker@gmx.com>, linux-hardening@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/iio: Remove all strcpy() uses in favor of strscpy()
Date:   Sun,  1 Aug 2021 19:11:57 +0200
Message-Id: <20210801171157.17858-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sANA7hqjWDJu1bKLfHEzEjh3NiMEYjyWglhBJmmkMx8uX8jnK6/
 gkfz5XJMkK6TxNhKlOkSEdnAHoX/t2JSU8FQsLgVNfyzqVA4+HxtGCXwBMdCbDWSOnF6I0f
 4f1j3hRT1DbLnm42TqofQhr04QVK8KtJF+9IsyMpfMjlOsli3PXs8haw6vAMYMmBzZ2biFZ
 j9rR8bFDNWcyAZ/zpjOTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GCBi1IHlMR8=:h5g2/+mr+7iOI9tAUL3Kw9
 bIAWeRkCylDZH/miQTUhEb8m7x5cGRbQqWFV4x495wVT0AzZLHoszS4bFuBAfVUB4PwYIrm3o
 OXMsq4W/x4sopv0g0uRX4jsEmQpi7cDQ6HUsiG5jDhMuRc6uJpZXLcXuUSBX8xLUxUXQWioHK
 sSXPNu3LoHm31OBgFmywCO0QSfV/HDr0WRHkgRVS2lh/kJgJVfzw7+ZBI3Av1GsM8vTfhzGMH
 w4kHfFRVM7eFwEu8mYsJWs8lluRoTP4erhAa++i8xRyFhLMrWTC6hvrdUiVce62CGxYxa/Bro
 FBHzWXAHA3nHwix5DvNMrMaTRGAd5Ffwbsf1vBSc4hwHZvwgthWQ13/n4JFl50hbwSVz38IA6
 qKGeE2R3v6ME/N++inkp7hXVUyTZFdTG1gcWYhH/C+JgKYZiyY6PuWVpVcj5nn8otGcbJTBJI
 mzb4eOWA0oqSobFHvw6jdMdSaPig7pM9x8H0O52IbuM++9eHytXEw36AkPs+KnkR5FH4ydZp1
 Wk3WBf59JCJKCbLKkjPHUACh/xJdlc1OjUXtc9sHLzjH+DUHXe3LW4+1y8uEjhwtIMnZNDEu8
 jw7JdbXmA3SSjX5melX7SYjupxMagftDodvEi/rGgeOrSiPLXOtMPBcBPQVTzoUxtA8gLReeR
 m63kRrclC1fTojr1SgoCyECNYgQ+CDFW6uRZLwM2rQggQ2NwRdnOKEdLnUO9KdAPp65gzLMfx
 U4sAGoxz8DT1YZoZVUgy3BDcY8E8kajFSyBD9Y/WJ2NIZ5871GhmmNA9kgywlvzfeyH6hYxoj
 WRzLTiXU+NNRlRRkc9/QgYm7oDGSFXBe1t7LipKqBaRpvVxQZk1+TXPcHZ0YIUkBl2sa/5MZM
 jyGZ8xySTYFGa5ZDxAnUkNsKGEMslgOWCa3IBoLmQJ9TYqoVIGEgCBQH1EhCE/VpZ1GHuYsjM
 O9CjLhwBcM3WRIxadbjMs30SPEJC9zYvI3FWXeWu4F/I6TO7U6jCBWy0841MqkWOepATz80tG
 wN5UH2Or16fbmEORigSfFK1f4hveUsyjN1rcLnIIFLuju7V4Y7+i7+Bhn+U0ei9e+DiIxwEwt
 sMWlfZAMmi8X04lo10TOKY6966rMfkm6IvX
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
This is a task of the KSPP [1]

[1] https://github.com/KSPP/linux/issues/88

 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_magn.c
index f282e9cc34c5..3a6aa1c4bf6c 100644
=2D-- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -264,6 +264,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *=
st)
 	const char *orient;
 	char *str;
 	int i;
+	size_t n;

 	/* fill magnetometer orientation */
 	switch (st->chip_type) {
@@ -282,17 +283,18 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state=
 *st)
 		for (i =3D 0; i < 3; ++i) {
 			orient =3D st->orientation.rotation[6 + i];
 			/* use length + 2 for adding minus sign if needed */
-			str =3D devm_kzalloc(regmap_get_device(st->map),
-					   strlen(orient) + 2, GFP_KERNEL);
+			n =3D strlen(orient) + 2;
+			str =3D devm_kzalloc(regmap_get_device(st->map), n,
+					   GFP_KERNEL);
 			if (str =3D=3D NULL)
 				return -ENOMEM;
 			if (strcmp(orient, "0") =3D=3D 0) {
-				strcpy(str, orient);
+				strscpy(str, orient, n);
 			} else if (orient[0] =3D=3D '-') {
-				strcpy(str, &orient[1]);
+				strscpy(str, &orient[1], n);
 			} else {
 				str[0] =3D '-';
-				strcpy(&str[1], orient);
+				strscpy(&str[1], orient, n - 1);
 			}
 			st->magn_orient.rotation[6 + i] =3D str;
 		}
=2D-
2.25.1

