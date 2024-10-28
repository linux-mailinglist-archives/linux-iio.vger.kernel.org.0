Return-Path: <linux-iio+bounces-11528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356F59B3D01
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 22:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D54282EF8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011A1DF972;
	Mon, 28 Oct 2024 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="fiT1ILP4";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="UT9/Usjb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03501EE01E;
	Mon, 28 Oct 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152030; cv=none; b=RszWmEPhDlU7JM2bOnk1e0uHGk4BffMmkxLmTmP8VnjiqPrhusJoemYwXY8UqUqyGuSZF1oNcm6LSz1kUPGk6PyPrS785UD9KNUU5Lx8+sZ3dMvrg7zHbetwrk0MNmqIr37tM3t6XZXGlGxqZld4IyVjn7apJC2wPmaBi5tHcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152030; c=relaxed/simple;
	bh=/FODotyq5fupfVjDekynKtpo9oN5xgCxVroRr4UMk/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdZOWkKVHfWJFoda8ueHa6D3wZaugCrqn//nny62aXCpEjg5+K40++zFeCNnWSWGHw/t1zo41lyogX8VBJVHlfGrzBp0R3bHYIZ2DikSaQ1SUzEYjB/AINxSBcpXOICNcORDWSxAhpJzpvIdmCqxb6A6t977lRTeF6KEAJtBDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=fiT1ILP4; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=UT9/Usjb; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id e2bbf806;
	Mon, 28 Oct 2024 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=s1; bh=ZvUsRlYw6ZS6XBuJNK1/spXjYUc=; b=fiT1ILP4WD8qR9eKUW
	N9Hp+Ky7N4OC6A1wHTZsmxwQiw/bJUpMWj54/SPtQCa8YMe9MFkJzF4kOcvLKp7u
	Cq6mZNN7lqhpH1TxLX1W1hAq+2lsUO/IC8r0xsAYeZRlVHv4nR0JcttcLpHQZF+l
	OQCWgOellKumD8hoZXf1Ak8RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; q=dns; s=s1; b=BMx7K0qITDB/2l6ISvIq0Hfh8etCOkrgxgLpXK1/wP5S
	UmpDpz4fw3vUpq3rKLIKGEPO5tRbBB2gL4iMRHw8XWC3mrJ2mZfVIx9bSvPdNjst
	Pt0zH/3v9s1kM/HHBuJAIiXYL+RQS73Fu1PZnsuRgcmOJp31rfS6MLqqnVw6+fg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1730151476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frD5HsBSKxsmYudVft2MfJqEfOygg85lLqKQjKUeG+4=;
	b=UT9/Usjbcs3DXSP1kRxlpUvOdKwyJKLVCVbkwuBFXG9xzktjEkJmjYS9Z4ZPTzdUPt3bU5
	nkef4mNCtjbLshh1MsuP/LupKdDlFaTlv5bFSAk09FUqT0etmlJDDYOZIbH5CQ+3AijMa2
	2xaFShW32SjOxb1axHc8ns2y/FV/pJg=
Received: from [127.0.1.1] (host-95-245-34-85.retail.telecomitalia.it [95.245.34.85])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 4ae7d902 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 21:37:56 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 28 Oct 2024 22:45:33 +0100
Subject: [PATCH v9 6/8] iio: dac: ad3552r: extract common code (no changes
 in behavior intended)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-6-f6960b4f9719@kernel-space.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extracting common code, to share common code to be used later
by the AXI driver version (ad3552r-axi.c).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Makefile         |   2 +-
 drivers/iio/dac/ad3552r-common.c | 249 ++++++++++++++++++++++++
 drivers/iio/dac/ad3552r.c        | 398 +++------------------------------------
 drivers/iio/dac/ad3552r.h        | 224 ++++++++++++++++++++++
 4 files changed, 501 insertions(+), 372 deletions(-)

diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 621d553bd6e3..c92de0366238 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -4,7 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-obj-$(CONFIG_AD3552R) += ad3552r.o
+obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
 obj-$(CONFIG_AD5360) += ad5360.o
 obj-$(CONFIG_AD5380) += ad5380.o
 obj-$(CONFIG_AD5421) += ad5421.o
diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
new file mode 100644
index 000000000000..2dfeca3656d2
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2010-2024 Analog Devices Inc.
+// Copyright (c) 2024 Baylibre, SAS
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include "ad3552r.h"
+
+const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
+	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
+	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
+	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
+	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= { -10000, 10000 }
+};
+EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, IIO_AD3552R);
+
+const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
+	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
+	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
+	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
+};
+EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, IIO_AD3552R);
+
+/* Gain * AD3552R_GAIN_SCALE */
+static const s32 gains_scaling_table[] = {
+	[AD3552R_CH_GAIN_SCALING_1]		= 1000,
+	[AD3552R_CH_GAIN_SCALING_0_5]		= 500,
+	[AD3552R_CH_GAIN_SCALING_0_25]		= 250,
+	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
+};
+
+u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
+{
+	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
+	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p) |
+	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n) |
+	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs(goffs)) |
+	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, goffs < 0);
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_calc_custom_gain, IIO_AD3552R);
+
+static void ad3552r_get_custom_range(struct ad3552r_ch_data *ch_data,
+				     s32 *v_min, s32 *v_max)
+{
+	s64 vref, tmp, common, offset, gn, gp;
+	/*
+	 * From datasheet formula (In Volts):
+	 *	Vmin = 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
+	 *	Vmax = 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
+	 * Calculus are converted to milivolts
+	 */
+	vref = 2500;
+	/* 2.5 * 1.03 * 1000 (To mV) */
+	common = 2575 * ch_data->rfb;
+	offset = ch_data->gain_offset;
+
+	gn = gains_scaling_table[ch_data->n];
+	tmp = (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
+	tmp = div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
+	*v_max = vref + tmp;
+
+	gp = gains_scaling_table[ch_data->p];
+	tmp = (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
+	tmp = div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
+	*v_min = vref - tmp;
+}
+
+void ad3552r_calc_gain_and_offset(struct ad3552r_ch_data *ch_data,
+				  const struct ad3552r_model_data *model_data)
+{
+	s32 idx, v_max, v_min, span, rem;
+	s64 tmp;
+
+	if (ch_data->range_override) {
+		ad3552r_get_custom_range(ch_data, &v_min, &v_max);
+	} else {
+		/* Normal range */
+		idx = ch_data->range;
+		v_min = model_data->ranges_table[idx][0];
+		v_max = model_data->ranges_table[idx][1];
+	}
+
+	/*
+	 * From datasheet formula:
+	 *	Vout = Span * (D / 65536) + Vmin
+	 * Converted to scale and offset:
+	 *	Scale = Span / 65536
+	 *	Offset = 65536 * Vmin / Span
+	 *
+	 * Reminders are in micros in order to be printed as
+	 * IIO_VAL_INT_PLUS_MICRO
+	 */
+	span = v_max - v_min;
+	ch_data->scale_int = div_s64_rem(span, 65536, &rem);
+	/* Do operations in microvolts */
+	ch_data->scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000, 65536);
+
+	ch_data->offset_int = div_s64_rem(v_min * 65536, span, &rem);
+	tmp = (s64)rem * 1000000;
+	ch_data->offset_dec = div_s64(tmp, span);
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_calc_gain_and_offset, IIO_AD3552R);
+
+int ad3552r_get_ref_voltage(struct device *dev, u32 *val)
+{
+	int voltage;
+	int delta = 100000;
+
+	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (voltage < 0 && voltage != -ENODEV)
+		return dev_err_probe(dev, voltage,
+				     "Error getting vref voltage\n");
+
+	if (voltage == -ENODEV) {
+		if (device_property_read_bool(dev, "adi,vref-out-en"))
+			*val = AD3552R_INTERNAL_VREF_PIN_2P5V;
+		else
+			*val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
+
+		return 0;
+	}
+
+	if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
+		dev_warn(dev, "vref-supply must be 2.5V");
+		return -EINVAL;
+	}
+
+	*val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_ref_voltage, IIO_AD3552R);
+
+int ad3552r_get_drive_strength(struct device *dev, u32 *val)
+{
+	int err;
+	u32 drive_strength;
+
+	err = device_property_read_u32(dev, "adi,sdo-drive-strength",
+				       &drive_strength);
+	if (err)
+		return err;
+
+	if (drive_strength > 3) {
+		dev_err_probe(dev, -EINVAL,
+			      "adi,sdo-drive-strength must be less than 4\n");
+		return -EINVAL;
+	}
+
+	*val = drive_strength;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_drive_strength, IIO_AD3552R);
+
+int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
+			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
+{
+	int err;
+	u32 val;
+	struct fwnode_handle *gain_child __free(fwnode_handle) =
+		fwnode_get_named_child_node(child,
+					    "custom-output-range-config");
+
+	if (!gain_child)
+		return dev_err_probe(dev, -EINVAL,
+				     "custom-output-range-config mandatory\n");
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-scaling-p mandatory\n");
+	*gs_p = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-scaling-n property mandatory\n");
+	*gs_n = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,rfb-ohms mandatory\n");
+	*rfb = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-offset mandatory\n");
+	*goffs = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_custom_gain, IIO_AD3552R);
+
+static int ad3552r_find_range(const struct ad3552r_model_data *model_info,
+			      s32 *vals)
+{
+	int i;
+
+	for (i = 0; i < model_info->num_ranges; i++)
+		if (vals[0] == model_info->ranges_table[i][0] * 1000 &&
+		    vals[1] == model_info->ranges_table[i][1] * 1000)
+			return i;
+
+	return -EINVAL;
+}
+
+int ad3552r_get_output_range(struct device *dev,
+			     const struct ad3552r_model_data *model_info,
+			     struct fwnode_handle *child, u32 *val)
+{
+	int ret;
+	s32 vals[2];
+
+	/* This property is optional, so returning -ENOENT if missing */
+	if (!fwnode_property_present(child, "adi,output-range-microvolt"))
+		return -ENOENT;
+
+	ret = fwnode_property_read_u32_array(child,
+					     "adi,output-range-microvolt",
+					     vals, 2);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"invalid adi,output-range-microvolt\n");
+
+	ret = ad3552r_find_range(model_info, vals);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"invalid adi,output-range-microvolt value\n");
+
+	*val = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_output_range, IIO_AD3552R);
+
+MODULE_DESCRIPTION("ad3552r common functions");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 68cc69308a17..92688d958f4f 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -12,226 +12,9 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
-/* Register addresses */
-/* Primary address space */
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
-#define   AD3552R_MASK_SOFTWARE_RESET			(BIT(7) | BIT(0))
-#define   AD3552R_MASK_ADDR_ASCENSION			BIT(5)
-#define   AD3552R_MASK_SDO_ACTIVE			BIT(4)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
-#define   AD3552R_MASK_SINGLE_INST			BIT(7)
-#define   AD3552R_MASK_SHORT_INSTRUCTION		BIT(3)
-#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
-#define   AD3552R_MASK_DEVICE_STATUS(n)			BIT(4 + (n))
-#define   AD3552R_MASK_CUSTOM_MODES			GENMASK(3, 2)
-#define   AD3552R_MASK_OPERATING_MODES			GENMASK(1, 0)
-#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
-#define   AD3552R_MASK_CLASS				GENMASK(7, 0)
-#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
-#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
-#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
-#define   AD3552R_MASK_GRADE				GENMASK(7, 4)
-#define   AD3552R_MASK_DEVICE_REVISION			GENMASK(3, 0)
-#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
-#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
-#define AD3552R_REG_ADDR_VENDOR_L			0x0C
-#define AD3552R_REG_ADDR_VENDOR_H			0x0D
-#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
-#define   AD3552R_MASK_LENGTH				GENMASK(7, 0)
-#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
-#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
-#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
-#define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
-							 GENMASK(1, 0))
-#define   AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
-#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
-#define   AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
-#define   AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
-#define   AD3552R_MASK_INVALID_OR_NO_CRC		BIT(3)
-#define   AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
-#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
-#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
-#define   AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
-#define   AD3552R_MASK_MEM_CRC_EN			BIT(4)
-#define   AD3552R_MASK_SDO_DRIVE_STRENGTH		GENMASK(3, 2)
-#define   AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
-#define   AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
-#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
-#define   AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
-#define   AD3552R_MASK_SAMPLE_HOLD_DIFFERENTIAL_USER_EN	BIT(5)
-#define   AD3552R_MASK_SAMPLE_HOLD_USER_TRIM		GENMASK(4, 3)
-#define   AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
-#define   AD3552R_MASK_REFERENCE_VOLTAGE_SEL		GENMASK(1, 0)
-#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
-#define   AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
-#define   AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
-#define   AD3552R_MASK_MEM_CRC_ERR_ALARM		BIT(4)
-#define   AD3552R_MASK_SPI_CRC_ERR_ALARM		BIT(3)
-#define   AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
-#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
-#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
-#define AD3552R_REG_ADDR_ERR_STATUS			0x17
-#define   AD3552R_MASK_REF_RANGE_ERR_STATUS			BIT(6)
-#define   AD3552R_MASK_DUAL_SPI_STREAM_EXCEEDS_DAC_ERR_STATUS	BIT(5)
-#define   AD3552R_MASK_MEM_CRC_ERR_STATUS			BIT(4)
-#define   AD3552R_MASK_RESET_STATUS				BIT(0)
-#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
-#define   AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4 + (ch))
-#define   AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)	BIT(ch)
-#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
-#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ? GENMASK(7, 4) :\
-							 GENMASK(3, 0))
-#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B + (ch) * 2)
-#define   AD3552R_MASK_CH_OFFSET_BITS_0_7		GENMASK(7, 0)
-#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) * 2)
-#define   AD3552R_MASK_CH_RANGE_OVERRIDE		BIT(7)
-#define   AD3552R_MASK_CH_GAIN_SCALING_N		GENMASK(6, 5)
-#define   AD3552R_MASK_CH_GAIN_SCALING_P		GENMASK(4, 3)
-#define   AD3552R_MASK_CH_OFFSET_POLARITY		BIT(2)
-#define   AD3552R_MASK_CH_OFFSET_BIT_8			BIT(0)
-/*
- * Secondary region
- * For multibyte registers specify the highest address because the access is
- * done in descending order
- */
-#define AD3552R_SECONDARY_REGION_START			0x28
-#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
-#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C - (1 - ch) * 2)
-#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
-#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
-#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
-#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
-#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 - ch) * 2)
-/* 3 bytes registers */
-#define AD3552R_REG_START_24B				0x37
-#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
-#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D - (1 - ch) * 3)
-#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
-#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
-#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
-#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
-#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - ch) * 3)
-
-/* Useful defines */
-#define AD3552R_MAX_CH					2
-#define AD3552R_MASK_CH(ch)				BIT(ch)
-#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
-#define AD3552R_MAX_REG_SIZE				3
-#define AD3552R_READ_BIT				BIT(7)
-#define AD3552R_ADDR_MASK				GENMASK(6, 0)
-#define AD3552R_MASK_DAC_12B				0xFFF0
-#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
-#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
-#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
-#define AD3552R_GAIN_SCALE				1000
-#define AD3552R_LDAC_PULSE_US				100
-
-enum ad3552r_ch_vref_select {
-	/* Internal source with Vref I/O floating */
-	AD3552R_INTERNAL_VREF_PIN_FLOATING,
-	/* Internal source with Vref I/O at 2.5V */
-	AD3552R_INTERNAL_VREF_PIN_2P5V,
-	/* External source with Vref I/O as input */
-	AD3552R_EXTERNAL_VREF_PIN_INPUT
-};
-
-enum ad3552r_id {
-	AD3541R_ID = 0x400b,
-	AD3542R_ID = 0x4009,
-	AD3551R_ID = 0x400a,
-	AD3552R_ID = 0x4008,
-};
-
-enum ad3552r_ch_output_range {
-	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
-	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
-	AD3552R_CH_OUTPUT_RANGE_0__5V,
-	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
-	AD3552R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
-	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
-	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
-	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
-};
-
-static const s32 ad3552r_ch_ranges[][2] = {
-	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
-	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
-	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
-	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
-	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
-};
-
-enum ad3542r_ch_output_range {
-	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
-	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
-	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__5V,
-	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
-	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
-};
-
-static const s32 ad3542r_ch_ranges[][2] = {
-	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
-	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
-	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
-	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= {-2500, 7500},
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000}
-};
-
-enum ad3552r_ch_gain_scaling {
-	/* Gain scaling of 1 */
-	AD3552R_CH_GAIN_SCALING_1,
-	/* Gain scaling of 0.5 */
-	AD3552R_CH_GAIN_SCALING_0_5,
-	/* Gain scaling of 0.25 */
-	AD3552R_CH_GAIN_SCALING_0_25,
-	/* Gain scaling of 0.125 */
-	AD3552R_CH_GAIN_SCALING_0_125,
-};
-
-/* Gain * AD3552R_GAIN_SCALE */
-static const s32 gains_scaling_table[] = {
-	[AD3552R_CH_GAIN_SCALING_1]		= 1000,
-	[AD3552R_CH_GAIN_SCALING_0_5]		= 500,
-	[AD3552R_CH_GAIN_SCALING_0_25]		= 250,
-	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
-};
-
-struct ad3552r_ch_data {
-	s32	scale_int;
-	s32	scale_dec;
-	s32	offset_int;
-	s32	offset_dec;
-	s16	gain_offset;
-	u16	rfb;
-	u8	n;
-	u8	p;
-	u8	range;
-	bool	range_override;
-};
-
-struct ad3552r_model_data {
-	const char *model_name;
-	enum ad3552r_id chip_id;
-	unsigned int num_hw_channels;
-	const s32 (*ranges_table)[2];
-	int num_ranges;
-	bool requires_output_range;
-};
+#include "ad3552r.h"
 
 struct ad3552r_desc {
 	const struct ad3552r_model_data *model_data;
@@ -633,136 +416,35 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
 }
 
