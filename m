Return-Path: <linux-iio+bounces-25321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7ABF5E62
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21BB501AC9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB532B9A4;
	Tue, 21 Oct 2025 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l2hBdznd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752D2F2603;
	Tue, 21 Oct 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044056; cv=none; b=BY4l2Zri17uZVkoGeR+XqAkz4bwHAjTGLaLnVp3qwzipn9OvhXlKO2VaVXBe1OC1y7vDfDKUjW0sb/JN2J0LS/gXYCgQblnbdCzimdRnC8ayrgdlKScgJuPiDS0La5KywnRvRBfwAr2Ny87wPoQqxRtJv/I0kiU+6sTAI53tBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044056; c=relaxed/simple;
	bh=Z9iCx+eJ61Cfb1Q/oVx3nCwYc8oPCgSibMlNQ0Aovms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukb519zFkmlgvk3i7ZkCXcEPZ0PC+tmYj58ySvOe3Gnxsr0A8mSUPlN5J99ATm2Tc6guGxRzYd6txR4O0WpSz/t7YTILXgomiKYnT+8H/+U2fYvpUYQgh2diw5hALLgpcF9M1ABCB2JvuwCxcqUWKAR/+Jq2aR/1J0KkUDrV8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l2hBdznd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8PGMF006006;
	Tue, 21 Oct 2025 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RswHx
	QLFAkQLri88MIvQF07Yip2/gokn8Iv9adsJ284=; b=l2hBdznd7bwSrZ/Qs1n+j
	A2hk6P/st6r90boKDEXnvcC2yo1zQkewgzAk0gMDpXxe0p0TvFOsaqBBZjQ4NcBs
	g0zFfELO0yiTA/bS2OSXEawF6jODwZb7dtmBsVuVIpL1DmoAbaGY1MOpMTEbB3pq
	tCKRy2vgTijKfzP6Gt/agqwHxMPF+0VUFk6q491TP4VSzEX8HKXArhy2bPORZ+mG
	TPyqes26drwEOwtWBm+w1JTx5DeNCwpUeUL3Q3Mew6RaUEJaIiUsG01ZKAfszZHJ
	dnTkII1vvPF47cJGNPtP7OTCEMFOzfyv0dcRgNyKaUrzjAL5CMYyldIZVoWTgFq5
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49wt9vc7fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:12 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsBPS061038
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Oct
 2025 06:54:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:11 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Kk002507;
	Tue, 21 Oct 2025 06:54:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/6] iio: adc: ad4080: add support for AD4083
Date: Tue, 21 Oct 2025 10:53:44 +0000
Message-ID: <20251021105349.21145-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=H5vWAuYi c=1 sm=1 tr=0 ts=68f76654 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1KW0U2bv4PRnK4pRsUcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: YtybEhl6kMF24vIPq5m9stfF-Fowlnvr
X-Proofpoint-ORIG-GUID: YtybEhl6kMF24vIPq5m9stfF-Fowlnvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MSBTYWx0ZWRfX9e42ZvQKhK9k
 gynGF+tfrsh2ozvUgoxxBaTWVXN0ayCyBCL6EDXirgTy2GctMZTru9AXbIyTCFha1QH+zqrSho9
 XJV3nzGZdw3Pi/Kx08UssC8deB5g/EKG38wOSlwN6LipaC4/86Ljw5FtmHuOBn43kZ8khElsudq
 LvD1pohQzwYevigfmq7RsSyfy7R0YhpV7gZm5CffGvJ/qS3kQpMy10SWoUruCMdFjqS3B8cv686
 996kE3bVfvAoCM43uYQI9hoFQ/9jvCIcA34Y7Awe6vCZTSioNGLWBJA/6td8xbqxgJrUX1aPLO9
 K5iRy4EKhRMJmGZnaaV2lrSfVWeqjr7PerEdyVvN/6ZIXLZrEuDOzTuNi+bzBtQJ3mLll9ZtRGO
 CU0kjJpz4Sacp1++HTOtCZU2SdFyog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200151

Add support for AD4083 16-bit SAR ADC. The AD4083 differs from
AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
maximum (5 vs 7).

Changes:
- Add AD4083_CHIP_ID definition (0x0053)
- Create ad4083_channel with 16-bit resolution and storage
- Add ad4083_chip_info with lvds_cnv_clk_cnt_max = 5
- Register AD4083 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 5940651655df..e2cdca2e9174 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -127,6 +127,7 @@
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
 #define AD4081_CHIP_ID						0x0051
+#define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
@@ -439,6 +440,8 @@ static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32)
 
 static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
+
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
 static const struct ad4080_chip_info ad4080_chip_info = {
@@ -461,6 +464,16 @@ static const struct ad4080_chip_info ad4081_chip_info = {
 	.lvds_cnv_clk_cnt_max = 2,
 };
 
+static const struct ad4080_chip_info ad4083_chip_info = {
+	.name = "ad4083",
+	.product_id = AD4083_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4083_channel,
+	.lvds_cnv_clk_cnt_max = 5,
+};
+
 static const struct ad4080_chip_info ad4084_chip_info = {
 	.name = "ad4084",
 	.product_id = AD4084_CHIP_ID,
@@ -627,6 +640,7 @@ static int ad4080_probe(struct spi_device *spi)
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
 	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
+	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
@@ -635,6 +649,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
 	{ .compatible = "adi,ad4081", &ad4081_chip_info },
+	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
-- 
2.43.0


