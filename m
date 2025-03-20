Return-Path: <linux-iio+bounces-17140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB6A6A12F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58907189EF24
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656D221550;
	Thu, 20 Mar 2025 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+xe7+7e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BF2147F8;
	Thu, 20 Mar 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458886; cv=none; b=e8ErPHWUuOCST/AM4wOIQypEd+7tkcJJ3Ewvf5RaduqLHms+BzeEv/FmCRdXJz9koO4MoxyrGHRBny084Vwuozy/EgrAR1yT7mHD+pUyowq40/tOy72JAeEhD6aLbiLSVLuipXWsJIq0pOGwV+uNvKEsrSewGHsTPk7z7rwO350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458886; c=relaxed/simple;
	bh=5c4sx8lxPu927ub7j2zSMTttb+wbAmNDHYG9xeutmh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZQL8OxpWYOE67Fe3Geax94l7lieTrhbCxMmwOe5m8eD79lph115v9vtSI313unjvJTmHOYCSpg+5hSY+CEYU5SvUX5h51Askku1iE22KhgHs3TU9g4cFjyjk15pTUDWyh/arZMPmAIdtsbmmc9ibuQPWsGGJWgDJ0sX/tPfP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+xe7+7e; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54996d30bfbso508326e87.2;
        Thu, 20 Mar 2025 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458882; x=1743063682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh/aY3YPLr128eeDB6TiMpExF6OYM+MKvRvuZdF7Mjc=;
        b=S+xe7+7eXTuEo0pU+j7zm6k9c5EMEvEewQpYbhlY/2o//th+25BSBOx7x3bj4TR5mA
         qUEG4uN0ecnzz8mjA/0d3jbfy/A22QLAiIytlzfM7iNcZsWG7V+ykUlwsUR/VJPDJ3G8
         TG9lQhp4jmSSj0ZerxjH/2NZ4dOBlyKoiWpuyLOBku0V566/LmOba6Xj7Ie8SI8VBTzC
         OAHWmA0+N49FXgLGmw9rjutqZxH1kug4A35uewyqW5EmphVl1BWCrl0xmqWfWkCr+y1s
         8UsQO++aKYCFpjoD6LrDvla2psfSxRvyc45rL2wBaaYEow+CTRke8fyFceyK+BpuA0q0
         GlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458882; x=1743063682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh/aY3YPLr128eeDB6TiMpExF6OYM+MKvRvuZdF7Mjc=;
        b=MJf39sJ6mxfDjMuq7THE4DN+8TCgUQ5JpozizZFlbBi71vVhFQ+qpK43HhGTLBJnZk
         U62zz6i6vvCJxpYEiIDqt0CQl1RR4yr8dmQR0cWKnUhMPlPNYnAgOQukyevW0n5af7au
         sE4CS/7OZ0kcEFY7Vf3gaYHFOoLTAb7KpxI79dHiG8W5lS0xzEMtvyCkXAKmsvt57h1M
         WMnveNJBcyTM4yqytwI0ntNQEsuFVjTXif5YQejxd4i626KsRqm4344iA87gUzxmNs70
         kqYkgRlTYPvwGW5Gi8bdP3vKOhXYOV8l+VRJMUxfhA+fNuLoLtRf2pHy7GN+Av3KH+DU
         wkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnE0UgBHQB0s/YJjVhEGcxdRY2+yOIC2aiTo7wpVHHNHhtVv9ZY3ELBm3oxDvNqYMqVi1RzFGbq3oPTdVb@vger.kernel.org, AJvYcCVzSbb6jbOg7mgETqpOp9TYoEPJb4ysZcNgK1ht4qX35pTA/LzjYXMTcVSZTA1lTifdPm7OjBOPiGAcGWLedqNxROw=@vger.kernel.org, AJvYcCW44QhvdpyFa52B7GlqrJjchb1qoZhUnQK9jH4cIyQDHfSpz1u1EY/oAl0BG2F12aOniF386M/5l9Qc@vger.kernel.org, AJvYcCWhonrsFtlPCenLV51H5VCpGtH+mFmGVWXRB6Ywa0hxzoAlfVK5kEIlDCWZdEnTHaH5+hEtvm3Rq/D7@vger.kernel.org, AJvYcCXn4SjmsQI1uDQC5LWG+hvJal6JIGubNteWyquAnv26Z53Rp7sqN4xgHxOc5DcerguF9g1ZBprPQQE/oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYjFxBDK/tB0TvyLLIWvwflnpIH4RX2DixkY8MrQd/v5+8BWn
	8MKk14xyzD0rBREYALCIUR06CVf7Eg4k5KExMnn7ljxUmhH3jCBJ
X-Gm-Gg: ASbGnctXNUsFDWQWA5oZ/89bHLgA0hIWFuGWU08UGzeJ28x17kafLXAuDF0yEaoCIcB
	Avyp/BxutOC6x/ZOldJk2KRtNSQrJ0FAPvLFCv2gdXwQ+TCvDxsdzU7UVslEcQxb0PtXsfI2OWU
	OCrtSe0ihiWFi2dGuh9vzkaATUJdZE9DL/c3oqlbamcKPDqgRDX0IiIhgGyacCOyMIx2t9dkTzW
	V1Njh4890ZFmuKSIbwzgubYaWODN8ca2Psba5pH3DZ01P4yfBulDzGWrRTYltRB6LABvlsdmEsD
	L2BiB5n+SgNOwzKHcMP/SS69VlwBoy46zvRA2PFbS9mnuOD2HmU=
X-Google-Smtp-Source: AGHT+IHeGKxlOEHY1CvTb3t+asOzrM/2sZpLzoi3Px7HFPqXXPcThNk4Cky/x2Ts6rByEpk8KRr1cA==
X-Received: by 2002:a05:6512:304b:b0:545:5bd:bf42 with SMTP id 2adb3069b0e04-54acb21aca9mr2189060e87.36.1742458881710;
        Thu, 20 Mar 2025 01:21:21 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba885129sm2145851e87.184.2025.03.20.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:21:20 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:21:16 +0200
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
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
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
Subject: [PATCH v9 3/8] iio: adc: add helpers for parsing ADC nodes
Message-ID: <299f990caf58d77cc24200e8d75655661f16050e.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jd3Vv7o0qGxJT9tp"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--jd3Vv7o0qGxJT9tp
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
Revision history:
v8 =3D>
 - No changes
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


--jd3Vv7o0qGxJT9tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfbz/wACgkQeFA3/03a
ocX4ngf/T0NbTd3rDDggxSnvJxHt0vz0qqlflnkgBtWRvUrP1uMi0zzaf6NeglAl
9kiKhEanC97PDw0KPr+4Xa1zpF2EjSkeH0/3Nt1xdm7lSxduKMe5zt0WAC8WkOXj
2VJ6967Zobm5s2sZ9xr4LQDX7xZEUEG3zoEBxKSvQ6Z5F99fpDy8gh8AfjfyXgIT
c25rOyqQK0jwmlIvEkmTFaBngHTzJY7h+M/PwBoMBwQkr8xViKJf9b+1qzPfk3Qz
NQzVYp9CFSSgeWpVOb8R/cwSrz4zLcans+ETBZvNfrXH0gHc1w08hQp4AFZnEvMg
Uqb0iXUyMPX/qfdd9opXWAvLRKD+lQ==
=br7A
-----END PGP SIGNATURE-----

--jd3Vv7o0qGxJT9tp--

