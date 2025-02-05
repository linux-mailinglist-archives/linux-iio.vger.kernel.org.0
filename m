Return-Path: <linux-iio+bounces-15037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15565A28BC4
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB91168744
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D4139D0A;
	Wed,  5 Feb 2025 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI5WxaDR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B886AE3;
	Wed,  5 Feb 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762501; cv=none; b=fjeP8og7Z88aGlrKrS0tDscazASKZv7JdmCvy9COQufson/BzNXgBFBzeHQgKBt9V2lwQdRWyqfNyUF+nWs27rO7Ter5dCYOph3aFvuIA5/N0U+AcUi1FlBDAGOBnbY6rng42mAsdczTrFmlUE5uThbAq8EV6U5scmlNQoOTLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762501; c=relaxed/simple;
	bh=I3ELP6WKhCj90FnQ9TAbt8egoArd+2vyUQCm1PuVrHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXr3SB6+jVrp3Y5ExZwqRCmmTPAW0f9FQwtNkvF9u+5YtHsILKkh8VA7GZxxGW+WnnAyrX9jOwm+/WGaZZqYkaxjM64I5EBwJVNcGHjnq9MtgvWeysIW6PEoVZiFCDfI0mNTIE7edw2+dBph7tdttAnh/wbzg3jwCC8Rlai9MUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI5WxaDR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543d8badc30so7142802e87.0;
        Wed, 05 Feb 2025 05:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738762498; x=1739367298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qx6DDwoqjempv42Hl7mNejUZxlTkzRhJGgmaA6yW6YE=;
        b=GI5WxaDRP5Mm0bt65sK3dscT5JC3VRazwkbYhyk7JIUBdPC0VTHVM8p/PXznowethJ
         8RNaEZS/pU3DfCGJJvN8jEaEVTbLZyC6hcrd9sLgtCIUVMwSNZkt/CrPUFBZ68SadXR5
         pLYBYop5NQQOQy6uTolBabRDoON6cD5ZzplNyj0AykNVK8XhB9PXnn82jr/Lw58QlFAC
         bU0nkcRP81v+ezRPDWWp5Xc8LQaJFK1Bk4FZQKgS7ZTKLFzsP9fyCvojae9VtWmnomb3
         OOvRaRK9+5Qtswmppuxsei+vvyqJJ3AFuStmuHGd+0W0Hm96Pj6Q+/0QU4MEJyga5D6b
         F8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762498; x=1739367298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx6DDwoqjempv42Hl7mNejUZxlTkzRhJGgmaA6yW6YE=;
        b=que+I9mUC5EnuiUUjvm1hBWQXaOR7vFdUQyEWvpumndRlWqlTyadBdZQqYYOmCq2J6
         vFcBJ9PDAoF183JhfD/lIO5VGk+tF+UyuMnkIqNB/2JjfMxOMS0RGA+O8Eeo20CTAMv3
         a0ppVWidu0gyQxDrq2mzJpFn1jqDZjTyJxsuHHkY/EX6Ep9qnUIJ8Zgwuej6IKlMzq2X
         B+SFfpcWw+9VZP8QhRaT3+3WcwD0izt91BmkfiIfjGmcAu1hOLDuGCrEHxOgqoUBRHY2
         KVpoQFgD1IyjrSYF8/pQl2DyZqhxOtre4KuWlP8YjGtJjdcR9C7UbGUu5sdU1NCLDMt/
         W6jg==
X-Forwarded-Encrypted: i=1; AJvYcCUMcMlov9haeb2uGnipc853O4g1FE/xXenOmxng6xgwSgnYkr9mKCRb+whdrhRqEDy+69ICDK1fx9n6@vger.kernel.org, AJvYcCVMkVh0a2j/z8kOMZEHLY3VUop8GW/yCZ64/ae3RLYjUit1mK7vQ2ZSLtC0mvkmmJSwZCj2KIhmyBYR@vger.kernel.org, AJvYcCVU/bYUvfOnNFut7nudlToHfBcTnzSRTWy8kKipo09WBPo782JK7cp4qV8OFnYcLuRe/Qug3LbM+XNJQSZ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yf5K+aA5oabzL6r8WOHuInfTtuaQmid2fLlyAU3NEcqGoB+Y
	sFX8tcFbto64iMdnlGxmWxqKHsT1X/V/9vQWSNgoiKDtHolRCJfs
