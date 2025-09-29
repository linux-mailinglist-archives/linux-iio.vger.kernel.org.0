Return-Path: <linux-iio+bounces-24562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3EBA9BD9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5369A1892876
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB230C11E;
	Mon, 29 Sep 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tlZ6lMN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5635D30BF58;
	Mon, 29 Sep 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157978; cv=none; b=BMAcNJIAy+/1JZS9JtjCF6XT7MdaY3CmCJjfvHSdUfiq+jxKrAHpVWQ1HamI4j+etlWbyYdxFAkEcwV3wUDaHi+r1joTbJineqxaUzq1lcMTsdBCRamdgf3j/q9+FRAriDC/G9c7zBa0F30dKXXgF4ZwzSMi/JAZhzWvtdqa7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157978; c=relaxed/simple;
	bh=zTvJ7/WCuV8mAD2zCQJhyZcWzUkozsxRKWRU/BLYNjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBa8jRQjCaN/hS2CUcW+S+zzWtiIt6sjFF8UWsqUPR8Kki+SSnTVQcUiXiwTobPhr/xbb68rXuFOES2U0gGfeBMxtI05/plJ5+B5RDP+CzBkY3V6ttnPRiGos+txM+QW1uQiw0+MPjuW03HPZMKxEgvfgZ3z+8effE7mZhSVenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tlZ6lMN4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCSMmK026923;
	Mon, 29 Sep 2025 10:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FxjuK
	HNfnki7+CQPI9GOC4AdypcedbdK4rgBZFfqZUY=; b=tlZ6lMN4iH/Y025u2H1El
	vvt5cf5538oOfhJBTgWLWeLv/gc47IJbalsIMN27QsvbF//TH26+vp9E/QxOLs02
	d255IGAd3I9M+WHJvMS2zyUoPjxBsLdqIsoW7/NOuIXYODA3gVH/zAeh4ws30kUF
	AxsgPvm1p1wqZYpdgq4xpAfr+kn+dUtfd/V9qOnGRbs+VDM4FSKRtjsb5jOmvsY/
	Qw7JxvD18OGeJPnKB015DQTQE0lch/QYz090RBqXmJl0hAg8T252+aePQPTZ3id+
	23nZ32ZXi8mQkajpn1DBk8rDmgAvoafuvqeLvDrUV+Ws3uZfv5RkovAfrWn9ZyKG
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49fpd3ssp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 10:59:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58TExStd013589
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Sep 2025 10:59:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 29 Sep 2025 10:59:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Sep 2025 10:59:28 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58TExDGB023559;
	Mon, 29 Sep 2025 10:59:22 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 5/5] iio: adc: ad4080: add support for AD4081
Date: Mon, 29 Sep 2025 14:59:09 +0000
Message-ID: <20250929145909.111243-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929145909.111243-1-antoniu.miclaus@analog.com>
References: <20250929145909.111243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZqdyltv c=1 sm=1 tr=0 ts=68da9ed1 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=kT8vE1fiKq0M1JW6GToA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UCkqL80mVCGlPp2xfhjVDSNLoiFQVMfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA3OCBTYWx0ZWRfX5B3ZoH87EUWx
 wWE+q5n4ufWzkCBfcpNgCQ9LinJT2ooogtRRREnTaYGjNlqxYtzEhndbbe3gJvj+M7d06SoQX5L
 y9KWybNLQzI9m/OwJ4jnlqrw64xAF1Bm7X72Pk1hMI9X3l37wt0gpdQ4cXsO51iugX4v92ptwDp
 PQY6rpCuoHrbCgQ6y5bu/2IML3YrPL5sZRK4LVeiCOJP6aP6BfByTCjmO2pRsF7kvOR4gHM8Fnx
 i/toF0Fb4ADpkjat4gaSNnkYrSSm1Hbj+8FjACZfxE3e037QvOSRsQWBSy1EQOcP8U6J6MfEBFr
 363zE66IqDeyStxSHapObKkMIWR6ZmzCjMILnawWYJKWjByPQz60M7u3BbSKcLJiAiEUzNmf55b
 RKP9QZowjVqsU3oxqRiHKfyU+tc73w==
X-Proofpoint-GUID: UCkqL80mVCGlPp2xfhjVDSNLoiFQVMfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290078

Add support for AD4081 20-bit SAR ADC. The AD4081 has the same
resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4081_CHIP_ID definition (0x51)
- Create ad4081_channel with 20-bit resolution and 32-bit storage
- Add ad4081_chip_info with lvds_cnv_clk_cnt_max = 2
- Register AD4081 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index cf3460a1eee4..dab8933f573d 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x50
+#define AD4081_CHIP_ID						0x51
 #define AD4084_CHIP_ID						0x54
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
@@ -436,6 +437,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 
 static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
+
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
 static const struct ad4080_chip_info ad4080_chip_info = {
@@ -448,6 +451,16 @@ static const struct ad4080_chip_info ad4080_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4081_chip_info = {
+	.name = "ad4081",
+	.product_id = AD4081_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4081_channel,
+	.lvds_cnv_clk_cnt_max = 2,
+};
+
 static const struct ad4080_chip_info ad4084_chip_info = {
 	.name = "ad4084",
 	.product_id = AD4084_CHIP_ID,
@@ -610,6 +623,7 @@ static int ad4080_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
@@ -617,6 +631,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ .compatible = "adi,ad4081", &ad4081_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
-- 
2.43.0


