Return-Path: <linux-iio+bounces-16768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F4A5ECB6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427881892278
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31291FC7E6;
	Thu, 13 Mar 2025 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdMBvLyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAA1FBEAF;
	Thu, 13 Mar 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850324; cv=none; b=nbokSX7ac1GtIhGvZGZLIMGEeAjnZa0Y3oQ7tV1E5S1jnbMor6GKSuuKFNNUMkFMcYPGkilsuoy9yeJyZG1VbmACvvZ/TEPAIiUGJvd2OyVD1BhWA8/qRkzT3md/4AIuqIwHh7ZwOTYcl0h8w0pQp1iSUVMOw3elmlnFEJYnyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850324; c=relaxed/simple;
	bh=i8GLas7ACi+qstK1cpvUIDSXQITDwCAsQnaja72JoNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNBMXN42lJj7bnXS1QAi91U7vPHPD2dZMKErEuopkIKuhPbgtneH+E9eMOqiPTp2E4ROj5cdQFALKLUeDa7m+6nuXwL/1m1tEhFLV/Wl4TJq5LmeFot/9JyJ9B534UN30H39oXWppVYbzx03Ir072kOZ5mp6n1N0lOubj17s50c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdMBvLyW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543d8badc30so736896e87.0;
        Thu, 13 Mar 2025 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850321; x=1742455121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNBkzdo4zeGpBZbzG1j1jFrnV6IYxaydhMaM77zT2qA=;
        b=MdMBvLyWpkOf/KtIuRLpunKDCmcED1kp1yuU2b75cT2MnlyutAmBC4U0ZQZkmG85oO
         z5c+yByBWqZZqwg119NVZ3Hs0GutwtGkzD61s2C1h+zZjShj2G4Dvsg+l+nOh4P+yEOM
         5XupYnW14PsiCNuBig2283Wh9FArj8POpd9/iiB343U8mBP40/0NPuUDU3H1y7/X9Npy
         WTubfOoiPJVSwniIUvQyab8gGWs7Cm01csrzGQKKTsC1vUUg/GkSy1y8LLYtKTk8c3Nm
         FzVKoMNhZyRddJJa1jTxkJ2XHYpYS1ijGr/5rmZfXKDEG6NUdiDytKJ1eQaSEUM1TD1a
         QSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850321; x=1742455121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNBkzdo4zeGpBZbzG1j1jFrnV6IYxaydhMaM77zT2qA=;
        b=URwu6ylkP4L8DcngmqsjYwkH3JRBokLd2Em/GPk0VZo8SStwpXFBjepOOT9kLZCIeo
         nJbPOHObxLy2tZXjPF4IfOJZeNKM1USZZ5iO7FoTlr8lV/G/cvf6v+EIEY8eq9ee0RAe
         glT854gh2GJ0RMvT3bn0z0Wo8T5vqlreTjMzk7dJPy3sfd09rwNYGmpj9m0KKPPX1B1x
         sJHXjJOlReFKpj/MNGiOm3d8hKP6h4TxpOcTGvQ8BkbJyMoWUIO7RPjICMAhLj+/mFVi
         VgBw6kygceUOr0YVQ+wafeuUzfmxbRSGce1PMJx7WNIeEyxGUKod0F6GwSla0x1V/MsH
         ScVg==
X-Forwarded-Encrypted: i=1; AJvYcCUpxwsnG3++Rzc/cQjxTkFSLd+M+iptGimOgiI3ifP0ATEWIW5OJYJkP22wFhD26ODyGvXFFOlp+ZX2EnYvh40yokU=@vger.kernel.org, AJvYcCWY+RQnHO4pA+G/ZorTG9x4ZRK0QmhhNGOifLYUglAqTi46/Cci4AKyS/2lvVu6vYjWGfsa9u/H9EGumVje@vger.kernel.org, AJvYcCXvWADbCg6A4lbU/cPOrwNJWclcGTgcxTBX1xMd9Qwb3XjDiiDdZaq+lUHd3sdAgvFtZAG2DEr8EFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AXgmDwC86OoGwWWmP8QupIG/8VbSbxzVRrRs7bSHHnEz2ggd
	948bqwS7J6Ds1gaf6jwhfFqgdjrQjZWcGLHwdeIRJSXU4JNsVl5S
X-Gm-Gg: ASbGnctwkYPPDfcRmlWNcZb3IJ+1PNmTY6vQJHQAbdLRZuFAUT8eQ8ZugYYvtCnBjey
	OQ7ssFLjh5ueNljOEoFqGjL1/7Tc9oc1HwmiyRpNtc/ykPK+RLglH6rhuo+Ktyv2q+X1YWNkz+o
	eny5Owyj/vIzqk+UTYNzitprffJTfIk0phOufX/skkcOZkWua9FJ5zkpiv31OpdozB5YDuMgOa3
	sYKovW5kjhyyF2u4FcpX966veU7KIcUfye57yzbFWPkbOAQDqLdSPM2iu9sNjw7Ovu9TXvBDw+l
	i0drvqTj9cNe7YcZLVPeSWamVIT7h1lnR8ITqdngog/4CIEtQfY=
X-Google-Smtp-Source: AGHT+IHzFdYzVh+JP80hwpzuyCS08l2evcbJwqkFmY0l240ranE0VwgaLkSjjxRuOKyajCaZDbrG1w==
X-Received: by 2002:a05:6512:3993:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-549910b791emr9723243e87.44.1741850320618;
        Thu, 13 Mar 2025 00:18:40 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9201sm115738e87.250.2025.03.13.00.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:18:38 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:18:32 +0200
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
Subject: [PATCH v7 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <613d681662ea1f44c3b5beefd0e4acc47cb2aa2a.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L56k8x8KViqQTwWr"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--L56k8x8KViqQTwWr
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
child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
string didn't reveal any in-tree .dts with channel nodes named
otherwise. Also, same grep shows all the .dts seem to have channel IDs
between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v6 =3D> v7:
 - Fix function name in the commit message
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


--L56k8x8KViqQTwWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShsgACgkQeFA3/03a
ocW1mAgAu3+aP6d0RrBjbHVEx+VS2YNPyzQ2miJIqyJH8gU7N4KezrUkelROti8V
BKX64ki+UPHEkGizpzn02afLM0Qnf6GXf/wqcAz1ix3VvndI+LBGQ7o7Zm34hfCV
RkLxIZCyJvsZp/v75QYVHs93JvZBUOUFSDP4n3aQIqP5nSQaaNRACvUKRcSQY2eA
ZxTg/cF8KdCbddpGfbHIWUh4cmnR3yZtgeHy8xocJor7o0s3GGGFqALAooxYyuVu
60DN37C3xcHQuiMm3a0pB0Mnrmrt+m7JQk9YhT/ZeyFxRHTwUzZW87PgCA/xkWFo
fCk3pQ3aXyjz5LOiL4AbCjU4GJWHDw==
=h6wE
-----END PGP SIGNATURE-----

--L56k8x8KViqQTwWr--

