Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471CA3F5D77
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbhHXL44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:56:56 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23272 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbhHXL4u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806167; x=1661342167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qW8KAnZWqVWyEk8YWpmG05BOTuKIoV+MBdVsrB4eYEI=;
  b=lKro4fc7LK8/ouizPWs5YJIu+F9J3Vr5+7TUs64943c/Ma7T/ZoTwT+7
   vWU9EKb60BcNhci4svBbuMAiBMtKZcT6k2j09ekgDg7Xllm4TZMc3lJwd
   rOzHIUtsr1Pi6eLg72uDHLhld266Mu4snF05sI0Ynl9bVUP0RoKd7a86Z
   kbwqX32WqxjzfoOKReUduGYmq7jUFq6mMlW20uPxoS8QuuWRRZYcSbHDm
   8nqXib8EC82mDI4xn1FM0GBX7g3lo4kyEHAYhxpuEFPATsubr758JkPxw
   CCc95OH5XUIxYcA9z0QXXPZI3fO4rE/QccrLZNk6A1KyaUIfTee3qx6Dl
   Q==;
IronPort-SDR: Hrk2LLzY/eHEwtHW+yRZLI6Gy9f8o987RkgHU7lcFxGNvguHfYwOIwIHILYzUWl6lEk+CbgU2R
 Us9sT+/Zrb8yL+hbsjzv5BWoZq9nBSrNxZfhUoZqlNNEZ9xkpdJTTle0NAFAzoA+PivMbpr59o
 OMlImnf7uLK/NVGo603yMzx+z2xkDlEKhONZo2WLobmFIyPovjUuSRKUpfwRIHHfenrX+4jMLj
 AW1g2jhiBu6uaHoM0j7OauOy4IptcLBzqR2cAq3pRXCUoMTflV22T3fUu7v8/K1rOPJ/Q2I5Ph
 +iLfVPXrJXgit6N/tot/cCb3
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="126884960"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:56:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:56:02 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:55:47 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 05/10] iio: adc: at91-sama5d2-adc: add support for separate end of conversion registers
Date:   Tue, 24 Aug 2021 14:54:36 +0300
Message-ID: <20210824115441.681253-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some platforms have separated the end-of-conversion information from the
usual ISR/IMR/IER/IDR registers, into EOC_ISR/EOC_IMR/EOC_IER/EOC_IDR.
To cope with both variants, helpers are being added, that will make
code more clear and more easy to read.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 66 ++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 8ede18b8d789..23be7cec063e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -117,6 +117,14 @@ struct at91_adc_reg_layout {
 	u16				IMR;
 /* Interrupt Status Register */
 	u16				ISR;
+/* End of Conversion Interrupt Enable Register */
+	u16				EOC_IER;
+/* End of Conversion Interrupt Disable Register */
+	u16				EOC_IDR;
+/* End of Conversion Interrupt Mask Register */
+	u16				EOC_IMR;
+/* End of Conversion Interrupt Status Register */
+	u16				EOC_ISR;
 /* Interrupt Status Register - Pen touching sense status */
 #define AT91_SAMA5D2_ISR_PENS   BIT(31)
 /* Last Channel Trigger Mode Register */
@@ -581,6 +589,44 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
 	return mask & GENMASK(st->soc_info.platform->nr_channels, 0);
 }
 
+static void at91_adc_irq_status(struct at91_adc_state *st, u32 *status,
+				u32 *eoc)
+{
+	*status = at91_adc_readl(st, ISR);
+	if (st->soc_info.platform->layout->EOC_ISR)
+		*eoc = at91_adc_readl(st, EOC_ISR);
+	else
+		*eoc = *status;
+}
+
+static void at91_adc_irq_mask(struct at91_adc_state *st, u32 *status, u32 *eoc)
+{
+	*status = at91_adc_readl(st, IMR);
+	if (st->soc_info.platform->layout->EOC_IMR)
+		*eoc = at91_adc_readl(st, EOC_IMR);
+	else
+		*eoc = *status;
+}
+
+static void at91_adc_eoc_dis(struct at91_adc_state *st, unsigned int channel)
+{
+	/*
+	 * On some products having the EOC bits in a separate register,
+	 * errata recommends not writing this register (EOC_IDR).
+	 * On products having the EOC bits in the IDR register, it's fine to write it.
+	 */
+	if (!st->soc_info.platform->layout->EOC_IDR)
+		at91_adc_writel(st, IDR, BIT(channel));
+}
+
+static void at91_adc_eoc_ena(struct at91_adc_state *st, unsigned int channel)
+{
+	if (!st->soc_info.platform->layout->EOC_IDR)
+		at91_adc_writel(st, IER, BIT(channel));
+	else
+		at91_adc_writel(st, EOC_IER, BIT(channel));
+}
+
 static void at91_adc_config_emr(struct at91_adc_state *st)
 {
 	/* configure the extended mode register */
@@ -1100,13 +1146,15 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 	u8 bit;
 	u32 mask = at91_adc_active_scan_mask_to_reg(indio_dev);
 	unsigned int timeout = 50;
+	u32 status, imr, eoc = 0, eoc_imr;
 
 	/*
 	 * Check if the conversion is ready. If not, wait a little bit, and
 	 * in case of timeout exit with an error.
 	 */
-	while ((at91_adc_readl(st, ISR) & mask) != mask &&
-	       timeout) {
+	while (((eoc & mask) != mask) && timeout) {
+		at91_adc_irq_status(st, &status, &eoc);
+		at91_adc_irq_mask(st, &imr, &eoc_imr);
 		usleep_range(50, 100);
 		timeout--;
 	}
@@ -1342,12 +1390,14 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio = private;
 	struct at91_adc_state *st = iio_priv(indio);
-	u32 status = at91_adc_readl(st, ISR);
-	u32 imr = at91_adc_readl(st, IMR);
+	u32 status, eoc, imr, eoc_imr;
 	u32 rdy_mask = AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
 			AT91_SAMA5D2_IER_PRDY;
 
-	if (!(status & imr))
+	at91_adc_irq_status(st, &status, &eoc);
+	at91_adc_irq_mask(st, &imr, &eoc_imr);
+
+	if (!(status & imr) && !(eoc & eoc_imr))
 		return IRQ_NONE;
 	if (status & AT91_SAMA5D2_IER_PEN) {
 		/* pen detected IRQ */
@@ -1441,7 +1491,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	at91_adc_writel(st, COR, cor);
 	at91_adc_writel(st, CHER, BIT(chan->channel));
-	at91_adc_writel(st, IER, BIT(chan->channel));
+	at91_adc_eoc_ena(st, chan->channel);
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
 
 	ret = wait_event_interruptible_timeout(st->wq_data_available,
@@ -1458,7 +1508,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		st->conversion_done = false;
 	}
 
-	at91_adc_writel(st, IDR, BIT(chan->channel));
+	at91_adc_eoc_dis(st, st->chan->channel);
 	at91_adc_writel(st, CHDR, BIT(chan->channel));
 
 	/* Needed to ACK the DRDY interruption */
@@ -1676,6 +1726,8 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
+	if (st->soc_info.platform->layout->EOC_IDR)
+		at91_adc_writel(st, EOC_IDR, 0xffffffff);
 	at91_adc_writel(st, IDR, 0xffffffff);
 	/*
 	 * Transfer field must be set to 2 according to the datasheet and
-- 
2.25.1

