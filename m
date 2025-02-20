Return-Path: <linux-iio+bounces-15867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75FAA3DBEE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A47517D953
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7720DD56;
	Thu, 20 Feb 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MhcMzTlk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5302080E2;
	Thu, 20 Feb 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059786; cv=none; b=mf6RS2nJzNaAOjf9kC+sN0wqyOjxsSx2ZhFC2NF7g0VDcrjVcbPXvftR9wNcSdqApuT7ZUCAeZp+zoc/fhiNcd0wOH/EDVfj/29iicpKqBRnCekIrg+tHBOo06ghOYFLHs81AqpRx5KdZfzq5FIof+u/0+tIFJHIWTHXnWLMpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059786; c=relaxed/simple;
	bh=NOihASg/Ef+jb8uqLkOuTGMK7/qufCjr3asSJ0tfWxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KW6xSod/pJbenBpNvgkHCJzsqD71L/iaYQvOEdXKvEVqkQ5raBB0GrFWyFqg4bPY6MLjN/o5EethFvWy1DKki6Z2RDUyUS5V0coIKYkbccDixw/7eyc/x2of0VNSm5F+fy0AHySucXNalFrHyPzMOHrWvLFNGId7mkxbR1+3RUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MhcMzTlk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCCpZk024127;
	Thu, 20 Feb 2025 08:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=60Wor
	WDwddjY3eNbVNNVj45kosDEU8xv9qW169VxB+E=; b=MhcMzTlkssZWzjVCD7M2E
	i8YbIvR8xQIqC8HXKaBXDGbHp9iSO+DXvRuugqOaX4+XdG5bk35ksDCnnexAMuMl
	1r8qHDFVgze7jWPiniRrLX8FmuKK996ej0rNeqqNBU0Hu+zSds5/jBfNWEkzdxvK
	jwipaojLgbLz54NR6jTsLSTM6rQ2cNdIKP+NuAB6fKG2IGO7Fir8tKQ/S0HLJSRl
	WbHxpm88MgbP1rjsxOWcNetEZNbtqVALngbrc2mBTvWNenwx7c6HBS3eEWm8k+lH
	fsivTOZoKXoDXC+t5+ExXzSQwDFoWkXMUPW40Ye0LDiuAqvAuYcR8LdVp05YBZY7
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x46yrc6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:22 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuLit054158
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:21 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqx008409;
	Thu, 20 Feb 2025 08:56:15 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 10/14] iio: adc: adi-axi-adc: add sync status
Date: Thu, 20 Feb 2025 15:54:20 +0200
Message-ID: <20250220135429.8615-11-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: xzhov4h2HdVl-nz8xkRIu5JxxN67OKEL
X-Authority-Analysis: v=2.4 cv=QdWcvtbv c=1 sm=1 tr=0 ts=67b73486 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=iHiT1KXCh9GZH4AYC8IA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: xzhov4h2HdVl-nz8xkRIu5JxxN67OKEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add support for checking the ADC sync status.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 7f6dc0ff7c54..b5c2ba3a44c8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -56,6 +56,9 @@
 #define   AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK	BIT(1)
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
+#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
+#define   ADI_AXI_ADC_SYNC			BIT(0)
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -453,6 +456,21 @@ static int axi_adc_ad408x_self_sync_disable(struct iio_backend *back)
 				 AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK);
 }
 
+static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS, &val);
+	if (ret)
+		return ret;
+
+	*sync_en = (bool)FIELD_GET(ADI_AXI_ADC_SYNC, val);
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -600,6 +618,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
@@ -647,6 +666,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.bitslip_disable = axi_adc_ad408x_bitslip_disable,
 	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
 	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


