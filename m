Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB9D7494
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfJOLM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 07:12:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50386 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbfJOLM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 07:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=h+cPmi6fQIEbZL1+N7ZA2YRo1U+Xr0XfjyL5BfqY5ag=; b=nTZjYiV/Hkfl
        QA2Ep8WtR3Uld9seLnhx/FX1mo3nhZ5tnVSQ8D9gUGrKL2N4J+c56A/N3ZEThZ3EgQT3uUMSirp4m
        X8WnW1uIplrlFFGJfF87S/2ub7drGsRCx1hRK+90CaSxslA8vmg4Hj+/layIu09Qysxxcgk+VOPex
        BmTjI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iKKkZ-00020j-19; Tue, 15 Oct 2019 11:12:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 596EB27419E4; Tue, 15 Oct 2019 12:12:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "spi: spi-falcon: extend warning to `delay` as well" to the spi tree
In-Reply-To: <20190926105147.7839-18-alexandru.ardelean@analog.com>
X-Patchwork-Hint: ignore
Message-Id: <20191015111222.596EB27419E4@ypsilon.sirena.org.uk>
Date:   Tue, 15 Oct 2019 12:12:22 +0100 (BST)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch

   spi: spi-falcon: extend warning to `delay` as well

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

From 3e2405f01f4a1e744f2bea28aa105d7f2257c893 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:45 +0300
Subject: [PATCH] spi: spi-falcon: extend warning to `delay` as well

The WARN_ON macro prints a warning in syslog if `delay_usecs` is non-zero.
However, with the new intermediate `delay`, the warning should also be
printed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-18-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 00f46c816a56..d3336a63f462 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -377,7 +377,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 
 		m->actual_length += t->len;
 
-		WARN_ON(t->delay_usecs || t->cs_change);
+		WARN_ON(t->delay_usecs || t->delay.value || t->cs_change);
 		spi_flags = 0;
 	}
 
-- 
2.20.1

