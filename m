Return-Path: <linux-iio+bounces-17869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A30A824CE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546A119E00D4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D322620F5;
	Wed,  9 Apr 2025 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="L5ZSYsuJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4B2620C8;
	Wed,  9 Apr 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201554; cv=none; b=hUE9v5XL/hK4fXhGxXbite2pAfhxfK/FY/QA384GlRV7wHg0thomr8ymt/Jt80FAsrwGYcjLwfscupSi6wU1MOgzld9lUIIPco13TmXd1ivDA/A3e2RJJ104lfWMj8vQYrjNkIhxkvOrAzRTW0OzjqFKCgnr7IAd4ERAavBswbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201554; c=relaxed/simple;
	bh=tYJnQ974Zys7Ol/8cY+C5mpYQQIzGOy9TOcyoP6Rsj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q326rBEifcWxDN4zXU+2qXAlbndNc91CdnUTIaVULnLlrglXkR+crby4uqDTxPizmkoblnpnsFdgTIVlKLMlgu0ErI44ALXeDX69zDOkDZuwkZ+FUGlsP/U/QaKbXJLiZIGJemoKtM45y+KEangVbbeRd+xsNUaz4tahqXfs2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=L5ZSYsuJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5398mI2B009329;
	Wed, 9 Apr 2025 08:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6OGho
	wcTsy6Jc5v1+rS984AXxVoNr3xwOkUgP6ehtb8=; b=L5ZSYsuJRrIWahAyGUseV
	dqNn7Lmw1sa4VeryIHOQIghkcnRmsmxYf4VcB5+uj3xMtPA4AZNwZ99qaW6hNqr+
	rCkYnpOd2dH3VzeN5zC89BepGL/RmuAZ+7iIIdN0SqDk02nunA9c+0rUdJ0frMtd
	WX9Lqb1h12F2cDZEiwG7/DUy2OMtBM9a/1cWwZxMdk4tKoNASvc3z2wG51aR77Te
	ozgnH8iw+mq9TqRX6VpQF4UH5L8HdMaCouTcPI73EnQjUYaEQbXZHWENa8N9MAt3
	fc6xXgbM90k89TSBn8535NkRjuO/IjxuXXNecrSVxvj9JxvLEoPJaJN6I7OHMKeZ
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45vvjr0sk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:25:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 539CPYSo052331
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:25:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 9 Apr 2025
 08:25:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:25:34 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539CPL38016956;
	Wed, 9 Apr 2025 08:25:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 4/7] iio: adc: ad4170: Add clock provider support
Date: Wed, 9 Apr 2025 09:25:20 -0300
Message-ID: <65b71e307d37b8e3e26937a1e67398b2af0af399.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Var3PEp9 c=1 sm=1 tr=0 ts=67f66740 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=EjOB5vySZ_iNcyL_diIA:9
X-Proofpoint-ORIG-GUID: 6mE6HjjgTNH3pENmI9tujKMr46M-clYa
X-Proofpoint-GUID: 6mE6HjjgTNH3pENmI9tujKMr46M-clYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090074

The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
the AD4170 can provide it's 16 MHz internal clock at the XTAL2 pin. Extend
the AD4170 driver so it effectively uses the provided external clock, if
any, or supplies it's own clock as a clock provider.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4170.c | 135 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 5ffcdedf3e7f..97cf4465038f 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -7,6 +7,8 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -62,6 +64,7 @@
 #define AD4170_DATA_16B_STATUS_REG			0x1A
 #define AD4170_DATA_24B_REG				0x1E
 #define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_CLOCK_CTRL_REG				0x6B
 #define AD4170_ADC_CTRL_REG				0x71
 #define AD4170_CHAN_EN_REG				0x79
 #define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
@@ -89,6 +92,9 @@
 #define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
 #define AD4170_PIN_MUXING_SYNC_CTRL_MSK			GENMASK(3, 2)
 
+/* AD4170_CLOCK_CTRL_REG */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
+
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
 #define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
@@ -121,6 +127,12 @@
 
 /* AD4170 register constants */
 
+/* AD4170_CLOCK_CTRL_REG constants */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT			0x0
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT		0x1
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT			0x2
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT_XTAL		0x3
+
 /* AD4170_CHAN_MAP_REG constants */
 #define AD4170_CHAN_MAP_AIN0			0
 #define AD4170_CHAN_MAP_AIN1			1
@@ -238,6 +250,10 @@ enum ad4170_regulator {
 	AD4170_MAX_SUP
 };
 
+static const char *const ad4170_clk_sel[] = {
+	"ext-clk", "xtal"
+};
+
 enum ad4170_int_pin_sel {
 	AD4170_INT_PIN_SDO,
 	AD4170_INT_PIN_DIG_AUX1,
@@ -320,6 +336,9 @@ struct ad4170_state {
 	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
 	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
 	u32 mclk_hz;
+	unsigned int clock_ctrl;
+	struct clk *ext_clk;
+	struct clk_hw int_clk_hw;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
@@ -1693,13 +1712,127 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
+	return regmap_write(st->regmap16, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
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
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct clk_init_data init = {};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name = fwnode_get_name(fwnode);
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
+	return 0;
+}
+
 static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
 	int reg_data, ret, i;
 
-	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = ad4170_clock_select(indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
+
+	ret = regmap_write(st->regmap16, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
 		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
-- 
2.47.2


