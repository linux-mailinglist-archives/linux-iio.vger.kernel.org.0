Return-Path: <linux-iio+bounces-21161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABEAEDFF3
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E307A7F1E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC128BABA;
	Mon, 30 Jun 2025 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="E1morB8L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA328B7E9;
	Mon, 30 Jun 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292078; cv=none; b=DyQfLeO5cwojeITwrnfAbtiFAL3cxdFyuopQvqYZcqlm8qKrTzFTDr2YjEt95jh97fWHu8gGDI7IKzeFpEDa9D3ELSTMbRTNdRWlnu4uyk6U+KHyDM1jX9nJ8pQI8hXzkf3JTzpPDbHuJHQUh0ewkN87v2T5aeSuQLO6cmE3XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292078; c=relaxed/simple;
	bh=FPcZ1vLEyLErGb6BmASRsUypJFZAzsK0gcRC7yUSLEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXKxz6Ybz50fMksvruOf3K7HEJw/C/PFc6mmnB/kTOdF2jz9x7XW8zsB4JF9KWS8lSGdbdJSkYbapMlM/l37mprUmYOHD930QJ626TAPJiBLNGjqZZFHjhN4Pi0bD771Xui6xYufgt1UZMLm4ScFS15KXDJxQ5qSv2Hu6Img1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=E1morB8L; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDllEK026511;
	Mon, 30 Jun 2025 10:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a0mXz
	SQh+Byve8aYvjlNc1VGRmBiX6qc17OIZgRIty4=; b=E1morB8LfGx+myE0s3R2/
	zCs2CwbZwhWZeoNoJyI/uxSKVPAjQ0zy/IPUjDkwDlbxxt5f0wP4pGq4nIZj7jfh
	LmWUT4O4M7UnuG24Wdms5ZZqdtCdfV2BILP63KDv3dcP7krarp95xzWs+BB/Xahi
	gJH28TdB+ylIMprV5cWMHrwpr5mBm8I72VsqG5lJWZyFgWvJzYbKgp8znIaVRC8Q
	jYdx5AEF0/IMA88fx0yX2Ko7EML93C6RCv8Hzl+gbJ71OsZKhcyroxZrnDqkH0v9
	6IS6SWv00jMCMQ1mJnRGN/N5JQ1vJVDPjy6K3bK7RNn2vV0+pW3eGiWRLX5mRdhP
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47krqa10jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:00:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UE0qMq039851
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 10:00:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:00:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:00:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 10:00:52 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UE0XFo009103;
	Mon, 30 Jun 2025 10:00:36 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 08/12] iio: adc: ad4170-4: Add clock provider support
Date: Mon, 30 Jun 2025 11:00:32 -0300
Message-ID: <3373d02579fb3f2c45f845984b2cf9b979221fb8.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfXy45lSMYlr7G2
 cIDlW8SujRYjy+3yHZc49TjQPW/6Fpt+1wo2d6Tv2boFJ43GpdsgCfwW4Zb+uuR+8HXY8GObBeP
 uFRMp/pVJRR5OddNZl96AuPjeE9A6SGftqes6UMuo/tbf0Tpfsa39IrV8iZvABWQxXQTLM/OzdZ
 wbbqRbIVXEqEyYhS0PjeK4BsfvZ8hdTiMlu85gCgFOs3AO5+lP/xlyyeAAnNclrf7xGTM6d3pKE
 IQL9XM1m2wtbEZxm0enZVX0qM6DuAJoQUpdN+tSRomu/88pyuvtPBc1K+tMSfjyhGcmYWjNOLdR
 AZ9qVos85R2jpEpbEN3aZNtGLFwzKn4GLfrGx8B7RPgJZ06s+qqCbEZnKdmLeLCDhPAjW49mdFq
 XtqIYf+X2oiMsgw8C7KzwkFnyaKrqx7mKTA7AgxiEbVQiibwKTgFp0aooiXXXBuBjmu8FKvp