-static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
-				     s32 *v_max)
-{
-	s64 vref, tmp, common, offset, gn, gp;
-	/*
-	 * From datasheet formula (In Volts):
-	 *	Vmin = 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
-	 *	Vmax = 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
-	 * Calculus are converted to milivolts
-	 */
-	vref = 2500;
-	/* 2.5 * 1.03 * 1000 (To mV) */
-	common = 2575 * dac->ch_data[i].rfb;
-	offset = dac->ch_data[i].gain_offset;
-
-	gn = gains_scaling_table[dac->ch_data[i].n];
-	tmp = (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
-	tmp = div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
-	*v_max = vref + tmp;
-
-	gp = gains_scaling_table[dac->ch_data[i].p];
-	tmp = (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
-	tmp = div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
-	*v_min = vref - tmp;
-}
-
-static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
-{
-	s32 idx, v_max, v_min, span, rem;
-	s64 tmp;
-
-	if (dac->ch_data[ch].range_override) {
-		ad3552r_get_custom_range(dac, ch, &v_min, &v_max);
-	} else {
-		/* Normal range */
-		idx = dac->ch_data[ch].range;
-		v_min = dac->model_data->ranges_table[idx][0];
-		v_max = dac->model_data->ranges_table[idx][1];
-	}
-
-	/*
-	 * From datasheet formula:
-	 *	Vout = Span * (D / 65536) + Vmin
-	 * Converted to scale and offset:
-	 *	Scale = Span / 65536
-	 *	Offset = 65536 * Vmin / Span
-	 *
-	 * Reminders are in micros in order to be printed as
-	 * IIO_VAL_INT_PLUS_MICRO
-	 */
-	span = v_max - v_min;
-	dac->ch_data[ch].scale_int = div_s64_rem(span, 65536, &rem);
-	/* Do operations in microvolts */
-	dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
-							65536);
-
-	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span, &rem);
-	tmp = (s64)rem * 1000000;
-	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
-}
-
-static int ad3552r_find_range(const struct ad3552r_model_data *model_data,
-			      s32 *vals)
-{
-	int i;
-
-	for (i = 0; i < model_data->num_ranges; i++)
-		if (vals[0] == model_data->ranges_table[i][0] * 1000 &&
-		    vals[1] == model_data->ranges_table[i][1] * 1000)
-			return i;
-
-	return -EINVAL;
-}
-
 static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 					 struct fwnode_handle *child,
 					 u32 ch)
 {
 	struct device *dev = &dac->spi->dev;
-	u32 val;
 	int err;
 	u8 addr;
-	u16 reg = 0, offset;
-
-	struct fwnode_handle *gain_child __free(fwnode_handle)
-		= fwnode_get_named_child_node(child,
-					      "custom-output-range-config");
-	if (!gain_child)
-		return dev_err_probe(dev, -EINVAL,
-				     "mandatory custom-output-range-config property missing\n");
-
-	dac->ch_data[ch].range_override = 1;
-	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
-
-	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-scaling-p property missing\n");
-	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
-	dac->ch_data[ch].p = val;
-
-	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-scaling-n property missing\n");
-	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
-	dac->ch_data[ch].n = val;
-
-	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,rfb-ohms property missing\n");
-	dac->ch_data[ch].rfb = val;
+	u16 reg;
 
-	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
+	err = ad3552r_get_custom_gain(dev, child,
+				      &dac->ch_data[ch].p,
+				      &dac->ch_data[ch].n,
+				      &dac->ch_data[ch].rfb,
+				      &dac->ch_data[ch].gain_offset);
 	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-offset property missing\n");
-	dac->ch_data[ch].gain_offset = val;
+		return err;
 
-	offset = abs((s32)val);
-	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));
+	dac->ch_data[ch].range_override = 1;
 
