Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F93656C7
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhDTKsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhDTKsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Apr 2021 06:48:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68EC06138F;
        Tue, 20 Apr 2021 03:47:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so930121pfk.9;
        Tue, 20 Apr 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppKMafDgcTqXy7goP6Ij1fDPQWBxSsSHNxbUNdGLuU0=;
        b=gLi8qv1WxfM+jMxCp0Vf1EvJRT/1EyROPHTtel3FZ3vDJxBo5147WQT7wZR9h4+Csp
         xu/ICEDIeWUVSSVNoZ+wfUjXeKoWLyZ3O4Bzpt9YsA+tePttZjR8L3Ep5HOXZIfHC0/+
         dz0PTUNSu0xgbtB/nwpfJPIdBzKFzWRxj8/imQMRRcbKyMLq3+NcoX7W9E/KprRPOGhS
         V0PiJaSGSUyS7lfWFvB7/UGOlysw5+1W0E0YxDyaGHd7azbKq6TKdgNHp+io+7Ora5co
         2sYgsRVGEevfUg/gqKs2BPitSnyY84xc2OcHGmiAqgSwZRhcsBxF8RrbqzGbkNpL+ttZ
         +TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppKMafDgcTqXy7goP6Ij1fDPQWBxSsSHNxbUNdGLuU0=;
        b=cR8VKncbF16jeS883RbY4ZA0x6Eaam6zdNeY42dkXqp9PdJsb4fbfeHg/nHNp/B5Hb
         X5QwLsAPz0Z+0BbPiTNDc/Q+JOFc8XotmHtWYKwP88g/0wEIrutNG8Cs3O4XmmZknjwF
         aAE8sa63yjihMCbBBT4gKs1rdzJRsx8d6fD645ze0aopq151v1usiu+4w7jow87H/WW6
         WbGKh96B8bydRPby52f/iAowmwBawd7/V5iAjW9A2M8kvHegJ3pNqkBrRiXB9ZgY+gVH
         w1BlNeByTTsNNLkRcLOeclgN2qxVac5N6d+QTK4AZAd5JBamXlHoVlGzMwRU53ue2XYg
         Vrzg==
X-Gm-Message-State: AOAM531U57QgXmG6AscA4t63GMiYrGjk8nr4+mLzmQSTicyXPLZQ58Fr
        zvxopWqN9XEYnwhnzNvTvvqU8RNBrKDElV4xF5F+7ml1qhU=
X-Google-Smtp-Source: ABdhPJynj/0U0LGa9pPh0aG5fUmlAZuvnjiTZeZSkEYMMqAa/TAykg354H5lyy2wy3fGhErWznZ0wVSleVV6vwJSkNc=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr16395183pgi.4.1618915662332;
 Tue, 20 Apr 2021 03:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210419132159.4450-1-tomas.melin@vaisala.com>
 <20210419132159.4450-3-tomas.melin@vaisala.com> <CAHp75VdApCk_Ydt2W_WWJ_wme4d1ocrrnvo+TjZcQ62RG6uOUA@mail.gmail.com>
 <bea4dc56-b860-431c-a820-a482ce87743c@vaisala.com>
In-Reply-To: <bea4dc56-b860-431c-a820-a482ce87743c@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Apr 2021 13:47:26 +0300
Message-ID: <CAHp75VfM3xToHJ+J095pkoLz1YD5qq-MaZoN3Log+bj6ktWFkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 20, 2021 at 11:50 AM Tomas Melin <tomas.melin@vaisala.com> wrote:
> On 4/19/21 4:55 PM, Andy Shevchenko wrote:
> > On Mon, Apr 19, 2021 at 4:26 PM Tomas Melin <tomas.melin@vaisala.com> wrote:

...

> >> +#define SCA3300_MASK_STATUS    GENMASK(8, 0)
> >> +#define SCA3300_MASK_RS_STATUS GENMASK(1, 0)
> > This feels like an orphan. Shouldn't you move it closer to the group
> > of corresponding register / etc definition?
>
> Tried to group these in alphabetical order, but IIUC preference would be
> towards grouping

Yes, alphabetical is about header block, and definition should be
understandable and HW represented.

> according to how they are used? Would this be clearer and acceptable?

1) with some amendments, see below.

> 1)
>
> /* Device mode register */
> #define SCA3300_REG_MODE    0xd
> #define SCA3300_VALUE_SW_RESET    0x20

SCA3300_MODE_SW_RESET

> /* Last register in map */
> #define SCA3300_REG_SELBANK    0x1f
>
> /* Device status and related mask */
> #define SCA3300_REG_STATUS    0x6
> #define SCA3300_MASK_STATUS    GENMASK(8, 0)

SCA3300_STATUS_MASK

and so on (I guess you got the pattern)

> /* Device ID */
> #define SCA3300_REG_WHOAMI    0x10
> #define SCA3300_VALUE_DEVICE_ID    0x51
>
> /* Device return status and mask */
> #define SCA3300_VALUE_RS_ERROR    0x3
> #define SCA3300_MASK_RS_STATUS    GENMASK(1, 0)

...

> >> + * @txbuf: Transmit buffer
> >> + * @rxbuf: Receive buffer
> > Are the buffers subject to DMA? Shouldn't they have the proper alignment?
> Good point, I will add alignment.

Move them to the end of the structure to save few bytes,

...

> >> +       sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
> > Seems you ignored my comment. What is this 0x0? What is the meaning of it?
> > Same for all the rest magic numbers in the code.
>
> Sorry, not ignored but will remove this redundant 0x0 for next round.

Maybe it's not redundant after all (I noticed other magic numbers in
the same position)? Please, comment your intention case-by-case.

...

> >> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> >> +                        indio_dev->masklength) {
> >> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> >> +                                      &val);
> >> +               if (ret) {
> >> +                       dev_err(&data->spi->dev,
> >> +                               "failed to read register, error: %d\n", ret);
> >> +                       goto out;
> > Does it mean interrupt is handled in this case?
> > Perhaps a comment why it's okay to consider so?
>
> IRQ_HANDLED seemed more correct than IRQ_NONE.

Why? Care to explain?

>  Or did You have some
> other option in mind?
>
> How about something like:
>
>      /* handled with errors */

But what if this is the very first interrupt (bit in the loop) that
failed? What about the rest?

>      goto out;
>
> >> +               }
> >> +               data->scan.channels[i++] = val;
> >> +       }

-- 
With Best Regards,
Andy Shevchenko
