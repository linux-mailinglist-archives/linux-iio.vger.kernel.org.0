Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2696353468
	for <lists+linux-iio@lfdr.de>; Sat,  3 Apr 2021 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbhDCO6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhDCO6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 10:58:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCCC0613E6;
        Sat,  3 Apr 2021 07:58:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d12so11278303lfv.11;
        Sat, 03 Apr 2021 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofez9QQkjbGfabnkHUsDerilVQ8cXc1rXhIvZTSlqfA=;
        b=VcH+WX0DiySUQJLr1aarBlCe/aFgiAQ5l2FY+K/U12KXDyaEuZ/fItdbjl27O1yId3
         /PE+2O8GkJC9Ia2SFNzIFxoMjpr+4a91m8myGxsqWVp07TFly26EU/ho+I+GX/SHxmDz
         fDUf3X2ufiDtkewdhCqYkk1prfgOglggJ3VV1KQYd1S/bPEJekdQOg+hfWmk1A7DY9gd
         s5DyeTLT3NDWRQ1xKuS8H9Tt5DSxCZ1iUeRHlekpRNsGuAiEI/me7P+x1Lz59GBCOU9m
         yJIDP9sO0UYDEg3/o5WSaQDiFdlRs8JCXVQIZRLnWNkg2T5/4texofTWtTaTrmQWH8XQ
         Vp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofez9QQkjbGfabnkHUsDerilVQ8cXc1rXhIvZTSlqfA=;
        b=Dz8VETysctiBp6fGZ105olxnL9qGhFY4FntaOFAFmE12eeWuyTv3b+7uyb1bQfsZCF
         6Ci6z8LsjIE/o2VrhDbiu3XFXX0ibDXZSWj4n5siHXZwcQdK3bBuGXxsxsnPt2SEn+wr
         OfGpRcPXskdLacQX5NTxvx1LLC+rohEIk6ExDhh7ihky+7hcV4/mnmvzb4IG/knO4A4W
         6KONcJQ++puIOyjRemLQAhMrDFD6loSiUb/m+ExXoUxeUgjIiFfsw6f2jRf01Oy+Ue9F
         8otcv5MdRUPv/BdBCoM8UxAjLIafhUGO8YNPbK+b1zZX9fpWq5+850LpjTQdNPvLdjbQ
         pvfg==
X-Gm-Message-State: AOAM531flb/4dhuELboErYTippmDXkDF4dOg1QjjLFzSxgJShS7edQKq
        P1I2nlto2m1rRyGkaEKtsGhC4XgYduOhstSjciPzZ66Cr1U=
X-Google-Smtp-Source: ABdhPJwMsPdGA9tjvCjHqW0Bj3pR7PYcV5DMkFP1eW0WLL/4zc10iqXAL7UERRmctJ5dfqx9U98LfQ1Pgk9YxfaBEAY=
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr12219631lfn.354.1617461917675;
 Sat, 03 Apr 2021 07:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210401091648.87421-1-puranjay12@gmail.com> <20210401091648.87421-3-puranjay12@gmail.com>
 <7a9097bf-9f8d-0fe7-7b5e-84643bcff760@metafoo.de>
In-Reply-To: <7a9097bf-9f8d-0fe7-7b5e-84643bcff760@metafoo.de>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sat, 3 Apr 2021 20:28:25 +0530
Message-ID: <CANk7y0gwSZgxzmxtOZayyy_TrUP+rbjtN4WXZAsZE7E46UmUDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     alexandru.ardelean@analog.com, Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 2, 2021 at 1:43 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 4/1/21 11:16 AM, Puranjay Mohan wrote:
> > TMP117 is a Digital temperature sensor with integrated NV memory.
> >
> > Add support for tmp117 driver in iio subsystem.
> > Datasheet:-https://www.ti.com/lit/gpn/tmp117
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Nice and clean driver. Just some comments about the CALIBBIAS.
>
> > [...]
> > +#define TMP117_RESOLUTION_10UC               78125
> Isn't the unit here 100 uC?

it is 7.8125 milli degrees_C so 78125 x 10^-4 milli degrees_C
which is 78125 x 10^-4 x 10^3 micro degrees_C
so it becomes 78125 x 10^-1 micro degrees_C = 78125 10_microdegrees_C.
Did it in detail so I remember it in the future. I guess you thought
it as 0.78125 millidegrees_C?

> > +#define TMP117_DEVICE_ID             0x0117
> > +
> > +struct tmp117_data {
> > +     struct i2c_client *client;
> > +};
> > +
> > +static int tmp117_read_raw(struct iio_dev *indio_dev,
> > +             struct iio_chan_spec const *channel, int *val,
> > +             int *val2, long mask)
> > +{
> > [...]
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret = i2c_smbus_read_word_swapped(data->client,
> > +                                     TMP117_REG_TEMP_OFFSET);
> > +             if (ret < 0)
> > +                     return ret;
> > +             *val = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> > +                                                             / 10000;
> > +             *val2 = ((int16_t)ret * (int32_t)TMP117_RESOLUTION_10UC)
> > +                                                             % 10000;
>
> If I understand this right CALBBIAS is written in one unit, but read in
> another unit. E.g. if you do `echo 100 > ..._calibbias` and then `cat
> ..._calibbias` you'd read a different value back.
>
yes, reading it will return the value in milli degrees_C. but to write
it should be in the register format according to the datasheet.

> I think that would be quite unexpected behavior. The unit should be the
> same. Here in the read function you can just return the register value.

Okay, if you feel that would be right then I will do it.
> Just make sure to properly sign extend like for the RAW property.
>
> > +             return IIO_VAL_INT_PLUS_MICRO;
> > [...]
> > +}
> > +
> > +static int tmp117_write_raw(struct iio_dev *indio_dev,
> > +             struct iio_chan_spec const *channel, int val,
> > +             int val2, long mask)
> > +{
> > +     struct tmp117_data *data = iio_priv(indio_dev);
> > +     s16 off;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             off = (s16)val;
> This should have some input validation to avoid writing bogus values to
> the register when the value is out of range. You can either reject out
> of range values or clamp them into the valid range (using the clamp()
> macro).
the maximum value which this register takes is 0xffff, so it should
get clamped automatically when casting to s16?
I might be wrong here.

> > +             return i2c_smbus_write_word_swapped(data->client,
> > +                                             TMP117_REG_TEMP_OFFSET, off);
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> [...]



-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
