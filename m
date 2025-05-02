Return-Path: <linux-iio+bounces-18966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D6FAA6D51
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F032C18950F6
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516162367B3;
	Fri,  2 May 2025 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p4jQyDlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7522FACE;
	Fri,  2 May 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176385; cv=none; b=CF31/GYurw53vg7fuq0tUF8Hgb0JeRURSajQzP5BAITkgov17k5eG+eILpR3Ni5p0W4P45zj/b1U8EhwWM9vOJvaZRnLqtXog/9ifuRCPx879as3ScNW9MesI0vSc1jbyvwD4bpqg7sMj8XdT1Dwqy87ku86FxoIGb1hEMcr9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176385; c=relaxed/simple;
	bh=HQlFKESXhCugNeJbPQgUHHoNvkvtnaIx8WN7c9H+O2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1QlX8YgZ55H7E9sgYcS8Cfi7fa73bJM5qH9rPviXlrXixTwT37O9vb3Z9M9C/N1+jkbY/5l6bSyeakJjxHYTuLqzE6B3LoY27ASrBoYuyIJJ0emCgzLFk/DYH0JbPhGHEJ1URno234FFl3yovIGvpZLbUxYLZ3xf0ruxtvcKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p4jQyDlT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54265IAt019278;
	Fri, 2 May 2025 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=DQvFt
	7jhsX/mMZgNf+GaA+RvkOV+brvoK/N9mztZONU=; b=p4jQyDlT3pZw6MFrqmj8A
	PPTLLA/vSpGqXB/02tsD5mVwaV2FFiDyrbeKsx5NQ9T4Se4vOKzjeJhCQfAidFMz
	tUuPM9/cx0fpRltCa/m9xtgFiYIC4AvX79XVdguhFbjqoXSZaiSN92ENiKwXaykP
	nniGmeUY3rE/OHnoqJTYl8oPFcPffmheQiIOndGVlKotM9BzAXyyuQKZ5pDqxA6d
	9zl/fFW9lfeuJt6P9ARXDG4vR6tofrn/ef7t2VedKUZQRLOZSUSZgpJAFiAtKWNe
	4V6xSP7mOQuBFDcTEAwSEK0uO8FWtCEnmlMdJTrnRlFq+7azJorvRarDcu16z4Nx
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46cm5pskjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5428xcqX058974
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 04:59:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7P015723;
	Fri, 2 May 2025 04:59:32 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 06/10] iio: adc: adi-axi-adc: add data align process
Date: Fri, 2 May 2025 11:59:01 +0300
Message-ID: <20250502085905.24926-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502085905.24926-1-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: kf1Jnci-Y1eGEXbud8pewrtOy21BW94R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX57UZUzKM4TCx I4RPtVAQ7RkXrprYdMWVpdIddGanJZu8cZSE571cyEXsGtd4rg4ow2qZN+4NQDAu5Tvu3lh0ghK x3dzul8rUxHbjrRBXCEJFSuWDiZPURn1Zyl+Dtp8e8iUf0V5+J0GAvGCexw3+NzCqLq8S8BQuV1
 1SAB86oNnqtblnHpmuh9C8Gi6RjhBxqmA9cLfmByDnnxkhqrlJv/jl6X6N5vS5Ve0kQc9N6Ky9L ex/bVdJ2H1wWkUTQ22swjTvPBos/HkcHptz1TG0ODr0cx7iU5Xg12rLehc/mvmm55ltGdc5SaX2 p2wykp7PePbY88Uox7YxuCybJPuQsLyqR+NqfPi8ecBfLFKF+IhzUgenMBM1fjOqwcI7OcSht8y
 dlxfLT5hwigE0FttNbx8L9Og2vECY+OXTDU8H6yyqYvLpIJ4jQU+N82W8iNd/h44TCFHG2hD
X-Proofpoint-GUID: kf1Jnci-Y1eGEXbud8pewrtOy21BW94R
X-Authority-Analysis: v=2.4 cv=RYCQC0tv c=1 sm=1 tr=0 ts=6814897b cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wxM4B6g2en942FlrxLsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add support for starting the sync process used for data
capture alignment.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - rework data_align function.
 - rename bit definitions/functions.
 drivers/iio/adc/adi-axi-adc.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2a3a6c3f5e59..2a79c043c0de 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    ADI_AXI_ADC_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
@@ -54,6 +55,9 @@
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
+#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
+#define   ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK	BIT(0)
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -416,6 +420,38 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
+					       u32 timeout)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	bool sync_en;
+	u32 val;
+	int ret;
+
+	ret = regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+			      ADI_AXI_ADC_CTRL_SYNC_MSK);
+	if (ret)
+		return ret;
+
+	do {
+		ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS, &val);
+		if (ret)
+			return ret;
+
+		sync_en = FIELD_GET(ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK, val);
+
+		if (!sync_en)
+			dev_dbg(st->dev, "Not Locked: Running Bit Slip\n");
+
+		fsleep(500);
+	} while (--timeout && !sync_en);
+
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -605,6 +641,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
+	.interface_data_align = axi_adc_ad408x_interface_data_align,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


