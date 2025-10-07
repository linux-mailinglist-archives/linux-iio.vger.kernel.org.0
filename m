Return-Path: <linux-iio+bounces-24821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C33BC120B
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC53C7EB7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33892DC797;
	Tue,  7 Oct 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0+1m3dd0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD392DC353;
	Tue,  7 Oct 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835772; cv=none; b=kzlXEEMNocWwvVmDh/f6K398xY0qvHHRrmJHXnJT3EDKZT1KLLorO7jfkHhEG1dIe/muf/XHSpLlHkJMNb3VZD4kLrc+eAdu+azop/AsQ8/K37wL6PWKijBrCmRQZ9yqhnzdFSjL+tjeiL0KBFmzHf5+a7GQrG3+cA2PTXyFp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835772; c=relaxed/simple;
	bh=4BPRVIybPN0FhEsNBKBqsBzqNrv5vT4vefr34WGVwiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRIUhlO/MXdAKmc3deqUocGEJ64NOub3oEWtyVC3/LqWj5rJOyYhEqzXYn6GcDWK2jIjmNA6w5UQNxJMIqDfQwJLqH0s4y8/OCoww0wH7CrOgvrEbKHEWiq0bOJ6HgmX6b8j3dxEOg8QDe4DypLlAJlzhZqNv23kJeJ/wQwCex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0+1m3dd0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5978cxX3006425;
	Tue, 7 Oct 2025 07:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pdmPQ
	Tc0qANVndu/pYEtKyYCa5kJu3YGFw3O32Hr9IE=; b=0+1m3dd0bfdONJYzAaFiC
	XWVJ2q4XefYsf22nNT7JSKkNZqJEldY/SCLTGrqqQNGhZp7U42n1MfwTSX0W2a3n
	PjfsqfkKbPO7RdAug+5KWVSZU3M4TVqckSVNMJO0Ro3/nDje0l7VQtJIr47RdVg+
	s1Qv8B12C277IkETd8dNXIKZjgROnlVqCgvOivyuvJjPCOiVpIHDOmF7N/7n7VOB
	vd/Q7k8Czu6E9Mzo4lneX3z5a4NaZ7cep+UmfxLWDvVXHOO53gvBZi1r8WdAk53g
	7qwzz0wMQeSES4tlsFHFRpVKpP4BhzukLmYTCJz6cLUoxny4A2WDqMeTpFEVYh6t
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49myhq8qfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:16:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BG7LS058233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:16:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 7 Oct
 2025 07:16:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:16:07 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftX006224;
	Tue, 7 Oct 2025 07:15:59 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>
Subject: [PATCH v3 6/6] iio: adc: ad4080: add support for AD4081
Date: Tue, 7 Oct 2025 11:15:25 +0000
Message-ID: <20251007111525.25711-7-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA2OCBTYWx0ZWRfXzg2gSRDUbcTK
 ge7FGYkeHjfFqBGetRBMalM6q8rTY7432jCPdy87+qE+4lYY6L1kfuhjwW54m9hQPXcyeLeyYSC
 gsvCdClZFgyNV+39TXF1CzEKNnZYBaPjrhra5xbq22F5kGXpcxnBS0FoBSdObzASSAKzb8nY7x4
 HjbLG/Z1kn43A/f6vzaW2yK2S1v/74NVMRnLX55paq4hK22iWv6mRE+vDo8v73XPxWnNeqRYQ1c
 u5XP90ZsZk8hMTb5OYANi/6oyBw1/v9TItDFkwYyejMxkd/xbsID3YJ1aM5FcYq2LUH7SYy5oao
 r8O3uO0D2FdCeILHbpcsCgzd045POQuCS1T6B69ZacGxaTEyQHboa/SPjapLnVmXxwh3hXWQwTW
 6ClN63IuURuYcD6cj+pFTuKAFDAtNw==
X-Authority-Analysis: v=2.4 cv=IdOKmGqa c=1 sm=1 tr=0 ts=68e4f678 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=YQQmArLDnSoWccgIpQ4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WnKXJ_rrwa5jc3G4sJdSzSR0dWkQLvwp
X-Proofpoint-ORIG-GUID: WnKXJ_rrwa5jc3G4sJdSzSR0dWkQLvwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070068

Add support for AD4081 20-bit SAR ADC. The AD4081 has the same
resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
maximum (2 vs 7).

Changes:
- Add AD4081_CHIP_ID definition (0x0051)
- Create ad4081_channel with 20-bit resolution and 32-bit storage
- Add ad4081_chip_info with lvds_cnv_clk_cnt_max = 2
- Register AD4081 in device ID and OF match tables

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 740176e86657..6398106da335 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -126,6 +126,7 @@
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
 #define AD4080_CHIP_ID						0x0050
+#define AD4081_CHIP_ID						0x0051
 #define AD4084_CHIP_ID						0x0054
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
@@ -436,6 +437,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 
 static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
 
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
+
 static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
 
 static const struct ad4080_chip_info ad4080_chip_info = {
@@ -448,6 +451,16 @@ static const struct ad4080_chip_info ad4080_chip_info = {
 	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
 };
 
+static const struct ad4080_chip_info ad4081_chip_info = {
+	.name = "ad4081",
+	.product_id = AD4081_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 1,
+	.channels = &ad4081_channel,
+	.lvds_cnv_clk_cnt_max = 2,
+};
+
 static const struct ad4080_chip_info ad4084_chip_info = {
 	.name = "ad4084",
 	.product_id = AD4084_CHIP_ID,
@@ -612,6 +625,7 @@ static int ad4080_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad4080_id[] = {
 	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
+	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ }
 };
@@ -619,6 +633,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
 
 static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4080", &ad4080_chip_info },
+	{ .compatible = "adi,ad4081", &ad4081_chip_info },
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ }
 };
-- 
2.43.0


