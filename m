Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1DD7491
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbfJOLNW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:13:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731758AbfJOLM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SS+GQ758n0tok8uAi2IAvQDQHUGGy2vhXECqaYim69w=; b=kPqwQP9DNq7E
        VaHOBsJXH0vFkEpWwMHD8fUI8HRV0Up+AQZghuDA3YnogwTAdmZxeF7IhYI3kQEb5ucd72xIbsBCy
        zWi1MMPuZdjGiD1Kx+z8RA2jis1acR+jgDzkKG2/IPBDI7WLEbIO5vHr5pPuJB22vvsi5Si5ln97V
        UuNCo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkZ-000210-O7; Tue, 15 Oct 2019 11:12:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3B81127419E4; Tue, 15 Oct 2019 12:12:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: tegra114: change format for `spi_set_cs_timing()` function" to the spi tree
In-Reply-To: <20190926105147.7839-15-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111223.3B81127419E4@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:23 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: tegra114: change format for `spi_set_cs_timing()` function

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

From 8105936684681195d9073880b06a123b2e316811 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:42 +0300
Subject: [PATCH] spi: tegra114: change format for `spi_set_cs_timing()`
 function

The initial version of `spi_set_cs_timing()` was implemented with
consideration only for clock-cycles as delay.

For cases like `CS setup` time, it's sometimes needed that micro-seconds
(or nano-seconds) are required, or sometimes even longer delays, for cases
where the device needs a little longer to start transferring that after CS
is asserted.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-15-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++++++--
 drivers/spi/spi.c          | 16 ++++++++++------
 include/linux/spi/spi.h    |  9 ++++++---
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8133dc49d34f..e6a450d9b4f0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -723,15 +723,31 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
-static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
-				       u8 hold_dly, u8 inactive_dly)
+static int tegra_spi_set_hw_cs_timing(struct spi_device *spi,
+				      struct spi_delay *setup,
+				      struct spi_delay *hold,
+				      struct spi_delay *inactive)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	u8 setup_dly, hold_dly, inactive_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
 	u32 inactive_cycles;
 	u8 cs_state;
 
+	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
+		dev_err(&spi->dev,
+			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
+			SPI_DELAY_UNIT_SCK);
+		return -EINVAL;
+	}
+
+	setup_dly = setup ? setup->value : 0;
+	hold_dly = hold ? hold->value : 0;
+	inactive_dly = inactive ? inactive->value : 0;
+
 	setup_dly = min_t(u8, setup_dly, MAX_SETUP_HOLD_CYCLES);
 	hold_dly = min_t(u8, hold_dly, MAX_SETUP_HOLD_CYCLES);
 	if (setup_dly && hold_dly) {
@@ -758,6 +774,8 @@ static void tegra_spi_set_hw_cs_timing(struct spi_device *spi, u8 setup_dly,
 		tspi->spi_cs_timing2 = spi_cs_timing;
 		tegra_spi_writel(tspi, spi_cs_timing, SPI_CS_TIMING2);
 	}
+
+	return 0;
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2e448078a117..6beeb363515c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3269,15 +3269,19 @@ EXPORT_SYMBOL_GPL(spi_setup);
 /**
  * spi_set_cs_timing - configure CS setup, hold, and inactive delays
  * @spi: the device that requires specific CS timing configuration
- * @setup: CS setup time in terms of clock count
- * @hold: CS hold time in terms of clock count
- * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ * @setup: CS setup time specified via @spi_delay
+ * @hold: CS hold time specified via @spi_delay
+ * @inactive: CS inactive delay between transfers specified via @spi_delay
+ *
+ * Return: zero on success, else a negative error code.
  */
-void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
-		       u8 inactive_dly)
+int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
+		      struct spi_delay *hold, struct spi_delay *inactive)
 {
 	if (spi->controller->set_cs_timing)
-		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+		return spi->controller->set_cs_timing(spi, setup, hold,
+						      inactive);
+	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fe5b85df2c79..f9b4ba2db08d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -524,8 +524,8 @@ struct spi_controller {
 	 * to configure specific CS timing through spi_set_cs_timing() after
 	 * spi_setup().
 	 */
-	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
-			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+	int (*set_cs_timing)(struct spi_device *spi, struct spi_delay *setup,
+			     struct spi_delay *hold, struct spi_delay *inactive);
 
 	/* bidirectional bulk transfers
 	 *
@@ -1068,7 +1068,10 @@ static inline void spi_message_free(struct spi_message *m)
 	kfree(m);
 }
 
-extern void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold, u8 inactive_dly);
+extern int spi_set_cs_timing(struct spi_device *spi,
+			     struct spi_delay *setup,
+			     struct spi_delay *hold,
+			     struct spi_delay *inactive);
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-- 
2.20.1

