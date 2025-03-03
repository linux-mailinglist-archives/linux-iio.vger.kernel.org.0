Return-Path: <linux-iio+bounces-16263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E43A4BEAF
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A4C18864C7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEEF1FC7FF;
	Mon,  3 Mar 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne+RNNp8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB01FBEA6;
	Mon,  3 Mar 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001561; cv=none; b=AR0cw8q5g1PiBrDuX2CfkTAsnwugQ+puzbGkR+w0QfusXUrtFl2yjK6mKFPtMgN/0h2HS4MnsFzA0cQV7v+5sk/9ThJdY9rO3vHCNhfW619XJE97d6RWN26VD2xCoGx0ItBi579a3turEqsos4e28VT3Zp+jfrSMLZNs9OiI8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001561; c=relaxed/simple;
	bh=5Jo5imvp//ymQAHKsP7TsaZmdx0IGxFyllbskQnm8zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZMj+tpCVOJKZpQ1XJTNbqHRGtAZ208BzR6BxssYO2IffjVAy1+tfnMjp0HD7vVwNVtWVuTH/KGe6q8nKvnlxrKBS6tTe1rcXPolM/naL99E6nE/oJPzbgxslwFzaC3A9vlBZjmcypwQkWXtHclf31LFU9euHn5sYdBXHASoVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne+RNNp8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bae572157so15349551fa.3;
        Mon, 03 Mar 2025 03:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001557; x=1741606357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gD6SrAlWl3wCZz8bVhVbWlCcSCnWlJIW+5H7Xm1tBYc=;
        b=Ne+RNNp8xJF08BS1RlH4Q1OSU3hX5Q3OlXUZYF3UNiFbfofzGMgw3csB2n0XVJGZEr
         U1nc5lkvLg4vdzgh6umUZH3Nf/zm9G4l/B9Og4rJLkDH02H8TiTUcPoODZNO/EBbxVpI
         nSoe4UCPDG90PFuyeXRSCnyAZPVi7DYVx8FA0TFKgmGNWbFJh5ySzexdzjn8ABjk4wdz
         iyg8cUP8/KmdiuT9Q4UONW2ZIPBvJ+i0WAIq+FKZkZG/BHaf3+zoPN03gpGUyz4dY9MM
         vs1LvxxgCYjCHZjOG4uIoQaZ2N8cvvR+eTrUicWwM8IK0XVT3EtaFSIogxA3btdMR8eH
         s3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001557; x=1741606357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD6SrAlWl3wCZz8bVhVbWlCcSCnWlJIW+5H7Xm1tBYc=;
        b=gVLkzzARp2PwLhABIvwCWDaMABRef/BWe4xVAxnLIzGcBusBreG0th4iiGn26/3M+K
         clSoL8R8ewwND1Aj0b/2qWtvcLIHicgE0UVs/Xjx2d65CCV9FW80d6m7Wd+zaDRwwt3H
         DQV5pgNrKW4QOT7r7O9ijLhXXefynLcC8PpocacAQwLrmM17eZFQzt+Opjt/GztrrOYv
         XHLqY5XGDEpkKhKgxgWe4Bh6pVfUyQD40dDiAmJ9U1eRsfhnRePLxJ2K3s4BF/tC2FXQ
         R/N1uy7v/5G7LrmzQ0mZRsstMScAfw/52jvTWSh4xQdcMLDx/CTjXVJB8nhoy70OG8Jr
         SUMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSzxvnX41BilV0KQgSWTcP116TpqX9XR6jx15pjjnNPFfdXTm6AN5oKLesOVC7Uh486Pm9ODXFbI7BV7WUIhVdaPw=@vger.kernel.org, AJvYcCWd66NNQxz0+nc/G7xp/Tc3S1tHxtbEfNa1dLgNVE3uTWzw0MRb0Agpp6To3HRJccS5ZUuMfEVijnzM7Thj@vger.kernel.org, AJvYcCWxfMbMhLKWd3cASUUhxt2bVlwKPFpxlswNmzpHMz1w/L/ZzI+NXE3OkdWCb7d/Tg0bLCnvGsArSvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgxUMUow32qObZV15b2ZF5hHEhG7CxUYMUS9uLWHNupBB0/JQ
	M0kb6JIUOjL/7IeWk1VrxFcvGslGCaZjuzzv4X1DQOg5Dc0N3z9E
X-Gm-Gg: ASbGncuIqXFHc/9WEQjU214ywz+bF4dOcydTdplEFk7z9p2mueZB+oZ72N5S3vskdWR
	tA/kHio7dA6a/+yKd/yXs1pBdUp5v4eG6m6wMkF51x/kTR08E882fCoMBNJmjcDJ4sw59AEr63l
	tDjxfKJc8VNDpVRTU/mMXnenC4Bj9rpQpBDJIDewDR69XLStnuEKZkof2fnumKGhhWaCbAT8aod
	a8rj8r0gQeb3djU8GzVo9a0sMt26XZRDy7D6qJyqoWF5c+8Mms5Zf+I5bY+JIdj8ZdQQq75y9Cf
	DUhhn+N7zXqz3XKLlOLa3A1o+as8KchuFKqDh5kOb3nlOKWrWpNZmZs13jkw1AkoqTxm8lcLIuG
	vqDWUCuggprU=
X-Google-Smtp-Source: AGHT+IFn4ltod1VzU04f++mdV7LEwmx/Dhosdu103RiT+cuTpsuc+ht1g6mmZsgINc2fxQBSHduAiQ==
X-Received: by 2002:a05:651c:198a:b0:30b:a100:7cff with SMTP id 38308e7fff4ca-30ba1007d72mr38094521fa.5.1741001557124;
        Mon, 03 Mar 2025 03:32:37 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b9ba54a07sm9569871fa.52.2025.03.03.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:32:36 -0800 (PST)
Date: Mon, 3 Mar 2025 13:32:29 +0200
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
Subject: [PATCH v5 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <f8d2e21c7c4948453a42f1edcd3621d2c20871c5.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="35Ovmw/bSGGaWP2w"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>


--35Ovmw/bSGGaWP2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
drivers avoid open-coding the for_each_node -loop for getting the
channel IDs. The helper provides standard way to detect the ADC channel
nodes (by the node name), and a standard way to convert the "reg"
-propereties to channel identification numbers, used in the struct
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


--35Ovmw/bSGGaWP2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFk00ACgkQeFA3/03a
ocXuogf/VRKgP/0rrgWXAsIjfBQZMQT9EshBpQf2ccYp+GlC/QpzdnHj+pIBKZkc
RfoOZ3T8mNPvnM8X+dxMWhJ96yEXeWkMuWIvMlepjH94H2Qhte260EW422RwP4r7
LxRoKiMudKSKYDwpCUu+P5f5u0YK/oDvvxoxsDnrrgqBHky8ICtn7k4j/RqJmENW
pcG+SrQCFka7J4mlmRqZsDXpXObHsygGHUSQ04RnObcqbsoRj3t1UfvZhvGr/SOh
u7VdANuw56LMN+D9b3eg0lHdkDNDoJbqtzObw3l+hMMA5kc0AYZJap4M4NfJDT/T
1TdFzB8WNVTkceCLUkhefn6wgq2ahw==
=jjyb
-----END PGP SIGNATURE-----

--35Ovmw/bSGGaWP2w--

