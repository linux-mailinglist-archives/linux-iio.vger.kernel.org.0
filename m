Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6323B6C1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgHDI2i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHDI2i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 04:28:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D510C06174A;
        Tue,  4 Aug 2020 01:28:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so19784121pfm.4;
        Tue, 04 Aug 2020 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zLPOfCOr1RAuyDeEqSEeQYdBYJoolPkunVIn7d3sBM=;
        b=brrT1/A9GytVeAINrXagk80nXdYC0mcoHMB2NWjdpbRcXr+4nqKCy+rwUSSHKqQPQq
         GrByfJUk8gjZEHzF/mB88wnbel6ldak+YUrWQH4IU8Y87t1nBn0gWmsE1mvMi/y+PcGR
         Dk19aZadR6A4KQFC3JSeUeKlX0A5EC/ZAV83y0ZYs+JHi/Uaal+VE79MsTrcxneDz3XQ
         INo8dY71qjmnbENhAbV82LvGG7zIhl9d1nXjMY8vqGr/XaCgMGVOEc+qeUsk4rs69fxA
         Nf4UG5FpG5ubTuavCKV5OLpDZjxyUwblxhAvExWl56zMsU/gO7diBrNEW2hjeLOJO9gX
         st5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zLPOfCOr1RAuyDeEqSEeQYdBYJoolPkunVIn7d3sBM=;
        b=XNmCqCDHAlEqpqur8vPr2vJmCUpmEcEde6KbkVMvwJmeuEhxkEXmz9aTkVD0a5g55U
         bbEOCYXuUtsrI+Kg47RFJV1k0kP8sd2ITNMjkQIykMLAoVmGUKV1PRRUoIj/Lz79JvJU
         42C5SDOBCEYJHReRnsRc0rubO0CDjcmnjihcK99FGh8mbNcbnHkdTyou/Iz4DkIJdu9g
         ZB2zaOaGqz2UxozsoSx6FhBTpFHMtw2aVzjLpJbpYSkWHgqUTNWIbVm3fvL6B0RAmwjt
         1m3PnuJxZ3fn1T/6miMoPFABY1rxLkbEB4xThrfc6fJwZbfnZ07a0VxfTQYvtHjomHWc
         +PAw==
X-Gm-Message-State: AOAM531SHL4jXEW64Wsr0z2fJSiaFx4iQu/dMgDp+ULpuvWU3iEbDeRt
        71eK7jtAWGaYaX+l7gFdg38LIYyCLV6Io2TzGwE=
X-Google-Smtp-Source: ABdhPJzYa0UVDFjJMDx3gG3JiQjPhgly81KTX07Ub4i1Le+i6pmXkt0OdsNywXhG3v8TfGgZF2f4qGMXnnGHxQ1SSig=
X-Received: by 2002:a62:758f:: with SMTP id q137mr18887403pfc.170.1596529717996;
 Tue, 04 Aug 2020 01:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200802163735.76617-1-ceggers@arri.de> <20200802163735.76617-3-ceggers@arri.de>
 <CAHp75Vev64E86OWm+eV=1o4ZDs0Xh_Y1z6V54GmpRwWmjD7=eA@mail.gmail.com> <2356337.HYKpEJ1Wej@n95hx1g2>
In-Reply-To: <2356337.HYKpEJ1Wej@n95hx1g2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Aug 2020 11:28:22 +0300
Message-ID: <CAHp75VdusOQNzrY_Ken0KW06gtRW8fCOOtYXo=9nnFKc6bgWnQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 4, 2020 at 10:42 AM Christian Eggers <ceggers@arri.de> wrote:
> On Sunday, 2 August 2020, 20:02:35 CEST, Andy Shevchenko wrote:
> > On Sun, Aug 2, 2020 at 7:40 PM Christian Eggers <ceggers@arri.de> wrote:

...

> > > Datasheet:
> > > https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-
> > > b302-c2fd-e30a-c98df87616df
> > Do we need the UUID after the document file name?
> I have send AMS an inquiry. Not sure whether I will get an answer. I will wait
> a few days until sending v6.

I have successfully opened a document w/o additional UUID at the end of URI.
I think you may drop it.

...

> > > +#define AS73211_OFFSET_TEMP (-66.9)
> > > +#define AS73211_SCALE_TEMP  0.05
> >
> > In the kernel we don't do float arithmetic. How these are being used?
> Does this restriction also apply for compile time constants? I am quite
> sure that all calculations using these defines will be evaluated at compile
> time. If found a number of other places where probably the same is done:
>
> find . -name '*.c' | xargs grep "#define.*[0-9]\.[0-9]" | grep -v '"' | grep -v "\/\*.*[0-9]\.[0-9]"

Side note: `git grep ...` is much faster and better.
% git grep -n -w '#define[^"/]\+[0-9]\+\.[0-9]\+' -- drivers/ include/
arch/ | wc -l
47

+ DRM, yes.

In any case...

> > > +               *val2 = (AS73211_OFFSET_TEMP - (int)AS73211_OFFSET_TEMP) *
> > > 1000000;
> > >
> > > +                       *val2 = (AS73211_SCALE_TEMP -
> > > (int)AS73211_SCALE_TEMP) * 1000000;
> > Magic 1000000 multiplier.
> I think that in the context of IIO_VAL_INT_PLUS_MICRO this isn't quite magic. Using
> 1000000 directly seems quite usual:
>
> find drivers/iio/ -type f | xargs grep "val2 = .*1000000"

Hmm... Okay.

> > I think here you got them always 0. And to fix that you need to
> > redefine (with also units included in the name) above constants like
> > #define ..._OFFSET_TEMP_mC 66500
> > ... _SCALE_TEMP_?? 50
> a scale factor has no unit
>
> >
> > Consider to use definitions from
> > https://elixir.bootlin.com/linux/latest/source/include/linux/units.h
> There are only definition for milli celsius. For IIO_VAL_INT_PLUS_MICRO I would
> require micro celsius.
>
> If I have the freedom, I would keep it as it is. Else I would suggest the following:
> #define AS73211_OFFSET_TEMP_INT (-66)
> #define AS73211_OFFSET_TEMP_MICRO 900000
> #define AS73211_SCALE_TEMP_INT 0
> #define AS73211_SCALE_TEMP_MICRO 50000

...somewhat like above would be better. But your freedom is defined by
maintainers (not by me), so wait for their comments.

...

> > > +       }}
> > > +
> > > +       return -EINVAL;
> >
> > Make it default case.
> changed. Is there any benefit? My IDE's syntax checker now complains
> "No return, in a function returning non-void". But gcc is happy with this.

Your IDE is buggy :-)
Yes, there is a benefit of doing this, at some point compiler
complains about switches that don't cover all cases.

...

> > > +       ret = devm_iio_device_register(dev, indio_dev);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       return 0;
> >
> >   return devm_iio_device_register();
> changed. I prefer the original pattern as it would produce less changed lines
> if something needs to inserted later.

But if not, it will be a bulk of several lines of code which is the
bait for all kinds of janitors and clean up scripts (I saw that IRL,
so it's not unrealistic). In that case it will be twice the churn.

-- 
With Best Regards,
Andy Shevchenko
