Return-Path: <linux-iio+bounces-16029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347A9A42B7A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEDD1892B64
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92939266183;
	Mon, 24 Feb 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwgRMwzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FE264FBA;
	Mon, 24 Feb 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422036; cv=none; b=ZDq3g2zJzavvs3SskNMTdsaNQZ7hyUyXr5mNJktAL+If4cX0tKfvlnyl3/X79Wq9Vv+48g+uqtSuB0QODfv+xJ6tob5hcJD+ksfR3H6r5mQ5xDoaV3D5WSIhEleyqsHCZj8IoXC/oHUovmSRdtGNR148GDC/e0Ns8URicM5d7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422036; c=relaxed/simple;
	bh=DNgabINj0/zQQQgszmslDd1ZCNia1KB91/1Io5eaLn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn2i/f45/s6SKBEev5kqMumxCnSn5T0nL8Vd+7xYr4z61wKHGNf1MymoLFHuO7KIduJVvqOT826TZpLBIKNbYGlacRuZ6pGNCCFwMem81+Og1MGLEZrYTz10a7g/GkH8h67w5cqAbFMsc2xJfdYmlsVYADxE76joqVkuExDUalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwgRMwzj; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5484fa1401cso566361e87.1;
        Mon, 24 Feb 2025 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422032; x=1741026832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heP8tu0ZCh/Rz+nsytMurli7kJvo4BfOkz2KYfukdDQ=;
        b=FwgRMwzjy1EpQ8sXOLa6AY4mHd3IpTyx5B7lDDfClEoTyLS48wnGm3ttoLgPkcbH03
         PUrIjIoZWsPlSboFKAoS5qtl7R/Jc4CdxTSSsqZMXY5pRI7/I8Ym54B6g9Zoc/ZmcoPR
         XOaC32nkbQtaMN3rHcWPOB9x9/HSN2lAbItmC/OWIpopC5rP2Vi+C5U5Eb98pTHNf2J1
         O+iF5GyaK1dHS7mlRHU5+sz4hrP/5qMAEpQQbaLVbcSPM3QediW3L3/N+NdEnk/3nI+1
         9oFijGi3QOS52LIz1PIRG/Bq1JeEVXdzCLancJ7mxbF4K9r+ujAKzwH2T+8Sp02/Eoff
         zaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422032; x=1741026832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heP8tu0ZCh/Rz+nsytMurli7kJvo4BfOkz2KYfukdDQ=;
        b=UU7ZYkxfjgj0zHHUcWqJt4h0CqEp+qic9nb5dKr9Lsb/A3D2pg9ISigelbNFQ7gWNz
         vOpDNdMvZj/Qj4YLpJPvS7KCOYn7J3K8CnU9FegWucmDH1XkY2oiVhvf4bkwuPALj550
         ymSGdJZbc1TmwHv/czTT/Q+AMGkGzzYpIqxqH3OaZoGV894Flzkx99IxUJj+BBJKxJ++
         DZKV1Rk68GpDTskP4qIqSREdZ1qNeqIm7+xBde39TCYyjs8twKf525k6pwdxojqEyWCA
         yQNBIKD6uHCzSjOM3SrwF3ajlc53GgOLetHnWWKlhRfuF1hFWYO3SurdLTxHSW/xXy40
         4lIw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ctX/dzHIfPn5P9oPIzLC4W7SypF7e+oUAHzZoPPPZDSgPd40AQ1rLmKDFNxiDSFhk5eH/o2z0CDLefvy+Rxx+Oo=@vger.kernel.org, AJvYcCVIP7ELy3RksMdsTJXno1ehtPUGTrxj9Wcy53d/R9vexnBxqSkTGwkBwOjNrPRlyD6AD7EbgxJ2jAHj@vger.kernel.org, AJvYcCVPi2WhMijv9xkcWSd4fkzZJ7Mz6dRdyj7yBI6XzNTv6YO4DjxShYXBYq4nCisuFIGdNOmARVzEnQ52@vger.kernel.org, AJvYcCW0hynL6adio0APsPAS7Xqe6D3+ffYbsW7uM0rPbqQNKUN7Pd64PakkMu3re0OZ4czzzutPTw7cmxCz2g==@vger.kernel.org, AJvYcCXUKBHL3i7GuKmMPAqGK/kiLpv0n/SwvsXlVKKajWlcywmBvuB1iYtJfJykyXikKW6lbxz8C0mjnIC8DMCc@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnSJAgpC/f/G9Qrtq2lGP7XAyCK2lrWQtKiP7nJ66BH1xEgdx
	VBxqef/UPRujDAS35Rzad31LhqHR0g3+b1MuZdJsmUorJBX968P/
