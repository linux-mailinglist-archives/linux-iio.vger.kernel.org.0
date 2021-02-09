Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F2314686
	for <lists+linux-iio@lfdr.de>; Tue,  9 Feb 2021 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBIChh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 21:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBIChL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 21:37:11 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45285C061788
        for <linux-iio@vger.kernel.org>; Mon,  8 Feb 2021 18:36:31 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e1so14827662ilu.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Feb 2021 18:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd5FQ+iTB3TUS+68uoPN+c0Gbt0ALh0tlLKZH7bRgBQ=;
        b=d/6ICEA5K4QVHMfPGUb9IExrWa8sFDU8zrj3exT/y+p6nU+vL2jWZrjohwmlYrjlYr
         ht73JBHN7M4uzxsuxiK7UrK97T4/duGomLPrMECG3CMhVr2fEe86Q65Cvrt/r5wMF5zc
         as2GWSGzR3DPUlyH/BDcaskThBlWOyhcuSK9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd5FQ+iTB3TUS+68uoPN+c0Gbt0ALh0tlLKZH7bRgBQ=;
        b=DbZ+Ofo5K+tf9F+g6zWpe9rY7G6mqWPHHeWV4CHxCobX5jEnio8VBIZ3DDPPYkmOjb
         ODcmdMl6TnSnZJaGXAbo4bcSTBrwPqE5bCZ4mtqQ6YxNUSbDIivwCgOLBWHiTQqJG521
         wBqQjxAX5MDvq2ZQHEyrViF8BNwNAnrFM1z7qR7+zaq4Untg6lIIU3Cpfy+hWQYr/DVU
         l0paFQXj122DssHI0YwdQTGw7OsB/V5t2Meo9HSzjv6Z0QdlDQGZQbM57uAQh8aolnud
         vvFGIf1mnGJyiVnGrVkZPcfmdBnebQR70vjeRr1x6A8W767kmPWfwGA75dgLE7SVWLNE
         fGbw==
X-Gm-Message-State: AOAM531BO1dd1fG5Beb/BMfY/2En+pGAldgBs2mGzSDfyJdD5FXB6+Ml
        /6DP6GWHEXNTmGXnchtGb4D72Bvbv+864gP4cJB8ug==
X-Google-Smtp-Source: ABdhPJyUZ/bhyv314yz/TaMHfpfcDy7aqA+YXGLOckBGBLAhYwN7IqBrnhjHsjLXqlTGtjourzokm9kikdtXupwxuKk=
X-Received: by 2002:a05:6e02:1185:: with SMTP id y5mr18625157ili.237.1612838190636;
 Mon, 08 Feb 2021 18:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210202064541.2335915-1-gwendal@chromium.org>
 <161229346726.76967.648868878998146729@swboyd.mtv.corp.google.com>
 <CAPUE2uu0y8pRmCHxhLQ3Ca2oAMJ0ihwAHfUdHNBOUNS-hZhmdA@mail.gmail.com> <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com>
