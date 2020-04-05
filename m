Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BCE19EAA2
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDELIK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDELIJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:08:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD67D20672;
        Sun,  5 Apr 2020 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586084888;
        bh=wADKfMEYJB0GPYyIpzhoR48rj//i0JjVYuLqICKFraE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ULUtOSx8/9c1LHRZ0Thh7IV9l1HesVaYgQ6Taxhf/ujzRP1I25ov73MSA2eVokCEa
         6mXExk8LiFly0actvyG7aleikDpdu4wfKYdUPJKItp2DJl3dwirTfFxA6ryNtEMcom
         KdmorvMJ0z639ZiJif1c4NngG6MWszm+6Ljt/1MI=
Date:   Sun, 5 Apr 2020 12:08:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Leslie =?UTF-8?B?SHNpYQ==?=(=?UTF-8?B?5aSP6YKm6YCyX1BlZ2F0cm9u?=)" 
        <Leslie_Hsia@pegatroncorp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hermes =?UTF-8?B?SHNpZWg=?=(=?UTF-8?B?6Kyd5pe75YqtX1BlZ2F0cm9u?=)" 
        <Hermes_Hsieh@pegatroncorp.com>,
        "jesse.sung@canonical.com" <jesse.sung@canonical.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Message-ID: <20200405120803.7ca63241@archlinux>
In-Reply-To: <754706C925201D4896E92CCAD6B38E4401F0F61013@PTW-EX-37.PEGA.CORP.PEGATRON>
References: <754706C925201D4896E92CCAD6B38E4401F0F61013@PTW-EX-37.PEGA.CORP.PEGATRON>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 06:49:12 +0000
Leslie Hsia(=E5=A4=8F=E9=82=A6=E9=80=B2_Pegatron) <Leslie_Hsia@pegatroncorp=
.com> wrote:

>   *   Author: Leslie Hsia
>   *   Amplifier driver for TAS5805M, initial the amplifier and set the so=
und's parameter.
>   *   Signed-off-by: Leslie Hsia <Leslie_Hsia@pegatroncorp.com<mailto:Les=
lie_Hsia@pegatroncorp.com>>

Hi. Please read the SubmittingPatches.rst file for how to submit a diver.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

I've pasted the patch below though to allow some quick initial comments.

One high level comment to start off.  This is very much an audio focused am=
plifier.
I wouldn't normally expect to see a driver for such a device in IIO.  Why h=
ere
rather than somewhere in the audio subsystems?

sound/soc/codecs/
already has a large number of similar looking amplifiers.

The amplifiers in IIO tend to be general purpose (and normally extremely hi=
gh
frequency supporting) amplifiers. Cc'd Mark Brown as one of the ASOC mainta=
iners
who can probably give you a clear answer to if this belongs in ASOC.

Anyhow, some general comments inline.

Thanks

Jonathan

>=20
>       -------------------------------------------------------------------=
------------------------------
>=20
>   *   This is a new driver for TAS5805M, please help me to Cc to the rela=
ted people. Thanks.
>=20
>=20
>=20
> This e-mail and its attachment may contain information that is confidenti=
al or privileged, and are solely for the use of the individual to whom this=
 e-mail is addressed. If you are not the intended recipient or have receive=
d it accidentally, please immediately notify the sender by reply e-mail and=
 destroy all copies of this email and its attachment. Please be advised tha=
