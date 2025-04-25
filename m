Return-Path: <linux-iio+bounces-18635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D7A9C780
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2DB4E21BD
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427A24BBFF;
	Fri, 25 Apr 2025 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sG6rp7fo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF22417C5;
	Fri, 25 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580368; cv=none; b=l98acWK03OyeTSH0V1NAbzyqoLoj1dP/pZ578sOrzjDW7loPiPu0pvZ/l0zcy2Ss/4m5L2mEC7qVZwow3qbjfdmWeVQxwh2OjpbydlZ1+mnJAdjOGXlYAVB0Dxh6+i4xKuqz6IFuJtTMwf5EPrO2F0o97PF0MBuTkDfwfoSEsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580368; c=relaxed/simple;
	bh=16U6K1ZaW9fJBAKa6h+jzo9hCrNCS2YDK4RdtwilTYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLUx0k5OoRUoDqlHt+dgRHFQy/WiJrtRO0KXtsuRonPhgmoAi6JCcJ0eyidZIFoIz2x4Hykn04dLRZWSkWZZRBXAZ/rmYsgjXv6UIA1DIes8zxi0E34P/vfn6gD1vpa/sNz1jqgQbZRv1GR0hv8hPJetpj3nAvEe0VBXjQs5IGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sG6rp7fo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8aMOp016633;
	Fri, 25 Apr 2025 07:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FxTA4
	YN+qbGAZaVvp2OH98a+j0pSVAjr6TUg3qJra5Y=; b=sG6rp7foNTd6UFGEweMV3
	bltG96gTewBYr5v6OBslZwkH28p1vJrdEpKN9UteZjYYFzRnFDcR81SQrtHc0TIy
	aRpPnNiKRE1IglGCWIbH6b/Fg/HOMJDcEJepykXDAeb7WCUebswcNtKEpHtQVuLY
	30/fJh9CNB+1y0aHXnwUCxP01pIS+USldIKoad0vc85UuunncxLYukCUAcZrpSVv
	mcbA9KHOF5zNse1vP5/GmIiWuMbT+WD3J/C0NaNsJ/acY4nfzR2vagUFnfDge4o3
	6ed+FEaPtx9kFHrNir41rAtpNFlenitLz6yGkdoTnc5I2vXsk9EGQzBeN2RFt5p6
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833j9qu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ30G049239
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Apr
 2025 07:26:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:03 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjc1003881;
	Fri, 25 Apr 2025 07:26:00 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 09/11] iio: adc: adi-axi-adc: add num lanes support
Date: Fri, 25 Apr 2025 14:25:36 +0300
Message-ID: <20250425112538.59792-10-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: L7rksMhKkZS5CsKRDtCW_PcxQaxHa3P3
X-Proofpoint-GUID: L7rksMhKkZS5CsKRDtCW_PcxQaxHa3P3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX1MgfqAW4Iy/e 1Bg8alAl/BLzMLE05IrqexF5HfoKgR9OdEjtDz9bJJkOgS2mH3m4s7HdyDgSbigb95gJW51srse AjwZBhuU0DoT7IEY2yv72heNdIYOx5drwYlg0o+0mbZ5LRLSZ1iFmaDpVwKmNnAhQOXaPI9kUST
 LX02I+OaXzu099MM5xXSX/CsUomLCm2UI8/XLKiOXrGlMRgbMwJPSBwb+UN8LXsLhAPU3k2+a3p /xpFiQlnQjjYwbHCbwmImer1rWwcKvzLjBkIcXauK0fum1lpWL5FA5v4tBCnlAnT9UuAbSNQWsz AEeN2l0W8nEV/M19AhdFhSo5hPNBoUKnELW/W26unqdVF2KRyYokBnUin3XYFOq2seBCjhCCZpY
 XQkChpKa4ZSuLY/8qSJGwQydeJCbICbhL8GIqwZOkOIcsi4HB4eHcB3i77kKrrVDOBkfDPTX
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b714c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=XZtg4_54fT2L5_ulfa8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add support for setting the number of lanes enabled.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/iio/adc/adi-axi-adc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index bf0155830d87..8ff781ab5ec3 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -44,6 +44,7 @@
 #define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
 
 #define ADI_AXI_ADC_REG_CTRL			0x0044
+#define    AXI_AD408X_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
 #define    AXI_AD408X_CTRL_SYNC_MSK		BIT(3)
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -451,6 +452,19 @@ static int axi_adc_sync_status_get(struct iio_backend *back, bool *sync_en)
 	return 0;
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
+				  AXI_AD408X_CTRL_NUM_LANES_MSK,
+				  FIELD_PREP(AXI_AD408X_CTRL_NUM_LANES_MSK, num_lanes));
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -601,6 +615,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.sync_status_get = axi_adc_sync_status_get,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
@@ -646,6 +661,7 @@ static const struct iio_backend_ops adi_ad408x_ops = {
 	.data_alignment_enable = axi_adc_sync_enable,
 	.data_alignment_disable = axi_adc_sync_disable,
 	.sync_status_get = axi_adc_sync_status_get,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.49.0


