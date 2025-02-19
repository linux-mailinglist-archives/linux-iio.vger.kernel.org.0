Return-Path: <linux-iio+bounces-15779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F9AA3BE15
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0401F16A74E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAC1DEFE1;
	Wed, 19 Feb 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3J4DYOy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD821D5AC0;
	Wed, 19 Feb 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968239; cv=none; b=Td7rKXGhY0ArJuH3fH10SjJNWsJnqAdiG5dVuwBF868OQ+9ZpZ7LHiB2y/nEW7prveD/f61uXbxkcCtHnpexgPlbCd/k5nni7PM4AdSwvSURH4uRErD1j5P8BE6UdSmcMg7Ti31JGIemZVW1cFc3IzUN5WTyduNMUIeeN5VE5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968239; c=relaxed/simple;
	bh=tgTP6swMute83bKTBlLKzUP6WGhz4RuTtl2RaWC6gak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhLbQPZH+dutD4955ZdLQwTFKQiSMIy98/NnSSQd1dOUZsgFKMQiimPAr+fq1RupgUzrHWV/JpfHh0OwkT0/SUSsPwaxPT7Z7lXkiEc7/r5BapveGQIrfBcBEmaTbGQwgsBaq88u6AoEFvv3p4G7foRgL5UPwNAELCCCX/mJZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3J4DYOy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307c13298eeso9308851fa.0;
        Wed, 19 Feb 2025 04:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968234; x=1740573034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gRANWQiTUbafkGO9fwshwTqOYl/mRZcDzeC9SF4EWE=;
        b=j3J4DYOyS3tV8HS9DZxJWqboEhjBCgJBU619kkJaVDNXxmzF/Uh9Xeo8uBWsKPIFL+
         aGtJOK9hVgPV5dDdm+7s2nBODmuU3+fQEUpwf86N6oG10rqplhLWrPlml4rz5AL41X03
         1S5CwiqktAm9Jj23CRG7YuOd2Qm3nunFxYTwNNQstnRZzGvsXVxciU1dQNaO1dSOtwEh
         w3w+Q81lGxeRPdJ3iPjDN18Q6tLipMrlUy/NXuG0bODWG1q0ZWh5huQU/YgSYGB+ksPx
         kgriGa6jfdZAzRhOQKBSE4mttD8zp+yG4rBmGJfGbkDY1mV3E+tNas5tP4BIc/5HT9CG
         dzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968234; x=1740573034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gRANWQiTUbafkGO9fwshwTqOYl/mRZcDzeC9SF4EWE=;
        b=jomZEvE0pS//dWD4/yinTmnguoQqY5p/5+H5rfmH+3RA64SiXL1QYyctj0TkRTeMDU
         VJW0w2huQ0yc7TaxO/+8KcxtN86Q6H7HfWNFhQl0abE4dyldEqsjXkyDuM7glZBQyLwC
         uTHY5ZyYxcvBDXaB1QEFFkF0n446RRszMzeATtzb9hxSlp84ku2V0YZ0TUUot31zSe7t
         2e7McF73Rx0V2UFZkWmAtsSXbnI9T87zDvzxEt4WFheIAP5L7S+dgERgenOfE3fn9sej
         /tdIZAfooSOG1wc52+rppCingYpbyZYnzqOa3QeaQRladpcStR6VYm2INB7vXxI4WlTv
         ApKA==
X-Forwarded-Encrypted: i=1; AJvYcCUA21GDtTSUVAxgxNRPLRey4kJbkec/E9KLq90Wwtle1iTr8D9pymjrihJH1HrQOKqPEeQZR1jOmC41UAvS@vger.kernel.org, AJvYcCVQSoj57MgeVTd0/buwnuces88oMBoVB6HTMmJvCeRtbl/JQRQFjLYsgU0fXOLu8Dq0SQrsC4K4TKSc@vger.kernel.org, AJvYcCWMBA9AgcdfSAM5Xi9u/q23vzvH+uvtg015yWla3lxOimsU0q2Gi+gIvgSgwhBVhL0/5iKIUN94uL82@vger.kernel.org, AJvYcCX4vPeTa8hix/iP7lnlteTFsS1IVqdX1dwbCGN/BpUWrbAMoWe0ZDCCjfFN+FiAZJlpbK+aLXjb7HJETt5TZde09cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0iSbJoEEh8OA4ATrwWO1gLiv++zNn1P8drBDhVlgsYGnzarA
	kDbcw9M1kEg9B2cA3SgMDB4rheOAGLm1Soz/xXX9ytNBoejoxQrU
