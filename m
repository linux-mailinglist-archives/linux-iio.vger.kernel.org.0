Return-Path: <linux-iio+bounces-16369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E106A4E7E4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381FF8A5328
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26328153E;
	Tue,  4 Mar 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH8zje2s"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF36281518
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105311; cv=pass; b=Bys109HBngIRje+HkQCSqvCnUnahjCQhAh4vOBlMwBwd0ExN2C9wRiZcck7NsfZlkEpQyxWE2ayO3tiskCN+K6gVHH1EWdqoCfDKx3p6VepIHpXWYElZKQrmh9HTapUj22udknLfcYq/5jOqMUmUjXsBG2pJ9bIAsT0DmOmKr8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105311; c=relaxed/simple;
	bh=K4tBMQnaHMfsnGq5yH+1iVycU2fZaA/iBWkZbbp1u4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9AspFLVi9O314mNTHeeLaHfDu1aDxigPKYdsq90LLtIV4KzYHX1IMeRaAHGuxDjcIRW0WXiyZkpZNnwl36CGD/UToAQOdW/PPhmhJqDFx+acLI7mx1mDApXsyGhUA9cpjg4TNAALW+qFH4u0oaBniti1ciJZaWqLPlskbQMmtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH8zje2s; arc=none smtp.client-ip=209.85.208.175; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id D822440D0B9C
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:21:47 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gqy1mSFzG31q
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:19:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C826441898; Tue,  4 Mar 2025 19:19:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH8zje2s
X-Envelope-From: <linux-kernel+bounces-541587-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH8zje2s
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id C7AAF42731
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:34:30 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 5C6482DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:34:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE89B16895B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E41FC0FE;
	Mon,  3 Mar 2025 11:32:27 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFB1FBCB2;
	Mon,  3 Mar 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001543; cv=none; b=j4/X57bx+BBzCgr4hvEydixhSZf1F+kVxxViQnSaFB5lKcpewuSfDyDaJOxCHRbWP4iw2tR6liYrslzqooYFVZpSHQxW3LP8QyhPtTC9sS9E9fKeXVtDQVxipCQKMqcN+fLO/lJKdoxzvTR8fcyWLhHBvunMfNHThFtfhN7z4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001543; c=relaxed/simple;
	bh=K4tBMQnaHMfsnGq5yH+1iVycU2fZaA/iBWkZbbp1u4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNrPAYAgE/5uG2YLCN0bkM2G1bmIYnT+NkzhU0gH5bRBCpH+S+3j2ToAM7vgOQUovlTq8KefApgSGDioIAsB/Z4hFS/zKZwkWZPGJHXEWkBI4eRJQspAjMhuQkdrvGuKuK87I6wqfYPx3iT0ZaNG+XVRcdDmtR4WoEGDcpAuiaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH8zje2s; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30761be8fcfso46194801fa.0;
        Mon, 03 Mar 2025 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001540; x=1741606340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtBChGL3VlgSfzXhFjLcRU34BzOSwfeij0YOo0Xrd7Y=;
        b=SH8zje2sTlfqKLeUR/1haXzh8LK1kzFNkOpjPniIdqHzpuJe+0xR+erbcVUaQdi4s4
         V5Jrv1u9jpu7IzWVuuKbnUvPNJGs5MK6nLea9bd/kMEYnuTccGR4proioD8YWXonFvRt
         DRShMlKWDLa8LwsYl4q2q1MgdCo3iBsnftdql9L11TmcIpSEouoRAeVeJ+5jLyUSG6Re
         L71hp/pu88uUD8a29YSfQ9yD8lzfbt7O4pESKkJevFVIewBMfKQXdi08FaEE+qsSe5Jy
         qCdikF4pR5U0MSZxu9LG2JCy8qVoHt6TwLal1NLz6Xev7SEI7KP6P4XFgaMW2p5swQii
         RS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001540; x=1741606340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtBChGL3VlgSfzXhFjLcRU34BzOSwfeij0YOo0Xrd7Y=;
        b=TlEcVMMBb1iJ24zCZ/Z/0dmOdyT+Iyt6I7MPqc002Uu7+esAVxsUYgei5IR7oGcsur
         oLO51cy95O+nkVvQhO6DvZWOYcrKFTly1xP9ucn602RHI1RVmFLjOszE8w/pWF/6Etrj
         t9zEXSg4TUoU8yUVx1FH98sSidloOSsACiI4i2soWEHSWFhP4cXJBdRGZJ5fA0UJGxWS
         I4KvHn1l6Yz0Ebp6FXdAUrgRGuQ1W98vtkzoM8+oyO/CqcYN1klLwqUL12SP9OQb3Su4
         FAV3hwK+72/pLFBgw5VYrqCG0et/LAlhsGjEC9zADyGBN3WKC7dyMSc1APEjLJpgiERg
         fnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUgXzEFw3ICs3q/tCu3/OD68ncdkBfir4JBJwTcOnWlXYEUN/1kojIFaErHZwSmr7+a7GdSYrY2wIJK@vger.kernel.org, AJvYcCUz+QrAha8q9uKmxkAqJU4jOSQsYnhHTaLk3MTjGJNyW0jieHxpVfRn6mr1DZOcqWGwqtrjITnRZVB4@vger.kernel.org, AJvYcCVGpW/yzvssNlqacbvS3yGrtROFrj/HlQgMqxU5GElKS2zlO2FjPoCKmhbsMNYXV7Eb1xb5nJ77Yf5vGq0u6ABcWlc=@vger.kernel.org, AJvYcCVbA+/j8Z3nm4TcvAsROD68zSmfgd30butLZj7f2Uaq6kaHZxJ+YLbMZo5wqItm74gBtC5s/jXP+GVi1Q==@vger.kernel.org, AJvYcCXTpa8b8qc5OpVGxjzeoIt7un2FSyRIKaVgtljOHMmuOyqAE+tKRgz1u1RDGIrL/LQRQ9kXMeND1hMObQux@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpLtYmBO5OurFOUm1fzkfiXiAvR/yUcMBdVg7z3K08iAFS0X0
	BjxurpBh3WIx9VSP2dKcndCjsv4P3T4oKoDNFDaTWkzGBihlDZee
