Return-Path: <linux-iio+bounces-16027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABFBA42B92
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695633AB68E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A5265CAA;
	Mon, 24 Feb 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgT4iKn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D4264FBA;
	Mon, 24 Feb 2025 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422007; cv=none; b=ki1RyJqrC93MVtWaWXnupB0khQaCXqh80ltkCRcOG6B8slBwBq8Ip3oTRzQq9mYRb2Gxe9P1VaADW0juJxUY/SHX6TWrHfFMp2GL9oc8m7yM1thS4ENY2Bst/tWB3qcSGVvrBBXja9WC+FcB6Ab+ZUw0NbfFZnazzz17Hc/NNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422007; c=relaxed/simple;
	bh=Ev0eYz4sPpsPFrs2YtL4T+4Bm2liPGWxuhoDXr1Jpok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep7CC1GOTg/m2qxksVXfjnCfp4YI2nyEJJlPUYc3OgQX278wDegWmuR4GnmtxCkl6JeyLKl1A3LmvGHnzRqk3L5mUSG6CqeJOT1Q2Q9EUduBr3gz7Cxje5hBK9Li2nMwxjNxJ1Ef5joE4tAB1bpWPZJ+m+Z0HgxdRnlja7JRgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgT4iKn+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2969875e87.3;
        Mon, 24 Feb 2025 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422002; x=1741026802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=va2pvWmTusgEpgeYLRyDeBT6KWSDeENhUBZHU/VVNr8=;
        b=WgT4iKn+eVjB/Brg/4QT+JbCXkBVp4CVobO9g0runvARTsFH6KXN1MRyESD8xuh7vR
         imshs5y1L+WQJ4BXIudhHbG+CWo0Zc9x6TF5n9FjFfQBc65ygJgvYasANFWOVlPgozp7
         HPvdmiXG+uXV4fwNNQaTajjVmwQXBw370TpVYwA89NzdOzVJF4sQ+Z540nzYDKbBUAT6
         oLnColD4ml1LRFAV/15vNrCweJ/6kpIaP524N9VfbGcoyK1aRc2eoZ0KAmAKz0YHqLPt
         rbI7R7dALHuRs9Idj7Rs+yG25iAD7RT++Z7+OfYCw1eUoJhaGEs0k+hPOC1WrsS2SM3k
         s0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422002; x=1741026802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va2pvWmTusgEpgeYLRyDeBT6KWSDeENhUBZHU/VVNr8=;
        b=BhDH41y08Lp6ZLJfiee2fO31UPJAYof+ScxMVHD0Vx+uH5RHyeL9+6IWX02aC3f0R0
         wd3IiGMPqgyTLMnzhiLpFhODhm7aJC7IImhHIcjvSAOjCl88QzIvfKLvJzb9ECPBsmef
         SG8/r2C4Sus54fpHei6+W8H4Cce01a5wcCZNHib0WUuCKwxkbODyPz4l+hD9Q9GHYfA1
         nqgUkwKVJxZ+sE9XUa2UHsB82f0fVqN1W4SdO+l+OsnlKXQyeAEM7R8zrRxWUtRUbNk7
         HDYJ7GubvnyXUccJM4pXU5A5TsrnzR37fr9dQq3FUfAD1r+9MI///cmBsEHlNdvwLDkS
         O9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV2yfwr9SfpCmU1ruXJCTg7nMWFrww6NkahUqUwbYkX/JFGZlFfZx8UJlRVfhCKRTO+Dj+8BLsdVj5pzIk@vger.kernel.org, AJvYcCWBHiYNj3vLqXCF9dput2u2GN77m1y3nCTDIx2jBBp8orTDxBZ6mnqLACTFFUK1S9jnoV6Rx2tyuQef@vger.kernel.org, AJvYcCWmrXJ5pzfK4nvR0S7ltyPFtjnxjB6e/D1MR6hGKvSCwhFjXugkWSz2lNSx4Von9WygGeRaONplCb9e1g==@vger.kernel.org, AJvYcCXIp25yje4x8xRVDfiONRBOQVWl8pkK1A8dLyuZIEms+0QYvo8EuowyGRSNZVjBUw9514BxLDrjGiyS@vger.kernel.org, AJvYcCXhLSeedFElWG909A1LgB8ciRvRs+8aLAjqKom95zmojBy+KujLTU+4uj7ZTTDvy84qiQRm6bqxNQM30M3KXzbwMX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6CPbLcmYS5jdC71Jd9LsJmtBkvV/PqhyVFtRNsXSHUzkukfB
	t8G84Pv4TbWeeV2kKFktFkF1+53ULzQaCTk2gPj3cYqmswkAWNK+
