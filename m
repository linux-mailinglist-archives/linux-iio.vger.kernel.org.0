Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152433D1210
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhGUOdA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jul 2021 10:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239459AbhGUOc6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jul 2021 10:32:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABD1A61019;
        Wed, 21 Jul 2021 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626880415;
        bh=ZpXSFxbdmmtXubwHT8SiJge7QzFLPxH/DKFpzEzryX0=;
        h=From:To:Cc:Subject:Date:From;
        b=Qq2FtaQYOk7Om3Cvdg9fj2hsf/LZz5vwc64Ms+OCDqViCECTtjypkyOUeQpjbXUC9
         N1fe3E0z/xtpWgSmD+UMmv0vzfuryzVHcRwaOdjEQ091/Ist5K8h80Zrg5MAZaH+kA
         z8gHDP6Gq4syOHNn+QwQ6XTRCg7p/LUcrg+xJ43HmJ00sY3lNNQnMkdzjjLKyqgw3a
         dPQX7PAIlPC2J8SiVJrN8WNYWMOFUDMcSZme06M2V2OPQCUaof4DmCdtvy9VexVylq
         H2JTnExau1nVKqJuPiJ5tmTuJpgIwB633DPxVhdmqX84oUiFXepaDbgmRW+HcrPUwj
         sobForTXPqNAQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean@geanix.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: fxls8962af: fix i2c dependency
Date:   Wed, 21 Jul 2021 17:13:20 +0200
Message-Id: <20210721151330.2176653-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With CONFIG_SPI=y and CONFIG_I2C=m, building fxls8962af into vmlinux
causes a link error against the I2C module:

aarch64-linux-ld: drivers/iio/accel/fxls8962af-core.o: in function `fxls8962af_fifo_flush':
fxls8962af-core.c:(.text+0x3a0): undefined reference to `i2c_verify_client'

Work around it by adding a Kconfig dependency that forces the SPI driver
to be a loadable module whenever I2C is a module.

Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not overly happy with the fix either, but couldn't think of
a better idea. If someone provide a different fix, please ignore
mine.
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 0e56ace61103..8d8b1ba42ff8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -231,6 +231,7 @@ config DMARD10
 
 config FXLS8962AF
 	tristate
+	depends on I2C || !I2C # cannot be built-in for modular I2C
 
 config FXLS8962AF_I2C
 	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
@@ -247,6 +248,7 @@ config FXLS8962AF_I2C
 config FXLS8962AF_SPI
 	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer SPI Driver"
 	depends on SPI
+	depends on I2C || !I2C
 	select FXLS8962AF
 	select REGMAP_SPI
 	help
-- 
2.29.2

