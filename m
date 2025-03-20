Return-Path: <linux-iio+bounces-17142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232AA6A134
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9078189B0C5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C5213245;
	Thu, 20 Mar 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWab5+y+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856020AF69;
	Thu, 20 Mar 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458916; cv=none; b=UaVG8t9kysl6UKt0hdE5nJYYyOCaXlpVQQs6sva04gojJPEdXfMiBycX98/uQ93WdwZi3BPPV5yk80I66MqxhELthcQYCicGjT40ZF9oQacDJcwBxcYzhn1kJzSfdPNonLSugLUDdsFNzB0JI5xdVE3uURLrFwSKpJ2BY/2UohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458916; c=relaxed/simple;
	bh=mjqrYlVdSAwlOTt6uGeEK1tB3ZW41zl5T7WrSc0/Srw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcHxG+DyzIMzGdxxNnS2cHLyvGJDHpVySW+Q0KVEoJhRQwo6qBtH1B1nGeAC2fZ4zBcAzAXVp50MEVICbaL6qNcjNwLfjMOEbdB4orxHJKpnmB5tunDbpAt2cdOogRrXmv/bnu/S88R0xFObO+4fZc8z4lI9zKueaN6NMJiNYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWab5+y+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa8so5358121fa.2;
        Thu, 20 Mar 2025 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458913; x=1743063713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inP+EHbG3HFu17JrpCxUEkiI+iH0naKDQSPrV/Ou9sg=;
        b=NWab5+y+JVY2tybKuIzahQ7yVpRuLu4MvInOpPsU0LfffxJ+/MHdlY0eeaBcNr5HUf
         vpp1sEnN5yu7pCC1I+xtlQRQISSrCQbBn65pmTSjvMH5j63jTXwau6Awh8O3ZUMbWTIC
         1kOnD5XmcvF4ZY48LmNfjci1pyN2H4/EMibShV28iNTNpZw63d6Kz1C7M8lSYiWsaXTv
         zy0Sw85VQOzmPSitM2+ydMBngZPAgX37Lj0jwcilEEA3K1i1hWPQOZ6dySQKDw2399pq
         VlBuGfl/j6pkYo43/2t/blIhM/NybaKwZxGIqYwRuhH1In78xJ39IcLEVWhktSImQEzq
         OTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458913; x=1743063713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inP+EHbG3HFu17JrpCxUEkiI+iH0naKDQSPrV/Ou9sg=;
        b=OoeISqI8du5WcTOjV3ZEkTe+9jFuilRG8rBycQP/qAXpDcdSVuRCVBM6DJpgp4JDni
         KQys40kYovyxZ5tiy0E50N6KNsWWziMK/9pa9UVxf/sbkgfs9wPuI28vBTquTnL669Pc
         l/hTos76nXKOVWAzlw+V3ezfTAgATjC91Tg548vu0v6m8OSBKzCxPb9SS+sluH67YeX+
         /qYBW6d57Imwch4DyzkjhD1ST+MEYglwk4ateUpqaN0B4zm4/snFArM4ZWWjuCxvIHZx
         nlr9+QLBK1ugTYwzRUChaekaJneLBgdAuDaaN54qUIzptKMTYhne+Xjl+VcO+uG0DCzK
         q2xA==
X-Forwarded-Encrypted: i=1; AJvYcCX3PaIFgBVzcxl7RlAfb+ATBHj5umsKvKoBpA7SP8500dlfu/ODh4EW1A2i5lQKFhseJMAOb71UvtEhQ9Hc@vger.kernel.org, AJvYcCXVn6KlVXD/ae8Ynxy8Bj48DBtZ6tPxt31y50KjxMsFh2n1YV8CZz0L7XQKwun+zvRJy2oAyjj5R64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVP2mcLO/wE6seli0vivPEKBAd2nbb2IXh7/I4CKsN53iQcn9
	mA5CmfqGrosr4LreGCtvhnSOiSofXTEVTy49FbNOq38WC2l29ruy
X-Gm-Gg: ASbGncumdnL/XLdPqVZNQtb6Kfkg9zJ7g9tx8GqjD52tcBeTzyFCZ0UbqBmtPoYCrbK
	9Ly+ulFE4x71vhnRbY5PLGi6UNcHoBWk22QazsWQJKeFIp5Rpty5ILx1W9sO/GvYau1YaQb+/He
	luaq2qL5Ca+PDOatChiqbfUZFR5lR8vPpJlXwmH8Z1WrggdyS06S7/B2gcF+duG6PBDrOrdR8Oh
	8Z/RMReFhZWJEe6B/UjzVKTl2gLtOisRLI/wP51xM29bMlyamAfZ9SqSuIi3MBEH0HlmmlnaW6L
	8BdgY/yzRPicr3KZahRfg3OVop8CwEVlBgmXfRQD3J9WWJrYOZI=
X-Google-Smtp-Source: AGHT+IEhufbW2LJTHSlZk9mpioInmJst32vWXWedYxnZIFXDsg6/QWM8o+AA1E/Gzb00RvRPWNGd7g==
X-Received: by 2002:a05:651c:546:b0:30b:b9e4:13b0 with SMTP id 38308e7fff4ca-30d6a3db84emr26007541fa.12.1742458912404;
        Thu, 20 Mar 2025 01:21:52 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0fff95sm25420711fa.47.2025.03.20.01.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:21:50 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:21:45 +0200
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
Subject: [PATCH v9 5/8] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <bd0a5b7cb9b98319941ea246953866c61fba6540.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BbT3xLiwPWOuLU+N"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--BbT3xLiwPWOuLU+N
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
NOTE: This change now drops a print "no channel children" which used to
be printed if no channel nodes were found. It also changes the return
value from -ENODEV to -ENOENT.

Revision history:
v8 =3D>
 - No changes
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


--BbT3xLiwPWOuLU+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfb0BkACgkQeFA3/03a
ocVctgf/bBBEeJw/sSHAk6ry0GVLRQoRYDRuSwV02Qrw1Hkui7QSbGLhlnOGGA5X
UsbfZitGbL1x1b14QvMwl3JiYosiHCQOWSph1O19piML/pRVjy7ou98lu+O+oHbt
6Q+PWMNGhfMD15DPy10pmeO40WCnXhqHYDWCRFnav6k01//ugzG+C/Tas0kvR4JZ
5H30kUZQTpz42DXUmk9l2WpvU18Y5w7TMpD5rMy0ThY7P0mygc3ztK1R6TggKS1i
SgnZcATsrUozQlf6XwuqlYTlhmT5Ef5WmvnoMmsb6cNPzzMJSKcne59CYxt7u6op
dgldsND/s60Avrsv/hLScyxlRG/kLw==
=r70i
-----END PGP SIGNATURE-----

--BbT3xLiwPWOuLU+N--

