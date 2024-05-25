Return-Path: <linux-iio+bounces-5287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AE18CF001
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D9C4B2108F
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5C84FB3;
	Sat, 25 May 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooGqySzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B81DFFC
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716653245; cv=none; b=Al29sssKOn/1Ye4ggeIjbVv47+4YqQ+gg+3Vh3tKqddoOIz3DZ9IvbCh9qZIyMzmzfQGAoqvlh14aTkRG4O190H/R2hHKABgPBfChI6ZG7EvYzJT5BvXruH9AZZxP7wG+MqnEIAIj+1dLjAggHZEW18bzooOm7yGMrG1y6mkxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716653245; c=relaxed/simple;
	bh=Qsk/qa/5fmiuCHqTpS2cPhuLlgGAJMLkK37HHspPWmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGHy9TUTsAAKyschqxyJXww2KtIpvIUmtV2bIrtBTAvWVV9Y+qhjLLss9PZlQU9sXHo7LU8ENMvP3IdZNnBLNLiDKdTxWyUVHz7mNzZQWZyJoLCKBnrX6ZjPfGMhElevHLao6z1GPa5zo1mhfQ3V0hFZo8/icPypglsmM1k+Ox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooGqySzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957A1C2BD11;
	Sat, 25 May 2024 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716653244;
	bh=Qsk/qa/5fmiuCHqTpS2cPhuLlgGAJMLkK37HHspPWmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooGqySzl9UI+rn2DbVwQOCUo4s37XQ5c5AFjaiA++6BvmFNMuHkj1IJBNXf2OzH/A
	 2szEMwkffOXCkTpSYaNW6i33dNx7UYN3red9uvycqtAQUa9/Hokorzp7/3YglS2E5c
	 hN+BE0TaRHCJ7PjHcN7PQ2D4j3YPGfLh8WQ886UqLPk/30d09FwcCk+O6eIEEpmTz8
	 1MxOHgvLRj+bFTRaakDZaS53QJ+Q+1m3oGoGmYPlybfT3KO7b33XyM731omXiM5h55
	 l2ICvaYGVCUjyzhDS2uP8ETDG6NN/1vnpK2UGtOsluAU1TBVABe2qe2Y7z0FTPdHr7
	 4DGZimbDVv8ew==
Date: Sat, 25 May 2024 17:07:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, INV Git Commit
 <INV.git-commit@tdk.com>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Message-ID: <20240525170711.30b32904@jic23-huawei>
In-Reply-To: <FR3P281MB17574BF058BCAC2CE087D154CEEB2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240507103056.291643-1-inv.git-commit@tdk.com>
	<20240509141326.00000684@Huawei.com>
	<FR3P281MB175734C16B7C8F430874A866CEE22@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240519125253.6a548bc0@jic23-huawei>
	<FR3P281MB17574BF058BCAC2CE087D154CEEB2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 May 2024 15:35:45 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> the hardware bias changes (inside calibbias exactly) is due to the
> noise differences of the 2 modes, introducing a little change in
> offset (these comes from the MEMS mechanical parts). This change
> cannot be anticipated sadly.
>=20
> Most of the time, the low power mode is used for accelerometer, since
> most used accelerometer features are motion monitoring in the
> background (pedometer, activity, ...). But high frequencies can be
> needed for very fast event like tap our double taps on the device.
>=20
> We could default to low-power mode and switch to low-noise mode
> automatically only for the high frequencies where it is mandatory.
> And we could add a sysfs entry like low_noise_mode to enforce
> low-noise mode for lower frequencies supporting it.
>=20
> This way traditional userspace can ignore the power_mode setup and
> use all frequencies. And only specialized userpsace components can
> set this low_noise_mode to have better noise values for specific use
> cases. For the hardware bias issue, the high frequency use cases are
> usually not impacted by the absolute offset, so it should not be a
> big issue.
>=20
> Is that OK for you?

The part about defaulting to low power mode where possible on basis
that's what is normally wanted makes sense.

A low_noise_mode switch for special users is a reasonable compromise
I think, but let's see if we get other replies on this or on a patch
implementing the above.

Jonathan

