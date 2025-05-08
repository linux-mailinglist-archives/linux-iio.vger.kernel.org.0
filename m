Return-Path: <linux-iio+bounces-19294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B69EAAFA06
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CF898140F
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C0C225788;
	Thu,  8 May 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vee09aI4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22C223DDA;
	Thu,  8 May 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746707544; cv=none; b=dZ776NEqoITzKtW5dcRqD8Jaz4fMi8dRe0vVRgCCtrCguTHXf7pwn2DFyTbWTC5H/DpIwFuRn6FZrlqLEBcSHI4i1t/YO4X6whbePWmOssRD2Zb3Nq9LkK5+W4/Pn5OFQTbSPLwauOSbESkII73iPpRAUULlhHCfmKOtSdUNj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746707544; c=relaxed/simple;
	bh=40ebb2cwjTLIp3Z7qvZGDycv+JCJe/VeSQoUx+s43Ik=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aS15D3GGrB/BzoxgTz7zqR/S4zayTmLN9bMisiO0O5q2u6kP6QzaDtC5zQDVw/A0Y/TROu7lEl70W/+fqzuw5zyem1OHY8joisL2GuXh1pVfgwJ5xntZ7ZI1bUc6PWkKC+wDDuekwUZx4xwuW8teJYLlFdbYQijjMvJefgLehW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vee09aI4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5489Dt1S013492;
	Thu, 8 May 2025 08:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+vGCE
	Mfc5ckM0R57MNBPDhXEB/R+W3cwClciV1LPL98=; b=vee09aI41vAWwMPyaPNEH
	Q3wMH9cPxwO/4Qd6sPZF6cLGou8y8E6TvPxHmZ+8XjjkJjg2+6pYaO7A0aYm9D06
	L/QVx5VnOELFTnqLYLvI182WYqwPTcBSg3IIkLEOPv1gnRV0FTD9Vaq5v1++ruI5
	W2gn3J02K9M5Zfch69x+O0A24nzYoiJdj/6UxQrgOUmUE6QB17Su3Zky/Q0bUUN4
	ml3T//5HflzEDc/1Fvp2utw8A75LlM8XOGqbGDghu9IKyw3osckvnincyeTrPjtm
	lS5tlikL1WvNlMYiS1f43jNSj1dCEME6ohkiQ1AH8rZu4GMhRn2ATES3iAn+1Q+z
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46gpct1uk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:32:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548CVxxm006292
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 08:31:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 08:31:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 08:31:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 08:31:59 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548CVFte002317;
	Thu, 8 May 2025 08:31:50 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Ioan Daniel
	<pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] iio: adc: adi-axi-adc: add set decimation rate
Date: Thu, 8 May 2025 15:30:55 +0300
Message-ID: <20250508123107.3797042-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=J/eq7BnS c=1 sm=1 tr=0 ts=681ca440 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=YaUefwTmmUCeskgydjwA:9
X-Proofpoint-GUID: MzianQqEkvlnyWGtlXxWFvD7Vx-Lb3F9
X-Proofpoint-ORIG-GUID: MzianQqEkvlnyWGtlXxWFvD7Vx-Lb3F9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMyBTYWx0ZWRfX7gQQeh/Akjzw
 U0BWlv+dyAz+HBFg7SHX5Uz6jdfL2hIPz7I1lG4/Np30KDE72kjjz2LZGtsO/QIdVVvMnOUeV87
 nSvW6UEm2tnrZU/ZMRDL8A6M+ZquMOocv0H0Shujutlmwoog+XTzmVTowipUVlcwAXv1Bqjy9Be
 mSz+cAYDyUyspgGks2SnEIbl9c6ftNSEBThEpjK3PdTcF0WdAOrxdlU7qMTEhP+CGsnK6WouDzv
 EikxF3MWz00bhYJS7BBrbTngouBRuCXg+myZULebg6UJbvPHrF6d+pZgANtyz0LU9phB7JDhE2L
 lZqHlD3SYDAFy9iIkD3d+BW8SozIrKpBi0sZ6dbrhZ2ucl2i469ceDy5VFe/YnR2TWwUgqjCakl
 lBg6Et/SJdg8uDO+iCLUnSyUuHkhD71pnHDaCvSXxRTTfLQ4/M8ufZhUgpPfR7Eokrp6cZO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080103

Add support for setting decimation rate.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v2:
 - update ADI_AXI_ADC_REG_CHAN_USR_CTRL_2 register in a per-channel register
 - rename ADI_AXI_ADC_DEC_RATE_MASK in
   ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK
 - add channel index parameter to keep axi_adc_set_dec_rate generic
 - remove ad7405 chip-specific struct
 drivers/iio/adc/adi-axi-adc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9e8c30230791..33eb8f337e0b 100644
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
@@ -242,6 +245,17 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_set_dec_rate(struct iio_backend *back, unsigned int chan,
+				unsigned int rate)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_update_bits(st->regmap,
+				  ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(chan),
+				  ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
+				  FIELD_PREP(ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK, rate));
+}
+
 static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
 				    unsigned int *status)
 {
@@ -550,6 +564,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_set_dec_rate,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.34.1


