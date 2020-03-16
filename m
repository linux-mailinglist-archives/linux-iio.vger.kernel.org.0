Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FB186645
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgCPIVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 04:21:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39620 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgCPIVo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 04:21:44 -0400
Received: by mail-io1-f68.google.com with SMTP id c19so15128290ioo.6
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2020 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZYO6PdRUaR2GzeYHtNLWRoMQgJ9+WJyqfFclTBz8Is=;
        b=Qdlvvbcj/qr4QzRGGZQWnxl9bC8JQb/EovzyCFwHoSeSq0PfsxKGU8msQitfHR6YHd
         JmAOwBxsdqyoTq07A6d+nkzEJxEhdMMOyC6iUvMBxrmz1c6j8VU6IGatnTIaD5zEWRMe
         DjkrQkqHgcGbO6Th22lb92dvS9hAWERdo5K+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZYO6PdRUaR2GzeYHtNLWRoMQgJ9+WJyqfFclTBz8Is=;
        b=A8cqsd6K40Rj30BEIl9QBfkQmAoXm4q8QOQk5x+qCLqMMTI7JQIN0t3T9J5QDSztEp
         Dd7GJzzNGINkEpFNeZDYTal3bTyLQ9dyKKlFTkaoBIqbe9an80z5rclLKhBVL/PxPt0J
         BXYAy7Yxx3hc+ZZru/IEKAUGiiuiqgpE1ZbHytzvyod2UebmmcrVyEVNawHmyjTEUgb3
         1e+r014T8LIV/8gck7zx3KuFhdaiAThzeMdRs66QhxPJlt+WVhaLELsru23Zqp6aFfar
         h47eciEDyBDUCQqzuWwxQaDQvSImFFekT578vU1VSzpDEouO9w2qEJtNQgZILMzC/2r4
         uwmw==
X-Gm-Message-State: ANhLgQ2uvfIDYVgpD8AawxtTzctcVy2LpHZgUnooqOHclpHHIxk7Dijt
        oUZmDZcWBbnV2+5NAWy7/W6WIbi5m1SFfffWwhGl3yKxlfk=
X-Google-Smtp-Source: ADFU+vusngpc29O5m0Xi8COoflqmamL0gNziA8vMQem/YIDZwQGt/+dNb/hGQXkepJsvZCJE/vipLoUtsvBzvFgREag=
X-Received: by 2002:a05:6638:103:: with SMTP id x3mr12142684jao.62.1584346902777;
 Mon, 16 Mar 2020 01:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com> <20200315094604.62dc96be@archlinux>
In-Reply-To: <20200315094604.62dc96be@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 16 Mar 2020 01:21:32 -0700
Message-ID: <CAJCx=gkZEDa5vg1R2gta9vERy2+W4vst0et0THO9Oth3d3Yzfg@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: remove mlock usage
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 15, 2020 at 2:46 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 10 Mar 2020 00:01:28 +0530
> Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> > Use local lock instead of indio_dev's mlock.
> > The mlock was being used to protect local driver state thus using the
> > local lock is a better option here.
> >
> > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
>
> Matt.  Definitely need your input on this.
>
> > ---
> >  drivers/iio/health/max30100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > index 84010501762d..8ddc4649547d 100644
> > --- a/drivers/iio/health/max30100.c
> > +++ b/drivers/iio/health/max30100.c
> > @@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> >                * Temperature reading can only be acquired while engine
> >                * is running
> >                */
> > -             mutex_lock(&indio_dev->mlock);
> > +             mutex_lock(&data->lock);
>
> Hmm.. It's another complex one.  What is actually being protected here is
> the buffer state, but not to take it exclusively like claim_direct does.
>
> Here we need the inverse, we want to ensure we are 'not' in the direct
> mode because this hardware requires the buffer to be running to read the
> temperature.
>
> That is the sort of interface that is going to get userspace very
> confused.
>
> Matt, normally what I'd suggest here is that the temperature read should:
>
> 1) Claim direct mode, if it fails then do the dance you have here
> (with more comments to explain why you are taking an internal lock)
> 2) Start up capture as if we were in buffered mode
> 3) Grab that temp
> 4) stop capture to return to non buffered mode.
> 5) Release direct mode.
>
> I guess we decided it wasn't worth the hassle.
>
> So Rohit.  This one probably needs a comment rather than any change.
> We 'could' add a 'hold_buffered_mode' function that takes the mlock,
> verifies we are in buffered mode and continues to hold the lock
> until the 'release_buffered_mode'.  However, I'm not sure any other
> drivers do this particular dance, so clear commenting in the driver
> might be enough.   Should we ever change how mlock is used in the
> core, we'd have to fix this driver up as well.
>
> Hmm.  This is really hammering home that perhaps all the remaining
> mlock cases are 'hard'.

Heh really had to look this over what I was doing since it has been
almost half a decade now :).

Think locking that mutex was only to prevent another read during the
temp reading, and not really
not sure how effective that is actually. Especially since the I2C
subsystem should handle those reads
in a queue like fashion.

- Matt

>
> Thanks,
>
> Jonathan
>
> >
> >               if (!iio_buffer_enabled(indio_dev))
> >                       ret = -EAGAIN;
> > @@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> >
> >               }
> >
> > -             mutex_unlock(&indio_dev->mlock);
> > +             mutex_unlock(&data->lock);
> >               break;
> >       case IIO_CHAN_INFO_SCALE:
> >               *val = 1;  /* 0.0625 */
>
