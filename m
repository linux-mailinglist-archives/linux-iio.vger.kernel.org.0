Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD37ED7459
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfJOLM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbfJOLM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ozxjDEuvmCR1qhM0gekOKO4P+Dq1BuOBLJHr+rFe3bo=; b=jAHArkMX56x3
        waR4ugKQSl7AkAoqMMpLWUyQAeT4xd7/v2/mR28vE8nRu2otWEzHDlUi1Q+ZqnZspDBKggEcOkVO4
        Q48Po77NVRnCTefr0vDAdnyDf3zt0BGsJoDgjNEzbsrxkwBqL15B9HpkxC6THCTNDs2oPOkmHq2X2
        1HR3k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkY-00020e-Ix; Tue, 15 Oct 2019 11:12:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 140C02741DCA; Tue, 15 Oct 2019 12:12:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: bcm63xx: extend error condition to `delay` as well" to the spi tree
In-Reply-To: <20190926105147.7839-19-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111222.140C02741DCA@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:22 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: bcm63xx: extend error condition to `delay` as well

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

From c5751ba0f71e3afe62000a9505915093efa31bd6 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:46 +0300
Subject: [PATCH] spi: bcm63xx: extend error condition to `delay` as well

The driver errors out if `delay_usecs` is non-zero. This error condition
should be extended to the new `delay` field, to account for when it will be
used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-19-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index fdd7eaa0b8ed..0f1b10a4ef0c 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -368,7 +368,7 @@ static int bcm63xx_spi_transfer_one(struct spi_master *master,
 		}
 
 		/* CS will be deasserted directly after transfer */
-		if (t->delay_usecs) {
+		if (t->delay_usecs || t->delay.value) {
 			dev_err(&spi->dev, "unable to keep CS asserted after transfer\n");
 			status = -EINVAL;
 			goto exit;
-- 
2.20.1

