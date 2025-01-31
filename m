Return-Path: <linux-iio+bounces-14750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E71FA23E77
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0831611FA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E421CAA96;
	Fri, 31 Jan 2025 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARyFZPhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DD1C8FB5;
	Fri, 31 Jan 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330643; cv=none; b=QEePsZI+HbbftHMAxM0Ihr0szDVZpW1xe9jJQ/e/bk4EKfJW1qFfjZ8cS+/r/XzU+6lEhIHzxmSeIiT63GUURtTo2fo4q84mDD7uAvmpX5rUSpyowYYnYBo7mjgzglbDQBpjqd7B4m73HCa3mDSVGBlCibyAqZY8rVVOmpNXT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330643; c=relaxed/simple;
	bh=LbHCUrEdhbojNKZ/RR5Lpsxq1m/GASPMuuAZHnVP2S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SumXtjS+ASSHVsnxlJeftYWqj2lSIv+PBTibGf5FeqZ8frNKKsGUQQxA/a3NE8/lNaavPiPZed4pVu3yr7glwXpe0bS4+TQFVYNxxbPRXmwHzQAupBoTp6S5EumxCmScET0DePMbM5c7igjsv3916H2izbWhIXSJitsD1ot9TMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARyFZPhu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so18269571fa.2;
        Fri, 31 Jan 2025 05:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330640; x=1738935440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+5jra0SH2uQt8IrloFdsrAify0lpNpYCVPtA+7/PaI=;
        b=ARyFZPhuCpRceLALYxF2gLT9JrxlFiLDPvUyWfwf2RC3GeSFHb81f8y3okuV0T1DSw
         c8Uz9YvG0X3nE0uJ+0MOoDGHWX0SJXQPaFSFlHmIfIHe3oOAfaF/jh+WXYpQDQvZURiD
         DBPv63z6UNkboyDvDI/es/7v6PmwfVZI61bd1WJnjMNSH2wHU1dYkViBc5/clIbX7i60
         eIADBBLKUc+sKsI40d8cXvzTJCixBYmDwy8DuJ/yMvNYGmcIRnTdjhhV/rk4g3WK7JBU
         rNMYbt65wTlxdQPlcBaOcqbUKBcRdn8mTEzdL27/oNyaJgaF1VylF3GW3puhL4xw7BaY
         eh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330640; x=1738935440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+5jra0SH2uQt8IrloFdsrAify0lpNpYCVPtA+7/PaI=;
        b=KTXMSfIGasmkoJCHMfZ2BSc04zwaQYwcJfTjFRFYs9s59b17AW+DZ59CyfJxY4S0b8
         PWXxexKI8qPVmGiokOFyhT1IawSM9lZ8ZZo8CmgLhG7iZPMGe4tbktPTbqgw3n+P6wHi
         Q00R8usogp6HjU9Nek/OB8vi+2Bv2zcTTIpr8nIsvTdkb/ENjHncD6GiSCt4hh8wvYTH
         eaI7+nFuSCao/ohb0VyptWcvAB6MpLo8pg9cEUa2CR/+Aigm6z2pOmj23Wscc7PFmPoO
         xLdzkqw7XXpxVB0OpENa98UwMsk211+HnMJTUv+lO9uhWO+waS38Bq4+XymeE72vZLKl
         qf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCURoVXz8nkuFSch4TShRcI9D6RgYzGVVITyoH20Yu0mUfBMDKbVCcaNbAajkk8mcqLWXSBYDKT/abRf@vger.kernel.org, AJvYcCW86T9jU0xnOM2iC1iitSq3QR0I6OM77psNhYHpzpcl/xwkMOFSL/5Vaf4csaYS/X7VMa3Nz4yC5Zyprw==@vger.kernel.org, AJvYcCW9G/QrgxPSsEiWiqB0z53lIO8JxZ+y0Ybb3NsSgSRPUO6I0tyB5urSq3LHV1IKsS+rRRwYjha9Eh1Re5Km@vger.kernel.org, AJvYcCXAKyge0CmgaoRM+ksJ+xDmSw9+pUB/aysJy4V5xZ/rwcWNsq5ADTARBUHHU7tXLCzCcIFoJatf1rSt@vger.kernel.org
