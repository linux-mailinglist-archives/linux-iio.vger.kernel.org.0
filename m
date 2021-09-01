Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC23FDA6E
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbhIAMcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244885AbhIAMbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499439; x=1662035439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1x0+Qp34bILSG55aLS1tJl2YzVKf2hhzsH4Fixrb5FY=;
  b=xtEd9v4plT9HbLBCG59y/O2w/dtTGXYMTcrvoJQzDOv8m3AAwRLiB0tD
   w60og7JgGhZLd2wRiCewgGvyErjshrc8l4cwBVIUJqIfTrD5B1CRcwJr/
   CeZPM9GewLjDCnXzVvNLuFUaj+jriTY4+J2gKxayF1wfJ+ymDCTL4xvZz
   aKOu+BYRH4bz2KeAuUQCga0ZkURdJp0HMK1wYayhi//76vUTara9sJ4vJ
   mV4LWbjEHNWxefxPTHeqogSbQxws3NaZudgXeCbwaXuWeJCv4QtYdC2fh
   Lz8Pm4O/AKyPIcjk22Ek9jTAqM+6VFh1XRL5OsOlJmKJZpO7QXiz1EKG2
   A==;
IronPort-SDR: Ni+ok4B2d06ubRZpzGS0CbhtCRWw3fXhmkDyCB2A52NnQpgUC3jgse0gHruXNpbpWOnpsEzEMh
 dIjv2on6P6mU53urOV42CD7xRLnkgKfhSgzCnvIZrNTIfv6c31zyidV5jLo4u3OWaIbgXwP5wC
 uOwP3N84AlsWD5tSuxu0Qw5rYzQpXA/xjbn9ofqy6LSzyAzcZpKGMsMfsIDon0Iq5wuCGLoqwj
 FqE4rBVlLTlT/G2NdfNCxADzUVbimLvozp0VCUsuwxQbrQ6/biHuoAxHAYgsNWDQaLE4tBvJrA
 AfBUfeE0+ZGtOlyURVe46TaM
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="130318387"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:38 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:35 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 05/10] iio: adc: at91-sama5d2_adc: add support for separate end of conversion registers
Date:   Wed, 1 Sep 2021 15:30:08 +0300
Message-ID: <20210901123013.329792-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
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
Changes in v3:
- subject at91-sama5d2-adc -> at91-sama5d2_adc

 drivers/iio/adc/at91-sama5d2_adc.c | 66 ++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d81e16f13b3b..c227a0865a31 100644
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
@@ -586,6 +594,44 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
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
@@ -1105,13 +1151,15 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
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
@@ -1347,12 +1395,14 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
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
@@ -1446,7 +1496,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	at91_adc_writel(st, COR, cor);
 	at91_adc_writel(st, CHER, BIT(chan->channel));
-	at91_adc_writel(st, IER, BIT(chan->channel));
+	at91_adc_eoc_ena(st, chan->channel);
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
 
 	ret = wait_event_interruptible_timeout(st->wq_data_available,
@@ -1463,7 +1513,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		st->conversion_done = false;
 	}
 
-	at91_adc_writel(st, IDR, BIT(chan->channel));
+	at91_adc_eoc_dis(st, st->chan->channel);
 	at91_adc_writel(st, CHDR, BIT(chan->channel));
 
 	/* Needed to ACK the DRDY interruption */
@@ -1681,6 +1731,8 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_SWRST);
+	if (st->soc_info.platform->layout->EOC_IDR)
+		at91_adc_writel(st, EOC_IDR, 0xffffffff);
 	at91_adc_writel(st, IDR, 0xffffffff);
 	/*
 	 * Transfer field must be set to 2 according to the datasheet and
-- 
2.25.1

