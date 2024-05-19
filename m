Return-Path: <linux-iio+bounces-5095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C975A8C9487
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502E21F216FB
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855543AD9;
	Sun, 19 May 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TujBlMPm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEA8BEA
	for <linux-iio@vger.kernel.org>; Sun, 19 May 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716119588; cv=none; b=IA+h1/B9Qkz11HcQh4SwmYDBk3Zy+02449V7ZyyBH1agvWK4MTQnxvAMT9o0G8Wu6mFxJlBvza4gNLp9pQHp1/EXePgXaQIlzwVDUEWjL6oUg8oYaIiPjFS9RUX0/jKnwi2DHeJ3ie9X3tscntfSyUd6ChXwdo+o/CLQsnFtNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716119588; c=relaxed/simple;
	bh=JXEOVZlPLkBkhxRrfdrh71uo1KFA1k/2+dbDEAofL0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUOLKAI5Z9Xc87OsCdGxyDDVAqr5WXAYHK/2GGwCgpq53/h8+bLSXq7p/sVacAEi6fMZgbw23w/8q88FIqWpi+ts8id4hrGC5//MU9UoWmoJK1M369LCux97JXtQkPRsyhPJkrV9Wncdg2nwrR6p71WcKxVblVy8Gf8gRX/0YNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TujBlMPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1C7C32781;
	Sun, 19 May 2024 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716119587;
	bh=JXEOVZlPLkBkhxRrfdrh71uo1KFA1k/2+dbDEAofL0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TujBlMPmkbMCYdO9bV14QIG6pfCWZbIb8dvAyz06Dl7VJIzmBHbNoePc08yftZPmN
	 OffM2IFLsE2BkTLCDkcflT0sAOQbu2+6S2DV+eJm5cmp7B4cq4zqRYkvjr1MVwvMfX
	 D1M+EmdryG5tD++QsAkeLWliA+H8fjqefcjVZ42n27skQzBoBqn6FDjqZIRuXbg4VZ
	 USCwpwlEqOGRkevYU4+Gbv6CxmqmJ+201SrU91tFspjt91aFFDZH29yg9m2NAxO8uO
	 mtGq885c1eG4zcWVKOldB/TKuuDFu6vdIqyO6iR2Xqw8X3MBCTx45X5v94MidwkKos
	 s8boRsFM//UUA==
Date: Sun, 19 May 2024 12:52:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, INV Git Commit
 <INV.git-commit@tdk.com>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Message-ID: <20240519125253.6a548bc0@jic23-huawei>
In-Reply-To: <FR3P281MB175734C16B7C8F430874A866CEE22@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240507103056.291643-1-inv.git-commit@tdk.com>
	<20240509141326.00000684@Huawei.com>
	<FR3P281MB175734C16B7C8F430874A866CEE22@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 09:18:34 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> sorry for the patch malformation, I will send a V2 fixed.
>=20
> Our chips have usually 2 working modes called "low-noise" and "low-power".
>=20
> "Low-noise" is the standard mode where the chip (ADC/MEMS) runs continuou=
sly with high precision oscillator. Measures are the best with the less jit=
ter (low noise), you can use the highest possible frequencies (> 500Hz), bu=
t power consumption is high, and you cannot use the lowest frequencies (< 1=
2.5Hz).
>=20
> "Low-power" is duty cycling the chip, turning ADC and MEMS on only when m=
easuring and then turns it off. Power consumption is then much lower (low p=
ower), you can use the lowest frequencies (< 12.5Hz), but measures have mor=
e jitter, and you cannot use the highest frequencies.
>=20
> Depending on the use case, you may prefer to have the "low-noise" mode wi=
th better measures and high frequencies, or the "low-power" mode with less =
power consumption and low frequencies. The main point is the frequencies av=
ailability depending on the power mode.
>=20
> We could have the driver switching automatically from low-noise to low-po=
wer to support all possible frequencies, but we need to arbitrary choose th=
e mode for the common frequencies, and the configured hardware bias in bias=
 registers are not the same depending on the power mode. We prefer handling=
 all this from userspace, switching the mode when needed depending on the u=
se case and dealing with the 2 sets of hardware bias depending on the modes.
>=20
> I hope I am clear enough with my description.
>=20

Whilst I understand the motivation, the problem with this is that most user=
space
software will have no idea what these controls do. It is very challenging=20
to provide enough discoverability to userspace because these modes tend to =
have
weird and wonderful side effects (e.g. the hardware bias here).

So I'd very strongly suggest at least a 'default' option to figure it out f=
rom the
requested frequencies probably defaulting to low noise on the common freque=
ncies
- "when in doubt give the best possible data".=20

With that in place, I'd be more likely to be persuaded of the need for a
'tweak' bit of custom ABI that overrides this automatic parameter setting.
Thus things would work as well as possible for normal software, and advanced
software, by which I mean your userspace stack, would have access to a way
to bias the low power / low noise decision in the common frequencies.

The sticky bit here is that hardware bias. I'm assuming that is what we
are controlling via calibbias?  If so is there any sane way to relate the t=
wo
sets of bias values?
Normally (I think) that stuff is about fixing variability in the analog
signal part of the device, so I'd expect any change in value to be predicta=
ble
unless there is something odd going on with digital filtering perhaps?

Finally I do wonder how often people use those mid frequencies where there =
is
a direct choice.  In broad terms the reason for low power is to do detection
of background stuff - screen rotation etc in which case they'd also pick low
frequency to save even more power. The low noise modes are for when the pre=
cise
data matters a lot more and those tend to also need at least moderately high
sampling rates because people are typically running some sensor fusion on t=
op
and accurate data but at low frequency is usually no good for that unless y=
ou know
something is mechanically filtering the motion (i.e it's fine on measuring =
shaft
rotation on something with lots of inertial, not so much human motion).

Jonathan

> Thanks,
> JB
>=20
>=20
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent:=C2=A0Thursday, May 9, 2024 15:13
> To:=C2=A0INV Git Commit <INV.git-commit@tdk.com>
> Cc:=C2=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metaf=
oo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptist=
e Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Subject:=C2=A0Re: [PATCH] iio: imu: inv_icm42600: add support of accel lo=
w-power mode
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Tue,  7 May 2024 10:30:56 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Add channel attributes "power_mode" and "power_mode_available" for
> > setting accel power mode (low-noise or low-power).
> >=20
> > Differents ODRs and filter are possible depending on the power mode.
> > Thus make ODRs and filter dynamic and check values when applying. =20
> Hi Jean-Baptiste
>=20
> No Sign-off?
>=20
> We have never provided this sort of control because it's near
> impossible for user space to know what to do with it.
>=20
> Various attempts happened in the past to provide enough info
> to userspace, but didn't succeed because what low power means
> is incredibly chip dependent.  As a general rule everyone wants
> low power, but at 0 perf cost :)
>=20
> What are the results of low power mode? Normally it maps as
> something we can enable when some other set of states is set or
> automatically control based on how often the device is being accessed etc.
>=20
> For example, what do we loose by choosing this mode for everything
> below 200Hz?
>=20
> I see there is some reference to 'low noise' - what does that actually
> mean for this device? Is it oversampling or running lower resolution on
> the ADCs?  If so those are the things to look at as ways to control
> this.  Choose lowest power to meet a given set of requirements.
>=20
> Jonathan


