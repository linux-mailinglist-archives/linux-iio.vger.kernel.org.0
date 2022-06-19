Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A662550C05
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiFSQMY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSQMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 12:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117A644A
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 09:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 571D9611E3
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 16:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F15C34114;
        Sun, 19 Jun 2022 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655655140;
        bh=+ZdKPuYReGipTUHwHK+MrO06eN99QYR8e7WNYpKsknw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVC1sLcrL97eha9NI2Du/DtxnMe6MsoWoH8YWJIJQlVLY1KSLQPBDYW251NT7ujr0
         xRxoKFARuolCAjgHEXeO/OKJfsWLrx/vXu22LGl5HAjz/ES6NmkBVQATGK7+Uy9+TF
         vhCt61ALUcIe6/YPEW/V+ERuVZcDaKcObadqQINpqCW0gPIl+caEVsF3IT6GNXMmhX
         HfZ/Y59O8rFQj5jpYZop+IXyhxCowkwz1mKem9T/n909TDrSQ0x3whg78GvVXgMHzk
         eF26SP46QCx2DmWShpxW++/vvYM18fSrYcntH0eSfdit50dGGxjkOhcREIWC9Vo1T2
         /khQQ++vRFlMQ==
Date:   Sun, 19 Jun 2022 17:21:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: Use generic_handle_domain_irq()
Message-ID: <20220619172137.1d5c7de2@jic23-huawei>
In-Reply-To: <20220514154436.721f9cdd@jic23-huawei>
References: <YnuYoQIzJoFIyEJY@linutronix.de>
        <20220514154436.721f9cdd@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 May 2022 15:44:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 11 May 2022 13:06:09 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > The call chain
> > 	generic_handle_irq(irq_find_mapping(domain, x));
> > 
> > could be replaced with
> > 	generic_handle_domain_irq(domain, x);
> > 
> > which looks up the struct irq_desc for the interrupt and handles it with
> > handle_irq_desc().
> > This is a slight optimisation given that the driver invokes only one
> > function and the struct irq_desc is used directly instead being looked
> > up via irq_to_desc().
> > 
> > Use generic_handle_domain_irq().
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>  
> 
> +CC Fabrice, 
> 
> Fun following through the different checks in the two functions, but looks fine
> to me.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> 0-day to see if it can find any problems.

oops. I applied this to the fixes-togreg branch of iio.git.  Will have
to rebase that to drop it.

Now applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 1426562321575..c8fc97e52fef4 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -356,7 +356,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
> >  		if ((status & priv->cfg->regs->eoc_msk[i] &&
> >  		     stm32_adc_eoc_enabled(priv, i)) ||
> >  		     (status & priv->cfg->regs->ovr_msk[i]))
> > -			generic_handle_irq(irq_find_mapping(priv->domain, i));
> > +			generic_handle_domain_irq(priv->domain, i);
> >  	}
> >  
> >  	chained_irq_exit(chip, desc);  
> 

