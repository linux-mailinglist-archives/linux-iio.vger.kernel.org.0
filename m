Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57A342D76
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 15:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCTOyN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 10:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229546AbhCTOyA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:54:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4BEC61929;
        Sat, 20 Mar 2021 14:53:57 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:53:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Pavel Andrianov <andrianov@ispras.ru>,
        ldv-project@linuxtesting.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A potential data race in drivers/iio/adc/berlin2-adc.ko
Message-ID: <20210320145353.5a82a34d@jic23-huawei>
In-Reply-To: <71686d00-1b1a-9fc2-e65d-dd9be140fd27@metafoo.de>
References: <e11a245e-95ed-eff0-05a8-264f7598672f@ispras.ru>
        <e0a0dddc-b5e4-f544-c448-84910861afc1@metafoo.de>
        <71686d00-1b1a-9fc2-e65d-dd9be140fd27@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Mar 2021 09:47:29 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/18/21 9:27 AM, Lars-Peter Clausen wrote:
> > On 3/18/21 9:07 AM, Pavel Andrianov wrote:  
> >> Hi,
> >>
> >> berlin2_adc_probe [1] registers two interrupt handlers: 
> >> berlin2_adc_irq [2]
> >> and berlin2_adc_tsen_irq [3]. The interrupt handlers operate with the 
> >> same data, for example, modify
> >> priv->data with different masks:
> >>
> >> priv->data &= BERLIN2_SM_ADC_MASK;
> >> and
> >> priv->data &= BERLIN2_SM_TSEN_MASK;
> >>
> >> If the two interrupt handlers are executed simultaneously, a 
> >> potential data race takes place. So, the question is if the situation 
> >> is possible. For example, in the case of the handlers are executed on 
> >> different CPU cores.

If we assume there is a race here, the reading into priv->data from
two different registers on the line above the masking is more of any issue.

> >>
> >> Best regards,
> >> Pavel
> >>
> >> [1] 
> >> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L283 
> >>
> >> [2] 
> >> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L239 
> >>
> >> [3] 
> >> https://elixir.bootlin.com/linux/latest/source/drivers/iio/adc/berlin2-adc.c#L259
> >>  
> > Looking at the code there are two functions. berlin2_adc_tsen_read() 
> > and berlin2_adc_read(). These two function are take the same mutex and 
> > can not run concurrently. At the beginning of the protected section 
> > the corresponding interrupt for that function is enabled and at the 
> > end disabled. So at least if the hardware works correctly those two 
> > interrupts will never fire at the same time.
> >
> > Now, if the hardware misbehaves the two interrupts could still fire at 
> > the same time.
> >
> > - Lars
> >  
> Actually thinking a bit more about this the interrupt could still fire 
> after it has been disabled since there is no synchronization between the 
> disable and the interrupt handler. And the handler might be queued on 
> one CPU, while the disable is running on another CPU.
> 
Superficially it looks like splitting the priv->data and related priv->data_available
into versions for the normal ADC and the touch screen ADC paths should solve
this at the trivial cost of a couple of elements in that structure.
Possibly also need to deal with the wait_queue but I think that's fine as is.
(haven't thought about it that much!)

Jonathan

