Return-Path: <linux-iio+bounces-26363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EFC786DB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 11:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 08E41323D6
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14D34AB07;
	Fri, 21 Nov 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cfA84AlS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCD30C636;
	Fri, 21 Nov 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719209; cv=none; b=uRphxvZFkuusHMnHS3WifrtbfMxZoS9d1jSuoLbClbV8wU1/UAJlTrpEpZ1Un4pXWF+JX+cbyRe7nSlgcCLimcujmCMvwoprJNR+8qz1n5wmVZTqUS5AX6l0jgnzQYRiqrPD4J/7MxLThW0xIIZvWe27aztpGoE/8eWSO4IAzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719209; c=relaxed/simple;
	bh=b5r1NAmyQjRNCU11owh2ozDZ3T9LNomz4EoNbpmT44E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdeTa+V6beFHALqJ9v8OspI6VcNmK5qiJq/lRrW5cbMHdqkvf+3HPqCe0mlEpw7guWa8A9CJPPIXv9exnA+ygELC9ETXKrJB/OxsLBG3gjcsSntNVRDWRlj9owINiYuC96+bkQz13eeqaANHPHF6DjrAf5G87rahHnNyFIuY+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cfA84AlS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6KKKU2556779;
	Fri, 21 Nov 2025 05:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QOWGL
	8hWgVx0NQcDiIEm3cVbPm7ASlxqAGJFb1yGqhw=; b=cfA84AlSfgERFG2MRAtOv
	uE52b9gKXKQwq/v98KwP0F8ugCq0RQfPrriBG8AhMSPGPFW6gwLbXt5GEhO2DOIF
	Ry/o+UBH6KXeNx8Ca8RpdlnY2bO2/neVTLCyxvUGy/MqdwB+xciYgW0yipbZgfhE
	MElhkRNHrJ1jOeFFzFp3BZpQi8XbcqanZ5c4Q/x1//AlcspUy4YODVE8jSrmnEOm
	KnD/zXNbO9CQrn+WFFdKKlFzTnAWul8d1v1c5+uj47zA7b8e0XqAX5GgWnomjnq0
	hhdohgezrGjUO1VKI4g9V3/v/gI2Yxz0JPe0PQjKbDNUu3qsfTogJaTW1Pw50bTy
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ajjqjrwdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:00:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5ALA02gC015330
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 05:00:02 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 05:00:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 05:00:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 05:00:02 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9xo96027151;
	Fri, 21 Nov 2025 04:59:57 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [RESEND PATCH v2 2/2] iio: frequency: adf4377: add clk provider support
Date: Fri, 21 Nov 2025 09:59:33 +0000
Message-ID: <20251121095933.19032-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121095933.19032-1-antoniu.miclaus@analog.com>
References: <20251121095933.19032-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: S_x1Sdo_QV8GZOx05Gz-mHMP6FRzhpLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX95XNdNdlJZVM
 WieHE70+6MrCsWkcsAWNKl/5tueyy154GXxp30+zmvDOk2jPUOGbOvjrlUL7NpmrwCX2lhBKsPZ
 VqeN5mxaeS9gQ08d+kXVG9/inBCPXQ/pT30OVSrnU0x2Y1Hp7HlfhXed6LjrdgypnBp0kuYfRuB
 kEmQDaXW3kRzfYUZkwrdKQYkooQjKLX745lQSfToDIgNJzap1KuTwcLbAApFCl7YOltGHo56y7k
 qhPsQhQ2yXpyqZrmdLkouxNcpa7KCtntORrf3HYVDtv78AcydZK12Kl3EOlyqfBVLmWsz7F/r0p
 a69rGTvz3+YcBVv3LLewFrZXVQqtWqu0G2CO6yWT1RJ8+QXQZLyLlWGrGisKcYr2YL72Kjl6shy
 1TOQiBDNmnc3OFoqbNMfINveueCjvw==
X-Proofpoint-ORIG-GUID: S_x1Sdo_QV8GZOx05Gz-mHMP6FRzhpLz
X-Authority-Analysis: v=2.4 cv=ffygCkQF c=1 sm=1 tr=0 ts=69203823 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=I9ctbcXp8itbP4OmBmcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076

Add clk provider feature for the adf4377.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- Replace deprecated .is_enabled clock operation with .is_prepared
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


