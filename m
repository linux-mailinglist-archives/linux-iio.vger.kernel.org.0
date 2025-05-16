Return-Path: <linux-iio+bounces-19592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87794AB9AAA
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6813B3AAE18
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE723717C;
	Fri, 16 May 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ggxS6rYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64DE236457;
	Fri, 16 May 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747393177; cv=none; b=pxOGaxJb6C39lwJp6Ume/bmmpsLl8Hs7sW7vn+qbfDEiQDgoQrfgDBtKMH1OlIiwoltZ2egOpqY6Gd6mVv58Ec2Dqosz2V3/Pmsq07/NCARz5DiuQI6OES3iwRqF1IvhxZFUGhBRlss24zd5KZsOiEhWASlUs0ZudITRMvepwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747393177; c=relaxed/simple;
	bh=3RlenhZGYIHgiDVKL+qnZWSFUVuEfrCQ5ijfKTjQA0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxqWvza/Q7aFVuWups5/UbQc1Il4tf6NT4vdjCp5ELceFXxHkAV6Zmr8BiYS3Y9/k/5jp/CMxWkhBp7nBchavTxugoMOSQqHrtsTtjTYSUUynhUo8i/xT/X2/O/HpVL+0k+Apdmd8hGsrz7LzToOcB8P7GprIKzmoB3f0jRF+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ggxS6rYe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GAATML010053;
	Fri, 16 May 2025 06:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ACLF9
	1C2Y72Z54/yLRk+5FNXWZ+Y82MsyQoA6tXtCZ4=; b=ggxS6rYelA5MaTmLqFnYX
	AjKTcTOv+dQcRPOBG1kQ2WHVIPuH4BFRg/ljXfTP5WpRmfTIOl6jwulr2V7kzwtS
	p4Bm+FEvDIFHzZT2y+y3lv0AZHkAsRVhSj6jZURSZsKHGncuP8QAEjHOhsfLvayj
	29baJcx2L7mwYlXiezXCF7388lHdmCFI1K70RC1UrxBUaEQ8z6lLxP1V8N7qJxE+
	Na5RXOZPQhjQiZAceWMRJaSZqpFTfJoRhqCIeyIFHOrnFy6qh+C4MiH7GEHwiL7n
	WecSI+cyfOrfSc9OwXlWTOM254I2sTIzIo3JMfpWJkdzXvO55uzbfevgmzcRzym3
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46p070s4r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 06:59:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54GAx9If050070
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 06:59:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 16 May
 2025 06:59:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 May 2025 06:59:08 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54GAwRHw006196;
	Fri, 16 May 2025 06:58:59 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
Date: Fri, 16 May 2025 13:58:02 +0300
Message-ID: <20250516105810.3028541-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: L8UXBkSJjOOhak6Mxu0yPnUtu6Iyj2QL
X-Proofpoint-GUID: L8UXBkSJjOOhak6Mxu0yPnUtu6Iyj2QL
X-Authority-Analysis: v=2.4 cv=A/9sP7WG c=1 sm=1 tr=0 ts=68271a7e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=hj20C08OGkFrgq5-ZMUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDEwNCBTYWx0ZWRfXxZf06yojoHdO
 Y8LbqY2VCor7h22mekxrrH958L5vJpEBETS39ti2NQ+obAtwNhUMbkSSkXz5VrdRpmSf2fqt1Nx
 wqhH86SED41fYoS3TKTuoV64D0sHBXEGLABr6ruhAyYLd6Y7b1ibJxEjIsHAmmFGj3lKrxSLtKr
 t2KGMEHr7WjVYe1UEP50icjiu0UVyIaMBeFodr3gVtgjHvthqFvrPwjXxbVRBY0lz813lPKAeBp
 8pP/tTqCF6IomyDokOwoUuDTFeOhHLn0ECn5SlkW33hDVsSYXWi9Jb7hSYKPZ0exOIrD9f6dLsB
 YYqwHA37SZAPkvgF81uux/M8tKnqv0YAw8Qdmk1UnMcTCVlns3smRfb1K1wm5HVpwl35yiDT8IY
 Ql/Zl2K2oxvpAqdrvJF1zGnyAOokDBm5x9D3ssOaAMdryPrzI2/goWlznFkdY7jigjDmueq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_04,2025-05-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160104

Add support for setting decimation rate.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9e8c30230791..0b8673668745 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -80,6 +80,9 @@
 #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
 
+#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(c)	(0x0424 + (c) * 0x40)
+#define   ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK		GENMASK(15, 0)
+
 /* IO Delays */
 #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
 #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
@@ -242,6 +245,19 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
+					  unsigned int chan,
+					  unsigned int rate)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_update_bits(st->regmap,
+				  ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(chan),
+				  ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
+				  FIELD_PREP(ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
+					     rate));
+}
+
 static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
 				    unsigned int *status)
 {
@@ -550,6 +566,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.34.1


