Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368DC52311A
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiEKLGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiEKLGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 07:06:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3056A1AD89
        for <linux-iio@vger.kernel.org>; Wed, 11 May 2022 04:06:12 -0700 (PDT)
Date:   Wed, 11 May 2022 13:06:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652267170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JNTkaL7CYGyZNj/Sj8koZSQng8dqdZ7jLKa+MBiBnRk=;
        b=dgIVoq4bjM6CFOjcRf9HApW92bQ2y3k0/SJlbS6OnG+3lWnUXPqa035mm53LesqbTVJmPJ
        tIUhTOFMM7eOEW4VydCbPdEiP7A3hsgdH2jE41sa9iWpqRXvQbVe/JuKcmoA6ezhlpBD/Z
        cqOcf037r+soY/s9/bzhJmaSKcbtepCXS9oL53LWWYozv6L8H2VIGHTtrFUFiHnU3nliLC
        DYKWeQZI3Xbqgk8DUIVmyd8u0HXrbn2vz97o35peKn2TBWzmVy7yYRyRr7ayk3lSDr4FW3
        ZSvoS1ZvvaMZW8V0nNYN9jM+6xv27sSBb7Jm7P8Knrcu6QFDVtgmDRxrarin7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652267170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JNTkaL7CYGyZNj/Sj8koZSQng8dqdZ7jLKa+MBiBnRk=;
        b=XYNZHjr/PZ4EoKKntKWBsm/WbrSJeOpdfr0XpqGcdUJ8SqXbM4Es/7EqV4jDflCErCR3nk
        NNg09sOiqA8lUfDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] iio: adc: stm32-adc: Use generic_handle_domain_irq()
Message-ID: <YnuYoQIzJoFIyEJY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The call chain
	generic_handle_irq(irq_find_mapping(domain, x));

could be replaced with
	generic_handle_domain_irq(domain, x);

which looks up the struct irq_desc for the interrupt and handles it with
handle_irq_desc().
This is a slight optimisation given that the driver invokes only one
function and the struct irq_desc is used directly instead being looked
up via irq_to_desc().

Use generic_handle_domain_irq().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/stm32-adc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 1426562321575..c8fc97e52fef4 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -356,7 +356,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
 		if ((status & priv->cfg->regs->eoc_msk[i] &&
 		     stm32_adc_eoc_enabled(priv, i)) ||
 		     (status & priv->cfg->regs->ovr_msk[i]))
-			generic_handle_irq(irq_find_mapping(priv->domain, i));
+			generic_handle_domain_irq(priv->domain, i);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.36.1

