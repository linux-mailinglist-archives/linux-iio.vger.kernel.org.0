Return-Path: <linux-iio+bounces-6681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B191287D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43453B292B8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B32358A7;
	Fri, 21 Jun 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UaXZMKs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F02940F;
	Fri, 21 Jun 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981470; cv=none; b=rz5yMu6eLK4gri1ncoJ9Usj47Gy3+ALHlWd7smnNfrpmQLw+QtWabTPhw99P13pxqGHdArQ2LDWOsuEH75RtavBlXL/5N5guXmGyF8dTiXPr0PHvE35hKEwQ0qjua0Vt+8hpO0NPl7iI0vYvATObS7W7LRSuWmpkSWOneqaIrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981470; c=relaxed/simple;
	bh=5hLo/NJHRsfeggQDXZtDEA7gdlTNrQ5GceHmTEYUk8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqkdYGsOhMfADhX7WD/ULXYTNASpJ4eyu14sAB1Yj7+bedvmueh6sjP2B8vaDpXjwZ/+6MeXMqBGVZ05rqr7bxrJ5fyIHCEF4mjg1NNsI5uSJAvHQpj3+QNZdxc1azsoJMDhr3y6pHE0bY1uMO2m5geVA4Ap4QMYU3dpQBaQhuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UaXZMKs5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBfeWg014796;
	Fri, 21 Jun 2024 08:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MxN1j
	fBJIKGuR9o5HaLQx0jskf9yOcmAgKNAbFMGh/g=; b=UaXZMKs573U7Hq/tuwhso
	duyHbSt5xkgv7pFv059imY1WDyMNMAI7527g4TRv8mvO/iUV8k/J+81NneZfTNpV
	XeH1jg7WeqEDM0HW6kMmb7JX3E/cqbQDkmlIW0TFGfZuZpSmN9t/V9qhGuJjEcRG
	WXChOHO0prYhAre7hYc+pOHA9Ywx/cj+Sieq1U9NBFzQi2FdLfTfc1Y3gR+IEUYj
	3wSKvPy+uvJARPnupQBD9FWNVY2lyQQeEEJcHjiqcxSAxWOwXlu5vwaTmhQvbdk1
	GidOGP1Q1Nx//5UUOGyOY3KQdA7+o1GJpfqovXTRQvQx7hl6FUe+5Kp8mAjTh3uu
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yw4yxs5vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:14:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45LCEO2X021838
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 08:14:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 21 Jun
 2024 08:14:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Jun 2024 08:14:23 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45LCE6Sv032255;
	Fri, 21 Jun 2024 08:14:16 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 2/2] iio: frequency: adf4350: add clk provider
Date: Fri, 21 Jun 2024 15:13:59 +0300
Message-ID: <20240621121403.47912-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621121403.47912-1-antoniu.miclaus@analog.com>
References: <20240621121403.47912-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: C5-Nl98mnm-CxPdry3kMW7wGU8kUzwEg
X-Proofpoint-ORIG-GUID: C5-Nl98mnm-CxPdry3kMW7wGU8kUzwEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210091

Add clk provider feature for the adf4350.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - rework `init.name` handling.
 - simplify iio channels initialization.
 drivers/iio/frequency/adf4350.c | 124 +++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 4abf80f75ef5..e13e64a5164c 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -19,6 +19,7 @@
 #include <linux/gpio/consumer.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -36,6 +37,9 @@ struct adf4350_state {
 	struct gpio_desc		*lock_detect_gpiod;
 	struct adf4350_platform_data	*pdata;
 	struct clk			*clk;
+	struct clk			*clkout;
+	const char			*clk_out_name;
+	struct clk_hw			hw;
 	unsigned long			clkin;
 	unsigned long			chspc; /* Channel Spacing */
 	unsigned long			fpfd; /* Phase Frequency Detector */
@@ -61,6 +65,8 @@ struct adf4350_state {
 	__be32				val __aligned(IIO_DMA_MINALIGN);
 };
 
+#define to_adf4350_state(_hw) container_of(_hw, struct adf4350_state, hw)
+
 static struct adf4350_platform_data default_pdata = {
 	.channel_spacing = 10000,
 	.r2_user_settings = ADF4350_REG2_PD_POLARITY_POS |
@@ -381,6 +387,113 @@ static const struct iio_info adf4350_info = {
 	.debugfs_reg_access = &adf4350_reg_access,
 };
 
+static void adf4350_clk_del_provider(void *data)
+{
+	struct adf4350_state *st = data;
+
+	of_clk_del_provider(st->spi->dev.of_node);
+}
+
+static unsigned long adf4350_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct adf4350_state *st = to_adf4350_state(hw);
+	unsigned long long tmp;
+
+	tmp = (u64)(st->r0_int * st->r1_mod + st->r0_fract) * st->fpfd;
+	do_div(tmp, st->r1_mod * (1 << st->r4_rf_div_sel));
+
+	return tmp;
+}
+
+static int adf4350_clk_set_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct adf4350_state *st = to_adf4350_state(hw);
+
+	if (parent_rate == 0 || parent_rate > ADF4350_MAX_FREQ_REFIN)
+		return -EINVAL;
+
+	st->clkin = parent_rate;
+
+	return adf4350_set_freq(st, rate);
+}
+
+static int adf4350_clk_prepare(struct clk_hw *hw)
+{
+	struct adf4350_state *st = to_adf4350_state(hw);
+
+	st->regs[ADF4350_REG2] &= ~ADF4350_REG2_POWER_DOWN_EN;
+
+	return adf4350_sync_config(st);
+}
+
+static void adf4350_clk_unprepare(struct clk_hw *hw)
+{
+	struct adf4350_state *st = to_adf4350_state(hw);
+
+	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
+
+	adf4350_sync_config(st);
+}
+
+static int adf4350_clk_is_enabled(struct clk_hw *hw)
+{
+	struct adf4350_state *st = to_adf4350_state(hw);
+
+	return (st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
+}
+
+static const struct clk_ops adf4350_clk_ops = {
+	.recalc_rate = adf4350_clk_recalc_rate,
+	.set_rate = adf4350_clk_set_rate,
+	.prepare = adf4350_clk_prepare,
+	.unprepare = adf4350_clk_unprepare,
+	.is_enabled = adf4350_clk_is_enabled,
+};
+
+static int adf4350_clk_register(struct adf4350_state *st)
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
+	init.ops = &adf4350_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_PARENT;
+
+	st->hw.init = &init;
+	clk = devm_clk_register(&spi->dev, &st->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	st->clkout = clk;
+
+	return devm_add_action_or_reset(&spi->dev, adf4350_clk_del_provider, st);
+}
+
 static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 {
 	struct adf4350_platform_data *pdata;
@@ -522,8 +635,6 @@ static int adf4350_probe(struct spi_device *spi)
 
 	indio_dev->info = &adf4350_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = &adf4350_chan;
-	indio_dev->num_channels = 1;
 
 	mutex_init(&st->lock);
 
@@ -551,6 +662,15 @@ static int adf4350_probe(struct spi_device *spi)
 			return ret;
 	}
 
+	ret = adf4350_clk_register(st);
+	if (ret)
+		return ret;
+
+	if (!st->clkout) {
+		indio_dev->channels = &adf4350_chan;
+		indio_dev->num_channels = 1;
+	}
+
 	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
-- 
2.45.2