>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Sunday, May 19, 2024 13:52
> To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc:=C2=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>; INV Git Commit
> <INV.git-commit@tdk.com>; lars@metafoo.de <lars@metafoo.de>;
> linux-iio@vger.kernel.org <linux-iio@vger.kernel.org> Subject:=C2=A0Re:
> [PATCH] iio: imu: inv_icm42600: add support of accel low-power mode
> This Message Is From an External Sender This message came from
> outside your organization.=20
> On Mon, 13 May 2024 09:18:34 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>=20
> > Hello Jonathan,
> >=20
> > sorry for the patch malformation, I will send a V2 fixed.
> >=20
> > Our chips have usually 2 working modes called "low-noise" and
> > "low-power".
> >=20
> > "Low-noise" is the standard mode where the chip (ADC/MEMS) runs
> > continuously with high precision oscillator. Measures are the best
> > with the less jitter (low noise), you can use the highest possible
> > frequencies (> 500Hz), but power consumption is high, and you
> > cannot use the lowest frequencies (< 12.5Hz).
> >=20
> > "Low-power" is duty cycling the chip, turning ADC and MEMS on only
> > when measuring and then turns it off. Power consumption is then
> > much lower (low power), you can use the lowest frequencies (<
> > 12.5Hz), but measures have more jitter, and you cannot use the
> > highest frequencies.
> >=20
> > Depending on the use case, you may prefer to have the "low-noise"
> > mode with better measures and high frequencies, or the "low-power"
> > mode with less power consumption and low frequencies. The main
> > point is the frequencies availability depending on the power mode.
> >=20
> > We could have the driver switching automatically from low-noise to
> > low-power to support all possible frequencies, but we need to
> > arbitrary choose the mode for the common frequencies, and the
> > configured hardware bias in bias registers are not the same
> > depending on the power mode. We prefer handling all this from
> > userspace, switching the mode when needed depending on the use case
> > and dealing with the 2 sets of hardware bias depending on the modes.
> >=20
> > I hope I am clear enough with my description.
> >  =20
>=20
> Whilst I understand the motivation, the problem with this is that
> most userspace software will have no idea what these controls do. It
> is very challenging to provide enough discoverability to userspace
> because these modes tend to have weird and wonderful side effects
> (e.g. the hardware bias here).
>=20
> So I'd very strongly suggest at least a 'default' option to figure it
> out from the requested frequencies probably defaulting to low noise
> on the common frequencies
> - "when in doubt give the best possible data".=20
>=20
> With that in place, I'd be more likely to be persuaded of the need
> for a 'tweak' bit of custom ABI that overrides this automatic
> parameter setting. Thus things would work as well as possible for
> normal software, and advanced software, by which I mean your
> userspace stack, would have access to a way to bias the low power /
> low noise decision in the common frequencies.
>=20
> The sticky bit here is that hardware bias. I'm assuming that is what
> we are controlling via calibbias?  If so is there any sane way to
> relate the two sets of bias values?
> Normally (I think) that stuff is about fixing variability in the
> analog signal part of the device, so I'd expect any change in value
> to be predictable unless there is something odd going on with digital
> filtering perhaps?
>=20
> Finally I do wonder how often people use those mid frequencies where
> there is a direct choice.  In broad terms the reason for low power is
> to do detection of background stuff - screen rotation etc in which
> case they'd also pick low frequency to save even more power. The low
> noise modes are for when the precise data matters a lot more and
> those tend to also need at least moderately high sampling rates
> because people are typically running some sensor fusion on top and
> accurate data but at low frequency is usually no good for that unless
> you know something is mechanically filtering the motion (i.e it's
> fine on measuring shaft rotation on something with lots of inertial,
> not so much human motion).
>=20
> Jonathan
>=20
> > Thanks,
> > JB
> >=20
> >=20
> >=20
> > ________________________________________
> > From:=C2=A0Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent:=C2=A0Thursday, May 9, 2024 15:13
> > To:=C2=A0INV Git Commit <INV.git-commit@tdk.com>
> > Cc:=C2=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de
> > <lars@metafoo.de>; linux-iio@vger.kernel.org
> > <linux-iio@vger.kernel.org>; Jean-Baptiste Maneyrol
> > <Jean-Baptiste.Maneyrol@tdk.com> Subject:=C2=A0Re: [PATCH] iio: imu:
> > inv_icm42600: add support of accel low-power mode This Message Is
> > From an External Sender This message came from outside your
> > organization. On Tue,  7 May 2024 10:30:56 +0000
> > inv.git-commit@tdk.com wrote:
> >  =20
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > >=20
> > > Add channel attributes "power_mode" and "power_mode_available" for
> > > setting accel power mode (low-noise or low-power).
> > >=20
> > > Differents ODRs and filter are possible depending on the power
> > > mode. Thus make ODRs and filter dynamic and check values when
> > > applying.   =20
> > Hi Jean-Baptiste
> >=20
> > No Sign-off?
> >=20
> > We have never provided this sort of control because it's near
> > impossible for user space to know what to do with it.
> >=20
> > Various attempts happened in the past to provide enough info
> > to userspace, but didn't succeed because what low power means
> > is incredibly chip dependent.  As a general rule everyone wants
> > low power, but at 0 perf cost :)
> >=20
> > What are the results of low power mode? Normally it maps as
> > something we can enable when some other set of states is set or
> > automatically control based on how often the device is being
> > accessed etc.
> >=20
> > For example, what do we loose by choosing this mode for everything
> > below 200Hz?
> >=20
> > I see there is some reference to 'low noise' - what does that
> > actually mean for this device? Is it oversampling or running lower
> > resolution on the ADCs?  If so those are the things to look at as
> > ways to control this.  Choose lowest power to meet a given set of
> > requirements.
> >=20
> > Jonathan =20
>=20