X-Gm-Gg: ASbGncsqON23aUOVao3AivQLlI/09+Xd2+4qe/+sP0b0sfL4N2vO4asJ7YFAlY/RKB/
	EGI2ZfnEDX92sEuPpihXH7S4+qqCjFEZWNqvoYEU+wpLNaNx29i90CbIZ9XGC7RaYmrKnPEJ/6J
	rV2GXNvFLWv7JOGd3ZWzZvOjEMgjYDsbfm0W5QXsFv1oD4xDKOkBvsz+8HBlal+d7tcQ8nCpEu3
	jie2NQpA730o4ZB5gAyvTGPwl48dD97uIuk6O/ujEMetgmht5YjEzAqzVrMo4FnjO7Gdu3BEzzO
	jJue00RLRPkJgDWNzA==
X-Google-Smtp-Source: AGHT+IHrMLZnut3O+oPCnEljCCSQaCZaZ54vyEmHcxAzYTO2GP6CKvyfLOicpmkjYj8Lzc7sCNqYHQ==
X-Received: by 2002:a05:6512:2398:b0:541:1c49:26a with SMTP id 2adb3069b0e04-54405a72440mr993468e87.43.1738762497439;
        Wed, 05 Feb 2025 05:34:57 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebeb7d46sm1896268e87.190.2025.02.05.05.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:34:55 -0800 (PST)
Date: Wed, 5 Feb 2025 15:34:51 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iio: adc: add helpers for parsing ADC nodes
Message-ID: <337895af7418a8e4b20b5a9322344b68082508ae.1738761899.git.mazziesaccount@gmail.com>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MwgNILorLCN7QnDM"
Content-Disposition: inline
In-Reply-To: <cover.1738761899.git.mazziesaccount@gmail.com>


--MwgNILorLCN7QnDM
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
RFC v1 =3D> v2:
 - New patch

I think it might be nice to have helpers for fetching also the other
generic (non vendor specific) ADC properties (as listed in the
Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
have use for those in BD79124 driver (at least not for now), I don't
imnplement them yet. Anyways, this commit creates a place for such
helpers.
---
 drivers/iio/adc/Kconfig            |   3 +
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/industrialio-adc.c | 151 +++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    |  22 +++++
 4 files changed, 177 insertions(+)
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
index ee19afba62b7..956c121a7544 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_FSL_MX25_ADC) +=3D fsl-imx25-gcq.o
 obj-$(CONFIG_GEHC_PMC_ADC) +=3D gehc-pmc-adc.o
 obj-$(CONFIG_HI8435) +=3D hi8435.o
 obj-$(CONFIG_HX711) +=3D hx711.o
+obj-$(CONFIG_IIO_ADC_HELPER) +=3D industrialio-adc.o
 obj-$(CONFIG_IMX7D_ADC) +=3D imx7d_adc.o
 obj-$(CONFIG_IMX8QXP_ADC) +=3D imx8qxp-adc.o
 obj-$(CONFIG_IMX93_ADC) +=3D imx93_adc.o
