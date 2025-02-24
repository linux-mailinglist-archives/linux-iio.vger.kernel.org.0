Return-Path: <linux-iio+bounces-16028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7E0A42B6E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2655F172896
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F8265CC9;
	Mon, 24 Feb 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBBiVp17"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21D262D38;
	Mon, 24 Feb 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422021; cv=none; b=aOCIYQc6JZ15syddRvHu/KOUV28N+8ZW7qBPqUIgyXixi5efJUaQtGXV8Kfm7iprrETCfmjwqRU75yPl4L3CiwRsxuJhwVxABbCkBhfiULPCjg2V8BphJZIO/bwYJ7uDg+1vlm6cmoYZSiwPHWPnQYeQUpHpFUylpUGoU/iH+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422021; c=relaxed/simple;
	bh=jQuaC/58RFsv33FJ4d9fVw7g0PRVpSEVzZh6MU7O4kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KONFLhSFWPZh+7eGoTBjpwTzklud5v3lAuQ+Q9ZOtPqFxFaBbFdLGk2FYbRMfkNEzSfsmsQKe1/6N4XbsxxlzTWHbyWejoWMRwnGs8H1o4zAh1TaUOT6EXyD92lv2ZESLTmdPDoy1+IF0JfjbnendYBj+djxkJRJDOlaVT9vR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBBiVp17; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5462a2b9dedso5671445e87.1;
        Mon, 24 Feb 2025 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422017; x=1741026817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbgG/npWw2NepzS3A/ksrl5rJ4Tlhh8QEzNC+teb494=;
        b=EBBiVp17JMK7CCQmQQgnZBdwSW4OS5mji/uMeEwS2VWSvCyGaO9iE+y+Ve7FfS2Oje
         tC0ScPXshO3soJMblMJag0SZR5a+xHBThxSqoMnAaXUvvVSjvvPvJpg2vGd9SUzBpul8
         UBFOIRCpUZFeDd702IGbfBIwiHn2Ux38LpN106FUteBTzdcFsdjudmnP78tGvAI2Sjil
         6wZOgG5xYEQM1LsE+xaF1DvvoNSMncb2MzgLCaqSFVnehpm73AfnNNO/ONxH6XNajEAX
         bb3MTNfVEls43Djh4xqK4gRS+3IIjlDoQw/cLJR1MUtvPeSvNy6gqkjTUagfTxO4AQx4
         vZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422017; x=1741026817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbgG/npWw2NepzS3A/ksrl5rJ4Tlhh8QEzNC+teb494=;
        b=kP0B66gvdrHUT/cXZ5Sr2rdhhqPTN29fDtyGAKKeuGKikRANgFY5XL6GWU5BVRKIsp
         0ucLx1mfPZlbbynNPH15orbxyXiKVOhqCRVE6cFxBYzZ1yhlfeW6IbTc1/2vIyJFgCBK
         1Pvr2lzmLtpma4G4BueLZN45+0Am6MGAGOnvnODguohJzKeQoK5iBKW+mO0lBL0MBUgw
         Hckml1gIPKLoADvHkSadTRs2IaYmdKlWXdpnh5g7cu2EihUwX0PtoVhBpHnkmLJZluU6
         0q/TqNzDeeQ0MlBXCyyiUPj91DfBBkaObYiHICaJYPtlhNEdrHRa9+cfGrcctqoHKEey
         KAxg==
X-Forwarded-Encrypted: i=1; AJvYcCU1/Zd6VQsiU2mfKtTZZnDktDNPnPcGbV+S9OtRjx2bWotWNlHOZmX2Xp6+fTWfJKLumob7da1+EK+O@vger.kernel.org, AJvYcCVLJ+AWtH7CU2LOQu4BqnGQ5tj25iADsl2e+WZkUMpALqhdRBggt0+GztfqZHAWSxg2+AazCUAkDIkJYA==@vger.kernel.org, AJvYcCVcMQOyR09yHYcvUIn1a3MsILHbdhXM1NO0dprTiKcTinwHNZsBSTBt4jKB4EXvkhsT3AGq04P84814ju0Hccv4Aw4=@vger.kernel.org, AJvYcCVt4Re5nG2ZI4llxM6TeVwOY0CfxAESWqWckfCJjLVr6s4e/7SAucZ+Vtde0IUJ68Kf/D31i4QRjcAlU6/J@vger.kernel.org, AJvYcCWWJbAneD7wkNFTVV/f7P3E4pkg8vCpvEvE1kopgoiD6IuWsBUM0XVk8X0A2y9ZFGCZk+NwvE7CAZ09@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/t8h7pPgndbw4qw7nIa6QOn6sHw7MoQd8eGlGCpUvcdnSUJJe
	XvRAJ8x5xo41AYM6RoOxctoxGyvCiqBkkSxyXCFPLi5NK8JfWtIbC5JU2Q==