X-Proofpoint-GUID: osX5q-y1O1ZURLfIBEwXZEhq117u8_Hu
X-Proofpoint-ORIG-GUID: osX5q-y1O1ZURLfIBEwXZEhq117u8_Hu
X-Authority-Analysis: v=2.4 cv=U8+SDfru c=1 sm=1 tr=0 ts=68629895 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=FbnkXhljGIpD8s1dgEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

The AD4170-4 chip can use an externally supplied clock at the XTAL2 pin, or
an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
the AD4170-4 can provide its 16 MHz internal clock at the XTAL2 pin. In
addition, the chip has a programmable clock divider that allows dividing
the external or internal clock frequency, however, control for that is not
provided in this patch. Extend the AD4170-4 driver so it effectively uses
the provided external clock, if any, or supplies its own clock as a clock
provider.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v6.

 drivers/iio/adc/Kconfig    |   1 +
 drivers/iio/adc/ad4170-4.c | 147 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 538929b3df6e..36e506e8d8f1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -91,6 +91,7 @@ config AD4170_4
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	depends on COMMON_CLK
 	help
 	  Say yes here to build support for Analog Devices AD4170-4 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 9202a8dfcc16..bf261d4ef67d 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -13,6 +13,8 @@
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -55,6 +57,7 @@
 #define AD4170_CONFIG_A_REG				0x00
 #define AD4170_DATA_24B_REG				0x1E
 #define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_CLOCK_CTRL_REG				0x6B
 #define AD4170_ADC_CTRL_REG				0x71
 #define AD4170_CHAN_EN_REG				0x79
 #define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
@@ -75,6 +78,9 @@
 /* AD4170_PIN_MUXING_REG */
 #define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
 
+/* AD4170_CLOCK_CTRL_REG */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
+
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
 #define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
@@ -102,6 +108,12 @@
 
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
@@ -149,6 +161,8 @@
 
 /* Internal and external clock properties */
 #define AD4170_INT_CLOCK_16MHZ				(16 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * HZ_PER_MHZ)
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
@@ -166,6 +180,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
 	[AD4170_PIN_MUXING_REG] = 2,
+	[AD4170_CLOCK_CTRL_REG] = 2,
 	[AD4170_ADC_CTRL_REG] = 2,
 	[AD4170_CHAN_EN_REG] = 2,
 	/*
@@ -238,6 +253,10 @@ enum ad4170_regulator {
 	AD4170_MAX_SUP,
 };
 
+static const char *const ad4170_clk_sel[] = {
+	"ext-clk", "xtal",
+};
+
 enum ad4170_int_pin_sel {
 	AD4170_INT_PIN_SDO,
 	AD4170_INT_PIN_DIG_AUX1,
@@ -340,6 +359,8 @@ struct ad4170_state {
 	struct completion completion;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
+	struct clk_hw int_clk_hw;
+	unsigned int clock_ctrl;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1623,13 +1644,137 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
+	struct clk *ext_clk;
+	int ret;
+
+	ext_clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(ext_clk))
+		return dev_err_probe(dev, PTR_ERR(ext_clk),
+				     "Failed to get external clock\n");
+
+	if (!ext_clk) {
+		/* Use internal clock reference */
+		st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+		st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+					     AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
+
+		if (!device_property_present(&st->spi->dev, "#clock-cells"))
+			return 0;
+
+		return ad4170_register_clk_provider(indio_dev);
+	}
+
+	/* Read optional clock-names prop to specify the external clock type */
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad4170_clk_sel,
+						    ARRAY_SIZE(ad4170_clk_sel));
+
+	ret = ret < 0 ? 0 : ret; /* Default to external clock if no clock-names */
+	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+				     AD4170_CLOCK_CTRL_CLOCKSEL_EXT + ret);
+
+	st->mclk_hz = clk_get_rate(ext_clk);
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
 	struct device *dev = &st->spi->dev;
 	int reg_data, ret;
 
-	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = ad4170_clock_select(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
+
+	ret = regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+	if (ret)
+		return ret;
 
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
-- 
2.47.2


