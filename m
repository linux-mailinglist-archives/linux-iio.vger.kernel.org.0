Return-Path: <linux-iio+bounces-19492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD693AB5509
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A302B7B557C
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47D28ECCB;
	Tue, 13 May 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p1kLs95g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C723957D;
	Tue, 13 May 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139783; cv=none; b=qcA3XPhpk5UpJS27V2tNXezIP94TqwsgcYgGrgzSuBoD/y760kukVvfE9vdS9tU45cUf39wWzcJr5pj0ajKeG6PMXsGUC8BX1xN1DlnbtdhoDGZ2TltmnYGoXd4DG+MDs6au0551dpDSSgTXHRlTJVL4j3muaob8OM/gI1rz79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139783; c=relaxed/simple;
	bh=g48L3w+JVLetESqqX32XneL1nuq5ExrV//oSXMzrWUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqJp4bIyEgtyguNYqpE5Ic0mDP2363DXRfEBzKOXwtZlF+2IEafhuQ459FGy9n+S/8zIrV+Ab09J1sf/4BfgH4BuenkxIE4mggwgjeyKBcwAKd85NC5ogIq+msDvJQE8a2zyBIvHvg/pI+8O0hqBeDrfDwOYLUIvE7QcMmZz4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p1kLs95g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9mUid024893;
	Tue, 13 May 2025 08:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lGATG
	YZcOXsxd+o4S9Rph4vKmg3hISyWeCh2thUI9s0=; b=p1kLs95gGVEG7vei/7F+s
	3ioPHBNmqwwUeka2URJ+qsJmugr8PYMMCZZOO8cLR7nx73rimR7f/PetxDlDSc94
	4Z1lxrsxb1c9pZLJytPerWVlLhhebGBpDqMwuOaWOoK+lK9evQ8i7NzhfAtxO6kv
	1oqbQxFoiY5BnS87ZFhtyndcOH3g+W+KdUzFE3GBlndpk8uEHKQf5iztd5VvuGO/
	GoxuI7/i0u0l0KIvP6HOh9yGQ9HYE8BUpkuzp+x2V3Hr8R91DbixsiQ9wJdryZOC
	f4ZGN0f6U/vPD8RzDut63gx+V7G+1xryobu9IoxfxCveXlXQDzGAL9A6OHtoiUqb
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46m3s98sub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:36:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCa2RT041171
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:36:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 May
 2025 08:36:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:36:02 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCZlON007532;
	Tue, 13 May 2025 08:35:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 07/10] iio: adc: ad4170: Add clock provider support
Date: Tue, 13 May 2025 09:35:46 -0300
Message-ID: <a0d049e5fbab5cdeff266da886fd765b2b0d1af1.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vYWJGd9iGDPRTdL50APjgEAkuL5jp5At
X-Authority-Analysis: v=2.4 cv=ZaUdNtVA c=1 sm=1 tr=0 ts=68233cb3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=NQW59FIc28cfkTJrcWIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vYWJGd9iGDPRTdL50APjgEAkuL5jp5At
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExNyBTYWx0ZWRfX8MIE+r9MQxhx
 Rb9dOdM/s9Zpwxl+wy0A3bgVv0UbvIaZxbXiTGPbd97T4MnzvtpAaOsb4jNF2r2x21GJYIpQ2P/
 zJ0wR6+/7xfM9ruZtKrkTnBT45A5VoYZtOTv12BGT3zWERH2sSWnpU12VyQ53bRY0cLyXSxVzzi
 FkRanCCFyMxzGH952VCYxjmq/1sVKpSPV5GfZk9kS7V1DCZ3r6O2xNqEbEnpAczxl9GjpOdbWT+
 04AK77V3ztB3RR5cwhe8NtxY2idYfvMHgEakTAK96aXZnSLHvhgDIPFCo9rzxlzZVD0udFS0Qvx
 LsdMrp3geeeTVcsRbgciOfKLCfenM5EC9hB5a5zjuM7/10rRgEYWvqqY/AYw+vNWGgHb2cot9pc
 7tojP1LKYIlr1l46agqV/By7NU3aWtPXJzK47jOS69nMoABI1TGiW9PrfXOME96uoQh4fh3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130117

The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
the AD4170 can provide its 16 MHz internal clock at the XTAL2 pin. Extend
the AD4170 driver so it effectively uses the provided external clock, if
any, or supplies its own clock as a clock provider.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- Applied minor changes according to v2 review.
- Avoid unmet dependencies by depending on COMMON_CLK rather than selecting that.
- Brought early external clock defines from early patches to this one.
- Picked up a review tag from v1 review that I failed to include in v2.

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4170.c | 144 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d3d3af862f8..6e4b14243599 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -77,6 +77,7 @@ config AD4170
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	depends on COMMON_CLK
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index e8856c911dfd..9ab6df002e5e 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -9,6 +9,8 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -49,6 +51,7 @@
 #define AD4170_CONFIG_A_REG				0x00
 #define AD4170_DATA_24B_REG				0x1E
 #define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_CLOCK_CTRL_REG				0x6B
 #define AD4170_ADC_CTRL_REG				0x71
 #define AD4170_CHAN_EN_REG				0x79
 #define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
