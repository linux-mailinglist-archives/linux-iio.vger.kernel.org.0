Return-Path: <linux-iio+bounces-24576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448EBAC85C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E613236D3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C206303C9D;
	Tue, 30 Sep 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="thWLIvcO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEF2FBDF0;
	Tue, 30 Sep 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228384; cv=none; b=r2UlOGSl+/wjVdLqlcY9wRC3zd42h2a9X4kAqMWJEdDDM/RCj9nftUthCzh/hifgMEBXG3zjvcMH/AwHHgo5XyuE1XXgbMu50uJMmIyPe6MkpI1sh8sDDv8kDDqxgruwMCsE/otN88Foo1nW+3ctBmAz+SnP2MPPSCial1hyP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228384; c=relaxed/simple;
	bh=G3dXiSj38UTwxoTnwobKAgqe3zW6IWIRn4jKwDK1xiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOwEaof98sTShnVM0fSjW5/WKxaNK7baeKXgAh0iUO3VZDzztqG3WzVkV9Dh0LrE2l4j2v3js3Yc7AR3FxTGil+rD6Ve2UpsLc0DDVcwYrEWjl7K1o1QvMQ0yYipHFb/hYTW1jCjvpCQoI07khGlk5oZTHjlOBdWRSy3eTCVTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=thWLIvcO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8FgKJ026774;
	Tue, 30 Sep 2025 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aFpAy
	V7ihnCIWNGwHQJ0ayXrTeBXwN6xnfN+J8FCe/0=; b=thWLIvcOPDLG/px0bT7ST
	6kTo3YhcqZO2EKqUgvCjR9EK4hZpGHw9tiYYM9wLpaMrdIpG4FeVhINSffOABcbC
	sc+qy6NW/8WeqGCilu7OeCojcruwkGUeBZPDBPZEIMNuHht59XH+OMqQRbwFkyC7
	b240O5efi8kCfLl4yp7R4LpI25hSO4d1MA8iCul72j3nX7Nik+6vpv7e6w8k2qxB
	n2cvM2lDOO7Mtx/9txqBRwFTjSjSpfyT/X/nP2CxiGGcurWm+1SXRIwZRk3QKaU7
	w2m6Xin91Z5FLj/f6BK0VQ/8Z0d2i1/G7H2+HMLmYbLCkj/vqVxiIZSI3YkgpD/M
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49g7sjhwnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:32:59 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWwGp027484
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 06:32:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:58 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipY025133;
	Tue, 30 Sep 2025 06:32:54 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 6/6] iio: adc: ad4080: add support for AD4081
Date: Tue, 30 Sep 2025 10:32:29 +0000
Message-ID: <20250930103229.28696-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: -0_RQ5GGRXg24TRtRIB8-DoNczBItmdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDAzMyBTYWx0ZWRfX+MNWYu5pkC5l
 /1Hmi3k7if/j4iI8xNhJxnL37N/o6BgPeTJBLm/JMEZyTcH4bYxLXKXPN5QvfQmFca2BvybvoJG
 H6HQkq1PV44irCksGoa60AdDja5254f+mscYLPdjKzqWg32wtJ0wLIY3H/sQL1tf5VxhLYL0KmZ
 uTKUCdjkL8weRDmVxJSadUS6+M8vyC+NVKRw/nOcY9wYkExwC7qG/Op/Ql2xSQNIVx1HlEIp5T7
 ej2wqD4xsvFmiezXGCokQe/smbnM4GAM2eEk8B6fH2OPExra+xshucUbUutieTiKhdKRD0Y6y7D
 7AK410P6oNptGYKIkZRngIcQpKqKOeoHNaTCbMlIHkfEa6k8oKG5UInX+5KC/EXYDsRgCozzD05
 8Hqxj1htBDN3Qq1bgVFOD5Yx+NhcMg==
X-Proofpoint-GUID: -0_RQ5GGRXg24TRtRIB8-DoNczBItmdi
X-Authority-Analysis: v=2.4 cv=U/CfzOru c=1 sm=1 tr=0 ts=68dbb1db cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=kT8vE1fiKq0M1JW6GToA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509300033

Add support for AD4081 20-bit SAR ADC. The AD4081 has the same
resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4081_CHIP_ID definition (0x0051)
- Create ad4081_channel with 20-bit resolution and 32-bit storage
- Add ad4081_chip_info with lvds_cnv_clk_cnt_max = 2
- Register AD4081 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index a68d7fa9f977..0dcbf175523c 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
+#define AD4081_CHIP_ID						0x0051
 #define AD4084_CHIP_ID						0x0054
 
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
@@ -611,6 +624,7 @@ static int ad4080_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
@@ -618,6 +632,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ .compatible = "adi,ad4081", &ad4081_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
-- 
2.43.0


