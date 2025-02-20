Return-Path: <linux-iio+bounces-15865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0901A3DBE7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831EC178ABE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC72066D7;
	Thu, 20 Feb 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fmYlasY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6A202C43;
	Thu, 20 Feb 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059784; cv=none; b=Cxt7WlF/VtVID0ZeM6WtrNOpqJH9BtrevAnPASjsoq0SMZGF8hfK55EYpW5bBMxyAUHK5E30CZjtA1LsunpK5Sqn1D1TJIngL5ifSr1GS9OgcZ6LYRPdDTsOii3C3oHvNosbPI6ElUUPJEBy+1fCzIxKMNwdi7P+02qAmRu25TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059784; c=relaxed/simple;
	bh=bsA4SbuVZSrZyPLo81VthpcEM2db/lAXryKqZfRiAMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZYDZqztvYgJFheU/k+6bcSkoBdPddKPr1Ge3XYSILDn5+idbCq0vlRd82pgawZ9Y7CBLyPBFGNYQ3pGT7tOFi0MICNW+AMlFTyQDYINJVZLNeDvswolk1iSbIszvOMJYv9Yaz8LEo7hQvViI4y7bSSin+N0ywulrd45i7t5Aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fmYlasY9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBRMaX005745;
	Thu, 20 Feb 2025 08:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=M5nq4
	I7DELZdpLPcd2xLy4pOKehKkIefH8m0XJUGHbQ=; b=fmYlasY9+Qfk3XrrguoSk
	O7iVpeprt8M8l7LDQ9r8Zafm8uB3CR3dt2LpHok0/2iUxAWY8kAeAuCedR8St4ro
	w3uQsfJECKs7h7AYWvWQD2Q40GqUkP7gUqrgD0Llt3d8qUI63AQ9pNlCpdkyaZ4D
	6lYytrgrDdUKmGSfefJhvZF5Bv4S6cb9SLwR7t1mwYTPR0RG8DzOAokVoIO56vH4
	hYRRq85obEA3MOOX3jZsFYBqhWiv0m4jhEYHFznLuQujqCe91E88eea/nz15Uki4
	AfZdRYd8ocuHm/sxV4jXtTVWBi+nBhvhsCX4MUBnkza/2q6SLKQZeeMde92AbogV
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x3hj0h0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuJu6054151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 20 Feb 2025 08:56:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqv008409;
	Thu, 20 Feb 2025 08:56:13 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 08/14] iio: adc: adi-axi-adc: add bitslip enable/disable
Date: Thu, 20 Feb 2025 15:54:18 +0200
Message-ID: <20250220135429.8615-9-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: FIujp9Ls0Kj7Y-2TMj1Hafz9Rsrd0Bgl
X-Proofpoint-GUID: FIujp9Ls0Kj7Y-2TMj1Hafz9Rsrd0Bgl
X-Authority-Analysis: v=2.4 cv=OJvd3TaB c=1 sm=1 tr=0 ts=67b73484 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=K3rqzkFOlv3lcIUz5H4A:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add support for enabling/disabling the sync process.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index d4466e02fc28..c7811667f853 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    AXI_AD408X_CTRL_BITSLIP_EN_MSK	BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
@@ -419,6 +420,22 @@ static int axi_adc_ad408x_filter_disable(struct iio_backend *back)
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_ad408x_bitslip_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+			       AXI_AD408X_CTRL_BITSLIP_EN_MSK);
+}
+
+static int axi_adc_ad408x_bitslip_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				 AXI_AD408X_CTRL_BITSLIP_EN_MSK);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -609,6 +626,8 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_enable = axi_adc_ad408x_filter_enable,
 	.filter_disable = axi_adc_ad408x_filter_disable,
+	.bitslip_enable = axi_adc_ad408x_bitslip_enable,
+	.bitslip_disable = axi_adc_ad408x_bitslip_disable,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


