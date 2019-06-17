Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114A1488BF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfFQQV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 12:21:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35446 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jun 2019 12:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I+3dZymZ36bDT+SYPOPtFYrTLqbyyrx6FBC7YcP64m4=; b=pyZwABOhiF03uQ7pO88KTepolG
        gJfIgqubE3Xu7VCulG5ILy+0XOzm1hQ5rRiurXcbjmtXZsEGtuSCCZ7JU1m8lH/MiZa5KvSc8lCAG
        Ka/rLuHfNZutgYB/mKm+BhrkD+zuJujVaiwFvoKSM8hBRAVgQfMpqUJ7Kqu9+e17IT4x3dNc8m2rX
        tb7v90vmBb6JtltQhMzZuafvyWNaEQpBZvMsUH3XUas8nh7CaR4ullem0UdebRSItFmJ2BADFJA3v
        LM0ZSY+bUGWhGS4xg4Ga4Gf3cIgJS1bUb903//initn9ID+heZhXn94u8tpFMLuidvLqnpTPuzdeN
        +QqnFq7w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcuO7-0000qD-OH; Mon, 17 Jun 2019 16:21:44 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kjeld Flarup <kfa@deif.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Richard Weinberger <richard@nod.at>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] counter: fix ftm-quaddec build error on UML
Message-ID: <e33254e5-3e8e-fc86-de72-b3dd2f6c310c@infradead.org>
Date:   Mon, 17 Jun 2019 09:21:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error on user-mode Linux, which does not set HAS_IOMEM,
so devm_ioremap() is not available.  Fixes this build error:

ERROR: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!

Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kjeld Flarup <kfa@deif.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
---
BTW, please fix these lines to have ending '>' characters:
MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");

 drivers/counter/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-52-rc5.orig/drivers/counter/Kconfig
+++ lnx-52-rc5/drivers/counter/Kconfig
@@ -51,6 +51,7 @@ config STM32_LPTIMER_CNT
 
 config FTM_QUADDEC
 	tristate "Flex Timer Module Quadrature decoder driver"
+	depends on HAS_IOMEM
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
 	  driver.


