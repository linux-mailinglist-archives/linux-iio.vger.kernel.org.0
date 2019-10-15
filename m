Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73FDD7462
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfJOLMj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731757AbfJOLMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hcgiqdEyI9PH+KFyB4vAYOotphpi9n8TG47zzpEovkw=; b=pvMUQoEXcckW
        TRyel8KX6H7ubLdWla3JdIS+IhrM8474tKseujZ4Nzecig0d4ZBeMK1CwudMNGlSTXzMcjSxWRHIs
        Y500ow0mZlVobwiMB9ylRtHn9m5QykkHrwpPBof8ag11jiEvBTDx5WAutdBp+KXUba7NfJ+1NT52l
        GmWzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKke-00022m-Tk; Tue, 15 Oct 2019 11:12:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 604662741CD7; Tue, 15 Oct 2019 12:12:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: make `cs_change_delay` the first user of the `spi_delay` logic" to the spi tree
In-Reply-To: <20190926105147.7839-4-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111228.604662741CD7@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:28 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: make `cs_change_delay` the first user of the `spi_delay` logic

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

From 329f0dac4cad9fa4b1439a88180d91bcb5c4eaf8 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:31 +0300
Subject: [PATCH] spi: make `cs_change_delay` the first user of the `spi_delay`
 logic

Since the logic for `spi_delay` struct + `spi_delay_exec()` has been copied
from the `cs_change_delay` logic, it's natural to make this delay, the
first user.

The `cs_change_delay` logic requires that the default remain 10 uS, in case
it is unspecified/unconfigured. So, there is some special handling needed
to do that.

The ADIS library is one of the few users of the new `cs_change_delay`
parameter for an spi_transfer.

The introduction of the `spi_delay` struct, requires that the users of of
`cs_change_delay` get an update. This change also updates the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-4-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/imu/adis.c  | 24 ++++++++++++------------
 drivers/spi/spi.c       | 28 +++++++---------------------
 include/linux/spi/spi.h |  4 +---
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..2cd2cc2316c6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7499a4efbaba..b69c14082c52 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,9 +1160,9 @@ EXPORT_SYMBOL_GPL(spi_delay_exec);
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
-	u32 delay = xfer->cs_change_delay;
-	u32 unit = xfer->cs_change_delay_unit;
-	u32 hz;
+	u32 delay = xfer->cs_change_delay.value;
+	u32 unit = xfer->cs_change_delay.unit;
+	int ret;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay) {
@@ -1171,27 +1171,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		return;
 	}
 
-	switch (unit) {
-	case SPI_DELAY_UNIT_USECS:
-		delay *= 1000;
-		break;
-	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
-		break;
-	case SPI_DELAY_UNIT_SCK:
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
-		 */
-		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
-		delay *= DIV_ROUND_UP(1000000000, hz);
-		break;
-	default:
+	ret = spi_delay_exec(&xfer->cs_change_delay, xfer);
+	if (ret) {
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
-			     xfer->cs_change_delay_unit);
-		delay = 10000;
+			     unit);
+		_spi_transfer_delay_ns(10000);
 	}
-	/* now sleep for the requested amount of time */
-	_spi_transfer_delay_ns(delay);
 }
 
 /*
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8f643de3197b..7670be934643 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -778,7 +778,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
- * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -900,8 +899,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u8		word_delay_usecs;
 	u16		delay_usecs;
-	u16		cs_change_delay;
-	u8		cs_change_delay_unit;
+	struct spi_delay	cs_change_delay;
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

