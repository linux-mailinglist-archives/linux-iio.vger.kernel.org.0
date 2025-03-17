Return-Path: <linux-iio+bounces-16977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B76A656CE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728AF3A7E9B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E2190068;
	Mon, 17 Mar 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9qKlCxg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD918CC10;
	Mon, 17 Mar 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226659; cv=none; b=e52TL+b+ZgKx/bhR6mdMrOAUcCs9L5YsQrvObosRf/ULsrt5fGhmLkjWlHr1bRt0856PDSV7kdxAalWHgTlhXXm6E+trsg6hme7WAtOY/R4cUe6E1hAM9dQS0CV0s1MKeDZpwdE15AD4U4As3WkGzgRtTMqBNdsZTbAxpdYs6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226659; c=relaxed/simple;
	bh=EYqnE3TxIdwal4Cm/7kgvJ/wHUh9YOULf7xU+ZQ1paA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG/vaiGH8l9q2jIx4yJB2T6JB2w+mIKZgehQbsVFsaCx1cNJVfGGHRw1NzztkZ3gbJ90BEZuIFyyv9uuwmJSjglj1PmS5wuqqd3nrKwpocMCEjROJdvIPzfgzWlJO2Lkh63Z5J2l93wDQbXHgNYbjKPbbtDpRM8Hv9fOH5tcdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9qKlCxg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bef9b04adso49937181fa.1;
        Mon, 17 Mar 2025 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226656; x=1742831456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ii7b0KSEIGWdGVz920b6yiZTvzIrS7hqW2hr3ua9Jtc=;
        b=l9qKlCxgeMxrTj2gwhg4WnCqu3N7zSqXMkmM5j6b8Ek0QWsjipJWuMb/Ln+Fw3EDye
         QFifyDYlIJGaCERKUes56lwiA+ZAFhmpoVEZ4tNoHHZ7/BCOyW923K3+9s+nM9XsNHaw
         lLtUl+ih1NOsIucz0fO6foGzho0vFIFz2y7+VTz6AImlBBZtKMk3J7PV52nTpOIxELx+
         41YooTbgnv8/hFr4rOKl4TDDAauOWWl98zJ80H29L0icJcVbnmlFQWZAlLRgfb8KbmbT
         7yI2QW2tngKLdY7WFgRZDE2n9/XlOZscyYp6RbYuy7h3zo/rj4v8wziK3rfcBUSJNfMM
         I/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226656; x=1742831456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii7b0KSEIGWdGVz920b6yiZTvzIrS7hqW2hr3ua9Jtc=;
        b=vDAa/i70f+Mq4MKTby/NyyMUvG9o0+tpq3WiU/ijthKXrvSqQ9nT1laADvNc++r19x
         RrisPJ1NuWSfTxdDMKryG0SKLI0JfH+vUkMrryRBSydPJADaLwNk2Zd3PCtJ6bwInRUF
         +us7rrrXXa9GLcuvUtXIsoVlrTl5uLxn7ptsABJUIJbM6ejljKBuyjWm2OfwgIAmrGER
         LtGmTKsum9XM8C3hKTA4YBTCrLsffKmM/c2d7HqTx744tczU7KtJfLI0npxoy5SH5MpF
         7Ld5QguioRjtmJhueQjY+1F7Ke77pAvwuqtQAN8cuVL8479fxMoxdJonfbQPhJYb8LdH
         jJBw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQxXXbpFpsAe79G79Z3NaGwJsu6QnsgAl08GdKwYVTbYacDqLo31rXGYjpWs4AAJGs0T/tB5+/BuT@vger.kernel.org, AJvYcCUwDVtYrry5andfK/IZ7ETm2YHH01RxZ0jcbbkUIssqHg9ffB92GxEiWDuDAM45kWbWxuWXwhgTzD4PGXE9@vger.kernel.org, AJvYcCV8oyGh+68acWo9WVkbCE/WG2vb0mKSeGjbLSM1IOi1PPZgcbGkpiOokx1upJsA8C1EXSTYPZ7+457h4w==@vger.kernel.org, AJvYcCXkOACunYO0wcoPEUMRinhomby4FfhadR3UMmMOE5f7OckTQLYcdKfcoY7lW7FiRE2lMDUJIwDvPKgF@vger.kernel.org, AJvYcCXyhPvSaJEaErY6NeVrm/ADrVGQqHU1KCBSWbsiIvBb2D1MmWHIBIwVKyX48QToj4jiIo1XI59yIdOgSVmTYzE0O8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFLRBrJSOHQupFLi1ITUvDPA8ih9p2moSA5m2rx4w6HDhqw2Eb
	ZArJU9yajOx7iCFUy5O+RpY7hM55jP+rVJzMj2cs2x7aqS3XE2T7
