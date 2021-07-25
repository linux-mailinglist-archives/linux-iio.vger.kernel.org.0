Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297883D4E28
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGYOMT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 10:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231128AbhGYOMS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 10:12:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE54760720;
        Sun, 25 Jul 2021 14:52:43 +0000 (UTC)
Date:   Sun, 25 Jul 2021 15:55:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/4] iio: adc: Add driver for Renesas RZ/G2L A/D
 converter
Message-ID: <20210725155515.25c727b9@jic23-huawei>
In-Reply-To: <CA+V-a8v28TuGa9Vay9wraRetEK4XZBm6BU4USZYTdFR4BkwBBQ@mail.gmail.com>
References: <20210719085840.21842-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210719085840.21842-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210724190601.084d43e7@jic23-huawei>
        <CA+V-a8v28TuGa9Vay9wraRetEK4XZBm6BU4USZYTdFR4BkwBBQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 25 Jul 2021 13:18:53 +0100
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> Hi Jonathan,
> 
> Thank you for the review.
> 
> On Sat, Jul 24, 2021 at 7:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 19 Jul 2021 09:58:38 +0100
> > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >  
> > > Add ADC driver support for Renesas RZ/G2L A/D converter in SW
> > > trigger mode.
> > >
> > > A/D Converter block is a successive approximation analog-to-digital
> > > converter with a 12-bit accuracy and supports a maximum of 8 input
> > > channels.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>  
> >
> > Hi Lad,
> >
> > A few additional comments inline.
> >
> > Thanks,
> >
> > Jonathan
> >  

...

> 
> > > +#define RZG2L_ADFIL                  0x2c
> > > +#define RZG2L_ADCR(n)                        (0x30 + ((n) * 0x4))
> > > +#define RZG2L_ADCR_AD_MASK           GENMASK(11, 0)
> > > +
> > > +#define RZG2L_ADC_MAX_CHANNELS               8
> > > +#define RZG2L_ADC_CHN_MASK           0x7
> > > +#define RZG2L_ADC_TIMEOUT            usecs_to_jiffies(1 * 4)
> > > +
> > > +struct rzg2l_adc_data {
> > > +     const struct iio_chan_spec *channels;
> > > +     u8 num_channels;
> > > +};
> > > +
> > > +struct rzg2l_adc {
> > > +     void __iomem *base;
> > > +     struct clk *pclk;
> > > +     struct clk *adclk;
> > > +     struct reset_control *presetn;
> > > +     struct reset_control *adrstn;
> > > +     struct completion completion;
> > > +     const struct rzg2l_adc_data *data;
> > > +     u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> > > +};
> > > +
> > > +static const char * const rzg2l_adc_channel_name[] = {
> > > +     "adc0",  
> > Is it useful to expose these as labels to userspace?
> > Seems unnecessary given they map directly to the channel
> > numbers.
> >  
> Exposing  them as this may vary depending on the wiring on the board,
> so it  would be better for user space to know which channels are
> available.

Hmm.  One thing to take into account is the IIO ABI doesn't require
channel numbers to be consecutive.  There are a few drivers where
they aren't due to channel optionality.

Perhaps that would make sense here?  If not, I'm fine with leaving
these as you have it.  They do no harm.

> 
> > > +     "adc1",
> > > +     "adc2",
> > > +     "adc3",
> > > +     "adc4",
> > > +     "adc5",
> > > +     "adc6",
> > > +     "adc7",
> > > +};
> > > +
...

> > > +static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
> > > +             return -EBUSY;
> > > +
> > > +     rzg2l_set_trigger(adc);
> > > +
> > > +     /* select channel */
> > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
> > > +     reg &= RZG2L_ADM2_CHSEL_CLEAR;
> > > +     reg |= BIT(ch);
> > > +     rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
> > > +
> > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
> > > +     reg &= RZG2L_ADM3_ADIL_CLEAR;
> > > +     reg |= RZG2L_ADM3_ADCMP;
> > > +     reg |= RZG2L_ADM3_ADSMP;  
> >
> > No loss in readability in combining the two lines above and shorter
> > code is always good.  Having the mask on a separate line makes
> > sense but the |= pair doesn't.
> >  
> Agreed will move to the same line.
> 
> > What is a bit unusual here is you clear some bits then write different
> > ones.  That is presumably relying on the fact that the ADCCMP part
> > is always set to the same value.  That seems unwise to assume from
> > a long term maintainability point of view.
> >  
> The ADIL bits have to be set to zero, so I am clearing the ADIL bits
> (bit 24-bits 31) and the ADCMP/ADSMP should be set to specific values
> oxe/0x578 respectively.

Understood, but from this 'local' bit of code it's not obvious that they don't
have other bits say, perhaps ADSMP is set to 0x483 for example by some
other code? (obviously it isn't, but it's nice to not have to sanity check
the rest of the driver to be sure!)  So normal thing to do would be to also
mask those bits out. 

I'm a bit curious on whether there are other bits in this register that make it
useful to do the read modify write cycle? (doesn't seem to be a public
datasheet from a quick google...)

> 
> > > +     rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
> > > +
> > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
> > > +     reg &= RZG2L_ADIVC_DIVADC_CLEAR;
> > > +     reg |= RZG2L_ADIVC_DIVADC_4;
> > > +     rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
> > > +
> > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADINT);
> > > +     reg &= ~RZG2L_ADINT_INTS;
> > > +     reg &= RZG2L_ADINT_CH_CLEAR;
> > > +     reg |= RZG2L_ADINT_CSEEN;
> > > +     reg |= BIT(ch);
> > > +     rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
> > > +
> > > +     return 0;
> > > +}
> > > +
...

Thanks,

Jonathan