t any unauthorized use, disclosure, distribution or copying of this email o=
r its attachment is strictly prohibited.
>=20
> =E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=
=E4=BB=B6=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E6=A9=9F=E5=AF=86=E6=88=96=E4=
=BE=9D=E6=B3=95=E5=8F=97=E7=89=B9=E6=AE=8A=E7=AE=A1=E5=88=B6=E4=B9=8B=E8=B3=
=87=E8=A8=8A=EF=BC=8C=E5=83=85=E4=BE=9B=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=
=E4=BB=B6=E4=B9=8B=E5=8F=97=E6=96=87=E8=80=85=E4=BD=BF=E7=94=A8=E3=80=82=E5=
=8F=B0=E7=AB=AF=E5=A6=82=E9=9D=9E=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=
=B6=E4=B9=8B=E5=8F=97=E6=96=87=E8=80=85=E6=88=96=E8=AA=A4=E6=94=B6=E6=9C=AC=
=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=EF=BC=8C=E8=AB=8B=E7=AB=8B=E5=8D=B3=E5=
=9B=9E=E8=A6=86=E9=83=B5=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=AF=84=E4=BB=B6=E4=BA=
=BA=EF=BC=8C=E4=B8=A6=E9=8A=B7=E6=AF=80=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=
=E4=BB=B6=E4=B9=8B=E6=89=80=E6=9C=89=E8=A4=87=E6=9C=AC=E5=8F=8A=E9=99=84=E4=
=BB=B6=E3=80=82=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=B6=93=E6=8E=88=E6=AC=8A=E8=80=
=8C=E4=BD=BF=E7=94=A8=E3=80=81=E6=8F=AD=E9=9C=B2=E3=80=81=E6=95=A3=E4=BD=88=
=E6=88=96=E8=A4=87=E8=A3=BD=E6=9C=AC=E9=9B=BB=E5=AD=90=E9=83=B5=E4=BB=B6=E6=
=88=96=E5=85=B6=E9=99=84=E4=BB=B6=E4=B9=8B=E8=A1=8C=E7=82=BA=EF=BC=8C=E7=9A=
=86=E5=9A=B4=E6=A0=BC=E7=A6=81=E6=AD=A2 =E3=80=82
>=20

diff -uprN -X linux-4.15-vanilla/Documentation/dontdiff linux-4.15-vanilla/=
drivers/iio/amplifiers/tas5805m.c linux-4.15/drivers/iio/amplifiers/tas5805=
m.c
--- linux-4.15-vanilla/drivers/iio/amplifiers/tas5805m.c	1970-01-01 08:00:0=
0.000000000 +0800
+++ linux-4.15/drivers/iio/amplifiers/tas5805m.c	2020-03-13 13:58:36.201225=
000 +0800
@@ -0,0 +1,151 @@

Use an SPDX license identifier and then don't put the license
boilerplate in each file.

