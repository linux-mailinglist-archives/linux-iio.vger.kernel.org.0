Return-Path: <linux-iio+bounces-16031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA1AA42B89
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B14188B2F2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00FA266583;
	Mon, 24 Feb 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfhfRoEX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6582661B6;
	Mon, 24 Feb 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422066; cv=none; b=qDbqHgmOuvxHZXFYtb5AyEXse8N9cQ+cjCOYf+FLSn5aJN/FFN4VdtuTUZEoldRTnq98ROL4eoItKTZ6JsF/yyOXP+R2Me6LUGokFOzQI/BiKUu7prH95mqwpDx/k+PSeBFkRv649j+Ejv9p729B/H5uo857PNjQVEE+RZghOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422066; c=relaxed/simple;
	bh=ptpLCzQ6BNa0qLiSCk4X/p1uRBpcdAzC37NT2TsZkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpAEdADsj6yVhZ3/Mw8Kc7I8DXnseyAbTH/ge3c0w9T/fYcu8Vh0YoxsD9q6FrJAfaXrA2s0AZzz/NG1Z35wXBvDqw0Qi0SV7p48ohrEFl2rgcjFBSVQI5+nLz6VkQxNfkn9I2e9JzbM4Guw36ABxk9yErWoD79K9RWpds9kOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfhfRoEX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso54511471fa.1;
        Mon, 24 Feb 2025 10:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422062; x=1741026862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGcm2bkFDPXzL23Cd0xQolPfqoEIsDRM3DUNg3w1Cy8=;
        b=FfhfRoEX9FiTMUtcNBXqFhAi6S1yLqp8i9Xswxpnv3hQRHnLSZax8SuRfHAH+7F+Yw
         HBq+NxzvGT1/lwSxN0bSqPlIPZsHK2mBXj7D7A6I8M4ngyrDWUbRqtGJEwEu/9ZscsvN
         CzHBEv/ynnYGHiKgcUGSzQCcIPW+hUumZZLFfZrLd3Luj0V9GxCBoY2p8HMwh5bwslZ2
         XtwZ50jQXcK+VQNfTgztsJ4MuZpVovzYNjc/UWD5hzX9gunus5q7apAtlnFxMmfraHMH
         oUJHrdDMi2mwZHt9HbRezToYQ+6vzCE44EnhGW6OfIW9Z19ViHQyWsbQQ3Zjho1vozLs
         U0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422062; x=1741026862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGcm2bkFDPXzL23Cd0xQolPfqoEIsDRM3DUNg3w1Cy8=;
        b=PqA24OKH+E7a6R2wAwLwWa4mMS9lFlletXf3a3ud+CnKq2Jm0VCdO++lYZVWQbNbHy
         RAGPErFm1IceSQZ0Lo1Rr3V8gqfwIMvV++AKU3VOwYWS9/bRHktgLPlTAe0nuN1DLbTG
         bnyZ4y5IaE4bzBo49xsIUb864NndYtW8ebD33deL18EL3CjVrUsCm9VSaL9jN8ctL53S
         NlWMl1EfEXwTO/wf5icOwlrmxhK1yf0PvL1GcR3QP37p5Lt9ihUcMke5Lg0XoOtTp4f9
         o6a+wEdG45m/1J7q/22L004m+BdBPYWgdoE1bM4Rg9zO4h36efpwXD8mGeiZrypmdajy
         f3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9WgPdKl9iCnpOYPGLz5gihl6nM6zZfqdOAQmqN8OMo8gEt6oH8mqDOsZMXDOU4OqbJCRIK8Vt2gUF@vger.kernel.org, AJvYcCUqjnQez6ts1ms4SNzyUdlGDlQgy/aMSks1aI7oi9ZfCvVJcaEFaL8J9tajhh1W7gVXEI+8Zq62Lx1FaNMoTE/VlT8=@vger.kernel.org, AJvYcCVUNFD7Mm7z9PAIFcBtKQW7UeqhrbiV7zI77vvt9KFlqoYwxmVsukgmjScYmOOrG2mPBQ71iNtqJAjlMA==@vger.kernel.org, AJvYcCVk7LhdTe92whCLLKWJaMlOO053HyTZzJ401qJH5V9H1L0kniF0/Rq+Pn5LLfsit/G7EX89eeWlXTYK@vger.kernel.org, AJvYcCVlLWYGL4Co9RQHHX3wgTR70OAN1VV+Q+xHkfAALL1BZ2B9V7gl+gPqzfGBrMGnWdjUCObjqEUPlaQcG8+D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JEfSBW3lFgyuTGNUz7dkDFEAIwGCKYjVVpSCJ/ncDyYhRrKu
	hTqYVQFWd5xCeN5L0VIFscJSULLYzuqDFUGb3K4qSopvO0dnEJSi