diff --git a/drivers/iio/adc/industrialio-adc.c b/drivers/iio/adc/industria=
lio-adc.c
new file mode 100644
index 000000000000..366e4c8eb6c7
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Helpers for parsing common ADC information from a firmware node.
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/property.h>
+
+#include <linux/iio/adc-helpers.h>
+
+int iio_adc_fwnode_num_channels(struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *child;
+	int num_chan =3D 0;
+
+	fwnode_for_each_child_node(fwnode, child)
+		if (fwnode_name_eq(child, "channel"))
+			num_chan++;
+
+	return num_chan;
+}
+EXPORT_SYMBOL_GPL(iio_adc_fwnode_num_channels);
+
+/**
+ * iio_adc_device_get_channels - get ADC channel IDs
+ *
+ * Scan the device node for ADC channel information. Return an array of fo=
und
+ * IDs. Caller need to allocate the memory for the array and provide maxim=
um
+ * number of IDs the array can store.
+ *
+ * @dev:		Pointer to the ADC device
+ * @channels:		Array where the found IDs will be stored.
+ * @max_channels:	Number of IDs that fit in the array.
+ *
+ * Return:		Number of found channels on succes. Negative value to
+ *			indicate failure.
+ */
+int iio_adc_device_get_channels(struct device *dev, int *channels,
+				int max_channels)
+{
+	struct fwnode_handle *fwnode, *child;
+	int num_chan =3D 0, ret;
+
+	fwnode =3D dev_fwnode(dev);
+	if (!fwnode) {
+		fwnode =3D dev_fwnode(dev->parent);
+		if (!fwnode)
+			return -ENODEV;
+	}
+	fwnode_for_each_child_node(fwnode, child) {
+		if (fwnode_name_eq(child, "channel")) {
+			u32 ch;
+
+			if (num_chan =3D=3D max_channels)
+				return -EINVAL;
+
+			ret =3D fwnode_property_read_u32(child, "reg", &ch);
+			if (ret)
+				return ret;
+
+			/*
+			 * We assume the channel IDs start from 0. If it seems
+			 * this is not a sane assumption, then we can relax
+			 * this check or add 'allowed ID range' parameter.
+			 *
+			 * Let's just start with this simple assumption.
+			 */
+			if (ch > max_channels)
+				return -ERANGE;
+
+			channels[num_chan] =3D ch;
+			num_chan++;
+		}
+	}
+
+	return num_chan;
+
+}
+EXPORT_SYMBOL_GPL(iio_adc_device_get_channels);
+
+/**
+ * devm_iio_adc_device_alloc_chaninfo - allocate and fill iio_chan_spec fo=
r adc
+ *
+ * Scan the device node for ADC channel information. Allocate and populate=
 the
+ * iio_chan_spec structure corresponding to channels that are found. The m=
emory
+ * for iio_chan_spec structure will be freed upon device detach. Try parent
+ * device node if given device has no fwnode associated to cover also MFD
+ * devices.
+ *
+ * @dev:	Pointer to the ADC device
+ * @template:	Template iio_chan_spec from which the fields of all found and
+ *		allocated channels are initialized.
+ * @cs:		Location where pointer to allocated iio_chan_spec should be
+ *		stored
+ *
+ * Return:	Number of found channels on succes. Negative value to indicate
+ *		failure.
+ */
+int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
+				       const struct iio_chan_spec *template,
+				       struct iio_chan_spec **cs)
+{
+	struct fwnode_handle *fwnode, *child;
+	struct iio_chan_spec *chan;
+	int num_chan =3D 0, ret;
+
+	fwnode =3D dev_fwnode(dev);
+	if (!fwnode) {
+		fwnode =3D dev_fwnode(dev->parent);
+		if (!fwnode)
+			return -ENODEV;
+	}
+
+	num_chan =3D iio_adc_fwnode_num_channels(fwnode);
+	if (num_chan < 0)
+		return num_chan;
+
+	*cs =3D devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
+	if (!*cs)
+		return -ENOMEM;
+
+	chan =3D &(*cs)[0];
+
+	fwnode_for_each_child_node(fwnode, child) {
+		if (fwnode_name_eq(child, "channel")) {
+			u32 ch;
+
+			ret =3D fwnode_property_read_u32(child, "reg", &ch);
+			if (ret)
+				return ret;
+
+			*chan =3D *template;
+			chan->channel =3D ch;
+
+			if (num_chan > 1)
+				chan->indexed =3D 1;
+
+			chan++;
+		}
+	}
+
+	return num_chan;
+}
+EXPORT_SYMBOL_GPL(devm_iio_adc_device_alloc_chaninfo);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("IIO ADC fwnode parsing helpers");
diff --git a/include/linux/iio/adc-helpers.h b/include/linux/iio/adc-helper=
s.h
new file mode 100644
index 000000000000..3801b2d17517
--- /dev/null
+++ b/include/linux/iio/adc-helpers.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* The industrial I/O ADC helpers
+ *
+ * Copyright (c) 2025 Matti Vaittinen <mazziesaccount@gmail.com>
+ */
+
+#ifndef _INDUSTRIAL_IO_ADC_HELPERS_H_
+#define _INDUSTRIAL_IO_ADC_HELPERS_H_
+
+#include <linux/iio/iio.h>
+
+struct device;
+struct fwnode_handle;
+
+int iio_adc_fwnode_num_channels(struct fwnode_handle *fwnode);
+int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
+				       const struct iio_chan_spec *template,
+				       struct iio_chan_spec **cs);
+int iio_adc_device_get_channels(struct device *dev, int *channels,
+				int max_channels);
+#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */
--=20
2.48.1


--MwgNILorLCN7QnDM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmejaPsACgkQeFA3/03a
ocXF2Af7BrkEy4+kLdt+RK3pXbGOY4bQ2DhyM0UxUE+dFRYvlNYrvDhcATss0C0Z
dnOVeUzoNB3V1GLilmvgwnWaUoMpOUUDU4VCjmmzw1GuqHYKI15y+Qg+EpkCMWwT
POx37pXDMAwi9OpnalajCMqmU+MEQUXfBmjV12bHKf9ubMTtzVXYzULcDT/FTGYf
EMU5iBE02SwmzY8LsG1qfCLdvZbujOkJMEpNVbcZ+uLScGamwt3aXVKxMpKm5fvr
K60jRS0HPPlu5ipmx+8WeBSlT0ffBHO1F3kFrRI1YgOsB+fSg0CwuVor1leOtVmh
blKis3xK6yOIY1oURIeBjbo2ajhEiQ==
=oKC/
-----END PGP SIGNATURE-----

--MwgNILorLCN7QnDM--

