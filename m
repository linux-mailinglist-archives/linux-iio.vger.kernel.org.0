Return-Path: <linux-iio+bounces-17220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDBA6D4C0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A17167464
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E22505DA;
	Mon, 24 Mar 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+s4+qMh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400B282F0;
	Mon, 24 Mar 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800406; cv=none; b=pPeZuAAd5jMyvW7vHJ1t0iB/+CiNeTC5UV4u9yQeruJt98qPUdk8HTe6WBzx7sNwvvNWwpezL6Hu6vZHJrLXLUOwPdopSqjVf9N1DfUT0W8ttl0OnUvVxujaohuJPTCLgECnIan6y8IITMce6zo27DTocNScow3VdwcbusZfgp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800406; c=relaxed/simple;
	bh=69jZkXZ68qT8OF04E/eXa3qlCemMeikttohLyW2VZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoWJJ40k2ornZocWm6a985uMl2cD1UJ7YfjdnliXiJjg5koJikiFwxcR1VYvYzMaZpsQzv+lmWAJ1wG/VgFa+QVV+wBQMF9jzDyK2Ugtf/FXzg+DnbTCoBjv2ChyceTlJI9YQc/pMuZzowAVJQt+dV+6+Sau7F/0/uLvma4kRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+s4+qMh; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfed67e08so45272761fa.2;
        Mon, 24 Mar 2025 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800402; x=1743405202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xgDjO2hAXj0Gho2LDAx5GiyXu0xY3ddzTlGNMRW/qg=;
        b=c+s4+qMhigwdWkgxaPHqTTPhAq6wlWBJzM6rpfnrS4KqAitHDPCAshhL4U9QNxSWDU
         VmPzukuSiq/cYKLAyJP6TH3dHQ2/x9/VlXpO1o02QV4Y9A7os2V2FH3mPPIt+5/xww6N
         u0SY78u9p3Zzsz7VPP63tvUYo5jjXbjKpSGK3bUp5ou+Qj/vcbu4qEGexdiTzjZ8bEuG
         OxgwfY04CTHgw+A5cDhc/UPAKdCYbZ9HxhK/uniRENgWNu17JZEE+ASO1zE6JeQCjfiK
         MeNANH/4iaV7diD7QbEh+BxSEvqCH4pyP1k9mCKLGQ04ga1bh4EnsxZvuC1SZ0ZxhQlO
         j/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800402; x=1743405202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xgDjO2hAXj0Gho2LDAx5GiyXu0xY3ddzTlGNMRW/qg=;
        b=K091fzGmQVmvnr/uWhmnHS3S9UFhqFSiQ3ogxcNw1J7vwMz2fMCxUcVSFI9YvwDqgA
         3djRklC4ajDlSeyrRsfuaGNYcnT3sMJv/hAOFAix6xieya9SEcA8woyaRtAl2BYgJnZE
         ttJQuyplfk2dPXp9bsgDZp+EsJCULaz6hK3Z9cDyD5q4Mv3eLFJz1FRCMwvJjQMaa1U/
         zocd4W9YpzxHN0Zwv6MzC/4afkzXQnmx7kubXJP4yfGPPkEtbpPtEuDV6EEHb3NAqamg
         WjA71e29Ln5vWo0t8hW/bNfJGpPwVolGQWpaGmJuefvDre0BwggFJfl5/n2Ol060glWg
         Ff7w==
X-Forwarded-Encrypted: i=1; AJvYcCUkivTWceIGJRMtKstqA5o3CCDInFY/V5xgDTApEbGHl7WALEgMw1U+QpQInIJBNfAKWHO1h0tS0UQQIu1P/MsAA0g=@vger.kernel.org, AJvYcCVO15wezW4ZUV0iDSGD1Mr+/35FfOFDC8IjkUtth5FByMGO9Af6TCo6Kyxwu7amuz0YSgWKo3cZdHY=@vger.kernel.org, AJvYcCXkProfLoP7nI5vDo6fCMUPdOoVuqWibUs0tgCkLM8n3xQvyhfijHR+LTbZ8k/cK/yS+Ta5+AA01dKGWkQp@vger.kernel.org
X-Gm-Message-State: AOJu0YyBuvwhHI2mmjDiO+33fD/xv1DqXsPt7p9I6c24E8yvYBVPGaYU
	7hoQPPhKM/zCJTUkTpKgEkfxGWcrHezpHVQhWSWiOd9hrL5F4HHs
