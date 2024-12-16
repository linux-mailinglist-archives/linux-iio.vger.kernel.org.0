Return-Path: <linux-iio+bounces-13550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D139F389F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7C01898A5B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 18:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217772080C5;
	Mon, 16 Dec 2024 18:04:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E1206F2A;
	Mon, 16 Dec 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372296; cv=none; b=IQ77Y+VJIG8lKVXLIs0uE0kKxbI/D4AEq1nbDPbRO06RbbMix/J2pJrJnoxeLuZinsXYKYhoNbLE5ypxucNuOcX0DJ4QD9h1q8r1nrXuq/5yxTURyOL/tYmtod3Qy/ys8JyO+oUpXSGaUZ5NoQ0+l6ABdc6k2u2lyVkP0VIDoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372296; c=relaxed/simple;
	bh=lbDKXZznI9n6wkxDq7JwPrVXZIpy9akRDVPtvwb2q08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWXmKsorND1leTERKCH+mlbi/mmTS8YZfIrTjNh05ixwtcWWiCqxxWlckT6LEPHkzdHl/mZHC0f8jVCB6kKK2Z/qf6djYo+CDwV8LmXagGNXpfiqGJexq9J8fiPJSn8fGBVPmvdsO7lUQaM/J7gRP+LgcJiMUR3ySMgKRrJKsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3778bffdso4664280e87.0;
        Mon, 16 Dec 2024 10:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372291; x=1734977091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVbLtKhMVH3E9RE9EdOfJwHW403nkaRVF2RmkmWG7DY=;
        b=o59OQ73GN1yY0eO6dRwEzU8k9RkRQl1sU2VKg1b67H/abgzCpx9EOqL+a9bOJQypak
         sdHnZsZ3MxpPaAr4+ZQ92qAfX7hBE5Yet7PpPCzHo1fjUMVQnZoDO4WjYsdz1c9nmfrk
         1p+HOTsa5Hrf/eDxSM9yWxIwqIMcTt7sn6gn6m0q20ZuPOjlZiDS8dphBjpGIy4LUG3w
         9+N84TEMmoJBOW5RK1qwi6v+Ya9ub7+USbhJ9og3IgaIIcvAF4OI0VLJZEEeDTTjoOUc
         2nSRpMP2eLaZxu/Hy3JGsVNnel3zEeHFgSMyrCrQs/N5/VWtKNzjkHIMA6d1Nv21OK/h
         +HuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUeMgeYEm3I4RWqa+INIhxOhDdyUndLO5UHFdoaQWrnwnWDrycGCqhFWa5zB+NgS4U18E8qtun6Q=@vger.kernel.org, AJvYcCXvUn1VSdczli3LzzRaGVjsAaGN2x8r7azR5vvQtX5EGGNTdju8tFevrNnWu0v2jniko/m0EUl0cf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmsyVJ8sHzX1dFdCC2rXKZ0uctaUhXso97VxGy0FrpGNvKLZ6
	9+IZFIQ6suQjvuZpVbgU+lUdEH/3hYGiteAy5Lv2lao2Gpx4mkehyZLNyQeVKKw=
X-Gm-Gg: ASbGncvXZxvuQ38lW38CLFijHHRWN/7Cg5F6WyNf1OpY8suhDF2BUlGmcChX2od9ToG
	6MbQoabr9PEVF0c8fGgU0GDEVDw9HnBmXJjTtGl0ypRNr7Ihn+4YIyB5SmhQzq+Ucx8wqF+2UHF
	ruasSxvB91t5L+rJPROfPE8QK/Cd6HGJrObbllpJAg+O9hrrieetACldlxq/GjPmCbW+B8ygkax
	gU67aJNB5dYtd5Rs/vHm/jWoHp5t3EBr+rW92ByOlB+s/kG51xGE37lxCg4qSE1Lky8+gkhvpc7
	BYsadX9bj47qdA==
X-Google-Smtp-Source: AGHT+IHxHl6yJiEQBoO6PB3nbkowmZVvB11xefeOSGFbAGUnm548f4pgsGUNC8xYdlX3RAdX/RaYBQ==
X-Received: by 2002:a05:6512:3c9d:b0:540:3561:8854 with SMTP id 2adb3069b0e04-5409054d67emr4149901e87.17.1734372290713;
        Mon, 16 Dec 2024 10:04:50 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c0026dsm929567e87.113.2024.12.16.10.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 10:04:50 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso54459861fa.1;
        Mon, 16 Dec 2024 10:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVJp08ILYeWr43S3q20d5UAticpHIfr7Aybl12mw7ySG2oOuloFZpv+g4J8UGb0QSVBsuvWK/dNLg=@vger.kernel.org, AJvYcCVYJNm+H6oUXIhAqBgAOzWzSENUMy0nyOMQkqi+GYMWpQz1U+kORQU705wHaNNe2i3JBhjn10KJPjM=@vger.kernel.org