X-Gm-Gg: ASbGncukRmpndCy/Yyz69uN2gfTRR2mlyNMY8alCtvav8Ra4gOc6FhM9VAI9KOkQLTK
	aKw5W6RWzgHz6H4CF0SwJnqcLrng6ZuO8iUd/FnIRAJUIN6n4eZ3yNyCr4CQvN2FkUZVma6BWSj
	6dkkAK+FP8rq66Pgg0sIynqFUyxEzclN5ZNm9MQEbk/eJfPYNpUiqvEUdBb1IHqXDQ/IKJZ8yCT
	iKxbyi718NkU/48kKP0V1t9IKTHWGROa95JVNMM3v6D3onDxBgWG4IwWHo2ph8HO+LOo05BOydJ
	o0hea6SCCpdd3+iLplqUTQSKDoS106Op
X-Google-Smtp-Source: AGHT+IFU/BAE8/JP2/pFWB6uj3X2U5hpIcR9yw/fgE/bh3vrS5xv0stjrRkIhM1Vu3CupP2zc9Z8ug==
X-Received: by 2002:a05:6512:b0a:b0:545:d72:95f0 with SMTP id 2adb3069b0e04-548510dd0efmr39333e87.24.1740422002020;
        Mon, 24 Feb 2025 10:33:22 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819ebdf6sm46721fa.35.2025.02.24.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:33:20 -0800 (PST)
