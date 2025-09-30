Return-Path: <linux-iio+bounces-24572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF469BAC850
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2829D3C2EE2
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678752FAC18;
	Tue, 30 Sep 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PjqtyfWe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74337298CAB;
	Tue, 30 Sep 2025 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228379; cv=none; b=p5J3RlZrGS1z3kBIP2NLoVvSwvky/yavfN3yneeHCaxeKX/sVWFqgB8zG3AmO7LvGvDnLfWKU6nqBV9fPYTRtgW8gnPqf4VGWdXnbCepfqAG/7uhYHOMl+/jxWsdO1eboZrnx9xiOmTALB1xUwpyYSNSKm5STwsHYwQu9Aq/Tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228379; c=relaxed/simple;
	bh=9phiHVEOPYKHogcXD4+rYsJvVGLaiflzuN4ISbPoeL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHrrw/kVFO1Mcw0oDDM/yriygTHdR/DyEINzR8DvcDg+6s5xgdRcOL5Ud3SAoSGteDCBK32kFBzxUVhHAR3G3GD9BxV+H+xu6bWqCpNEkQ0hwNSWlfthb9/7dZELGkXA3cg9Quo8w4h8yNKd/Ld0Wzya+x/6bZjEnoRuhjTeOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PjqtyfWe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U7Q8f0000994;
	Tue, 30 Sep 2025 06:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GBrYF
	iV492Bu5F5TBkv2mA+Y40vWHi1dPR9LlR16PdI=; b=PjqtyfWegj/A7Q6m65ae4
	OnKCdE0mfMd7yJMcgiJKO2M4csXqywOTWVnd5pV5V8vIiTrHO49Od2TGGgFsqs6x
	DGag2ABOffFdi9ZX+8+yZfX7w9FSUnu4EclaDwiuUdELbxR96GVkbaoxjp01x1zb
	en7rosjbMTRDEfGsu82NoAgjVhkxREXYtoM11W6+Hn32xthlQ0QsIXIvpZTmDMc6
	bsaHUOl+chgE5ev76NWOVwBM4YeElN9VFgX9EpyoqSK7GKutafYDMcl+WgIycLqo
	slOCbZII11fWsURgXJBY+P4sSqhuU3SydJ9uRm9OHU6xRnQrMfIPyjScwGRXhJJc
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1r3dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:32:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWrpB027459
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 06:32:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:53 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipU025133;
	Tue, 30 Sep 2025 06:32:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/6] iio: adc: ad4080: prepare driver for multi-part support
Date: Tue, 30 Sep 2025 10:32:25 +0000
Message-ID: <20250930103229.28696-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930103229.28696-1-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 0oogfkMQzeJRI7GcMI9rjWzgjE8byO9p
X-Proofpoint-GUID: 0oogfkMQzeJRI7GcMI9rjWzgjE8byO9p
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68dbb1d6 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=RVsaI-Iikop_xu5dod0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX33YUXX5isLfO
 0dSB4P5Xyj+WpALHN/B/HITlaMq12UcneTNbwQVS8r9Gttv5zQkWo9qSMBwXrIU3VKPP1vqRyJ6
 qjSXi2DJIh7/kedE36sZ2r5cd/nztxWGQ9s5VkQnOOcugm+YSd1J/gzn2YUslxL6iPOqiPwd/X/
 XyQi664uFrZ9ZsRfwjjqVunGC+Xz5oWCfdzW3WXQAL8LSuSnUInMmzMgPgIXj+FO8V9v5jVQ+qE
 kZLKUD2RLnww8GP2jUUh0eTZU40S2CHC+Pf6POnVDe5GSUSzqTUoPHoawSSC5M3KgSV1pG7GTDc
 u9/jsyQwthy5o1jcYsazA0stQjH6Al+9vpe8On1wcmDp7l2Jc2zLG2A0SosGU+9bQSivpWZphN/
 5LWu42Gx24F53PXkKk4U+oW4ZAfXSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Refactor the ad4080 driver to support multiple ADC variants with
different resolution bits and LVDS CNV clock count maximums.

Changes:
- Add lvds_cnv_clk_cnt_max field to chip_info structure
- Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
- Make LVDS CNV clock count configurable per chip variant
- Use chip_info->product_id for chip identification comparison

This prepares the infrastructure for adding support for additional
ADC parts with different specifications while maintaining backward
compatibility with existing AD4080 functionality.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - allign all the \ to the left in the channel definition.
 drivers/iio/adc/ad4080.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index b80560aebe2d..fa15b8f63b8a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -167,6 +167,7 @@ struct ad4080_chip_info {
 	const unsigned int (*scale_table)[2];
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	unsigned int lvds_cnv_clk_cnt_max;
 };
 
 struct ad4080_state {
@@ -414,23 +415,25 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 	{ }
 };
 
-static const struct iio_chan_spec ad4080_channel = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-	.info_mask_shared_by_all_available =
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-	.ext_info = ad4080_ext_info,
-	.scan_index = 0,
-	.scan_type = {
-		.sign = 's',
-		.realbits = 20,
-		.storagebits = 32,
-	},
-};
+#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = 0,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_all_available =				\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.ext_info = ad4080_ext_info,					\
+	.scan_index = 0,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = (bits),					\
+		.storagebits = (storage),				\
+	},								\
+}
+
+static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
@@ -439,6 +442,7 @@ static const struct ad4080_chip_info ad4080_chip_info = {
 	.num_scales = ARRAY_SIZE(ad4080_scale_table),
 	.num_channels = 1,
 	.channels = &ad4080_channel,
+	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
 static int ad4080_setup(struct iio_dev *indio_dev)
@@ -463,7 +467,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	id = get_unaligned_le16(&id);
-	if (id != AD4080_CHIP_ID)
+	if (id != st->info->product_id)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
 	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
@@ -489,7 +493,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
-					    AD4080_LVDS_CNV_CLK_CNT_MAX));
+					    st->info->lvds_cnv_clk_cnt_max));
 	if (ret)
 		return ret;
 
-- 
2.43.0


