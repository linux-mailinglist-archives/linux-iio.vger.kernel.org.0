Return-Path: <linux-iio+bounces-25325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A18BF5E8C
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 12:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BFE198314E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519232E6B4;
	Tue, 21 Oct 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KRvhEBsu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0E432C33E;
	Tue, 21 Oct 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044060; cv=none; b=jWOBwpar3RoBmn31QwDg11zR7J3ycK9GkFRy0S94X3IncA6i2ZP7DjP3FMoFL0YoJv7WexmfTWesgPjlvZsdwiciIywvKdF9gtWEsNrcczubbG7CP0hYNgCC0Zhl13BBA+egprqeBjyXY8KK5K3mO0+rShcT1WpQakxmHnAdoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044060; c=relaxed/simple;
	bh=Lt93E/m4s7d94UUOaMPx4cYfRzKdGJFDqDMb8Sur5LQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj2MixzyJLaR2Ky0Pb+MB7VYEREltw0USJ/oP4QjOyPxS084boQrR223PbapnKwt3QREqFvqobjyvo+F9LgM2dVt0b+pSGPt3BwCo7zrUMdgP9ZrPVBPOE8sbk+h8UsOkze6g1KeGmpXZ9ghgXYeIKUQEYiYgybUr6jVSV8vsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KRvhEBsu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8A2su019086;
	Tue, 21 Oct 2025 06:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tC/Tt
	27yJG+VmNqOjpo8JeBkHwh4eGqkfkchgarSJ7U=; b=KRvhEBsuG0qb3C1aqazL+
	lZl9DiTqxlAVstnewthZb0I7wwTXGHpMpVbJn++tYvrpfydt6oKfd+Sbok83T9Cz
	PVIBRQMk0PSDRnWktK7APXjDEHAGJEnAsiXvfEkrkYLOjnKDyepCAIy1j6/AiMom
	qLPnRN8nMg5ooklxa5QER+Pdq+42a5djXa3U/2+89ngnOj12fU87UDYCiHI1LWqc
	TGeX7HNZ12Yj58f2fcREhCx5BZ2wjZ2Hoy6k6Y5pxqf9YYKr4Y1/uJfFGMvn7dXT
	dpbTtyp3/uRpcyNOO2MkD2AbEvc5ALtvVgp21req1m0cWniUgRFMxNKRApRrVQrB
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49v4r4qjyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 06:54:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59LAsGeU051724
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Oct 2025 06:54:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Oct
 2025 06:54:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Oct 2025 06:54:16 -0400
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59LAs1Km002507;
	Tue, 21 Oct 2025 06:54:10 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 4/6] iio: adc: ad4080: add support for AD4086
Date: Tue, 21 Oct 2025 10:53:46 +0000
Message-ID: <20251021105349.21145-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yAEz37dQO0HBBRK8npnr8CZYyTvTnKOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzNSBTYWx0ZWRfX8n49KqNuo5Ru
 Jgr4wGe2M4VVG5XzJhefA/S7VPR7cucDDD6S4r849UPVazPRI57f7wmzRnkslK1QykK3ZRxeN1o
 /GONxgI2eorkgeg2+boU9Gg+FoWEc1j2+i4ekrbCw6ue5bOn92orJqP7Qjr3T7+gb1FBCMqAM5W
 rwm/sqwu/4VJUoJDw3JC6ODK0M/2RfuTf7eG3UFgtcJ6FtfRDlAPyA/I/f/h/cWC7B8iK61BQZW
 TBbvKGXSgLmhWuv2c+JIkKBHt+xCEwlhrQyBQtJLcnDu9hU6bFNokVhwUh6eWM+ZA5Ulpl/wfLt
 9mfOfHXfRdDZ4ayUnLQFMbbdKiZkfVpzEQcQiiGgnnpsmLI/eNh58CJOjMRXm6pph48sPwjF1sT
 5f4XU7Xkozpl8RmhCfOYjX4JnC0dHg==
X-Authority-Analysis: v=2.4 cv=KKtXzVFo c=1 sm=1 tr=0 ts=68f76659 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=k4GWfuzuceEyQr0MdMoA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: yAEz37dQO0HBBRK8npnr8CZYyTvTnKOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180035

Add support for AD4086 14-bit SAR ADC. The AD4086 differs from
AD4080 in resolution (14-bit vs 20-bit) and LVDS CNV clock count
maximum (4 vs 7).

Changes:
- Add AD4086_CHIP_ID definition (0x0056)
- Create ad4086_channel with 14-bit resolution and 16-bit storage
- Add ad4086_chip_info with lvds_cnv_clk_cnt_max = 4
- Register AD4086 in device ID and OF match tables

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index e2cdca2e9174..d6d0688adc3d 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -129,6 +129,7 @@
 #define AD4081_CHIP_ID						0x0051
 #define AD4083_CHIP_ID						0x0053
 #define AD4084_CHIP_ID						0x0054
+#define AD4086_CHIP_ID						0x0056
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -444,6 +445,8 @@ static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16)
 
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
+static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -484,6 +487,16 @@ static const struct ad4080_chip_info ad4084_chip_info = {
 	.lvds_cnv_clk_cnt_max = 2,
 };
 
+static const struct ad4080_chip_info ad4086_chip_info = {
+	.name = "ad4086",
+	.product_id = AD4086_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4086_channel,
+	.lvds_cnv_clk_cnt_max = 4,
+};
+
 static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
@@ -642,6 +655,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
 	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
+	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -651,6 +665,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4081", &ad4081_chip_info },
 	{ .compatible = "adi,ad4083", &ad4083_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
+	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0


