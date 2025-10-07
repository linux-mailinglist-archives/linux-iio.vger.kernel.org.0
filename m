Return-Path: <linux-iio+bounces-24818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D61BC11DD
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18DB3B1681
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC60F2D9782;
	Tue,  7 Oct 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VEf/5HP/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7FE2D9497;
	Tue,  7 Oct 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835767; cv=none; b=goroqxzlEoTRzl33G+pL6OPs+HC/2p9IMmJnZmTl1w4a4tysSkWuqA7LdZuK/Kc5eUXEpaeNDEDoKMJyIa9hB6MQMV69CuxFO3AwC/AySW1K1dBU2St48b9QVzE6C6HGP7JYK1Qxh3JIA1aP7+2vAwUiaQz2JKePS7c2itIGLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835767; c=relaxed/simple;
	bh=NdoXbW3w5CoPrO/WzF6G5DDhhncKUPPxcVyycEDOoag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3HjH/039ckb6wCvUVhPWX22cpbZ4yGkBpaPPtNFGJ8h7LHUVMKwcvT7bcXnHOhEBUGLa/ZID/1oAngfRTgjQ4od20SyTRyZXfjB3zh7SLi4KHtoPtpvmGc/3si1ZymeOhZR3k+EFflpydCNxKkxLU2eTGX4CFBqutpY197gmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VEf/5HP/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5979plpA010720;
	Tue, 7 Oct 2025 07:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RfwZE
	pDpLmpaYXkgieNnSh64amDOTmVaUeOyXE2UBGo=; b=VEf/5HP/926pDdk57+d0T
	s6cmgYadFGjho4QIaQoIl4vy5VD95HhubBVlCRXnrsCW7v5+C7vEMHrcw+rNLufe
	XufVheIawZbtSPsBvc3wojsfAI9Ci0naBrVQ9k2VsZBhcXD5qVV9fpZbrgOGjULA
	FykeCm5rkHXhZ1FtG/5DKEQVh6R7twj1RQ4Kq9aqW9Ub345NMk0QjusOwTze3G7U
	ZneMuDrgHS+1yuf/ifj3wwtQni30ZzntU7kUlPklS7KD+usBhfXGHKPQCsk445BW
	gv2jl4lVUXze30wiXgsNMTfuyDzIpfS9ktqmM7jLzeaUQ2CR4VhT+Bk8OzAmc0DH
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe1y7fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:16:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BG1h9058204
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:16:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:16:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:16:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:16:01 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftV006224;
	Tue, 7 Oct 2025 07:15:55 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v3 4/6] iio: adc: ad4080: add support for AD4084
Date: Tue, 7 Oct 2025 11:15:23 +0000
Message-ID: <20251007111525.25711-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007111525.25711-1-antoniu.miclaus@analog.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e4f672 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=ibccQJ5QWis0U0yrBgcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iRXpa_fLloHKmTNSb4jSHoCCh-ND4Bh5
X-Proofpoint-ORIG-GUID: iRXpa_fLloHKmTNSb4jSHoCCh-ND4Bh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX+odkweY/jJ5Y
 PugoyNWjzul6DzbZwH27c+HfaKe3l/6RPMdEdL+Md+r6y3V+KBO/vXxiRlvcs0l+HhIwvvr1afy
 0x8DT1CNLCkrRDU/81kMoShm9WbjVkO33dcqZP0wI5+534VhQffk7hjv10YS64J9lcqQ8E3+FhL
 m0cu4voqcCen8TDVAtjrhzdCoRRwCoLWdcySHvjiSketvjlHViJyapHiB7XKJ7S/Jm2TRXrG/mf
 Mn0nluw+gsrLN4aGeWSS4dgOURVVvikT9Zm+vuVSmausCE8xQETZByKcdxcOMnAUZzhFY8DBCJn
 m9TPKHNsEcLra+lgZcUBSVqTXYvvYKkT7Bj2tGg++sG1ShbM91TQ/u79NQPhnRCaMPD3pFcHA+E
 HpqnIOyiNj3AzfEfT7ZrCHdlsq4Frw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

Add support for AD4084 16-bit SAR ADC. The AD4084 differs from
AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4084_CHIP_ID definition (0x0054)
- Create ad4084_channel with 16-bit resolution and storage
- Add ad4084_chip_info with appropriate configuration
- Register AD4084 in device ID and OF match tables

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7231b93821cd..740176e86657 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
+#define AD4084_CHIP_ID						0x0054
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -435,6 +436,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 
 static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -445,6 +448,16 @@ static const struct ad4080_chip_info ad4080_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4084_chip_info = {
+	.name = "ad4084",
+	.product_id = AD4084_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4084_channel,
+	.lvds_cnv_clk_cnt_max = 2,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -599,12 +612,14 @@ static int ad4080_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
 
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0


