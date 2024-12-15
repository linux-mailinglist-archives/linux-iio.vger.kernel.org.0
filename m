Return-Path: <linux-iio+bounces-13499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA24A9F2447
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419511886558
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45418DF93;
	Sun, 15 Dec 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThIo3FJr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CC1805A;
	Sun, 15 Dec 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734271555; cv=none; b=cFqQpjlRokFIX2HV7GVVHNio0kcoxHSP8fGYNiIWXcBowKpQ2xlddMYTOPNMsP2zUll/Fk3qbQ0juWU9kZhcDRG5eJ9lDdsZSUEGyuaafLZTCd6FLlPLbtvMoRf2KcORtwbVhZ/XwgzNZCJ1DP7UlfXgQK9HfB4JXI9lNTU/b7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734271555; c=relaxed/simple;
	bh=3W3WefVFDr1GkD6oxAqAtFaVoza7nW7apJ541UPn/Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCBPF/76hhdsK3jUa36tl4s9yu72tDjvG6wSiBgxGNb4777NaLEHtKjxxsBdBwmdGmzNoiblGoMynGVxio+qbQB4a+HuEAUYJkClkEAf7rEwJFdPJN4BruVvK+NziPWEuYKeoidphUKOE8HYbFmPU/xNE0TkqLrtsZirBpc9EF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThIo3FJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194D5C4CECE;
	Sun, 15 Dec 2024 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734271554;
	bh=3W3WefVFDr1GkD6oxAqAtFaVoza7nW7apJ541UPn/Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ThIo3FJro1sn1A6x0LXs7FrLZmVYRZ0dRDb5u7+Qyb4mFBP6jmT4y3147wjfsBLft
	 PG1F8XRy/gT/LFvjcsNN34rEkfxqK8lb7sASOZeKzSW65bRbSRW4aLOjraVU7N4ppM
	 Ok8iU5CrwC7uP3PeTgr43i8SQmPzFa5p54bzjkAc5SieMomodSLp1oz4htsjUdGbKF
	 NwT90CnUtQXMTZ/cLHazZllmqbryadfSehvuLwvafnHMoin3juyTXnWGsHiOISXo/j
	 LwOIl3zbVdDtyJsDsQopB/u74FSI1O8KqeL/pAG9gDlXwd61oD34EqFBWF23CB15Ts
	 jaV5+hfR2Wtww==
Date: Sun, 15 Dec 2024 14:05:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
Message-ID: <20241215140545.04562ad9@jic23-huawei>
In-Reply-To: <D6BJ0676105O.3LEEDK2CY9DHR@gmail.com>
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
	<20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
	<20241021193933.59c2d2b6@jic23-huawei>
	<7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
	<20241022192807.2f83dfa1@jic23-huawei>
	<3af77b51-d254-4c97-8faf-1dea29a4f9b1@gmail.com>
	<D6BJ0676105O.3LEEDK2CY9DHR@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 16:24:34 +0100
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Thu Nov 28, 2024 at 1:26 PM CET, Javier Carrasco wrote:
> > On 22/10/2024 20:28, Jonathan Cameron wrote:  
> > > On Mon, 21 Oct 2024 22:21:22 +0200
> > > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > >  
> > >> On 21/10/2024 20:39, Jonathan Cameron wrote:  
> > >>> On Sun, 20 Oct 2024 21:12:17 +0200
> > >>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > >>>  
> > >>>> The Vishay veml3235 is a low-power ambient light sensor with I2C
> > >>>> interface. It provides a minimum detectable intensity of
> > >>>> 0.0021 lx/cnt, configurable integration time and gain, and an additional
> > >>>> white channel to distinguish between different light sources.
> > >>>>
> > >>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > >>> Hi Javier,
> > >>>
> > >>> I missed one thing on previous review...
> > >>> There is no obvious reason this driver needs to provide raw and processed
> > >>> values.  Unless I'm missing something, just provide raw and let userspace
> > >>> do the maths for us.
> > >>>
> > >>> Jonathan
> > >>>  
> > >> Sure, I will drop that for v3. I added it because this driver took the
> > >> veml6030 as a reference, and that driver provides the processed value. I
> > >> guess that the veml6030 should have not provided processed values
> > >> either, but it's late to remove them after the driver was released.
> > >>
> > >> Now that we are at it, what is the rule (of thumb?) to provide processed
> > >> values? Those that can't be obtained from the raw data and simple
> > >> operations with the scale/offset/integration time/whatever userspace can
> > >> see?  
> > >
> > > Yes. If the conversion is linear, then leave it to userspace (with scale
> > > and offset provided). If it's not linear then in kernel because currently
> > > we have no other choice.
> > >
> > > There are some historical quirks where a processed only interface got in
> > > then we had to add raw later (typically when we added buffered output
> > > where scale and offset are important because processed values normally
> > > don't pack well).
> > >
> > > Jonathan
> > >
> > >  
> >
> > Hi Jonathan, I am bringing this back because I am not sure if dropping
> > the processed values was the right approach here. I would like to
> > clarify before propagating some approach that might not be accurate.
> >
> > This sensor is linear, and the processed value can be obtained by simple
> > multiplications, but not just raw * scale as documented in the ABI.
> >
> > This driver is based on the veml6030, whose processed value is obtained
> > as raw * resolution, where the resolution is completely linear and is
> > obtained as sensor_resolution * integration_time / scale.
> >
> > That means that the scale is actually a gain, and the user needs to know
> > the sensor resolution provided in the datasheet (see cur_resolution in
> > veml6030.c) to get the processed value. There is a sensor resolution for
> > every pair { gain, integration_time } in the datasheet, so there is no
> > need to calculate anything, yet the resolution is not provided by the
> > driver.

Ah. The ABI is defined such that the _scale should always be the value that
you multiply _raw by to get a the defined base units.   That means it
has to take into account anything that affects that - in this case that
means it incorporates the effect of that resolution table as well.



> >
> > Nevertheless, your comment on this matter was the following:
> >  
> > > Why both raw + scale and processed?
> > >
> > > We normally only provide raw and processed for light sensors if:
> > > 1) The conversion is non linear and hard to reverse.
> > > 2) There are events that are thresholds on the raw value.
> > >
> > > Here it is linear so just provide _RAW.  
> >
> > That is still true in this case, because it is a linear, easy to reverse
> > conversion. Nevertheless, the user needs to look for the sensor
> > resolution in the datasheet and then use the given integration_time and
> > scale.
> >
> > Is that ok and desired for light sensors? 

