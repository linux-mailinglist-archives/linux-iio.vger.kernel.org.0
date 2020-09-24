Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09885276B67
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 10:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgIXIFq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 04:05:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17950 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbgIXIFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 04:05:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O82fbE015755;
        Thu, 24 Sep 2020 04:05:42 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6b79u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 04:05:41 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08O85eMM049955
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 04:05:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 24 Sep
 2020 04:05:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 04:05:39 -0400
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O85Srs000911;
        Thu, 24 Sep 2020 04:05:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 2/4] iio: adc: ad9467: add support for AD9434 high-speed ADC
Date:   Thu, 24 Sep 2020 11:05:16 +0300
Message-ID: <20200924080518.96410-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924080518.96410-1-alexandru.ardelean@analog.com>
References: <20200924080518.96410-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_05:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240062
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
2.25.1