X-Gm-Gg: ASbGncsqoj3vmW2/q14+IJ8uF/qi2XfpUpwmtOvU9zdtePPppJrkAxmvTsrXoYc7WOM
	uHAxTcX9owXxbKoUSQDahTJxPhZtYx1OKwUjoe7ptPYZReL++ebHix8SBgb/AkB/lul1mbNYN9d
	AluZr7LzCAuG+MFeZp3CHwrEOa6Rt1niA/VVRAsxmTriiu5IMCYotknB/6RLD9Mwk4EBchS2rkD
	sXCxuiPQlnWAaHYFdN7BtA+IQ8Oom8HBG+3GXEs3UFhWK6uYW9Nn/uY3+3Mwv/vmT5gGPS4Ujus
	z7v6VpyACkqZqlaqeymGVjY3CLE5M0M8
X-Google-Smtp-Source: AGHT+IGBSL1yjpp7J6W1giQ4I2dWNpu3PXBwrEQmef+HokD2Y0Oka/qGiW3kVLsJKEKXgtjM51bkUg==
X-Received: by 2002:a05:6512:4013:b0:53e:239b:6097 with SMTP id 2adb3069b0e04-548392717f4mr5798488e87.50.1740422017026;
        Mon, 24 Feb 2025 10:33:37 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54850e58973sm11520e87.23.2025.02.24.10.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:33:34 -0800 (PST)
Date: Mon, 24 Feb 2025 20:33:29 +0200
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
Subject: [PATCH v4 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <5658fbdd886cc7ada278a42c63a140bc14d1277d.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mtOolVTi1ZqGpvqI"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--mtOolVTi1ZqGpvqI
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
child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
string didn't reveal any in-tree .dts with channel nodes named
othervice. Also, same grep shows all the .dts seem to have channel IDs
between 0..num of channels.

Use the new helper.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v3 =3D> v4:
 - Adapt to 'drop diff-channel support' changes to ADC-helpers
 - select ADC helpers in the Kconfig
 - Rebased to 6.14-rc3 =3D> channel type can no longer come from the
   template.

v2 =3D> v3:
 - New patch

I picked the rzg2l_adc in this series because it has a straightforward
approach for populating the struct iio_chan_spec. Only other member
in the stuct besides the .channel, which can't use a 'template' -data,
is the .datasheet_name. This makes the rzg2l_adc well suited for example
user of this new helper. I hope this patch helps to evaluate whether these
helpers are worth the hassle.

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


--mtOolVTi1ZqGpvqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u3kACgkQeFA3/03a
ocWBYAf/brWd7/SyZ84Uz2yw5H7dpkgJJ+92jtAc/7YINSXooW/ZlWxIWkRc5/wl
NWJyaGDZO9innoXJSHn73DWXGKJOPJ/QUeLqjW86wN+DyDJdz1cOI24Y5GpOOq3B
dzzsKxxwfVuI1Enl4cKBkWR63OjFMdjk7OF/wex50TQuC964i/hkTQYyeB4+XCpB
3JddSObvtByksJW26s7jnv9bvsC8XhnSz37Vw2P5etG0umGjPp2FHqREvq2Ou/YZ
3RBzlihjDWPLO5cDVa6pKAFATd5sufaJl8W0t8I8IFm8Nc4mn3h+uYqUJGGZ33i5
dXuQHwUK+I8QBlWSHvaz8wnI18JegA==
=WOuY
-----END PGP SIGNATURE-----

--mtOolVTi1ZqGpvqI--

