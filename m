Return-Path: <linux-iio+bounces-24816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC6BC11C4
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA993B7B90
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6002D9ED0;
	Tue,  7 Oct 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HG0BzKN9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043C2D94B5;
	Tue,  7 Oct 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835761; cv=none; b=uPRnlr1lggxDPQNrK+kx7jrZj2CX84/W5YN70TjDRg/YPCtMSJqpjDiECNaq6gzf/C//poq+8yOp3iGXlzu7/q/F5ZM+R2Iz0EFPK+BU3a7m04ZWV681Cdodol3rKUpQb4X2ab91DX7JKevd8Mk3+FLAbsC2LVH3mraLy5l/ATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835761; c=relaxed/simple;
	bh=Y6SUc1edRPUHtAZwrtsFW6hLf36+mw3tXxySYcCT1Hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpRfgW+DhfeTe1WbZ+jZg6g/nVHHYOcRFs1mDxjUUCy+dTvqM1txHHGVmRvTXd8VbMTr5k2UYbrLCgF+2fBbcl0snh7EmhLtCZPY5cNfLf6AT5/829jdLOo18Qo5T7/rCLSWmv/rW4I/MVjm3avgqJxXRko74Wch6YGIYnS3r3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HG0BzKN9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5977w2ML010600;
	Tue, 7 Oct 2025 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jRW8V
	ii+Y6/3vQPsiswGVmgkEgtnObUQut6OYHLfFEQ=; b=HG0BzKN9m0kQmZzCRp4w5
	If3hm7RAL7wuM6aKEAdfqUd4j0ub+gLAG4eEI19bPzsiP6RH+L3+4GIyluqG//Gb
	xdVBfjIf0vErgXX4vNAiwCFMCCW2jy8Ks4Hy7g3arRnR3Z4Z2JX8Bl2iKHXq9WuG
	7laqYcwqD6aB8l6598HELsmf3vGIeeAiIVjtf1NI1cSgZmEC3dGJ5osa9udYO2Mf
	mcze6kupew3mcP79Jdk8R5Q82nZIwphje7X57/iEv+fLQaSEj2Bycbt1pTMSegHz
	rzuP+/2yHQNqwt4VvK8Shd7FxeI5zM1JAkM3iKjp8+tmqgEhxulmW54IuRRAitut
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe1y7f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:15:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BFuZM058176
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:15:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:15:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:15:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:15:55 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftT006224;
	Tue, 7 Oct 2025 07:15:51 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v3 2/6] iio: adc: ad4080: prepare driver for multi-part support
Date: Tue, 7 Oct 2025 11:15:21 +0000
Message-ID: <20251007111525.25711-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007111525.25711-1-antoniu.miclaus@analog.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e4f66d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=RVsaI-Iikop_xu5dod0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: BUORRWIGXh_nNL2FJ7XJ2ZHnxzJOGYpm
X-Proofpoint-ORIG-GUID: BUORRWIGXh_nNL2FJ7XJ2ZHnxzJOGYpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX2ftiDiBpeDqC
 bXX9ntcFdJQvfBD69+wShIbFE7WTFVEpICatrQYz/AO+Zhp5h/tQyC1B7ewh1f4idH5HfNYKI76
 VTs28bq07EUCLJUHP812g4KS5kspZSQUnP45ssylCBbmzn48l77LluKCZw6TLVg3atYVKHTS5bq
 /fileSv3NaDYyn8TxzyitE7FLhLloKDYsCMpBY0dpavF43TdImcokpo4Fs99zZ/5hDjZq+i/2eo
 0JraWp4l/hEsGalNhfzlu8c6CQLLsasf/UlIw/yR99IcWquNC7KRbeT+x96sMqbB6pAmPoFsDtF
 RaBhRBfA5PtxclKnSL4eC9Kjf7+a42Dvbas5JReu/CwHqMbX45BzJ+C0DYMbenlW2ZzckpYbbxK
 dYf8BG0jH9A1soU/YtysRg6+X9LIOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

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

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index ae5a975a47a5..7231b93821cd 100644
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
@@ -464,7 +468,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	id = le16_to_cpu(id_le);
-	if (id != AD4080_CHIP_ID)
+	if (id != st->info->product_id)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
 	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
@@ -490,7 +494,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
-					    AD4080_LVDS_CNV_CLK_CNT_MAX));
+					    st->info->lvds_cnv_clk_cnt_max));
 	if (ret)
 		return ret;
 
-- 
2.43.0


