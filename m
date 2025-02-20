Return-Path: <linux-iio+bounces-15864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346EA3DBDE
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9AC19C23EC
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D82204866;
	Thu, 20 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t3qPaKlB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137B1FFC43;
	Thu, 20 Feb 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059783; cv=none; b=pMT9q41A64xSRai9qGbHEji2Dz2zgewqOR0WfwBDp8h+KrJ8wlcgXSGAX1LkxjuHnCxnF0OvVSz+QHnM5zFbp3cqTdZxEbwC9IghtyI46UD7w2syj5xJXPbc6PULxTnZ0HGhXtCL/lJynneMhoC12595j+GMmdzPrEvhEXTq6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059783; c=relaxed/simple;
	bh=sYZAxPl0RyVQE3vg1hEkoEp7cETlBB5LdZ47XOl7TOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PobARbbtS5IMBemTRoBD7ouB8ysrTq+Sass48WgT23crI5UF5a/PzVQm/B6ax3t8tpYlz2wNGsvjmBYeA2ut5ysvOa7bdgEX46y92S5bw+XMkpY0VUDkqOn0Gz8kTK8ue8W/pdNxV1eWgzqUQEUkIntUrII/3SKWlCgvpWvcZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t3qPaKlB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KCCqjQ024131;
	Thu, 20 Feb 2025 08:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TbRja
	XDavTJQTIE1EOGSbzCBkizcb4aJzMnb8YTnHUY=; b=t3qPaKlBQPhK16XGKiQeC
	UWzOWCHqaUZ7ngUmLrYxaO/whXb7vKIvcVWZeWwK5lHXV2s+eg6z62B4F/fV6o/b
	4mFp+xWzelHwfu6pVBDMMLk6cTYjaTwuFprigKz+UUs3hYeWPM1uY0FGkoSeXn4I
	LL6PK64kx3PsYsxTnZ/OPXWOR4aDFVGuxyDgdN42YTyjmgaWlyjMAuPIUOItSz29
	6+Tu8JWvT6hJQxlFZC2CwSKWRCCL8mM/zMw57eNLQ50JFwiNLEDCbtCYChPq6i1p
	YwMoM3ZRICyJejHXe30lWY9gNGRNAccwpIKyK73o7Tz7gS7sAmGrWzrZg2kiZHEt
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44x46yrc6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 08:56:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51KDuIsd054147
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Feb 2025 08:56:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Feb
 2025 08:56:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Feb 2025 08:56:18 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.155])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51KDtxqw008409;
	Thu, 20 Feb 2025 08:56:14 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 09/14] iio: adc: adi-axi-adc: add self sync support
Date: Thu, 20 Feb 2025 15:54:19 +0200
Message-ID: <20250220135429.8615-10-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: 6KbOo9WHT4yr2MCf-Aj00_zkquWmZgVp
X-Authority-Analysis: v=2.4 cv=QdWcvtbv c=1 sm=1 tr=0 ts=67b73483 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=WgLiV2wPMLe3KAJAQCsA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: 6KbOo9WHT4yr2MCf-Aj00_zkquWmZgVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200101

Add support for data capture synchronization through CNV signal or
bit-slip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7811667f853..7f6dc0ff7c54 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -53,6 +53,7 @@
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
+#define   AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK	BIT(1)
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
@@ -436,6 +437,22 @@ static int axi_adc_ad408x_bitslip_disable(struct iio_backend *back)
 				 AXI_AD408X_CTRL_BITSLIP_EN_MSK);
 }
 
+static int axi_adc_ad408x_self_sync_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+			       AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK);
+}
+
+static int axi_adc_ad408x_self_sync_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -628,6 +645,8 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.filter_disable = axi_adc_ad408x_filter_disable,
 	.bitslip_enable = axi_adc_ad408x_bitslip_enable,
 	.bitslip_disable = axi_adc_ad408x_bitslip_disable,
+	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
+	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