X-Gm-Gg: ASbGncvZmzQBUc6JGJgsA/3HMYNBRPhQuxFd7CKqLElTPh4hFoxuma3dK8mU4ZRbpO6
	Q5zHDCcCEboL6nccjtHxOy/zTZ091z0rlkDMkCJau7zJRpgrv29IZLy/lattfn3hfuIUOluDNIN
	VaDlGKhA4IeMB2Z3DcdG4CdcnL9UxRa+rzhfvXKE0uXzf0FfrXzgQNyxwkxB2bVSh3Cn709AHL1
	PDNQBGr4265YINe5ubKB+RNAKoUWC0KPSz0vFLWsOA/qHqzFERHkZJWJXlpp9lQyVVqoLPjkGad
	Wk8XPnuHYT3PSh/D1jGwIw==
X-Google-Smtp-Source: AGHT+IHMuqGjJPJmwx6XEk4wd+AYe/hAr14LA7ZB3GETJw2tINvrS45+HcCU40rfNoKlPNXMWabz/g==
X-Received: by 2002:a2e:9f15:0:b0:309:2696:c293 with SMTP id 38308e7fff4ca-30a440f8e73mr13589371fa.4.1739968233293;
        Wed, 19 Feb 2025 04:30:33 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3ce198e6sm5776661fa.3.2025.02.19.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:30:31 -0800 (PST)
Date: Wed, 19 Feb 2025 14:30:27 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
Message-ID: <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gZYeK9USRfcafrDz"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--gZYeK9USRfcafrDz
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
v2 =3D> v3: Mostly based on review comments by Jonathan
 - Support differential and single-ended channels(*)
 - Rename iio_adc_device_get_channels() as
 - Improve spelling
 - Drop support for cases where DT comes from parent device's node
 - Decrease loop indent by reverting node name check conditions
 - Don't set 'chan->indexed' by number of channels to keep the
   interface consistent no matter how many channels are connected.
 - Fix ID range check and related comment
RFC v1 =3D> v2:
 - New patch

(*) The support for single-ended and differential channels is 100%
untested. I am not convinced it is actually an improvement over the
*_simple() helpers which only supported getting the ID from the "reg".
In theory they could be used. In practice, while I skimmed through the
in-tree ADC drivers which used the for_each_child_node() construct - it
seemed that most of those which supported differential inputs had also
some other per-channel properties to read. Those users would in any case
need to loop through the nodes to get those other properties.

If I am once more allowed to go back to proposing the _simple() variant
which only covers the case: "chan ID in 'reg' property"... Dropping
support for differential and single-ended channels would simplify this
helper a lot. It'd allow dropping the sanity check as well as the extra
parameters callers need to pass to tell what kind of properties they
expect. That'd (in my opinion) made the last patches (to actual ADC
drivers) in this series a much more lean and worthy ;)

Finally, we could add own functions for differential/single-ended/all
channels when the next driver which uses differential or single-ended
channels - and which does not need other per-channel properties - lands
in tree. That would still simplify the helper API usage for those
drivers touched at the end of this series.

