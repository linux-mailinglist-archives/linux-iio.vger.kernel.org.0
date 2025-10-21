Return-Path: <linux-iio+bounces-25327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B74EBF5E84
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C24605A7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790532ED24;
	Tue, 21 Oct 2025 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mEeXT5/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCC32E73E;
	Tue, 21 Oct 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044063; cv=none; b=ekJn3WuLc5bJLwA80JlwY45Nw04wirFJ6H0PI/sRsKveQRil6+PgjHnsqy/136U7ltnu6BN94xpW3Hw6V4RsJho2AiCo0iYfU+l5zsodv9iJrTR+F6UZyZix+zG3ses9SDTE2XIcv0YCBf9+W5WRMkj5GsgSUUdqvYmI5eTvnmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044063; c=relaxed/simple;
	bh=+5xmvBn7LsVVWqlIR/GzMI0xi8l1Q3pvWm7cjzA1Aes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCD0msZkDqTYyay1kfHhBNKHIv7zmo36DeFNLeUg78S5uG+wTzNDTlFTCJX8PmgTKxUwRcs5wzD3CB39HnFMZ9Kj0hQRmpjHxKKrT/n6j29c2hb+ffzTZFz6U/DxQXpSrRr0em9W6ykVEetc50mgvTuLGlMpQotbip+oAtFin/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mEeXT5/y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8PGMG006006;
	Tue, 21 Oct 2025 06:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QApSc
	2wKfhT4tzEg3Fh6148Ee9+Atmg+WBM+BVv7B1I=; b=mEeXT5/ySa7V4+ziDR5bW
	YE9VF6ke/5ek25+QZ3jhqPpfnSapMNXFGKC3oSxjC9bsSExFO8vSfxMigKf0ypZ+
	qAZXAY4HghZfx6s3F59aOZ+7th27aDelLT0FVcMWeSXwSPcTsoQcxJa6B1Xwy1nK
	pWGTWaKwO53jLJCdjxKIOirs7W0aSNablcWLU6gBsucG1oaBluJeFMLR9wQcgDB6
	uejA7PvIg7TUkEsbf8mfCHsbyq8H0YZOUvky2Vqgx0CR9rTjqO07n4zBsAAH2H6a
	ZG3WXFMiQ0nSinpOP7IbP+hW6+SNVmdXSL2xiIpGOWSpHkoTC8N0wq5zfwjw0hwi
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49wt9vc7g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsI6c061047
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Oct 2025 06:54:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:18 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Ko002507;
	Tue, 21 Oct 2025 06:54:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 6/6] iio: adc: ad4080: add support for AD4087
Date: Tue, 21 Oct 2025 10:53:48 +0000
Message-ID: <20251021105349.21145-7-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=H5vWAuYi c=1 sm=1 tr=0 ts=68f7665c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=xOphimBu5T1goNqgOUwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XbAX8UobJhC6kcYjSF-dYh1QTIRuiBbq
X-Proofpoint-ORIG-GUID: XbAX8UobJhC6kcYjSF-dYh1QTIRuiBbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1MSBTYWx0ZWRfX1jikG9MeALXx
 4ozbncjXHdUPQ45TLhuEq4rRK10ueHjgH/KO1M7YZ84Be4vPA1atHsCcUSNskw2ohjgpSIGO3Xm
 FWZ9Z9V4nH9EDtutLKGAo8LAOyvgnibpS+cWPBxRz1OnO8U4vvu80aUOqpm0UH/sC8jJW6gm7uR
 ezDzX7svouWN3ZA3/0/LRVH1mxWy3t1rqaDh4EkXKsKZrNODkWEB3uigMPEw2ppfkjvrcGdRXTp
 rCsyq9ZDUl/EBweFwVhGVR+Z5EDE8va/BcRejfv29foVFTZWBS2JU4c4lvU9stvQJmVV7OeAZcH
 BwaCI8qTyFxb54HS+LGtEmk08Tn8iyC+Vv+bzBeqHrZa6iffsPJx9HSfYTly6f/DCeK2+qb4r1W
 EafhWAAe9Da/dftkZKkkCNdobc6CTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200151

Add support for AD4087 14-bit SAR ADC. The AD4087 differs from
AD4080 in resolution (14-bit vs 20-bit) and LVDS CNV clock count
maximum (1 vs 7).

Changes:
- Add AD4087_CHIP_ID definition (0x0057)
- Create ad4087_channel with 14-bit resolution and 16-bit storage
- Add ad4087_chip_info with lvds_cnv_clk_cnt_max = 1
- Register AD4087 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index d6d0688adc3d..7cf3b6ed7940 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -130,6 +130,7 @@
 #define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
 #define AD4086_CHIP_ID						0x0056
+#define AD4087_CHIP_ID						0x0057
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -447,6 +448,8 @@ static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16)
 
 static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
 
+static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -497,6 +500,16 @@ static const struct ad4080_chip_info ad4086_chip_info = {
 	.lvds_cnv_clk_cnt_max = 4,
 };
 
+static const struct ad4080_chip_info ad4087_chip_info = {
+	.name = "ad4087",
+	.product_id = AD4087_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4087_channel,
+	.lvds_cnv_clk_cnt_max = 1,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -656,6 +669,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
+	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -666,6 +680,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
+	{ .compatible = "adi,ad4087", &ad4087_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0


