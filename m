Return-Path: <linux-iio+bounces-611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D64803EDC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 20:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2C2281167
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A471C33088;
	Mon,  4 Dec 2023 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="fhmp8oun"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442AD2
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 11:57:15 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58cecfb4412so3320625eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2023 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701719835; x=1702324635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SBTfgpI7c2ac59dT9wiC8J/GPNEeE/8u5o5TG4ssEQ4=;
        b=fhmp8ounvakzsyada1KC6PTtZwKjGMLx0HfFFzpB3k0J5DYAn4tTZYmuYo27TMfu6P
         AC+sDKWTPHkSW6suXieYbQ7yM+1o3gCKpZUz4BmO9/wCrfNqLsvXb8js0hNdvDbqXH/R
         P0guMe/VWq0OM37JM9rEyzwow4STHG/d9cl/FM5hypwUcRUeEbI91AEjmjc776eN2knv
         vtlm5F3d0TtPTWQEqRlgVwAN8/Lw9WOJY07FTy65c6nRRhaZBu5zNtkbK7ZsjlTSZ545
         qpWXIzjGPmNpuoOoV6DOQatQX8yO8HOervIKBBuGNrqPUFin0z6xGwdi/hLLA7BsVCJ8
         t0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719835; x=1702324635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBTfgpI7c2ac59dT9wiC8J/GPNEeE/8u5o5TG4ssEQ4=;
        b=eldRP6VLvkG79B7dv2I6KjQTfAv9s2MpvHMTeaeJK0YVozmmfC4AnEO6NATGLhWUaL
         GM/rQJND53X0HB4gf02YN456Mh8frg1sPQa+GeRVoE70hu5fTMHnW80+e1cpjGM65EZ2
         K7maYQdvVIS/0oQqjYEOvL0trlpI6JszXtVVEJ19Uo63/DZxtS+JBiJ8pX1r1AXNFJ1c
         VI+HNyalfbQs6YjERe44jaSFKaoIQAcfLLAQpVwTv998kEwYlc9AJO3SFftUDIHdCi+7
         TP+kinA1Zfh8VsrmXko6ezvW2Jlve1ovoOGhiNHcYyVG7nXDJ2ImC0ECjIddwJ9ZpDBi
         JNEA==
X-Gm-Message-State: AOJu0YwASZNLjDuZ6Oyg+1hsAcozSayBVlJ61K/HTFy5cQup/EAoWSHb
	fEJuBKTWRfHthwocfrWt233anWSo4s68BYzxO9RubQ==
X-Google-Smtp-Source: AGHT+IFOFahrQNa632EgBewrVs7SXeztT1nvDz+j8RxzpLp1TJG0AtGPq1vH8DB7jC4CehQb0sIPVHJSoNVZMFvqVIQ=
X-Received: by 2002:a05:6870:568c:b0:1fb:75b:2fd6 with SMTP id
 p12-20020a056870568c00b001fb075b2fd6mr5131473oao.109.1701719835169; Mon, 04
 Dec 2023 11:57:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701168726.git.cmo@melexis.com> <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
 <20231204142224.51f2ccdf@jic23-huawei> <CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
 <20231204170623.0c0cd598@jic23-huawei>
In-Reply-To: <20231204170623.0c0cd598@jic23-huawei>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 4 Dec 2023 20:56:39 +0100
Message-ID: <CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Dec 2023 at 18:06, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 4 Dec 2023 16:34:30 +0100
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
...
> > While in Sleep Step mode, the EEPROM is powered down, but the cache
> > buffers those values. Still when you try to write or read a volatile
> > register (which should not be prevented by cache enabled as per my
> > opinion, but code says differently) in that mode, it returns -EBUSY
> > (as we discovered by code), so this kind of manipulation is needed to
> > enable write and read operations from volatile registers.
>
> So the cache trick is just meant for the eeprom?  Can you use two regmaps.
> (I've seen similar done for devices with different ways of reading which
> this 'kind of' corresponds to).
> One to cover the eeprom and the other the registers that always work.
> That should let you separately control if they are in caching state or
> not.
> Or just read the eeprom into a manually created cache on boot?
>

It did not seem correct to create a manual cache, since regcache does
this job. I tried two separated regmaps, but when I tried to
initialize them I got into kernel panic/crash, so I could not get it
working on same device. Do you have any device in mind I could
template this against?

...
> > "invalid" data (shouldn't differ much, but I wanted to prevent that as
> > it might be 0).
>
> ok.  Just give a little bit more of that detail.  I'd not understood
> intent is to ensure one trigger -> one measurement.

OK.
> >
...
> >
> > Burst is from 90632 terminology (and our chip register map), but maybe
> > more general would be "trigger_measurement"?
>
> ok. But why only if in SLEEP_STEP?
>

Because in continuous mode (other mode used here) the measurement
table is constantly updated, so trigger is not useful and would only
slow down the reading. And I did not want to block the data retrieval
when person wants to read the data fast.

> >
> > > > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > > > +                                  unsigned int *refresh_rate)
> > > > +{
> > > > +     unsigned int reg;
> > > > +     int ret;
> > > > +
> > > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > > +             regcache_cache_only(data->regmap, false);
> > >
> > > Definitely needs a comment on why this is needed in this case.
> > >
> >
> > Here and below (where we turn it back to true?), but then I assume in
> > all other instances as well? Maybe a more general comment in the
> > sleep_step mode function?
>
> If we keep this, then yes I think we need comments on these - even if
> it's as simple as 'not accessing an eeprom register so we want to
> talk to the device'.

OK, then this is an option if I cannot make two regmaps work.

> >
> > > > +
...
> > changed we should end up in correct state. I can wrap a mutex around
> > though.
>
> Assuming regcache_cache_only() isn't refcounted, you could end up with a
> second copy of this racing through and accessing the data after the
> first one turned the cache back on so the -EBUSY your mentioned.
>

True. I will use mutex then for this action.