X-Gm-Gg: ASbGncsRYxTQixg3Fzv+JbhMi7cvtES/zHSS1mSsucCOK5YAnRM60hYqMErI0y25Qzb
	ioTFosb5wrSjRYGOocgDmKuHl4z4GXguRVoPKQyU2Y5hEsiz9/F/8TI/JGF/AhOj5G3DVR9J6Jk
	DyL9op5/bKXolV0uwYLhXs0BpZc9FfshZIadEdXsCm4wNrCXCZO2HOyiV2Ig/kMUALq6ypXaees
	xwl6uQZ+XvcSPePddp4oqpR96BHzjxcBRqzko2gQDazSqxiiTj7DbAYKfyBgzoC5ZnHkSe1akmL
	9+vzvfsdj6lUaWKoMVpcTGn6Sd6XcQCg
X-Google-Smtp-Source: AGHT+IEPWpkUpgPr0eB/Achjr7Rn3Tb0Ji8xC1A5AEo/ZmVuif3jXu4CrP1IlCZOVmjDn2HsR2pkFg==
X-Received: by 2002:a05:6512:280b:b0:545:1e2d:6b8e with SMTP id 2adb3069b0e04-54838f4ee02mr4841783e87.42.1740422032277;
        Mon, 24 Feb 2025 10:33:52 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e4b08dasm3063356e87.87.2025.02.24.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:33:51 -0800 (PST)
Date: Mon, 24 Feb 2025 20:33:46 +0200
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
Subject: [PATCH v4 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <a3c579cc96b35cae04f6090d98c7672c48fa8347.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SN0UVbzzUhiLmzpo"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--SN0UVbzzUhiLmzpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg",
"diff-channels", "single-channel" and the "common-mode-channel" to
channel identification numbers used in the struct iio_chan_spec.
Furthermore, the helper checks the ID is in range of 0 ... num-channels.

The original driver treated all found child nodes as channel nodes. The
new helper requires channel nodes to be named channel[@N]. This should
help avoid problems with devices which may contain also other but ADC
child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
string didn't reveal any in-tree .dts with channel nodes named
othervice. Also, same grep shows all the in-tree .dts seem to have
channel IDs between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
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


--SN0UVbzzUhiLmzpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u4oACgkQeFA3/03a
ocWbZQf9ENM9NOauYJv2UjhpBSTG5JItz5FY4Ls+WM6co9Ueho/lhcnSyp002koJ
D9fFrMq51TfFu2ABL7fETrJ9gmYl0dOTD7C/w2ayltZKZrPiBmmjnU+hLl/0eiF0
YAZAQTPVFUdTQSHmU+GnBa/ruBAyxjl81h54lON13X9gpP+IDqAhc+1IKXTSRA+Q
DfWzAYk/qTCA/S5UWjrUZXAu6Q7cG1YfvGw0m7FjryW3GEDvJ0OF9ejaLxpstlnj
3SQc3hqfmtgaGK9WoOGVOup4R92TRVwl27rmYUt0B6xOtZ3MBawR3ivKFCxF1ZG4
u+vpEVi1loNi09TGLVyMFz/RaxOgvA==
=RyMg
-----END PGP SIGNATURE-----

--SN0UVbzzUhiLmzpo--

