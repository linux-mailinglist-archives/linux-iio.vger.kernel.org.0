Return-Path: <linux-iio+bounces-22863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966AB293C2
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422A4206DA0
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02422FE06;
	Sun, 17 Aug 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O43iDTKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960D14EC73
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443430; cv=none; b=Ajg1R2v6zkYBshddmgkqgTsny4vZ9Yc6sGWdaTLgXZFtGnozXymOtZ0n9PwLPR5e11KQsguU8qO1IneEyvR+//V+N6qekzcSQkSRZ+96j+jDUYvxnEzXhWLpHEdEnmfzp44EpSY07wE8K6lgbYoOmvOUSoP8XeTnkSewdWum6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443430; c=relaxed/simple;
	bh=nlHPW2pKwVfDBasik+ZIGKqGdcpbd8YwPlzh0Ae7IzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUnK/SO5eJrrLF3XhNNFli1kkYtlsUFCRfYurkiLEVwFEKoZSo0fXAbhHs0kLEg0Y90p5f/bUS0dEB1ILViLZFVsuVdn9FfCmVeRciaep9tFMxZej0wDPOZRLMH+p4fBEgmIfqa6eb5AWC06zVclnNR+yCIDsxS5PZ0LLnQVCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O43iDTKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA16AC4CEEB;
	Sun, 17 Aug 2025 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755443430;
	bh=nlHPW2pKwVfDBasik+ZIGKqGdcpbd8YwPlzh0Ae7IzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O43iDTKnHvj71pGH0pFBxhIPkCHIUFfsBbCRueXQEaWO4Dk3OsxtAG+/2UeqpxT2g
	 Qzs4zWcBpCIRScIZ4B9UD5Icsnzmbu5Kz5gyZwVBPCho3l+aV81D52W/JMAh+Ix5+f
	 6v7JDmPGy+1LG3yEPfPTsncxU9n400zcCGXvr5+nWP4mbDX45Vuom03wZoG8BpeZ3S
	 iaueRwp1OrHAN99sJf2BxiVXPzvJlmlVfJF6/sIdWjgrRzE+honpzPw9cdit037ICL
	 GoHMXMMTPAqejCsz+AABRCvU7Y95l6WXpffYnM+YATjAvL1SAmN2Sbp/MbprDaNJZ9
	 l8ZAY92GC97VA==
Date: Sun, 17 Aug 2025 16:10:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 3/6] iio: pressure: bmp280: implement
 sampling_frequency for BMx280
Message-ID: <20250817161023.6b887db2@jic23-huawei>
In-Reply-To: <87ldnonwpv.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-4-Achim.Gratz@Stromeko.DE>
	<CAHp75VfhzJrPU6E=potYqPDYMbimhOy7edw9U0MfKsYMYwo8Sw@mail.gmail.com>
	<874iunknar.fsf@Gerda.invalid>
	<20250810191117.37c26fa8@jic23-huawei>
	<877bzbf0ti.fsf@Gerda.invalid>
	<20250811204840.74b2be91@jic23-huawei>
	<87ldnonwpv.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 21:53:00 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > For cases where we 'trigger' an event we normally use sampling frequency
> > to be 1/(total time to capture a set of readings)  Idea being it's
> > the frequency at which you get results if you immediately trigger
> > another one.  Doing that here doesn't correspond to 0Hz.  
> 
> From the device point of view the setting _is_ 0Hz.  That you are going
> to read it back-to-back is not something it can know.

We can argue this for ever and there is lots of precedence
of treating on demand sensor sampling frequency as 1/period.
(though seems we haven't documented that which isn't great - see reference
later).

> 
> There is one more problem with your idea: since that parameter is the
> only way to switch between modes, implementing it you way would mean
> that MODE_NORMAL+t_stby=0 would map to the same frequency as MODE_FORCED
> and then we're back to square one that there is no parameter to tell us
> which mode we want.

That's a fair point that I'd missed. I was kind of assuming there was
a power up time that made the (pseudo)frequency for MODE_FORCED a
good bit less than the the MODE_NORMAL case which thinking  more on it
would have put it in the middle of the MODE_NORMAL cases so not
helpful either.

