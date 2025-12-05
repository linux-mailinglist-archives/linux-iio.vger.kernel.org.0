Return-Path: <linux-iio+bounces-26793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C34CA7FE3
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 15:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4869F31A40FE
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB5328274;
	Fri,  5 Dec 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZgqF7zSa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC402E7178;
	Fri,  5 Dec 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764945592; cv=none; b=SejVXOSp11kj7szpEn8yveZljcx+7hHs6te6Js3ghaGkUP50QpkQD7ARqAVOQUbnb0BxpCeZmKlG/Y2T3rvs/3loRS713FW+1QPwY3UlyhT7uzzZGLdglq2bBDlkqAYkA9JxlReIUyaHBZ0z6yp2o6dkFkk8VA2L7VuVnUhcZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764945592; c=relaxed/simple;
	bh=u1ku4Rn0LKds4Md2ux7ksUpo1jViVMABKZDt7hQZmIk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VU5EjISmVs5U/lbPGh67x0WwaBoPhNoaEa48lDfYFTVSE3eIqfjUxaPzfpdlxWwl6NOS1EmKhDBAH0dDPu/IOs/NIqUtn2dIID9ADc95WbjCWapaUaLgAUT3LrSTzfwbOhXd2xVROdnzvHYHDFbUxxT+wnXowWtvEwHzZhamUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZgqF7zSa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5E5B6k172839;
	Fri, 5 Dec 2025 09:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8Jxgh
	OrnmlBT9Xj+i3quwlxrBaWlJpjH1yMcbAELnUY=; b=ZgqF7zSaCozFxrDCIonpH
	AwP5yfQbpNkhM72l2Nq8FUFmlYiwyBzRJVaAkLr6nzmDC9eiPBNJ3KZKeMdoiiZJ
	EqGYz2Mf41ju40VE0ljj47jaeeI6j9x2CCiRkc+ImmqeQ8VKBBQAqQVtMYGhpcnZ
	w+uHWhYfP4qfB5apriyk2eJUpAklfpdCNtOjLJoZEdMqzygIHzOAMoZ0H8lRQUdq
	rvP2cpfewuk0uYQ9snk57dOT8x1J1jv3lY0ey995YHGDKBOic79Hhq7Czav+eKpy
	RTjFoZCadgELLQ492xatIoxacaGOp6jRrwloHboAc3iEp/kvMrz2xXcpMwuQKUZO
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aufyscg26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 09:39:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B5EdQET029286
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Dec 2025 09:39:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 5 Dec
 2025 09:39:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 5 Dec 2025 09:39:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B5Ed1pt027828;
	Fri, 5 Dec 2025 09:39:16 -0500
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
Subject: [PATCH v4 2/2] iio: frequency: adf4377: add clk provider support
Date: Fri, 5 Dec 2025 16:38:46 +0200
Message-ID: <20251205143848.989-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143848.989-1-antoniu.miclaus@analog.com>
References: <20251205143848.989-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=G4cR0tk5 c=1 sm=1 tr=0 ts=6932ee9f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=lgSw96-Xf9cIUEf7j_0A:9
X-Proofpoint-GUID: bMpuO0QWM41NOA5CnSu1xoSpxe8Ra435
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEwNSBTYWx0ZWRfX096UR9wvY21j
 N3qjPGYWd3ElNRw6HT5pReRBv1jyDFF0veHD15jHsK1cD4JkL+aERDdfnVcj2IuZn2DNPad+BLt
 F5r8c8D/BZsi/mr3twZIkRSl7tBazT6iZ1wVHmclgnbKSZKyH6s5DtF/pixA6CpRqXAZa4HQyYZ
 YuJbC6RsjWWyfP4KWg9UGdAnmCJ5Pe9AEiErcw/F1jL0TAIufNMVyksSK1CYdwMaODyVv5tCeS1
 J0FAYK5bV8EOk6DHbCaDOjtVnv0IYKz+YPcAm12azy3woX1yotlgDBs3350gbBy2PxJ317oF0Dg
 z8sKtQtPXxfETw3PpDol5eYGF9EFeMRdfbZ3u2XITE0jJ+mpVe7HLH6wiLwTyspuD62HXPw5uy0
 w7rlz14Mbd5ZSYLoVigLk/P9kVyJRA==
X-Proofpoint-ORIG-GUID: bMpuO0QWM41NOA5CnSu1xoSpxe8Ra435
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050105

Add clk provider feature for the adf4377.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - Split device_property_read_string() assignment from conditional check
 - Use %pfw format specifier
 - Add struct device *dev local variable
 drivers/iio/frequency/adf4377.c | 121 +++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..bbf82c03606f 100644
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
@@ -929,6 +935,110 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
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
+	struct device *dev = &spi->dev;
+	struct clk_init_data init;
+	struct clk_parent_data parent_data;
+	int ret;
+
+	if (!device_property_present(dev, "#clock-cells"))
+		return 0;
+
+	ret = device_property_read_string(dev, "clock-output-names", &init.name);
+	if (ret) {
+		init.name = devm_kasprintf(dev, GFP_KERNEL, "%pfw-clk",
+					   dev_fwnode(dev));
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
+	ret = devm_clk_hw_register(dev, &st->hw);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &st->hw);
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
@@ -958,8 +1068,6 @@ static int adf4377_probe(struct spi_device *spi)
 
 	indio_dev->info = &adf4377_info;
 	indio_dev->name = "adf4377";
-	indio_dev->channels = adf4377_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
 
 	st->regmap = regmap;
 	st->spi = spi;
@@ -979,6 +1087,15 @@ static int adf4377_probe(struct spi_device *spi)
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


