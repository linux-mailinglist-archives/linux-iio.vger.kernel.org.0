Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925C446F74
	for <lists+linux-iio@lfdr.de>; Sat,  6 Nov 2021 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhKFRwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Nov 2021 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhKFRwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Nov 2021 13:52:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1673C061570;
        Sat,  6 Nov 2021 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=p98X60FllSP44Lbfdicz/g7B4IYhfi07lOm/UAWCN1c=; b=umtFtwq0MW5enSXh0Pn/RIqbVN
        oawwur3mMZgi/DqWLHGCdHV7oKPexxfJKKoIz0M3YsZRoiPcbQemcIFAGe+XfUb0FfZTPJRJsyMr1
        WwnOK4J4Q/i+25JMIgEtY9H3fYW/ZKhNOV7Y3M1+xeGnftO5gtRrFgvgz/M2itOjpwMC8TlOucxW0
        6kFDcHivssFjMSjqH/GHngXtNcYVkamgDXKpVLkuuEbAl6HgluivvUcIuOnRgfHrYja0G1yM/vLXX
        LzTCC3kABD0HJVsbkZVHsRINzyPxI2UlWJdd2Yz/6Ob1rKkrub9f+sK7ntez15hbO2uCF5kKKQTNh
        PCylU5yQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjPov-008ZcK-TE; Sat, 06 Nov 2021 17:49:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
Date:   Sat,  6 Nov 2021 10:49:32 -0700
Message-Id: <20211106174932.15676-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MIPS does not always provide clk*() interfaces and there are no
always-present stubs for them, so depending on "MIPS || COMPILE_TEST"
is not strong enough to prevent build errors.

Likewise MACH_INGENIC_SOC || COMPILE_TEST is not strong enough
since if only COMPILE_TEST=y (with some other MIPS MACH_ or CPU or
BOARD setting), there are still the same build errors.

It looks like depending on MACH_INGENIC_SOC is the only thing that is
sufficient here in order to prevent build errors.

mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'

Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Artur Rojek <contact@artur-rojek.eu>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211105.orig/drivers/iio/adc/Kconfig
+++ linux-next-20211105/drivers/iio/adc/Kconfig
@@ -501,7 +501,7 @@ config INA2XX_ADC
 
 config INGENIC_ADC
 	tristate "Ingenic JZ47xx SoCs ADC driver"
-	depends on MIPS || COMPILE_TEST
+	depends on MACH_INGENIC_SOC
 	select IIO_BUFFER
 	help
 	  Say yes here to build support for the Ingenic JZ47xx SoCs ADC unit.