X-Received: by 2002:a2e:a78a:0:b0:302:18fa:3be0 with SMTP id
 38308e7fff4ca-30254462719mr40946051fa.22.1734372289996; Mon, 16 Dec 2024
 10:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210224859.58917-1-macroalpha82@gmail.com>
 <20241211215826.06162190@jic23-huawei> <67606b09.050a0220.3905d.5bc7@mx.google.com>
In-Reply-To: <67606b09.050a0220.3905d.5bc7@mx.google.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 17 Dec 2024 02:04:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
Message-ID: <CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
To: Chris Morgan <macroalpha82@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	andre.przywara@arm.com, lee@kernel.org, sre@kernel.org, lars@metafoo.de, 
	Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:01=E2=80=AFAM Chris Morgan <macroalpha82@gmail.co=
m> wrote:
>
> On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote:
> > On Tue, 10 Dec 2024 16:48:57 -0600
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > >
> > > After performing a git bisect, I identified a commit that broke the
> > > battery and charger driver for my AXP717 PMIC. This was caused by
> > > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> > >
> > > After digging into it, it appears when mfd_add_devices was called wit=
h
> > > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
> > > made by the various AXP20X power drivers would not be able to generat=
e
> > > a dev_name(dev) for some reason, and the iio_channel_get() call used =
in
> > > the devm_ helper would fall back to making a iio_channel_get_sys()
> > > call. After the platform ID was updated, now iio_channel_get() is no
> > > longer falling back to iio_channel_get_sys(). At least this is my
> > > limited understanding of what happened.
> >
> > The dev_name(dev) not getting a name doesn't sound quite right to me.
> >
> > Time to look at the ancient creaking ghost that is the iio_map handling=
.
> >
> > struct iio_channel *iio_channel_get(struct device *dev,
> >                                   const char *channel_name)
> > {
> >       const char *name =3D dev ? dev_name(dev) : NULL;
> >       struct iio_channel *channel;
> >
> >       if (dev) {
> >               channel =3D fwnode_iio_channel_get_by_name(dev_fwnode(dev=
),
> >                                                        channel_name);
> >               if (!IS_ERR(channel) || PTR_ERR(channel) !=3D -ENODEV)
> >                       return channel;
> >       }
> >
> >       return iio_channel_get_sys(name, channel_name);
> > }
> > EXPORT_SYMBOL_GPL(iio_channel_get);
> >
> > We didn't invent the relevant phandle stuff in DT via the patch you poi=
nt at
> > so all that matters is what gets passed to that iio_channel_get_sys()
> >
> > So key here is that dev should be set, so we are passing dev_name(dev) =
into
> > iio_channel_get_sys()
> > I'm guessing that changed...
> >
> > Ah.  The iio_maps in
> > https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp20x_=
adc.c#L158
> > are our problem. Those hardcode the consumer_dev name. The fix just cha=
nged
> > those names. Back when this infrastructure was written we were in the w=
orld of
> > board files, so everything was hard coded in them - or in an MFD like t=
his
> > it was treated as a singleton device.
> >
> > So as to how to fix it... Assuming the new device names are the same fo=
r all
> > the mfd parts that make up each pmic, then you should be able to figure=
 out the
> >  extra the number and build the channel maps to allow you to find the n=
umbered
> > devices.
>
> Is there a way to figure out the device number at runtime? The issue is
> each time the device attempts to probe and fails, the device number
> increments, making it a "hitting a moving target" problem.

The ADC device is a mfd cell or child device of the PMIC mfd device.
So you should be able to use dev->parent to get it directly? We do
that at least for the regulator driver.

ChenYu

> Thank you,
> Chris
>
> >
> > That's a lot lighter change than moving over to DT based phandles for a=
ll this.
> > (which is the modern way to handle it).
> >
> > As a cheeky check, just edit those maps to whatever IDs you have and se=
e
> > if it works.  Probably not an upstreamable solution but will confirm we=
 have
> > it correct.
> >
> > Your patch works because we allow for some fuzzy matching (I can't reme=
mber
> > why) that doesn't use the consumer device name.
> > That works as long as there is only one instance.  I'm guessing all thi=
s
> > mess came about because someone has a board with two of these devices. =
On such
> > a board we need the precise matching including the device name.
> >
> > Jonathan
> >
> > >
> > > To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
> > > that directly calls iio_channel_get_sys(), and I updated all the
> > > affected drivers with the new routine. I then no longer experienced
> > > any issues with the drivers on my devices.
> > >
> > > Chris Morgan (2):
> > >   iio: core: Add devm_ API for iio_channel_get_sys
> > >   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
> > >
> > >  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
> > >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> > >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> > >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> > >  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
> > >  5 files changed, 51 insertions(+), 13 deletions(-)
> > >
> >