> 
> > Main problem is no standard userspace code is going to understand
> > a value of 0Hz as that effectively means no readings ever.  
> 
> I am "userspace" and I well enough that I'm going to get one sample per
> read.

You are writer of one specific bit of userspace code. 
If you look at a generic application like the stuff ADI builds on top
of IIO then that is going to be a very odd value to see.

> 
> >>   
> >> > Even if it is a pain to work out, we should estimate what it means to
> >> > use force mode wrt to how fast a single sample can be obtain.    
> >> 
> >> MODE_FORCED just doesn't work well ffor devices that do mukltiple
> >> measurements at once that then need to be read one by one.  At least not
> >> by using the sysfs read request as the trigger for the measurement,
> >> which is what the earlier patch did that went into v6.13  
> >
> > I understand it works poorly under at least some circumstances. It's
> > just the issue of 0Hz not being a way people would expect to control this
> > or how any other driver does it.  
> 
> Beside any other driver (which I've not looked at), you're willing to
> break an existing one?  Because no existing userspace that use this
> driver will be working past that change.

Existing code doesn't use sampling frequency and works, though slowly
after that power saving related change.  It was the wrong default
choice but we missed it at the time - probably because both the author
and reviewers were thinking slow reads where the only thing likely
to be required by users of this device (see later). We should have
stuck to the periodic sampling unless we detected (runtime pm
autosuspend probably) that we were not doing frequent reads.

> 
> > Another approach might be to stash the timestamp of the last 'forced'
> > event and if it is 'sufficiently' recent just go with the readings of
> > other channels grabbed at that time. If it's not we pay the cost of
> > another read cycle.  That's close to doing a runtime pm autosuspend
> > on many other sensors where we take the view that if no one asked
> > for a while, we will pay the cost of a new power up and hence put the
> > sensor to sleep.  
> 
> I've actually looked at that and found it lacking.  That just makes
> MODE_FORCED a permanent thing that totally ignores that the sensor is
> supposed to be operated in free-running MODE_NORMAL in many
> applications.

An additional feature would be to detect repeated reads
and deciding to to autoswitch out of mode forced (probably on second read
of a channel within a short period).

> MODE_FORCED really is for things like wheather stations
> where it gets woken up onece every few minutes.  As long as there is no
> separate attribute or module parameter to switch between operation
> modes, this would be removing exactly the functionality that I want to
> use.

Ok.  I misunderstood this.  It's not that you want to grab
all the channels quickly (but only do that infrequently) it's that you
want to do measurement of rapidly changing pressure?  That's fair enough
as a use case, I just wasn't expecting to see it for this part (vs the
ones that have pipe connectors or similar)

> 
> > Hooking a single forced capture up to a hrtimer trigger would also
> > be somewhat similar to this but the interface to userspace is
> > rather more different so perhaps not the right way to think about it
> > here.  
> 
> I haven't been able to get this to work, I've never got a reading out of
> the buffer.  I'll try again once the distribution I#m using has enabled
> sysfs triggers, which are easier to test with hopefully.
Ok. Lets park that one for now.  This isn't a case where we have to get
readings at the same time for multiple channels to be useful, they just
need for your usecase not to be too far apart. So buffered support isn't
urgent.

Given the situation I'll accept the slight oddity of a 0Hz sampling_frequency.
It may confuse some software but as long as the default is sensible
sampling frequency isn't (I believe) that commonly tweaked for sysfs
reads anyway.  Tends to be much more relevant with high speed buffered
capture.

Hmm. Seems I let an exception for this in once before. Sorry had forgotten
that until I was wondering what docs update we need.

https://elixir.bootlin.com/linux/v6.16/source/Documentation/ABI/testing/sysfs-bus-iio#L112

So can you add a note to that doc covering this case (can be a follow up
patch if everything else is fine for v2)?

Sometimes these corner cases take a bit of arguing out. Thanks for
your patience!

Thanks,

Jonathan




> 
> 
> Achim.