X-Gm-Gg: ASbGncs3uwBZDtD6fR6dKPFy8I+mGrAc8DramoIJVOF9Ghso9hMCaWPdhJCpIhOH+s9
	XRKUMsVeamuwIr8r+YS+1Fknxw2sVyIu9SsB3QkXjHehIhmn+tIhlFdiRSn7H+NK8CZGXuGOFue
	VVlQVte4o4qhgsD7R/q6AA7AYKu8snS+vSsJozX6TSFB9XimDML5vbKkPLIibXz2561y9+Vz0hf
	ftMAGZs8YQODsIGn3EG8FPu/j1IGUUzaGEqKZ4+5AFfvJfdMHoQ7BUQqiNCsNChg2t+pqxiFWO6
	vSRsYZb+fauiD7GxSJu51lDig6MT9MmyubSWjqxWOowPT/ov2gqmWBjBi0Z9bih3bIs+1xI2iDe
	HG/KDvIsFc6Q=
X-Google-Smtp-Source: AGHT+IFLEDrP5BMqyi/QYjEYMZ1pICg9oq6il8b+Tt5IsjAulwVVVhkiZFRC9rVJrJAglId4UhYVLA==
X-Received: by 2002:a2e:bc23:0:b0:30b:bf18:91b2 with SMTP id 38308e7fff4ca-30bbf18952cmr9389191fa.3.1741001539821;
        Mon, 03 Mar 2025 03:32:19 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bbb7f2b69sm3425911fa.29.2025.03.03.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:32:18 -0800 (PST)
Date: Mon, 3 Mar 2025 13:32:12 +0200
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
Subject: [PATCH v5 03/10] iio: adc: add helpers for parsing ADC nodes
Message-ID: <e71c63c2f61135f9a8c7884525aab2c48f1e84c2.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xqvnd4i6gfW+Zz1G"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gqy1mSFzG31q
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710035.34288@ClNiLqYAbWbhATr+Q4M/Eg
X-ITU-MailScanner-SpamCheck: not spam


--Xqvnd4i6gfW+Zz1G
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
index 000000000000..7bdae5330224
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
+ * @max_chan_id:	Maximum value of a channel ID. Use -1 if no checking
+ *			is required.
+ * @cs:			Location where pointer to allocated iio_chan_spec
+ *			should be stored.
+ *
+ * Return:	Number of found channels on succes. Negative value to indicate
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
index 000000000000..403a70b109ec
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
+	return device_get_child_node_count_named(dev, "channel");
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


--Xqvnd4i6gfW+Zz1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFkzwACgkQeFA3/03a
ocXuBwgAuRQ/tlZSOf6SLet+xxTrkc8Ao08JwLFpdY3kORBcf8Syd5R2/3ALMsmM
jcpwo1ZbsawPz+ypEbE1c9M7x+L49rdIE9F2DYUEGzqcemWfaeyDatgytn3VKbz6
x/Wq961wfy5ntkyxrdNlcV5WNSwIFNNt6qH5O3SwGM63yVjjyPlthmXvEVZYRS0e
ujDFFqBGcReOBDTNpG3TV0ozv0xFZQpmBPDIyBE6XWQK6JS85fy4zQ4HltAX8gfL
bfXcPg7WnKHLvy1bQLVtF8JqyckD8QiqcT1fUznqWpxfJ7EkFhvWULWXLB6eKQYR
fmvISMGCkMrTFeC6oaojYKHIbwlA+Q==
=FJAk
-----END PGP SIGNATURE-----

--Xqvnd4i6gfW+Zz1G--