X-Gm-Gg: ASbGncvS2fr5uNqSAnNBGBpy7fxOGAVvpuA7Pp8AbQs2c6Y95DhhyCkjo2d8GQQ5aEz
	plJfXRFyQnbg+EdNMfyMN0r/LCXZw3i+qQg3CQ7xSt+BPtSK+zIJ6dLYKy7QKi/1NbSKTTKz/q+
	6llsiHbyxNqWPnSed0i/FzUW5K1AJhPHYz40S13YE++G21rqkf+3zo5SjboE04Le3NVP5dMA2Cz
	dOYGeAJFhlxU9uoC30RZdRt4O16PP381kbBZW8DqiqsdKkMwMNR5ZSg66tbWTvedXMy6hy50ZT4
	lXYrX38iFOMa7qFPVR0shn8Z/wyEA7yUTI8aABHpoj5BMh4TFbVH2QQQWRdDyA==
X-Google-Smtp-Source: AGHT+IEEGvh3xBWemsVzH4wBXP8yRpV5NjdfvJKnT0Q5uYgr5FPXWVoYQ+4hCSjx/lxflCVclNNDFg==
X-Received: by 2002:a05:6512:2823:b0:549:8e5d:a84c with SMTP id 2adb3069b0e04-54a03b78224mr236127e87.2.1742226655332;
        Mon, 17 Mar 2025 08:50:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864ed4sm1385343e87.128.2025.03.17.08.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 08:50:53 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:50:49 +0200
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
Subject: [PATCH v8 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <e556f152a9cff2ff61e7b7a4b42feffb400cb1f9.1742225817.git.mazziesaccount@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VenAnZ5yOArFOc9Y"
Content-Disposition: inline
In-Reply-To: <cover.1742225817.git.mazziesaccount@gmail.com>


--VenAnZ5yOArFOc9Y
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
v7 =3D> v8:
 devm_iio_adc_device_alloc_chaninfo_se():
 - Treat all negative values for the max ID as 'don't care'
 - Return -ENOENT instead of '0' if no channels were found.
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
 drivers/iio/adc/industrialio-adc.c | 82 ++++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    | 27 ++++++++++
 4 files changed, 114 insertions(+)
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
index 000000000000..b4057230e749
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,82 @@
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
+ * @max_chan_id:	Maximum value of a channel ID. Use negative value if no
+ *			checking is required.
+ * @cs:			Location where pointer to allocated iio_chan_spec
+ *			should be stored.
+ *
+ * Return:	Number of found channels on success. Negative value to indicate
+ *		failure. Specifically, -ENOENT if no channel nodes were found.
+ */
+int devm_iio_adc_device_alloc_chaninfo_se(struct device *dev,
+					  const struct iio_chan_spec *template,
+					  int max_chan_id,
+					  struct iio_chan_spec **cs)
+{
+	struct iio_chan_spec *chan_array, *chan;
+	int num_chan, ret;
+
+	num_chan =3D iio_adc_device_num_channels(dev);
+	if (num_chan < 0)
+		return num_chan;
+
+	if (!num_chan)
+		return -ENOENT;
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
+		if (max_chan_id >=3D 0 && ch > max_chan_id)
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


--VenAnZ5yOArFOc9Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfYRNkACgkQeFA3/03a
ocW65gf5AbvmNtrufWqElUg7CZxI84RdeX/glpqc2aCI9PJQne+eoyxWfh++mFM4
xNKQwxwyZ1w2Ot92onGIm9UK6h0V5qWHCNm9hQPIoQkcS10FfN9Gg/nQ0lsLchqI
5mlBpkqBW5IDmqiOh9jOsDKoIbsqBvhEBtmM8spqYJhJi+DE5bzuNN1TMSw6OPbt
Ry+TZuyfY0sW4KVXhNwhukLYeopM9kRj+YsaUIVJD4LJA8vMfGFamUk0QEKq6/qD
ztSJugAbEaIyA9U6cLdTS6Wc3VffunzYkfykryaBnIw5JsQDY4asstkML0kkzU1U
6K585gt1EmU0daBBQg+2GR2qnqBvfg==
=v3IW
-----END PGP SIGNATURE-----

--VenAnZ5yOArFOc9Y--

