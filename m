Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED87396517
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhEaQWn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbhEaQT7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 May 2021 12:19:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C0C02C3FA;
        Mon, 31 May 2021 07:51:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t20so8063697qtx.8;
        Mon, 31 May 2021 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=ssQk50PTKdi25HhTNegK8mdpJbFiFprG9dU8Lz4nRig=;
        b=tyPc2tC8hY7r94PkE8Tw2rk/SppuuKTHGqtiEHeKdt/jcKIrFvQG5L+hsu2lHNzOqk
         R0fQ3AD9OK44Y08gaHfts7ZFOiwO+dH/EKNWTH9pfasRkWp9ruJdDFML+OtEoEBY4GCC
         REIQOWYgucCyDskHwxEmPfl1o2y4GTgl3/OdisSSLQIOORR4HoH3W1/kqn07q+iysPzD
         1dqT9bt434JnIkGHHwLNPVqovhYDwjJvO4ZV+4huHPglq2ao7ttfmPvE1l0P3SXfzLeg
         8e2gdPxQjiy4zEUzPyDSZMyvAmXvQHNQmX3DzVtV7MwOZ9LPS33BnR5SpSyoOqTYHJfg
         x81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=ssQk50PTKdi25HhTNegK8mdpJbFiFprG9dU8Lz4nRig=;
        b=lvGhgDS74zDD+zjS3wveV/80FKeaxNYXr7AQY5YnytYJxdVA5BTIl/ksWLtXm0gqNa
         PZGN5aP+tMK8zW2d5xU9HmRBumsdaFbVzpAbpjkkkA8z88upRwWTPOITNzdvlm+TF0wb
         CINMrdfz4QhB0BW61rKlphdfhfQlEnZT/5n64I/FIbDWEZI6rusF8kjC+ucUWN9YPTLs
         VZRdDFuM0XVdygIr2BFY8Dy94WQuxdRQU3TB4YgOg7/7u+lRDndVbD+9L47yfLyc9LPJ
         IcuvUsLg4zXpNBLyjsbEG5yotmjnHqEifa301qdE3nl5RuNXNuJdarUek8q5zaS56INj
         r55g==
X-Gm-Message-State: AOAM532lPGx00dajnF/tBuz6U0ICFtg857CoJEiEFS/S+Xelou7dEaBC
        /rEVhIVJD/gn+85Cqtkqj8c=
X-Google-Smtp-Source: ABdhPJxA5jtSrWweYQVE1RYBNT1/CViJtlqhB9Ezr0lyICULe5bnFyX/C/wzwB+iE6IDto8hPLOa1g==
X-Received: by 2002:ac8:7f42:: with SMTP id g2mr15278445qtk.73.1622472664501;
        Mon, 31 May 2021 07:51:04 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id b123sm9541572qke.87.2021.05.31.07.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 07:51:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 May 2021 10:51:03 -0400
Message-Id: <CBRIK3PI2AMD.3KUD7EI7NJ2EB@shaak>
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
In-Reply-To: <01f8d320-05ae-1178-151a-d0d11a23bb55@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon May 31, 2021 at 10:08 AM EDT, Peter Rosin wrote:
> On 2021-05-31 15:36, Liam Beguin wrote:
> > Hi Peter,
> >=20
> > On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:
> >> Hi!
> >>
> >> Thanks for the patch!
> >>
> >> On 2021-05-30 02:59, Liam Beguin wrote:
> >>> From: Liam Beguin <lvb@xiphos.com>
> >>>
> >>> This is a preparatory change required for the addition of temperature
> >>> sensing front ends.
> >>
> >> I think this is too simplistic. I think that if the upstream iio-dev h=
as
> >> an offset, it should be dealt with (i.e. be rescaled). The rescale
> >> driver
> >> cannot ignore such an upstream offset and then throw in some other
> >> unrelated offset of its own. That would be thoroughly confusing.
> >=20
> > I'm not sure I fully understand. The upstream offset should be dealt
> > with when calling iio_read_channel_processed().  That was my main
> > motivation behind using the IIO core to get a processed value.
>
> You can rescale a channel with an offset, but without using processed
> values. I.e. the upstream channel provides raw values, a scale and an
> offset. The current rescale code ignores the upstream offset. I did not
> need that when I created the driver, and at a glace it felt "difficult".
> So I punted.

I understand what you meant now.

At first, I tried to apply the upstream offset from inside the rescaler.
As you said it felt difficult and it felt like this must've been
implemented somewhere else before.

After looking around, I noticed that the code to do that was already
part of inkern.c and exposed through iio_read_channel_processed().
If the upstream channel doesn't provide a processed value, the upstream
offset and scale are automatically applied.

So with the changes in [3/9] the rescaler's raw value becomes the
upstream channel's processed value.

This seems like an easier and probably cleaner way of adding offset
support in the rescaler.

Does that make sense?

Cheers,
Liam

>
> But if the rescaler is going to start to handle offsets of any kind, it
> will get very confusing if the upstream offset is ignored. The proper
> way to do that is not something I have thought deeply about, and I
> don't know what the proper behavior is. For a processed channel, the
> offset is baked into the value that is scaled. Maybe the sane thing
> is to do that for a non-processed channel as well? But that gets a bit
> ugly, as it is counter to the simplicity, beauty and efficiency of the
> rescaler driver. In the non-processed case the driver is just adjusting
> the scale value. But since we are talking about proportional
> relationships, it should be possible to rescale a non-processed
> channel with an offset by just adjusting the offset in some way related
> to the rescale factor. Doing it with integer math is the "difficult"
> part...
>
> Cheers,
> Peter

