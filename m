Return-Path: <linux-iio+bounces-19370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19210AB1132
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6B1BC48E9
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02053290D85;
	Fri,  9 May 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XNkdEbc+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFD2900BA;
	Fri,  9 May 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787845; cv=none; b=FIyGcacOVxkoJk18ZYSH9fJ2ICLwF1CvNR0+PDvhk6ag56Rh8RQrMkhA8hUZSqJkFIaJP/KxBP0RGxeI+BLGM7zlvICN/p6YRoMDI0IgHDqqqmLzAfKm5C6I6JH7SmKPlultlvbNXgW2/F1zW3ZldZBvMaf0VA7CcQmqrHNHJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787845; c=relaxed/simple;
	bh=QO3+heLiv//QBFzmUS97ic69T69qA7aFOSlf+aNg130=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijm4x3yLIgicfksE+f609y3vBjL2M8LiJOUI8MxVxNLacjelUjo1kdmhoyBvIaicjW5noJuw2BS5/zwm+mVZ+t1gQLGnjdbmCHyLrKAX2WnOY+Bg3jGLDt4qqQ4XCZHMP/o8xzp/Y1CCgfGQE/bQNw44qxN1xx40ZjAz+EjtN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XNkdEbc+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499eLTg007673;
	Fri, 9 May 2025 06:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FWUTN
	wvbeducbOQhkZlHJNRRZTh+nc4xsSRbCCtQ/W4=; b=XNkdEbc+cAY4qykKkx+z4
	63a+JSFlH5G7aRJK0LQqa9yTUlVF+idDBjw8xTYHePch8nqTL5XPPKdv+KyQG/Rb
	Lx47BtiBMDP7mtpUJd433Zs8gvR3F/xZZz9n77VMa2zwdjUVjEBM0ddDggxOp1sr
	4XC0K+BU1JKxyY4b+QsXsuavR6RFUjW8forMz/BvpbpxaAT4jj06mUJnT0/YoscJ
	NNoLlEETb6L1Ivqw3dMN4dEolVJcYCCaZmGUK1dYJmejOddHfdPXiiBhEsEcNHDa
	gDZrKOat8wQWRCxyhyv9cufM3R4oWh/lOL25MsDgPC7qBwljiGIr/DVG3ddyurqu
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hc2yh8w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AodqK049063
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 May 2025
 06:50:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:39 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK17014223;
	Fri, 9 May 2025 06:50:33 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v5 07/10] iio: adc: adi-axi-adc: add num lanes support
Date: Fri, 9 May 2025 13:50:16 +0300
Message-ID: <20250509105019.8887-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfXzzz65lEeufDp
 n2qTPKshBgKsf5ZpfQ11EciXStB7pwZDMrMG09k5ez76cEQJcokjuFh3LC5T/Qd+09yQOU0lZ95
 slGAjBtsrlZJI4YBkpuAp3x5VSvc5sroN+PGegrYXj95Asv1a5/15bokz8fxswwmrB7w4vQZVSZ
 RCCG11DxK5PDSOOjUipuIMk42gKdUeEhrHzaO6K4P4StHoYUYLyblDRSn+R3JUK8gmATVErsWEw
 uYwgVRc5PV/gJeM7Cj30bWQA0NDQDXHQ5MNbzQe1pE6cAHE8QHMzAcyIRr9KyXLzzttc3cnQPBu
 ZKlbSH9Upxo427rwCZ5ayXUXH5imt2ohMbDq3rNKt7ECR0y2F7sQJXinAlNQOhmlpNuKtoMq3d+
 Gx0GfLSw1KkqVLF2j8gofjwjKHwl6l6+9iaj1L4NDDlarYSmtBb4rOVpMYJ187U2xi2voayz
X-Proofpoint-ORIG-GUID: MINAD8d1HiOK43NMgfe-YTCMlgeSU78G
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=681dde00 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=MtuLGBRfhagEvKnVNLsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MINAD8d1HiOK43NMgfe-YTCMlgeSU78G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090103

Add support for setting the number of lanes enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index f9c4018e3b41..d9a14fb6b8e8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    ADI_AXI_ADC_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
 #define    ADI_AXI_ADC_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -439,6 +440,19 @@ static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
 					1, timeout_us);
 }
 
+static int axi_adc_num_lanes_set(struct iio_backend *back,
+				 unsigned int num_lanes)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (!num_lanes)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				  ADI_AXI_ADC_CTRL_NUM_LANES_MSK,
+				  FIELD_PREP(ADI_AXI_ADC_CTRL_NUM_LANES_MSK, num_lanes));
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -629,6 +643,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
 	.interface_data_align = axi_adc_ad408x_interface_data_align,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


