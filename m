Return-Path: <linux-iio+bounces-19584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B8AB97B2
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE2616288D
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518622DFB6;
	Fri, 16 May 2025 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DP2qG5nF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9622DA12;
	Fri, 16 May 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384042; cv=none; b=fW+w7/gmOub/Q6lQH25w2vdUIpS8QQx0mwfoSjZoYZcTo3nhnHK3GKPiZ0mJAFEEVWzXVFUhELtno6Rm75cF0IIOugjv0yRXRtgKCLewEFM+PwvAAbvT1pw71CU4cVGDWVKjVHsTi3xPjGOvkj0vmVGwHlQfRxx3ijl7BLN8N6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384042; c=relaxed/simple;
	bh=3q/GKFuplJbG4mV3MADRU/64WOlMdWW2JP+DRIqFOKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFQMdUMHt7mTiUHhTl0NoZyBN9h/uYzeOBKry/Rr93ZVgPsx3VHUrO3+pkLuydpVM21iT0ottbcZBPjF/Pcce7idGo3pdNmfQQG46HmB1iUaLhSLE+yJhAnVjib7WXoL4Umrce4/Y0UCsPONhlmOAgISgxqXHcoJq8nzEi9UT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DP2qG5nF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6XkgK010053;
	Fri, 16 May 2025 04:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xBl0e
	5N3fGGp+F1afaexSwGmJ3XYC9+flArzGOheeWY=; b=DP2qG5nFwny6k0vd8LdYH
	O31alMSgys6oMU6N7h/didTsuHh8iGIZyUjwHisLx72+R71DwARZgOrBlLVgYos+
	iwk8k2RxzSaJ6gy66EITwK8L06I4djY6kPFVvAcI8WQ4jYJmjFctv/69WrTwMlTw
	QNY7DlWF49wxh7UZuOnWFbkthfaGvfBBI5w2Vqioyin2kAtMDxHbynxdy1sVByft
	i8caec4Jb3h1UC+gZ2B5cz0NA/nqw2kLTdJaBd3ROG0GhOyEyxO3G3QkgEDl/vnX
	3iXUIqsDYaQSCKigx4fdMt/O2PE1X6wEVsHhjTvmCaVnxBWCZpxCwtuh0DhQ20pi
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46p070retx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 04:27:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54G8Qqgq033628
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 04:26:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 May 2025 04:26:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 04:26:52 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.120])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54G8QZwj031549;
	Fri, 16 May 2025 04:26:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v6 05/10] iio: adc: adi-axi-adc: add filter type config
Date: Fri, 16 May 2025 11:26:25 +0300
Message-ID: <20250516082630.8236-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: hH4JEMf-_uKzKlPzOc5IPHacqJK82xrP
X-Proofpoint-GUID: hH4JEMf-_uKzKlPzOc5IPHacqJK82xrP
X-Authority-Analysis: v=2.4 cv=A/9sP7WG c=1 sm=1 tr=0 ts=6826f6e3 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Gqha4wrVLCtXpNfHMFMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA3OSBTYWx0ZWRfX2QcDhQpyjzXK
 2RhOEEdoqkJvvaD/ZdVtxBG4jX1tHzB25UqA7OgS+IXvHYP8F2BI46LmNmJmmP8nqLU6bwkULQW
 Fscros1t/LVU2L++GLEGq0GgVu+DRfbI0Olw4lLJ+SXStPXpPZ6H5Uaio3XAXn0VPvT20+/fBdh
 W6TzK6rY2pO7cwTgc3WY8FOncQy+3VxqkpMfcqlLm9rvNf3BUFmwJbwdazPGE/bZo+4Qxth4ODx
 laqUboiWVApsr5TFXc0uYQEEorICkdPTpWDc6DpqMWIX+KB8wW8pZHpIyP2FoCgXV+NTk4RrwpZ
 LtYV0zPOgqVebeprTwbhKiTcsrRQxCjMkRTQaoyH+d5fOgX5zcyde8mNdHlxfIfUaQliYQgTZY/
 2/1Ze/m7Z4Oo9dXCMgnxv9LEJMRG/ps78Dvrz/V4aS7jArfSFsgjL3N1HybJmbCGv+8+AGW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160079

Add support for enabling/disabling filter based on the filter type
provided.

This feature is specific to the axi ad408x IP core, therefore add new
compatible string and corresponding iio_backend_ops.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/adc/adi-axi-adc.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 61ab7dce43be..2a3a6c3f5e59 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -52,6 +52,7 @@
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
 #define   AXI_AD485X_PACKET_FORMAT_32BIT	0x2
+#define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
@@ -402,6 +403,19 @@ static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
+					  enum iio_backend_filter_type type)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (type)
+		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				       AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -582,6 +596,24 @@ static const struct iio_backend_info axi_ad485x = {
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
+	.filter_type_set = axi_adc_ad408x_filter_type_set,
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
@@ -697,9 +729,15 @@ static const struct axi_adc_info adc_ad7606 = {
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
2.49.0


