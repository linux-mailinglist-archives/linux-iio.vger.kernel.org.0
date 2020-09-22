Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCF2742FC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIVN0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 09:26:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25042 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbgIVN0X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 09:26:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MDKDKK014319;
        Tue, 22 Sep 2020 09:26:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu6aggu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:26:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08MDQJNL025972
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 22 Sep 2020 09:26:20 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 22 Sep
 2020 06:26:20 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 22 Sep 2020 06:26:19 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08MDQCoo015940;
        Tue, 22 Sep 2020 09:26:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/5] iio: adc: ad9467: wrap a axi-adc chip-info into a ad9467_chip_info type
Date:   Tue, 22 Sep 2020 16:25:55 +0300
Message-ID: <20200922132559.38456-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922132559.38456-1-alexandru.ardelean@analog.com>
References: <20200922132559.38456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_12:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=856 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220104
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are 2 chip constants that can be added to the chip-info part. The
default output-mode and the VREF mask.

When adding new chips to this driver, these can be easily omitted, because
these also need to be updated in 2 switch statements.

However, if adding them in the chip-info constants, they are updated in a
single place and propagated in both switch statements.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad9467.c | 62 +++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f068256cfca9..85f5a014bd2d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -88,6 +88,15 @@ enum {
 	ID_AD9467,
 };
 
+struct ad9467_chip_info {
+	struct adi_axi_adc_chip_info	axi_adc_info;
+	unsigned int			default_output_mode;
+	unsigned int			vref_mask;
+};
+
+#define to_ad9467_chip_info(_info)	\
+	container_of(_info, struct ad9467_chip_info, axi_adc_info)
+
 struct ad9467_state {
 	struct spi_device		*spi;
 	struct clk			*clk;
@@ -186,35 +195,31 @@ static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, 0, 16, 'S'),
 };
 
-static const struct adi_axi_adc_chip_info ad9467_chip_tbl[] = {
+static const struct ad9467_chip_info ad9467_chip_tbl[] = {
 	[ID_AD9467] = {
-		.id = CHIPID_AD9467,
-		.max_rate = 250000000UL,
-		.scale_table = ad9467_scale_table,
-		.num_scales = ARRAY_SIZE(ad9467_scale_table),
-		.channels = ad9467_channels,
-		.num_channels = ARRAY_SIZE(ad9467_channels),
+		.axi_adc_info = {
+			.id = CHIPID_AD9467,
+			.max_rate = 250000000UL,
+			.scale_table = ad9467_scale_table,
+			.num_scales = ARRAY_SIZE(ad9467_scale_table),
+			.channels = ad9467_channels,
+			.num_channels = ARRAY_SIZE(ad9467_channels),
+		},
+		.default_output_mode = AD9467_DEF_OUTPUT_MODE,
+		.vref_mask = AD9467_REG_VREF_MASK,
 	},
 };
 
 static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 {
 	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	const struct ad9467_chip_info *info1 = to_ad9467_chip_info(info);
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
-	unsigned int i, vref_val, vref_mask;
+	unsigned int i, vref_val;
 
 	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
 
-	switch (info->id) {
-	case CHIPID_AD9467:
-		vref_mask = AD9467_REG_VREF_MASK;
-		break;
-	default:
-		vref_mask = 0xFFFF;
-		break;
-	}
-
-	vref_val &= vref_mask;
+	vref_val &= info1->vref_mask;
 
 	for (i = 0; i < info->num_scales; i++) {
 		if (vref_val == info->scale_table[i][1])
@@ -316,18 +321,6 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
-static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
-{
-	switch (chip_id) {
-	case CHIPID_AD9467:
-		st->output_mode = AD9467_DEF_OUTPUT_MODE |
-				  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
-		return 0;
-	default:
-		return -ENODEV;
-	}
-}
-
 static void ad9467_clk_disable(void *data)
 {
 	struct ad9467_state *st = data;
@@ -337,7 +330,7 @@ static void ad9467_clk_disable(void *data)
 
 static int ad9467_probe(struct spi_device *spi)
 {
-	const struct adi_axi_adc_chip_info *info;
+	const struct ad9467_chip_info *info;
 	struct adi_axi_adc_conv *conv;
 	struct ad9467_state *st;
 	unsigned int id;
@@ -386,7 +379,7 @@ static int ad9467_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, st);
 
-	conv->chip_info = info;
+	conv->chip_info = &info->axi_adc_info;
 
 	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
 	if (id != conv->chip_info->id) {
@@ -400,7 +393,10 @@ static int ad9467_probe(struct spi_device *spi)
 	conv->read_raw = ad9467_read_raw;
 	conv->preenable_setup = ad9467_preenable_setup;
 
-	return ad9467_setup(st, id);
+	st->output_mode = info->default_output_mode |
+			  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+
+	return 0;
 }
 
 static const struct of_device_id ad9467_of_match[] = {
-- 
2.17.1