I (still) think it might be nice to have helpers for fetching also the
other generic (non vendor specific) ADC properties (as listed in the
Documentation/devicetree/bindings/iio/adc/adc.yaml) - but as I don't
have use for those in BD79124 driver (at least not for now), I don't
imnplement them yet. Anyways, this commit creates a place for such
helpers.
---
 drivers/iio/adc/Kconfig            |   3 +
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/industrialio-adc.c | 304 +++++++++++++++++++++++++++++
 include/linux/iio/adc-helpers.h    |  56 ++++++
 4 files changed, 364 insertions(+)
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
index 000000000000..0281d64ae112
--- /dev/null
+++ b/drivers/iio/adc/industrialio-adc.c
@@ -0,0 +1,304 @@
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
+int iio_adc_device_num_channels(struct device *dev)
+{
+	int num_chan =3D 0;
+
+	device_for_each_child_node_scoped(dev, child)
+		if (fwnode_name_eq(child, "channel"))
+			num_chan++;
+
+	return num_chan;
+}
+EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
+
+static const char *iio_adc_type2prop(int type)
+{
+	switch (type) {
+	case IIO_ADC_CHAN_PROP_TYPE_REG:
+		return "reg";
+	case IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED:
+		return "single-channel";
+	case IIO_ADC_CHAN_PROP_TYPE_DIFF:
+		return "diff-channels";
+	case IIO_ADC_CHAN_PROP_COMMON:
+		return "common-mode-channel";
+	default:
+		return "unknown";
+	}
+}
+
+/*
+ * Sanity check. Ensure that:
+ * - At least some type(s) are allowed
+ * - All types found are also expected
+ * - If plain "reg" is not allowed, either single-ended or differential
+ *   properties are found.
+ */
+static int iio_adc_prop_type_check_sanity(struct device *dev,
+		const struct iio_adc_props *expected_props, int found_types)
+{
+	unsigned long allowed_types =3D expected_props->allowed |
+				      expected_props->required;
+
+	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
+		dev_dbg(dev, "Invalid adc allowed prop types 0x%lx\n",
+			allowed_types);
+
+		return -EINVAL;
+	}
+	if (found_types & (~allowed_types)) {
+		long unknown_types =3D found_types & (~allowed_types);
+		int type;
+
+		for_each_set_bit(type, &unknown_types,
+				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
+			dev_err(dev, "Unsupported channel property %s\n",
+				iio_adc_type2prop(type));
+		}
+
+		return -EINVAL;
+	}
+
+	/*
+	 * The IIO_ADC_CHAN_PROP_TYPE_REG is special. We always require it to
+	 * be found in the dt. (If not, we'll error out before calling this
+	 * function.) However, listing it in 'allowed' types means the "reg"
+	 * alone can be used to indicate the channel ID.
+	 *
+	 * Thus, we don't add it in the found properties either - so check for
+	 * found and allowed properties passes even if user hasn't explicitly
+	 * added the 'IIO_ADC_CHAN_PROP_TYPE_REG' to be allowed. (This is the
+	 * case if either differential or single-ended property is required).
+	 *
+	 * Hence, for this check we need to explicitly add the
+	 * IIO_ADC_CHAN_PROP_TYPE_REG to 'found' properties to make the check
+	 * pass when "reg" is the property which is required to have the
+	 * channel ID.
+	 *
+	 * We could of course always add the IIO_ADC_CHAN_PROP_TYPE_REG in
+	 * allowed types and found types - but then we wouldn't catch the case
+	 * where user says the "reg" alone is not sufficient.
+	 */
+	if ((~(found_types | IIO_ADC_CHAN_PROP_TYPE_REG)) & expected_props->requi=
red) {
+		long missing_types;
+		int type;
+
+		missing_types =3D (~found_types) & expected_props->required;
+
+		for_each_set_bit(type, &missing_types,
+				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
+			dev_err(dev, "required channel specifier '%s' not found\n",
+				iio_adc_type2prop(type));
+		}
+
+		return -EINVAL;
+	}
+
+	/* Check if we require something else but the "reg" property */
+	if (!(allowed_types & IIO_ADC_CHAN_PROP_TYPE_REG)) {
+		if (found_types & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED ||
+				found_types & IIO_ADC_CHAN_PROP_TYPE_DIFF)
+			return 0;
+
+		dev_err(dev, "channel specifier not found\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * iio_adc_device_channels_by_property - get ADC channel IDs
+ *
+ * Scan the device node for ADC channel information. Return an array of fo=
und
+ * IDs. Caller needs to provide the memory for the array and provide maxim=
um
+ * number of IDs the array can store.
+ *
+ * @dev:		Pointer to the ADC device
+ * @channels:		Array where the found IDs will be stored.
+ * @max_channels:	Number of IDs that fit in the array.
+ * @expected_props:	Bitmaps of channel property types (for checking).
+ *
+ * Return:		Number of found channels on succes. 0 if no channels
+ *			was found. Negative value to indicate failure.
+ */
+int iio_adc_device_channels_by_property(struct device *dev, int *channels,
+		int max_channels, const struct iio_adc_props *expected_props)
+{
+	int num_chan =3D 0, ret;
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 ch, diff[2], se;
+		struct iio_adc_props tmp;
+		int chtypes_found =3D 0;
+
+		if (!fwnode_name_eq(child, "channel"))
+			continue;
+
+		if (num_chan =3D=3D max_channels)
+			return -EINVAL;
+
+		ret =3D fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return ret;
+
+		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
+						     &diff[0], 2);
+		if (!ret)
+			chtypes_found |=3D IIO_ADC_CHAN_PROP_TYPE_DIFF;
+
+		ret =3D fwnode_property_read_u32(child, "single-channel", &se);
+		if (!ret)
+			chtypes_found |=3D IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
+
+		tmp =3D *expected_props;
+		/*
+		 * We don't bother reading the "common-mode-channel" here as it
+		 * doesn't really affect on the primary channel ID. We remove
+		 * it from the required properties to allow the sanity check
+		 * pass here  also for drivers which require it.
+		 */
+		tmp.required &=3D (~BIT(IIO_ADC_CHAN_PROP_COMMON));
+
+		ret =3D iio_adc_prop_type_check_sanity(dev, &tmp, chtypes_found);
+		if (ret)
+			return ret;
+
+		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF)
+			ch =3D diff[0];
+		else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED)
+			ch =3D se;
+
+		/*
+		 * We assume the channel IDs start from 0. If it seems this is
+		 * not a sane assumption, then we can relax this check or add
+		 * 'allowed ID range' parameter.
+		 *
+		 * Let's just start with this simple assumption.
+		 */
+		if (ch >=3D max_channels)
+			return -ERANGE;
+
+		channels[num_chan] =3D ch;
+		num_chan++;
+	}
+
+	return num_chan;
+
+}
+EXPORT_SYMBOL_GPL(iio_adc_device_channels_by_property);
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
+ * @dev:		Pointer to the ADC device.
+ * @template:		Template iio_chan_spec from which the fields of all
+ *			found and allocated channels are initialized.
+ * @cs:			Location where pointer to allocated iio_chan_spec
+ *			should be stored.
+ * @expected_props:	Bitmaps of channel property types (for checking).
+ *
+ * Return:	Number of found channels on succes. Negative value to indicate
+ *		failure.
+ */
+int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
+				const struct iio_chan_spec *template,
+				struct iio_chan_spec **cs,
+				const struct iio_adc_props *expected_props)
+{
+	struct iio_chan_spec *chan;
+	int num_chan =3D 0, ret;
+
+	num_chan =3D iio_adc_device_num_channels(dev);
+	if (num_chan < 1)
+		return num_chan;
+
+	*cs =3D devm_kcalloc(dev, num_chan, sizeof(**cs), GFP_KERNEL);
+	if (!*cs)
+		return -ENOMEM;
+
+	chan =3D &(*cs)[0];
+
+	device_for_each_child_node_scoped(dev, child) {
+		u32 ch, diff[2], se, common;
+		int chtypes_found =3D 0;
+
+		if (!fwnode_name_eq(child, "channel"))
+			continue;
+
+		ret =3D fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return ret;
+
+		ret =3D fwnode_property_read_u32_array(child, "diff-channels",
+						     &diff[0], 2);
+		if (!ret)
+			chtypes_found |=3D IIO_ADC_CHAN_PROP_TYPE_DIFF;
+
+		ret =3D fwnode_property_read_u32(child, "single-channel", &se);
+		if (!ret)
+			chtypes_found |=3D IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED;
+
+		ret =3D fwnode_property_read_u32(child, "common-mode-channel",
+					       &common);
+		if (!ret)
+			chtypes_found |=3D BIT(IIO_ADC_CHAN_PROP_COMMON);
+
+		ret =3D iio_adc_prop_type_check_sanity(dev, expected_props,
+						     chtypes_found);
+		if (ret)
+			return ret;
+
+		*chan =3D *template;
+		chan->channel =3D ch;
+
+		if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_DIFF) {
+			chan->differential =3D 1;
+			chan->channel =3D diff[0];
+			chan->channel2 =3D diff[1];
+
+		} else if (chtypes_found & IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED) {
+			chan->channel =3D se;
+			if (chtypes_found & BIT(IIO_ADC_CHAN_PROP_COMMON))
+				chan->channel2 =3D common;
+		}
+
+		/*
+		 * We assume the channel IDs start from 0. If it seems this is
+		 * not a sane assumption, then we have to add 'allowed ID ranges'
+		 * to the struct iio_adc_props because some of the callers may
+		 * rely on the IDs being in this range - and have arrays indexed
+		 * by the ID.
+		 */
+		if (chan->channel >=3D num_chan)
+			return -ERANGE;
+
+		chan++;
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
index 000000000000..f7791d45dbd2
--- /dev/null
+++ b/include/linux/iio/adc-helpers.h
@@ -0,0 +1,56 @@
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
+enum {
+	IIO_ADC_CHAN_PROP_REG,
+	IIO_ADC_CHAN_PROP_SINGLE_ENDED,
+	IIO_ADC_CHAN_PROP_DIFF,
+	IIO_ADC_CHAN_PROP_COMMON,
+	IIO_ADC_CHAN_NUM_PROP_TYPES
+};
+
+/*
+ * Channel property types to be used with iio_adc_device_get_channels,
+ * devm_iio_adc_device_alloc_chaninfo, ...
+ */
+#define IIO_ADC_CHAN_PROP_TYPE_REG BIT(IIO_ADC_CHAN_PROP_REG)
+#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_ENDED BIT(IIO_ADC_CHAN_PROP_SINGLE_E=
NDED)
+#define IIO_ADC_CHAN_PROP_TYPE_SINGLE_COMMON					\
+	(BIT(IIO_ADC_CHAN_PROP_SINGLE_ENDED) | BIT(IIO_ADC_CHAN_PROP_COMMON))
+#define IIO_ADC_CHAN_PROP_TYPE_DIFF BIT(IIO_ADC_CHAN_PROP_DIFF)
+#define IIO_ADC_CHAN_PROP_TYPE_ALL GENMASK(IIO_ADC_CHAN_NUM_PROP_TYPES - 1=
, 0)
+
+/**
+ * iio_adc_chan_props - information of expected device-tree channel proper=
ties
+ *
+ * @required:	Bitmask of property definitions of required channel properti=
es
+ * @allowed:	Bitmask of property definitions of optional channel propertie=
s.
+ *		Listing of required properties is not needed here.
+ */
+struct iio_adc_props {
+	unsigned long required;
+	unsigned long allowed;
+};
+
+int iio_adc_device_num_channels(struct device *dev);
+int devm_iio_adc_device_alloc_chaninfo(struct device *dev,
+				const struct iio_chan_spec *template,
+				struct iio_chan_spec **cs,
+				const struct iio_adc_props *expected_props);
+
+int iio_adc_device_channels_by_property(struct device *dev, int *channels,
+				int max_channels,
+				const struct iio_adc_props *expected_props);
+#endif /* _INDUSTRIAL_IO_ADC_HELPERS_H_ */
--=20
2.48.1


--gZYeK9USRfcafrDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zuMACgkQeFA3/03a
ocXdzwf+NBG/bW2zolvYNUyZakYqPyQsNdn0w7+7dBeFJW3qJCvblU9X5zaMC7RD
InYlHxGGA1c5cMHfDTcJHAC/txZhMzn8eeXGkVwtyoQTNdxARxYzMLdAMM+OxydZ
GAJmveezO4etWiq9o3Mbn7x2zoFfbglft986VGdyQLOt0r3Zy7M/E0FemVn1F4xO
VlwTZo4s+FDShNbOeg16FvFmG0QyNNxM4ctzi3m53MyN2W6D04/dtbLGCXIk6X6+
ROAfXvzXG2mNiYg3aHpG+dPNuXlyigGq3zZWtg5S9mkhB5LFbLjteC1q9KUSCRAJ
6I7xdTz1rvnwCk7gTEDUCSuJ4TCU/g==
=oycM
-----END PGP SIGNATURE-----

--gZYeK9USRfcafrDz--

