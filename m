Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D81D7487
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfJOLNH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:13:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731799AbfJOLMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FImbjSlBLQU6w2z/iCVuGjm90w0sbr42HLTIqyphFao=; b=lKXNwCEX34O8
        QSn0eqeuZDlrRCmkFQWcaizKE9uEyt7EkP1Tlvs/bu/BCYsCWvgWbuHG8C4KquopBhtZk63eNXqsT
        HTTHFRh/pReCMuafjBIFg+DW1DDkp4s2OYPR4tQl2i0Nyxc+SN51u3pBuzN3+6/TBfMvBa/PSwH1O
        mti7k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkb-00021k-Oh; Tue, 15 Oct 2019 11:12:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 44F652741CD7; Tue, 15 Oct 2019 12:12:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device" to the spi tree
In-Reply-To: <20190926105147.7839-8-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111225.44F652741CD7@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:25 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6c613f68aabf33385c01e949204ac5ed30887161 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:35 +0300
Subject: [PATCH] spi: core,atmel: convert `word_delay_usecs` -> `word_delay`
 for spi_device

This change does a conversion from the `word_delay_usecs` -> `word_delay`
for the `spi_device` struct.

This allows users to specify inter-word delays in other unit types
(nano-seconds or clock cycles), depending on how users want.

The Atmel SPI driver is the only current user of the `word_delay_usecs`
field (from the `spi_device` struct).
So, it needed a slight conversion to use the `word_delay` as an `spi_delay`
struct.

In SPI core, the only required mechanism is to update the `word_delay`
information per `spi_transfer`. This requires a bit more logic than before,
because it needs that both delays be converted to a common unit
(nano-seconds) for comparison.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-8-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 26 ++++++++++++++++++++++++--
 drivers/spi/spi.c       | 24 ++++++++++++++++++++++--
 include/linux/spi/spi.h |  7 ++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3ed5e663da6f..1471b049f99a 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1149,12 +1149,31 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static int atmel_word_delay_csr(struct spi_device *spi, struct atmel_spi *as)
+{
+	struct spi_delay *delay = &spi->word_delay;
+	u32 value = delay->value;
+
+	switch (delay->unit) {
+	case SPI_DELAY_UNIT_NSECS:
+		value /= 1000;
+		break;
+	case SPI_DELAY_UNIT_USECS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return (as->spi_clk / 1000000 * value) >> 5;
+}
+
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
 	struct atmel_spi_device	*asd;
 	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
+	int			word_delay_csr;
 
 	as = spi_master_get_devdata(spi->master);
 
@@ -1178,11 +1197,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 	 */
 	csr |= SPI_BF(DLYBS, 0);
 
+	word_delay_csr = atmel_word_delay_csr(spi, as);
+	if (word_delay_csr < 0)
+		return word_delay_csr;
+
 	/* DLYBCT adds delays between words.  This is useful for slow devices
 	 * that need a bit of time to setup the next transfer.
 	 */
-	csr |= SPI_BF(DLYBCT,
-			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
+	csr |= SPI_BF(DLYBCT, word_delay_csr);
 
 	asd = spi->controller_state;
 	if (!asd) {
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b69c14082c52..307e440dd92d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3281,6 +3281,26 @@ void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
+static int _spi_xfer_word_delay_update(struct spi_transfer *xfer,
+				       struct spi_device *spi)
+{
+	int delay1, delay2;
+
+	delay1 = _spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (delay1 < 0)
+		return delay1;
+
+	delay2 = _spi_delay_to_ns(&spi->word_delay, xfer);
+	if (delay2 < 0)
+		return delay2;
+
+	if (delay1 < delay2)
+		memcpy(&xfer->word_delay, &spi->word_delay,
+		       sizeof(xfer->word_delay));
+
+	return 0;
+}
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
@@ -3416,8 +3436,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 		}
 
-		if (xfer->word_delay_usecs < spi->word_delay_usecs)
-			xfer->word_delay_usecs = spi->word_delay_usecs;
+		if (_spi_xfer_word_delay_update(xfer, spi))
+			return -EINVAL;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6cb67ad53ffa..ebeb272aeb0f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -139,7 +139,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
- * @word_delay_usecs: microsecond delay to be inserted between consecutive
+ * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  *
  * @statistics: statistics for the spi_device
@@ -189,7 +189,7 @@ struct spi_device {
 	const char		*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
-	uint8_t			word_delay_usecs; /* inter-word delay */
+	struct spi_delay	word_delay; /* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -781,8 +781,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
- * @word_delay_usecs: microseconds to inter word delay after each word size
- *	(set by bits_per_word) transmission.
  * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
@@ -897,7 +895,6 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
-	u8		word_delay_usecs;
 	u16		delay_usecs;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
-- 
2.20.1

