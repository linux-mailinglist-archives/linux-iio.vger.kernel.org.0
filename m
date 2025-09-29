Return-Path: <linux-iio+bounces-24559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B71BA9BBB
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0294A17E695
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28130AD19;
	Mon, 29 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r5OfsUQl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51126E6FF;
	Mon, 29 Sep 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157975; cv=none; b=oMePoRRwjVa/FtiwxqpiNZdqz28AOG+lyv6JZkOwNz8/twzCs682vW3S7WaghDJH4vkgR1VBFVSZpETtl0iBk6eCzyZ81fWrv2bYbRpxhXMOSXYVTukM1loPh0DA2vCQi7VITXv9jWR12Tn3HDXs9rMiXwKvzxipRYLBVoKrNkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157975; c=relaxed/simple;
	bh=oalG20CtRpDcuQnoJM0+JyMi45I8t8CsE4LC4YYDonc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VR9fNcwIjuQ+I/zpg1XXx9LEr0QL9cG1AFbbxmsb3Md22tf0UNsdzBEmwEjapJlk7ItO0693CcP7eFSOOo37bUL+QdfVo7OooSGxFUrr+QMFl9mlx2TV92Lz6smS3DFsNkvpTOIoPTpUHlZqAhVbDQmVMgy5QKnADlPGKHeW7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r5OfsUQl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCna4J001126;
	Mon, 29 Sep 2025 10:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5p7vsrRZWSngxnInGFwIRuXDwtu
	E6LKHiW+cRdATNok=; b=r5OfsUQlLNzIcjoeaVou7WrHQEyfvmlDnTVHFO3OYPO
	xJNcDm2jX3jiJeHb8Q4gk/Vy3JOLkXdGcW1FSqU62nOcyg3Ap/fKTddGvLd5qbbY
	+b9kDXLhVaf1YvzqQgVeY525LGLkKUs8FzKRypmgttgQmfMeU3EE85HHK7y87B8D
	hB1q1Lt2D2mwUnXByhwLat0LGjiYsVyo6QP/1wUKo4vVlaFa3zJNTNB5Ug0tjHAw
	A9jGAIwfkzZ9kjcbhnOtCvO5YmCjWaQ03PElAtelnmEpg4LoGvU6gZpgTQCjQ7V7
	AsV/IwrevAgwPYoY0yipg6HLJu3Rn7KtJ/iHyZ2CJ8w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1jey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 10:59:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58TExNs3013573
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Sep 2025 10:59:23 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:23 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Sep 2025 10:59:23 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58TExDG7023559;
	Mon, 29 Sep 2025 10:59:16 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/5] iio: adc: ad4080: prepare driver for multi-part support
Date: Mon, 29 Sep 2025 14:59:05 +0000
Message-ID: <20250929145909.111243-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: F9a2omZQMtcPf1unF5G-76SftsASoTKv
X-Proofpoint-GUID: F9a2omZQMtcPf1unF5G-76SftsASoTKv
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68da9ecc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=Pkl20Ks3zfJNZXB0MFMA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX8THRheibrPs/
 xJS61kTUk8YkrZBLy1NQ07Tqa8HalQAFSGAMru2zeToUHB6nX/J7+oKblk5hSQRym9DZ565w7n1
 iwlRzp503Abh4dS4v2weiIDf+fD6MenLu8WP6d7f17TFWBXbgg0HUnpEGhiqKQCUugHuW1XGhr2
 OjilnVMVnjplpStPE4MjcSbBtoQTwqew/yPvWWPyNoUS0dB0H369T+dIwRLbGszdFGEtFClTiby
 4QXlMaO0M0xbmrMqWagJU44tdyMPF98YJgOaIttr1LjHXpz+jQdafGIRch/TJbn61XMPVZ1aIAN
 5N1rNGsNAloN0zu4AjCi3ZaKc0UwWkBe+tJjmRAypEdTTuD1ao4YlCYQaAbaQDH3OQ4/4iPqOd4
 FQszd75E6NPs9MIqEFXx8h48oyf7ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Refactor the ad4080 driver to support multiple ADC variants with
different resolution bits and LVDS CNV clock count maximums.

Changes:
- Update AD4080_CHIP_ID to correct value 0x50
- Add lvds_cnv_clk_cnt_max field to chip_info structure
- Create AD4080_CHANNEL_DEFINE macro for variable resolution/storage bits
- Use AD4080_REG_PRODUCT_ID_L register for chip identification
- Make LVDS CNV clock count configurable per chip variant

This prepares the infrastructure for adding support for additional
ADC parts with different specifications while maintaining backward
compatibility with existing AD4080 functionality.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed321..9f670c290a55 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -125,7 +125,7 @@
 
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
-#define AD4080_CHIP_ID						GENMASK(2, 0)
+#define AD4080_CHIP_ID						0x50
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
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
+#define AD4080_CHANNEL_DEFINE(bits, storage) {\
+	.type = IIO_VOLTAGE,\
+	.indexed = 1,\
+	.channel = 0,\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
+	.info_mask_shared_by_all_available =\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
+	.ext_info = ad4080_ext_info,\
+	.scan_index = 0,\
+	.scan_type = {\
+		.sign = 's',\
+		.realbits = (bits),\
+		.storagebits = (storage),\
+	},\
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
@@ -458,11 +462,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	ret = regmap_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id);
 	if (ret)
 		return ret;
 
-	if (id != AD4080_CHIP_ID)
+	if (id != st->info->product_id)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
 	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
@@ -488,7 +492,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
-					    AD4080_LVDS_CNV_CLK_CNT_MAX));
+					    st->info->lvds_cnv_clk_cnt_max));
 	if (ret)
 		return ret;
 
-- 
2.43.0