X-Gm-Message-State: AOJu0YzxirKi5hl+1D/u2d9GxcW8CxWxrnBZS8OA1c5uCa2XvFavxDhR
	8An0RVSjbYbN+WIQssBz1ptvuULImdWoY7DRUFTD7NJSYgBLhIV0
X-Gm-Gg: ASbGncv/RVx6BDIytv/u76TIGX3qb7JYo5zA+8hutqu84ZvYYlCe1EstlsFqeaTno07
	34u3ig2zZEPhtP4gHmRuxvhGrnQ149bm7Xhyyv3jpIjxk0TjBscsN9HRS2YY+Hl5tWoc/gMf2Jx
	x1PFGFTRowSyHCHcm35OyFTPHRG6+gnIVSlfbU+c5g+gjS4Eg17HGaafYXzHXW9nLLCIpQ1FSF3
	EVjyMyuJDIvxUxccyxSiYM7YaxkRt+RqAxZOSBMj6knsnUQ7fGxM4rewWJcfZuC5Jvur6cYbjgI
	rZLHBs/iMGT/wqPbtJREgpPaYx83dLtgkYB4KjItDzAxBG0=
X-Google-Smtp-Source: AGHT+IEZVmENbSjG/r2sUas2lBFwtK4YregPz+jUi4RWXqrXWLW1kIijOfmxTUWeA+ggD/8MDycmAA==
X-Received: by 2002:a2e:bd16:0:b0:302:40ec:a1bc with SMTP id 38308e7fff4ca-307968e10ffmr37536271fa.30.1738330639355;
        Fri, 31 Jan 2025 05:37:19 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3069d54sm5496371fa.1.2025.01.31.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:37:17 -0800 (PST)
Date: Fri, 31 Jan 2025 15:37:06 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 2/5] mfd: Add ROHM BD79124 ADC/GPO
Message-ID: <cc30cf6859b5e5a7320282709f428cd42717ac6b.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZCYcIh57x3OhomXz"
Content-Disposition: inline
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>


--ZCYcIh57x3OhomXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add core driver for the ROHM BD79124 ADC / GPO.

The core driver launches the sub-drivers for the pinmux/GPO and for the
IIO ADC. It also provides the regmap, and forwards the IRQ resource to
the ADC.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/Kconfig              |  12 +++
 drivers/mfd/Makefile             |   1 +
 drivers/mfd/rohm-bd79124.c       | 165 +++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-bd79124.h |  32 ++++++
 4 files changed, 210 insertions(+)
 create mode 100644 drivers/mfd/rohm-bd79124.c
 create mode 100644 include/linux/mfd/rohm-bd79124.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..f024256fb180 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2113,6 +2113,18 @@ config MFD_ROHM_BD71828
 	  also a single-cell linear charger, a Coulomb counter, a real-time
 	  clock (RTC), GPIOs and a 32.768 kHz clock gate.
=20
+config MFD_ROHM_BD79124
+	tristate "Rohm BD79124 core driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the ROHM BD79124 ADC core. The
+	  ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
+	  also an automatic measurement mode, with an alarm interrupt for
+	  out-of-window measurements. The window is configurable for each
+	  channel. The ADC inputs can optionally be used as general purpose
+	  outputs.
+
 config MFD_ROHM_BD957XMUF
 	tristate "ROHM BD9576MUF and BD9573MUF Power Management ICs"
 	depends on I2C=3Dy
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e057d6d6faef..c7d64e933a7d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -270,6 +270,7 @@ obj-$(CONFIG_MFD_SC27XX_PMIC)	+=3D sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+=3D rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD71828)	+=3D rohm-bd71828.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+=3D rohm-bd718x7.o
+obj-$(CONFIG_MFD_ROHM_BD79124)	+=3D rohm-bd79124.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+=3D rohm-bd9576.o
 obj-$(CONFIG_MFD_ROHM_BD96801)	+=3D rohm-bd96801.o
 obj-$(CONFIG_MFD_STMFX) 	+=3D stmfx.o
