Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A53F5D81
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhHXL5S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:57:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2714 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhHXL5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806193; x=1661342193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7nI8fyTYBz20af6nUrWsfLTibicHMU5AlrcEN/AkcDo=;
  b=b+eZ55FxM/2tLAttPUnePVa/IkuiaxdLQCa501udS3kyD3Itp0HT+dEu
   ANrCk2QNpZjAxjYoYBuWB/FpT2uEd/t+Pksx250R3HITgTVWPRAGqN5Sb
   SPg1J5ZxNP4/1BpKHvYMmqgV5DYNafxgglzMaQgqQhDxKm5Kqr6Om8IL4
   p6JwIKluUpOL45w9lVewGqoE6pkOWG2sRZiwbWq9+g5aESPTeiGD3x4Gu
   kAyOPMNFaVPY+g50saYvFCEF2r6K6Xj/kL0p8Hn0f8RM2FLHJwusrQmUY
   c6u/rXYizbx2HsDhTA8DOteLEcBE2+VO4QJXuCH+GrB7gsLqPBb/0soOQ
   A==;
IronPort-SDR: HiHKPZpeRDBX4xcDtX7bINfg9KyhALmckMhKrpleMxM8yS/ls0XLbs7UxyiKxHLZnP7jiTi2NZ
 35NMR+6+wX0y+NRBwu8q1bmMaACvdN+ZAgfPeVL+Lm5JlzP66+Jwq1xU4scgW7HBONNbMSLWh0
 y5sfq9Bkou0aBZVdbzG9sisOiCbzjE16Gbcz+HEJgl/zaT2v/hKvbbk3QwTxlC7IVN8jHluoVI
 2AG8vawf1Qv9qwFL4zNS37H8LmZEsgJ5Y2lnZvEvxQvIhH8TmfWjbaO0HZ0y+cKNgmX6rOohMn
 5mu21dk9GBOBSgMERjrLkeYj
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="66906609"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:56:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:56:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:56:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 07/10] iio: adc: at91-sama5d2_adc: add support for sama7g5 device
Date:   Tue, 24 Aug 2021 14:54:38 +0300
Message-ID: <20210824115441.681253-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
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
 drivers/iio/adc/at91-sama5d2_adc.c | 77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index bb4e5e1e3ce4..f3f5230eac54 100644
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
 
@@ -527,6 +559,34 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_PRESSURE(21, "pressure"),
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
@@ -547,6 +607,20 @@ static const struct at91_adc_platform sama5d2_platform = {
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
+#define AT91_SAMA7G5_HW_TRIG_CNT	3
+	.hw_trig_cnt = AT91_SAMA7G5_HW_TRIG_CNT,
+};
+
 static int at91_adc_chan_xlate(struct iio_dev *indio_dev, int chan)
 {
 	int i;
@@ -2094,6 +2168,9 @@ static const struct of_device_id at91_adc_dt_match[] = {
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

