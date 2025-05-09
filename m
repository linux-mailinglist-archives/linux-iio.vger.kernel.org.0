Return-Path: <linux-iio+bounces-19367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A8AB1128
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40E14C79C2
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E3290083;
	Fri,  9 May 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ffNZxeCn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4628FFCB;
	Fri,  9 May 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787843; cv=none; b=nrvDshsVVLWj92YSuQZ1oUJwsfgokdfigQ4x3iMtrYPR/Yc6KkWruNdCYc+wK29+u3iUTJ8yl6lDF8JVztCKksaVL5zcraQs7XQi54VgKhED1B6jSpX9DEyl4OAIrx0we+rrlv3aD/MQGPr5aMKUJBhinTEuB07kt4T+kB/Ho1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787843; c=relaxed/simple;
	bh=iRd9PMwathJVL09WkcWcEIQDgiwTZOu9wa5/ggNNDJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViS+knA0wL4vTY9kRSRoWd6KNFtRTLwFqVqV521+05TqEU1MxQcBjmise6rTlylSGpEfqmnN2ey38aj3De3I1Xues14PZRbxDJNEnKIdnm9gmkN4Yn3vuA30yH1kBgIReOFNGXZeVikhGUEpDM2K91QsFDGtarLY3/6oMJkqhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ffNZxeCn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499mv6i007808;
	Fri, 9 May 2025 06:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+NrYh
	6yVyilITFkUrCOS4635djrrnzxtlv5kiZMUEEo=; b=ffNZxeCn5XhnpTwdJapUr
	yisTwP9YApMdvvi5qqrN/y/0odnDQ1oBvQiYPcpngujig/0XCeThaVdOhuFAwVDQ
	9DCxbeXom76XW/J1I18RedbkpDpn7PgWdfcrgYiAolE2MaNaPcx6iA9kBkCgo+oV
	afhSRWYILdYLGUlaBmIX33Z71m8+kLjE74wz19+9dDd6ZkhFE0qckMYwpmZjOKSU
	OwcLrOGQYOjz+liGw+8EFhY/LdUKYRs13yM/+A5zLgd2wjC9Yjt8DrBAbiL+/K7I
	4DoUrEQ25ThRlb/TB0Dy8wzwZ/CrRm+58MM8FQyJ4P2nfEHNSUSUFkgZFl1pPlID
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46hc2yh8vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:50:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 549AocZr049053
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 May 2025 06:50:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 May 2025
 06:50:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 May 2025 06:50:37 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.148])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 549AoK16014223;
	Fri, 9 May 2025 06:50:32 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 06/10] iio: adc: adi-axi-adc: add data align process
Date: Fri, 9 May 2025 13:50:15 +0300
Message-ID: <20250509105019.8887-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509105019.8887-1-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfX3oOj8Wkrquo7
 6mtTahm8Q4J4l66UD/OCxa+gIXddVlv7Oyz+wnKK+UZA1qSqUOocWNcuHeiKzSrP3ZkDU05rcDb
 5Z0yOL9B8M46aMMUKMGDTJUCogGLnzVOKxKPgfnPODVp4vR7/FOhnzVN5WZRO2guqxF9xX/ruyT
 k2aK8E5VTCMTHw4UqBa1ItwGFNdQlcFr1I8kku93fJ1mpnxp4wyw1mlG87mivEUiJm9Ve2HT84z
 L1zEJSEeh7W8kg8uAZ4/jXuiKDJLjUdgPVjIbnIS0wg4YsMyzUPHqlmjfRWFVLBULjywR2s1K5v
 xr53bgGSNaUKaWDKUm0V1idGNCAE8iz7ns9zS8RpUd7FMbvPHwDoVgnZ3IfcrK3sEbp4b87hK/T
 mJbNuxJCIQb9yoxqMz6M5RHYj/MIF0ThJ2SoCTF59PRRF4TVJHjwag0CQx5+LncHOD4gM9ck
X-Proofpoint-ORIG-GUID: Lv7wsLj8-kzX2FpqNKd7ozQZRMZyIII3
X-Authority-Analysis: v=2.4 cv=UJbdHDfy c=1 sm=1 tr=0 ts=681dddff cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=wxM4B6g2en942FlrxLsA:9
X-Proofpoint-GUID: Lv7wsLj8-kzX2FpqNKd7ozQZRMZyIII3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090103

Add support for starting the sync process used for data
capture alignment.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - use regmap_read_poll_timeout
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


