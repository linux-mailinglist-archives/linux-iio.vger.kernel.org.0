Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DAF1A0A7E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 11:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDGJys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 05:54:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38009 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgDGJyr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 05:54:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so560616pfo.5;
        Tue, 07 Apr 2020 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/AY2Km8PifPy3imPl/lbUeSicPj3n0GEhu63na6IGc=;
        b=mq8c88CwohX/PzApU3CJEIL4Br1RzZyfdp1Q5xfTJ4Jf2BuV4ucUtCQpgD4om80pxD
         C+u65sLXlymg9hs2x2JDJLLqQ6fhv6SfHzwf1ShpbWcouhzLkESPy+2M52OGBiwfr6F6
         MRHxBNegwSX6caxGmRMB980AGnXHVAV/YpUQIaNrzKUzL5oq2ymEouhmww08tmPwKYnp
         p++Cbxty7rzsBIk3ZkEHOBxE7RtWjbLrJxhz+DVq+p9MG3/AD7mIqRTVGJp8ECIAbbgb
         x24uWGK/YWtbUpWll0gSSdd7yFBEGAqRjalwIppPSbzcBgIMb3tBfsaRtuNlFJvB6N9i
         CwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/AY2Km8PifPy3imPl/lbUeSicPj3n0GEhu63na6IGc=;
        b=hJOk2YUQa/jj5nPRdTp1alQNLs2maSlNF4B0aoGtzC/3bXkaSXQ0TNZXG9YkCUuo4C
         Ii8Hsn5QyXt8v44xmEpik8NdluQkA2qSzod3GQJFNB2mEfuIb9dJJFI5yH+9X/1q/RwY
         xwWFtFW7e+Io7ZmVbyrThDOEMm+VulK87AJQ06wQNYs8k8acrFhL1gC7o5inLPP9vaai
         QQQ32gL8UORmaiVxRMCfO2CPrKn1hvuoUiDYczAlv55+fOqtB9S3M4UTzUUMIsr+HZZh
         XBJZS7JdRX0tBnfxccEpFTE2LbNkJweq1oa2MUkzLCJbPH3BH+aRZaPek9JpDqndN9Ap
         9CJQ==
X-Gm-Message-State: AGi0PuYLNMAQX360KLRizadPTEo228N2SFYD+9mY4KVCg0JDPwf6rOGI
        Tyljr9FO+LLYOyBWpPQV37D7VjOEe2WryoG42wE=
X-Google-Smtp-Source: APiQypLzFcLW1izEfD1Gb+eB1GF8vhCfXf5UMv1aM5bBnDH/j1JYmeUP01tlpra04BXAdf0a1ZuNNijmS3R6+ixBPvg=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr1245672pgc.4.1586253286857;
 Tue, 07 Apr 2020 02:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200406150846.878-1-nuno.sa@analog.com> <20200406150846.878-6-nuno.sa@analog.com>
 <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
 <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
 <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com> <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
In-Reply-To: <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Apr 2020 12:54:39 +0300
Message-ID: <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
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
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 7, 2020 at 12:26 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
>
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Dienstag, 7. April 2020 11:19
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; devicetree
> > <devicetree@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>;
> > Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> > <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > Ardelean, Alexandru <alexandru.Ardelean@analog.com>; Hennerich,
> > Michael <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475

...

> > > > > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > > > +                        indio_dev->masklength) {
> > > >
> > > > One line?
> > > >
> > >
> > > It goes beyond 80 col limit... I know I could initialize these to some local
> > const but...
> >
> > That's why question mark is there.
> > Nonetheless, if it ~2-3 characters more, I would leave it on one line anyway.
> >
> > JFYI: readability has a priority over 80 limit.
> >
>
> Thanks! I would say it also depends on the maintainer (not sure)? Some are more
> strict about checkpatch...
> Btw, the line will have 84 if one liner...

Let's leave it to maintainer then.

> > > > > +       }

...

> > > > > +       irq_type = irqd_get_trigger_type(desc);
> > > > > +       if (irq_type == IRQF_TRIGGER_RISING) {
> >
> > > > > +               polarity = 1;
> >
> > For the sake of consistency I would assign irq_flag here as well.
> >
>
> The library will do it by default, But that's me using "inside" info... or maybe if
> I document that in patch 2 (the struct kernel docs) we would not really need to
> assign it here?

I see now. From my point of view the library here does an ill turn
because it hides some details which driver needs to do anyway.
I prefer explicit over implicit at least here.

I would say okay, if there is no such code (like below) would be
present in the driver.

> > > > > +       } else if (irq_type == IRQF_TRIGGER_FALLING) {
> > > > > +               polarity = 0;
> > > > > +               st->adis.irq_flag = IRQF_TRIGGER_FALLING;
> > > > > +       } else {
> > > > > +               dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
> > > > > +                       irq_type);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > >
> > > > Here is the problem. You got type, but you compare it to flags. It's
> > > > not correct.
> > > > Although values are the same, the meaning is different.
> > > >
> > >
> > > Hmm, thanks! Honestly, this was copy paste from adis16480 and I never
> > realized this. I will
> > > use IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING.

-- 
With Best Regards,
Andy Shevchenko
