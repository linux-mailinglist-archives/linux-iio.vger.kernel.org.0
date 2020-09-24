Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78F5276B6D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgIXIFw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 04:05:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22218 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgIXIFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2020 04:05:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08O82fcs015752;
        Thu, 24 Sep 2020 04:05:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6b79w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 04:05:44 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08O85hsN049967
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Sep 2020 04:05:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 24 Sep
 2020 04:05:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 24 Sep 2020 04:05:41 -0400
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08O85Srt000911;
        Thu, 24 Sep 2020 04:05:33 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <Michael.Hennerich@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/4] iio: adc: ad9467: add support for AD9265 high-speed ADC
Date:   Thu, 24 Sep 2020 11:05:17 +0300
Message-ID: <20200924080518.96410-4-alexandru.ardelean@analog.com>
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

The AD9265 is a 16-bit, 125 MSPS analog-to-digital converter (ADC). The
AD9265 is designed to support communications applications where high
performance combined with low cost, small size, and versatility is
desired.

The ADC core features a multistage, differential pipelined architecture
with integrated output error correction logic to provide 16-bit accuracy at
125 MSPS data rates and guarantees no missing codes over the full operating
temperature range.

The ADC features a wide bandwidth differential sample-and-hold analog input
amplifier supporting a variety of user-selectable input ranges. It is
suitable for multiplexed systems that switch full-scale voltage levels in
successive channels and for sampling single-channel inputs at frequencies
well beyond the Nyquist rate. Combined with power and cost savings over
previously available ADCs, the AD9265 is suitable for applications in
communications, instrumentation and medical imaging.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf

The driver supports the same register set as the AD9467, so the support for
this chip is added to the 'ad9467' driver.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad9467.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 54a5864bc698..19a45dd43796 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -76,6 +76,14 @@
 /* AN877_ADC_REG_OUTPUT_DELAY */
 #define AN877_ADC_DCO_DELAY_ENABLE		0x80
 
+/*
+ * Analog Devices AD9265 16-Bit, 125/105/80 MSPS ADC
+ */
+
+#define CHIPID_AD9265			0x64
+#define AD9265_DEF_OUTPUT_MODE		0x40
+#define AD9265_REG_VREF_MASK		0xC0
+
 /*
  * Analog Devices AD9434 12-Bit, 370/500 MSPS ADC
  */
@@ -93,6 +101,7 @@
 #define AD9467_REG_VREF_MASK		0x0F
 
 enum {
+	ID_AD9265,
 	ID_AD9434,
 	ID_AD9467,
 };
@@ -167,6 +176,10 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	return 0;
 }
 
+static const unsigned int ad9265_scale_table[][2] = {
+	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
+};
+
 static const unsigned int ad9434_scale_table[][2] = {
 	{1600, 0x1C}, {1580, 0x1D}, {1550, 0x1E}, {1520, 0x1F}, {1500, 0x00},
 	{1470, 0x01}, {1440, 0x02}, {1420, 0x03}, {1390, 0x04}, {1360, 0x05},
@@ -216,6 +229,18 @@ static const struct iio_chan_spec ad9467_channels[] = {
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl[] = {
+	[ID_AD9265] = {
+		.axi_adc_info = {
+			.id = CHIPID_AD9265,
+			.max_rate = 125000000UL,
+			.scale_table = ad9265_scale_table,
+			.num_scales = ARRAY_SIZE(ad9265_scale_table),
+			.channels = ad9467_channels,
+			.num_channels = ARRAY_SIZE(ad9467_channels),
+		},
+		.default_output_mode = AD9265_DEF_OUTPUT_MODE,
+		.vref_mask = AD9265_REG_VREF_MASK,
+	},
 	[ID_AD9434] = {
 		.axi_adc_info = {
 			.id = CHIPID_AD9434,
@@ -432,6 +457,7 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9265", .data = &ad9467_chip_tbl[ID_AD9265], },
 	{ .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
 	{}
-- 
2.25.1