If we are talking about illuminance or other well defined scaled channels then
no it is not.  They must give a value in Lux when we multiply _raw * _scale
(ignoring offset).  It is messily defined for intensity channels as they
have no base units to target, but the principle should be the same.



> I think that a more accurate
> > approach would have been treating the gain as a HARDWAREGAIN, which
> > would have been used to calculate the scale i.e. resolution to directly
> > apply to the raw value. In its current form, the processed value is not
> > what you get if you do raw * scale.

That sounds like a bug that needs fixing because it is not compliant
with the define ABI.  It is messy as stated for intensity because in that
case PROCESSED in the ABI as it's largely meaningless.

>  But as you specifically mentioned
> > light sensors in your comment, that might not apply here. Moreover,
> > there are only two drivers (si1133.c and vl6180.c) that use HARDWAREGAIN
> > for IIO_LIGHT, which makes me think I am over-complicating thing here.

Hardware gain must not be part of what is necessary to compute a value
in userspace. It is not the ABI specified way of doing it which means
zero software will do it right.  Any change to that is a break in 
backwards compatibility of the ABI. The cardinal rule of Linux is we
never ever do that. Note not breaking the subsystem ABI comes above
not breaking backwards compatibility of a given driver.

We have relaxed things a bit to say that in some cases it can be used
to provide some useful 'debug' info on a channel setup, but _scale * _raw
is still the only way to get to the defined ABI.

> >
> > By the way, in_illuminance_hardwaregain is not documented in the ABI,
> > only out_voltageY and in_intensity. But that is another topic.

We should indeed add it.

> >
> > The veml6030 has been around for some time and there is no way around
> > without breaking ABI, and the veml3235 has been only applied to your
> > tree and maybe it could wait to be released.

If the reporting is wrong wrt to the defined userspace ABI then it's
a bug fix and unfortunately that means we might break users :(  There
is no good way to fix these.

> >
> > If everything is ok as it is, then that's the end of the story, but if
> > the processed = raw * scale operation should apply, the veml3235 could
> > still be fixed. And when it is too late for that one too, then I could
> > follow a different approach for the veml6031x00 I recently sent to avoid
> > propagating the issue.

Definitely good to fix the veml3235 and we can also fix the older driver
as this is simply a bug (one of the few valid reasons for an ABI change).

> >
> > Thanks and best regards,
> > Javier Carrasco  
> 
> Hi Jonathan, this email might have gone unnoticed.

Yup. Sorry. I had an email sanfu and ended up with my whole inbox marked read.
May have missed a few mails as a result.

> 
> This issue is relevant for the veml6030 and veml3235, and also for the
> veml6031x00 under review, as it follows the same pattern. Do you think
> they are ok as they are? Probably not, as they don't follow the ABI
> documentation, and after reading some other reviews, HARDWAREGAIN is
> usually not the fix for something like this.
> Should the gts helpers be used instead?

They need to be fixed so they follow the ABI. GTS may well help with that
as Matti wrote it to address this complexity of too many ways of making
changes that affect the scale.  It is also valid under the ABI to restrict
things to simpler case of integration time etc being controlled directly
and the _scale just updating when you change them as long as you update
scale_avail as well.  That's ugly interface but not 'wrong' which is why
Matti created something more user friendly.

Jonathan

> 
> Thanks and best regards,
> Javier Carrasco