@@ -69,6 +72,9 @@
 /* AD4170_PIN_MUXING_REG */
 #define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
 
+/* AD4170_CLOCK_CTRL_REG */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
+
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
 #define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
@@ -96,6 +102,12 @@
 
 /* AD4170 register constants */
 
+/* AD4170_CLOCK_CTRL_REG constants */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT			0x0
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT		0x1
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT			0x2
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT_XTAL		0x3
+
 /* AD4170_CHAN_MAP_REG constants */
 #define AD4170_CHAN_MAP_AIN(x)			(x)
 #define AD4170_CHAN_MAP_TEMP_SENSOR		17
@@ -142,6 +154,8 @@
 
 /* Internal and external clock properties */
 #define AD4170_INT_CLOCK_16MHZ				(16 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * HZ_PER_MHZ)
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
@@ -162,6 +176,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
 	[AD4170_PIN_MUXING_REG] = 2,
+	[AD4170_CLOCK_CTRL_REG] = 2,
 	[AD4170_ADC_CTRL_REG] = 2,
 	[AD4170_CHAN_EN_REG] = 2,
 	/*
@@ -227,6 +242,10 @@ enum ad4170_regulator {
 	AD4170_MAX_SUP
 };
 
+static const char *const ad4170_clk_sel[] = {
+	"ext-clk", "xtal",
+};
+
 enum ad4170_int_pin_sel {
 	AD4170_INT_PIN_SDO,
 	AD4170_INT_PIN_DIG_AUX1,
@@ -329,6 +348,9 @@ struct ad4170_state {
 	struct completion completion;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
+	struct clk_hw int_clk_hw;
+	struct clk *ext_clk;
+	unsigned int clock_ctrl;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1656,6 +1678,120 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static struct ad4170_state *clk_hw_to_ad4170(struct clk_hw *hw)
+{
+	return container_of(hw, struct ad4170_state, int_clk_hw);
+}
+
+static unsigned long ad4170_sel_clk(struct ad4170_state *st,
+				    unsigned int clk_sel)
+{
+	st->clock_ctrl &= ~AD4170_CLOCK_CTRL_CLOCKSEL_MSK;
+	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, clk_sel);
+	return regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+}
+
+static unsigned long ad4170_clk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return AD4170_INT_CLOCK_16MHZ;
+}
+
+static int ad4170_clk_output_is_enabled(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+	u32 clk_sel;
+
+	clk_sel = FIELD_GET(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, st->clock_ctrl);
+	return clk_sel == AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT;
+}
+
+static int ad4170_clk_output_prepare(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+
+	return ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
+}
+
+static void ad4170_clk_output_unprepare(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+
+	ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT);
+}
+
+static const struct clk_ops ad4170_int_clk_ops = {
+	.recalc_rate = ad4170_clk_recalc_rate,
+	.is_enabled = ad4170_clk_output_is_enabled,
+	.prepare = ad4170_clk_output_prepare,
+	.unprepare = ad4170_clk_output_unprepare,
+};
+
+static int ad4170_register_clk_provider(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct clk_init_data init = {};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	if (device_property_read_string(dev, "clock-output-names", &init.name)) {
+		init.name = devm_kasprintf(dev, GFP_KERNEL, "%pfw",
+					   dev_fwnode(dev));
+		if (!init.name)
+			return -ENOMEM;
+	}
+
+	init.ops = &ad4170_int_clk_ops;
+
+	st->int_clk_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &st->int_clk_hw);
+}
+
+static int ad4170_clock_select(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad4170_clk_sel,
+						    ARRAY_SIZE(ad4170_clk_sel));
+	if (ret < 0) {
+		/* Use internal clock reference */
+		st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+					     AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
+		return ad4170_register_clk_provider(indio_dev);
+	}
+
+	/* Use external clock reference */
+	st->ext_clk = devm_clk_get_enabled(dev, ad4170_clk_sel[ret]);
+	if (IS_ERR(st->ext_clk))
+		return dev_err_probe(dev, PTR_ERR(st->ext_clk),
+				     "Failed to get external clock\n");
+
+	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+				     AD4170_CLOCK_CTRL_CLOCKSEL_EXT + ret);
+
+	st->mclk_hz = clk_get_rate(st->ext_clk);
+	if (st->mclk_hz < AD4170_EXT_CLOCK_MHZ_MIN ||
+	    st->mclk_hz > AD4170_EXT_CLOCK_MHZ_MAX) {
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid external clock frequency %u\n",
+				     st->mclk_hz);
+	}
+
+	return 0;
+}
+
 static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
@@ -1663,7 +1799,13 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	int reg_data, ret;
 	unsigned int i;
 
-	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = ad4170_clock_select(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
+
+	ret = regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
 		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
-- 
2.47.2