X-Gm-Gg: ASbGnctDLgu1JPUsWmPTWGJg399RXggceKM+Wtlt8kjHAzNMEbZX1dwIdDIy2JfYhCm
	+x3VSK3NQDUIvJEEZFBJrtxcbmyKtXaKNQwCHY6CzhFOq7htrEYOCIlQ2cCiPSiqJsofb3xE2yS
	aZywtXTICf43gI9GYjWMeuzoXueW9q3u78pSnVDpUV6USbgCm4lh7BA/MgvFLTVsiRfffxZ/UhS
	KmY0pgJ/SwUKTv9hkF+8zbGkx3kc/siYuQD927JeXmPoD6rui7rA73BqdiKbG4tuPyUx6k34/wo
	J0XjR4K9MOSIi5HZGXFLVTlNiDBatKvd
X-Google-Smtp-Source: AGHT+IFEpds9WAAPmdXGIB+EMRIMZX8JJNMGJEFMaa6SvRSCJp+geS/XDIi8N88vVzGAieZpjJvTTw==
X-Received: by 2002:a2e:8017:0:b0:300:4107:6294 with SMTP id 38308e7fff4ca-30a5b216a46mr47097571fa.35.1740422062295;
        Mon, 24 Feb 2025 10:34:22 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0a4fsm58811fa.2.2025.02.24.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:34:20 -0800 (PST)
Date: Mon, 24 Feb 2025 20:34:16 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v4 07/10] iio: adc: ti-ads7924: Respect device tree config
Message-ID: <20dd0e4ea72fe39b90b611f9c08dbd4bc1d5217f.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IkbFafee0o6MuMJf"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--IkbFafee0o6MuMJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ti-ads7924 driver ignores the device-tree ADC channel specification
and always exposes all 4 channels to users whether they are present in
the device-tree or not. Additionally, the "reg" values in the channel
nodes are ignored, although an error is printed if they are out of range.

Register only the channels described in the device-tree, and use the reg
property as a channel ID.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v3 =3D> v4:
 - Adapt to 'drop diff-channel support' changes to ADC-helpers
 - select ADC helpers in the Kconfig
v2 =3D> v3: New patch

Please note that this is potentially breaking existing users if they
have wrong values in the device-tree. I believe the device-tree should
ideally be respected, and if it says device X has only one channel, then
we should believe it and not register 4. Well, we don't live in the
ideal world, so even though I believe this is TheRightThingToDo - it may
cause havoc because correct device-tree has not been required from the
day 1. So, please review and test and apply at your own risk :)

As a side note, this might warrant a fixes tag but the adc-helper -stuff
is hardly worth to be backported... (And I've already exceeded my time
budget with this series - hence I'll leave crafting backportable fix to
TI people ;) )

This has only been compile tested! All testing is highly appreciated.
---
 drivers/iio/adc/Kconfig      |  1 +
 drivers/iio/adc/ti-ads7924.c | 78 ++++++++++++++++--------------------
 2 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0993008a1586..d16082ac2e1f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1476,6 +1476,7 @@ config TI_ADS7924
 	tristate "Texas Instruments ADS7924 ADC"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_ADC_HELPER
 	help
 	  If you say yes here you get support for Texas Instruments ADS7924
 	  4 channels, 12-bit I2C ADC chip.
diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
index b1f745f75dbe..e3ac170c73f4 100644
--- a/drivers/iio/adc/ti-ads7924.c
+++ b/drivers/iio/adc/ti-ads7924.c
@@ -22,6 +22,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
=20
+#include <linux/iio/adc-helpers.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
=20
@@ -119,15 +120,12 @@
 #define ADS7924_TOTAL_CONVTIME_US (ADS7924_PWRUPTIME_US + ADS7924_ACQTIME_=
US + \
 				   ADS7924_CONVTIME_US)
