Return-Path: <linux-iio+bounces-15866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D016A3DBE0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A871880630
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9020C010;
	Thu, 20 Feb 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hjm3UCB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD391FA84F;
	Thu, 20 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059785; cv=none; b=nU70uuQjc+gOR+GklPBPPpA72fQmc54m0Yp0/ZA5lPLyOMrYvZS6NKnJJKSZ93tWvsDEJe0szDVvpvBGKWnCUg2Mz9jU617Rb1uLY6SJJVDK6vrP/Wn4wdbKAeXvebsJJsQgjwbQGsGuNxhFUiLAQh/22SxMAljV0mP0xZoZi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059785; c=relaxed/simple;
	bh=v2iQV1sOO/mruq7Yz23pk+XzCfss2XxFxsRPQmNgMgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2pIs95NhIe+QUhtmP0I4VDB7ma4PPYeqOyU+x7RjvM5dZWK+/IFYha+njfpr/4iXiyeUo+zAaVjNcUUPqDwqrcMF/++TWMve7sm8Zn9wuCw6f3nWeATKfYVGJC01+Xbt5JQg1hQG+H5p3UtNvTcY6Kd327iQG6PmybN4D6Eygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hjm3UCB+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCCqjR024131;
	Thu, 20 Feb 2025 08:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=H+vmo
	b4GH+8c/AEaQNR5EDbVQaUoJVzz5ob2B+vxPwM=; b=Hjm3UCB++MBriS56znoiE
	ywIEgKO2yN1POcdTcQsZOdyeAWPqR406lFw+Xt9LC0PnnlwT1a/S0Y/CqR5MY5pX
	TVd29h0e93FAvYIAbS/4ZTuF5F65v02Cdjuu/X5+48yzCPXhQ7GZLs5ppwwkGImM
	5dp7qx0mjqs/+949iloYMDAsQljL1A3wC6qZ82PLu/LrSmq2XClsgw+fWydJPiuv
	7IBs0BfbW8vGV3FqjDQ+vUOEL0QFs9IDHRFzqBTKyonfL4fdCb6sd/eXf+h8QANU
	x6gdvx12ONkPbxq7OUtCd9fqN86FPYiBEu1z7qQApM20X3v9Mo8gEv8kLHoRVJcM
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x46yrc6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuKYC054154
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:20 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxr0008409;
	Thu, 20 Feb 2025 08:56:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 11/14] iio: adc: adi-axi-adc: add num lanes support
Date: Thu, 20 Feb 2025 15:54:21 +0200
Message-ID: <20250220135429.8615-12-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: eW2UwbMvI-SQYesDyD4PBLRUT-zSpiWC
X-Authority-Analysis: v=2.4 cv=QdWcvtbv c=1 sm=1 tr=0 ts=67b73485 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=AiCaRuOvQI6FySGr_IAA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: eW2UwbMvI-SQYesDyD4PBLRUT-zSpiWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add support for setting the number of lanes enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index b5c2ba3a44c8..c39f9ac7797f 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    AXI_AD408X_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
 #define    AXI_AD408X_CTRL_BITSLIP_EN_MSK	BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -471,6 +472,19 @@ static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
 	return 0;
 }
 
+static int axi_adc_ad408x_num_lanes_set(struct iio_backend *back,
+				 unsigned int num_lanes)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (!num_lanes)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				  AXI_AD408X_CTRL_NUM_LANES_MSK,
+				  FIELD_PREP(AXI_AD408X_CTRL_NUM_LANES_MSK, num_lanes));
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -667,6 +681,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
 	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
 	.sync_status_get = axi_adc_sync_status_get,
+	.num_lanes_set = axi_adc_ad408x_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


