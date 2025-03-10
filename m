Return-Path: <linux-iio+bounces-16668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5713DA59556
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A428B7A4AAD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C947228C9C;
	Mon, 10 Mar 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0XQh9my"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EC227E96;
	Mon, 10 Mar 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611392; cv=none; b=HZHy9N0dlPWOdc5IV3zEw4PjRM2eBBSd499uDeMPni02FqMR/pmkoZxkaEhrrsfFX5YLXVFx3LfiuFs8eqGQ7zVsIn/ulp67YAmq/DWyyWqi7IUDKO//0vHxsI3LAPw3iu9uwnDs/hIITahmC07a4YvS73UrYP8sMXQsBQgxRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611392; c=relaxed/simple;
	bh=tOL7GHXNeVRSjXZ63bdNqXRhLBN2WrCsetNGmtKgOsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKKeSQaFe1vTxYfzr03IYGcsjnuN+ZnT27S/MBR2nA/X8m/nYQsbeIfT/gY70hlT5iyA9bQna3wOe+DH8Xrjkc7owX1IuSdsboSi9aMFAgT9NfvtXcRUE2eQwRaVNa8Sg/B6mJnq0mFwLvOX6ZRU1QXiIYE+RfmwEWRpaow+xNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0XQh9my; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-549a4a4400aso1079918e87.0;
        Mon, 10 Mar 2025 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611388; x=1742216188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmS9Nh9i+BPrGyYk+ScJ6aAJuT3mUYc5BVgKtPBpA+I=;
        b=m0XQh9myYIUIzgwDdzxPFFkmn7OxpjNX0IqXKtgRMk+ZKJbdkAVgTlc3FxccMsh4VA
         LrIN6GjNuXmvfB4WOErg7BTb5KaaQ8W/WHc9nJDQAdUsk6kgw/638diUNqs3zRCr1z0n
         wrndEKvjFHG9DWFC4j5hQAuJ9ryoZyByhvjVHYkDB92QZJtUZ+n5FXaA/6OO+NsllFlY
         fFlxm9RqvwEcYCHthGS2DLiTj6vvoN8EoL4QhOOg53OQ5CjFSZdv1hW4poDEcFHNWiuW
         WIJKUXv+aNnQz4QzDMKFZ3ti9co606vkbeEAimxHSxH7KDCCZ9R3x4JHuW2VLRhbVi6/
         WbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611388; x=1742216188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmS9Nh9i+BPrGyYk+ScJ6aAJuT3mUYc5BVgKtPBpA+I=;
        b=nJ1wnF6RoIMcBJy9kbe4XiK94Bq0NWnLi6SeJtOjXNTx6AVL3b2CsppXLLIL5tAfIk
         XZNvlDAa9YFdvWZlvlkA9jLh0shfRDds0jfPT5mgy6nTbGYZoIZSfzFdGjrxya3OQv5L
         E7TnvnI75j2979aIaIZBhGAjIzAW7EkuRgRPyEvE3XOy+HS+qnoacCmHfjOa8WENvmMp
         NjVMU3YP9a8+N+mc3/n9SwYXiCEH0WqAuzFeakd6lawGFoFZCioO/BiJc/I7gcyPEIsk
         HM8sz9kksM1mktay2GYh4vvWuzpUeASHwW3rfHzJCza2tT9E16tIcMbK253pyK2WOlJ1
         DRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5CSOHzQ0c0P8iEc0i1nY7p+Evt2tmRIJtQgplm8PfyH9YG8U1I21p8iP1fzJzVJbYKd+5Dx5co6o=@vger.kernel.org, AJvYcCWk80gO/NpQzXYEf3WC1RvxSl66UmSixXZAx7gaVvuwarD3Cqenlo/tSailnE1XULFtLAEghHais3HT8m6+@vger.kernel.org, AJvYcCWoZndXV9Yt+sPFQKwVsunxMQ54T7Fo5t4oH2mCJ6J1DcDECrdUqXaZjqsDe/2SRRfs1CvUGytyQQQNvdJ6muhtyng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9NRpJa47V/yjToNRq0O5IZpx9CYvzpKu5QXc2pBubyBc6x1c
	3LhekisCZbprnJhZX15kivej+Uw6TuXEyB+qGqWRBsI2VuGHbjJD
X-Gm-Gg: ASbGncuma6ybzGnOe1NhhGgDKset22Y32PLsoAmISo2S3lGQgZZYP+fp0kJNAgTBL6C
	Kw/Hm73ogtIQOguiiTTvn0joEyL1PKu9vJbWGLLBxuuBh2/z4Q04SIop+bgV75qb19PXIAqVb3M
	HJOP/dDpb8/62GUVu4CXZ5/ONgz4TgGV37lDFWQtMzTy+lNQSDIOq4rVD9RBjVTWlYFT3Lr5Odm
	fkH1Dx5lD+Q+ycDN/g3/SdgiA2AQ7u9Yflnciy8k5DXTNMW3irN8GyV9wFnpnAQK9DSvtnAIq02
	sjPPYR1Bkt1DHl3lhqvM9ZkYIBIrc/WbgUjG8CJGFSR15iFi0ew=
