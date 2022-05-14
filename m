Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17E527213
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiENOgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiENOgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 10:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595A21259
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 07:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6166C60F2F
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 14:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AECC340EE;
        Sat, 14 May 2022 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538961;
        bh=uj57vtgIPOPvjuF6jl0w79+fMTdHOb3k7GdpeKeNuFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uDJ1e0I+IuGnNXsYXn9MT6yOTbp9i9ohqx5z3X3Q6xajjsVEkqK/YZ6dNxJbQTUwk
         WcG0fbr3yfHmQG6fTWraNde56HxKiJVFuAbpf47UqSgU1BKLcLLqF5196Z7PfmQe4w
         Q90OtAvGqaG+CEEvjW3bgNs71K11CCpbkvw5h4oNNFdWvOV/lzX9VgCGeC/uUTivDh
         Z2BhE4tYoZt/UI0ex+xBCcjubBucyTBsQjv8ZgDLOASfSAJEyJCadlVtrJHeU6vhBP
         KG4Ul0y6tWVJbUtDuwegJOZg74BaMU5aC/WTWCOFV/WjS5h83rC3h0Cx+p+b5E1soJ
         3doc8VYLCEXsA==
Date:   Sat, 14 May 2022 15:44:36 +0100
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
Message-ID: <20220514154436.721f9cdd@jic23-huawei>
In-Reply-To: <YnuYoQIzJoFIyEJY@linutronix.de>
References: <YnuYoQIzJoFIyEJY@linutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Wed, 11 May 2022 13:06:09 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The call chain
> 	generic_handle_irq(irq_find_mapping(domain, x));
> 
> could be replaced with
> 	generic_handle_domain_irq(domain, x);
> 
> which looks up the struct irq_desc for the interrupt and handles it with
> handle_irq_desc().
> This is a slight optimisation given that the driver invokes only one
> function and the struct irq_desc is used directly instead being looked
> up via irq_to_desc().
> 
> Use generic_handle_domain_irq().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

+CC Fabrice, 

Fun following through the different checks in the two functions, but looks fine
to me.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find any problems.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/stm32-adc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 1426562321575..c8fc97e52fef4 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -356,7 +356,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
>  		if ((status & priv->cfg->regs->eoc_msk[i] &&
>  		     stm32_adc_eoc_enabled(priv, i)) ||
>  		     (status & priv->cfg->regs->ovr_msk[i]))
> -			generic_handle_irq(irq_find_mapping(priv->domain, i));
> +			generic_handle_domain_irq(priv->domain, i);
>  	}
>  
>  	chained_irq_exit(chip, desc);

