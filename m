Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA1D7477
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfJOLMc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfJOLMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ARKB+R9zHbI+0KX24UtACDYQgXcgSfTo14RFK2hAad4=; b=EUm1CNU4w5Az
        6jonVhvhcKbeKg3RZsQV6necCkwtd9WbScME//jT4QGu+/5pNiIdV0NfWherMt8nvWn1lJPUn4Jrq
        CiDm00+2Cy7z/Q/NUsygBhMOdkgL7NqLNXsbt0pLrZikSL8t72N47dNQOy7pVPhs35lkg8DZIPYJr
        G9sKY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKka-00021S-Up; Tue, 15 Oct 2019 11:12:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6B0342741CD7; Tue, 15 Oct 2019 12:12:24 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: tegra20-sflash: use to new `spi_transfer_delay_exec`" to the spi tree
In-Reply-To: <20190926105147.7839-12-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111224.6B0342741CD7@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:24 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: tegra20-sflash: use to new `spi_transfer_delay_exec`

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

From b883d5eda6c49a807e925b257bf9687d5c351004 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:39 +0300
Subject: [PATCH] spi: tegra20-sflash: use to new `spi_transfer_delay_exec`

This conversion to the spi_transfer_delay_exec() helper is not
straightforward, as it seems that when a delay is present, the controller
issues a command, and then a delay is followed.

This change adds support for the new `delay` field which is of type
`spi_delay` and keeps backwards compatibility with the old `delay_usecs`
field.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-12-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra20-sflash.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index a841a7250d14..514429379206 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -341,10 +341,11 @@ static int tegra_sflash_transfer_one_message(struct spi_master *master,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
-		if (xfer->cs_change && xfer->delay_usecs) {
+		if (xfer->cs_change &&
+		    (xfer->delay_usecs || xfer->delay.value)) {
 			tegra_sflash_writel(tsd, tsd->def_command_reg,
 					SPI_COMMAND);
-			udelay(xfer->delay_usecs);
+			spi_transfer_delay_exec(xfer);
 		}
 	}
 	ret = 0;
-- 
2.20.1