+/*
+ * Driver for the TAS5805M Audio Amplifier (I2C part only)
+ *
+ * Author: Leslie Hsia <Leslie_Hsia@pegatroncorp.com>
+ * Author: Andy Liu <andy-liu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+=20
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include "tas5805m.h"
+
+struct tas5805m_priv {
+	struct regmap *regmap;
+	struct mutex lock;
+};
+
+const struct regmap_config tas5805m_regmap =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+static const struct reg_sequence tas5805m_init_dsp[] =3D {
+	{ 0x03, 0x00 },
+	{ 0x03, 0x02 },
+	{ 0x33, 0x00 },
+	{ 0x4c, 0x3d }, // set volume to -6.5dB

These magic numbers should ideally be replaced with defines that
decode the fields and identify the register names setc.

+	{ 0x03, 0x03 },
+};
+
+static int tas5805m_set_device_state(struct tas5805m_priv *tas5805m, int s=
tate)
+{
+	int ret =3D 0;
+
+	ret =3D regmap_write(tas5805m->regmap, 0x00, 0x00);
+	if (ret !=3D 0)

if (ret)

+		return ret;
+
+	ret =3D regmap_write(tas5805m->regmap, 0x7F, 0x00);
+	if (ret !=3D 0)
+		return ret;
+
+	ret =3D regmap_update_bits(tas5805m->regmap, TAS5805M_REG_DEV_CTL2,
+				 TAS5805M_DEV_STAT_CTL_MSK, state);
+	if (ret !=3D 0)
+		return ret;
+
+	return ret;

return regmap_update_bits...

+}
+
+static int tas5805m_probe(struct device *dev, struct regmap *regmap)
+{

Superficially it seems like there is little benefit in separating this
from the i2c_probe below - I would just have it inline.

+	struct tas5805m_priv *tas5805m;
+	int ret;
+
+	tas5805m =3D devm_kzalloc(dev, sizeof(struct tas5805m_priv), GFP_KERNEL);

sizeof(*tas5805m)

+	if (!tas5805m)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, tas5805m);

Not used.

+	tas5805m->regmap =3D regmap;
+   =20
+	mutex_init(&tas5805m->lock);
+
+	ret =3D regmap_register_patch(regmap, tas5805m_init_dsp, ARRAY_SIZE(tas58=
05m_init_dsp));
+	if (ret !=3D 0) {

if (ret)


+		dev_err(dev, "Failed to initialize TAS5805M: %d\n",ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tas5805m_i2c_probe(struct i2c_client *i2c, const struct i2c_dev=
ice_id *id)
+{=09

Use probe_new as you aren't using the i2c_device_id anyway

+	struct regmap *regmap;
+	struct regmap_config config =3D tas5805m_regmap;
+
+	regmap =3D devm_regmap_init_i2c(i2c, &config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return tas5805m_probe(&i2c->dev, regmap);
+}
+
+static int tas5805m_i2c_remove(struct i2c_client *i2c)
+{=09
+	return 0;
+}
+
+#ifdef CONFIG_OF

No need for this protection and it will probably result in build errors
if you build with device tree support.

+static const struct of_device_id tas5805m_of_match[] =3D {
+	{=20
+		.compatible =3D "ti,TAS5805M",=20
+		.data =3D TAS5805M_AMP_DEV_NAME,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tas5805m_of_match);
+#else
+#define tas5805m_of_match NULL
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tas5805m_acpi_match[] =3D {
+	{"TXNM5805", TAS5805M},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, tas5805m_acpi_match);
+#else
+#define st_accel_acpi_match NULL
+#endif
+
+static const struct i2c_device_id tas5805m_i2c_id[] =3D {
+	{ TAS5805M_AMP_DEV_NAME, TAS5805M },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, tas5805m_i2c_id);
+
+static struct i2c_driver tas5805m_i2c_driver =3D {
+	.driver	=3D {
+		.name =3D TAS5805M_DRV_NAME,
+		.of_match_table =3D tas5805m_of_match,
+		.acpi_match_table =3D ACPI_PTR(tas5805m_acpi_match),
+	},
+	.probe =3D tas5805m_i2c_probe,
+	.remove =3D tas5805m_i2c_remove,
+	.id_table =3D tas5805m_i2c_id,
+};
+
+module_i2c_driver(tas5805m_i2c_driver);
+
+MODULE_AUTHOR("Leslie Hsia <Leslie_Hsia@pegatroncorp.com>");
+MODULE_AUTHOR("Andy Liu <andy-liu@ti.com>");
+MODULE_DESCRIPTION("TAS5805M Audio Amplifier I2C Driver");
+MODULE_LICENSE("GPL v2");
diff -uprN -X linux-4.15-vanilla/Documentation/dontdiff linux-4.15-vanilla/=
drivers/iio/amplifiers/tas5805m.h linux-4.15/drivers/iio/amplifiers/tas5805=
m.h
--- linux-4.15-vanilla/drivers/iio/amplifiers/tas5805m.h	1970-01-01 08:00:0=
0.000000000 +0800
+++ linux-4.15/drivers/iio/amplifiers/tas5805m.h	2020-03-13 14:00:11.350955=
000 +0800
@@ -0,0 +1,15 @@
+#include <linux/types.h>
+enum ti_ampfilier_type {
+	TAS5805M,
+};
+
+#define TAS5805M_DRV_NAME    "TAS5805M"
+
+#define TAS5805M_REG_DEV_CTL2		0x03
+#define TAS5805M_DEV_STAT_CTL_MSK	(BIT(1) | BIT(0))
+#define TAS5805M_DEV_STAT_DSLEEP 	0x00
+#define TAS5805M_DEV_STAT_SLEEP 	0x01
+#define TAS5805M_DEV_STAT_HIZ	 	0x02
+#define TAS5805M_DEV_STAT_PLAY		0x03
+#define TAS5805M_AMP_DEV_NAME		"TAS5805M"
+
