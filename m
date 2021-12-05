Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29B468C3D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhLERAd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLERAc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E38C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA55B80EC2
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E260C00446;
        Sun,  5 Dec 2021 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723423;
        bh=G/fR1AijkDODlDRQIHr4Y3lzzkuCiHKfPtQhFkfMrfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktFPVXr9x6DmhC42BtAe8p3juSuY8pUf65P/bBPbAM0GjTRTqSIr0XTH3oMi3X216
         DuOYiBNpJzclpRLqm5e0bvubT78ejJ1pf222Ije0ZRUHBjKLBZg6OLiLNkAw5b43NK
         HEp5QRo2yuBylJHXxvdw1Lev3OI+lGRKN7a+6YgHxFwdEtPWfB4nfkD+Tmb2avaCdR
         ubOVyDUrAlM2ps2uo2aproTUl/K14rUCspnyRbewD16w7aBslr2zzVODRwLZ9yEqsm
         aEPl0y7BVLvIm0pfW0G0F+9JKi8PamiN+VvHnOO9toAHYx1g4OUwHqQwtg6jXIMEh6
         nI9etBjQJCBMw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 12/12] iio:adc/dac:Kconfig: Update to drop OF dependencies.
Date:   Sun,  5 Dec 2021 17:01:40 +0000
Message-Id: <20211205170140.2783914-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We could probably drop a lot more of these, but for now this removes
unnecessary restrictions on stand alone ADC devices.

For these 3 drivers the false dependency seems to date all
the way back to their initial introduction.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

v3: Added clarification that this is fixing old false dependencies.

drivers/iio/adc/Kconfig | 4 ++--
 drivers/iio/dac/Kconfig | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9b0b99bc826c..c7de4632f24a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1146,7 +1146,7 @@ config TI_ADS7950
 
 config TI_ADS8344
 	tristate "Texas Instruments ADS8344"
-	depends on SPI && OF
+	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADS8344
 	  ADC chips
@@ -1156,7 +1156,7 @@ config TI_ADS8344
 
 config TI_ADS8688
 	tristate "Texas Instruments ADS8688"
-	depends on SPI && OF
+	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADS8684 and
 	  and ADS8688 ADC chips
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 75e1f2b48638..ba6649a2d040 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -329,7 +329,6 @@ config MAX517
 config MAX5821
 	tristate "Maxim MAX5821 DAC driver"
 	depends on I2C
-	depends on OF
 	help
 	  Say yes here to build support for Maxim MAX5821
 	  10 bits DAC.
-- 
2.34.1

