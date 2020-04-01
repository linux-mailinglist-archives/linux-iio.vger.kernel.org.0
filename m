Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB819A98C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgDAK1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 06:27:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43140 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgDAK1d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 06:27:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so11885232pfa.10;
        Wed, 01 Apr 2020 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RNJMZCJvB40U9Qk+mZw8kiFZdWTeiO8956JY+Lpa3zY=;
        b=kd+qALydDbsk5PDv3CmNVU876gc2XF9ln0DDeqKl2KQAmmQURexYe6cGFN/wz629v6
         brJSdD5GuUwI/AD89NLIcxbm0THCRCkr925la6QHbV2IVAmQfOujYs/65sZkqcODp2C6
         1xrJxGxtDNRfAJXPR9QA9Va36wxptxLSMw0XRUUf0j7j74OTEbGxffE+2ewDh0/XbV7g
         g5Yxa8OsfcZCO602gcz22X4qYB1CPG5pwO0HaueaHsaZgQwi1sP+F7V59FMoThwgZT+Y
         klbhMvCKOBbJsfyRFpugp1KQZ8TwFG89UzgrRtBFJEuj7gLSxNypQkoRvKX1O87zL6LB
         66RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RNJMZCJvB40U9Qk+mZw8kiFZdWTeiO8956JY+Lpa3zY=;
        b=GfgQaF8Q4/c1mmVPuazlO4iavY866iuU7o03ucpory8CM9CUnr7oB+Xb0PyDB0FchU
         uK07oITEPbkncPAX94bx1CAdKMtVC//zz6nj05icUi65RTvNJrkoFvnB5cLqC58TLRFm
         adgXx2YOXeyRlIu/cvIOSyd8uZq2VeCPaJSqpwsGE0cuaBk9Suoja+RlLw6ywOyPeah0
         NbR/oVHnf6RXoVDDKWX8L3IavvhcvlfsG/3KRg82j6vmF/dYPfPJgD45lbb3y+iB3qkm
         UfGAtu7959CpVOdFLjebk7f/zvV6tti3BfFJbq+Td1a9IHIId/5Gl92KycSpXuqDLJQo
         zQGw==
X-Gm-Message-State: ANhLgQ3dOscSuQju4rQneqlFm7Odio7zjTaISfA4Bt2shq5vSgYvBoKp
        6BzhyP2fr4AABkFRrytTCZL5y5RaC/uwDthA739vGIsTN5Y=
X-Google-Smtp-Source: ADFU+vt4HEC1R5DFw7uZpOKFKf66YONDP4gkCpjtAsq+aOrsNGlomYjFsswtwGKtUniltF+o2+/dDvfW30Ht+CAEtdg=
X-Received: by 2002:aa7:9097:: with SMTP id i23mr22128994pfa.170.1585736851029;
 Wed, 01 Apr 2020 03:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-3-nuno.sa@analog.com>
 <CAHp75VfXS1P-EJaKERojK=-3erYi5MxyDMjfrELyY2X3PZEN1A@mail.gmail.com> <BN6PR03MB3347F9B31FE4E82904ED3E8C99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB3347F9B31FE4E82904ED3E8C99C90@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 13:27:23 +0300
Message-ID: <CAHp75VfowVagnG0U8N4SM5Y2ZRoRTFFtJtZgkV+XWGznhrkogg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 1, 2020 at 10:22 AM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>=
 On
> > Behalf Of Andy Shevchenko
> > Sent: Dienstag, 31. M=C3=A4rz 2020 19:40
> > On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:
> > >
> > > There are some ADIS devices that can configure the data ready pin
> > > polarity. Hence, we cannot hardcode our IRQ mask as
> > IRQF_TRIGGER_RISING
> > > since we might want to have it as IRQF_TRIGGER_FALLING.

...

> > > +static int adis_validate_irq_mask(struct adis *adis)
> > > +{
> > > +       if (!adis->irq_mask) {
> > > +               adis->irq_mask =3D IRQF_TRIGGER_RISING;
> > > +               return 0;
> >
> > > +       } else if (adis->irq_mask !=3D IRQF_TRIGGER_RISING &&
> >
> > 'else' is redundant.
> >
> > > +                  adis->irq_mask !=3D IRQF_TRIGGER_FALLING) {
> >
> > But this condition rises questions. Why i can't configure both?
> > Why I can't configure other flags there?
>
> Both you can't because it is just how these type of devices work. Data is=
 ready either
> on the rising edge or on the falling edge (if supported by the device)...
> I agree this could check if only one of the flags are set instead of dire=
ctly comparing the
> values (invalidating other flags) but I would prefer to keep this simple =
for now...
>
> >
> > > +               dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> > > +                       adis->irq_mask);
> > > +               return -EINVAL;
> > > +       }
> >
> > > +       return 0;
> > > +}
> >
> > And actually name of the function is not exactly what it does. It
> > validates *or* initializes.
>
> Well, yes. It just sets the mask to the default value to keep backward co=
mpatibility
> with all the other devices that don't support/use this variable...

Perhaps documentation in a comment form should be added.
Moreover, I realized that you added to variable and function mask
suffix while it's actually flag.

--=20
With Best Regards,
Andy Shevchenko
