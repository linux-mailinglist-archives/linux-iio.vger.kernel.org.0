Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC521CF955
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgELPhR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 11:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgELPhR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 May 2020 11:37:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D895206CC;
        Tue, 12 May 2020 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589297836;
        bh=1O6ZykHvXDJEczjrH9LJuh8X1yHOP7Q/30u8pa72BCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqwakY8meehODH74gpckFTa+Mh+b6xO0w7sFxmlOy9XVG4nwxGnTy6d/fTPn2KKM2
         FpnaUhXQ4zcFpBOJudkbcySubJ2+F+jCEnuxGUDYz6Hh3Axo6CPTcFQ7NCAH24bj08
         0hH/vzANpANCy0xlayV1dZeLa4UcnByWyMsY1C90=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jYWy2-00Bh0h-Rd; Tue, 12 May 2020 16:37:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 May 2020 16:37:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/2] irq/irq_sim: simplify the API
In-Reply-To: <20200430143019.1704-3-brgl@bgdev.pl>
References: <20200430143019.1704-1-brgl@bgdev.pl>
 <20200430143019.1704-3-brgl@bgdev.pl>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6568919d6cc3ee8f602a58354e3aff44@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: brgl@bgdev.pl, linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, tglx@linutronix.de, jason@lakedaemon.net, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, bgolaszewski@baylibre.com, Jonathan.Cameron@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Bartosz,

On 2020-04-30 15:30, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The interrupt simulator API exposes a lot of custom data structures and
> functions and doesn't reuse the interfaces already exposed by the irq
> subsystem. This patch tries to address it.
> 
> We hide all the simulator-related data structures from users and 
> instead
> rely on the well-known irq domain. When creating the interrupt 
> simulator
> the user receives a pointer to a newly created irq_domain and can use 
> it
> to create mappings for simulated interrupts.
> 
> It is also possible to pass a handle to fwnode when creating the 
> simulator
> domain and retrieve it using irq_find_matching_fwnode().
> 
> The irq_sim_fire() function now only takes the virtual interrupt number
> as argument - there's no need anymore to pass it any data structure 
> linked
> to the simulator.
> 
> We modify the two modules that use the simulator at the same time as
> adding these changes in order to reduce the intermediate bloat that 
> would
> result when trying to migrate the drivers in separate patches.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for IIO
> ---
>  drivers/gpio/gpio-mockup.c          |  47 ++++--
>  drivers/iio/dummy/iio_dummy_evgen.c |  32 ++--
>  include/linux/irq_sim.h             |  34 ++---
>  kernel/irq/Kconfig                  |   1 +
>  kernel/irq/irq_sim.c                | 225 +++++++++++++++++-----------
>  5 files changed, 202 insertions(+), 137 deletions(-)

[...]

>  /**
>   * irq_sim_fire - Enqueue an interrupt.
>   *
> - * @sim:        The interrupt simulator object.
> - * @offset:     Offset of the simulated interrupt which should be 
> fired.
> + * @virq:       Virtual interrupt number to fire. It must be 
> associated with
> + *              an existing interrupt simulator.
>   */
> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
> +void irq_sim_fire(int virq)
>  {
> -	if (sim->irqs[offset].enabled) {
> -		set_bit(offset, sim->work_ctx.pending);
> -		irq_work_queue(&sim->work_ctx.work);
> +	struct irq_sim_irq_ctx *irq_ctx;
> +	struct irq_data *irqd;
> +
> +	irqd = irq_get_irq_data(virq);
> +	if (!irqd) {
> +		pr_warn_ratelimited("%s: invalid irq number\n", __func__);
> +		return;
>  	}
> -}
> -EXPORT_SYMBOL_GPL(irq_sim_fire);
> 
> -/**
> - * irq_sim_irqnum - Get the allocated number of a dummy interrupt.
> - *
> - * @sim:        The interrupt simulator object.
> - * @offset:     Offset of the simulated interrupt for which to 
> retrieve
> - *              the number.
> - */
> -int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
> -{
> -	return sim->irqs[offset].irqnum;
> +	irq_ctx = irq_data_get_irq_chip_data(irqd);
> +
> +	if (irq_ctx->enabled) {
> +		set_bit(irqd_to_hwirq(irqd), irq_ctx->work_ctx->pending);
> +		irq_work_queue(&irq_ctx->work_ctx->work);
> +	}
>  }
> -EXPORT_SYMBOL_GPL(irq_sim_irqnum);
> +EXPORT_SYMBOL_GPL(irq_sim_fire);

Rather than using an ad-hoc API to queue an interrupt, why don't you
actually implement the interface that already exists for this at
the irqchip level (irq_set_irqchip_state, which allows the pending
state to be set)?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
