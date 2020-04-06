Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC51019F7E1
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgDFOYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:24:21 -0400
Received: from mout.web.de ([212.227.17.11]:40869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgDFOYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 10:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586183046;
        bh=xSEwm/6oH2CKOeOql1gxSNnJccoSug+cKCZkiAyUuQA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aZZAYv/44JKV8rrgyWHibFZljtbHMBBbDlg1ZulIjrxZAM3Ib/rRPVTuixdQNQxlw
         h6wFQk5ickuPQpvbGLaBB+jcDzZgtbyL8tsg5IqFR1tZyAAGR3h0giHdtl6EmdO9RB
         sjF8LBJnsakMexwVbZ2NPlOLR0YQuarJdnOVgdSM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from LaptopNick.fritz.box ([79.214.93.1]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGABv-1jYswj0PO3-00F9K5; Mon, 06
 Apr 2020 16:24:06 +0200
From:   Nick Reitemeyer <nick.reitemeyer@web.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 3/3] iio: magnetometer: ak8974: add Alps hscdtd008a
Date:   Mon,  6 Apr 2020 16:13:53 +0200
Message-Id: <20200406141350.162036-3-nick.reitemeyer@web.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406141350.162036-1-nick.reitemeyer@web.de>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ySTmdEyReTIOPqgXfNwoQ0QZQ3ZLKwVg5U1BqqQmYXXa5o+9EiC
 Tyf7y1o7xVbC0dvad8FnuVjZHohcGGf1adJrXqofDIhRyirz7vq3gKnFW+790nay34bLhlb
 jgS8WyLtblTBD4+NCYhInacDUL3y3tBAShIlx+QfcikoUsyMQpfHhETEO25H0ePK7Vv320x
 ZVc9bbUzrv1p3P/27mpqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XI54rXRtWwY=:OCDbwVcIo9m0tQk1aFlhHB
 kkA78VmQGA0pQsUhwmueYM46eAdTOp+dLuBvk2JIdNkxC9bS8SBaS4/wueeDXmqKbVmljKdDH
 X+ML++i29Hptyqezmg0n+m7386f8RsOVWk+lAXPTILbjDBNTjXWwyFNvtr3Zt18hHBRTTIokZ
 b53oWVdB7/+PN28eiYMy/OoGbM3lhxaKTHmaJ8dX6X+VRf1HvNMpYKvWnAXfYLJMhINLsbQi8
 b9bPReYBrE5g1qZYXW1ExaR2iaD0cHfjcpTAY+RXB+bxOv89fmAbyA6DRy2uS7daNd7UOMBfx
 GNTqoBJMNszwEP5phwZIJXMfhAAcON7dDs0ehnKWqEPko2H4WQOO2Y+AJ2XXsz5MI5YgLLtTo
 xkJGm2ysDAVsJZY5qeSk1C79gslFteL1UbJSANMIv13WIVETwPBJr+81czhSvvf9G9tO5+azP
 MDzousv9r0KrzFiRmSKW/UzBA+Or/u0dUSZ4AXUVbNK9s6XkucBHOsOVQtXiRuX0daFyIck4g
 u3hxpw+k3GpHZrCX6QTvf7LdrhKr2Z22Z16pX2/DBFRFx+376LcamrbVZj60QkUi2eM1LBtNi
 oqKNMmRgCj9Gxg7KuspkgVXGGCUFbPQ7eYWudGjk9evUChOLH6b8OTU1B6BZCWPzFL5dcmJ+q
 K0xH5bRfL0u9/Fc3p/o+f/wq7l2PjpKR0bLK55PjvVImUhL4FffC6I7EtQXFeQq/KouVo95gh
 aukHSG4W37RRr5fnLdYK7dxppJQHldLWcv5HvGzlK8C+d8U44I0jYwW/3N4V5WHQMLlDwJftO
 7AmU9m/NRQCz/K01VrQxkbPdsqGGZCGcX5XTpo2pMWsIp3bSFj4xNtpt/Eu0Eh1vEpr02zIaA
 D44oyMWfCiI5oZOkP2sWB2V4TezLEJiCleX3WFLc1ht0HTjADoDbZ0aFfh89uU1j8/OSV1pMl
 GkGdmWhpaf/9eNAxgFrH6wsldIFumUWrH7c/tzz3baAPqKVQLlKHu+TZRe4XjoGxutit4j9AG
 e0E+2mVhGfcWKuytyQ9DNwshbpiRVHSOqlsmOt0wzgRGZQ7lygegvNXYlUHFO9NcShM8W5oeG
 GvmJMyqQNplJ389nWbBMYDCk3Wd26b1XP1E9V12wbLlDsEhq2eR4lMMa4Txsy11g7+tLr40Hi
 /ksYhfIzrLAtRt5D9qJzbkhi7j/BTpKB6uZw788BC4QRv4FGrv8ckMNBPCsRd3HlS4wjAqpQP
 cnMfdPzvJoFgUWkxQ
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The hscdtd008a is similar to the AK8974:
Only the whoami value and some registers are different.

Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
=2D--
 drivers/iio/magnetometer/ak8974.c | 38 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/=
ak8974.c
index d32996702110..ade4ed8f67d2 100644
=2D-- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -49,6 +49,7 @@
 #define AK8974_WHOAMI_VALUE_AMI306 0x46
 #define AK8974_WHOAMI_VALUE_AMI305 0x47
 #define AK8974_WHOAMI_VALUE_AK8974 0x48
+#define AK8974_WHOAMI_VALUE_HSCDTD008A 0x49

 #define AK8974_DATA_X		0x10
 #define AK8974_DATA_Y		0x12
@@ -140,6 +141,12 @@
 #define AK8974_INT_CTRL_PULSE	BIT(1) /* 0 =3D latched; 1 =3D pulse (50 us=
ec) */
 #define AK8974_INT_CTRL_RESDEF	(AK8974_INT_CTRL_XYZEN | AK8974_INT_CTRL_P=