Date: Mon, 24 Feb 2025 20:33:16 +0200
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
Subject: [PATCH v4 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <23f5ee3e3bf7179930d66c720d5c4c33cdbe8366.1740421248.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xF5zIPCTVvd4fOx7"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--xF5zIPCTVvd4fOx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are ADC ICs which may have some of the AIN pins usable for other
functions. These ICs may have some of the AIN pins wired so that they
should not be used for ADC.

(Preferred?) way for marking pins which can be used as ADC inputs is to
add corresponding channels@N nodes in the device tree as described in
the ADC binding yaml.

Add couple of helper functions which can be used to retrieve the channel
information from the device node.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v3 =3D> v4:
 - Drop diff-channel support
 - Drop iio_adc_device_channels_by_property()
 - Add IIO_DEVICE namespace
 - Move industrialio-adc.o to top of the Makefile
 - Some styling as suggested by Andy
 - Re-consider included headers
v2 =3D> v3: Mostly based on review comments by Jonathan
 - Support differential and single-ended channels
 - Rename iio_adc_device_get_channels() as
   iio_adc_device_channels_by_property()
 - Improve spelling
 - Drop support for cases where DT comes from parent device's node
 - Decrease loop indent by reverting node name check conditions
 - Don't set 'chan->indexed' by number of channels to keep the
   interface consistent no matter how many channels are connected.
 - Fix ID range check and related comment
RFC v1 =3D> v2:
 - New patch

iio: adc: helper: drop headers
---
 drivers/iio/adc/Kconfig            |  3 +
 drivers/iio/adc/Makefile           |  2 +
 drivers/iio/adc/industrialio-adc.c | 89 ++++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    | 22 ++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 include/linux/iio/adc-helpers.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..37b70a65da6f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -6,6 +6,9 @@
=20
 menu "Analog to digital converters"
=20
+config IIO_ADC_HELPER
+	tristate
+
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
 	depends on AB8500_CORE && REGULATOR_AB8500
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..1c410f483029 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -3,6 +3,8 @@
 # Makefile for IIO ADC drivers
 #
=20
+obj-$(CONFIG_IIO_ADC_HELPER) +=3D industrialio-adc.o
+
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industria=
lio-adc.c
new file mode 100644
index 000000000000..d8e9e6825d2b
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers for parsing common ADC information from a firmware node.
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+#include <linux/iio/adc-helpers.h>
+#include <linux/iio/iio.h>
+
+int iio_adc_device_num_channels(struct device *dev)
+{
+	return device_get_child_node_count_named(dev, "channel");
+}
+EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
+
+/**
+ * devm_iio_adc_device_alloc_chaninfo_se - allocate and fill iio_chan_spec=
 for ADC
+ *
+ * Scan the device node for single-ended ADC channel information. Channel =
ID is
+ * expected to be found from the "reg" property. Allocate and populate the
+ * iio_chan_spec structure corresponding to channels that are found. The m=
emory
+ * for iio_chan_spec structure will be freed upon device detach.
+ *
+ * @dev:		Pointer to the ADC device.
+ * @template:		Template iio_chan_spec from which the fields of all
+ *			found and allocated channels are initialized.
+ * @max_chan_id:	Maximum value of a channel ID. Use -1 if no checking
+ *			is required.
+ * @cs:			Location where pointer to allocated iio_chan_spec
+ *			should be stored.
+ *
+ * Return:	Number of found channels on succes. Negative value to indicate
+ *		failure.
+ */
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+				const struct iio_chan_spec *template,
+				int max_chan_id,
+				struct iio_chan_spec **cs)
+{
+	struct iio_chan_spec *chan_array, *chan;
+	int num_chan =3D 0, ret;
+
+	num_chan =3D iio_adc_device_num_channels(dev);
+	if (num_chan < 1)
+		return num_chan;
+
+	chan_array =3D devm_kcalloc(dev, num_chan, sizeof(*chan_array),
+				  GFP_KERNEL);
+	if (!chan_array)
+		return -ENOMEM;
+
+	chan =3D &chan_array[0];
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 ch;
+
+		if (!fwnode_name_eq(child, "channel"))
+			continue;
+
+		ret =3D fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return ret;
+
+		if (max_chan_id !=3D -1)
+			if (ch > max_chan_id)
+				return -ERANGE;
+
+		*chan =3D *template;
+		chan->channel =3D ch;
+		chan++;
+	}
+
+	*cs =3D chan_array;
+
+	return num_chan;
+}
+EXPORT_SYMBOL_NS_GPL(devm_iio_adc_device_alloc_chaninfo_se, "IIO_DRIVER");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");
diff --git a/include/linux/iio/adc-helpers.h b/include/linux/iio/adc-helper=
s.h
new file mode 100644
index 000000000000..5d64244f1552
--- /dev/null
+++ b/include/linux/iio/adc-helpers.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * The industrial I/O ADC firmware property parsing helpers
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef _INDUSTRIAL_IO_ADC_HELPERS_H_
+#define _INDUSTRIAL_IO_ADC_HELPERS_H_
+
+struct device;
+struct fwnode_handle;
+struct iio_chan_spec;
+
+int iio_adc_device_num_channels(struct device *dev);
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+				const struct iio_chan_spec *template,
+				int max_chan_id,
+				struct iio_chan_spec **cs);
+
+#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */
--=20
2.48.1


--xF5zIPCTVvd4fOx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u2wACgkQeFA3/03a
ocWTugf/U1pTmo4p4LmDyyZYpi+D/ws4cKRUHOYY95vJckFOlwmOyc9U8dRpKI07
CFWsUcrb775GbqfUGpnkaq6C9Dyshlv+5vR0jWcdV515Q5z9qHNr7e4ZOrvdu+/O
6jEE8Hipav5vG4H68tsNCS75NO7cLDgC2JeelX2ry90AkDVOKxJKlyhfi3ZEOIvw
S9Ijn6lg54WX7n3OwKScW6jfnMAOvblou4tprOk9IniYGwCKrvaF6SCT+2QdD+5/
l9+0JnbuM7wmW9OOIBoUFBO+xOOYK33VSlcFFmpfcsz2rH3Cvhd4itABZA1GnapM
y18XWpd9QPm2V4txHMpe+vT46UYnnw==
=+wbV
-----END PGP SIGNATURE-----

--xF5zIPCTVvd4fOx7--