X-Gm-Gg: ASbGncu7zNE6mTpug+pXDy1eej5fn24E1sFWH4rRiedv3V1SoOLf9w7tMyzl7caDbHd
	S54BgGjL8lwDKhTGIBmUuVyeZ71F/AZg9j8NYi31Jy+V190DG4ESfvU+yX4HTy0oqz2RSC3kt56
	sci6l+pAQaClURPS6c6v4I9aIIp07vp8nRK2+0MkKgNUVzmLkIqxBvMGQlHsd9ZKDIEw0RdsZ11
	Uc0sUKl3HFtlCm55xaF5JOov1FMG3oHIdu9sss+TYcwWc9Zg+f7owVBXfPFbkXguA+74DPGjrxa
	8ign7VClRjYgi6hGG624Y7GsyyMsBlRorwJZFXZMfU7PjEbm/rw=
X-Google-Smtp-Source: AGHT+IHtFw/OJkEA+kPm71pUZWebjIQZOp7KFKJ37v05RSPCTEZqzTaCuPFBtCu5VsKLcF9TSUk5EQ==
X-Received: by 2002:a05:6512:68e:b0:549:b0f3:43a2 with SMTP id 2adb3069b0e04-54ad64f5a60mr2871381e87.40.1742800402189;
        Mon, 24 Mar 2025 00:13:22 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbcf4sm1027355e87.118.2025.03.24.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:13:20 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:13:16 +0200
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
Subject: [PATCH v10 4/8] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <e84ccff01070eaee3dd1ae2d7e109f963168f586.1742560649.git.mazziesaccount@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ko9W/u9JJC9iH7MY"
Content-Disposition: inline
In-Reply-To: <cover.1742560649.git.mazziesaccount@gmail.com>


--Ko9W/u9JJC9iH7MY
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
 - Rebased to 6.14-rc3 =3D> channel type can no longer come from the
   template.

v2 =3D> v3:
 - New patch

The change is compile tested only!! Testing before applying is highly
appreciated (as always!).
---
 drivers/iio/adc/Kconfig     |  1 +
 drivers/iio/adc/rzg2l_adc.c | 39 +++++++++++++++----------------------
 2 files changed, 17 insertions(+), 23 deletions(-)

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
index 883c167c0670..8097e59da516 100644
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
@@ -324,48 +325,39 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_i=
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
-	if (!num_channels)
-		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
+	num_channels =3D devm_iio_adc_device_alloc_chaninfo_se(&pdev->dev,
+						&rzg2l_adc_chan_template,
+						hw_params->num_channels - 1,
+						&chan_array);
+	if (num_channels < 0)
+		return num_channels;
=20
 	if (num_channels > hw_params->num_channels)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "num of channel children out of range\n");
=20
-	chan_array =3D devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
-				  GFP_KERNEL);
-	if (!chan_array)
-		return -ENOMEM;
+	for (i =3D 0; i < num_channels; i++) {
+		int channel =3D chan_array[i].channel;
=20
-	i =3D 0;
-	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
-		ret =3D fwnode_property_read_u32(fwnode, "reg", &channel);
-		if (ret)
-			return ret;
-
-		if (channel >=3D hw_params->num_channels)
-			return -EINVAL;
-
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
@@ -626,3 +618,4 @@ module_platform_driver(rzg2l_adc_driver);
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.49.0


--Ko9W/u9JJC9iH7MY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBgwACgkQeFA3/03a
ocV+bAf+KIBq/Pk0Hq6fjLemXrSIx9XxJbszPFvjAcYzm7Nfng0Uoe1LIdjdta8c
tUoR5999bMjARzB4u+9wI3Kk11VK2veGteKErhofSJGX15FjlC0WPTMbCNNwwgzY
vMEeDGXYe1cwoQ17wcFLqiEeVRdIlxyykO5/xkwiH7uKeTXi1kwAvLKJCKeSkzr2
roh14mHQDO/QsMbC8j9hIgP9JigtRtxC0lg8PA3jH7BXZi5rkWY7fQQO6GyP/I8+
KFfnQuaRSNNQWOnO9+yWDmYDWStaXPlSG9fDG5Kwh0IMQcMIpf4rNIEgJ1fxJdgf
/UM3SQi7H9VLgOclcY5/zbsua9WAdA==
=2xsq
-----END PGP SIGNATURE-----

--Ko9W/u9JJC9iH7MY--

