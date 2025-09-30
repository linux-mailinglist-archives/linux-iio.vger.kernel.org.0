Return-Path: <linux-iio+bounces-24574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4057BAC865
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9213BA6FE
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822092FB61D;
	Tue, 30 Sep 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HFsf+4Ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F32FAC16;
	Tue, 30 Sep 2025 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228381; cv=none; b=SMkHQ7xvjL0UOQCzq5nJf7cjhw4bUOS71ilrf9+esHgySqBmBG43mwzG85VLq6IgOY95gZIfKJTMnH7xOCIftQWO8KnnCcjQrBCYdBfdSQhyGrYoejV/htvdciUNet3mBhGVt/S5ijW+c8nNS519zfnGMUsenREWjVurGiN9dZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228381; c=relaxed/simple;
	bh=B2Hmi5JLx4uso0WPsfX5SMvWDFdWkrFWJIRHYaK1IFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NS1ME3Y8qFF3vpISsJbOZMpZPmLmgiLcpgD8OCO3CAlMP6GeUrXbbNcbTnmBg+SoT65Ze2+fRUxpDopoxxepmLHqq51WMyvzumZY4PZSmSuJInEk9/MimcTUJS+X1gJ9PvkiYHNftt79J6frnBYI/dvFPTMP0Vo/S0eqeomrRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HFsf+4Ft; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U8QA1q027016;
	Tue, 30 Sep 2025 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r/ZnA
	EEIR+Csk+hxZDcsb0zA9QTyQ69NZTP5iqJepgg=; b=HFsf+4FtEpbbEujZUueBG
	KklZmeL41vRRlAkYaxyWgDOosgd6YwifWI+wHRgiBJ5t+b+8Hvr0wZggzKoM0Kn+
	XXxk8byJj69v0grfdyVnyHSq/V6kUZpa1C1yFZb+WZ3/yLWWlPFGz0O1+ydYdfQ4
	U9yBxoS0h2LZJE1i0feR6MZ4TiA53t8MMJML9/4o4Ad3tBJjw02JTnAMyGga0WIk
	7GgWZRJE0+gP6j3WaN+30wE/g2FdRlREqwd7YrzFSvz2P1ClbG0+nviY7bxQxvFg
	qLM/8SyFfYZTolFdYOKENHn5G6/Pt6vRbgNQnd87HPobTGY3I95e0beIn78GZcuu
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49fpd3yfbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Sep 2025 06:32:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58UAWupb027476
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Sep 2025 06:32:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 30 Sep
 2025 06:32:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 30 Sep 2025 06:32:56 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58UAWipW025133;
	Tue, 30 Sep 2025 06:32:52 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 4/6] iio: adc: ad4080: add support for AD4084
Date: Tue, 30 Sep 2025 10:32:27 +0000
Message-ID: <20250930103229.28696-4-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=RZqdyltv c=1 sm=1 tr=0 ts=68dbb1d9 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=ibccQJ5QWis0U0yrBgcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: fKIyuvntzt6mr_etG3xBu34UN467e1Rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA3OCBTYWx0ZWRfX+acVq9W3Y8XB
 oFpvjp8QCbf5DA4zc8/9ACEjVSSFWxd7ebHACItJgLzL6ChXQcD7EhVi9JzkDlgg+z6KjEoAM1W
 eOlfZ7CncrzY/wd7XwINAb2KLxfmF8szV9joqQDoKU4qlIPFkCijsaS8iDsdG7I8Ayaa6y6uS5k
 RZGkKtmtAZX1pPoyOmCNjfXk/TQYh/+rLcWk6iO8lR5DUqcOqXrrbaFLiNg9PC4TbEiyJz11Lqd
 AMyx+hy4KUZ4iQQYSEzwVIiwtvXxuDr/d7el2CdzjCSJTlQh8h7+XO86w0j0SkDQlGTqV2l2hfw
 bdvpwXqQrYMgYd9oETrdjS9MRM3z5CFLBYtqi6Qzi8AHBQC2IuIGN6tDoby6tzLjmBRbBELb03i
 +ok3vFznw9zVTRhfMtEP/HeP72Rx9g==
X-Proofpoint-GUID: fKIyuvntzt6mr_etG3xBu34UN467e1Rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290078

Add support for AD4084 16-bit SAR ADC. The AD4084 differs from
AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4084_CHIP_ID definition (0x0054)
- Create ad4084_channel with 16-bit resolution and storage
- Add ad4084_chip_info with appropriate configuration
- Register AD4084 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index fa15b8f63b8a..a68d7fa9f977 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
+#define AD4084_CHIP_ID						0x0054
 
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
@@ -598,12 +611,14 @@ static int ad4080_probe(struct spi_device *spi)
 
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


