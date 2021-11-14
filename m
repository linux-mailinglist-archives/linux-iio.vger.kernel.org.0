Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97B444F911
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhKNQhq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 11:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhKNQhp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 11:37:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528EC061746;
        Sun, 14 Nov 2021 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OUXnxEsE3vKg0RZs07T16Pv1PQAOQdxWCDDV7x9zuxs=; b=0vF2S7KfVGtQBCp10pux0sTZOQ
        cOS+NOVpF1UZWvRgCKUJ2RFu2bsG42Dd1mX6JSO4HM+SJ3y0+Sk2H/1LVTPTfjJBOEjzApzekvNnz
        CJcY8hnskK0kIXEKzpLNCvzJtJSDLEqqpHBsXxCzC/AhlY7Fg8Qx1lLvNf3BY9GGRx6xk/+YX0WFO
        bv4nzEwUXlfmKbje3wSBPPzEknkyPOz07ikNQAs6565ucRA8cOJ3XhRnVfbSND4LcYiAnGlG6J2qq
        cnZyJ4AEKm3PJjpiTEoNtPWiDmQY+91J4fLGtQGhKdtfCb22Xm5NAG6d0Aebuncvs5WaynrHRJBaz
        GY7kF8Lw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmISs-00DqEd-SR; Sun, 14 Nov 2021 16:34:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH v3] mips: bcm63xx: add support for clk_get_parent()
Date:   Sun, 14 Nov 2021 08:34:44 -0800
Message-Id: <20211114163444.21669-1-rdunlap@infradead.org>
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
Cc: Russell King <linux@armlinux.org.uk>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 and v2 were:
[PATCH] iio/adc: ingenic: fix (MIPS) ingenic-adc build errors
Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")

 arch/mips/bcm63xx/clk.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-next-20211112.orig/arch/mips/bcm63xx/clk.c
+++ linux-next-20211112/arch/mips/bcm63xx/clk.c
@@ -381,6 +381,13 @@ void clk_disable(struct clk *clk)
 
 EXPORT_SYMBOL(clk_disable);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return NULL;
+}
+
+EXPORT_SYMBOL(clk_get_parent);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	if (!clk)
