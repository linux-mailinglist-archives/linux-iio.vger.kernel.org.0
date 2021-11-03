Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C223E4447B8
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhKCRwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 13:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhKCRwP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 13:52:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347FD608FB;
        Wed,  3 Nov 2021 17:49:37 +0000 (UTC)
Date:   Wed, 3 Nov 2021 17:54:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] iio: interrupt-trigger: Remove no-op trigger ops
Message-ID: <20211103175410.433505d9@jic23-huawei>
In-Reply-To: <20211031142130.20791-1-lars@metafoo.de>
References: <20211031142130.20791-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 15:21:22 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The IIO core handles a trigger ops with all NULL callbacks the
> same as if the trigger ops itself was NULL.
> 
> Remove the empty trigger ops from the interrupt trigger driver to slightly
> reduce the boilerplate code. Object size of the driver module is also
> slightly reduced.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Good spot - I was kind of assuming we didn't protect all call sites
but seems that we do so good to get rid of these

Series applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/iio-trig-interrupt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index f746c460bf2a..5f49cd105fae 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -25,9 +25,6 @@ static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
> -};
> -
>  static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  {
>  	struct iio_interrupt_trigger_info *trig_info;
> @@ -58,7 +55,6 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  	}
>  	iio_trigger_set_drvdata(trig, trig_info);
>  	trig_info->irq = irq;
> -	trig->ops = &iio_interrupt_trigger_ops;
>  	ret = request_irq(irq, iio_interrupt_trigger_poll,
>  			  irqflags, trig->name, trig);
>  	if (ret) {

