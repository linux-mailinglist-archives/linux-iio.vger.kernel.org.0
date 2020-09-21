Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D0D272117
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIUK3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 06:29:12 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55704 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgIUK3B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 06:29:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LAKAgf003003;
        Mon, 21 Sep 2020 06:28:59 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33nbu660yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 06:28:59 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08LASwED057454
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 21 Sep 2020 06:28:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 21 Sep
 2020 06:28:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 21 Sep 2020 06:28:59 -0400
Received: from saturn.ad.analog.com ([10.48.65.111])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08LASrIV019182;
        Mon, 21 Sep 2020 06:28:54 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: adc ad9467: add support for AD9434 high-speed ADC
Date:   Mon, 21 Sep 2020 13:28:49 +0300
Message-ID: <20200921102850.192224-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_02:2020-09-21,2020-09-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210075
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

The AD9434 is a 12-bit monolithic sampling analog-to-digital converter
(ADC) optimized for high performance, low power, and ease of use. The part
operates at up to a 500 MSPS conversion rate and is optimized for
outstanding dynamic performance in wideband carrier and broadband systems.

All necessary functions, including a sample-and-hold and voltage reference,
are included on the chip to provide a complete signal conversion solution.
The VREF pin can be used to monitor the internal reference or provide an
external voltage reference (external reference mode must be enabled through
the SPI port).

The ADC requires a 1.8 V analog voltage supply and a differential clock
for full performance operation. The digital outputs are LVDS (ANSI-644)
compatible and support twos complement, offset binary format, or Gray code.
A data clock output is available for proper output data timing.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf

The driver supports the same register set as the AD9467, so the support for
this chip is added to the 'ad9467' driver.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f068256cfca9..aee3007ea3f2 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -76,6 +76,14 @@
 /* AN877_ADC_REG_OUTPUT_DELAY */
 #define AN877_ADC_DCO_DELAY_ENABLE		0x80
 
+/*
+ * Analog Devices AD9434 12-Bit, 370/500 MSPS ADC
+ */
+
+#define CHIPID_AD9434			0x6A
+#define AD9434_DEF_OUTPUT_MODE		0x00
+#define AD9434_REG_VREF_MASK		0xC0
+
 /*
  * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
  */
@@ -85,6 +93,7 @@
 #define AD9467_REG_VREF_MASK		0x0F
 
 enum {
+	ID_AD9434,
 	ID_AD9467,
 };
 
@@ -154,6 +163,13 @@ static const unsigned int ad9467_scale_table[][2] = {
 	{2300, 8}, {2400, 9}, {2500, 10},
 };
 
+static const unsigned int ad9434_scale_table[][2] = {
+	{1600, 0x1C}, {1580, 0x1D}, {1550, 0x1E}, {1520, 0x1F}, {1500, 0x00},
+	{1470, 0x01}, {1440, 0x02}, {1420, 0x03}, {1390, 0x04}, {1360, 0x05},
+	{1340, 0x06}, {1310, 0x07}, {1280, 0x08}, {1260, 0x09}, {1230, 0x0A},
+	{1200, 0x0B}, {1180, 0x0C},
+};
+
 static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 			       unsigned int *val, unsigned int *val2)
 {
@@ -182,11 +198,23 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9434_channels[] = {
+	AD9467_CHAN(0, 0, 12, 'S'),
+};
+
 static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, 0, 16, 'S'),
 };
 
 static const struct adi_axi_adc_chip_info ad9467_chip_tbl[] = {
+	[ID_AD9434] = {
+		.id = CHIPID_AD9434,
+		.max_rate = 500000000UL,
+		.scale_table = ad9434_scale_table,
+		.num_scales = ARRAY_SIZE(ad9434_scale_table),
+		.channels = ad9434_channels,
+		.num_channels = ARRAY_SIZE(ad9434_channels),
+	},
 	[ID_AD9467] = {
 		.id = CHIPID_AD9467,
 		.max_rate = 250000000UL,
@@ -318,10 +346,14 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 
 static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
 {
+	st->output_mode = AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+
 	switch (chip_id) {
+	case CHIPID_AD9434:
+		st->output_mode |= AD9434_DEF_OUTPUT_MODE;
+		return 0;
 	case CHIPID_AD9467:
-		st->output_mode = AD9467_DEF_OUTPUT_MODE |
-				  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		st->output_mode |= AD9467_DEF_OUTPUT_MODE;
 		return 0;
 	default:
 		return -ENODEV;
@@ -404,6 +436,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
 	{}
 };
-- 
2.25.1

