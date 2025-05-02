Return-Path: <linux-iio+bounces-18963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D665AA6D42
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51067188FD87
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315D22E3F0;
	Fri,  2 May 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eVZ3UfLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBC22B8AB;
	Fri,  2 May 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176382; cv=none; b=ocvEOBX7j7vcd6Pv4HlgjGJg4mYvsZ4dWKwTnoIhd+xkJhgWmzqo57kyL1pTkMfl1gk+PIV/L13zSOkzlfC5tCuzr0g5VMhLUHk/w0lChsXYS10FpbEetcuLINgIp2E3wIC/qcVzij3xkCme/SGBOOeynm67WBmsEwutYHzaYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176382; c=relaxed/simple;
	bh=EvHlE5d8LCdBcTcU4Vrbhg9hruUVNcTrvSN0XUwTqg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+YAZYTGr5ygyFRrjQk6CvzVbYqnlqQo0f2zGQCAZPvVujR8lTKMgP5qZhPW0OcPfd708fF7q8rW1l76W9hgP4z5Uouh3D/WZ29l7sUigxLT/q9Hih0lKu0R9qVI1ulKFw+umMnWFNGVcPxbmwHYlVIoHzA0tA9nkz/AxreHi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eVZ3UfLl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5427VDbT030805;
	Fri, 2 May 2025 04:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WHCgg
	HzjGodYAEvbarEyaF35iS/lQgvtCblBcy74j10=; b=eVZ3UfLlJp5J2VlJ4PsON
	HGyYUhMOwEnk3QsxMI6vp0qBtMkSsQ41ycvx4xM8+CuvS6xt4XZzlACp8G80m1Ud
	nnBOSxWtpSCNQLeumhhQh+Ony4ukxmOeLL4Ee+Xr4McfwfUXw1xFONveFXJ8mLMS
	FpJrAwj3oO19UhNaHBpsGJT4kVtUVWmrj3iMaQrZfpnqEYtrkvno799vEKtbsspg
	60GB2Fx1O2KancXZtm8larQasYXCbOVup+dc7GembESxGFy3Zc4i89CPhFQQxm6b
	paTrpTR//mAXQBYnraQQqKg7zyZgC7Gik1B1SlG3/YZ7JdYKZ2jVn1+FxITKq2Bk
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6tr3xq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 04:59:38 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5428xbeg029959
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 04:59:37 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 2 May 2025 04:59:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 2 May 2025 04:59:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 04:59:37 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5428xL7O015723;
	Fri, 2 May 2025 04:59:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 05/10] iio: adc: adi-axi-adc: add filter type config
Date: Fri, 2 May 2025 11:59:00 +0300
Message-ID: <20250502085905.24926-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: 6ZCRRPk0nB7k2xIxt6IPwbtbzCDAERDg
X-Authority-Analysis: v=2.4 cv=TpTmhCXh c=1 sm=1 tr=0 ts=6814897a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=Gqha4wrVLCtXpNfHMFMA:9
X-Proofpoint-ORIG-GUID: 6ZCRRPk0nB7k2xIxt6IPwbtbzCDAERDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX/yqE4scoft+C KSez6b8Oe3qIAdoKXaMgNxjsRLhhZEcSR+H0Ta9GoWMfO4A7UadoHn/W6w+4Kam5qjvJ2tpMh/J PY9xeBFb/WkmoGir07NTy9BM/HnJjYwSscJN18aHnl1NOAN/B/XfReJTIqGqN265ZC2O0qBz9tv
 xzzc39TlVFNljkp3eogAqou8IZZsuEWAIM+PdcFTR3vIPmY9FmjRNXV4aHIx6hMzD3Zzn98+A9W lWHg9O5V91/U+5IBuFxHQGe56K6cz2v3KQtYPdro69kGN+h9fVi1Pej7Ss6Nn+/i3ZhSQz52EXV Qog4Sftw1AUoD4dbow0Vxn2A7LQHD8LRTt8p5xeGqZPITpwkaMgpBbCGV2lBRxYLUostEr/fpza
 JNRjumJ69L7nUjC7Hq6Z823ntZy4Bfn4bTY8w1PtDzoI6YBEKfaPnbojmwY/wID3KNzl8OOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020069

Add support for enabling/disabling filter based on the filter type
provided.

This feature is specific to the axi ad408x IP core, therefore add new
compatible string and corresponding iio_backend_ops.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - update commit message to state that the new compatible is added.
 - checking for max value is done in the iio_backend function.
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


