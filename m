Return-Path: <linux-iio+bounces-18633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B5A9C782
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3911B8304A
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 11:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641C2475E8;
	Fri, 25 Apr 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WR84TC5c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75220242D89;
	Fri, 25 Apr 2025 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580366; cv=none; b=qPskldooQ1xLHyJBxBWcvqAT7YDxgDkoNEPtAxhSzHC7czoybGvgvY2aZDPpj4/7b+U1ghYv9/7Cv9u1ouLiARvUhMbAFwj85O63+S90yfDczBCYhBStF+WkZpoznvpnTtgnkTlf9xzHY4NaodHRW14mWWa4F6FmDkbHHDuXmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580366; c=relaxed/simple;
	bh=gXzxQWyGZ6b0yLCCWpoFf0SG6RO6KNn0zLqSOnXFLgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTM3n0Dub1XYpMdIbDlzZ09il2q/qYBGt7pc1wTzaWAruKnFro0hG1pQroHoOEJ5boGD/SNRt+AQFI/QXxNTZB7mfEQwGbHzH6eSq+1hijcfPfgxuGApgAYNYXpAsa1S4E8IEqDkCPC82QHtWEwWTgy1Up36nKxt38TirBwiOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WR84TC5c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8nTru016645;
	Fri, 25 Apr 2025 07:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iSvgE
	F9S7Tx5uJzr/Yh3Dv0JZMAbJQCAV0DbeVyswgk=; b=WR84TC5c1RRvFFhsuLOtA
	MJU70Vhj1k83C3YY65TjcLOve3dub8IxdfIygPDM9El51jhK1Med7rbDAcmchyEZ
	qAXM7P6ZXzoR8IQU7mBJ/3AaF79m+XjgRdOepKQyg/LofTQWQvK6kS3m3YkOFeut
	Z5djN1iVwGyK3g9e9P00zFyqu5YfFDMuK/kkAdj4G6evRsf5w1+HC/eGWHgAvlbp
	118Th+4WoF85s8pY+KFiOafoG/cpkKLWOo8XUcJwVql5GunzKyRl4n97AS4SGAHx
	SKGAmc+tKw68gW+2u0WvoVJfwpcCsOwWF4duZbfGzjwjpLvR0gTXPAFL5eTmqumU
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46833j9qtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 07:26:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53PBQ05g049230
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 07:26:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Apr 2025 07:26:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Apr 2025 07:26:00 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53PBPjbw003881;
	Fri, 25 Apr 2025 07:25:56 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 06/11] iio: adc: adi-axi-adc: add filter type config
Date: Fri, 25 Apr 2025 14:25:33 +0300
Message-ID: <20250425112538.59792-7-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: RPPal2fQjoZURf6sLUi0M8f1h8P1oQvf
X-Proofpoint-GUID: RPPal2fQjoZURf6sLUi0M8f1h8P1oQvf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MiBTYWx0ZWRfX0FYfzkaqEiTx TE0mqy0de0826D5zb4YavOwV1MlpQx1CFo7H8M67rYZ3kR0cv9K76CUt/Xovbo5RFgkKA8yPXdL bXvgzm5h7DuBGJaNZYGZMU4NEPSID0E/LPNGtrD8+SFndY5lK5sVjx7vahjm+DhNky5GBX1nktn
 DoArNieSD2chl9RYrKz4IdtFUZB/M86KRZouDIWY8qvd+KZ/NiTYN+sc5TRA97o4VWSR5bwM8+n g/Ctztn9C9mEvgT0kbo1XmAdOQoDhPlh6mLve8Oqw3i9ZTM7T/ycps0GEUP8qyVDb3tw3MbkGaP mIAkhhnzOM3ZejDwl1cHqmU2pLPfDFe+2OkkhGY0Uh2CIVUk3GCl5QeNHHL9/9ssc0iiynWLwag
 KjpMJI4GrN/76F1RCRAJlq7ZWMuAlq6rjFly0Wl2PfxbZcIOjW+sK7LJrw46nh6WE5F7Vb5l
X-Authority-Analysis: v=2.4 cv=Hu52G1TS c=1 sm=1 tr=0 ts=680b7149 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=tS2dMKavNNEhNzk4wysA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250082

Add support for enabling/disabling filter based on the filter type
provided.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - update the function to adapt to the backend interface.
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


