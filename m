Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8D3FDA75
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbhIAMcZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9822 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbhIAMbk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499444; x=1662035444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UK2QOHkZR/X1+4QOI21Q9uKFpQFHYrxZVCh/5BV4MFM=;
  b=zxJIxLk9HYK1vDUPipZ1axUcgEaHGfBT8BzphrguXq6LDQwA3n7byJ13
   B0p+KaZU41dTN7ETjhckrt6ZdUAb4R8U3GBL1e5mu2pjWTOvD22CDnBMW
   KtrxbAntntrKZ/x+6rbuLQuhMgvC0rdYtawxsR1PmMrcnBu1yDo5osTkA
   U4IeCY33o9OEopI2bV64T9x0aU0MBEjbTQKgi3/4OuDp/v6UyB99Glci+
   LqDBHaemjKDtc/E15Y2O3Y/5v1NWyGyJge/jR1f8ftIyrAmzPhSOersab
   sY1KkDyds0ktLF6fUAak1a90j2+lpEaSgBN2FuwDvXrk/JzEAIzKvgI4z
   g==;
IronPort-SDR: QkwpyxpbENSRI2hOhHiIvfemC02RNRZt/9D5pFo1B1rOtmA7BwrnJI4J6E5ol8UDWlrPInoYlI
 fP+08kDKdme/g5bA5nwWJ5gnxskFCzfp4IjJOqRD3rNhMKh6MeTMzpARNBRiMehuOpbMzpm3gY
 3vEiIRWgzaRUXrD9irWdFid0T62H4AvMM/YN6bHeR5ylyqg1LLbOWsA9dsSnyWUkGrYSo6Xd5R
 DbzTrR/SJUb4Jo8a5TJZIfrSVtvmARLRkTPsU69d0cHXDD5LaqI0KOylAL7t2G6Et2HH8l49mL
 jwfz0inZQYWqX3hIcIOqI5gp
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="127848035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:43 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:41 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 07/10] iio: adc: at91-sama5d2_adc: add support for sama7g5 device
Date:   Wed, 1 Sep 2021 15:30:10 +0300
Message-ID: <20210901123013.329792-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to sama7g5 ADC which is similar with sama5d2/sam9x60 device.
Differences are highlighted by compatible.
Main differences include 16 channels instead of 12 and missing
resistive touchscreen.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 78 ++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7d8e80335ba8..8a95310e8f64 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -261,6 +261,38 @@ static const struct at91_adc_reg_layout sama5d2_layout = {
 	.VERSION =		0xfc,
 };
 
+static const struct at91_adc_reg_layout sama7g5_layout = {
+	.CR =			0x00,
+	.MR =			0x04,
+	.SEQR1 =		0x08,
+	.SEQR2 =		0x0c,
+	.CHER =			0x10,
+	.CHDR =			0x14,
+	.CHSR =			0x18,
+	.LCDR =			0x20,
+	.IER =			0x24,
+	.IDR =			0x28,
+	.IMR =			0x2c,
+	.ISR =			0x30,
+	.EOC_IER =		0x34,
+	.EOC_IDR =		0x38,
+	.EOC_IMR =		0x3c,
+	.EOC_ISR =		0x40,
+	.OVER =			0x4c,
+	.EMR =			0x50,
+	.CWR =			0x54,
+	.COR =			0x5c,
+	.COR_diff_offset =	0,
+	.ACR =			0xe0,
+	.TRGR =			0x100,
+	.COSR =			0x104,
+	.CVR =			0x108,
+	.CECR =			0x10c,
+	.WPMR =			0x118,
+	.WPSR =			0x11c,
+	.VERSION =		0x130,
+};
+
 #define AT91_SAMA5D2_TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
 #define AT91_SAMA5D2_TOUCH_PEN_DETECT_DEBOUNCE_US    200
 
@@ -531,6 +563,34 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_PRESSURE(26, "pressure"),
 };
 
+static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
+	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	IIO_CHAN_SOFT_TIMESTAMP(24),
+};
+
 static const struct at91_adc_platform sama5d2_platform = {
 	.layout = &sama5d2_layout,
 	.adc_channels = &at91_sama5d2_adc_channels,
@@ -552,6 +612,21 @@ static const struct at91_adc_platform sama5d2_platform = {
 	.hw_trig_cnt = AT91_SAMA5D2_HW_TRIG_CNT,
 };
 
+static const struct at91_adc_platform sama7g5_platform = {
+	.layout = &sama7g5_layout,
+	.adc_channels = &at91_sama7g5_adc_channels,
+#define AT91_SAMA7G5_SINGLE_CHAN_CNT	16
+#define AT91_SAMA7G5_DIFF_CHAN_CNT	8
+	.nr_channels = AT91_SAMA7G5_SINGLE_CHAN_CNT +
+		       AT91_SAMA7G5_DIFF_CHAN_CNT,
+#define AT91_SAMA7G5_MAX_CHAN_IDX	(AT91_SAMA7G5_SINGLE_CHAN_CNT + \
+					AT91_SAMA7G5_DIFF_CHAN_CNT)
+	.max_channels = ARRAY_SIZE(at91_sama7g5_adc_channels),
+	.max_index = AT91_SAMA7G5_MAX_CHAN_IDX,
+#define AT91_SAMA7G5_HW_TRIG_CNT	3
+	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
+};
+
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
 {
 	int i;
@@ -2099,6 +2174,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
 	{
 		.compatible = "atmel,sama5d2-adc",
 		.data = (const void *)&sama5d2_platform,
+	}, {
+		.compatible = "microchip,sama7g5-adc",
+		.data = (const void *)&sama7g5_platform,
 	}, {
 		/* sentinel */
 	}
-- 
2.25.1

