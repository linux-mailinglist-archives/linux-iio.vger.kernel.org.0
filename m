Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1215D7499
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfJOLNW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:13:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbfJOLM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1DVh9UecgU3Om0hFKJyJzEeWH8DVtuUEIaWKy+MoWsU=; b=RmpxbFRFtO0q
        qzCPcOfZMyyV6hHCr8XsBUAwEEsDrwfVD3JZrsoCOMLE1iX8iY7xnQxEfN13D3Uc2gWlwTDIJ5WTY
        n9Ukkac2qxjVg74uPyfkyDOZVmglFzfD79I5dWvSK80HVRAjthW/xfQcunojJgFA7L5vLtp3G2nR5
        zTn5A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkZ-00020s-Gl; Tue, 15 Oct 2019 11:12:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EA4622741DCA; Tue, 15 Oct 2019 12:12:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: implement SW control for CS times" to the spi tree
In-Reply-To: <20190926105147.7839-16-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111222.EA4622741DCA@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:22 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: implement SW control for CS times

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

From 25093bdeb6bcae728e12e3795261dbd3677060a9 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:43 +0300
Subject: [PATCH] spi: implement SW control for CS times

This change implements CS control for setup, hold & inactive delays.

The `cs_setup` delay is completely new, and can help with cases where
asserting the CS, also brings the device out of power-sleep, where there
needs to be a longer (than usual), before transferring data.

The `cs_hold` time can overlap with the `delay` (or `delay_usecs`) from an
SPI transfer. The main difference is that `cs_hold` implies that CS will be
de-asserted.

The `cs_inactive` delay does not have a clear use-case yet. It has been
implemented mostly because the `spi_set_cs_timing()` function implements
it. To some degree, this could overlap or replace `cs_change_delay`, but
this will require more consideration/investigation in the future.

All these delays have been added to the `spi_controller` struct, as they
would typically be configured by calling `spi_set_cs_timing()` after an
`spi_setup()` call.

Software-mode for CS control, implies that the `set_cs_timing()` hook has
not been provided for the `spi_controller` object.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-16-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 45 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  5 +++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6beeb363515c..21628b0728f1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,6 +775,15 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
+	bool enable1 = enable;
+
+	if (!spi->controller->set_cs_timing) {
+		if (enable1)
+			spi_delay_exec(&spi->controller->cs_setup, NULL);
+		else
+			spi_delay_exec(&spi->controller->cs_hold, NULL);
+	}
+
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
@@ -800,6 +809,11 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
+
+	if (!spi->controller->set_cs_timing) {
+		if (!enable1)
+			spi_delay_exec(&spi->controller->cs_inactive, NULL);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
@@ -3278,10 +3292,39 @@ EXPORT_SYMBOL_GPL(spi_setup);
 int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 		      struct spi_delay *hold, struct spi_delay *inactive)
 {
+	size_t len;
+
 	if (spi->controller->set_cs_timing)
 		return spi->controller->set_cs_timing(spi, setup, hold,
 						      inactive);
-	return -ENOTSUPP;
+
+	if ((setup && setup->unit == SPI_DELAY_UNIT_SCK) ||
+	    (hold && hold->unit == SPI_DELAY_UNIT_SCK) ||
+	    (inactive && inactive->unit == SPI_DELAY_UNIT_SCK)) {
+		dev_err(&spi->dev,
+			"Clock-cycle delays for CS not supported in SW mode\n");
+		return -ENOTSUPP;
+	}
+
+	len = sizeof(struct spi_delay);
+
+	/* copy delays to controller */
+	if (setup)
+		memcpy(&spi->controller->cs_setup, setup, len);
+	else
+		memset(&spi->controller->cs_setup, 0, len);
+
+	if (hold)
+		memcpy(&spi->controller->cs_hold, hold, len);
+	else
+		memset(&spi->controller->cs_hold, 0, len);
+
+	if (inactive)
+		memcpy(&spi->controller->cs_inactive, inactive, len);
+	else
+		memset(&spi->controller->cs_inactive, 0, len);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f9b4ba2db08d..cfd87b18f077 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -609,6 +609,11 @@ struct spi_controller {
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
 
+	/* CS delays */
+	struct spi_delay	cs_setup;
+	struct spi_delay	cs_hold;
+	struct spi_delay	cs_inactive;
+
 	/* gpio chip select */
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
-- 
2.20.1

