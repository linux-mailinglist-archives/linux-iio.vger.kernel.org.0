Return-Path: <linux-iio+bounces-17141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D4A6A132
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B3F7A6C11
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312B3214A71;
	Thu, 20 Mar 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxPQQWuK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C4920B81E;
	Thu, 20 Mar 2025 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458898; cv=none; b=DUs98vbx/C7bHlNIYCgkhDg3Ki/tikvtv43ByiZZ62KWsWpWC6N/SnGrWUDzWTx4HfhjCrskOlUbaz/lCgTmEEoX4avdZWbAolyFv4us9WkLgwEVmjWKqRJcdD5yEz14z1/DsIBLajKxaQDs1wCmq0SaN3FvsYJKwVEE5BYsrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458898; c=relaxed/simple;
	bh=5s+1olZvrfDepZYolF+XZxcPNp0eu1iVp32/XZsDt88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeSbEsES1b46Ca//NNDNLApt5W1ndsrh7hmSKmECPBBBkpWVzy7zKBHvV4pyiwe5MVz1mquTH17AdpOnoYjtUuX0dEmNORHCtzWh6kmkYKVG6HzRo37LMaG7NTxZ6aEC4uRctxuhWHtQjHdMGF+9U8JrNYq9qlOtPlOYt8xFUNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxPQQWuK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so543117e87.2;
        Thu, 20 Mar 2025 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458894; x=1743063694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHn5LS6QjK1roaVwIQAN41urQFISbkKM+favVVAYAjs=;
        b=dxPQQWuKBxmMbsteRZTGx6KFuFzeHnrVyQJWCdEYi2AmeKCnNMr2wh+Pkve8LFCMH7
         OVuelnY7mJyKSrCMJfeMyeKrEDBhYJXcHyZezOVtCnIyUewZ5lNKF29kGm1HfNPJZtZb
         S+gGEqbTkBv2oPyOsNZrdRAVy3OwOYL8rBKCxbsDo6GE00UUJo1DgRxlSNpWiPbWrgBn
         +96v1D71nYGOvW67gdpvgJ/gzy/k00B+ObxP8XzDBmzBT/Jyy15HTSoqqcOTcLDbDNDL
         umB3EX1pVr7DDMADmwRNmVejaBBoS1fbkg8cCT8xFIGSiz7YzmkWMZ8drWpNnsJ29927
         XjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458894; x=1743063694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHn5LS6QjK1roaVwIQAN41urQFISbkKM+favVVAYAjs=;
        b=AxaUBmKf+g48ZJEfZoyMmcEPQUezw/p3wI05pcAakP6cpaZ7fFT2yLXMOZxS+lB+ZP
         OQ5/zcjwLEifsTvaEd0wn/fh3KWr1s7UiHTVB657RnUvYNf9uVC6L7ol83SB86/uj8kc
         +aya6QuYOE1L7aS8wizWHrvjehT1vktlEKd8IheigINzdnoFo6td3VDigz4PwbknQiVM
         dc7RGnkf4zFYl/7xiLQreBvwO/aGAwfYwWVFIV1HsfGH7JMrhMLsejgKG7F1mdTpjXHa
         SJlu8+lL7Dpo0LCHjlHBWNWNxD20Z7OnzpUTnH89krocYt8nNnRGgTYxz95LkkKxZHDi
         M7fA==
X-Forwarded-Encrypted: i=1; AJvYcCUW9k3xE2n1MZYmaEJJNSw8UEvjUED01cXLOm+BQPR+tw7VBIg7Fopb3P59AnrELDg0re4g3eb+aOU=@vger.kernel.org, AJvYcCWglMllZ/iJHVkGF5q7RGjRF5DZSFNNn6Yic1PyQMEFUUEyyy+XQtsrIMnpnbgIO5ow0lJUVQAzXrkZcGV9Kv7jfa0=@vger.kernel.org, AJvYcCXrrvDmVjg7CKFgosPIFvFfQV7S75s+x4TGDEU1OnRCBiImITw6SpLOyVlOk4fWZX4MbfAvcUMN1r71fCOB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKnwCZavWXwzmYLafuocyKT+Ktv+AaSL8jybBzuLj8CC1Bhzj
	LD0g0a8MOEioy3NaSLZm3gmLoAWhQTkCKssWtypEvhRvsl+1kihC
X-Gm-Gg: ASbGncv11X7R6eUPi/XLk9u7FlM3Vgy6aEMfrw8hvL+SFcXHWkmpVZbEdLiJ8zUTrC2
	hYmN5JlQTpf8a48zOfCS6vatV3/ZtBcYpf6jpptcflekzDK4NSiafyCxpgywC9HSVUAuaSYuH/t
	pcyN9KEE+JHF5/STX9drzN25H5kWeXQ/Xzn8HFrwPL2AsbIAf8qgV2Hyzcdz2fCrkXIJfwnk90H
	eANYdsv4WTpeAn1xkl8F5UhmG2uEL1XgXkNPAm2QKr1pQcHXmiPd0j7yHz5kIOagQN1tFnvaDA9
	eaON8zY+lKlN5UV0mXl0T/cs57A8qN1DJcEbmho0uB4Anz3i0r0=
X-Google-Smtp-Source: AGHT+IH6fqyrgkSGKtXPSSRg+UaxhjJDwQO8+OiM1mUCfcH7FhAMZW5Tt3ZymhgCuqoN+F+bt02DKA==
X-Received: by 2002:a05:6512:39c7:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54ad068651fmr788267e87.45.1742458893832;
        Thu, 20 Mar 2025 01:21:33 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a86c1sm2209974e87.21.2025.03.20.01.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:21:32 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:21:28 +0200
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
Subject: [PATCH v9 4/8] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <9a3a11561dbd3d5023da2da05cf2190793738242.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rV4g6/vmFUDjLo08"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--rV4g6/vmFUDjLo08
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
2.48.1


--rV4g6/vmFUDjLo08
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfb0AgACgkQeFA3/03a
ocXAUQgAjZZZhjA/o8IPDUqFz8coF0XFSH0Ut2zRcbPZHXhsxVsPRCR+UXJvZXsz
+L2nBXjHO0wzpZphwA50i4GEzu2v6p0oWTaPxX2Tn1dNs7ppQcgE4bGqTiuzGgPd
a4Cf5D7hZCRxXY5FrhgVXv0EKBW9tHdpbbAh24ixqIeaLKtBkP3bKN4U5/SvZme+
3ZBsVDZWcGbN/swBsIPi9uboK/rhI/Z6vfOQUUIO1cDpEktxy9JdwH6nrvr93u0z
DEs/8HXGrvfHyhun4kni2benzDKfyIR3geOuaygitTGhgr2uvze8s2D7EA3WprnI
OhjdcJh7LylV5c2hwYuds3dlhg/Rkg==
=QPV7
-----END PGP SIGNATURE-----

--rV4g6/vmFUDjLo08--

