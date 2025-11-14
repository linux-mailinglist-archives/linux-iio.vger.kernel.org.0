Return-Path: <linux-iio+bounces-26220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A254C5D094
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2B724E7DB8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD624314D3D;
	Fri, 14 Nov 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O0NI//jb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7BA314A70;
	Fri, 14 Nov 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122212; cv=none; b=nb9H3gwuQvwXh9Oy2td6+5spn0StkOVTB4LugJod+udpSKUEyUfcJBbKFl4+TU4ZGokVa05YkpW4M0fwr1/Zz+pjub2IRjjctGTs+MxIqr+f3AFIuYLlOT8hXrKTG7Pg8ql7BuID/TBPjcpl09ROgztAI+KPRtFkUukp+bzkabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122212; c=relaxed/simple;
	bh=HAc/xn10cMvNrj7udzOuqVdwq77+2n6om11MvoL9Ydo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRV76MuLhOrfrVgWnKyll4vARAZz9496rxEvCjcCxzfJnl09gqdu6AoO6XQz+Xt70wzgxpWLLInrGbhyj4tFztOeUGErsge/3mT0cbye1wwJq9vwPAyZGf/kH5AceUCGqyStvFkNpmICDaIHXuGVIih9f6Ev5nSy9Ed1D+4PDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O0NI//jb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEA1iFw182654;
	Fri, 14 Nov 2025 07:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r1qbt
	qSdgoIFAE2l3CRrdhP7Abyiyjhy1QaEh6P9RcY=; b=O0NI//jbQqSuz/7FvzV7A
	MViNemScuAQV+pZBgquZPadXPAYmhJcFjspKzxDJ0Q7o3MmHZHVHNIfteJDxAAT3
	uFr8K2RrPy2A6xnke1sIjnBOmXBqUkyb7C/Qll+xRBJC9YuRBOwlT3G8OmsWeFwA
	N9DOysv55jlhNJABVmMbMD4ZyY1FD/JH4SiNOiJiS4s3S2JMZDHdG0dFOMf63/Jk
	x+2FaxKvPwWMxsv6Vz+MTer51ks2aCI6/vxYaAUcLJqLkbOmqy+itxC/iioZaHW1
	aO1VOYKK7YTWyj44M7Mkw3JDsJ4GcrJ05cmpfqY/DP0wEo1UiFiM+7WlbOvXmhqn
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ady1fhfc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 07:10:08 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AECA74e045510
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 07:10:07 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 07:10:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 14 Nov 2025 07:10:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 07:10:07 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEC9r21019558;
	Fri, 14 Nov 2025 07:10:01 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
Date: Fri, 14 Nov 2025 12:09:08 +0000
Message-ID: <20251114120908.6502-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114120908.6502-1-antoniu.miclaus@analog.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YcywJgRf c=1 sm=1 tr=0 ts=69171c20 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=nVjtjxfPRRi5vZi_wFUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: lkWrhNhuYcFaSdjwk7xGPEOJuxbnyMiM
X-Proofpoint-GUID: lkWrhNhuYcFaSdjwk7xGPEOJuxbnyMiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NyBTYWx0ZWRfXweV6WbONYK7w
 m3UociPOzoTplwLJba9qDgHrgAv8zvXoy/Q//WFifBVLOLDfChuF3DpqPaUoqClVeUJsBFLJybg
 5wQpoJ9nTzp3XUl4D+2YO0oPIUtFRLHYr0wF8oz0p+dcaURtwmcGZ1YuObLidMmXfjFLpQUwdrt
 K91vsU5TskyoabD4/l3hKApmI6nhRIbOi5XCOgogZiUwZE1qtyuzxl/9pJ3oppPJyGylBMg/8p3
 sHJrnm6RPHp6nopijELhXe6x0llxTR7qKITzNpHTSGzMqaxtaXZR1tLgoWaRn/dzggsIST4lcCF
 Ca0XYbRYBWUOIEIJtZtT8Fd9mK2sZEwA52N+viPPJj8aV5h3CuOU/+JP3KmojbnkjUQ/dx6x7bM
 XjA5G4QXKgmVmpDMvo8Kxotj6Dwwhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140097

Add clk provider feature for the adf4377.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 131 +++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..08dc2110cf8c 100644
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
@@ -929,6 +935,120 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_OK;
 }
 
+static void adf4377_clk_del_provider(void *data)
+{
+	struct adf4377_state *st = data;
+
+	of_clk_del_provider(st->spi->dev.of_node);
+}
+
+static unsigned long adf4377_clk_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
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
+static int adf4377_clk_is_enabled(struct clk_hw *hw)
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
+	.is_enabled = adf4377_clk_is_enabled,
+};
+
+static int adf4377_clk_register(struct adf4377_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct clk_init_data init;
+	struct clk *clk;
+	const char *parent_name;
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
+	parent_name = of_clk_get_parent_name(spi->dev.of_node, 0);
+	if (!parent_name)
+		return -EINVAL;
+
+	init.ops = &adf4377_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_PARENT;
+
+	st->hw.init = &init;
+	clk = devm_clk_register(&spi->dev, &st->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	st->clk = clk;
+
+	ret = of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	st->clkout = clk;
+
+	return devm_add_action_or_reset(&spi->dev, adf4377_clk_del_provider, st);
+}
+
 static const struct adf4377_chip_info adf4377_chip_info = {
 	.name = "adf4377",
 	.has_gpio_enclk2 = true,
@@ -958,8 +1078,6 @@ static int adf4377_probe(struct spi_device *spi)
 
 	indio_dev->info = &adf4377_info;
 	indio_dev->name = "adf4377";
-	indio_dev->channels = adf4377_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
 
 	st->regmap = regmap;
 	st->spi = spi;
@@ -979,6 +1097,15 @@ static int adf4377_probe(struct spi_device *spi)
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


