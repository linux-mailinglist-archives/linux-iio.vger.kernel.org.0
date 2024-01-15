Return-Path: <linux-iio+bounces-1669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4882D620
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D351C2819C5
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313F6D2E6;
	Mon, 15 Jan 2024 09:37:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C002D275;
	Mon, 15 Jan 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TD6RL0yhyz6K9FQ;
	Mon, 15 Jan 2024 17:34:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 38ECC140B33;
	Mon, 15 Jan 2024 17:37:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Jan
 2024 09:37:04 +0000
Date: Mon, 15 Jan 2024 09:37:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Denis Benato <benato.denis96@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jagath Jog J
	<jagathjog1996@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: iio: iio-trig-hrtimer bug on suspend/resume when used with
 bmi160 and bmi323
Message-ID: <20240115093703.00001f64@Huawei.com>
In-Reply-To: <053a5c27-68fd-41b1-8b40-783dfb83d488@gmail.com>
References: <31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com>
	<20240113174351.47a20239@jic23-huawei>
	<053a5c27-68fd-41b1-8b40-783dfb83d488@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 14 Jan 2024 21:04:12 +0100
Denis Benato <benato.denis96@gmail.com> wrote:

> On 1/13/24 18:46, Jonathan Cameron wrote:
> > On Wed, 10 Jan 2024 23:35:01 +0100
> > Denis Benato <benato.denis96@gmail.com> wrote:
> >   
> >> Hello,
> >>
> >> With this mail I am submitting bug report that is probably related to
> >> iio-trig-hrtimer but there is also the possibility for it to be
> >> specific to bmi160 and bmi323.
> >>
> >> The described problem have been reproduced on my handheld PC (Asus
> >> RC71L) and in another handheld PC with two different gyroscope
> >> drivers: bmi323 (backported by me on v6.7, on RC71L) and bmi160.
> >>
> >> My target hardware (RC71L that yeld to this discovery) has a bmi323
> >> chip that does not have any interrupt pins reaching the CPU, yet I
> >> need to fetch periodically data from said device, therefore I used
> >> iio-trig-hrtimer: created a trigger, set the device and trigger
> >> sampling frequencies, bound the trigger to the device and enabled
> >> buffer: data is being read and available over /dev/iio:device0.
> >>
> >> While in this state if I suspend my handheld I receive (from dmesg)
> >> the warning reported below and at resume data is not coming out of
> >> the iio device and the hrtimer appears to not be working. If I create
> >> a new trigger and bind the new trigger to said iio device and
> >> re-enable buffer data does come out of /dev/iio:device0 once more,
> >> until the next sleep.
> >>
> >> Since this is important to me I have taken the time to look at both
> >> drivers and iio-trig-hrtimer and I have identified three possible
> >> reasons:
> >>
> >> 1) iio-trig-hrtimer won't work after suspend regardless of how it is
> >> used (this is what I believe is the cause)  
> > me too.  
> who and how should investigate this issue? Would putting a kprintf in the hrtimer callback be enough to check?
The warning you have pretty much points at this being the problem, but sure
you could add a print there to be absolutely sure.

> 
> 
> Just to make sure I understood correctly: is this a separate issue from the warning I receive or are those linked?

I think it's all one issue.

