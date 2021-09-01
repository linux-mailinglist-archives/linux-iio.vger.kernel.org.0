Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D253FDA9B
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244965AbhIAMdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:33:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:27508 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbhIAMcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499468; x=1662035468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kckYhD66DFZkK8lLvrMRwHsV78aFwfuAzTiiTncJlik=;
  b=mCdSYcZ8BoEJZesneHdlv8Wx8EozBzwsgPTLYdDCgUf+ttBo5C9iWyMi
   6mg717tDhHAHwRn3jTaKBq90YwOSmr900r+7mJQoIytsJQ35WHaaA6wAk
   YOMZVq505Rb2uJsm5BQ5fu5AcYxrAHgECj+PlW8GvZcm83HTtJuwebW8T
   SuZMybNoKqq9+7sQaov6aALpxpQB2LisB0imPPYMAk1QMxKHTcjinGwiQ
   U5BxayMBs3jXuuK4C+XtEWO7LxnWXejodN+vH8/0eoSXnuPJ9WTS3iXNs
   XL0QzPzP9nrVlsBm22tDfcUe7hLnwI2+N8DLPIDEgwX3JP74bbjj1Apak
   g==;
IronPort-SDR: 6evxSRl6p9JyTrXL1bzTEb7EIwuuVTYQyJzyRs/rIcjdibN81FSik1vULD09GRoCFs+0XOWHmN
 HWYSwfaj6T21bFMOZKq9R+b5quNxxKhcHo6Hujg18G2s0AfmIJhdhOmdKjn+hgHu068kHw/m80
 eVAgjume8byFgT6GyHUVzYXLIZrRBiS6npb+SC8qVxc5eAsCzx8fIr25kW2k+Tm/qots18PU2N
 9IthuUt+ZiTNoxFXNiFEZN++uTyKXYCRYNq46/qOdclCjZhkSfcsp+i4w8CpezkNmgZFtbmERM
 gl1ea45FMdA7ixw43IrTTv9M
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="130318400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:40 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:38 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 06/10] iio: adc: at91-sama5d2_adc: add helper for COR register
Date:   Wed, 1 Sep 2021 15:30:09 +0300
Message-ID: <20210901123013.329792-7-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
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
Changes in v3:
- fixed nitpick:
> +     cor = (BIT(chan->channel) | BIT(chan->channel2));

Excessive brackets.



 drivers/iio/adc/at91-sama5d2_adc.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index c227a0865a31..7d8e80335ba8 100644
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
@@ -594,6 +595,21 @@ static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
 	return mask & GENMASK(st->soc_info.platform->nr_channels, 0);
 }
 
+static void at91_adc_cor(struct at91_adc_state *st,
+			 struct iio_chan_spec const *chan)
+{
+	u32 cor, cur_cor;
+
+	cor = BIT(chan->channel) | BIT(chan->channel2);
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
@@ -1038,8 +1054,6 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 			 indio_dev->num_channels) {
 		struct iio_chan_spec const *chan =
 					at91_adc_chan_get(indio_dev, bit);
-		u32 cor;
-
 		if (!chan)
 			continue;
 		/* these channel types cannot be handled by this trigger */
@@ -1047,16 +1061,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
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
@@ -1444,7 +1449,6 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 				  struct iio_chan_spec const *chan, int *val)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	u32 cor = 0;
 	u16 tmp_val;
 	int ret;
 
@@ -1490,11 +1494,7 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 
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

