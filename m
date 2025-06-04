Return-Path: <linux-iio+bounces-20207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46536ACDF41
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4717A9085
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9036B28FFD8;
	Wed,  4 Jun 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yIHik8Pg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14B28E610;
	Wed,  4 Jun 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044164; cv=none; b=Ip+hzlqhdnNPfZ04riZFIhHnelAWHial8iOtx8gEq6TJ91s3GMr1qVloNr0Qp+iuJ9zj+k32txXfrJLo5Hxvp6gW2Us5vCF5hbsXhwAsLmtU7yzD95UuHtDFnoYJF8yWYBdKF3EKUmpNb/JQvoRieI6TrOWd59RfepVR2sIwDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044164; c=relaxed/simple;
	bh=qyyWAcb4tyvZwqvXmqUt1NsxFCrKyOmrUp190XU3Fqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tATkRaTudpW2OuGivB1mdFrOSQC0b6NIl6bol9Dt1dVaGe4TYGy41OIm4aW2Q8c0pH6Ic93jzrkj/8I2fg5Q19Yfo37608iF5/usvr+pkdUgHjF9clzvXVQ0tqLLK6i+4tzS07FB6w6FP2FfbfUpWzlXHPFGNt+fFU2gaq/u25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yIHik8Pg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554BhisB028811;
	Wed, 4 Jun 2025 09:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6+4OQ
	Vr59kJNDqEMSIRD5EZr7b4y3gwa4a34o3K29e0=; b=yIHik8PgIy+YYZ2Se8XtK
	gsjadqrMiyKuhgz82Suc6KDcIDWibn5ddsq7w5vjexqLDIex3ol5OfLW2wAnf1Do
	kEZE3wUyBauxa8bMIbhIcJzf1m2bhvhwlYFaMcIvwviL9zmN5I2LHFezyx+csyAv
	xuQRxFa4p4/Y9mCQI+VB0ngnQkFT7AlslLzffaLo0bn9efMhCOQbImuaYQ5JK5h6
	0NovNVcFjt61VgHMisZrR+3GRUiiUTaveYFD/cdEzRjXHmu6ynJw+TcAG7IEeIOk
	rFqk8jfGdiQUOAj8emNULns/PdFhDBcTp5NPguW8bW4qXTNZRlo8iIwPufJeGgh4
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j2jjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:35:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 554DZO3v007772
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 09:35:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 09:35:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 09:35:24 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554DYVPZ029277;
	Wed, 4 Jun 2025 09:35:14 -0400
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
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Ioan Daniel
	<pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/5] iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
Date: Wed, 4 Jun 2025 16:34:05 +0300
Message-ID: <20250604133413.1528693-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: O5bmGVb8aBf7H_K9Vumlxzj83eh3gDm-
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=68404bac cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=hj20C08OGkFrgq5-ZMUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: O5bmGVb8aBf7H_K9Vumlxzj83eh3gDm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwNCBTYWx0ZWRfX2QKkoioE4HMf
 86tskbH3Fkry2CQxV2bdsasqOFCtwXvBpXNfmpuXUnS6GcrDz8yInqNSIQ0TRyLevSlCUbgPd51
 6fQwot0mSSVqAb+pc/qzdM1Dy2ZP92wd3T/yg/eBpR6N6OgYy/a6ngIJTnhPh11PERmKYygmN2R
 1gym7jHAGPp6uiFPkSawxR/u687Aym+xaWqt/Z2sOKJhA1svbFet2liUhyIHsdviNnZyivES70G
 2Xsl/cvZRytjnVRevr8ii5bbz/aF5vGX/beAEpLVtbDJWbFVTMciwuuLhOorc2VYX9av8RaLlpm
 bEL32+B/ttLarNAwnvrziJDSiihE8IkPyUskIUZ8APJCAHU0vDqPs0smsryLGVhtriuDlKIXg3w
 RWcVsLqn4abW6ldLrXGnkFGFaXZCm8YSPn3D2KySoPY+g1dIdRvgckVcI75L7zTXfhBEZ3hP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040104

Add support for setting decimation rate.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
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


