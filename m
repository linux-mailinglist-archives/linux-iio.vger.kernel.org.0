Return-Path: <linux-iio+bounces-24558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7FBA9BB5
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A725A1922267
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B53064A3;
	Mon, 29 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="u/U5g1LV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5972FDC4C;
	Mon, 29 Sep 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157975; cv=none; b=sx7I0UKu1uage6AZD0QxcV7sZETS+C34IzR6vDdgA43IBmn9P8ZpODXCw5a3pdwAMdUk9a/01T4I/2CmrFqRbVaNXdNM5X3S8RHpCceryRhwCF7wB6aBjNoZxzPhT7koFEB+56GplBVwThjGgJe1f7tdgBzltJCe398LkOmVF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157975; c=relaxed/simple;
	bh=+7GwcoqC8qWNy2L3sxfFP5h75DWzgpzZQkCDkSZfwy8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jp6BicWwy3xByQs6EvBGqkztqefers4VCRz/9DSIN0lWMjADc0pBIyiJgAeTwhiIyJfeFJF68wYo36Nd9F23jqUe3ii/7c0yoroS3TbLp9EZrBiXofPPMCOladRBSXWk4Cr+wBVe9icRtO3tbG5tCKRS+JTim+Zyjrg6kcwoF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=u/U5g1LV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TCM7ea000989;
	Mon, 29 Sep 2025 10:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZYH8U
	6wZt/gDCowcDACKdsRnUEM+NRV15GT9EOIoHC4=; b=u/U5g1LVxZeWn/PoMps5v
	KnuzQRhVRekKDo0CNBeCzko3xnCGxtm2AAohCJ56s3TLgi6Gor0W8X+GAhwlBjin
	lszJ/3fwpMmqQIuacIXduD7gOelS2BwbcXqSx6LmWi0o8CRTXbgMxVhYDgo5poNb
	0cNJ4uEgbSSqv0IDgISxVJmODJvLbe6ViT2XXt3erQdDQHTHCFS+Y5u/TpV7L/4s
	FbIPttXhs7NXdIMKnot4rOvK+KiQb/HcWum6jnT1tkSYnin/BVyoT7qIblkuHWNe
	jFnp8AAb5RDwRuEQfp4AFPzOHzOKbiI6YeRjTJVIQaPDq2mDzZsnZ3cPzn3/9QoX
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ecu1jey7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 10:59:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58TExOTR013576
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Sep 2025 10:59:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 29 Sep
 2025 10:59:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Sep 2025 10:59:24 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58TExDG9023559;
	Mon, 29 Sep 2025 10:59:20 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/5] iio: adc: ad4080: add support for AD4084
Date: Mon, 29 Sep 2025 14:59:07 +0000
Message-ID: <20250929145909.111243-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: Odd8kYOjtyCFypfWxRBjZ-dUTeqpVi1P
X-Proofpoint-GUID: Odd8kYOjtyCFypfWxRBjZ-dUTeqpVi1P
X-Authority-Analysis: v=2.4 cv=A5Nh/qWG c=1 sm=1 tr=0 ts=68da9ecd cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=ibccQJ5QWis0U0yrBgcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA4NCBTYWx0ZWRfX260NuSEv3s1g
 WisDf3ohBqxf9gxYN24hGbs/ISQba7ILCp6kxgSIXVGgPLAplsu+Up8Z97YWydFK9g5p9tnDmj+
 jRi8zBGwULuyST9m1o7IbKQMNzVjDIqjA9wytLAobtXnoV/H5FrPMwK/k4w/ryN8JKzuWvKZGkF
 M1InFPf4RqjuBdHAP2sOhAR07daXrPEZzbRqRfhtqT6ebZTWus5EL8UWjdOgNU1rl8lTtXmztDN
 306+HhYwsDbDEFj6DLK/1LNhL2bD3BZ/cdvwmc6xIat9LL13qtkrYIoxUEgJKoGSvuDNjsif7gq
 p3QjYEeRQN+/C5U/iFN8/jP4Us5yYxSM15ZsmtzvfnHeV/VFihrLD+pjzuAKg0/0rzmmeGevmfp
 6xrgxMDlLS8sBrIfltsNpXX9Bmf8eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270084

Add support for AD4084 16-bit SAR ADC. The AD4084 differs from
AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4084_CHIP_ID definition (0x54)
- Create ad4084_channel with 16-bit resolution and storage
- Add ad4084_chip_info with appropriate configuration
- Register AD4084 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 9f670c290a55..cf3460a1eee4 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x50
+#define AD4084_CHIP_ID						0x54
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -435,6 +436,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 
 static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -445,6 +448,16 @@ static const struct ad4080_chip_info ad4080_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4084_chip_info = {
+	.name = "ad4084",
+	.product_id = AD4084_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4084_channel,
+	.lvds_cnv_clk_cnt_max = 2,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -597,12 +610,14 @@ static int ad4080_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
 
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0


