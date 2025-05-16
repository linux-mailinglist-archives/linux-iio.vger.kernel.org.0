Return-Path: <linux-iio+bounces-19578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB235AB979C
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F95A04822
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519B722FF37;
	Fri, 16 May 2025 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gRWb44UN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0222F77B;
	Fri, 16 May 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384019; cv=none; b=YiCMXQxDoeqni4QwAMw4xAiYNDZLP1VZfmKg3te12+pBqRthnYni9xOuyqwA0LVwX4+b5Q13Y1BOtqb3oRvgdgOEsadGirNIwkImfZtHBwPCyq3fdnoWfAWxwakHNl5Ib6xAt0C4SrtMgXFlZhUaJ1BwcqYdfuTvGrDwtFsEdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384019; c=relaxed/simple;
	bh=TUYc48z0lNgqLqi1vHJYv8MyyzFgasv82sjTQl5P+kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIYonDCQ9aM5ZjQVgauWvOTorESQ2v0x78QlogSYBQaHNBedlh8n7TKCgyjSrP+UGkyTALdqUJ+rgF3yd5vvqjEFjMmpGJ8sicxyQ/okzmOU+Id0i10o0nvyLTMfvxGhSZYry2BXexTcA0MF+WD44XP79FK931Ef0V48IcIfJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gRWb44UN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G8Ce1A016372;
	Fri, 16 May 2025 04:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0hvsd
	+G13KfwN/n8/HSXfh/s/bV6cQeB/WSq4KwPF9U=; b=gRWb44UNUtQefLyzgogkt
	4/Y4Tbv9yJvUHgLsjkpLSEpeqx7X8+XYL1QhkhZXGYSDoDwtrmCK2dTmKR66lagZ
	2w/pUoHF7DC7jp48adEvHRYGweK3hO7e68qOc/jDCbzrdWLf6omiPgXqYRnuWyW1
	ot4rf8MLKXts4uVeT4ZE48nxdvuHWBIY0McKLbPp2JwtFq81P2RHP+k1Y1qzVaFN
	iCwxcM6+TXw0mMqwJM83PmS888nNohNwm5MUS+tiVefKP2OFqNCncOtH+mrtYfiZ
	5uSaNpbuUO62tyxpwA3NvxHWn0KKswlEayeT3lS+d5FZasxkuYsWwLR7IoqO1nds
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46mn654vfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:26:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qrdh033635
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:53 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwk031549;
	Fri, 16 May 2025 04:26:47 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v6 06/10] iio: adc: adi-axi-adc: add data align process
Date: Fri, 16 May 2025 11:26:26 +0300
Message-ID: <20250516082630.8236-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516082630.8236-1-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WhYAjsJHnEcmtUeEHxOTSTPlFKl0I72b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX76NLYOhj+brk
 dDmRfwTJ1eiOGyztEynR/h2QZNBB8PBC7xlGNnnfkeJ0l5Pp+SVOWGtAj6p+4BfMVY5vpGOvgLd
 mQADNCqHkIvV068I1tfjOWNBa0tI5YLT/N6EthEN6JaLh5W2ed4sf/8GFWWbZbwR5fUTIvrxyc3
 FBtw6Q2UuiwgTY5yYo6Wxdee2IxoKz+0Qoq/RafBySNRow/HJq9VucyPcqpQEUpV9R2sOHum8z0
 WFrdHX8sYV2yC+PrsGv7ZSvgnFJHqVwtH6ZUlHkFCRX1jaVh5pWYLGNaDc8UdeCaRgazvobcEKl
 2axL9XSA0tarCj69xX0HX2oAiZcx1laXs/OUko1lhXggcNkqZX/8xnaHd9cbmPglwXz0uM6IPGv
 eNLq1HrFzUfI4IDZcHBpibBLvzE4F4JdSc3qeK2h+iI08akTJ5/F6zEApcG43rnGgAyRX0fA
X-Authority-Analysis: v=2.4 cv=SZL3duRu c=1 sm=1 tr=0 ts=6826f6cf cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wxM4B6g2en942FlrxLsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WhYAjsJHnEcmtUeEHxOTSTPlFKl0I72b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160079

Add support for starting the sync process used for data
capture alignment.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2a3a6c3f5e59..f9c4018e3b41 100644
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
 
@@ -416,6 +420,25 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
+					       u32 timeout_us)
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
+	return regmap_read_poll_timeout(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS,
+					val,
+					FIELD_GET(ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK, val),
+					1, timeout_us);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -605,6 +628,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
+	.interface_data_align = axi_adc_ad408x_interface_data_align,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


