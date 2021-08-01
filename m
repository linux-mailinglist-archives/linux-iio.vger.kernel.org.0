Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6213DCCC6
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhHAQ5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 12:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhHAQ5T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Aug 2021 12:57:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6521E610A5;
        Sun,  1 Aug 2021 16:57:06 +0000 (UTC)
Date:   Sun, 1 Aug 2021 17:59:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D
 converter
Message-ID: <20210801175947.2b49878d@jic23-huawei>
In-Reply-To: <CA+V-a8vMdFrrcw3iqbSzd4oN_x6CijOwYo7eSFuf8LhfB6SFRg@mail.gmail.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210731181142.430c50f8@jic23-huawei>
        <CA+V-a8vMdFrrcw3iqbSzd4oN_x6CijOwYo7eSFuf8LhfB6SFRg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Jul 2021 19:31:52 +0100
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for the review.
> 

...

> > > +#define DRIVER_NAME          "rzg2l-adc"  
> >
> > As only used in one place, just put it inline there so we don't need
> > to go find if we want to know the value - I'm lazy.
> >  
> Its being used in two places
> 1: indio_dev->name = DRIVER_NAME #In probe call
> 2: .name = DRIVER_NAME # In platform_driver struct
> 
> Let me know if you want me to replace them inline and drop the above macro.

oops.  Searching apparently failed me ;)  Fine as is.

...


> > > +static const struct iio_info rzg2l_adc_iio_info = {
> > > +     .read_raw = rzg2l_adc_read_raw,
> > > +     .read_label = rzg2l_adc_read_label,
> > > +};
> > > +
> > > +static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
> > > +{
> > > +     struct rzg2l_adc *adc = (struct rzg2l_adc *)dev_id;  
> >
> > No need for explicit cast from void * to another pointer type.
> > This is always valid without in C.
> >  
> Agreed.
> 
> > > +     unsigned long intst;
> > > +     u32 reg;
> > > +     int ch;
> > > +
> > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADSTS);
> > > +
> > > +     /* A/D conversion channel select error interrupt */
> > > +     if (reg & RZG2L_ADSTS_CSEST) {
> > > +             rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > > +             return IRQ_HANDLED;
> > > +     }
> > > +
> > > +     intst = reg & RZG2L_ADSTS_INTST_MASK;
> > > +     if (!intst)
> > > +             return IRQ_NONE;
> > > +
> > > +     for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS) {
> > > +             if (intst & BIT(ch))  
> >
> > I'm missing how this if can fail given we only end up in here when the bit is
> > set.
> >  
> ADC has 8 channels RZG2L_ADSTS register bits [0:7] will be set to 1
> when the given channel ADC conversion has been completed. So the above
> if condition checks if the bit is set to 1 and then reads the
> corresponding value of that channel.

Just looking at the two lines of code above
for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS) 
will only call the the next line if the bit is set.  E.g. It will only call
it
if (intst & BIT(ch))

So you can only get into the body of the for loop if this bit is set and the
condition is always true.  Hence drop 
if (intst & BIT(ch)) 

> 
> > > +                     adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) &
> > > +                                         RZG2L_ADCR_AD_MASK;
> > > +     }
> > > +
> > > +     /* clear the channel interrupt */
> > > +     rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > > +
> > > +     complete(&adc->completion);
> > > +
> > > +     return IRQ_HANDLED;
> > > +}
> > > +

...

> > > +
> > > +     pm_runtime_enable(dev);  
> >
> > I think you also want to set the state to suspended to ensure the resume is
> > called on get.
> >  
> pm_runtime_set_suspended() should only be called when runtime is
> disabled or is it that I am missing something ?

If you want the runtime pm code to assume your device is suspended initially
then you set the state before you call pm_runtime_enable(dev).


J
