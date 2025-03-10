Return-Path: <linux-iio+bounces-16667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718BA59553
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F23B228D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF5229B00;
	Mon, 10 Mar 2025 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGDfJapK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A7227E98;
	Mon, 10 Mar 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611381; cv=none; b=UZQV6ckTjHAeBCbK9SUIL7ql1fPhPuigFoEHZjjpK4OQ7jEY0TAWpS+DegG4/jciR/9qWKcSipQYQmVtovOCjG5OI8VoqxbyrlbaCZ5QVP+MJf9AKgTvS2Psn4PgFfeDObpfCxx48GQkRe5KfrVf1X2FLS8su1FVK93gJ6bSdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611381; c=relaxed/simple;
	bh=g0jZnLSa9pPHhKusFdn4qSS/J9LINnm5/xWCLl9Nvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOtTakosq8ABJ2E/O1wagu27qW+/zKQmWl8IQVr93aJmBOggkM4e44gxZwV39RkH8FLMCuv7+jimdB+Ti9nvrESeBMJNo8KPjJSPePCUwqA8waslFlqGytuUuMATiUSpVJmYc38CRLGsfkVkOJCIzZ1GexBikeyWPO7+s2OHszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGDfJapK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4068162e87.3;
        Mon, 10 Mar 2025 05:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611377; x=1742216177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvlmIYXxPFwsgRKDsD0xfbB0Kf2m77owf2uPI4W2MCQ=;
        b=hGDfJapKBx0x5za59h3IcvoO5PmJQRK3Ay32tx2/7gHmt5Zv50t/awOyVc599VURDd
         Nyo0SH0vaYppHqjvkBFDApgQ/TWENdyXS7fVIZLxsy7bKYB6REd6o/ul1UWegXcabJt1
         QTWJ5Qy+DxeNhZdYxYMx0jsfCxl7jNLOmnn21nfFyFvtjxviBMKmO6YY5IFOM+4eZ3eT
         HvlW4fh1VxbL0gKjmo49XK+3rBjwefFPrLNl00xdib3sueX56UTYvD7tdnBkBK5CRN4f
         3FfLMV8QkXzX6eC05XGO5FRVkG7qXJzUK52CoW7g1bz7JALlEM9TrPEuHsqbNXA3IhPa
         06ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611377; x=1742216177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvlmIYXxPFwsgRKDsD0xfbB0Kf2m77owf2uPI4W2MCQ=;
        b=hUzCxDmkGxZFImu+NrYqV2XJxF0KEy2wvgG3EJgeywxlLO66lQoeCu1b3V4hFbjrxj
         SJtXXtx9AcQyX+8vSnaNeU31KlDXoo0cYzx375ZW7trHUio0/z3YQGgioxHvyO056u2P
         xkx1u8OqizSWhMLnd8Ozmu/Y46AC88Uczh1poD5EiiJObo0T+kOKYPz4UB23c+Mw91e+
         MWeew2rgTjqwTvYkot/SXrgNCKyg3DKZae/2dGIpcg5YfK1DFGE2OBpMkUA83b0LogKW
         MbZExNVsckI5DasF2v0JUO7zxUQTBfFcEB8IfMYS9YvKCFWrHqKhpXO6bCPbxpwEpYsS
         AsMA==
X-Forwarded-Encrypted: i=1; AJvYcCU2oaDJcfkztReulQ81peYT2Vtyc+QSaoH6lVTLilVgdMZxDJTrdAQGjcgs40Ad/HtomLDKSsEd7LWK@vger.kernel.org, AJvYcCUkhxM9oJ7mDt7jL7fr/GJw3HU0B2dJF1u+QeskqwV+blexbt9pOAfYUEe46LDdOCf6ETvLGrzQe/24Ng==@vger.kernel.org, AJvYcCVYfPVIS6Pn9AkoV34OdhxyB8bVoJpv0berOnyVZ6aWdZwH7Jb2kUOYNrv/iPBk037FsGMe2eouYLN/3OOD@vger.kernel.org, AJvYcCVq7vQ6WTAO3kB9NruOVyz5g7ekuplzghgzNYZ2jgupYWntZ0oPLg9xBe8KWK0lR8mWqBUS7bClnXVFbXaCtqC0KBY=@vger.kernel.org, AJvYcCXfxKLRgbiLa1WgowS8gBNl4ZVhxFzZCZoeykclFXSZ61whFBA3UBHzdzvYOVMBMDrd0ajjY4peqQ49@vger.kernel.org
X-Gm-Message-State: AOJu0YxVwiTo3C+LVljgjA2CXCf9/MlX1YbaWC2xkch2He/HNYjvIwvs
	AYEXgrHUZdVLKX1naKIsGARVOW9I9Dl01e/7+6+Nz9tb4YkLA8VlDCurEg==
X-Gm-Gg: ASbGncsJtPF7Dewi+buDanSgETKKUI2ZRvWyCuOlUUaTbYqRDet7b4MPXnj6z0RLsBg
	tX/OU1q5G46thxNHYU/y6B57hr06GyVzXwYXFOoBqnxjIiCtiVnacZu/bKlQWyTjEgY4om/1KVN
	2SC0f+Y8JaweaaBKmE7DSPYkPuarW87Q4RQuNTFR2wCPeO0btSuqX1FPPFBQulPhnheWpxmlBEV
	Gnqo6NCfbZbPVQJHHPhOEla1iDbSwR0sKQEX5aDG6Tum3N5DvOcr1a0AxzQ5UUxzgGozXUyhwwW
	Z8jQEvYSO02QFWHU4tW2+35JJg5szJH65vGT2kGheh+ysdzQxNA=
X-Google-Smtp-Source: AGHT+IGu/NN+//EpU7CYFukNrNlPLiWHT6UQmiVwqBJ4NNs9fZZiJnlH6BOdww1vKwf1TPdeJLv8dQ==
X-Received: by 2002:a05:6512:2342:b0:549:4de9:22df with SMTP id 2adb3069b0e04-54990da2057mr4566087e87.0.1741611376948;
        Mon, 10 Mar 2025 05:56:16 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd0a0sm1446345e87.156.2025.03.10.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:56:15 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:56:11 +0200
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
Subject: [PATCH v6 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <c9654fcda1c5c8ac98f99ec8e3babdc41cbcb67b.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yVy/56adD+Q+P3oK"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--yVy/56adD+Q+P3oK
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


--yVy/56adD+Q+P3oK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4WsACgkQeFA3/03a
ocWgMAf/Z7NNUkKEm27TxKxy95umeEJ8mGVEzQvcolALVtVjQGUQhbAquYTy8CMT
5iCmkYMhuQXmyT0mgTchgVnBNYp2VTVk1TG1wmHGJK8RpUE58dPUABJ0JaCE214O
dQGwY0ZsqzDDZ4c2R0PWK8xkyADVmJ38wNgXq5RpMfbIySJxrFTQ8htVtsUhE53D
j48glktNZO/q+arIJpBPdJD2GT3zwnEIH4klKmslDalfc+ZS6sjCOcDUVMLSUoG7
CNWWthtxWCW1AN4kPzbBeS2Iqj4gySStD0k5cpb03axvwYEsyx/gCY6r3TyCP+fe
DVllR9bFrZ3T2mdjcHCP4Idz2i3buw==
=YVij
-----END PGP SIGNATURE-----

--yVy/56adD+Q+P3oK--

