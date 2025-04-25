Return-Path: <linux-iio+bounces-18636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B78A9C78C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A3920061
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6E24C07F;
	Fri, 25 Apr 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UAe3u3De"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA29248889;
	Fri, 25 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580368; cv=none; b=ACj4bslRE0teMJdc8u6a9yWknj2i1dqNRhmuH6h00iU21XTIPVap0q65cHdK9O5+7UzTOYLuJ+pBDr/x/QYILLfM3pTrLqOWymSMWsah/FoMK+mNj/p++x4l/E0HZ2aVf5SZFkwByVM1MNDZYR6CtPF/PPLkIgEKWLptpJTHP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580368; c=relaxed/simple;
	bh=iGjdECwz05Q23TjbVzfJUEmfOx5w5Gtw9dhMLrMcSBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgH2qdjTRFFhxbhucMLMbuONDAh0FaOn+8h4BylSGKJvq72gPNRGTqrCX11gBR2ORZjOsi+7mIHNLcdQPKCXNfCMJHSivtD/LJGHeuo3qPBLlXnL4WB6nu2pJih53uH5dfFvih6Us7Cn8JQ8hAIeB+sBrj8ELqhxRDFZzaf20+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UAe3u3De; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P83ln8014684;
	Fri, 25 Apr 2025 07:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lP+/q
	WeaBM22LT8OSzoG7B+UkNZ6KtprRXM/PBAyPJo=; b=UAe3u3DeHKi1IeYtzNlrE
	2s7y2byupjwBmLIAUzvYw/sT+3LycgfpK07ESN3TxXq/TQhugvae4jvLGa2r3rE0
	RamaUNgKDXmW/agCk5+i2suhdjt8oZUZlK/t2k8Qdy9LRZyKwqXU7iYIau1srqUR
	f9VcNAnCCFRLNZsFwyAP2IdUuMUuCPLR0YQqjORcugVtWDvqDJQG28XSO24yZyrG
	w1cyxyRjAeTNUYMZt1NDLCoTn6Gy3JGDctgt2aAwrvqAM6FFnuJTcmxZm09a40ug
	a7xr4oIat4SzTV+2M209YKjXYI0dst8P2+TKGguGmyQmFmmGO5IKBg4d3MBXUf1x
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 466jjwf1gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ3Vg049236
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:26:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:02 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbx003881;
	Fri, 25 Apr 2025 07:25:57 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 07/11] iio: adc: adi-axi-adc: add sync enable/disable
Date: Fri, 25 Apr 2025 14:25:34 +0300
Message-ID: <20250425112538.59792-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425112538.59792-1-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 6fSa6DozUhHTvORUXs-MuD9MfQm4DiX4
X-Authority-Analysis: v=2.4 cv=JMU7s9Kb c=1 sm=1 tr=0 ts=680b714c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=x1IIngsD5Fk5sZd3GpkA:9
X-Proofpoint-ORIG-GUID: 6fSa6DozUhHTvORUXs-MuD9MfQm4DiX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfXywQcnw0vhkvZ 6wSV0sI9fCN1FwRYCsO+XUw6Une5yPyjwhZAnWJLDeGpDb0Xz5iJAJW3FpKFGmxG1g79dUuaOIm G0Xtgajr0GtwCgNg5d/JTO6x5gt2rrgVHGW1gFI7AWme5bXhQmMKeCFUAjjgUFVrbWbJn4GmfoJ
 re8BKsNntjFHyDFjXNS8CBj2qtsjOaJ2F1KDEQOZnUoB2zOjl/fx3MYIwVCFw9lpa+cayp5WEBS GH4QWSfaacQMhkJnAj4Y1fpR99BW7GSmeeF0GCAU7mIBOjW0aITupho+ME5ab7Enok/1lM5nXEz 6LMdbDob3wkQk2yp4XuRW6cvO8kw2L47b5zpfk0z5cp3dL9Sduqxhci0is63KIU2RGT0G8gbD37
 +g5FU4pVnQxwIqmuFwcwlDTnMadGW24w1TrMhJtqSfoaqNyfQ7RyOC5pVeYf6pKorI5XG6lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add support for enabling/disabling the sync process used for data
capture alignment.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update the function to match the new backend interface.
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2a3a6c3f5e59..9947be059f98 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    AXI_AD408X_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
@@ -416,6 +417,22 @@ static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
 				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
 }
 
+static int axi_adc_sync_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+			       AXI_AD408X_CTRL_SYNC_MSK);
+}
+
+static int axi_adc_sync_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
+				 AXI_AD408X_CTRL_SYNC_MSK);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -559,6 +576,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.request_buffer = axi_adc_request_buffer,
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.data_alignment_enable = axi_adc_sync_enable,
+	.data_alignment_disable = axi_adc_sync_disable,
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
@@ -605,6 +624,8 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.free_buffer = axi_adc_free_buffer,
 	.data_sample_trigger = axi_adc_data_sample_trigger,
 	.filter_type_set = axi_adc_ad408x_filter_type_set,
+	.data_alignment_enable = axi_adc_sync_enable,
+	.data_alignment_disable = axi_adc_sync_disable,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


