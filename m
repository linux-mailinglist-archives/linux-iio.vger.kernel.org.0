Return-Path: <linux-iio+bounces-17939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01FA85D55
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 14:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A5A1BA639B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7492D3A8A;
	Fri, 11 Apr 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xlJT3e7W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EED2C3761;
	Fri, 11 Apr 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375016; cv=none; b=uPMJQ7USxeubxkss1N7QkUnELJu2LpO2N93Tp1SG7EVGWVMh2JTMNRvaeUaUBVv2tyu2ytvZOkDj3/+oaweFHKoCDIqScbDCEiSCEOMaqWpxCp/TvjmutFMEPbGzMkLc9wINCpWX6X8zYG+7aQPN+O4GW+24/htzIKzgi2dZAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375016; c=relaxed/simple;
	bh=BNrdMPj2SJcSbGHpeWM5ZD9h+bN8EmfOxH3DxN/+d9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/FFbHG/dzAZzViBKfRoQaSQGLHgHS8ZMzBYSxWfRUFXqf55y3FWDn9GBxGlUNtfCmvTHxc81sNLWfJQCnRSTHajbA1ewjK3ruaIX0kWr2TbMOwdvKYKOZTKoZScN8RqBdl28hBVfkD5lT4zL7djn7qoCeVZpVzwJZQt9mhpgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xlJT3e7W; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BA9YXi001831;
	Fri, 11 Apr 2025 08:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HeKGu
	pMs16K2OK2pa8A5WH2o9VgWgFEKlkm/zz8iHn8=; b=xlJT3e7WW7PD1F/f7Ph6r
	+3B/WGCZVphYKl/syNyzD8T+q7SA1/glucgYKlDazLB8ttkPZi8cX2Jr8IKdNAZm
	iH5lFL4ugUhRtkAMVKvsqVF6p3G/I+DqqhKmclaE6OtGvMeoDM/caNDa/zNq7i4r
	DM5D6AvO+oC/MijELrbjR4BJTQxRhgd+pSfCNVbcOwfkrDukNJS0k9qmAKuiFUe4
	sdmpq93O4bST6Lb7uRYZ9b5Mm+8354CAchYCXdA71pHFFNq3OU1KsyXAPuQT+UNo
	U4fqmsMKP3rSNDlSlbto0drZKtMHwu8IyPj8VcDr5bHQKse9l5trvuHoeqIzJPcG
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45x8yp0bs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 08:36:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53BCamld001280
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:48 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 11 Apr 2025 08:36:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 11 Apr 2025 08:36:48 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53BCaTPU006015;
	Fri, 11 Apr 2025 08:36:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 10/13] iio: adc: adi-axi-adc: add sync status
Date: Fri, 11 Apr 2025 15:36:24 +0300
Message-ID: <20250411123627.6114-11-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: rqaAIhABYoiJuiscF3JX6liPgrcfICEs
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=67f90ce1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=E9bf82uvLnFifWyeAaAA:9
X-Proofpoint-GUID: rqaAIhABYoiJuiscF3JX6liPgrcfICEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110080

Add support for checking the ADC sync status.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2.
 drivers/iio/adc/adi-axi-adc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 017685854895..0d12c0121bbc 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -56,6 +56,9 @@
 #define   AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK	BIT(1)
 #define   AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
 
+#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
+#define   ADI_AXI_ADC_SYNC			BIT(0)
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -453,6 +456,21 @@ static int axi_adc_ad408x_self_sync_disable(struct iio_backend *back)
 				 AXI_AD408X_CNTRL_3_SELF_SYNC_EN_MSK);
 }
 
+static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS, &val);
+	if (ret)
+		return ret;
+
+	*sync_en = (bool)FIELD_GET(ADI_AXI_ADC_SYNC, val);
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -600,6 +618,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
@@ -647,6 +666,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_alignment_disable = axi_adc_ad408x_bitslip_disable,
 	.self_sync_enable = axi_adc_ad408x_self_sync_enable,
 	.self_sync_disable = axi_adc_ad408x_self_sync_disable,
+	.sync_status_get = axi_adc_sync_status_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


