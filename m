Return-Path: <linux-iio+bounces-16978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE3A656A5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC15189BFDC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE77191F98;
	Mon, 17 Mar 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTC17P+O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BA18CC10;
	Mon, 17 Mar 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226672; cv=none; b=V7gFfQ0bc1ewUd8HKc+WONS4D+gLw3mpIMhNxu7lg4U0RdbfFXxdmGhrgW+kN8R6b61OGM9ESWJy+atDgNtL+Jr1msW/+vQqtCEPimrMHfI64nSvYZynlECiv0UH4AtZHMAcU7jDJNiIHBeEv3w939i6Y9lY/XFRIRjqteTivSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226672; c=relaxed/simple;
	bh=nUgF7BpmBFQHlh/SW+L2+6UKfHzhCGfZzOdkk2YYTKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Kvjc6SQjfX1VQZ5oTZWrtP7cObxpy933hL7ADT8SBKfklY4yxL1gB2xhmAjhzqGL3TGLC7fNLoTxb5FtMtTWFNL+leFcZ0w1GddpVXmR7+7SSCl7PFYjaV6FpDRp25oSzgxsDmDt9EfnwYcjxamPfXXUzT0XVT6LQyA1gRdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTC17P+O; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30beedb99c9so41984421fa.3;
        Mon, 17 Mar 2025 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226669; x=1742831469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUhFMAJ0TI9lHx1fpt2tcoLPC0eRKK/W60iKIY6k6Hk=;
        b=KTC17P+OKNrQ/GVaXpZd322qsFCIuFQYkkjG50ZVXunKwfbIcfSAx1IGpxWoAMX/dL
         Nd+O8g4JfRw6ygzlCYPnVKGfl55ILgYvwRDAPD29C0bhiB5mk20Q9+Fp+lGGtmPXQITw
         MrpczS+zA6F+cX4oP53013033QY1LuHR0H7XqGF15anFMvh21Nc/j+zbHusQHAMse1p8
         xKwtTMKM3fOpESUkzXXcbdXhmoI0/GUzZt602pXT4PytjJHLcrCE5/UpU78SS1NkjRfc
         0WQhi920dLZLVRafNiP0xNzlESC6/3rGWlIBpf9UAH/megpG+ZXfU8Co0LzMXxfj6sBe
         8E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226669; x=1742831469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUhFMAJ0TI9lHx1fpt2tcoLPC0eRKK/W60iKIY6k6Hk=;
        b=a7XtpemDwPWaezThRfzUFSnXnNz3YLPCvh/45+3hcKFLtDDBOyhuJmGMV480dMcP7C
         mzWt2zfBpcyW9vY8bjKeW/oZIRJTCfuXJT1hsctyBazuQWQeLB0K41SzHGwZDE6VMoTt
         tet+6bq3Q1JmAFu/11D0unTu+8ZKshjLSEmhHd9cV8y0vfU5sBTypbnKc0qAe5N3RzWG
         DsYDpJUZ45gZ7LZ2RCDuAkpOjSpbuIxnNf/nezVDp+Ag2zRmVKFq9ltTgl03IJRIZepD
         WrpOv0BJr2/kYR4D8usNafkEjRKQHevwJf3d7TenK0cmms5McgH0cnQeNBZXnGys5zE9
         Ae7g==
X-Forwarded-Encrypted: i=1; AJvYcCULvJw9gkgShALOUPiRD3Lijbtq5fivsVNMD/sxuPkFdSANVBWxAqi4Nbh5w6Lb8r4cod7waalIGu8=@vger.kernel.org, AJvYcCVj+KUzGFEo7qicXWaw0jrHytVmFrrlu6dd6W8knFmrUV5aP8R6xGf2THhOb6121xQ7MYYn+EPzxVdKn6fp@vger.kernel.org, AJvYcCVo/PFDq25sKo2SZsZdXlVLfSz9UUcJR1tK9vMWorVdcvXRUzEfg+Vgc7DHfmpsYct1U1aIQnGbrKl8os2SHc8Wylk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglNquTiXEVs1z9V1TCjSeIiq/wFDgr3i/cbG/d+DO5brCcGLH
	PP4Vyt/h0RpDwaLHlF8LOHUoSWr3oLWSilwEpMA8VtqukRacz/BK+OD46A==
X-Gm-Gg: ASbGncug/mBdKwwT2C4qyuOT/HKz9CJhEK/caBB7BwMrdlAjGs2YdXkQwKYUFCkLdn5
	7wGO84dS69H8LefpG3U7kCLsycxj+GhT07v50HjqMta43PhCtgXFqW77ej01fFzPRx75DV7m6v6
	ksBPJ8cS6Z/3Yq+s6lxRKb6ElALSScEvDlvGps2lG8gETdOCQsovXnjoyoZFsX41ruja4GaX6vd
	4uHUNYkswtG3hiwABv1j5eOl9Kcuv0KJW6tRLxDX7o/fDGLZfywuqcU6WzFntsDLRcGZL+YAtaf
	xkB6Ns1cOG/nLGGDsyVS/jecLxwFwNUBTBnop/tTGksZQJcFi6A=
X-Google-Smtp-Source: AGHT+IH9c4A6bdrRvvLHiVn+XSUiasQ49Prj2rnL8yMEX2EWx71QX8CVsgo36CW+3qbuUR/wlFX5ig==
X-Received: by 2002:a05:6512:138a:b0:545:2efc:7458 with SMTP id 2adb3069b0e04-54a03cf4e09mr321289e87.39.1742226668289;
        Mon, 17 Mar 2025 08:51:08 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88213esm1352414e87.175.2025.03.17.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:51:07 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:51:02 +0200
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
Subject: [PATCH v8 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <69b627227e675d94c27f42783d7cf9ada93f730b.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ra4PSkOTz2jaGrhL"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--Ra4PSkOTz2jaGrhL
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
2.48.1


--Ra4PSkOTz2jaGrhL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYROYACgkQeFA3/03a
ocUlSwgAi/k3Npc+ybHI0GoWaiW1KXr7TYNcmtPFjdy3l4alRjQRzKDrI2H2yPNp
OWguX0xpfsUeOCt6EcOw0R6sYMHZAZxT3I+Uww73cmtsxaYBC4DecRlZKeBB7r5p
Pk5eJPVRZTh/gWYSGitpJbnsqQM9IljrGL5sHUpIukaP0bGNI8mLNCzd2H53LgdD
4cGWKgaxsRKbN+xn3J278t1oB2RvK4GDawCkjpXsIcz6vtdLZmoi0AOP+jg6o/0Q
0LvtVXDIko37DibkmKtMK4ls+n13R/LyGPGSUHQkndovkRnJPvU2zgVeZ/rwpmRx
rEkptEUyx0VvoCCXiKPJe2NGbrYQyw==
=kPwI
-----END PGP SIGNATURE-----

--Ra4PSkOTz2jaGrhL--

