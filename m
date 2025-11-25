Return-Path: <linux-iio+bounces-26455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E644C85D58
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0D2C34F12F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F63210F59;
	Tue, 25 Nov 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j2S/ekBa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFC1DF246;
	Tue, 25 Nov 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764085734; cv=none; b=J3Pqk5FmW3406GSfhI7ASGaoejC8yKVtL8FwiDufShNODy7XpBpINEuxpIHFFk0oQn/SMSKYeNcBzQ0+7u5xpu+yyhOLF/IgX8fRbFpkH8j37SNdYLhSC6YyFUL+KLJLw/Al3d0shOSQc+ztmLESym6CWCG1FX1cwjH/XNVD4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764085734; c=relaxed/simple;
	bh=A+cHX4OWdpsJVrxoqQ6SFODR+TyBkPxuFCtib1swiEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwyzyJRVnCeEfNQfy8PzrxFGx0Q173gpSLiwNzcODK6o658ZG+cxmtpJ0JysWLC7m1ncXiJdffurmSISLye0k5vAA7TwLpfaa5/c1cIuYGb9nR4QpkqXmlwO6mfFpmtKJ/EvO6JcVVR2iGBzDl9a8ciXSxqi5W9zA2G4tZFXAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j2S/ekBa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APC6S5n043338;
	Tue, 25 Nov 2025 10:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TsexF
	ZjiIfs7swlGB616yquPEzzWSSxAARqJyEfwaBw=; b=j2S/ekBawXvwwjfpArpBj
	gd6r+grDqS57uuqZMyAEpE6apFEBAcihlx/nwW5yM1eAr8WJjylgYb4ZrR4h4Sv9
	eUIdrFFDBpWMag1K64bO0RK9PGxrpecNbPUmC0J+rJEBNvNwKQwMoqAtfVbK2lls
	xgU9YKZlf5OYafR+sR74nEElHJRlpD4aIly7IL52Tm1CCVucItieJX4t240zkhxt
	tan0NRSYkD7D2HKGT5G0J+OI0eHEEKuoqDRjUi/b3+BvP/FFcXSCYU2E4aqL9oq2
	BbeZhkc67pvUusGs6sfoIGpYH1Hob35giV2uSG2xkDc4YHbFjOObgIHStu10v+uG
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4amv1gnj31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 10:48:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5APFmVU3016032
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Nov 2025 10:48:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 25 Nov
 2025 10:48:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 25 Nov 2025 10:48:31 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.177])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5APFmAEH021473;
	Tue, 25 Nov 2025 10:48:22 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v3 2/2] iio: frequency: adf4377: add clk provider support
Date: Tue, 25 Nov 2025 17:47:36 +0200
Message-ID: <20251125154738.55869-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125154738.55869-1-antoniu.miclaus@analog.com>
References: <20251125154738.55869-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEzMSBTYWx0ZWRfX/zEkoTFJbrKt
 n66bH8HpCzFmU6ESgeVXMxrHD04IH2xi41sGKrLT8EYzsOEmzMqRtGHI9AoY1n/B6D7DvFmWA1j
 Ep84xXmS8DC8J6VyTVRxz+FEdxnhYAQEmy71jVpuna8DNQ8A1xGn6vpvQjh93bhf/gfdglNHcuw
 t6ccmT48+VvrfOjYWhmnwkd8+WXIm/6ETb1eSeThpy75hh564jl6CUIykIv3D40ezhQ1aB/dNqW
 gXanm7Eed+9aXWT5EfJCDyuZkT4Km8Gra4of4yZ392eCdwLUVKZH9JR+PpFO1gDZ1JuQyfmBiYq
 BiFPbM+1bM7ISd08SNn7WcRSEk4LQGIFIi/OOwGqhbGxAbsn8VyFXKYFnBaJMMMflzyQlheAgDM
 kDllli3rNwjq4VdMKKWdVdbrcL9cdQ==
X-Authority-Analysis: v=2.4 cv=D9hK6/Rj c=1 sm=1 tr=0 ts=6925cfd0 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=VGjn6xsyVdTJQteVSj0A:9
X-Proofpoint-ORIG-GUID: xgvaiYifUmsinv0mCy18oNJamAiwRECr
X-Proofpoint-GUID: xgvaiYifUmsinv0mCy18oNJamAiwRECr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511250131

