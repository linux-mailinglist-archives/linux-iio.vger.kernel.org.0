Return-Path: <linux-iio+bounces-17229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEBA6D705
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C016F72A
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A725D91A;
	Mon, 24 Mar 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j1quF8Qo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9325D8FE;
	Mon, 24 Mar 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807445; cv=none; b=iiqrdJDXLfMaUZvNj53h0RugqECJ9MzkR2KlUftNmGw1AAJ2VAfxLD3OuwrG2+MCg0CeEF17+prCg+5nZtT5QTNVAjmefsu8zh3Y0PvIIXM722gjsLvNdUlR1jckklfA1uOJJoswqC9zvXuCTvmY2Jx571WA+Mosz6oQwaDuPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807445; c=relaxed/simple;
	bh=xIj27Y7KtRteFLRWCMPuPG4fnslDopomKDgwbdfpbHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pr8oGNje+ZOjSQ8MW2WWNYv6bvBRx4nMav9y1OJP/jTlyK4YygkZ+MPwcnsd5G46AMj9iz0z/Wy3dGhgk5Saynk7Msp/g3SnMQSXNoTfCJlkGV2+SRP+DOY65WiWRH1DSaH7wgK7YAqTKrcKvRdGzXInaAo/kNJW3fMR+k9i4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j1quF8Qo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5q88S032462;
	Mon, 24 Mar 2025 05:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lIbnp
	xgREJX5ezsaXtDGge4N1KqqlmrjgSo5e/Lh4Ts=; b=j1quF8QoTDHxKuQ/eFilK
	l49IMVTv8T2F7K+sa75T6TSBCVrMSVVZDQjA2oTp6V/XjzJOGCK/eKQIHkEfkXer
	QvIZgVc3LBUb/RBx3sqkw+y8rPZJjdnssIgW861NJKql9sjTq5kdlDcLnsJTPE+6
	n4EAZTgZtbKgzVysYD3S98DUGQXSU7+AT/xFoRA8kCNtc7zhZSkzFriSAWejy56B
	dDZgQwP/CBsloKgo4q0oaw8VtcAaQq0yn5B/PRGwaPn9KJslWlz6Q6DYp8agRez0
	ojo8xCX+SOMbEtcwmq3J+LquqfwXWmbai/G1AO6hByEoLgf33cJUYUkdGW6w8ojT
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45hq27a5n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 05:10:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52O9AJ2C058942
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 05:10:19 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 05:10:19 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 05:10:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 05:10:18 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52O99Y6B001058;
	Mon, 24 Mar 2025 05:10:08 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        David Lechner <dlechner@baylibre.com>,
        "Javier
 Carrasco" <javier.carrasco.cruz@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Guillaume Stols <gstols@baylibre.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        Matteo Martelli <matteomartelli3@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Herve Codina <herve.codina@bootlin.com>,
        "Ramona Alexandra Nechita" <ramona.nechita@analog.com>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Subject: [PATCH 2/5] iio: adc: adi-axi-adc: add set decimation rate
Date: Mon, 24 Mar 2025 11:07:57 +0200
Message-ID: <20250324090813.2775011-3-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Rwt4kiP-WitRnTEc6kwbvBNnVLg3KkgJ
X-Proofpoint-GUID: Rwt4kiP-WitRnTEc6kwbvBNnVLg3KkgJ
X-Authority-Analysis: v=2.4 cv=DoZW+H/+ c=1 sm=1 tr=0 ts=67e1217c cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=p9lpGC_FqOwZuuFCcoMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240066

Add support for setting decimation rate.

Add separate compatible string for the custom AD7405 IP and implement
the necessary changes.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 43 ++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 766406f45396..0ed609e294ba 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -70,6 +70,9 @@
 #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
 
+#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2	0x0424
+#define   ADI_AXI_ADC_DEC_RATE_MASK		GENMASK(15, 0)
+
 /* IO Delays */
 #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
 #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
@@ -232,6 +235,16 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_set_dec_rate(struct iio_backend *back,
+				unsigned int rate)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_update_bits(st->regmap, (ADI_AXI_ADC_REG_CHAN_USR_CTRL_2),
+					      ADI_AXI_ADC_DEC_RATE_MASK,
+					      FIELD_PREP(ADI_AXI_ADC_DEC_RATE_MASK, rate));
+}
+
 static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
 				    unsigned int *status)
 {
@@ -465,6 +478,28 @@ static const struct iio_backend_info adi_axi_adc_generic = {
 	.ops = &adi_axi_adc_ops,
 };
 
+static const struct iio_backend_ops adi_ad7405_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.iodelay_set = axi_adc_iodelays_set,
+	.test_pattern_set = axi_adc_test_pattern_set,
+	.set_dec_rate = axi_adc_set_dec_rate,
+	.chan_status = axi_adc_chan_status,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+};
+
+static const struct iio_backend_info axi_ad7405 = {
+	.name = "axi-ad7405",
+	.ops = &adi_ad7405_ops,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct adi_axi_adc_state *st;
@@ -522,7 +557,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
+	ret = devm_iio_backend_register(&pdev->dev, st->info->backend_info, st);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
@@ -575,10 +610,16 @@ static const struct axi_adc_info adc_ad7606 = {
 	.has_child_nodes = true,
 };
 
+static const struct axi_adc_info adi_axi_ad7405 = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ad7405,
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
+	{ .compatible = "adi,axi-ad7405", .data = &adi_axi_ad7405},
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
-- 
2.34.1


