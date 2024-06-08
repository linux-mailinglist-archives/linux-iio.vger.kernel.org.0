Return-Path: <linux-iio+bounces-6049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA39011C8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAE1C20E90
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789F17A906;
	Sat,  8 Jun 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzI1xcdc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22B17995E;
	Sat,  8 Jun 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717855130; cv=none; b=lHg3G5h3rPbO1caDYM7nPPDdk5h49mC1mfl1tLm/gfoje1yDleenzx3TjoPsPOO1vcAz+P//+as0OuPS6BbBmIbfBVwKQAmF5whfOIuE/fduaU7lsWylClSHWBWgrXPSR6Cx2s8+ITzrhSdAgia+XeN4R6aZESYqezK+t89iP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717855130; c=relaxed/simple;
	bh=rymivpu+bnxuXmRt+sfwn8c8qJcKMj4gYVRj/HVjtRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWrafYSGOxfcddNOKd5tgopUtRLF4jw8XTn77pl1OkczLdyxUG4OfCHjK6PafLrPqoHrnnpDfloKPqX0SgRoSldW+s4zJ3Mx5pYZaP2Ajvllaz+cU97+Xkpw5CTGz3aY1Abrz9T8A0o9dvbW8zSlG1mtCzORkHnLgmkDscoKe9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzI1xcdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6B8C2BD11;
	Sat,  8 Jun 2024 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717855130;
	bh=rymivpu+bnxuXmRt+sfwn8c8qJcKMj4gYVRj/HVjtRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzI1xcdcgVioMJ2A9/78rrcKynqQ62IYsAqgHBYX6h+FdjCAjIgmOFxk1a237I5Nz
	 xxBsKRpQOPz4oHT0hUU6PbLzAFJ99aHL/KX9bG9tAgW7G16FFNarCh3VlzTtsDptj7
	 k0GarO96s5uPjOyMbWdjelLaMG6sA0W/pE2hRTyFdSrK/WJp/FaGggMtbKjynZQxi6
	 uRSxI5Fyps0d7KSX7Ef/wfWz5xrt1Nq/iTQI/egQQJsAkxVxRZbfwFNvQI6JIvwqCS
	 /QEBxXvI+4ThPQPOgyCwYvgUfny1EevXJGsscp9agmdNIhaAU3WIykO9j11tmYPIWF
	 ntq+B8K5aZraw==
Date: Sat, 8 Jun 2024 14:58:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jagath Jog J <jagathjog1996@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@pengutronix.de>, "Luke D . Jones"
 <luke@ljones.dev>, Jonathan LoBue <jlobue10@gmail.com>
Subject: Re: iio: iio-trig-hrtimer bug on suspend/resume when used with
 bmi160 and bmi323
Message-ID: <20240608145839.1c5bd665@jic23-huawei>
In-Reply-To: <e255e232-f7f0-4ded-a749-27ed5ccfcd7b@gmail.com>
References: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
	<20240113174351.47a20239@jic23-huawei>
	<053a5c27-68fd-41b1-8b40-783dfb83d488@gmail.com>
	<20240115093703.00001f64@Huawei.com>
	<c11328ef-b61e-489f-9016-e342c749c000@gmail.com>
	<20240602170830.34d73c96@jic23-huawei>
	<e255e232-f7f0-4ded-a749-27ed5ccfcd7b@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 03:25:13 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> On 6/2/24 18:08, Jonathan Cameron wrote:
> > On Thu, 30 May 2024 16:07:22 +0200
> > Denis Benato <benato.denis96@gmail.com> wrote:
> >   
> >> On 1/15/24 10:37, Jonathan Cameron wrote:  
> >>> On Sun, 14 Jan 2024 21:04:12 +0100
> >>> Denis Benato <benato.denis96@gmail.com> wrote:
> >>>     
> >>>> On 1/13/24 18:46, Jonathan Cameron wrote:    
> >>>>> On Wed, 10 Jan 2024 23:35:01 +0100
> >>>>> Denis Benato <benato.denis96@gmail.com> wrote:
> >>>>>       
> >>>>>> Hello,
> >>>>>>
> >>>>>> With this mail I am submitting bug report that is probably related to
> >>>>>> iio-trig-hrtimer but there is also the possibility for it to be
> >>>>>> specific to bmi160 and bmi323.
> >>>>>>
> >>>>>> The described problem have been reproduced on my handheld PC (Asus
> >>>>>> RC71L) and in another handheld PC with two different gyroscope
> >>>>>> drivers: bmi323 (backported by me on v6.7, on RC71L) and bmi160.
> >>>>>>
> >>>>>> My target hardware (RC71L that yeld to this discovery) has a bmi323
> >>>>>> chip that does not have any interrupt pins reaching the CPU, yet I
> >>>>>> need to fetch periodically data from said device, therefore I used
> >>>>>> iio-trig-hrtimer: created a trigger, set the device and trigger
> >>>>>> sampling frequencies, bound the trigger to the device and enabled
> >>>>>> buffer: data is being read and available over /dev/iio:device0.
> >>>>>>
> >>>>>> While in this state if I suspend my handheld I receive (from dmesg)
> >>>>>> the warning reported below and at resume data is not coming out of
> >>>>>> the iio device and the hrtimer appears to not be working. If I create
> >>>>>> a new trigger and bind the new trigger to said iio device and
> >>>>>> re-enable buffer data does come out of /dev/iio:device0 once more,
> >>>>>> until the next sleep.
> >>>>>>
> >>>>>> Since this is important to me I have taken the time to look at both
> >>>>>> drivers and iio-trig-hrtimer and I have identified three possible
> >>>>>> reasons:
> >>>>>>
> >>>>>> 1) iio-trig-hrtimer won't work after suspend regardless of how it is
> >>>>>> used (this is what I believe is the cause)      
> >>>>> me too.      
> >>>> who and how should investigate this issue? Would putting a kprintf in the hrtimer callback be enough to check?    
> >>> The warning you have pretty much points at this being the problem, but sure
> >>> you could add a print there to be absolutely sure.
> >>>     
> >>>>
> >>>>
> >>>> Just to make sure I understood correctly: is this a separate issue from the warning I receive or are those linked?    
> >>>
> >>> I think it's all one issue.    
> >> Hello,
> >>
> >> Sorry for the delay, I was able to find some time just recently.
> >>
> >> Sadly I don't think anymore this is just one issue:
> >>
> >> I have setup a proof of concept that at suspend sets a boolean to true and at resume sets the same boolean to false, and on trigger_handler returns IRQ_NONE if the device is sleeping (everything guarded by an additional mutex) and it solved the warning: no more regmap access are being performed after the device is put to sleep, but unfortunately the acquisition does not automatically resume after waking up the device.
> >>
> >> How shall we proceed?  
> > 
> > It's been a while (and a busy day of reviewing) so I'm struggling
> > a bit with the best away forwardHello,  
> 
> Don't worry about it, I don't have much time available either. That stuff is as precious as gold! Thank you kindly for your time!
> > 
> > A hackyish approach might be to mask the interrupt at device side
> > (fake interrupt used as part of the tree from a trigger to a pollfunc).
> > A tidy wrapped up version of this might be the best route forwards
> > though it won't currently stop the hrtimer merrily poking interrupts
> > at no oneI am sorry but I am not sure I understood this correctly: do you mean having something "in-between" iio-trig-hrtimer and the target iio device and use that to selectively poll the device? 
> > 
> > As a hack, could you try having your suspend call disable_irq() on
> > the irq found in iio_dev->poll_func->irq and reenable it in resume?
> > That might be sufficient.  
> I used disable_irq and enable_irq as suggested and it works perfectly: I tested it four times and all four times (in a row) data flow resumed after s2idle-suspending the device.
> 

Excellent.

> I can do more testing, but this is already looking very good and I'm happy (I don't have knowledge about iio internals so I am unable to tell if what I did will introduce some race conditions).

