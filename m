Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C81B8646
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDYLns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgDYLns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Apr 2020 07:43:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04857C09B04B;
        Sat, 25 Apr 2020 04:43:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o15so5976240pgi.1;
        Sat, 25 Apr 2020 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+fcBxNw/nwKWvas8bdh9z7lSOeFbVCVoSvS/R8YOZ4=;
        b=FBGpWRshuMLAD0L8sCwi1qBFiM3qU3inaSks+NHjc7EiO83P6aGntSbE2m7YDKbG5A
         mryVIOJddS5k0MIvthi5ILVpua11o+xn4uZLMq8u/ZsXyoJdqK7bAoMKNIIY1NIhwtjc
         1z/odHsWWdDINScg3E4/CyJ/AeQD6xWnmEf1GbZDkkZgfQIOZUjuhtp5RAZt9wmJHGWA
         +eAC9LSaIca26xLroqp+HQms8+mbdhBXjranbaNt38IMGkBTgiAUHmMXaawGs+el9fC8
         KdkTEEUa7+dBq/A+o0nAoHaZqtVIK2LyuytNm7vxyBqOcHRxETVHUaZu1USwsNuT/sx/
         DBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+fcBxNw/nwKWvas8bdh9z7lSOeFbVCVoSvS/R8YOZ4=;
        b=Xt5ya8mSHJ4Jmt4u4UFcova67qDqusn2rIoEEKin7zOIPxtXP0eouMsyjFWwVzAx9d
         Smv+kxOHcn7WqWpHq3i01mGkCyAZfE1w7Fbj2Bp6I1kqkc6j/O2TwwW8Y85RpeQ3QNzT
         xdl+K8WBDiwklYrgwFWWA7WKtyoyJ54vdbhUZdzxNn3aDJSSHpFJkhTEbPKHUYanBrd2
         wCQi7kLP3iCHej3nbR9wdYuCYU2eyzvRmPDPQ/HgxUZrkldXBnrhB0/wNJ0BiapcpaCD
         LZzeE50Jqpeld3NhCfOTzDfVWyISIMm8Ybe+cCOQ5Yq0saxJ4LLrqcals5vTbPrDTB6e
         yvwg==
X-Gm-Message-State: AGi0PuZDP9MGLJM4YRE7tM6utd5mhyqVNXwxq4+WMqidJzYmTrI9N9d3
        GPxvkwYICAvdZJcJgB9HYfK+pt7eeumWC8ezObdB8syNrJQ=
X-Google-Smtp-Source: APiQypLNRmDFDdkqQqFUJOEj14NHuHK26wddSprK6QKYDfBaSBDQ4d1J6m87q/0nL6ioabJ60J0w18/POeBEdQJoJGI=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr14036650pfb.130.1587815027309;
 Sat, 25 Apr 2020 04:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com> <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
 <20200424190413.GA2731@arch>
In-Reply-To: <20200424190413.GA2731@arch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Apr 2020 14:43:35 +0300
Message-ID: <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 24, 2020 at 10:05 PM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
> On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> > <tomasz.duszynski@octakon.com> wrote:

...

> > > Add Sensirion SCD30 carbon dioxide core driver.
> >
> > And DocLink tar of Datasheet: with a link?
>
> I never do this. These files change their location way too often to be
> worthwhile putting here. Nobody has that much time to fallow all this
> and keep respective files up to date.
>
> But that doesn't mean I can't drop a link here.
> https://developer.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/9.5_CO2/Sensirion_CO2_Sensors_SCD30_Interface_Description.pdf

Yes, just make it a tag

DocLink: ....

...

> > > +int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
> > > +               int (*command)(struct scd30_state *state, enum scd30_cmd cmd,
> > > +                              u16 arg, char *rsp, int size));
> >
> > My gosh.
> > Please, supply proper structure member in priv or alike.
>
> Not sure it's worth the fuss. Wrapping all into structure means either
> copying respective members or more dereferences later on.

At least you may introduce a typedef, because above really hurts my eyes.

