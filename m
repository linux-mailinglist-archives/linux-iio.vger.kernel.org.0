Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842C13EC17E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Aug 2021 11:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhHNJHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Aug 2021 05:07:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:34139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237272AbhHNJHW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Aug 2021 05:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628931998;
        bh=PV1/V9BM2iGGZgpghQZv6eXscCa2LJ+gGmLSlc8LOVs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=lbY/fEBlCvoICcj/qnFpTanCP1atiECki4mZtX1guWBE07c503fBvjD9nnFYZvZxp
         9s4BB/5MD74kg5NsEXseDA72WW7NSUIRZAVHK2lebEwZtLDjGQJvcyPL6LXj8lMGPR
         NMaQyh2MVW27NSRgjnxoT7dIvt9Fb/hZ0PHxWPNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MTRR0-1mgRCE2GkO-00TmQH; Sat, 14 Aug 2021 11:06:38 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Len Baker <len.baker@gmx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers/iio: Remove all strcpy() uses
Date:   Sat, 14 Aug 2021 11:06:18 +0200
Message-Id: <20210814090618.8920-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fco9R1o49YhpnMeIsBxQWc2AeBO9y3S9t08KUtxklIikjvVVTcx
 ih1JJ9IFXgMzrFT6oUVHWEPUOzeKk5erLbzGyRV7egQc8/LeW3wU0IYJ+mlc0A2ZJdqc4e5
 x7YP6PWk7W1OGZQc9ioAAVvHZODZcAvyLj7341K2qxHFNjyLjazAcrOmC9C7FWyBNGh9sB+
 +1AqkBHamEHflLf+KsfKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p89jI+Grgxw=:DaRDICzSAz95SmXD5sIkRQ
 f3k5OBUSstC6vEhVDLGiPWALv6A49PkzPbmZ7BF0Gs+EyY7RmJ2UJzwru4AqGL54ahOTSCCBR
 UEjDw08e4mzz80m32cvnvkZo6AwvuWh9zS6Bo7tq+xC0FR7jQ1h6i9pM5JsuHK/2ygXx4g017
 NDiWkSoAye1dk45PotoNlmulay4XC93/4AGLaTceARBBy4qbvGKv16YDlloNjX1mJlPD+/COI
 hZFGbtIAjg3EVbf7gus6Lc9JzCm8RiYsEyhP9dRxUd1HoKRVk8AxQAqqMcAK5RSR/p5AKEG/I
 SjSViWRI2kUfVucOgtOdFwsPtFCi+QWJqmfHoaszIu8kHlCqd2veINIKL81BX8EziHSQ5/cCB
 l8av51DyMHMSooZBLES/HB4I+L/vMZJVCynZMnisk7TQcwcJZHEaSzF3Hvjxo+l8qVlojoy2h
 AMoEgg6JSH65LnOIRSPOyaDhyDkldCfn/q3Bmv6C+b4IvWEibyDHFQMaiTwlm+1htMNfEEgAH
 ksIQdjzqUSZXneBZmVyxv4dzWpa2Zw3ZeIeAdJ1nXpR63KZILaA4alEGS1rwibEht6GN2qwHT
 /jvIvvGaX4rRnRhHVbWd3zF4mrCAt+qNv206yPFHS8Gt7mK9QTrGfg5+hAhkcbAauZ+A67sdd
 QymGRkUITbZLueiHb3ijP5tsQf43GMu17K2D3B9rKbBM4IR0Nh2sC6z2G6sFYXyeeglP/v3oa
 k8Kzbe9zGvNWuJEw/a79GHUBJKOJ7L9+wPYF7/LvUPHs8MinP5o30WbPJlSyEfNQ6fy3RLvHe
 R3gJ1s0urYeIR78G2rURYD/ckI/TyNWs+FkMBiVGzO67Wc3Bux4Q+DnHlVr/7ohFDn3uLnLmp
 uXQCzf4JD3kS8LWnLVH1Wj82s/YexwUV0r5gfCT17NbhdkJlbxbSlvHi9z//k42Uvj8sbnUi7
 Jy08uapEys9aviDRRgUKPOXLhYNRTnp0rg4zTcGUN6LCEkzES9QqEHmmXBV1vqekFIaWwrp6v
 wrxfSxa557bUUpWC11oInz+vqxrcms8KTbnR86Ma7d0ONl4f3FMK23tF8i0X86Rq4iIMkKHpy
 dnPaBYssuFfIGyQHQe/WTPwsdj6Hb12TcGVuKL+cWYfMYb4HyeM0GL1Qw==
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
Hi,

This patch doesn't change the logic. I think it is better to use the
current logic and not use always the plus and minus signs as suggested
in the previous version. I don't like the idea that 0 has sign.

Thanks,
Len

The previous versions can be found in:

v1
https://lore.kernel.org/linux-hardening/20210801171157.17858-1-len.baker@g=
mx.com/

v2
https://lore.kernel.org/linux-hardening/20210807152225.9403-1-len.baker@gm=
x.com/

Changelog v1 -> v2
- Modify the commit changelog to inform that the motivation of this
  patch is to remove the strcpy() function from the kernel entirely
  (Jonathan Cameron).

Changelog v2 -> v3
- Rewrite the code using devm_kstrdup() and devm_kasprintf() functions
  (Andy Shevchenko).
- Rebase against v5.14-rc5.

 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 32 ++++++++++++++--------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_magn.c
index f282e9cc34c5..9c359f894631 100644
=2D-- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -264,6 +264,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *=
st)
 	const char *orient;
 	char *str;
 	int i;
+	struct device *dev;

 	/* fill magnetometer orientation */
 	switch (st->chip_type) {
@@ -279,21 +280,28 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state=
 *st)
 		st->magn_orient.rotation[4] =3D st->orientation.rotation[1];
 		st->magn_orient.rotation[5] =3D st->orientation.rotation[2];
 		/* z <- -z */
+		dev =3D regmap_get_device(st->map);
 		for (i =3D 0; i < 3; ++i) {
 			orient =3D st->orientation.rotation[6 + i];
-			/* use length + 2 for adding minus sign if needed */
-			str =3D devm_kzalloc(regmap_get_device(st->map),
-					   strlen(orient) + 2, GFP_KERNEL);
-			if (str =3D=3D NULL)
+
+			/*
+			 * The value is inverted according to the following
+			 * rules:
+			 *
+			 * 1) Drop leading minus.
+			 * 2) Add leading minus.
+			 * 3) Leave 0 as is.
+			 */
+			if (orient[0] =3D=3D '-')
+				str =3D devm_kstrdup(dev, orient + 1, GFP_KERNEL);
+			else if (orient[0] !=3D '0' || orient[1] !=3D '\0')
+				str =3D devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
+			else
+				str =3D devm_kstrdup(dev, orient, GFP_KERNEL);
+
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

