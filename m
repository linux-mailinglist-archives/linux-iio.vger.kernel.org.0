Return-Path: <linux-iio+bounces-16767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EFA5ECB4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD88B7A97D7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556F1FC7C4;
	Thu, 13 Mar 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ+jiJr0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0851FC114;
	Thu, 13 Mar 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850309; cv=none; b=rkNA2s3mGHjAF/W4BK7OjUhRCgjKvqQhAkfZPP5izPY6OekDoCA20QynH1/9FW40hDwjyLnZD6+D6/oMZyuCoBBUJIlOgVT1gWhX5pTP2+miwbTa8v9gWlDcTV2dknaignTeZST7dxbcpeuoA6/aajZZZDItKQmNv67NbJ6ILz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850309; c=relaxed/simple;
	bh=rH8HYpQvPj2AhkP4iS9WMtYETITljdfi506n9WtdcOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1Vepa0VL1cEM+XvKl6pJ9a4CIiGz+FBzUvE1SlTKUqVtoVxyr7zHcorV96tNkn09u/yxsbj45ufOGenbGe3FC82qvfUEFAsBTO88WXbxXllC2kGD0qmMMmxWQJd+AlSfR6A7N38EsZpWOtbu0Tynb12hTW5EzbEGPf2aoLkYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ+jiJr0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543d8badc30so736700e87.0;
        Thu, 13 Mar 2025 00:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850306; x=1742455106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBGWyI2KhlGLTlExLjTIG8zzVp+t1U4InfDr+/tp5Go=;
        b=lJ+jiJr0dgd6sX+WOcBFtEykz9aGctwCzFcIArL25gJMC4JqEJ2oYCOjzq8UTvHUXm
         5byOqm5rFhpo1rB9M2PI6d30tp+PsVRL0WUcQvU4gXUAtOTqLEvAiJjJRMRD3USViXhm
         lt2bMs46rQ19JyXV4vM7WVQX1G61rFT11RwvKKu8g2rRRyN+KShzcII3msEB4LWhEsZz
         kE6+euzHWyz+yLy+Kx6MBYAsfNzYDIP+rrZklDCtdh0tpIqgKHPpPsZroOFDRCRGYFKg
         yb3pLItR9NfBuTqOq+8WtBMXMoy3sZmmFG4XoPBbtF17qcCaKic69jrWUwCE3l2Wrx5y
         Kq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850306; x=1742455106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBGWyI2KhlGLTlExLjTIG8zzVp+t1U4InfDr+/tp5Go=;
        b=ruRVfKW0hrOZEkpEz8I5QEE/CBJPI0r76Ty6PDulhqQ314qISEhKLIfSEvZobr6UNJ
         StDdukQVcu3VzzU0XfRBSBGw5+SdAALh0eQsZuEJp3PQ1wYKF/FS0k6LHm88VKMLkSLW
         HXqCNcO2m4CCW3hjiUiEq6Ttn46McxdJscHK0H/4M9ZzJKneKink08+KOH2TkX6UghA4
         N0tb+iFa1ZAlltruZzFvImL/008W9agrSoQSxazVohNZDZ1sXbj5l1UTqJWdEa6lozax
         J79L5A+bdwetSzspCKDmlRR1fwf5bxZs95saIUpxdbJjH9ggcHkkrnw1gNjn9Mv3A9Jt
         MDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU53Nn5aa+0ObBRnC5jSgKhQXehPfZF6/tNYs+xKKhs+vkp351cfOtwIH+eGmNaJ/1rBrduDurHczjn1OgE@vger.kernel.org, AJvYcCUiVMt3zwomzAllZIN6O3K0PzLY5kT/dsdXd0ghTluqi1ev0kmvo5tG9Ez6/RSSC0KuKeV0nir8eF7L@vger.kernel.org, AJvYcCVz3QucnGyt4jqxmTV9ArmVsEpIuTtRNSTOuF9ur+DQYkUb2x07L2FzhMVEfMDgxHAH9f+c+jWVuOYs@vger.kernel.org, AJvYcCWNkNO4FtaFK81OgQ5NtmlNeszs1nMU2zCK/eT4DEfZpm/hstt7L+eVmO0ZDhuT4MayYvtEChpGrXN42A==@vger.kernel.org, AJvYcCWzQ774iXMmIcoAiKE/akNKsy43Af6eJL21bRJuMA7ZFbkQPIIKZQE9buwvIyn/UAtaG8f99mbUQurujYRRuONt8jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysw0G4xfIlYvBJ8yqK/J12HIpZk1iDEtiw5m/1FIu9A4YWVsKn
	e0gGZlZQluZGvv8GRqM454zZLADGOgljBMcJkYcseGHewe/QFDmK