OL)

+/* HSCDTD008A-specific control register */
+#define HSCDTD008A_CTRL4	0x1E
+#define HSCDTD008A_CTRL4_MMD	BIT(7)	/* must be set to 1 */
+#define HSCDTD008A_CTRL4_RANGE	BIT(4)	/* 0 =3D 14-bit output; 1 =3D 15-bi=
t output */
+#define HSCDTD008A_CTRL4_RESDEF	(HSCDTD008A_CTRL4_MMD | HSCDTD008A_CTRL4_=
RANGE)
+
 /* The AMI305 has elaborate FW version and serial number registers */
 #define AMI305_VER		0xE8
 #define AMI305_SN		0xEA
@@ -241,10 +248,17 @@ static int ak8974_reset(struct ak8974 *ak8974)
 	ret =3D regmap_write(ak8974->map, AK8974_CTRL3, AK8974_CTRL3_RESDEF);
 	if (ret)
 		return ret;
-	ret =3D regmap_write(ak8974->map, AK8974_INT_CTRL,
-			   AK8974_INT_CTRL_RESDEF);
-	if (ret)
-		return ret;
+	if (ak8974->variant !=3D AK8974_WHOAMI_VALUE_HSCDTD008A) {
+		ret =3D regmap_write(ak8974->map, AK8974_INT_CTRL,
+				   AK8974_INT_CTRL_RESDEF);
+		if (ret)
+			return ret;
+	} else {
+		ret =3D regmap_write(ak8974->map, HSCDTD008A_CTRL4,
+				   HSCDTD008A_CTRL4_RESDEF);
+		if (ret)
+			return ret;
+	}

 	/* After reset, power off is default state */
 	return ak8974_set_power(ak8974, AK8974_PWR_OFF);
@@ -267,6 +281,8 @@ static int ak8974_configure(struct ak8974 *ak8974)
 		if (ret)
 			return ret;
 	}
+	if (ak8974->variant =3D=3D AK8974_WHOAMI_VALUE_HSCDTD008A)
+		return 0;
 	ret =3D regmap_write(ak8974->map, AK8974_INT_CTRL, AK8974_INT_CTRL_POL);
 	if (ret)
 		return ret;
@@ -495,6 +511,10 @@ static int ak8974_detect(struct ak8974 *ak8974)
 		name =3D "ak8974";
 		dev_info(&ak8974->i2c->dev, "detected AK8974\n");
 		break;
+	case AK8974_WHOAMI_VALUE_HSCDTD008A:
+		name =3D "hscdtd008a";
+		dev_info(&ak8974->i2c->dev, "detected hscdtd008a\n");
+		break;
 	default:
 		dev_err(&ak8974->i2c->dev, "unsupported device (%02x) ",
 			whoami);
@@ -674,18 +694,18 @@ static bool ak8974_writeable_reg(struct device *dev,=
 unsigned int reg)
 	case AK8974_INT_CTRL:
 	case AK8974_INT_THRES:
 	case AK8974_INT_THRES + 1:
+		return true;
 	case AK8974_PRESET:
 	case AK8974_PRESET + 1:
-		return true;
+		return ak8974->variant !=3D AK8974_WHOAMI_VALUE_HSCDTD008A;
 	case AK8974_OFFSET_X:
 	case AK8974_OFFSET_X + 1:
 	case AK8974_OFFSET_Y:
 	case AK8974_OFFSET_Y + 1:
 	case AK8974_OFFSET_Z:
 	case AK8974_OFFSET_Z + 1:
-		if (ak8974->variant =3D=3D AK8974_WHOAMI_VALUE_AK8974)
-			return true;
-		return false;
+		return ak8974->variant =3D=3D AK8974_WHOAMI_VALUE_AK8974 ||
+		       ak8974->variant =3D=3D AK8974_WHOAMI_VALUE_HSCDTD008A;
 	case AMI305_OFFSET_X:
 	case AMI305_OFFSET_X + 1:
 	case AMI305_OFFSET_Y:
@@ -926,12 +946,14 @@ static const struct i2c_device_id ak8974_id[] =3D {
 	{"ami305", 0 },
 	{"ami306", 0 },
 	{"ak8974", 0 },
+	{"hscdtd008a", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ak8974_id);

 static const struct of_device_id ak8974_of_match[] =3D {
 	{ .compatible =3D "asahi-kasei,ak8974", },
+	{ .compatible =3D "alps,hscdtd008a", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ak8974_of_match);
=2D-
2.26.0