...

> > > +enum {
> > > +       CONC,
> > > +       TEMP,
> > > +       HR,
> > > +};
> >
> > Way too generic names for anonymous enum.
>
> I'd argue that they are pretty well understood abbreviations in iio generally
> and here specifically. But adding some prefix won't harm.

Yes, prefix is what I was talking about.

...

> > > +static int scd30_wait_meas_poll(struct scd30_state *state)
> > > +{
> > > +       int tries = 5;
> > > +
> > > +       while (tries--) {
> > > +               int ret;
> > > +               u16 val;
> > > +
> > > +               ret = scd30_command(state, CMD_MEAS_READY, 0, (char *)&val,
> > > +                                   sizeof(val));
> > > +               if (ret)
> > > +                       return -EIO;
> > > +
> > > +               /* new measurement available */
> > > +               if (val)
> > > +                       break;
> > > +
> > > +               msleep_interruptible(state->meas_interval * 250);
> > > +       }
> > > +
> > > +       if (tries == -1)
> > > +               return -ETIMEDOUT;
> >
> > unsigned int tries = ...;
> >
> > do {
> >  ...
> > } while (--tries);
> > if (!tries)
> >   return ...;
> >
> > looks better and I guess less code in asm.
> >
>
> You mean that one extra branch in case of while?

There are few things:
a) do {} while notation immediately tells that at least one cycle of
body will be done (unconditionally);
b) it makes a loop variable unsigned and no need to check for specific
negative numbers;
c) it quite likely will generate slightly better assembly code.

>  But it comes to code
> itself it looks more compact. And I am okay with that.
>
> > > +       return 0;
> > > +}

...

> > > +       if (kstrtou16(buf, 0, &val))
> > > +               return -EINVAL;
> >
> > Shadowed error code. Don't do like this.
>
> Integer parsing either returns EINVAL or ERANGE. Passing the latter to
> the user is not worth the trouble, especially because majority of writable attrs
> have a fellow _available attr.

It's simple a bad coding practice. Please, change.

> > > +       if (kstrtou16(buf, 0, &val))
> > > +               return -EINVAL;
> >
> > Ditto.
> >
> > > +       if (kstrtou16(buf, 0, &val))
> > > +               return -EINVAL;
> >
> > Ditto.

...

> > > +       if (kstrtou16(buf, 0, &val))
> > > +               return -EINVAL;
> >
> > No shadowed error code, please. Check entire code.

Same here.

...

> > > +static IIO_DEVICE_ATTR_RW(pressure_comp, 0);
> > > +static IIO_DEVICE_ATTR_RO(pressure_comp_available, 0);
> > > +static IIO_DEVICE_ATTR_RW(meas_interval, 0);
> > > +static IIO_DEVICE_ATTR_RO(meas_interval_available, 0);
> > > +static IIO_DEVICE_ATTR_RW(asc, 0);
> > > +static IIO_DEVICE_ATTR_RW(frc, 0);
> > > +static IIO_DEVICE_ATTR_RO(frc_available, 0);
> > > +static IIO_DEVICE_ATTR_RW(temp_offset, 0);
> > > +static IIO_CONST_ATTR(temp_offset_available, "[0 1 65535]");
> > > +static IIO_DEVICE_ATTR_WO(reset, 0);
> >
> > Do you need all of them? Doesn't  IIO core provides a tons of helpers for these?
> > Btw, where is ABI documentation? It's a show stopper.
>
> They are sensor specific and none falls into a category of iio generic
> attrs. Maybe, except the measurement interval which could be represented as
> a SAMP_FREQ.

IIO ABI becomes already a big pile of nodes and I hope we will become
stricter about adding new ones.

> But given that measurement interval spans from 2s to 1800s
> it becomes a little bit awkward to have it in Hz.

> As for ABI that's in
> a separate patch.

It's not good from bisectability point of view. If by some reason this
patch or documentation patch gets reverted, the other one will be
dangling.
Please, unify them.

-- 
With Best Regards,
Andy Shevchenko
