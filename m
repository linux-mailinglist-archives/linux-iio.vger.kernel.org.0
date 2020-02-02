Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06514FCE5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 12:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBBL2X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 06:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBBL2X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 06:28:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DA9206D3;
        Sun,  2 Feb 2020 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580642902;
        bh=idvg0ScIrlr77Wo2HLm6435xerymIe999QDm8yIO6+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C1HaChaMOIyBwVl9vkRkqNBfD+C/F4DutFmVLMOFlVrERUFr9rh1UBSqkbO74zG/g
         r5mNxXldsaarO9YcnhvGWebtfKJGT946hzquZCN4XhBAwl7yPyBBQCV/Awg2wJ7xa1
         d/jHolFONRV+NG2tyijX+90XXdWvNHAIZKwpXFlA=
Date:   Sun, 2 Feb 2020 11:28:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Joel Stanley <joel@jms.id.au>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v1 2/2] iio: adc: modify NPCM reset support
Message-ID: <20200202112815.66b4b119@archlinux>
In-Reply-To: <CAP6Zq1hupvQeXwynt02ePu6eL9X5oriNNwSmJEPqQWZBj770oA@mail.gmail.com>
References: <20200119110032.124745-1-tmaimon77@gmail.com>
        <20200119110032.124745-2-tmaimon77@gmail.com>
        <20200129200143.08bf4a91@archlinux>
        <CAP6Zq1hupvQeXwynt02ePu6eL9X5oriNNwSmJEPqQWZBj770oA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 10:20:30 +0200
Tomer Maimon <tmaimon77@gmail.com> wrote:

> Hi Jonathan,
> 
> The patch replace reset ADC method from direct register access to using
> reset driver (will applied next Linux version).
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20200130&id=9c81b2ccf82da6e995b63e945afa882cfaa03ca9
> 
> 
> The ADC dt-binding modified as well to use the new reset method (approved
> by Rob Herring)
> https://www.spinics.net/lists/devicetree/msg331327.html
> 
> Indeed the this modification require DT modification as it described in the
> ADC dt-binding commit, is it an issue? Do you thnk I should describe it in
> the commit?

Whether it is an issue depends on nuvoton business model.  Can they ensure
that all places the kernel is changed will also have appropriate dt updates?

If not, you need to make the code continue to function without the change
(fall back to old methods).  If they do have enough control to ensure it won't
break any systems out in the wild, then just add a note to say that is the
case to the commit message.

Reasons this sort of thing is sometimes safe include:
* preproduction part so no users outside of people who will expect
potential breakage
* dt and new kernel images only distributed in a firmware package, or
where build script used to build the firmware package will ensure they
match (this is a bmc chip I think, so I guess not many people build their own
kernels except via scripting to package everything up as a firmware image
of some type?)

Thanks,

Jonathan
> 
> Thanks,
> 
> Tomer
> 
> 
> 
> On Wed, 29 Jan 2020 at 22:01, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sun, 19 Jan 2020 13:00:32 +0200
> > Tomer Maimon <tmaimon77@gmail.com> wrote:
> >  
> > > Modify NPCM ADC reset support from
> > > direct register access to reset controller support.
> > >
> > > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>  
> >
> > Hmm.  This presumably breaks all old DT.
> >
> > If that's not a problem please say why.
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/iio/adc/npcm_adc.c | 30 +++++++++---------------------
> > >  1 file changed, 9 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> > > index a6170a37ebe8..83bad2d5575d 100644
> > > --- a/drivers/iio/adc/npcm_adc.c
> > > +++ b/drivers/iio/adc/npcm_adc.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/reset.h>
> > >
> > >  struct npcm_adc {
> > >       bool int_status;
> > > @@ -23,13 +24,9 @@ struct npcm_adc {
> > >       struct clk *adc_clk;
> > >       wait_queue_head_t wq;
> > >       struct regulator *vref;
> > > -     struct regmap *rst_regmap;
> > > +     struct reset_control *reset;
> > >  };
> > >
> > > -/* NPCM7xx reset module */
> > > -#define NPCM7XX_IPSRST1_OFFSET               0x020
> > > -#define NPCM7XX_IPSRST1_ADC_RST              BIT(27)
> > > -
> > >  /* ADC registers */
> > >  #define NPCM_ADCCON   0x00
> > >  #define NPCM_ADCDATA  0x04
> > > @@ -106,13 +103,11 @@ static int npcm_adc_read(struct npcm_adc *info,  
> > int *val, u8 channel)  
> > >                                              msecs_to_jiffies(10));
> > >       if (ret == 0) {
> > >               regtemp = ioread32(info->regs + NPCM_ADCCON);
> > > -             if ((regtemp & NPCM_ADCCON_ADC_CONV) && info->rst_regmap) {
> > > +             if (regtemp & NPCM_ADCCON_ADC_CONV) {
> > >                       /* if conversion failed - reset ADC module */
> > > -                     regmap_write(info->rst_regmap,  
> > NPCM7XX_IPSRST1_OFFSET,  
> > > -                                  NPCM7XX_IPSRST1_ADC_RST);
> > > +                     reset_control_assert(info->reset);
> > >                       msleep(100);
> > > -                     regmap_write(info->rst_regmap,  
> > NPCM7XX_IPSRST1_OFFSET,  
> > > -                                  0x0);
> > > +                     reset_control_deassert(info->reset);
> > >                       msleep(100);
> > >
> > >                       /* Enable ADC and start conversion module */
> > > @@ -186,7 +181,6 @@ static int npcm_adc_probe(struct platform_device  
> > *pdev)  
> > >       struct npcm_adc *info;
> > >       struct iio_dev *indio_dev;
> > >       struct device *dev = &pdev->dev;
> > > -     struct device_node *np = pdev->dev.of_node;
> > >
> > >       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> > >       if (!indio_dev)
> > > @@ -199,6 +193,10 @@ static int npcm_adc_probe(struct platform_device  
> > *pdev)  
> > >       if (IS_ERR(info->regs))
> > >               return PTR_ERR(info->regs);
> > >
> > > +     info->reset = devm_reset_control_get(&pdev->dev, NULL);
> > > +     if (IS_ERR(info->reset))
> > > +             return PTR_ERR(info->reset);
> > > +
> > >       info->adc_clk = devm_clk_get(&pdev->dev, NULL);
> > >       if (IS_ERR(info->adc_clk)) {
> > >               dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
> > > @@ -211,16 +209,6 @@ static int npcm_adc_probe(struct platform_device  
> > *pdev)  
> > >       div = div >> NPCM_ADCCON_DIV_SHIFT;
> > >       info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) *  
> > 2);  
> > >
> > > -     if (of_device_is_compatible(np, "nuvoton,npcm750-adc")) {
> > > -             info->rst_regmap = syscon_regmap_lookup_by_compatible
> > > -                     ("nuvoton,npcm750-rst");
> > > -             if (IS_ERR(info->rst_regmap)) {
> > > -                     dev_err(&pdev->dev, "Failed to find  
> > nuvoton,npcm750-rst\n");  
> > > -                     ret = PTR_ERR(info->rst_regmap);
> > > -                     goto err_disable_clk;
> > > -             }
> > > -     }
> > > -
> > >       irq = platform_get_irq(pdev, 0);
> > >       if (irq <= 0) {
> > >               ret = -EINVAL;  
> >
> >  