Add clk provider feature for the adf4377.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
 - Replace .is_enabled clock operation with .is_prepared
 - Use modern devm_clk_hw_register() instead of devm_clk_register()
 - Switch to clk_parent_data with fw_name instead of parent_names array
 - Use devm_of_clk_add_hw_provider() with of_clk_hw_simple_get for modern DT integration
 - Fix indentation alignment in adf4377_clk_recalc_rate function parameter
 - Remove manual clock provider cleanup by using devm_* variants
 drivers/iio/frequency/adf4377.c | 119 +++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..045747351ed7 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -435,9 +436,14 @@ struct adf4377_state {
 	struct gpio_desc	*gpio_ce;
 	struct gpio_desc	*gpio_enclk1;
 	struct gpio_desc	*gpio_enclk2;
+	struct clk		*clk;
+	struct clk		*clkout;
+	struct clk_hw		hw;
 	u8			buf[2] __aligned(IIO_DMA_MINALIGN);
 };
 
+#define to_adf4377_state(h)	container_of(h, struct adf4377_state, hw)
+
 static const char * const adf4377_muxout_modes[] = {
 	[ADF4377_MUXOUT_HIGH_Z] = "high_z",
 	[ADF4377_MUXOUT_LKDET] = "lock_detect",
@@ -929,6 +935,108 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static unsigned long adf4377_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct adf4377_state *st = to_adf4377_state(hw);
+	u64 freq;
+	int ret;
+
+	ret = adf4377_get_freq(st, &freq);
+	if (ret)
+		return 0;
+
+	return freq;
+}
+
+static int adf4377_clk_set_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct adf4377_state *st = to_adf4377_state(hw);
+
+	return adf4377_set_freq(st, rate);
+}
+
+static int adf4377_clk_prepare(struct clk_hw *hw)
+{
+	struct adf4377_state *st = to_adf4377_state(hw);
+
+	return regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_MSK |
+				  ADF4377_001A_PD_CLKOUT2_MSK,
+				  FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
+				  FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
+}
+
+static void adf4377_clk_unprepare(struct clk_hw *hw)
+{
+	struct adf4377_state *st = to_adf4377_state(hw);
+
+	regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_MSK |
+			   ADF4377_001A_PD_CLKOUT2_MSK,
+			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 1) |
+			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 1));
+}
+
+static int adf4377_clk_is_prepared(struct clk_hw *hw)
+{
+	struct adf4377_state *st = to_adf4377_state(hw);
+	unsigned int readval;
+	int ret;
+
+	ret = regmap_read(st->regmap, 0x1a, &readval);
+	if (ret)
+		return ret;
+
+	return !(readval & (ADF4377_001A_PD_CLKOUT1_MSK | ADF4377_001A_PD_CLKOUT2_MSK));
+}
+
+static const struct clk_ops adf4377_clk_ops = {
+	.recalc_rate = adf4377_clk_recalc_rate,
+	.set_rate = adf4377_clk_set_rate,
+	.prepare = adf4377_clk_prepare,
+	.unprepare = adf4377_clk_unprepare,
+	.is_prepared = adf4377_clk_is_prepared,
+};
+
+static int adf4377_clk_register(struct adf4377_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct clk_init_data init;
+	struct clk_parent_data parent_data;
+	int ret;
+
+	if (!device_property_present(&spi->dev, "#clock-cells"))
+		return 0;
+
+	if (device_property_read_string(&spi->dev, "clock-output-names", &init.name)) {
+		init.name = devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
+					   fwnode_get_name(dev_fwnode(&spi->dev)));
+		if (!init.name)
+			return -ENOMEM;
+	}
+
+	parent_data.fw_name = "ref_in";
+
+	init.ops = &adf4377_clk_ops;
+	init.parent_data = &parent_data;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_PARENT;
+
+	st->hw.init = &init;
+	ret = devm_clk_hw_register(&spi->dev, &st->hw);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(&spi->dev, of_clk_hw_simple_get, &st->hw);
+	if (ret)
+		return ret;
+
+	st->clkout = st->hw.clk;
+
+	return 0;
+}
+
 static const struct adf4377_chip_info adf4377_chip_info = {
 	.name = "adf4377",
 	.has_gpio_enclk2 = true,
@@ -958,8 +1066,6 @@ static int adf4377_probe(struct spi_device *spi)
 
 	indio_dev->info = &adf4377_info;
 	indio_dev->name = "adf4377";
-	indio_dev->channels = adf4377_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
 
 	st->regmap = regmap;
 	st->spi = spi;
@@ -979,6 +1085,15 @@ static int adf4377_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = adf4377_clk_register(st);
+	if (ret)
+		return ret;
+
+	if (!st->clkout) {
+		indio_dev->channels = adf4377_channels;
+		indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
+	}
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
-- 
2.43.0


