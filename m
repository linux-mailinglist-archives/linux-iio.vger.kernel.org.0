Return-Path: <linux-iio+bounces-17941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A925A85D5A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6D01BC0343
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DE2D4B6F;
	Fri, 11 Apr 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="02A1RD/8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BA2D1F6E;
	Fri, 11 Apr 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375017; cv=none; b=raEb5TSJNGD3mNKfpgTBxm9WCGadYX81WhJ0dssrKZgOvR2/xpcl/zOtpoj3XU/GFETwaRdEdoZpCDM/U59wZ8av9avtyguxoncYooMy5oIhfNPXeYBOSNfq1L7l5H3Ag/gVARf7xxICEcQsSasTBxxkR159oCx4L8qjGhAVOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375017; c=relaxed/simple;
	bh=npI1BvUjnmfS73h1yJ+ckjGE++awkpQWeESJpDz6f/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8s71uDTYs9GORh4ehmKFbMGK2Ol6pxwTeNlcdpshLzRWWLBrlISBKjqSgWYf1dSyc3YXAR/iPvmyQm2S68VKwR9+Q3rVY8YzLyOIqMd+UnV5RB6H86iyHZRaNdbb4SB4GNxFHrwuPOWFVp/qPMtbM1GL63inR1xVwqNRtZ7P9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=02A1RD/8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9Bi3Z015148;
	Fri, 11 Apr 2025 08:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KaVId
	h0fAgARtzDwpzP0z66S4h8yDzjO0NjMbHOfswQ=; b=02A1RD/8srHTaNrtrIvcE
	Z+tRqgzGNghm2znXXSWv7/ZaURBZeZ3J7ctXx/GI9hN8/MdBr6IC/FTTtflP80PH
	yVJNVa8GJAKcVa95WxVQBUAOMLfvXmBKhaMHwUxeLfntW9wrlv3tJpypNJaCtdrY
	t+f0IlmmGxmEgtPBq9umQjq/Gf7s9xGPCfFSjfgVtU1v0X/Gj8JE2Z3TmnWD8OvM
	PNb4AzK0jUX2gBAcwsqg00KRXuhcNuR7mhz11vF+KhXAxB0UBKbGGrrG9jNmrCPx
	A0wh+XjUeW5a/Wk/2O/s9ARrm+tBiBz5fpLWgHi3R+UrTCTY6FtWVl6D7Mu8e64o
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6u56m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53BCaqwb005182
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:52 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 11 Apr
 2025 08:36:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:51 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPV006015;
	Fri, 11 Apr 2025 08:36:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 11/13] iio: adc: adi-axi-adc: add num lanes support
Date: Fri, 11 Apr 2025 15:36:25 +0300
Message-ID: <20250411123627.6114-12-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411123627.6114-1-antoniu.miclaus@analog.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NsoQYATsvjFMhwHtURjKqADt-KyyYdbR
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f90ce5 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=AiCaRuOvQI6FySGr_IAA:9
X-Proofpoint-GUID: NsoQYATsvjFMhwHtURjKqADt-KyyYdbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add support for setting the number of lanes enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0d12c0121bbc..8576c0c1d024 100644
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
2.49.0


