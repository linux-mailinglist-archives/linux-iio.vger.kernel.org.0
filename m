Return-Path: <linux-iio+bounces-13634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7209F7A88
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A639169CE7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8A223C7B;
	Thu, 19 Dec 2024 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn/F/f9r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55A22333F;
	Thu, 19 Dec 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608386; cv=none; b=Go5sruMXYG5LNOqx2AfM/z2fa6j9rFxlVIPWcyNwSn8G6789zl7T6b5PuWsQtJWqeeNGgui2TRYFG0SWtbztAFj1R3dBZE3v4ZLE3jiZZFyqgAxUk1JvW9Fw9pjXwicIqIQJUW9dE4sd1M1NeZBImlVPDALOMm7KyV2deyTn2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608386; c=relaxed/simple;
	bh=BpvVk9RBybjIhBULLPFPLQZC6xFjt/iBacQP0svRC2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz5PJi/Qnb8bkx8ylYY8FV/mtYcUWFlDaHVI/MZJth5+yehDubiyKtsNXEqNmC1sgl4OCBgrzzJHuQjC4fdOXgSs+9PXsr/V5EoPTACNcdvduhOJjwI7OrNVvJmInfP+HxWXnKmG6y5S9VhZAQnUC7iHriWcIeoXlCuOZCIu6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn/F/f9r; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3022c61557cso8695461fa.0;
        Thu, 19 Dec 2024 03:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734608382; x=1735213182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tj7M2TYQwRqRjCdjgEUfmnNBUMXGglxvGoFiGkG4aIQ=;
        b=Zn/F/f9rQKA1eVA9cBFC8oSSl0GYiSweJjkv8B+rrMfeYu5+jA5eZLOd7lfaisolAb
         httDB7N3wwerSRmVBUBMi7n8If9SOWJXZWwhI1m3JAiBDglQVw5n5V1AzDRfOgmi78fp
         JWaZue1woDCgJRMb6wWrL1+HEhtuVinkn8AQ7px4UfpDJCX0IXUJRXRIerJvAxYim1Sy
         o9bDBaRBFCtoHYNUVlAQJHCHKsp/tikDTryUQ4FU7Dhz/E8zZrjI6XNiO0l4xKpOHqIS
         p1U8DrO2c7Gdgb+yipAJ3Rcy+CXesUMUIR0mM1n3yuh4efVfmtjnfpQHWnW0vRM3K7oV
         82Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608382; x=1735213182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj7M2TYQwRqRjCdjgEUfmnNBUMXGglxvGoFiGkG4aIQ=;
        b=lzvZBs2dNGgmprnmf6wui8tTgD+rVtLC9qvhmYwY8jteab1+hPZLQpVzHT1UlrkaGV
         OGLbhzasqbt1XD0RTuqc9d9322TfaHwGIb9QPmmwSCLqumdANJO8bKm0YvcuUBXaG8Mw
         1/JDVKR2CZoDEKhB4CKUUKOJxgIJKA5A+KU7HezDUA554a7Eia8iTybFUfbn3ZiqWKoT
         rmXu44SJxVmNE8jCOq47n3OOlK92pZnNxp7iCRIgQin5gmCnERzc5ruJJsDXawX41Hsv
         equL2jVrWlsk3LE8CNIQP4IqtHRMkU9hZmkgHOxD3iRdgcEXXXS2A+4qrcLQuxsKgJy4
         nFkw==
X-Forwarded-Encrypted: i=1; AJvYcCURhfsK0lP0HSBWs7n8wDXCymoYi1k6JEAJiYu8gFH/UsPOeOOiDJAjUTvh4G50HCkeFt9DJEj9MsND@vger.kernel.org, AJvYcCV1m/CnzFy9H4AWqobTonXXkfQ/m3ESy0ys63ouS/yAgK948LyEDeqVcuIJ3Eum9b/WTJqE2d+d8xjo@vger.kernel.org, AJvYcCWSbY64iXWHMESQySMq8UOymfH4kDehkG5rSzM2SZ9R9MIAPq8AWBCfx18/ptGCwYw8YA5scxDyZtFw0HDv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gADXm1vAIlwBTIDwDU68GXesasgf64MZAopR7aXcun6bbfxq
	7oBwJeGBFIEg0bfY8Vk5xmsUiiN0p3VoJal6p+ZFdF6jDVP8tZJpxUGu5w==
