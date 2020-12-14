Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029032D939E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438974AbgLNHYM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 02:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438937AbgLNHYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 02:24:12 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7D6C0613CF
        for <linux-iio@vger.kernel.org>; Sun, 13 Dec 2020 23:23:32 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id p5so14896690ilm.12
        for <linux-iio@vger.kernel.org>; Sun, 13 Dec 2020 23:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSfI5itEhBBVa7KevscszD4yrA+i5z9MsDpAQedBJnw=;
        b=tomqg+SmYeCEpqw3f5sRMxiQw/KsVQMBkoAN3WciBLXj9+xur7aFn8fipRrVZkWOsD
         sf68cqde1JKfFWjCUQxRrP5ONPZMRjqOdppBG/rFQjRFwysCzhOY00E5TTElVGSNf4t+
         XvlSp7PPIll4zOZESmhFny82yzIcfDzZLqFjr4sxkWa/5QbgQdKjq4JwKNVGCrBpokE/
         9UKVmyPOgIaHr9Ac8pnwdeDV+aZ03i1wBTPEW19qSwT/j1xKgVM67EugWGNniXsWBFfm
         NXVvuOA597VVPNSNxia00QJLPseWMbPpvRb8UsAvTzWkF+j7HzXeACJEr5YM3QoA6MaW
         Y24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSfI5itEhBBVa7KevscszD4yrA+i5z9MsDpAQedBJnw=;
        b=X6XVIILUpnKDCMw24NiLYM1OQ1mgreTsbIk4FvUYfDTPw3aQQWj0QdmigTEtCvM0xH
         WyoUMP7nQeEuT4qBPUVY4JrmNvQgJyZGLBTeqB9p+VndYo6EB86FZkcnV9ejAnNFWaW1
         mTyMvDVPZoguNy98/7mETVSYukN0sn1t27tI8mPGgUGlPdb0OFui7bt0JXGUJ18dfwXy
         HH/81v+QHksKdrpHeVpOqcy5BzwOmltdGD/u85XhRiu6YZ/GfjTjldK3YGesXeJJL8jp
         sLvi451FVRAuUL/sWaLbVNhksWI6rRxKz/FIubYKs0/LK1rl6rnQ3JKzSadTUFnrlJ66
         sXJQ==
X-Gm-Message-State: AOAM532VmyvNnyZQ94ZeUlyAhCtXnNJHKxvWXzbP2xyD32yhWUcU3Jzc
        /Twn1qMoFldtJFfZ+I6j63oNdu0OGYA9hhU6abaLudPf
X-Google-Smtp-Source: ABdhPJzjYz1JTJo7mfFLK412EbJoy5JnFrf8r8BVpkXKXrUBTZLPGPwxB7t3/YsBOQECJrEhVVud9wWymDIUjaObES0=
X-Received: by 2002:a92:8419:: with SMTP id l25mr33526336ild.100.1607930611810;
 Sun, 13 Dec 2020 23:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20201209104649.5794-1-lars@metafoo.de> <20201213165530.18dce485@archlinux>
In-Reply-To: <20201213165530.18dce485@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 14 Dec 2020 09:23:20 +0200
Message-ID: <CA+U=DspaoNjJGei+kyV4L+MzvYqJy08LdsGnf0y6uHr85PbD5g@mail.gmail.com>
Subject: Re: [PATCH] iio: ad5504: Fix setting power-down state
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 13, 2020 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  9 Dec 2020 11:46:49 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> > The power-down mask of the ad5504 is actually a power-up mask. Meaning if
> > a bit is set the corresponding channel is powered up and if it is not set
> > the channel is powered down.
> >
> > The driver currently has this the wrong way around, resulting in the
> > channel being powered up when requested to be powered down and vice versa.
> >
> > Fixes: 3bbbf150ffde ("staging:iio:dac:ad5504: Use strtobool for boolean values")
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > Stumbled upon this while looking at something else. It is untested, but I
> > think it should be right. Alex can you double check?
>
> I read the datasheet as saying this fix is right but will wait for
> a confirmation from Alex.

Oh.
I see why the initial confusion existed.
Was confused a bit myself.
The thermal shutdown follows the initial/unchanged logic.
While the actual powerdown channel bits are inverted.

Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>


>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/dac/ad5504.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> > index 28921b62e642..e9297c25d4ef 100644
> > --- a/drivers/iio/dac/ad5504.c
> > +++ b/drivers/iio/dac/ad5504.c
> > @@ -187,9 +187,9 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
> >               return ret;
> >
> >       if (pwr_down)
> > -             st->pwr_down_mask |= (1 << chan->channel);
> > -     else
> >               st->pwr_down_mask &= ~(1 << chan->channel);
> > +     else
> > +             st->pwr_down_mask |= (1 << chan->channel);
> >
> >       ret = ad5504_spi_write(st, AD5504_ADDR_CTRL,
> >                               AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |
>
