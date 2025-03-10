Return-Path: <linux-iio+bounces-16669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9AA59559
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426A816DE72
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484A227E96;
	Mon, 10 Mar 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBnvm7xN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53E2288FE;
	Mon, 10 Mar 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611404; cv=none; b=pij2OOBrY19lkkP3HJvMUqjD3gafTNKFD2sTdBYQOXoF32TrdSXHWC+Bxnug0OfK8GXNTvOrZPoGGAx4VMpqU5TqX+TvjexiVMOVjw+cmgtlT61p/rmzdrRzEmn64EyeC2dk/TQsnxL8hoYgGgU3r1AHzhkQBPhPCdScpKIMTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611404; c=relaxed/simple;
	bh=9XEoIzTALm7hh7yrSVv2U09laC08ux9o8z1W2L0FrfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEQ0gyClo4ZQPN1AOgc/ALV1qgtaqeICFthdp0vUw0CQD9dZwexmWQ3AFWRz8vZw6dsXGe23eQNt5y4BAr55WrTBC4DaC2uBZd37Cn3KyuQg629qVhKX6aVNkgS5bsnBqVyTM0jwu/Ufh42b2dQckMOPpzciZD/dBJQT0HESGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBnvm7xN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so4451188e87.2;
        Mon, 10 Mar 2025 05:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611401; x=1742216201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcfEYtrJz5zWQt9AvTA5zPr+o4Ysr+2unMZ2MALKhvA=;
        b=lBnvm7xNQVfqckMS86XHfG/b57rc+H8exkYLuBHo8qo5Y7NW8mV0kub/v+Gfvb8TmT
         4Vm1XFV0NM0O0VAImyf8BPhtJa2Id5QAzxLsG21Af9/CZHtJC/MsE/5OfMziIjprs+cL
         ClozdyBXS/dA/G932CBCq7T1ZptQOQF3HyFtqW4FAPhkcsM+Z2wugwJ4FiwEklajQdOl
         JsIYqAzwFKcguX0t0bf1BblcxGhHsdt4Idp9Xj35MPB9JCHcj+MBRpRyecMjh3MGF/dg
         prMIIaRIf4Z2a8iCh+OQ6FLTzeu9E2eV5Gqt2xmy6zcxWtTFKOAV8zF/PEwZJZVU/tff
         IATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611401; x=1742216201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcfEYtrJz5zWQt9AvTA5zPr+o4Ysr+2unMZ2MALKhvA=;
        b=Vz8LVFeMJx4QpruQMhiv2YwVYQVi0OGKdcWx5kP9higkoJ0EiPBCygQ+v7rZCuc8uL
         U1B6jHKswblRAmHgTCLqy49VFMF8T1B7IlVVZq2pUiqsLUf+XVDuJUABUP9ISv8BQjJp
         0NzNB/jJNSO53Xf1XDsO3+UNu2SPp9vcev9vmYReLAbnn8QPmv/ioWVn1jkhw8Wy2Pht
         eqFr98kPsWeGO4w/9Y91Pgt8WUKkLWez3mQoXMB+GrdGqDnBqH2AIAiehbHy/1+UhgY1
         58Iultg7+D6ZZsd0EidqGNd0POqn/0sOfSvFmNrBVWIgKf07rFudLplow32m24sEaFTL
         vzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrq3o2u/0mtEVdB+D3aXX73QFSW8N8MLHtIMhwBiU6BgNwJAXRnw8i9EIECho9hHhQYpahOsgjJCzX1Oi/@vger.kernel.org, AJvYcCVzmz77hid/BXs0Au1FMZ7Eqxutb92lJ5gL/xG+Z8V4bN4VW2iLlq3TP1VbyW9RoWlH5RQ2X8Z13fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPK9ez4uL2Mjp9QDzoDgalkFBv1dUNLfuRkr3ihnKY/uECzxw
	Q5L08E8FXvQGMdv08EqYFCGAw9R7j0B9lODaZn8ejzpuhnTiJrZk
X-Gm-Gg: ASbGncv0IwyFxFr7mdh0J4ArD+WZD935Gwpg24viGyeE5dkkYvT2IC+cwvjzh16PVTu
	11nuyBvskNp0HIamjXA/TkZlwLDiWLrMvNhcwOH2eKpBxMfs+clkfA9/VdgBi0vY0x9C2ukbXpr
	qn+E0MDt1g1CndkY+2zwc0wPjndzQA1rsgFy3eIN+fWS8+AO3Kvgm9lizdNTmZZdTyZnZDoduBp
	ptTtMujPqNpSUaU+LxKMrAKhyYkNj9teBf7NrPp+7qC1FQNa00j1122FPQAkLx8JHtjRcdZ6PDk
	rJDTAs15CxrVO0tpgamOrhf/h0S3C8yx4j5dQ/L6bnCJe00Yhv0=
X-Google-Smtp-Source: AGHT+IFRmSf5GiiM8bfzTIfNKKyhDwDuNOYO808weMLsGD1nweR4GVyow1Hcgy16MeoRt06G5yQKvA==
X-Received: by 2002:a05:6512:3993:b0:549:792a:a382 with SMTP id 2adb3069b0e04-549910b59bdmr4168207e87.32.1741611400636;
        Mon, 10 Mar 2025 05:56:40 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58e22sm1449802e87.86.2025.03.10.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:56:39 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:56:35 +0200
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
Subject: [PATCH v6 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <06e8f4f84731df9fc5d6f324e74fbd1bf83a81d5.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JowyB6chBVFkTBVR"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--JowyB6chBVFkTBVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
drivers avoid open-coding the for_each_node -loop for getting the
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
Revision history:
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
 drivers/iio/adc/sun20i-gpadc-iio.c | 38 ++++++++++++------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

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
index 136b8d9c294f..bf1db2a3de9b 100644
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
@@ -149,37 +150,27 @@ static void sun20i_gpadc_reset_assert(void *data)
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
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(dev,
+				&sun20i_gpadc_chan_template, -1, &channels);
+	if (num_channels < 0)
+		return num_channels;
+
 	if (num_channels =3D=3D 0)
 		return dev_err_probe(dev, -ENODEV, "no channel children\n");
=20
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
-
 	indio_dev->channels =3D channels;
 	indio_dev->num_channels =3D num_channels;
=20
@@ -271,3 +262,4 @@ module_platform_driver(sun20i_gpadc_driver);
 MODULE_DESCRIPTION("ADC driver for sunxi platforms");
 MODULE_AUTHOR("Maksim Kiselev <bigunclemax@gmail.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--JowyB6chBVFkTBVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4YMACgkQeFA3/03a
ocXu2Af/T06ImH4ZvUrc2LEWGPWz5jQ32YPvoizwaT8sxZSy0oMBQhUDltshWQbl
CoMzoDJ/zWVNxpzjAU+SrP2mOtUdPlLzUCGLSqryEKoj3eNXHBfBGDdhHXOKl65p
mYldt4ydWOcrGDUUypWWG3QLyCDj6w0D6vtMbNzvW+Ue0cUk0+QxZT8iDMRFEAi5
+sJQp7TNbaTGFd0kjvr0o/FV5PPjW8kRWaG9cZJ8f09xgjMAdGIgcLfogw+RrTme
vv1G1ighu6XHhJDdpHJ/OufusDu46tWJBa4HwCXc7osBfXiGuvAW0YjrZiOOg5Bs
b/8opt91KLvW/AZ7SvVmj4p+2A8aug==
=oACh
-----END PGP SIGNATURE-----

--JowyB6chBVFkTBVR--

