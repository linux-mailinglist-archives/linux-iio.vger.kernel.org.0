Return-Path: <linux-iio+bounces-19674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47CABC02E
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134BA18942FA
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C82283FEC;
	Mon, 19 May 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H1ABcHz7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2935281528;
	Mon, 19 May 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663436; cv=none; b=pVDi6OAxocKjme53TkIsReYg/oi2Od7y8p3G4p4slf/lswuT0vRWYkLm79Tu/c7us93mndCNAgg/K+vCMFikoAosn2RsHZGgTQaroD1S7INW1dsbfppm6qJq3lNYrkoWOXWrWukGqCFQYNCml5jCMiwuh+uRSHhKafnhQCbVlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663436; c=relaxed/simple;
	bh=KqkzW6cqz8xSa8LPY0v6j3huAaayPsLu/UdoBTxeTck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Oo0ODZS+WcFTqNh17ZVSYujUbfq6DJqe2wkiKhOXmpHU69hEqD7HJKSTatInXxhPMrg3G9KyhGsrh8QEqC4BVNEvmqlPfyDpQ5qneZYHdBUPnJ+yi7UA64TAi3aWbNASyh4Q7KEbZmAd/1vcViRWr01xcX29fHUIlCepZ5YD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H1ABcHz7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JCtsfx024158;
	Mon, 19 May 2025 10:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5ogTO
	glL2BFdN1jliJVncAuZvZAaBGr3wLkh3Tqhj38=; b=H1ABcHz7vpA6i5U2WoWQ1
	33+8lVNLhI6DlQo33KtCxZpi6skJeHkEuabdsSH3YMRLXB6Vzj81JsKtldXM4Ag/
	dV0I9Hfiq5w5U3Ah7YyAaph7ehn75o8V8PWIgN0UlRBwplBr1DoaeEHHqjf2Lq/R
	S37KZbgym+oy3OIZnsqQXWU2rfx+Hvx3IGHzV95+nBz85us9g5mamyNmY3u4Qz6Q
	Kcv3Zd7U/YpDDtZ2k9puu9YPz4KTjBwTMxqBS7AaIdG4emajzyt3D9TGml3JZuhQ
	TP7HStbNKhjO0F4Y7RWBzs835yJTcfVe1zkrcKEDM5IXwIr+VTukUH4YvQ4Ze2hu
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46q8sfwjgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 10:03:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 54JE3QQ5026740
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 May 2025 10:03:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 19 May
 2025 10:03:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 19 May 2025 10:03:26 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54JE2bPF016713;
	Mon, 19 May 2025 10:03:18 -0400
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
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/6] iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
Date: Mon, 19 May 2025 17:02:11 +0300
Message-ID: <20250519140220.81489-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=FusF/3rq c=1 sm=1 tr=0 ts=682b3a2f cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=YaUefwTmmUCeskgydjwA:9
X-Proofpoint-GUID: Qs9-DXtPanMXE-yryPnOOGMZu-xKFZdU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfX1wgQFuSHSFvS
 wjTdwnb6wl+Wm8SqOut8sZsexQGZN8YYrLLSho9Y4Pb++LsEEyQ7EkVoPztHPvA+Oj+buOB9ijk
 BufvGcHmBhnTwOywpfXIyXJUKGcJ1xh1OixQZka3poAvp77eizeG+UWtt0v6j9xDJ9ivUJWT0ek
 Lso0nBfizhs92aj5FKPrKEQMPXln54f/a86t+TqH82ftyrj1O754QZwkMKQS0jNlIIa8w+zRLc2
 p97KHBmZoa97lzyiCkRJIDWC86/8ARGM5sculcWom9fmkpjd6zODpORWNgKTgcLUdDidH760h+0
 g3+l9+p9Uni1zwnw0C8m3HWnIlVQquehWox2ZzyNJYzRrpwvgBBpWA4Hu2G915TBrP5s+qF0Z4S
 QcEK3khqnlGmnnUktWn2n9gs/3DTjudqya+8IYi1k1hZWLvdkgrsoZRMNut680bMbTtCfEDS
X-Proofpoint-ORIG-GUID: Qs9-DXtPanMXE-yryPnOOGMZu-xKFZdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190130

Add support for setting decimation rate.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v4.
 drivers/iio/adc/adi-axi-adc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4116c44197b8..0b8673668745 100644
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
@@ -381,7 +397,8 @@ static int axi_adc_ad485x_data_size_set(struct iio_backend *back,
 }
 
 static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
-					  unsigned int ratio)
+						 unsigned int chan,
+						 unsigned int ratio)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
@@ -549,6 +566,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.34.1


