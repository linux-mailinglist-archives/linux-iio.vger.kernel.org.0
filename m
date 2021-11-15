Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB544FC9A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhKOApS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 19:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhKOApS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 19:45:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE76C061746;
        Sun, 14 Nov 2021 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1rrDoX9rx2nIbDYY5ODkSZGdf+EFjop/YR8A27i56WY=; b=qpFCqfnl2+L09fF8a1XD9ip9xz
        DQqbtOAdIdBIjjtndEGe3842507v2WqJGNosHC2qtUlh7r/QZ2GQDiaj/76yaB56w8Xs9NJ+mNSgw
        FW61V1ILDTFOGrUUtDdL1uQ3nGepqv6mRFbtkyFyoEh/TZNE8o4i3/zJjwhw/sDMIhT1NgvLicfEv
        JKe7R4mX1te0apMP1AGntgHTw3EcyM1ek9afxgblr/WDttluduRTt0QZZh0ifi8w+54LmpV+qsGAN
        P9Dg9rvVS4quAuRGS3JUyfMZyvV03F0f6t1Hbd4Wl6Lbshb3Zry4ffRwMgj/H1Lwvi0mlQn4QXQyj
        GImTvy8Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmQ4h-00EC9L-F6; Mon, 15 Nov 2021 00:42:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4] mips: bcm63xx: add support for clk_get_parent()
Date:   Sun, 14 Nov 2021 16:42:18 -0800
Message-Id: <20211115004218.13034-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BCM63XX selects HAVE_LEGACY_CLK but does not provide/support
clk_get_parent(), so add a simple implementation of that
function so that callers of it will build without errors.

Fixes these build errors:

mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4770_adc_init_clk_div':
ingenic-adc.c:(.text+0xe4): undefined reference to `clk_get_parent'
mips-linux-ld: drivers/iio/adc/ingenic-adc.o: in function `jz4725b_adc_init_clk_div':
ingenic-adc.c:(.text+0x1b8): undefined reference to `clk_get_parent'

Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs." )
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: Artur Rojek <contact@artur-rojek.eu>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v1 and v2 were:
[PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
  (limiting this driver to MACH_INGENIC in Kconfig)
v3: add clk_get_parent() to arch/mips/bcm63xx/clk.c
v4:
  add Fixes:, Suggested-by:, Reviewed-by: Acked-by:
  drop blank line between function and EXPORT_SYMBOL(); (Andy)

 arch/mips/bcm63xx/clk.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
+++ linux-next-20211112/arch/mips/bcm63xx/clk.c
@@ -381,6 +381,12 @@ void clk_disable(struct clk *clk)
 
 EXPORT_SYMBOL(clk_disable);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	if (!clk)