=20
-#define ADS7924_V_CHAN(_chan, _addr) {				\
-	.type =3D IIO_VOLTAGE,					\
-	.indexed =3D 1,						\
-	.channel =3D _chan,					\
-	.address =3D _addr,					\
-	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), 		\
-	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
-	.datasheet_name =3D "AIN"#_chan,				\
-}
+static const struct iio_chan_spec ads7924_chan_template =3D {
+	.type =3D IIO_VOLTAGE,
+	.indexed =3D 1,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+};
=20
 struct ads7924_data {
 	struct device *dev;
@@ -182,13 +180,6 @@ static const struct regmap_config ads7924_regmap_confi=
g =3D {
 	.writeable_reg =3D ads7924_is_writeable_reg,
 };
=20
-static const struct iio_chan_spec ads7924_channels[] =3D {
-	ADS7924_V_CHAN(0, ADS7924_DATA0_U_REG),
-	ADS7924_V_CHAN(1, ADS7924_DATA1_U_REG),
-	ADS7924_V_CHAN(2, ADS7924_DATA2_U_REG),
-	ADS7924_V_CHAN(3, ADS7924_DATA3_U_REG),
-};
-
 static int ads7924_get_adc_result(struct ads7924_data *data,
 				  struct iio_chan_spec const *chan, int *val)
 {
@@ -251,32 +242,35 @@ static const struct iio_info ads7924_info =3D {
 	.read_raw =3D ads7924_read_raw,
 };
=20
-static int ads7924_get_channels_config(struct device *dev)
+static int ads7924_get_channels_config(struct iio_dev *indio_dev,
+				       struct device *dev)
 {
-	struct fwnode_handle *node;
-	int num_channels =3D 0;
+	struct iio_chan_spec *chan_array;
+	int num_channels =3D 0, i;
+	static const char * const datasheet_names[] =3D {
+		"AIN0", "AIN1", "AIN2", "AIN3"
+	};
=20
-	device_for_each_child_node(dev, node) {
-		u32 pval;
-		unsigned int channel;
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(dev,
+						&ads7924_chan_template,
+						ARRAY_SIZE(datasheet_names) - 1,
+						&chan_array);
=20
-		if (fwnode_property_read_u32(node, "reg", &pval)) {
-			dev_err(dev, "invalid reg on %pfw\n", node);
-			continue;
-		}
+	if (num_channels < 0)
+		return num_channels;
=20
-		channel =3D pval;
-		if (channel >=3D ADS7924_CHANNELS) {
-			dev_err(dev, "invalid channel index %d on %pfw\n",
-				channel, node);
-			continue;
-		}
+	if (!num_channels)
+		return -EINVAL;
=20
-		num_channels++;
+	for (i =3D 0; i < num_channels; i++) {
+		int ch_id =3D chan_array[i].channel;
+
+		chan_array[i].address =3D ADS7924_DATA0_U_REG + ch_id;
+		chan_array[i].datasheet_name =3D datasheet_names[ch_id];
 	}
=20
-	if (!num_channels)
-		return -EINVAL;
+	indio_dev->channels =3D chan_array;
+	indio_dev->num_channels =3D num_channels;
=20
 	return 0;
 }
@@ -370,18 +364,15 @@ static int ads7924_probe(struct i2c_client *client)
=20
 	mutex_init(&data->lock);
=20
-	indio_dev->name =3D "ads7924";
-	indio_dev->modes =3D INDIO_DIRECT_MODE;
-
-	indio_dev->channels =3D ads7924_channels;
-	indio_dev->num_channels =3D ARRAY_SIZE(ads7924_channels);
-	indio_dev->info =3D &ads7924_info;
-
-	ret =3D ads7924_get_channels_config(dev);
+	ret =3D ads7924_get_channels_config(indio_dev, dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
 				     "failed to get channels configuration\n");
=20
+	indio_dev->name =3D "ads7924";
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &ads7924_info;
+
 	data->regmap =3D devm_regmap_init_i2c(client, &ads7924_regmap_config);
 	if (IS_ERR(data->regmap))
 		return dev_err_probe(dev, PTR_ERR(data->regmap),
@@ -469,3 +460,4 @@ module_i2c_driver(ads7924_driver);
 MODULE_AUTHOR("Hugo Villeneuve <hvilleneuve@dimonoff.com>");
 MODULE_DESCRIPTION("Texas Instruments ADS7924 ADC I2C driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--IkbFafee0o6MuMJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u6gACgkQeFA3/03a
ocUe1wf+MJKOql30Dh2UEfmAD+modSznTYRRI0q8qUSlSJUWjF3sOGOhT3n5uB08
68lAVMOvkhelWF/nvHuLJQLbpNATe3sVzQZ53X5Ont2jrgPBg4monQOxnqlIy1OD
siu4L1/uobQ4pFHHd1Sb+uQHg9RoSf0u7G/LeAxUK1qQOnyrJ8B4QDS9IbcsJbos
WKrdaBEUXUp8vb7RykmVe43qUiyUEdGKUZczoyAqG3+QD2hkJ73U+yF4QerQE4+M
LGfFIFlaf5U3RWJga1or1/1FDytmwQCyNZyDl4hVTjis+s46inK1tsH/zwpVueNn
nqoScEr26AP8Y01PhKWQ/zP5cIc7kQ==
=WNVg
-----END PGP SIGNATURE-----

--IkbFafee0o6MuMJf--

