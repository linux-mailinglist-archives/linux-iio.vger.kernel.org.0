Return-Path: <linux-iio+bounces-10559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49899C6D6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAB71C227FB
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C019CC09;
	Mon, 14 Oct 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QJHuIwEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114E15B14B
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900588; cv=none; b=AKjHoM6t9ocW5pC5bZm+sUIyQ+GaYusrIIpnN1ZFbB585JD0UiPUFygy2J7IW+vLJqIQhSq1PWz1PcqFDE1juqH5aLMadBpy+tCaIM19tScvg13QRYaNQi5ec+ZxeLkJw265hXNWReh60otXPF8RFAWCYRJ7Ez+86UqIpcGZWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900588; c=relaxed/simple;
	bh=btxIC9chTWHoE9mgFELsdtnmsEYy90ISDiD7eimMb7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWH2MtrqjGPGtnvk1kFoV+X2em3IF9NppB3vgrtGoo2HQ0XzeCz7gJ9+e8GZoxHhhPIXGsXgHAtkcqCZZZ/67+zvAl/0b79zNyXQwlJJUKVF4ER5SmDptB9bJ0hk5BYoDuI14zOiKEOkEy+yaNqGqSJnk/TCUWOOHQXdYMCqdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QJHuIwEr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so45781415e9.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900584; x=1729505384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GitRDvrsBquAzw9PJ62PgkaSy+LZKmkG9HCkmbWq6wM=;
        b=QJHuIwErpZrTJOrwQ1lOXxzysKu8hRkDLn24C5CNdjnkwNQgVNbKqLUmtEGAOe34LW
         KExre2T81EUdSOf7575XwcuCTgPjrGqRe5nBHndLYGx2aKToeF5E1X8esyCDnyzuc+xm
         aXAwEtMpIxI60GC2uVCEIvnDtd3/QJiy/D8/1Sj24n6RuOlAzB17ekztvz7RrJQu6QX5
         AWY10hq0yIQqaCnwYO3r7Pu5wLvQjDfzTPHod+HEdwqDOtPTVMqJIDnQcEU7KHvlQNrk
         C8H+yPsTVTBzf2MbJZ6QoFVy+k+Pi6tj1mLZKs+lj0d2cpSnAVVSGR+1/0/9+XDXnqTa
         yv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900584; x=1729505384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GitRDvrsBquAzw9PJ62PgkaSy+LZKmkG9HCkmbWq6wM=;
        b=n7C8qlYaigtF7ZHI0O6tOK9+YBXAHtBn5DUVEHoc2N3uy7CqrYKE73diT4q8KFPNuR
         G/p9fL9BzhyfYhc2eStLIqTJoDN3+r5jDUzunxY3R6SpEGY0tT6lKwWD3OsZR5h6tnBv
         F11fhALY8gCEiktPY9bHV6wEGWo1d3//IBbllkOvpfyGuNJ1ulHRo64UiUmK/tYefss7
         kNkCvdAnwty8siHS6SJfEdZE3vlKR6CsqZ5OUGf4dVm33f9W8RyN/a3hq5kGGcTMELcs
         YrAaUbUibHEmH2/7fo3SR9vUwoseGSfKi9kzoyip93nhlvNy0DXt2Eeh0mVVxRbd41vS
         wgoQ==
X-Gm-Message-State: AOJu0Yx4c3+QB6v8yWnnCa+eWoEuNry+d56QbKShSAfbVr8DllEgwGwB
	mXyHm0s++hur93x7bzNE+iErmW6z+5aQuxTF2Q275wy53Ux/aUf1X0k3mxyPSmI=
X-Google-Smtp-Source: AGHT+IGRMAiu5CTtIL9Fv4I/x6chPinCnKS3sarFWWx5brJaJtafo0Sw8xfl5Ptuhi2nnMwf5Q+VqQ==
X-Received: by 2002:a05:600c:996:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-431256079b8mr94610975e9.28.1728900584197;
        Mon, 14 Oct 2024 03:09:44 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:43 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:12 +0200
Subject: [PATCH v6 6/8] iio: dac: ad3552r: extract common code (no changes
 in behavior intended)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-6-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Extracting common code, to share common code to be used later
by the AXI driver version (ad3552r-axi.c).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Makefile         |   2 +-
 drivers/iio/dac/ad3552r-common.c | 170 ++++++++++++++++++++++
 drivers/iio/dac/ad3552r.c        | 303 ++++-----------------------------------
 drivers/iio/dac/ad3552r.h        | 200 ++++++++++++++++++++++++++
 4 files changed, 398 insertions(+), 277 deletions(-)

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
index 000000000000..9a892abf99ac
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2010-2024 Analog Devices Inc.
+// Copyright (c) 2024 Baylibre, SAS
+
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
+EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, IIO_AD355R);
+
+const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
+	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
+	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
+	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
+};
+EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, IIO_AD355R);
+
+u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
+{
+	u16 reg;
+
+	reg = FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs(goffs));
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, goffs < 0);
+
+	return reg;
+}
+
+int ad3552r_get_ref_voltage(struct device *dev)
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
+			return AD3552R_INTERNAL_VREF_PIN_2P5V;
+		else
+			return AD3552R_INTERNAL_VREF_PIN_FLOATING;
+	}
+
+	if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
+		dev_warn(dev, "vref-supply must be 2.5V");
+		return -EINVAL;
+	}
+
+	return AD3552R_EXTERNAL_VREF_PIN_INPUT;
+}
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
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 6fb06e2e3193..ef200f95db12 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -11,185 +11,9 @@
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
+#include "ad3552r.h"
 
 enum ad3552r_ch_gain_scaling {
 	/* Gain scaling of 1 */
@@ -223,15 +47,6 @@ struct ad3552r_ch_data {
 	bool	range_override;
 };
 
-struct ad3552r_model_data {
-	const char *model_name;
-	enum ad3552r_id chip_id;
-	unsigned int num_hw_channels;
-	const s32 (*ranges_table)[2];
-	int num_ranges;
-	bool requires_output_range;
-};
-
 struct ad3552r_desc {
 	const struct ad3552r_model_data *model_data;
 	/* Used to look the spi bus for atomic operations where needed */
@@ -693,75 +508,35 @@ static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
 	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
 }
 
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
@@ -772,30 +547,19 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
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
+	err = ad3552r_get_ref_voltage(dev);
+	if (err < 0)
+		return err;
 
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
+	val = err;
 
 	err = ad3552r_update_reg_field(dac,
 				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
@@ -804,13 +568,8 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
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
@@ -835,21 +594,12 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
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
@@ -1072,3 +822,4 @@ module_spi_driver(ad3552r_driver);
 MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
 MODULE_DESCRIPTION("Analog Device AD3552R DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD3552R);
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
new file mode 100644
index 000000000000..088eb8ecfac6
--- /dev/null
+++ b/drivers/iio/dac/ad3552r.h
@@ -0,0 +1,200 @@
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
+#define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
+							 GENMASK(1, 0))
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
+#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ? \
+							 GENMASK(7, 4) : \
+							 GENMASK(3, 0))
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
+/* Useful defines */
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
+int ad3552r_get_ref_voltage(struct device *dev);
+int ad3552r_get_drive_strength(struct device *dev, u32 *val);
+
+#endif /* __DRIVERS_IIO_DAC_AD3552R_H__ */

-- 
2.45.0.rc1


