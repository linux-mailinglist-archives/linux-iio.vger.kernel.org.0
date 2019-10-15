Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67BD74A2
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJOLNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:13:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbfJOLM2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sM7E8taO+faCX1B08W8bz1doM9EMVFx0kjcSL7W4bos=; b=Im4sf9CqkWHp
        mxoldhr3R0kBLyeAxNQS4R5lsFBSqqwL85EeL2CQZ5Vb2cXaaIQSToWzqAw8VC9CRYWslE2gA55YT
        eMTQMl0oVsc2ThniTsjucqHuAnJEJGwlDUkBtYe9hiLyiWZYC7XYSw2rgxT89c6spHK38smJMP4Eu
        x4UaM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkY-00020b-AU; Tue, 15 Oct 2019 11:12:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CAFB92741CD7; Tue, 15 Oct 2019 12:12:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: spi-axi: extend support for the `delay` field" to the spi tree
In-Reply-To: <20190926105147.7839-20-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111221.CAFB92741CD7@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:21 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: spi-axi: extend support for the `delay` field

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

From acc7720de3cb9721ac07f68309dd6d7aae8e9a7a Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:47 +0300
Subject: [PATCH] spi: spi-axi: extend support for the `delay` field

The AXI SPI engine driver uses the `delay_usecs` field from `spi_transfer`
to configure delays, which the controller will execute.
This change extends the logic to also include the `delay` value, in case it
is used (instead if `delay_usecs`).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-20-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 74842f6019ed..eb9b78a90dcf 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -163,10 +163,21 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-	struct spi_engine *spi_engine, unsigned int clk_div, unsigned int delay)
+	struct spi_engine *spi_engine, unsigned int clk_div,
+	struct spi_transfer *xfer)
 {
 	unsigned int spi_clk = clk_get_rate(spi_engine->ref_clk);
 	unsigned int t;
+	int delay;
+
+	if (xfer->delay_usecs) {
+		delay = xfer->delay_usecs;
+	} else {
+		delay = spi_delay_to_ns(&xfer->delay, xfer);
+		if (delay < 0)
+			return;
+		delay /= 1000;
+	}
 
 	if (delay == 0)
 		return;
@@ -218,8 +229,7 @@ static int spi_engine_compile_message(struct spi_engine *spi_engine,
 			spi_engine_gen_cs(p, dry, spi, true);
 
 		spi_engine_gen_xfer(p, dry, xfer);
-		spi_engine_gen_sleep(p, dry, spi_engine, clk_div,
-			xfer->delay_usecs);
+		spi_engine_gen_sleep(p, dry, spi_engine, clk_div, xfer);
 
 		cs_change = xfer->cs_change;
 		if (list_is_last(&xfer->transfer_list, &msg->transfers))
-- 
2.20.1

