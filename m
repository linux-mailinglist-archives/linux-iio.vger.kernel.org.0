Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B342742FB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgIVN00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 09:26:26 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26150 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgIVN0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 09:26:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08MDMOu9017185;
        Tue, 22 Sep 2020 09:26:22 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33new49vcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Sep 2020 09:26:22 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08MDQKCj025978
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 22 Sep 2020 09:26:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 22 Sep 2020 09:26:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 22 Sep 2020 09:26:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 22 Sep 2020 09:26:21 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08MDQCop015940;
        Tue, 22 Sep 2020 09:26:17 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/5] iio: adc: ad9467: add support for AD9434 high-speed ADC
Date:   Tue, 22 Sep 2020 16:25:56 +0300
Message-ID: <20200922132559.38456-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922132559.38456-1-alexandru.ardelean@analog.com>
References: <20200922132559.38456-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-22_12:2020-09-21,2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009220104
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
 drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 85f5a014bd2d..54a5864bc698 100644
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
 
@@ -158,6 +167,13 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int ad9434_scale_table[][2] = {
+	{1600, 0x1C}, {1580, 0x1D}, {1550, 0x1E}, {1520, 0x1F}, {1500, 0x00},
+	{1470, 0x01}, {1440, 0x02}, {1420, 0x03}, {1390, 0x04}, {1360, 0x05},
+	{1340, 0x06}, {1310, 0x07}, {1280, 0x08}, {1260, 0x09}, {1230, 0x0A},
+	{1200, 0x0B}, {1180, 0x0C},
+};
+
 static const unsigned int ad9467_scale_table[][2] = {
 	{2000, 0}, {2100, 6}, {2200, 7},
 	{2300, 8}, {2400, 9}, {2500, 10},
@@ -191,11 +207,27 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
 	},								\
 }
 
+static const struct iio_chan_spec ad9434_channels[] = {
+	AD9467_CHAN(0, 0, 12, 'S'),
+};
+
 static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, 0, 16, 'S'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl[] = {
+	[ID_AD9434] = {
+		.axi_adc_info = {
+			.id = CHIPID_AD9434,
+			.max_rate = 500000000UL,
+			.scale_table = ad9434_scale_table,
+			.num_scales = ARRAY_SIZE(ad9434_scale_table),
+			.channels = ad9434_channels,
+			.num_channels = ARRAY_SIZE(ad9434_channels),
+		},
+		.default_output_mode = AD9434_DEF_OUTPUT_MODE,
+		.vref_mask = AD9434_REG_VREF_MASK,
+	},
 	[ID_AD9467] = {
 		.axi_adc_info = {
 			.id = CHIPID_AD9467,
@@ -400,6 +432,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
 	{}
 };
-- 
2.17.1

