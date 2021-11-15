Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1555A44FCB7
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 02:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhKOBXx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 20:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhKOBXw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 20:23:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96917C061746;
        Sun, 14 Nov 2021 17:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xm2WaH1Ez4XZ9JuC8AhOwXIWdLRqdsdWoim4LFk92IY=; b=CBzkm4D3LOv1D4Xa4/t05C3Epc
        WB+wiGwxycYMzEJnNjlMOC15q0pfbZOLvPl06KOF2W9uQn8eI93FRTxERu0rHWllidrdQmaNc4KUV
        VTyJS8UJJ4WpDMShxvu2pNn4Y3ET7A1pAYvBUR7QDQ/8n6iVTFMxzHQzrGkwNJDnVa2Xfh2p+XwAu
        nsg+PHoIhbUUU9skqfoUxV1xyGjl/gnrsNFQNkwsLT/BKq7ie1JOFmpfMLKBFVN/5qNc53Mp8UTRm
        k5B9tS8hx6U3UoKwQtxHaikZcGjuv6WEJReehWSXEqN8WkPl4aLkuAQmuQtTHFKWIlgL5GH+acC37
        WZB8Bzpw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmQg0-00ECsh-Ks; Mon, 15 Nov 2021 01:20:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-mips@vger.kernel.org, John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] mips: lantiq: add support for clk_get_parent()
Date:   Sun, 14 Nov 2021 17:20:51 -0800
Message-Id: <20211115012051.16302-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Provide a simple implementation of clk_get_parent() in the
lantiq subarch so that callers of it will build without errors.

Fixes this build error:
ERROR: modpost: "clk_get_parent" [drivers/iio/adc/ingenic-adc.ko] undefined!

Fixes: 171bb2f19ed6 ("MIPS: Lantiq: Add initial support for Lantiq SoCs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: linux-mips@vger.kernel.org
Cc: John Crispin <john@phrozen.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/mips/lantiq/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20211112.orig/arch/mips/lantiq/clk.c
+++ linux-next-20211112/arch/mips/lantiq/clk.c
@@ -158,6 +158,12 @@ void clk_deactivate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_deactivate);
 
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 static inline u32 get_counter_resolution(void)
 {
 	u32 res;