X-Gm-Gg: ASbGncuJXqD1nskpbpi8bE9fdk+kL7rqAJik1u4WuHLnhzR6BYaN9ZyZ/S1OScpOjzv
	h9zySNqgjitYJYc/IZkEGWvbqLraWFlSEjcPyoyU/e6TTwKxVLhxOMTtJ69/9waZUF+GPDgx+5V
	mEb7E8A/KXC9wLPOS+AoqTEJ2XNKOWdbnZUJm4aPQ/CTsxlWxDNgx22ZhRSwQugXGdy7rnocmi+
	t6cxOZfYPpBhhRz6qtROdBWhcXffj3W4GHdOTB4vjHguFjttGjtyYOTdZNOCN0/CTra4Z904psQ
	UTRTL6CGSiHylfoNAdh3V2E/5BNK5fXSSFoESFK9ZpdvCYBJVjo=
X-Google-Smtp-Source: AGHT+IGP8h2FL/lCirDVHljxL5OfQTimB9tsLIQ+xH91borETZK6KwSphvw7DjFZLuCzX4cD5bzVZg==
X-Received: by 2002:ac2:4c46:0:b0:543:baa3:87ab with SMTP id 2adb3069b0e04-549910b7f23mr8760741e87.47.1741850305346;
        Thu, 13 Mar 2025 00:18:25 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c2677sm117486e87.95.2025.03.13.00.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:18:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:18:18 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
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
Subject: [PATCH v7 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <c8899e8c535a1d93cd7588b7c160eb0fae5d26d2.1741849323.git.mazziesaccount@gmail.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Map6KVD9/XFFO+4M"
Content-Disposition: inline
In-Reply-To: <cover.1741849323.git.mazziesaccount@gmail.com>


--Map6KVD9/XFFO+4M
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
v6 =3D>
 - No changes
v5 =3D> v6:
 - Adapt to changed fwnode helper names
 - Fix spelling
v4 =3D> v5:
 - Inline iio_adc_device_num_channels()
 - Fix Indenting function parameters
 - Combine the max channel ID checks.
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
---
 drivers/iio/adc/Kconfig            |  3 ++
 drivers/iio/adc/Makefile           |  2 +
 drivers/iio/adc/industrialio-adc.c | 79 ++++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    | 27 ++++++++++
 4 files changed, 111 insertions(+)
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
index 000000000000..6cfb001c74b9
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,79 @@
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
+ * Return:	Number of found channels on success. Negative value to indicate
+ *		failure.
+ */
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+					  const struct iio_chan_spec *template,
+					  int max_chan_id,
+					  struct iio_chan_spec **cs)
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
+	device_for_each_named_child_node_scoped(dev, child, "channel") {
+		u32 ch;
+
+		ret =3D fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return ret;
+
+		if (max_chan_id !=3D -1 && ch > max_chan_id)
+			return -ERANGE;
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
index 000000000000..56b092a2a4c4
--- /dev/null
+++ b/include/linux/iio/adc-helpers.h
@@ -0,0 +1,27 @@
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
+#include <linux/property.h>
+
+struct device;
+struct iio_chan_spec;
+
+static inline int iio_adc_device_num_channels(struct device *dev)
+{
+	return device_get_named_child_node_count(dev, "channel");
+}
+
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+					  const struct iio_chan_spec *template,
+					  int max_chan_id,
+					  struct iio_chan_spec **cs);
+
+#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */
--=20
2.48.1


--Map6KVD9/XFFO+4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShroACgkQeFA3/03a
ocXYzgf5AbYotx5dtqF9n2zXC4MOYVTwMuhhofkA8MBZgqF5L8mJgFQ6MmmxxQC3
zfOXxIhNGaW6aVj2FwTJOcG0/+5bRtunmE6ZvNxvFcE9KEtWGR7bt2qSvwuS1GJB
ZpIZauIUQzmHWt+09SxE++PV35pOGVvcdqFx/hqUURkSUSxl3R62GfdP7mVFJuRr
Bejq2uNVVr9uBpmEexUcDceDVC0PRbQyBL27ZTXl7RwiU2TSSLNWMkvhA9/0vzKP
ErMXITzLcLXToJtXw42YhDViJGJ4JTNC5jmIFSANMlKwlUcraxOzjkuEemCwPZ0b
PShKC3WCJ+Vw9h0iOVbRKHwzdNO+rw==
=naSV
-----END PGP SIGNATURE-----

--Map6KVD9/XFFO+4M--