X-Gm-Gg: ASbGncux9L937xA071Z+SuQIHpc7oJo2HIYDvmxsjom6QSTQtvnyLjQEZcSP7axMhzy
	94DRQNi9WJYTyiX+NWdo0pj9NNiww61IvAuqDUVAM57z2SVf9EqasZyP8RVI6NPUhCi3UDUSoDa
	vKhlvyIpBz8PMEQX/Ud/Fe2Zi3mlnOFOHG/BwQpOEqwfxDN8MED875Qf/XO6kn1x/4JeaIc7i0a
	SL9L8CIQuIVSx3cdj9DW/6ofZzIFpYxXIHCBtE2NE5B7aEJZLYf9PAXGYw=
X-Google-Smtp-Source: AGHT+IGWp8pRRpkvXuH/2iZ1kuJX/MLqsOFfNtHa9JdPgdKLsKhfJEIr/TRtQj9V/9r5kZdvU8WPBg==
X-Received: by 2002:a05:6512:1315:b0:53e:398c:bf9e with SMTP id 2adb3069b0e04-54221031307mr861021e87.55.1734608381766;
        Thu, 19 Dec 2024 03:39:41 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542238301fasm148867e87.242.2024.12.19.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:39:40 -0800 (PST)
Date: Thu, 19 Dec 2024 13:39:37 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: dac: Support ROHM BD79703 DAC
Message-ID: <bc77d7b979ca28408a216f597082fcd94ec63be7.1734608215.git.mazziesaccount@gmail.com>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8RYZPOAY7I4E1sEW"
Content-Disposition: inline
In-Reply-To: <cover.1734608215.git.mazziesaccount@gmail.com>


--8RYZPOAY7I4E1sEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79703 is a 6 channel digital to analog converter.

Based on the data-sheet examples the hardware would support setting the
DAC word without changing the actual output. The data-sheet is not too
specific on how the enabling the output of new voltage set by DAC
should be done - hence this is not implemented by the driver.

The BD79703 would also support two specific "PULL_DOWN" modes. These
aren't currently supported by the driver either.

Add a very basic support for controlling the channel outputs one-by-one.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/Kconfig        |   8 ++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/rohm-bd79703.c | 162 +++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/iio/dac/rohm-bd79703.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 4cde34e8c8e3..5690a37267d8 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -348,6 +348,14 @@ config AD8801
 	  To compile this driver as a module choose M here: the module will be ca=
lled
 	  ad8801.
=20
+config BD79703
+	tristate "ROHM Semiconductor BD79703 DAC driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for ROHM Semiconductor BD79703 Digital
+	  to Analog Converter (DAC).
+
 config CIO_DAC
 	tristate "Measurement Computing CIO-DAC IIO driver"
 	depends on X86 && (ISA_BUS || PC104)
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 414c152be779..8dd6cce81ed1 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_AD8460) +=3D ad8460.o
 obj-$(CONFIG_AD8801) +=3D ad8801.o
 obj-$(CONFIG_AD9739A) +=3D ad9739a.o
 obj-$(CONFIG_ADI_AXI_DAC) +=3D adi-axi-dac.o
+obj-$(CONFIG_BD79703) +=3D rohm-bd79703.o
 obj-$(CONFIG_CIO_DAC) +=3D cio-dac.o
 obj-$(CONFIG_DPOT_DAC) +=3D dpot-dac.o
 obj-$(CONFIG_DS4424) +=3D ds4424.o
diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
new file mode 100644
index 000000000000..a3df31d81b7c
--- /dev/null
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BD79703 ROHM Digital to Analog converter
+ *
+ * Copyright (c) 2024, ROHM Semiconductor.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+
+#define BD79703_MAX_REGISTER 0xf
+#define BD79703_DAC_BITS 8
+#define BD79703_REG_OUT_ALL GENMASK(2, 0)
+
+/*
+ * The BD79703 uses 12-bit SPI commands. First four bits (high bits) define
+ * channel(s) which are operated on, and also the mode. The mode can be to=
 set
+ * a DAC word only, or set DAC word and output. The data-sheet is not very
+ * specific on how a previously set DAC word can be 'taken in to use'. Thus
+ * this driver only uses the 'set DAC and output it' -mode.
+ *
+ * The BD79703 latches last 12-bits when the chip-select is toggled. Thus =
we
+ * can use 16-bit transfers which should be widely supported. To simplify =
this
+ * further, we treat the last 8 bits as a value, and first 8 bits as an
+ * address. This allows us to separate channels/mode by address and treat =
the
+ * 8-bit register value as DAC word. The highest 4 bits of address will be
+ * discarded when the transfer is latched.
+ */
+static const struct regmap_config bd79703_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.max_register =3D BD79703_MAX_REGISTER,
+	.cache_type =3D REGCACHE_RBTREE,
+};
+
+struct bd79703_data {
+	struct regmap *regmap;
+	int vfs;
+};
+
+static int bd79703_read_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct bd79703_data *data =3D iio_priv(idev);
+
+	if (mask !=3D IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	*val =3D data->vfs / 1000;
+	*val2 =3D BD79703_DAC_BITS;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static int bd79703_write_raw(struct iio_dev *idev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct bd79703_data *data =3D iio_priv(idev);
+
+	if (val < 0 || val >=3D 1 << BD79703_DAC_BITS)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, chan->channel + 1, val);
+};
+
+static const struct iio_info bd79703_info =3D {
+	.read_raw =3D bd79703_read_raw,
+	.write_raw =3D bd79703_write_raw,
+};
+
+#define BD79703_CHAN(_chan) {					\
+	.type =3D IIO_VOLTAGE,					\
+	.indexed =3D 1,						\
+	.output =3D 1,						\
+	.channel =3D (_chan),					\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
+	.address =3D (_chan),					\
+}
+
+static const struct iio_chan_spec bd79703_channels[] =3D {
+	BD79703_CHAN(0),
+	BD79703_CHAN(1),
+	BD79703_CHAN(2),
+	BD79703_CHAN(3),
+	BD79703_CHAN(4),
+	BD79703_CHAN(5),
+};
+
+static int bd79703_probe(struct spi_device *spi)
+{
+	struct device *dev =3D &spi->dev;
+	struct bd79703_data *data;
+	struct iio_dev *idev;
+	int ret;
+
+	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!idev)
+		return -ENOMEM;
+
+	data =3D iio_priv(idev);
+
+	data->regmap =3D devm_regmap_init_spi(spi, &bd79703_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to initialize Regmap\n");
+
+	ret =3D devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
+
+	ret =3D devm_regulator_get_enable_read_voltage(dev, "vfs");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get Vfs\n");
+
+	data->vfs =3D ret;
+	idev->channels =3D bd79703_channels;
+	idev->num_channels =3D ARRAY_SIZE(bd79703_channels);
+	idev->modes =3D INDIO_DIRECT_MODE;
+	idev->info =3D &bd79703_info;
+	idev->name =3D "bd79703";
+
+	/* Initialize all to output zero */
+	ret =3D regmap_write(data->regmap, BD79703_REG_OUT_ALL, 0);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, idev);
+}
+
+static const struct spi_device_id bd79703_id[] =3D {
+	{ "bd79703", },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, bd79703_id);
+
+static const struct of_device_id bd79703_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79703", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd79703_of_match);
+
+static struct spi_driver bd79703_driver =3D {
+	.driver =3D {
+		.name =3D "bd79703",
+		.of_match_table =3D bd79703_of_match,
+	},
+	.probe =3D bd79703_probe,
+	.id_table =3D bd79703_id,
+};
+module_spi_driver(bd79703_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("ROHM BD79703 DAC driver");
+MODULE_LICENSE("GPL");
--=20
2.47.0


--8RYZPOAY7I4E1sEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdkBfkACgkQeFA3/03a
ocUebggArgtxn69fNYeAZAjDlQFjbwKqXP4PyNyCLh3E/WvyyGP3Ez6zoUkORfkb
oUgItPzRcyCJFzp9K+GSaXqLgPRQxuDRNH9ngnJipq36lIN307B1o3sDNIbw0XwD
SPoK66uWgqbsbqleE05cHoZu0Md6m2Pr60CBNn8G+3qlaQjxfY/De+Bsi+akkQ6N
3CjslMgfSsRDDKaucpSzbUgKU84j8zG44M4Jg7WWotqGf0xrUq6BERMT7nGVOFPF
6mclr6RZNOhW+OQDf52Vt3ozSjbOO/YrFm2LY6oFrsMpHz0kgC9B1kr8PdJqPqgi
a237AYbdY7xCkWAfH1rxImKW0yoIAQ==
=U4rI
-----END PGP SIGNATURE-----

--8RYZPOAY7I4E1sEW--

