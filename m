Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215A7D74A0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfJOLNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:13:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50450 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfJOLM2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MgY4bxFY17PHIsD8EZBTx9xqaC4wci+W07NNCCTrDxg=; b=VwP6mNLys83T
        EwBLJHsdCOVbIVn37RACoo2clg2uiG8A75BZCWyB8SkdNmik8S3qKBqyu9p3lifRyVwlk5El3NuqH
        j7ZLSxWvsmkOvsrkqJClQ25fp6J8yTQ43dk/RHxMcwvzByv3WmEbGcMZky64KIeD/4jvJUw83VMXe
        RJgEI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKka-00021B-7B; Tue, 15 Oct 2019 11:12:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A18602741CD7; Tue, 15 Oct 2019 12:12:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: spidev: use new `delay` field for spi transfers" to the spi tree
In-Reply-To: <20190926105147.7839-14-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111223.A18602741CD7@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:23 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: spidev: use new `delay` field for spi transfers

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

From 8e319dd5f1ebbc1fffa9e550b2a643cbce7515b1 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:41 +0300
Subject: [PATCH] spi: spidev: use new `delay` field for spi transfers

The `delay` field has type `struct spi_delay`.
This allows users to specify nano-second or clock-cycle delays (if needed).

Converting to use `delay` is straightforward: it's just assigning the
value to `delay.value` and hard-coding the `delay.unit` to
`SPI_DELAY_UNIT_USECS`.

This keeps the uapi for spidev un-changed. Changing it can be part of
another changeset and discussion.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-14-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index d63235dcb231..1e217e3e9486 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -265,7 +265,8 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->tx_nbits = u_tmp->tx_nbits;
 		k_tmp->rx_nbits = u_tmp->rx_nbits;
 		k_tmp->bits_per_word = u_tmp->bits_per_word;
-		k_tmp->delay_usecs = u_tmp->delay_usecs;
+		k_tmp->delay.value = u_tmp->delay_usecs;
+		k_tmp->delay.unit = SPI_DELAY_UNIT_USECS;
 		k_tmp->speed_hz = u_tmp->speed_hz;
 		k_tmp->word_delay.value = u_tmp->word_delay_usecs;
 		k_tmp->word_delay.unit = SPI_DELAY_UNIT_USECS;
-- 
2.20.1

