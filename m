Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA32E39676E
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhEaRvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhEaRvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 13:51:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD7AC068EF8;
        Mon, 31 May 2021 10:42:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v8so11860087qkv.1;
        Mon, 31 May 2021 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=1DXVQRpeGSXh+WGF/b+ku0W0v/EoLnt0HIACBq7fscs=;
        b=D5TvIJgVHWXIOZl6WJKyyX6nNI5Sn0nhSukA/2sZSG1HilepNiKnHQeU8cgzER0kX4
         wKKsbN408yvDNeXdO18RZpO6hNADDiGd12iG7u6VhjT1Lkb7/U0AzDs5F99qKoJkRYE5
         WZnBecAbOQHEIpmv5ERI5xyZ7gEFX81B0aA/B8wQdQ1pnof+QoEzJRRhuPl/4vlChtDI
         EhQP1MLJr7hYeMohSp94qaspFSsXL/ItXS6TOB8eZ1Te2cbyGYo8dINY0WBmvtKk9IOr
         QKLyK6oaqertQul02H7f34o2YtESVXmFvQQ8AjOF9PMu2/lVKt0BrRtk75I6XXCU0QMe
         0SJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=1DXVQRpeGSXh+WGF/b+ku0W0v/EoLnt0HIACBq7fscs=;
        b=atIwgdKTSy1LwWjKExQ6xmbRsB4UO3RsorBd6YLjMl9pOMcY1YHsx+tpmI2r7xf+L7
         gCTb9MAkctfO1d0z5mByfyg4dK/xxsYCblfCHnyEBCAGjm2AbbRFQkWRh43WDDButhTK
         bVVCW9bRBrgY5aj1eTLLq1KWs+pZf/LiYTUduWhGZIp5Jqasuvw9psZO/YXw6ZC6MEDx
         wOcvlB8TPVMJ/67jqt0vji82WJOhm8fGlS+/1Gwq6GXel7e6lWkaOU+2ROVCQ3Lycn1h
         tMTs3B8NXh7uy2xJzaE5zf09HaRJzG+7BYcCkOGLOGnTq023BzJfRKIHONLoH5IWh+Gg
         8eTA==
X-Gm-Message-State: AOAM530bOo86r3nelFwepJPaKNEPaGI84iTIKos1FbSR1yIPC9Y5FKcm
        HZ26Tvxh+MQGpuM+wseIJJI=
X-Google-Smtp-Source: ABdhPJwTpraklzFcf6oltpQmXYZQnVbfsba8rcjX5W9O3d5hYEeNJQnZ34CzazfdM7MRjPqITWyDhg==
X-Received: by 2002:a05:620a:12c6:: with SMTP id e6mr16964196qkl.59.1622482930329;
        Mon, 31 May 2021 10:42:10 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id e12sm8055078qtj.48.2021.05.31.10.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 10:42:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 13:42:09 -0400
Message-Id: <CBRM73TM4R3Z.12A8GEYTETFNG@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-5-liambeguin@gmail.com>
 <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
 <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
 <01f8d320-05ae-1178-151a-d0d11a23bb55@axentia.se>
 <CBRIK3PI2AMD.3KUD7EI7NJ2EB@shaak>
 <ca30e3d2-7d9a-1c9d-9ae5-beefa2cd6492@axentia.se>
In-Reply-To: <ca30e3d2-7d9a-1c9d-9ae5-beefa2cd6492@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon May 31, 2021 at 12:25 PM EDT, Peter Rosin wrote:
> On 2021-05-31 16:51, Liam Beguin wrote:
> > On Mon May 31, 2021 at 10:08 AM EDT, Peter Rosin wrote:
> >> On 2021-05-31 15:36, Liam Beguin wrote:
> >>> Hi Peter,
> >>>
> >>> On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:
> >>>> Hi!
> >>>>
> >>>> Thanks for the patch!
> >>>>
> >>>> On 2021-05-30 02:59, Liam Beguin wrote:
> >>>>> From: Liam Beguin <lvb@xiphos.com>
> >>>>>
> >>>>> This is a preparatory change required for the addition of temperatu=
re
> >>>>> sensing front ends.
> >>>>
> >>>> I think this is too simplistic. I think that if the upstream iio-dev=
 has
> >>>> an offset, it should be dealt with (i.e. be rescaled). The rescale
> >>>> driver
> >>>> cannot ignore such an upstream offset and then throw in some other
> >>>> unrelated offset of its own. That would be thoroughly confusing.
> >>>
> >>> I'm not sure I fully understand. The upstream offset should be dealt
> >>> with when calling iio_read_channel_processed().  That was my main
> >>> motivation behind using the IIO core to get a processed value.
> >>
> >> You can rescale a channel with an offset, but without using processed
> >> values. I.e. the upstream channel provides raw values, a scale and an
> >> offset. The current rescale code ignores the upstream offset. I did no=
t
> >> need that when I created the driver, and at a glace it felt "difficult=
".
> >> So I punted.
> >=20
> > I understand what you meant now.
> >=20
> > At first, I tried to apply the upstream offset from inside the rescaler=
.
> > As you said it felt difficult and it felt like this must've been
> > implemented somewhere else before.
> >=20
> > After looking around, I noticed that the code to do that was already
> > part of inkern.c and exposed through iio_read_channel_processed().
> > If the upstream channel doesn't provide a processed value, the upstream
> > offset and scale are automatically applied.
> >=20
> > So with the changes in [3/9] the rescaler's raw value becomes the
> > upstream channel's processed value.
> >=20
> > This seems like an easier and probably cleaner way of adding offset
> > support in the rescaler.
> >=20
> > Does that make sense?
>
> Yes, it does. Doing generic calculations like this efficiently with
> integer math without losing precision is ... difficult.

You're right, I realized it's more complicated that it seems working on
this.

>
> I think that perhaps IF the upstream channel has an offset, the
> rescaler could revert to always use the upstream processed channel in
> preference of the raw channel. That would fix the missing support for
> upstream offset and still not penalize the sweet case of no upstream
> offset. Because the processed channel costs processing for each and
> every sample and I think it should be avoided as much as possible.
>
> Does that make sense?

Totally, I see what you're saying and will give it a try.

I still believe it would make sense to get the upstream scaling factor
the same way, to avoid duplicating that code.

Also it might be confusing to have the raw value be the upstream raw
value in some cases and the upstream processed value in others.

>
> Or are a bunch of drivers adding an explicit zero offset "just because"?
> That would be a nuisance.

A quick search seems to indicate that this isn't the case.

Thanks for your time,
Liam

>
> Cheers,
> Peter