> >   
> >> 2) iio-trig-hrtimer is stopped by the -ESHTDOWN returned by the
> >> function printing "Transfer while suspended", however that stack
> >> trace does not include function calls related to iio-trig-hrtimer and
> >> this seems less plausible 3) bmi160 and bmi323 appears to be similar
> >> and maybe are sharing a common bug with suspend (this is also why I
> >> have maintainers of those drivers in the recipient list)
> >>
> >> Thanks for your time, patience and understanding,  
> > 
> > Hi Denis,
> > 
> > I suspect this is the legacy of the platform I used to test the hrtimer
> > and similar triggers on never had working suspend and resume (we ripped
> > support for that board out of the kernel a while back now...)
> > Hence those paths were never tested by me and others may not have cared
> > about this particular case.
> > 
> > Anyhow, so I think what is going on is fairly simple.
> > 
> > There is no way for a driver to indicate to a trigger provided by a separate
> > module / hardware device that it should stop triggering data capture.
> > The driver in question doesn't block data capture when suspended, which
> > would be easy enough to add but doesn't feel like the right solution.
> > 
> > So my initial thought is that we should add suspend and resume callbacks to
> > iio_trigger_ops and call them manually from iio device drivers in their
> > suspend and resume callbacks.  These would simply pause whatever the
> > trigger source was so that no attempts are made to trigger the use of
> > the device when it is suspended.
> > 
> > It gets a little messy though as triggers can be shared between
> > multiple devices so we'd need to reference count suspend and resume
> > for the trigger to make sure we only resume once all consumers of
> > the trigger have said they are ready to cope with triggers again.
> > 
> > As mentioned, the alternative would be to block the triggers at ingress
> > to the bmi323 and bmi160 drivers.  There may be a helpful pm flag that could
> > be used but if not, then setting an is_suspended flag under the data->mutex
> > to avoid races. and reading it in the trigger_handler to decide whether
> > to talk to the device should work.  
> I was thinking of doing this too, but I don't know if adding a mutex to frequently invoked functions is going to introduce some timing problems and so I was waiting for some comments on that matter. If nothing bad is expected I can surely try it.
> > 
> > I'd kind of like the generic solution of actually letting the trigger
> > know, but not sure how much work it would turn out to be.  Either way there
> > are a lot of drivers to fix this problem in as in theory most triggers can
> > be used with most drivers that support buffered data capture.
> > There may also be fun corners where a hardware trigger from one IIO
> > device A is being used by another B and the suspend timing is such that B
> > finishing with the trigger results in A taking an action (in the try_reenable
> > callback) that could result in bus traffic.
> > That one is going to be much more fiddly to handle than the simpler case
> > you have run into.  
> Since more and more handheld PCs are coming and provided many vendors such as
> asus tends to improve what they did built on previous generations I think a
> general solution would be desirable.
> 
> Plus there are handheld PCs that does not yet have a driver (bmi270) or are
> using an existing one and it would be very difficult to fix it in every of
> them as of now, in the future I fear it will become almost impossible or 
> extremely time consuming as market expands.

Both solutions require specific calls to be added to every driver that might
encounter this - so most drivers that support triggers other than the ones
they supply.

> > 
> > Thanks for the detailed bug report btw.   To get it fixed a few
> > questions:
> > 1) Are you happy to test proposed fixes?
> > 2) Do you want to have a go at fixing it yourself? (I'd suggest trying
> >    the fix in the bmi323 driver first rather than looking at the other 
> >    solution)
> >    If we eventually implement the more general version, then a bmi323
> >    additional protection against this problem would not be a problem.
> > 
> > Clearly I'd like the answers to be yes to both questions, but up to you!
> > 
> > Jonathan
> > 
> >   
> Hello Jonathan and thank you kindly for you answer,
> 
> I am very interested in the iio ecosystem as in those aforementioned
> handheld PCs the gyroscope plays the role as a mouse so it's a pretty
> important input device.
> 
> I am writing to lkml not just as a single developer, but as part of a
>  larger community in this matter: this means we will be able to test
> any solution and in more than just one hardware.
> 
> To answers your questions:
> 1) yes, we all will be very happy to
> 2) as I am very busy right now I might be unable to do that immediately,
> but I will surely do it if one general solution cannot be found or is impractical.
> 
> As of my limited knowledge the number of drivers now existing that are affected
> are 2, and the number of drivers that will be affected, once the driver is
> written, will be at least 3.

The problem appears to be general unfortunately.

I'll have to see if I can fire up something where I can actually test solutions
and I'm afraid I also don't have a lot of time at the moment.
Perhaps I can find time in the next few weeks to hack together a prototype
for one of the drivers you can test.

Jonathan

> 
> Thank you very much for your answer,
> Denis
> 


