Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E932B3F5D7E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhHXL5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:57:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23293 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhHXL5C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806178; x=1661342178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O2F9iMbsqVusgWy32NpWZn++fKpKK8ooQFRG0T709+4=;
  b=JDNCNZHIiagXtb1WvfaZ5YM79BXoAcf2d6B+juRAONdP2IEjxd+7hRHm
   XS/X+UdfugqM3nvn/pEr4XhASxCm+OBM+q3n6Mu5XOd3nE4y+6Du/As7d
   DO3tToXABL9TMILl63pxQpvAXB+tVyIcwJeB/ZZNRvhMUC3J0HFhuIE6U
   A/F1ewbmFYEJ0QBllGqWH1uCeq/Gdv7Jt9tpiEN9ZVwDs5Bw2w7wV33IN
   jnx3MhSosse1xgOI0B8kEk9lpRvOt7SB+pjDMrOB2wOC6XgA3d8uz2fUk
   6/ASBzn36zpk2JENgk/dj4w7wEGLrk19vT2xzLForeQe+F02MYyJaZSl+
   A==;
IronPort-SDR: OMaPYsKFvNM5MiwqX/Tf6LnWqxXmlukZjffI0sMSu5XBk08seitPT5l2n76G4aa3mzfqf74pKE
 LuVuFecpezXhQJPvK6UwpI3U1JPIrpjQzeALqmawVS4V1Rn21SsTuSaWArJanAXVXzd7SjyWhm
 xB05q1pi3iuve2LAa5Oqh04WeoHVBy3/SCzpDgo/fKjJfJjm46rmKU0tCuBHxNb5D4nbCffG71
 vmGaShWlpRhpcJejGgqjiKz77xEvPX+Ssu9Fl9mOKl0a6c6fqLZDgxm+5LfehzqnwugFEehPxC
 MIp0k9NLCMNd3hhfugYT6CQ8
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="126884978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:56:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:56:16 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:56:02 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 06/10] iio: adc: at91-sama5d2_adc: add helper for COR register
Date:   Tue, 24 Aug 2021 14:54:37 +0300
Message-ID: <20210824115441.681253-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add helper for the COR register. This helper allows to modify the COR
register, removes duplicate code and improves readability.
The COR offset is now part of the register layout. This will allow
different platform with a different offset to use the same helper.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 23be7cec063e..bb4e5e1e3ce4 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -151,8 +151,8 @@ struct at91_adc_reg_layout {
 	u16				CGR;
 /* Channel Offset Register */
 	u16				COR;
-#define AT91_SAMA5D2_COR_DIFF_OFFSET	16
-
+/* Channel Offset Register differential offset - constant, not a register */
+	u16				COR_diff_offset;
 /* Analog Control Register */
 	u16				ACR;
 /* Analog Control Register - Pen detect sensitivity mask */
@@ -246,6 +246,7 @@ static const struct at91_adc_reg_layout sama5d2_layout = {
 	.CWR =			0x44,
 	.CGR =			0x48,
 	.COR =			0x4c,
+	.COR_diff_offset =	16,
 	.ACR =			0x94,
 	.TSMR =			0xb0,
 	.XPOSR =		0xb4,
@@ -589,6 +590,21 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
 	return mask & GENMASK(st->soc_info.platform->nr_channels, 0);
 }
 
+static void at91_adc_cor(struct at91_adc_state *st,
+			 struct iio_chan_spec const *chan)
+{
+	u32 cor, cur_cor;
+
+	cor = (BIT(chan->channel) | BIT(chan->channel2));
+
+	cur_cor = at91_adc_readl(st, COR);
+	cor <<= st->soc_info.platform->layout->COR_diff_offset;
+	if (chan->differential)
+		at91_adc_writel(st, COR, cur_cor | cor);
+	else
+		at91_adc_writel(st, COR, cur_cor & ~cor);
+}
+
 static void at91_adc_irq_status(struct at91_adc_state *st, u32 *status,
 				u32 *eoc)
 {
@@ -1033,8 +1049,6 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 			 indio_dev->num_channels) {
 		struct iio_chan_spec const *chan =
 					at91_adc_chan_get(indio_dev, bit);
-		u32 cor;
-
 		if (!chan)
 			continue;
 		/* these channel types cannot be handled by this trigger */
@@ -1042,16 +1056,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		    chan->type == IIO_PRESSURE)
 			continue;
 
-		cor = at91_adc_readl(st, COR);
-
-		if (chan->differential)
-			cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
-				AT91_SAMA5D2_COR_DIFF_OFFSET;
-		else
-			cor &= ~(BIT(chan->channel) <<
-			       AT91_SAMA5D2_COR_DIFF_OFFSET);
-
-		at91_adc_writel(st, COR, cor);
+		at91_adc_cor(st, chan);
 
 		at91_adc_writel(st, CHER, BIT(chan->channel));
 	}
@@ -1439,7 +1444,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	u32 cor = 0;
 	u16 tmp_val;
 	int ret;
 
@@ -1485,11 +1489,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
 	st->chan = chan;
 
-	if (chan->differential)
-		cor = (BIT(chan->channel) | BIT(chan->channel2)) <<
-		      AT91_SAMA5D2_COR_DIFF_OFFSET;
-
-	at91_adc_writel(st, COR, cor);
+	at91_adc_cor(st, chan);
 	at91_adc_writel(st, CHER, BIT(chan->channel));
 	at91_adc_eoc_ena(st, chan->channel);
 	at91_adc_writel(st, CR, AT91_SAMA5D2_CR_START);
-- 
2.25.1

