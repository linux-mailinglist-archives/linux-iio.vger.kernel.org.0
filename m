Return-Path: <linux-iio+bounces-15863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9BA3DBE4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BEE3BEFE0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5311FF7BF;
	Thu, 20 Feb 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Oj1OSEKs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A841FE45B;
	Thu, 20 Feb 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059781; cv=none; b=GX0ByCmLpOomMKfrwjXqDurmKpca4n+uuIhb5s3+ItrDBepwsV1KjY1DMgg9t6OW4dpgRVF6XutFRUbcUG2XBQKGtOVWZoV571C5Zrwz1IEqFrUlZoNEuvXYqh/BWwc3re7rYSKlfnZASaWWZEvLTgHt9cJt9nP2+Nat3rD++JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059781; c=relaxed/simple;
	bh=HcnBeQAIxkugoKBYBG6iBHYuJnuH1uNZW21EfdRlQpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRVNBFlYkeXi81F8JRZhZvkUJCnnp+zMQ/HRjbz//7FyKLCZyTthfxBneWlMKe3s6csPVTaSM8W8Md8lao+q7PM5ob6DaLrBe1I5QWbvJIFGCAJJqvd9BpwFTOYMHZK9Tp9QiJtTiKWMyduXt98S9f4eIS/EhPUHRNOHMTdMdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Oj1OSEKs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCD7Qu024275;
	Thu, 20 Feb 2025 08:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iTGyQ
	d0tpTWuqOHhnE1E14rS4S6QwjwrURvj2YvqeVo=; b=Oj1OSEKsI/cch6AmqkfSG
	dcpxCYknB9iywS6YNpJEBMOKX78s0bywlQvNCMCYp7HVjH5o+NSp0D7lYyENVA6L
	uSoMB/AguJpD+wsxcH7XVgfgfmACZb1U7/y9Fo1lya5ec9avOLk9MjXndwu8hk+j
	8IuInN6hv99cHpHTnuT3OtyzZiHe2PN7av1JOyuck0Al6+rp3AZuK7kOuQX/IOS5
	TpB+ws6rf97F3eTWM9DjtkHgxjpti0mITukUUspT+awUTdy2Gg7v4uR5ClxkVggD
	zNRvl57hIJsy8iJdP2iBtggz4IyhfCQ2mBESmNnU9fNw969eS+6YfsSK7oY8/C6d
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x46yrc6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuGnZ054142
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:16 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:16 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqu008409;
	Thu, 20 Feb 2025 08:56:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 07/14] iio: adc: adi-axi-adc: add filter enable/disable
Date: Thu, 20 Feb 2025 15:54:17 +0200
Message-ID: <20250220135429.8615-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220135429.8615-1-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: U9Z7DVrINK0lUTbEVRnnbJspFtu8fEVx
X-Authority-Analysis: v=2.4 cv=QdWcvtbv c=1 sm=1 tr=0 ts=67b73481 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=tS2dMKavNNEhNzk4wysA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: U9Z7DVrINK0lUTbEVRnnbJspFtu8fEVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add support for enabling/disabling the filter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 61ab7dce43be..d4466e02fc28 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -52,6 +52,7 @@
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
+#define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
@@ -402,6 +403,22 @@ static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_ad408x_filter_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+			       AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
+}
+
+static int axi_adc_ad408x_filter_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -582,6 +599,25 @@ static const struct iio_backend_info axi_ad485x = {
 	.ops = &adi_ad485x_ops,
 };
 
+static const struct iio_backend_ops adi_ad408x_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.filter_enable = axi_adc_ad408x_filter_enable,
+	.filter_disable = axi_adc_ad408x_filter_disable,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+};
+
+static const struct iio_backend_info axi_ad408x = {
+	.name = "axi-ad408x",
+	.ops = &adi_ad408x_ops,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct adi_axi_adc_state *st;
@@ -697,9 +733,15 @@ static const struct axi_adc_info adc_ad7606 = {
 	.has_child_nodes = true,
 };
 
+static const struct axi_adc_info adi_axi_ad408x = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ad408x,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
+	{ .compatible = "adi,axi-ad408x", .data = &adi_axi_ad408x },
 	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
 	{ /* end of list */ }
-- 
2.48.1


