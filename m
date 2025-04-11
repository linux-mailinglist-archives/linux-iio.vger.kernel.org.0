Return-Path: <linux-iio+bounces-17937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3FA85D5C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1099A3ADF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3B2D1F4C;
	Fri, 11 Apr 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FGDGvADx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C02BF3DF;
	Fri, 11 Apr 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375015; cv=none; b=UIWGa3EIGxHZm3WeaouCwBNrqWuf8lOI6O5mmVcof8w9nUk0xI3OXQB8HzAzrjDmuNPSQU8+wwP2fm2s+gGAJadI45uGLkDEGFsIQOa8Dx+lio4kJVRVqXfD1RBJjIwY+upMLUFgYwGBpTkGqjixVIAqz4Dgvyrlktn/NAyEMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375015; c=relaxed/simple;
	bh=bTnyd3aMCc6WZOdhCEeOSBsFdJf08mn3FnlCPBSLKz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faBytkJLgfPX7BEebpg/gnnARwryGfIZx6aTTmiRfWckwOymR1DRRrTsxsh82nKIB/Gxqeq8YE3Xnl+2ptiJlsyfunCAvoK9twB7VTKwhlec+Id6o0twLHFY8oyqdk1j97e8Z6G/NJq+3jb/3/sQ6IsYSP7mlZ+6ADCx5pln/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FGDGvADx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B8n7tR024242;
	Fri, 11 Apr 2025 08:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=u8yMp
	6z+MsD5dsddK1XVCTu/FW2y8RB5gjKnxo8n8pc=; b=FGDGvADxK2Uk+z2ZHcOa0
	E9Lb8tkTt9ssgG6ipF6DmEG4UeIlxpSgUtFgipkryhfIH5PiyhkO9kKHrBl4gIUI
	/vhn0jGH+pPoXO2MYnmWDzuMhnB4LhOYErt5G4il7qibnu+jg0nnP/Szn/U3ePsZ
	QRjnRZxMmGoSvw951L9k3K/gW25CB1fndU9hvnHAk80Q5dBAWfB6KZ/IOfhHg9vw
	otslHHZyHL0lU7Jve+3fggNZn+y9vhv4Dw8r1KAwo6YsiogXcq7mUGFp/5oQXmbf
	5Pn7J1psqHPcw9NbN9rUPEV2Xg6yMKu6ZNSMgbl+eEYkswELVO8iuwbwuJRM54JA
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45txc6kqga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BCalqq001271
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:47 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPT006015;
	Fri, 11 Apr 2025 08:36:43 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 09/13] iio: adc: adi-axi-adc: add self sync support
Date: Fri, 11 Apr 2025 15:36:23 +0300
Message-ID: <20250411123627.6114-10-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: eTHmCTepLDxtQ1CdewWLwLw8EJ8RIm0m
X-Proofpoint-ORIG-GUID: eTHmCTepLDxtQ1CdewWLwLw8EJ8RIm0m
X-Authority-Analysis: v=2.4 cv=KePSsRYD c=1 sm=1 tr=0 ts=67f90ce1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=dZsyohivTPeKK4liGEAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add support for data capture synchronization through CNV signal or
bit-slip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4625acc313c4..017685854895 100644
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
 	.data_alignment_enable = axi_adc_ad408x_bitslip_enable,
 	.data_alignment_disable = axi_adc_ad408x_bitslip_disable,
+	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
+	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


