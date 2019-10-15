Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70AD746B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfJOLMl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbfJOLMl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HxCw+GrSFAjIDABzZL5hlFUSN3/Z4sQnIyk1p1c3V9o=; b=xg2pQfOmcooJ
        4JAirHEZx2LJXvvRwu2jLT98sArjuGfJ6Vv2q2DBDgRJzElWIwXgR3VYyzJ0hyuPpWnp9cDidcvRy
        42aD6hF4rIWxagTMPBJpvh2aYxO9OVBAdLfthyE2/wVSowC1NKzQ0hGShSRLPMJB7JUjwasETD8/Z
        tmNJw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkf-000234-Ec; Tue, 15 Oct 2019 11:12:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E15C92741DCA; Tue, 15 Oct 2019 12:12:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: move `cs_change_delay` backwards compat logic outside switch" to the spi tree
In-Reply-To: <20190926105147.7839-2-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111228.E15C92741DCA@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:28 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: move `cs_change_delay` backwards compat logic outside switch

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

From 6b3f236a998550dba91a46a22feb1cc02f39fb06 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:29 +0300
Subject: [PATCH] spi: move `cs_change_delay` backwards compat logic outside
 switch

The `cs_change_delay` backwards compatibility value could be moved outside
of the switch statement.
The only reason to do it, is to make the next patches easier to diff.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-2-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9bb36c32cbf9..7ba981cdb86b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,16 +1114,15 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 	u32 hz;
 
 	/* return early on "fast" mode - for everything but USECS */
-	if (!delay && unit != SPI_DELAY_UNIT_USECS)
+	if (!delay) {
+		if (unit == SPI_DELAY_UNIT_USECS)
+			_spi_transfer_delay_ns(10000);
 		return;
+	}
 
 	switch (unit) {
 	case SPI_DELAY_UNIT_USECS:
-		/* for compatibility use default of 10us */
-		if (!delay)
-			delay = 10000;
-		else
-			delay *= 1000;
+		delay *= 1000;
 		break;
 	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
 		break;
-- 
2.20.1

