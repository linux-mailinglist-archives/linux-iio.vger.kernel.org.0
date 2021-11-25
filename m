Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DEF45E08E
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhKYSe5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 13:34:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41605 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhKYSc4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 13:32:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 072925C01F9;
        Thu, 25 Nov 2021 13:29:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Nov 2021 13:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=TXkFOC5OLjUvrOgouPoCBJ79UU
        U8W1VbrggoBpuMqtI=; b=S9WHltksoi+93Q5d0dulhEZN5zTkYujE1263kHYWGS
        /EVMTdWJpsmHVfK5LRQchQ1BdvBI5B360Joq39GoYP85ELim+rDhU0mdVEMAXsNe
        Cplj0ayVJfxpGGWcvJPJPhDpVFEJdZIP/0MMVyRcLB7SSN9U703DTdZXbZByrZR1
        Fzn1khp4CPiwPNW5F2Qhbs9s/snWb/MMJxQg2eKP7oQJlrZw//oAEh1fP06LlaL5
        YWObT9hc4HbntxAPHvK1zXURxHE/P/ebYw4ljeAuMPFMrO+30sxQCp7cjLI06MmH
        xkIoA0DKIzMIsYmyJNIi1M1pgf3HjO24wxXMCGTH08lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TXkFOC5OLjUvrOgou
        PoCBJ79UUU8W1VbrggoBpuMqtI=; b=TYaMWbEppUXIGFU3bYuaC7VMr4KWvVSeS
        CjU/jdzTZQ9/5ooQM4XN00XpUnGfxphH9Vc5QrRbgjYLynqO09HBlUwoZa7qO3Ed
        7xu9HcrRAV6QqNKXs5cFJqQNCKLmba+xqUfVdSZD9ZZ1eWpPr9idyrrbDNC9zxxE
        xtFPU7Kgq6JDEjjw+ZU4ZLz8cNUS8eaGh4BWAiJwhrRBlTlWnJ/hzjY5GB0y1qiU
        N0428gqbtC95LFu+p5iY6najl9gYJQtitQS4EIprOgG7xKjcYO6cNQCVGk+Vvn8s
        QYrm2VoW88w6jvFnqVoUn2yQ/bI/94i5L9DrD9I7d5arszqmQqFng==
X-ME-Sender: <xms:F9afYVRupp2A9JLeyjYhd554wZadthg99FKKjKbpZthVrfLhPmHEJQ>
    <xme:F9afYeyNYnxmjkThWKOTJlHs4HgvljyrxXhfZhn4_ptSgrTEPXxw4v7HlbWkC4Miw
    EMWjkIttwnqzxG0bQ>
X-ME-Received: <xmr:F9afYa3NaPaHVKIkUQtoBXi_N0yzuhUk1VSSH-Foqc6WMEN4pItS0VH98_f5J5uU7aG7HOJlRydEhQ7Bth8gNVDvsM-9Jgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehvdffgf
    fhteeijefgteeftdfghfdvheeuhedvjedugfeggfeljefgleefvefgfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqhihlihhsshesgidvvd
    dtrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:F9afYdBsyPnqcolUtu8zUkKq44_d6urxheatugQ4rj0mNRgFgkXRSg>
    <xmx:F9afYej4HFisQcrSngoxvkeOYURdxMYVmf9x2vJg1PDRLjHK6Vm0bA>
    <xmx:F9afYRoHvbL3ySjcueb2gdbEin1LYRJhGJLMj6EOElgM_My4QG4g5Q>
    <xmx:GNafYXV7SqwwO-mSP7AEnbZme6j8UrZyyaL63hlJJ0ztbV2VTDTuSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 13:29:43 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 1AB5D13E2; Thu, 25 Nov 2021 18:29:41 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alyssa Ross <hi@alyssa.is>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: trigger: stm32-timer: fix MODULE_ALIAS
Date:   Thu, 25 Nov 2021 18:28:48 +0000
Message-Id: <20211125182850.2645424-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

modprobe can't handle spaces in aliases.

Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 33083877cd19..4353b749ecef 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -912,6 +912,6 @@ static struct platform_driver stm32_timer_trigger_driver = {
 };
 module_platform_driver(stm32_timer_trigger_driver);
 
-MODULE_ALIAS("platform: stm32-timer-trigger");
+MODULE_ALIAS("platform:stm32-timer-trigger");
 MODULE_DESCRIPTION("STMicroelectronics STM32 Timer Trigger driver");
 MODULE_LICENSE("GPL v2");
-- 
2.33.0

