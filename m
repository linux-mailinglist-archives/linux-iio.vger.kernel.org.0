Return-Path: <linux-iio+bounces-16769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2648A5ECBD
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC4A3B6347
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA41FC0FD;
	Thu, 13 Mar 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ8NIoUJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2ED1FC0FF;
	Thu, 13 Mar 2025 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850340; cv=none; b=l6i97ho20J2g8c8XSGExzbI179o4JGNfd5BLzkkRBm3sRl1LYZpNMAb7P/sqqrBkA+a51P+/UgcIg0FG2hQQJIuhoC+6Ne6HfNbxn/Kh2zntkfGZL6KLe1iXHMlbf/6QtKWlS+yI12EDJhe9F1T9sk2cdvnbzmnEDIzyJoW1Bfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850340; c=relaxed/simple;
	bh=Py6P5qIQMYgTW/EN6fjs6QOlBpfBZ8Vn3jJYYY3XtRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCyErT1ZmHubqLOfvpZe2S2GnzslnpaxjgtvNTiIriWkP2WngasnyUBisCt2rwMvns5lta3WFxS9KVd+e0H+LnTZTrUgvkkR+pvHWFUDlQzaLXTRamavJ45LAs51WViZ5w6kCjzEDaoVYmJSAUr1poQpwHOUiaZ952iZTPjd7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ8NIoUJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c05fd126cso6057391fa.3;
        Thu, 13 Mar 2025 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850336; x=1742455136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFD+DcpWsMqfiQV+ZB7bRLNZX1LXyd6tXIeA6qREGzs=;
        b=OJ8NIoUJRvKSLho2fvHj7DmeLS0KQnbMGgMjigDzpaKqowytxdjJVMM38ZV/uxFkTx
         L40/qs2nJWWSv1WSwDVCBnXpunyDkHif5oVzl771emngpyfpIeYl1G623daMbINNtDHl
         KmmagUKHjpqtyqiowYCqqlO9BxprsXIYSIwTpcQOqpzEGsmDr217DPEZoKi4i9QsDLH1
         38hSWNoUCNqdBH8AHObbKpGhTEb3SFYc8ar3tLZZDJvRip86UAV/2VLWFYIPyRvp0JbZ
         B789MBNjjIBDIoDMXvNwJ+yMsdjNW5Aw68cbiZ5hYJxNK+eUJ0uhK9QWjN2GVpru5bdk
         wRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850336; x=1742455136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFD+DcpWsMqfiQV+ZB7bRLNZX1LXyd6tXIeA6qREGzs=;
        b=MofliyenpkktS/k2sPIsxa8kN4r5XzUw5vGRQz/lee1jOalH08ApZ49msCq1FtJTgt
         QEQsdl9jI3TcuqPOa8VHNMXH6WZhilX7ZszTeCkZcZUaoMcbkP4nBZ2p6cnQmDoMI66/
         6dma/0bm0Sgov7MrXQpKbpSU+97JCbNPGiFTgyGuvFE6HURj4aPkxVxMciqzCL6C/lnV
         KLUF5gIMbvGW20Bd6RKddr7jNSks+xTIxGMA7BJXsXEtA8O2haa0ktiZg7gdfFDcZIe1
         sy07Qrv1x09tFrZ3oazZ64ALrH6f4qD0/l5yuBSzXOkoIo69s4O16t35C0VMG2WirJVO
         G+ew==
X-Forwarded-Encrypted: i=1; AJvYcCVXrrmuHhy3dHqKRNmRFW7tC5SwUmDY7V95hc8NuvXdHHjlGbbFU+CdVC9vgu/NJi7tQp3PWXMec0Y=@vger.kernel.org, AJvYcCW1RFBmbpVF9Hq+g/3LYUao5lzR3k9QaQQv9DLisl22FGm1WHIcInp3D9oSBezo/oYyzmoB9ksQsXqLGMjg@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5Si7tWV1bSUdT8iMdRtJlxZwcGj0iCleOdyFbU9JbnFUWDBG
	9DXamyHCkk5kdYN0kbERUdPWTO+zcU46oOSSfQPcm5KU1C32M4Fs
X-Gm-Gg: ASbGncvDcBX/TxiKN8GaWkpPTiZlPOqty9CAfqZbP+9IeuHUAXpZpsPx582g5iyP8zH
	5GvD6wc++ieYD0SxbiJ9F95XgI8dE3iH78vXrevOaV6B6syMzkteEjOlWtDQBn/3qTxQ+gKkKlk
	fb+w1u28kpXxP1VK6qsjYCTaV+84fVx8bnq3K5tSGBs7wPcZXitImtFZkBaUC/pdevmBHdEpZ/d
	bWaixG5WPWSc5MkEglWkUdm0C1BF55E/so5ArO408wVtDfbPEZRR+L2nPbBWlLGsAEnuZVTObM/
	kLDbgg2HJwXFOJF2b15Ofx9EHyZArwXvlvBDG/SKMmtj4FPsSYU3HdNsp3wSnw==
X-Google-Smtp-Source: AGHT+IHmLCwaOiAyND+HYla9YJ6Owuf2FrMyU+QZHQM+mLQ3MEh0Yx2JRunjCA8pnIPh1yD8DBMFSw==
X-Received: by 2002:a2e:a543:0:b0:308:eb58:6591 with SMTP id 38308e7fff4ca-30bf460589fmr89888051fa.25.1741850335814;
        Thu, 13 Mar 2025 00:18:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1ec0f4sm1170341fa.109.2025.03.13.00.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:18:54 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:18:49 +0200
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
Subject: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CG41A4IiURwLiNo+"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--CG41A4IiURwLiNo+
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


--CG41A4IiURwLiNo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShtkACgkQeFA3/03a
ocV0VQf/bSuM20DCboJT//bmPStw7rxp+5V2qaPIPPnR8lochMA4g+bGRDCxrPCf
njoGMR4SXx8lAo7qTKIKI38WiXEGZt9UWZ3ChcTOJ1TwK70piBL85trcp9wYOsv4
OTug6csBzfPFoWg1KdCGBnh83jGkbNv/Wz0PqqKSQfXY1ZCK+VGLc+BZtYvpjkoV
DpvAnntsFD98gpmT+iKgOOx+oIGzcf/qm1URB0hBJRHtLmrp4Y/9ddzEXWcglEJe
eLLAe1ioYE4+qdj0PaRgfMN4dOEhnz+QaweILOQAfpjz2LCXEZMRQA65Tt/gqzGZ
bI6YQp3BPyhLIPUXiwks1S5EJmPyug==
=mpTG
-----END PGP SIGNATURE-----

--CG41A4IiURwLiNo+--