In-Reply-To: <161257570963.76967.16707158676326253606@swboyd.mtv.corp.google.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 8 Feb 2021 18:36:19 -0800
Message-ID: <CAPUE2uu3eyBbD4KDjE2-AgrAgFm0+NEaPgXX8EBP9HKqyrLsGA@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Support ACPI property
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Campello <campello@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 5, 2021 at 5:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Gwendal Grignou (2021-02-05 13:49:12)
> > On Tue, Feb 2, 2021 at 11:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Gwendal Grignou (2021-02-01 22:45:41)
> > > > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > > > index 37fd0b65a0140..1a8a441c9774d 100644
> > > > --- a/drivers/iio/proximity/sx9310.c
> > > > +++ b/drivers/iio/proximity/sx9310.c
> > > > @@ -1213,31 +1214,36 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
> > > >  }
> > > >
> > > >  static const struct sx9310_reg_default *
> > > > -sx9310_get_default_reg(struct sx9310_data *data, int i,
> > > > +sx9310_get_default_reg(struct device *dev, int i,
> > > >                        struct sx9310_reg_default *reg_def)
> > > >  {
> > > > -       int ret;
> > > > -       const struct device_node *np = data->client->dev.of_node;
> > > > +       int ret, count;
> > > >         u32 combined[SX9310_NUM_CHANNELS] = { 4, 4, 4, 4 };
> > > >         unsigned long comb_mask = 0;
> > > >         const char *res;
> > > >         u32 start = 0, raw = 0, pos = 0;
> > > >
> > > >         memcpy(reg_def, &sx9310_default_regs[i], sizeof(*reg_def));
> > > > -       if (!np)
> > > > -               return reg_def;
> > > > -
> > > >         switch (reg_def->reg) {
> > > >         case SX9310_REG_PROX_CTRL2:
> > > > -               if (of_property_read_bool(np, "semtech,cs0-ground")) {
> > > > +               if (device_property_read_bool(dev, "semtech,cs0-ground")) {
> > > >                         reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
> > > >                         reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
> > > >                 }
> > > >
> > > >                 reg_def->def &= ~SX9310_REG_PROX_CTRL2_COMBMODE_MASK;
> > > > -               of_property_read_u32_array(np, "semtech,combined-sensors",
> > > > -                                          combined, ARRAY_SIZE(combined));
> > > > -               for (i = 0; i < ARRAY_SIZE(combined); i++) {
> > > > +               count = device_property_read_u32_array(dev,
> > > > +                               "semtech,combined-sensors", NULL, 0);
> > > > +               if (count > 0 && count <= ARRAY_SIZE(combined))
> > > > +                       ret = device_property_read_u32_array(dev,
> > > > +                                       "semtech,combined-sensors", combined,
> > > > +                                       count);
> > > > +               else
> > > > +                       ret = -EINVAL;
> > > > +               if (ret)
> > > > +                       count = ARRAY_SIZE(combined);
> > >
> > > I wish this could be written simpler. Unfortunately there isn't any sort
> > > of for_each_device_property() iterator macro like we have with
> > > of_property_for_each_u32(). Or device_property_read_u32_array() can be
> > > OK if the length of the property doesn't exceed the size of the
> > > 'combined' array?
> >
> > device_property_read_u32_array(...,nval) calls
> > acpi_data_get_property(..., nval) in ACPI case.
> > If nval > obj->package.count, then -EOVERFLOW is returned.
> > Therefore count can not be to SX9310_NUM_CHANNELS, in case
> > combined-sensors is only 3 entries or less.
> >
> > This method of asking first for the number of element and a second
> > time for the values is already used at different places in the kernel:
> > drivers/power/supply/gpio-charger.c : see init_charge_current_limit()
> > or  madera_get_variable_u32_array insound/soc/codecs/madera.c.
>
> Sure it's used but that doesn't really mean it's a good pattern to copy.
> If the number is more than 4 I'd say we should ignore it and move on,
> but if it's less than 4 is an error returned?
>
> >
> > However, it could use device_property_count_u32(...), which is more
> > readable than device_property_count_u32(..., NULL,0).
> >
>
> How about
>
>   ret = device_property_read_u32_array(dev, "semtech,combined-sensors", combined, ARRAY_SIZE(combined));
>   if (ret)
>         break; /* Must have overflowed or not existed; ignore */
>
>   for (i = 0; i < ARRAY_SIZE(combined); i++)
>
> and then it should work as before?
It will not work:
If the DTD has a valid array of only 3 elements (for instance  [CS0,
CS1, CS2] as in
         Package (0x02)
         {
             "semtech,combined-sensors",
             Package (0x03)
             {
                 Zero,
                 One,
                 0x02
             }
         },
)

device_property_read_u32_array(...., 4) will return -EOVERFLOW and we
will use the default in the driver, which we do not want.

Gwendal.
