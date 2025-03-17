Return-Path: <linux-iio+bounces-16979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F4A656BE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44E317DF7B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16E199E94;
	Mon, 17 Mar 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMEuwsce"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047C185B67;
	Mon, 17 Mar 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226683; cv=none; b=KsDcoJeICkca8JeSRSaoHmpex+04bHKrpD7Rb1QQJh53PisIATyVoJStJPSIJperGwg7B1eaarITrB3B7D7ZgnfCZqwgm0w51wUIoLy/+bCWpgLnTGsmTE4h9uuJq4kNGqJoUocAg2Jo/xj4EQBuwZqOiAamP+rIVxF+Ua+gFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226683; c=relaxed/simple;
	bh=xTb1olCK/EduF6OfeRS61b3xoisiCP1HRkhWhhsp3As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac3bxI+sb34DTB7Gt1hMkxsk9Skmk4nzsb1sqO0NYb9tJ/cNBPesHqa2RN7ghOwlxVqTvVN2GR7V+5zkKtGbgfss2Gh5nsXqe8GfSqyb1CsDkz0hJm4SJ/eIsgIRsjmSG+CZTfdJhIXIzUkQmso55rZrRlTNoPOjixm6xBgIWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMEuwsce; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54298ec925bso6937665e87.3;
        Mon, 17 Mar 2025 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226679; x=1742831479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zU3hKPINr7QjLa/9u8VCMKZheNEA+eJosA8qF1wcCvk=;
        b=aMEuwscekSvxHOYl3A+CmzxjpQh+oj+IBj2EmjUsXP/g4wIB9c2xrMMA2tKnNQ1l10
         FEimAuD0kGwbpAuP5+cwZxtnS1UGDRMcIr1aUmUXwP7/JIhRIA/CM8FseJnhqP7V8TJI
         pVCEK7VuOGWz2oAyjyMIpaQ7j2+sNkywf+5cH+fNxVd88JxOwTjgL+bnqWt8DutmsFv8
         X/SUDYG+SG4IJ99uD1Yfzg0Vrfk/i1IQiqwG3/Ch08ILMzk9WW9rR5KMMWIP7u35mddq
         nohERgAohsKKtAPok5SL0mQ6l6yqC3yw4P3xSBA8HtCd3bYy6TOmVuEOT0Wce9imDV8Y
         SWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226679; x=1742831479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zU3hKPINr7QjLa/9u8VCMKZheNEA+eJosA8qF1wcCvk=;
        b=aCjcuivz9ldSfyzqJdkg/uTli6LAtxr+tV+UrBhHoeTbcjcDijMAYP3+UCLAR4dL48
         yzyLxB9JHus2p7yj37JUmEBw04sJTAFODOkSs/u6NW0peqltlDCH4d369SDn3LQT8OH9
         H1ouCT2xy0cYAv2tunoLirM+uts61N8jqMnZZGryEaumyfJMEtFePkVqa5ovKgaT+zAa
         l3qAs8IL5IxDHsx91jHMKUu5xOZd7YAOoBVnB15m1MBdGFdZ/bNzksUBoOXQ7/N4Z7JJ
         dFeWJlDU2VZ3jTnHO/+rnDR2LKXol0NrR2QGLFvgzC4RNPX2bsoGPUyGtiK7jJxaDZXt
         2QRA==
X-Forwarded-Encrypted: i=1; AJvYcCWzIHEzfWSNsz9zbzOYfZelBoc61xbD45rZHUjau2XzcM7CT3iPmOjHbTLS8eWzHnliYXQaKgZujZcEH6qq@vger.kernel.org, AJvYcCXyRW4KVkAKLD0bXDqE3IxF0X/ptLvrQLAyljID0SfXdwLSLpfZHJh+T+jnDNF73RYCFT+ARYcM2Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9atvWk9ge1f1FFPes7K9wv/Bo5EvLZyRZpN+xywUDw3uHO7It
	yyxVV3Or3Y6I2y7SX8RqOrrTyoveHUsLg0UvXUMor6ndNFdMNl1Q
X-Gm-Gg: ASbGnctMq1VJCx8CyMwq40K3NhpddtTyoBp2MPdORbXt0Fk3elwEZcHDwWA1075RUBo
	8yEWIg36W/eRGG785Ks4G/nXCxHHi4P9QJ5f1aEKyoiahRX3v8gEX+2xv+XSTf70ji+8ygl7fFq
	Kp+gdXm+cBTqMRHYJ6gXbpEk7ZkhTnCw1bbefGmoUCnRaiS6Ej4fmP3zvy4iVVyxwA4AZHVOTBl
	h8faDgLCz1wKKyA6TKTeEffrK/IZ5Y1ireGKdUrACLGAFGXER9Zh2lbuR+YpC5NkRp5IIrd7O0L
	APgIgTHI3VM6IgLj+cVKjmhKqqSWw7pdvkJba2Wa7WuF3ym7eds=
X-Google-Smtp-Source: AGHT+IFO6FurpLKdrrzNJjWZBW6Q6qLTQzj/6D7yUMiIDBFfxDiNKsnCqwySTDoIxxnnxKjOsr4OWQ==
X-Received: by 2002:a05:6512:130c:b0:545:c7d:1790 with SMTP id 2adb3069b0e04-549c3900894mr6947244e87.22.1742226679087;
        Mon, 17 Mar 2025 08:51:19 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864ed4sm1385479e87.128.2025.03.17.08.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:51:18 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:51:14 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v8 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <78d33ea9a795abdb2c5a4c606d48593e827ca59e.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KMNdhR1bTFQS085O"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--KMNdhR1bTFQS085O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
help drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg"
-properties to channel identification numbers, used in the struct
iio_chan_spec. Furthermore, the helper can optionally check the found
channel IDs are smaller than given maximum. This is useful for callers
which later use the IDs for example for indexing a channel data array.

The original driver treated all found child nodes as channel nodes. The
new helper requires channel nodes to be named channel[@N]. This should
help avoid problems with devices which may contain also other but ADC
child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
string didn't reveal any in-tree .dts with channel nodes named
otherwise. Also, same grep shows all the in-tree .dts seem to have
channel IDs between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
NOTE: This change now drops a print "no channel children" which used to
be printed if no channel nodes were found. It also changes the return
value from -ENODEV to -ENOENT.

Revision history:
v7 =3D> v8:
 - drop explicit "no channels check". It is now done inside the
   devm_iio_adc_device_alloc_chaninfo_se().
v6 =3D> v7:
 - Fix function name in the commit message
v5 =3D> v6:
 - Commit message typofix
v4 =3D> v5:
 - Drop the diff-channel stuff from the commit message
v3 =3D> v4:
 - Adapt to 'drop diff-channel support' changes to ADC-helpers
 - select ADC helpers in the Kconfig
v2 =3D> v3:
 - New patch

I picked the sun20i-gpadc in this series because it has a straightforward
approach for populating the struct iio_chan_spec. Everything else except
the .channel can use 'template'-data.

This makes the sun20i-gpadc well suited to be an example user of this new
helper. I hope this patch helps to evaluate whether these helpers are worth
the hassle.

The change is compile tested only!! Testing before applying is highly
appreciated (as always!). Also, even though I tried to audit the dts
files for the reg-properties in the channel nodes, use of references
didn't make it easy. I can't guarantee I didn't miss anything.
---
 drivers/iio/adc/Kconfig            |  1 +
 drivers/iio/adc/sun20i-gpadc-iio.c | 39 +++++++++++-------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e4933de0c366..0993008a1586 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1357,6 +1357,7 @@ config SUN4I_GPADC
 config SUN20I_GPADC
 	tristate "Allwinner D1/T113s/T507/R329 and similar GPADCs driver"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	select IIO_ADC_HELPER
 	help
 	  Say yes here to build support for Allwinner (D1, T113, T507 and R329)
 	  SoCs GPADC. This ADC provides up to 16 channels.
diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gp=
adc-iio.c
index 136b8d9c294f..2428ea69d676 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -15,6 +15,7 @@
 #include <linux/property.h>
 #include <linux/reset.h>
=20
+#include <linux/iio/adc-helpers.h>
 #include <linux/iio/iio.h>
=20
 #define SUN20I_GPADC_DRIVER_NAME	"sun20i-gpadc"
@@ -149,36 +150,23 @@ static void sun20i_gpadc_reset_assert(void *data)
 	reset_control_assert(rst);
 }
=20
+static const struct iio_chan_spec sun20i_gpadc_chan_template =3D {
+	.type =3D IIO_VOLTAGE,
+	.indexed =3D 1,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+};
+
 static int sun20i_gpadc_alloc_channels(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
-	unsigned int channel;
-	int num_channels, i, ret;
+	int num_channels;
 	struct iio_chan_spec *channels;
=20
-	num_channels =3D device_get_child_node_count(dev);
-	if (num_channels =3D=3D 0)
-		return dev_err_probe(dev, -ENODEV, "no channel children\n");
-
-	channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels),
-				GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
-	i =3D 0;
-	device_for_each_child_node_scoped(dev, node) {
-		ret =3D fwnode_property_read_u32(node, "reg", &channel);
-		if (ret)
-			return dev_err_probe(dev, ret, "invalid channel number\n");
-
-		channels[i].type =3D IIO_VOLTAGE;
-		channels[i].indexed =3D 1;
-		channels[i].channel =3D channel;
-		channels[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
-		channels[i].info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE);
-
-		i++;
-	}
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(dev,
+				&sun20i_gpadc_chan_template, -1, &channels);
+	if (num_channels < 0)
+		return num_channels;
=20
 	indio_dev->channels =3D channels;
 	indio_dev->num_channels =3D num_channels;
@@ -271,3 +259,4 @@ module_platform_driver(sun20i_gpadc_driver);
 MODULE_DESCRIPTION("ADC driver for sunxi platforms");
 MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--KMNdhR1bTFQS085O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRPIACgkQeFA3/03a
ocXzMQgAk9GKibU0YJ5K0EXd9JTmbwFlG/TohUel6DTYOTzSxaUzIcMAHgIsZqbm
ETPxR/mDiYEyLKOD9O6F+Tod6Kgpdol+YKzLEzx+LZPlmvvDzOixjsUdGT+BYLvZ
pEnQiLHbcF+6SatCJ/vCEyM/dJ99ztt8hRw/m1KxpUTLuCxBGpVBT1ouq7x4vDj+
XRNKcyZj9Y3lcTFf9W8TVuRZs9kh9Eb1rURFq7bbEqCYuuvdcmL0WMS5ne9GUVxT
QbuWpDKOd4pNQD9q6HyRtFySY4a+3Vbsd3lkeGEifKw+ESZgpytny4RhxX9dllnh
LT34DSm7XQXUzPtbuDBAP0jcirqfrg==
=2vYw
-----END PGP SIGNATURE-----

--KMNdhR1bTFQS085O--