X-Google-Smtp-Source: AGHT+IFJ26+dto0tWZ4vIWCYQVlcV8qYUyjYYGs2vvTGfKvhJ1aGexYXIfSXiv9FPwnXwgW67ZFJLg==
X-Received: by 2002:a05:6512:1112:b0:545:93b:30bf with SMTP id 2adb3069b0e04-54990eaaedamr3740432e87.41.1741611387853;
        Mon, 10 Mar 2025 05:56:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd456sm1433709e87.141.2025.03.10.05.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:56:26 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:56:23 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <e0b08f7cb2b564d9bc7b21f5712e69961863dcb1.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JwGmhENUYW/oDYQg"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--JwGmhENUYW/oDYQg
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
child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
string didn't reveal any in-tree .dts with channel nodes named
otherwise. Also, same grep shows all the .dts seem to have channel IDs
between 0..num of channels.

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
 - Rebased to 6.14-rc3 =3D> channel type can no longer come from the
   template.

v2 =3D> v3:
 - New patch

The change is compile tested only!! Testing before applying is highly
appreciated (as always!).
---
 drivers/iio/adc/Kconfig     |  1 +
 drivers/iio/adc/rzg2l_adc.c | 38 +++++++++++++++++--------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 37b70a65da6f..e4933de0c366 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1222,6 +1222,7 @@ config RICHTEK_RTQ6056
 config RZG2L_ADC
 	tristate "Renesas RZ/G2L ADC driver"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select IIO_ADC_HELPER
 	help
 	  Say yes here to build support for the ADC found in Renesas
 	  RZ/G2L family.
diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 883c167c0670..51c87b1bdc98 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -11,6 +11,7 @@
 #include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/iio/adc-helpers.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -324,21 +325,30 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_i=
d)
 	return IRQ_HANDLED;
 }
=20
+static const struct iio_chan_spec rzg2l_adc_chan_template =3D {
+	.indexed =3D 1,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+};
+
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct=
 rzg2l_adc *adc)
 {
 	const struct rzg2l_adc_hw_params *hw_params =3D adc->hw_params;
 	struct iio_chan_spec *chan_array;
 	struct rzg2l_adc_data *data;
-	unsigned int channel;
 	int num_channels;
-	int ret;
 	u8 i;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=20
-	num_channels =3D device_get_child_node_count(&pdev->dev);
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(&pdev->dev,
+						&rzg2l_adc_chan_template,
+						hw_params->num_channels - 1,
+						&chan_array);
+	if (num_channels < 0)
+		return num_channels;
+
 	if (!num_channels)
 		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
=20
@@ -346,26 +356,11 @@ static int rzg2l_adc_parse_properties(struct platform=
_device *pdev, struct rzg2l
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "num of channel children out of range\n");
=20
-	chan_array =3D devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
-				  GFP_KERNEL);
-	if (!chan_array)
-		return -ENOMEM;
-
-	i =3D 0;
-	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
-		ret =3D fwnode_property_read_u32(fwnode, "reg", &channel);
-		if (ret)
-			return ret;
-
-		if (channel >=3D hw_params->num_channels)
-			return -EINVAL;
+	for (i =3D 0; i < num_channels; i++) {
+		int channel =3D chan_array[i].channel;
=20
-		chan_array[i].type =3D rzg2l_adc_channels[channel].type;
-		chan_array[i].indexed =3D 1;
-		chan_array[i].channel =3D channel;
-		chan_array[i].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW);
 		chan_array[i].datasheet_name =3D rzg2l_adc_channels[channel].name;
-		i++;
+		chan_array[i].type =3D rzg2l_adc_channels[channel].type;
 	}
=20
 	data->num_channels =3D num_channels;
@@ -626,3 +621,4 @@ module_platform_driver(rzg2l_adc_driver);
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--JwGmhENUYW/oDYQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4XcACgkQeFA3/03a
ocXP/gf8CnB5D9cB7DJeFg/kg+YUTn52OWxelGV65dTT038ZNNG7+mfy5J27722w
T5KRnaOlsnVUnVEjga+Y4u/a4bXBByZKI9+EKddxlXThQqXOS7nq4RwsJUvZ5uwu
QcboFcs4EGlwiqc4VQ9xnuWNOhep0MH0YkEzeZULoWFlQygIPKieKLWs7CZdQbhY
KSzMsdG4TUMbYsdU413huGGAZrxyZ7J/nY/zzUZ8VJUm7O49BFO34QkISazkZiv3
OMqN6hZEez/EuJocQcPy2uu+dXZU9CYLaAjBAEUvLkCW2YK7txdArq3RKiJsIKYI
/+cJZ8Zq1jOpxO7Z3bKCk4cJGS4uCA==
=fZgg
-----END PGP SIGNATURE-----

--JwGmhENUYW/oDYQg--