diff --git a/drivers/mfd/rohm-bd79124.c b/drivers/mfd/rohm-bd79124.c
new file mode 100644
index 000000000000..c35ab0e03b0b
--- /dev/null
+++ b/drivers/mfd/rohm-bd79124.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (C) 2025 ROHM Semiconductors
+//
+// ROHM BD79124 ADC / GPO driver
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/mfd/core.h>
+#include <linux/mfd/rohm-bd79124.h>
+
+static struct resource adc_alert;
+
+enum {
+	CELL_PINMUX,
+	CELL_ADC,
+};
+
+static struct mfd_cell bd79124_cells[] =3D {
+	[CELL_PINMUX]	=3D { .name =3D "bd79124-pinmux", },
+	[CELL_ADC]	=3D { .name =3D "bd79124-adc", },
+};
+
+/* Read-only regs */
+static const struct regmap_range bd79124_ro_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_EVENT_FLAG,
+		.range_max =3D BD79124_REG_EVENT_FLAG,
+	}, {
+		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
+		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
+	},
+};
+
+static const struct regmap_access_table bd79124_ro_regs =3D {
+	.no_ranges	=3D &bd79124_ro_ranges[0],
+	.n_no_ranges	=3D ARRAY_SIZE(bd79124_ro_ranges),
+};
+
+static const struct regmap_range bd79124_volatile_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
+		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG,
+		.range_max =3D BD79124_REG_EVENT_FLAG,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
+		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
+		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
+	}, {
+		.range_min =3D BD79124_REG_SYSTEM_STATUS,
+		.range_max =3D BD79124_REG_SYSTEM_STATUS,
+	},
+};
+
+static const struct regmap_access_table bd79124_volatile_regs =3D {
+	.yes_ranges	=3D &bd79124_volatile_ranges[0],
+	.n_yes_ranges	=3D ARRAY_SIZE(bd79124_volatile_ranges),
+};
+
+static const struct regmap_range bd79124_precious_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
+		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
+		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
+	},
+};
+
+static const struct regmap_access_table bd79124_precious_regs =3D {
+	.yes_ranges	=3D &bd79124_precious_ranges[0],
+	.n_yes_ranges	=3D ARRAY_SIZE(bd79124_precious_ranges),
+};
+
+static const struct regmap_config bd79124_regmap =3D {
+	.reg_bits		=3D 16,
+	.val_bits		=3D 8,
+	.read_flag_mask		=3D BD79124_I2C_MULTI_READ,
+	.write_flag_mask	=3D BD79124_I2C_MULTI_WRITE,
+	.max_register		=3D BD79124_REG_MAX,
+	.cache_type		=3D REGCACHE_MAPLE,
+	.volatile_table		=3D &bd79124_volatile_regs,
+	.wr_table		=3D &bd79124_ro_regs,
+	.precious_table		=3D &bd79124_precious_regs,
+};
+
+static int bd79124_probe(struct i2c_client *i2c)
+{
+	int ret;
+	struct regmap *map;
+	struct device *dev =3D &i2c->dev;
+	int *adc_vref;
+
+	adc_vref =3D devm_kzalloc(dev, sizeof(*adc_vref), GFP_KERNEL);
+	if (!adc_vref)
+		return -ENOMEM;
+
+	/*
+	 * Better to enable regulators here so we don't need to worry about the
+	 * order of sub-device instantiation. We also need to deliver the
+	 * reference voltage value to the ADC driver. This is done via
+	 * the MFD driver's drvdata.
+	 */
+	*adc_vref =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (*adc_vref < 0)
+		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
+
+	dev_set_drvdata(dev, adc_vref);
+
+	ret =3D devm_regulator_get_enable(dev, "iovdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
+
+	map =3D devm_regmap_init_i2c(i2c, &bd79124_regmap);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Failed to initialize Regmap\n");
+
+	if (i2c->irq) {
+		adc_alert =3D DEFINE_RES_IRQ_NAMED(i2c->irq, "thresh-alert");
+		bd79124_cells[CELL_ADC].resources =3D &adc_alert;
+		bd79124_cells[CELL_ADC].num_resources =3D 1;
+	}
+
+	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, bd79124_cells,
+				   ARRAY_SIZE(bd79124_cells), NULL, 0, NULL);
+	if (ret)
+		dev_err_probe(dev, ret, "Failed to create subdevices\n");
+
+	return ret;
+}
+
+static const struct of_device_id bd79124_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79124" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd79124_of_match);
+
+static const struct i2c_device_id bd79124_id[] =3D {
+	{ "bd79124", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bd79124_id);
+
+static struct i2c_driver bd79124_driver =3D {
+	.driver =3D {
+		.name =3D "bd79124",
+		.of_match_table =3D bd79124_of_match,
+	},
+	.probe =3D bd79124_probe,
+	.id_table =3D bd79124_id,
+};
+module_i2c_driver(bd79124_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Core Driver for ROHM BD79124");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/rohm-bd79124.h b/include/linux/mfd/rohm-bd79=
124.h
new file mode 100644
index 000000000000..505faeb6f135
--- /dev/null
+++ b/include/linux/mfd/rohm-bd79124.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2021 ROHM Semiconductors.
+ *
+ * Author: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+ */
+
+#ifndef _MFD_BD79124_H
+#define _MFD_BD79124_H
+
+#define BD79124_I2C_MULTI_READ		0x30
+#define BD79124_I2C_MULTI_WRITE		0x28
+#define BD79124_REG_MAX			0xaf
+
+#define BD79124_REG_SYSTEM_STATUS	0x0
+#define BD79124_REG_GEN_CFG		0x01
+#define BD79124_REG_OPMODE_CFG		0x04
+#define BD79124_REG_PINCFG		0x05
+#define BD79124_REG_GPO_VAL		0x06
+#define BD79124_REG_SEQUENCE_CFG	0x10
+#define BD79124_REG_MANUAL_CHANNELS	0x11
+#define BD79124_REG_AUTO_CHANNELS	0x12
+#define BD79124_REG_ALERT_CH_SEL	0x14
+#define BD79124_REG_EVENT_FLAG		0x18
+#define BD79124_REG_EVENT_FLAG_HI	0x1a
+#define BD79124_REG_EVENT_FLAG_LO	0x1c
+#define BD79124_REG_HYSTERESIS_CH0	0x20
+#define BD79124_REG_EVENTCOUNT_CH0	0x22
+#define BD79124_REG_RECENT_CH0_LSB	0xa0
+#define BD79124_REG_RECENT_CH7_MSB	0xaf
+
+#endif
--=20
2.48.1


--ZCYcIh57x3OhomXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0gIACgkQeFA3/03a
ocUY2QgAkM6qEm1sViic5TZYHjrGfuLkUZKJ0lcOE+YmLtGAfmoRj4M6Rpw+T6Lm
PVqHq/tso/L9b4Ew58Cu5NiIyVhIp/CIeALxQMLyym8GS1mt7YBrPHFLHwsy/F5B
dL+KIzE07hmM7bS/14X8BYPjFps0CK8xFDDaokxB8QlWQo3ixHbg5HsO7pey9qKK
RHzkhTD6uMNJxDkYrBM1y1Dbbe6jzWa/DI8FIP+f0DY5y6BMrQB+CWllm7Ht7iVG
P2J7HMA2fR1r2sO8um93Dr4bCE6OI9XCrsa+GGQfrAx5O48KZcBcd/p9GJbHrA8O
MYrZSC3qkQPqOZCAFTmQaxTT6+prEw==
=4avQ
-----END PGP SIGNATURE-----

--ZCYcIh57x3OhomXz--

