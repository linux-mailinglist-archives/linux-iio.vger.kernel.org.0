Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093223DCD7A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhHATvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhHATvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:51:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF4C06175F;
        Sun,  1 Aug 2021 12:51:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x192so25338031ybe.0;
        Sun, 01 Aug 2021 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3qD/rZ0V+eZxmDbUBpM/NiZcHDu60IOJgfYrVNP/bc=;
        b=UWZRTpPfyQpQkOBjIXupYutSmPKNEtqcuw6cbNPojUx31DAVFmaM0uGVfD3dbyM5kL
         xwkt1AzcELfRrRG3897H9Q7uI3ynoyzYthmQy90EknruW110MEwQz7VRkjqmMbohobgw
         UCm0MQKk6ALPCOPq1e6pnHKsxggW68EAH7J/R7US5ownOQbWEnviDhEQmD5d9kqPT1X1
         1MK2MEhZEu1FeP+jwwjsDVXnarSVa9kOV42srcfQ5LIEsCrNGaLlrnBB4csawJDVEXfO
         PHsEj4ey+CAQW9ENMd4mX6GciukrqgjYVdjwYqJK1Ji4CvrFqf1zRZARFI7pVVAG0fHi
         +1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3qD/rZ0V+eZxmDbUBpM/NiZcHDu60IOJgfYrVNP/bc=;
        b=p9G8IKIis2Tsz9l6cIUWzaIrK/pSvMc4l25tOPFuwPUjoPXNVvifU/TIxSVQernCV7
         MQg8Zhbc4/FhUWdCgDGoAb6KcdA88NkswkRzsadHb6/DbfYKbDYDSQbM/fKGP3V4DTwX
         OT9KFwnZ0zuPs4xegEApAPOejqnObx3G4+EsBfVTr06l6qH8yuX/W9+hgGnlctzIMDyp
         uCjuIylKkHzNvwTkI2MTMUQycIzMHKkra0SnGk/Zri6msLXv8YVDYHkUVuPCG+Urf+OX
         PLpfc25dUfA//DdeCVGTehg+usmQdVnB2LQBtEcxZGVp638WYqy3XNutIzY9cquMflNW
         jNMg==
X-Gm-Message-State: AOAM531yh8PcbSMaIX30/EZL0howxVk0WSURhZb+ndy4faZFb8cXjStN
        kavSnieVFECDWSIK9RK6o0zd6xXzoqqzldgYln8=
X-Google-Smtp-Source: ABdhPJw7LS93H0i4bkzbrHg6bKZWyyhnvXHEnxMWG27SMcjNvQR5TGwBcMoCWf19lZaiXTiRlFhcOLADHqjJNSZQycE=
X-Received: by 2002:a25:dad7:: with SMTP id n206mr16449292ybf.119.1627847504684;
 Sun, 01 Aug 2021 12:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210731181142.430c50f8@jic23-huawei> <CA+V-a8vMdFrrcw3iqbSzd4oN_x6CijOwYo7eSFuf8LhfB6SFRg@mail.gmail.com>
 <20210801175947.2b49878d@jic23-huawei>
In-Reply-To: <20210801175947.2b49878d@jic23-huawei>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 1 Aug 2021 20:51:18 +0100
Message-ID: <CA+V-a8ukR39BsvUd055p8w-kafZ-SQDXydkJXag7c+7m3MEihg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D converter
To:     Jonathan Cameron <jic23@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Aug 1, 2021 at 5:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 31 Jul 2021 19:31:52 +0100
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Thank you for the review.
> >
>
> ...
>
> > > > +#define DRIVER_NAME          "rzg2l-adc"
> > >
> > > As only used in one place, just put it inline there so we don't need
> > > to go find if we want to know the value - I'm lazy.
> > >
> > Its being used in two places
> > 1: indio_dev->name = DRIVER_NAME #In probe call
> > 2: .name = DRIVER_NAME # In platform_driver struct
> >
> > Let me know if you want me to replace them inline and drop the above macro.
>
> oops.  Searching apparently failed me ;)  Fine as is.
>
> ...
>
>
> > > > +static const struct iio_info rzg2l_adc_iio_info = {
> > > > +     .read_raw = rzg2l_adc_read_raw,
> > > > +     .read_label = rzg2l_adc_read_label,
> > > > +};
> > > > +
> > > > +static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
> > > > +{
> > > > +     struct rzg2l_adc *adc = (struct rzg2l_adc *)dev_id;
> > >
> > > No need for explicit cast from void * to another pointer type.
> > > This is always valid without in C.
> > >
> > Agreed.
> >
> > > > +     unsigned long intst;
> > > > +     u32 reg;
> > > > +     int ch;
> > > > +
> > > > +     reg = rzg2l_adc_readl(adc, RZG2L_ADSTS);
> > > > +
> > > > +     /* A/D conversion channel select error interrupt */
> > > > +     if (reg & RZG2L_ADSTS_CSEST) {
> > > > +             rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > > > +             return IRQ_HANDLED;
> > > > +     }
> > > > +
> > > > +     intst = reg & RZG2L_ADSTS_INTST_MASK;
> > > > +     if (!intst)
> > > > +             return IRQ_NONE;
> > > > +
> > > > +     for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS) {
> > > > +             if (intst & BIT(ch))
> > >
> > > I'm missing how this if can fail given we only end up in here when the bit is
> > > set.
> > >
> > ADC has 8 channels RZG2L_ADSTS register bits [0:7] will be set to 1
> > when the given channel ADC conversion has been completed. So the above
> > if condition checks if the bit is set to 1 and then reads the
> > corresponding value of that channel.
>
> Just looking at the two lines of code above
> for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
> will only call the the next line if the bit is set.  E.g. It will only call
> it
> if (intst & BIT(ch))
>
> So you can only get into the body of the for loop if this bit is set and the
> condition is always true.  Hence drop
> if (intst & BIT(ch))
>
Agreed can be dropped.

> >
> > > > +                     adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) &
> > > > +                                         RZG2L_ADCR_AD_MASK;
> > > > +     }
> > > > +
> > > > +     /* clear the channel interrupt */
> > > > +     rzg2l_adc_writel(adc, RZG2L_ADSTS, reg);
> > > > +
> > > > +     complete(&adc->completion);
> > > > +
> > > > +     return IRQ_HANDLED;
> > > > +}
> > > > +
>
> ...
>
> > > > +
> > > > +     pm_runtime_enable(dev);
> > >
> > > I think you also want to set the state to suspended to ensure the resume is
> > > called on get.
> > >
> > pm_runtime_set_suspended() should only be called when runtime is
> > disabled or is it that I am missing something ?
>
> If you want the runtime pm code to assume your device is suspended initially
> then you set the state before you call pm_runtime_enable(dev).
>
OK will call pm_runtime_set_suspended() before enabling.

Cheers,
Prabhakar