On that note we definitely shouldn't directly mess with the IIO internals
as that implementation has changed in the past and might change again (though
it's been stable for over 10 years, so probably not ;). Hence we should
wrap this up in something like iio_suspend_triggering()/ iio_resume_triggering() 
which will then be called from the suspend and resume callbacks of
drivers that need to ensure no accesses once suspended.

> 
> As a reference I leave here the github link to the branch I have been experimenting with: https://github.com/NeroReflex/linux/commits/bmi323-pollfunc/ (Please don't mind that proof-of-concept code being copied and partially commented from bmc150-accel).
> 
> No errors are printed out and combining that info with the fact it's now working it can only means pollfunc and irq are both non-NULL and non-zero at both suspend and resume.

That's true in the case you care about, but if we were putting in place general infrastructure
it will get a little more 'interesting'.

For example if currently if the trigger has never been set for a device
pollfunc->irq == 0, but we don't actually clear that value when we
detach the trigger (previously it was never used after that detach so
it's value was irrelevant.

So at minimum we need to fix that by resetting the irq value to 0 in
iio_trigger_detach_poll_func(), and add the checks so that if there
is no trigger we don't try to disable the irq.

I'm nervous that it might be possible to suspend whilst also setting
the trigger and hence we need locking. We can probably use the core
state lock (iio_dev->mlock) for that but we'd need care as that's
already taken in some of these paths.

> > 
> > Check poll_func goes somewhere first though and that irq is > 0
> > I think that will call iio_trig_subirq_mask() which should block
> > any further interrupts until it's unmasked again.
> > 
> > We'll need to ensure this doesn't race with pollfunc going away though
> > which will make it more complex, but the above test should tell us
> > if there is a fairly smooth path to making this work.
> > 
> > I'll try and find time to do some testing myself, but it won't be
> > for a few weeks :(
> > 
> > Thanks,
> > 
> > Jonathan  
> Thank you again for your guidance,

No problem.

Jonathan

> Denis Benato
> > 
> >   
> >>>     
> >>>>>       
> >>>>>> 2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the
> >>>>>> function printing "Transfer while suspended", however that stack
> >>>>>> trace does not include function calls related to iio-trig-hrtimer and
> >>>>>> this seems less plausible 3) bmi160 and bmi323 appears to be similar
> >>>>>> and maybe are sharing a common bug with suspend (this is also why I
> >>>>>> have maintainers of those drivers in the recipient list)
> >>>>>>
> >>>>>> Thanks for your time, patience and understanding,      
> >>>>>
> >>>>> Hi Denis,
> >>>>>
> >>>>> I suspect this is the legacy of the platform I used to test the hrtimer
> >>>>> and similar triggers on never had working suspend and resume (we ripped
> >>>>> support for that board out of the kernel a while back now...)
> >>>>> Hence those paths were never tested by me and others may not have cared
> >>>>> about this particular case.
> >>>>>
> >>>>> Anyhow, so I think what is going on is fairly simple.
> >>>>>
> >>>>> There is no way for a driver to indicate to a trigger provided by a separate
> >>>>> module / hardware device that it should stop triggering data capture.
> >>>>> The driver in question doesn't block data capture when suspended, which
> >>>>> would be easy enough to add but doesn't feel like the right solution.
> >>>>>
> >>>>> So my initial thought is that we should add suspend and resume callbacks to
> >>>>> iio_trigger_ops and call them manually from iio device drivers in their
> >>>>> suspend and resume callbacks.  These would simply pause whatever the
> >>>>> trigger source was so that no attempts are made to trigger the use of
> >>>>> the device when it is suspended.
> >>>>>
> >>>>> It gets a little messy though as triggers can be shared between
> >>>>> multiple devices so we'd need to reference count suspend and resume
> >>>>> for the trigger to make sure we only resume once all consumers of
> >>>>> the trigger have said they are ready to cope with triggers again.
> >>>>>
> >>>>> As mentioned, the alternative would be to block the triggers at ingress
> >>>>> to the bmi323 and bmi160 drivers.  There may be a helpful pm flag that could
> >>>>> be used but if not, then setting an is_suspended flag under the data->mutex
> >>>>> to avoid races. and reading it in the trigger_handler to decide whether
> >>>>> to talk to the device should work.      
> >>>> I was thinking of doing this too, but I don't know if adding a mutex to frequently invoked functions is going to introduce some timing problems and so I was waiting for some comments on that matter. If nothing bad is expected I can surely try it.    
> >>>>>
> >>>>> I'd kind of like the generic solution of actually letting the trigger
> >>>>> know, but not sure how much work it would turn out to be.  Either way there
> >>>>> are a lot of drivers to fix this problem in as in theory most triggers can
> >>>>> be used with most drivers that support buffered data capture.
> >>>>> There may also be fun corners where a hardware trigger from one IIO
> >>>>> device A is being used by another B and the suspend timing is such that B
> >>>>> finishing with the trigger results in A taking an action (in the try_reenable
> >>>>> callback) that could result in bus traffic.
> >>>>> That one is going to be much more fiddly to handle than the simpler case
> >>>>> you have run into.      
> >>>> Since more and more handheld PCs are coming and provided many vendors such as
> >>>> asus tends to improve what they did built on previous generations I think a
> >>>> general solution would be desirable.
> >>>>
> >>>> Plus there are handheld PCs that does not yet have a driver (bmi270) or are
> >>>> using an existing one and it would be very difficult to fix it in every of
> >>>> them as of now, in the future I fear it will become almost impossible or 
> >>>> extremely time consuming as market expands.    
> >>>
> >>> Both solutions require specific calls to be added to every driver that might
> >>> encounter this - so most drivers that support triggers other than the ones
> >>> they supply.
> >>>     
> >>>>>
> >>>>> Thanks for the detailed bug report btw.   To get it fixed a few
> >>>>> questions:
> >>>>> 1) Are you happy to test proposed fixes?
> >>>>> 2) Do you want to have a go at fixing it yourself? (I'd suggest trying
> >>>>>    the fix in the bmi323 driver first rather than looking at the other 
> >>>>>    solution)
> >>>>>    If we eventually implement the more general version, then a bmi323
> >>>>>    additional protection against this problem would not be a problem.
> >>>>>
> >>>>> Clearly I'd like the answers to be yes to both questions, but up to you!
> >>>>>
> >>>>> Jonathan
> >>>>>
> >>>>>       
> >>>> Hello Jonathan and thank you kindly for you answer,
> >>>>
> >>>> I am very interested in the iio ecosystem as in those aforementioned
> >>>> handheld PCs the gyroscope plays the role as a mouse so it's a pretty
> >>>> important input device.
> >>>>
> >>>> I am writing to lkml not just as a single developer, but as part of a
> >>>>  larger community in this matter: this means we will be able to test
> >>>> any solution and in more than just one hardware.
> >>>>
> >>>> To answers your questions:
> >>>> 1) yes, we all will be very happy to
> >>>> 2) as I am very busy right now I might be unable to do that immediately,
> >>>> but I will surely do it if one general solution cannot be found or is impractical.
> >>>>
> >>>> As of my limited knowledge the number of drivers now existing that are affected
> >>>> are 2, and the number of drivers that will be affected, once the driver is
> >>>> written, will be at least 3.    
> >>>
> >>> The problem appears to be general unfortunately.
> >>>
> >>> I'll have to see if I can fire up something where I can actually test solutions
> >>> and I'm afraid I also don't have a lot of time at the moment.
> >>> Perhaps I can find time in the next few weeks to hack together a prototype
> >>> for one of the drivers you can test.
> >>>
> >>> Jonathan
> >>>     
> >>>>
> >>>> Thank you very much for your answer,
> >>>> Denis
> >>>>    
> >>>     
> >>
> >> Thank you for you time and patience,
> >> Denis  
> >   
> 