-	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);
 	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
 	err = ad3552r_write_reg(dac, addr,
-				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
+				abs((s32)dac->ch_data[ch].gain_offset) &
+				AD3552R_MASK_CH_OFFSET_BITS_0_7);
 	if (err)
 		return dev_err_probe(dev, err, "Error writing register\n");
 
+	reg = ad3552r_calc_custom_gain(dac->ch_data[ch].p, dac->ch_data[ch].n,
+				       dac->ch_data[ch].gain_offset);
+
 	err = ad3552r_write_reg(dac, addr, reg);
 	if (err)
 		return dev_err_probe(dev, err, "Error writing register\n");
@@ -773,30 +455,17 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	int err, cnt = 0, voltage, delta = 100000;
-	u32 vals[2], val, ch;
+	int err, cnt = 0;
+	u32 val, ch;
 
 	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
 	if (IS_ERR(dac->gpio_ldac))
 		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
 				     "Error getting gpio ldac");
 
-	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
-	if (voltage < 0 && voltage != -ENODEV)
-		return dev_err_probe(dev, voltage, "Error getting vref voltage\n");
-
-	if (voltage == -ENODEV) {
-		if (device_property_read_bool(dev, "adi,vref-out-en"))
-			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
-		else
-			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
-	} else {
-		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
-			dev_warn(dev, "vref-supply must be 2.5V");
-			return -EINVAL;
-		}
-		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
-	}
+	err = ad3552r_get_ref_voltage(dev, &val);
+	if (err < 0)
+		return err;
 
 	err = ad3552r_update_reg_field(dac,
 				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
@@ -805,13 +474,8 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	if (err)
 		return err;
 
-	err = device_property_read_u32(dev, "adi,sdo-drive-strength", &val);
+	err = ad3552r_get_drive_strength(dev, &val);
 	if (!err) {
-		if (val > 3) {
-			dev_err(dev, "adi,sdo-drive-strength must be less than 4\n");
-			return -EINVAL;
-		}
-
 		err = ad3552r_update_reg_field(dac,
 					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
 					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
@@ -836,21 +500,12 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 					     "reg must be less than %d\n",
 					     dac->model_data->num_hw_channels);
 
-		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
-			err = fwnode_property_read_u32_array(child,
-							     "adi,output-range-microvolt",
-							     vals,
-							     2);
-			if (err)
-				return dev_err_probe(dev, err,
-					"adi,output-range-microvolt property could not be parsed\n");
-
-			err = ad3552r_find_range(dac->model_data, vals);
-			if (err < 0)
-				return dev_err_probe(dev, err,
-						     "Invalid adi,output-range-microvolt value\n");
+		err = ad3552r_get_output_range(dev, dac->model_data,
+					       child, &val);
+		if (err && err != -ENOENT)
+			return err;
 
-			val = err;
+		if (!err) {
 			if (ch == 0)
 				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
 			else
@@ -874,7 +529,7 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 				return err;
 		}
 
-		ad3552r_calc_gain_and_offset(dac, ch);
+		ad3552r_calc_gain_and_offset(&dac->ch_data[ch], dac->model_data);
 		dac->enabled_ch |= BIT(ch);
 
 		if (ch == 0)
@@ -1073,3 +728,4 @@ module_spi_driver(ad3552r_driver);
 MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
 MODULE_DESCRIPTION("Analog Device AD3552R DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD3552R);
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
new file mode 100644
index 000000000000..7511e3f1882c
--- /dev/null
+++ b/drivers/iio/dac/ad3552r.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AD3552R Digital <-> Analog converters common header
+ *
+ * Copyright 2021-2024 Analog Devices Inc.
+ * Author: Angelo Dureghello <adureghello@baylibre.com>
+ */
+
+#ifndef __DRIVERS_IIO_DAC_AD3552R_H__
+#define __DRIVERS_IIO_DAC_AD3552R_H__
+
+/* Register addresses */
+/* Primary address space */
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
+#define   AD3552R_MASK_SOFTWARE_RESET			(BIT(7) | BIT(0))
+#define   AD3552R_MASK_ADDR_ASCENSION			BIT(5)
+#define   AD3552R_MASK_SDO_ACTIVE			BIT(4)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
+#define   AD3552R_MASK_SINGLE_INST			BIT(7)
+#define   AD3552R_MASK_SHORT_INSTRUCTION		BIT(3)
+#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
+#define   AD3552R_MASK_DEVICE_STATUS(n)			BIT(4 + (n))
+#define   AD3552R_MASK_CUSTOM_MODES			GENMASK(3, 2)
+#define   AD3552R_MASK_OPERATING_MODES			GENMASK(1, 0)
+#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
+#define   AD3552R_MASK_CLASS				GENMASK(7, 0)
+#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
+#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
+#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
+#define   AD3552R_MASK_GRADE				GENMASK(7, 4)
+#define   AD3552R_MASK_DEVICE_REVISION			GENMASK(3, 0)
+#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
+#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
+#define AD3552R_REG_ADDR_VENDOR_L			0x0C
+#define AD3552R_REG_ADDR_VENDOR_H			0x0D
+#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
+#define   AD3552R_MASK_LENGTH				GENMASK(7, 0)
+#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
+#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
+#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
+#define   AD3552R_MASK_CRC_ENABLE \
+		(GENMASK(7, 6) | GENMASK(1, 0))
+#define   AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
+#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
+#define   AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
+#define   AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
+#define   AD3552R_MASK_INVALID_OR_NO_CRC		BIT(3)
+#define   AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
+#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
+#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
+#define   AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
+#define   AD3552R_MASK_MEM_CRC_EN			BIT(4)
+#define   AD3552R_MASK_SDO_DRIVE_STRENGTH		GENMASK(3, 2)
+#define   AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
+#define   AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
+#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
+#define   AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
+#define   AD3552R_MASK_SAMPLE_HOLD_DIFF_USER_EN		BIT(5)
+#define   AD3552R_MASK_SAMPLE_HOLD_USER_TRIM		GENMASK(4, 3)
+#define   AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
+#define   AD3552R_MASK_REFERENCE_VOLTAGE_SEL		GENMASK(1, 0)
+#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
+#define   AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
+#define   AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
+#define   AD3552R_MASK_MEM_CRC_ERR_ALARM		BIT(4)
+#define   AD3552R_MASK_SPI_CRC_ERR_ALARM		BIT(3)
+#define   AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
+#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
+#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
+#define AD3552R_REG_ADDR_ERR_STATUS			0x17
+#define   AD3552R_MASK_REF_RANGE_ERR_STATUS		BIT(6)
+#define   AD3552R_MASK_STREAM_EXCEEDS_DAC_ERR_STATUS	BIT(5)
+#define   AD3552R_MASK_MEM_CRC_ERR_STATUS		BIT(4)
+#define   AD3552R_MASK_RESET_STATUS			BIT(0)
+#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
+#define   AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4 + (ch))
+#define   AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)	BIT(ch)
+#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
+#define   AD3552R_MASK_CH0_RANGE			GENMASK(2, 0)
+#define   AD3552R_MASK_CH1_RANGE			GENMASK(6, 4)
+#define   AD3552R_MASK_CH_OUTPUT_RANGE			GENMASK(7, 0)
+#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch) \
+		((ch) ? GENMASK(7, 4) : GENMASK(3, 0))
+#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B + (ch) * 2)
+#define   AD3552R_MASK_CH_OFFSET_BITS_0_7		GENMASK(7, 0)
+#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) * 2)
+#define   AD3552R_MASK_CH_RANGE_OVERRIDE		BIT(7)
+#define   AD3552R_MASK_CH_GAIN_SCALING_N		GENMASK(6, 5)
+#define   AD3552R_MASK_CH_GAIN_SCALING_P		GENMASK(4, 3)
+#define   AD3552R_MASK_CH_OFFSET_POLARITY		BIT(2)
+#define   AD3552R_MASK_CH_OFFSET_BIT_8			BIT(8)
+/*
+ * Secondary region
+ * For multibyte registers specify the highest address because the access is
+ * done in descending order
+ */
+#define AD3552R_SECONDARY_REGION_START			0x28
+#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
+#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C - (1 - (ch)) * 2)
+#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
+#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
+#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
+#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
+#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 - (ch)) * 2)
+/* 3 bytes registers */
+#define AD3552R_REG_START_24B				0x37
+#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
+#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D - (1 - (ch)) * 3)
+#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
+#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
+#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
+#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
+#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - (ch)) * 3)
+
+#define AD3552R_MAX_CH					2
+#define AD3552R_MASK_CH(ch)				BIT(ch)
+#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
+#define AD3552R_MAX_REG_SIZE				3
+#define AD3552R_READ_BIT				BIT(7)
+#define AD3552R_ADDR_MASK				GENMASK(6, 0)
+#define AD3552R_MASK_DAC_12B				GENMASK(15, 4)
+#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
+#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
+#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
+#define AD3552R_GAIN_SCALE				1000
+#define AD3552R_LDAC_PULSE_US				100
+
+#define AD3552R_MAX_RANGES	5
+#define AD3542R_MAX_RANGES	6
+
+extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
+extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
+
+enum ad3552r_id {
+	AD3541R_ID = 0x400b,
+	AD3542R_ID = 0x4009,
+	AD3551R_ID = 0x400a,
+	AD3552R_ID = 0x4008,
+};
+
+struct ad3552r_model_data {
+	const char *model_name;
+	enum ad3552r_id chip_id;
+	unsigned int num_hw_channels;
+	const s32 (*ranges_table)[2];
+	int num_ranges;
+	bool requires_output_range;
+};
+
+struct ad3552r_ch_data {
+	s32	scale_int;
+	s32	scale_dec;
+	s32	offset_int;
+	s32	offset_dec;
+	s16	gain_offset;
+	u16	rfb;
+	u8	n;
+	u8	p;
+	u8	range;
+	bool	range_override;
+};
+
+enum ad3552r_ch_gain_scaling {
+	/* Gain scaling of 1 */
+	AD3552R_CH_GAIN_SCALING_1,
+	/* Gain scaling of 0.5 */
+	AD3552R_CH_GAIN_SCALING_0_5,
+	/* Gain scaling of 0.25 */
+	AD3552R_CH_GAIN_SCALING_0_25,
+	/* Gain scaling of 0.125 */
+	AD3552R_CH_GAIN_SCALING_0_125,
+};
+
+enum ad3552r_ch_vref_select {
+	/* Internal source with Vref I/O floating */
+	AD3552R_INTERNAL_VREF_PIN_FLOATING,
+	/* Internal source with Vref I/O at 2.5V */
+	AD3552R_INTERNAL_VREF_PIN_2P5V,
+	/* External source with Vref I/O as input */
+	AD3552R_EXTERNAL_VREF_PIN_INPUT
+};
+
+enum ad3542r_ch_output_range {
+	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
+	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
+	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
+	AD3542R_CH_OUTPUT_RANGE_0__3V,
+	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
+	AD3542R_CH_OUTPUT_RANGE_0__5V,
+	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_0__10V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
+	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+};
+
+enum ad3552r_ch_output_range {
+	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
+	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
+	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
+	AD3552R_CH_OUTPUT_RANGE_0__5V,
+	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
+	AD3552R_CH_OUTPUT_RANGE_0__10V,
+	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
+	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
+	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
+};
+
+int ad3552r_get_output_range(struct device *dev,
+			     const struct ad3552r_model_data *model_info,
+			     struct fwnode_handle *child, u32 *val);
+int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
+			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs);
+u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs);
+int ad3552r_get_ref_voltage(struct device *dev, u32 *val);
+int ad3552r_get_drive_strength(struct device *dev, u32 *val);
+void ad3552r_calc_gain_and_offset(struct ad3552r_ch_data *ch_data,
+				  const struct ad3552r_model_data *model_data);
+
+#endif /* __DRIVERS_IIO_DAC_AD3552R_H__ */

-- 
2.45.0.rc1


