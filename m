Return-Path: <linux-iio+bounces-8563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADA955903
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18042825FE
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07391E511;
	Sat, 17 Aug 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5DyFBQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5AB66C
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912922; cv=none; b=TWMJ2heM3o5lDSHYXyg5yPWeQJqUFvu4EufZiJ7NsWcpctPtQomvDTpJ5GIApnPSao6sFgSd/UOvT4hhtLBxhCaJSO6GIkLmgo0ZCZIEE73wpT/prPBo837gZIk5s6qy/1Qis26sXZ12h+gTzwB/+3BoFUjGprnQSLMPSNtdfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912922; c=relaxed/simple;
	bh=5BkVCLyRVkWTglZdfDBeYqwQo9HfSwLbQGLvVvgMG5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDYZvf1NF5oFqF/GqQYEeweyi+GoZY+FAgM6Uk4FUGru0nN5ifXdyTwxyrk6q0aageOzB5WTA+pzgJhmE/eFmhDJeuNVvmVNS/Ku8kgAYxBPf6te3HZ3MH2Muuifw/Sfs/JOQwFMzdz69zC5f6Rkt5vmpIkJNpdedIZqmsfIzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5DyFBQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD8C116B1;
	Sat, 17 Aug 2024 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723912922;
	bh=5BkVCLyRVkWTglZdfDBeYqwQo9HfSwLbQGLvVvgMG5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y5DyFBQQJBfdY7X7uconkINUpIR+G1J0QzSKwDipQNAcpFELAv52INzpLGAw5R9Ra
	 rYmKge4nrfH45TuaTkFxeIWAMRO3y4FNUZq8kIV6P+lbY8GPsv/HMWrNpfecC64AXM
	 xFHlQI5t1Gcac04RhHaiZDJywa7Rg9fIcE5MaLjjC3JA3k4R+MLc2sSio1DSbzsxby
	 61QkCS/gVID53lqG3ufgaLMsF/8c9rDq5p5VLj2Akn5JpfNxpRJgg7acNnmd/UUUSm
	 HYrKeHG9KXgA2h8U9Ipc1ENGnvo5glyPKTYSMvlzIji8u2pJ/ltUAG8egQ5gsFM6xl
	 J8iv/QhD59HKQ==
Date: Sat, 17 Aug 2024 17:41:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: linux-iio@vger.kernel.org, Jagath Jog J <jagathjog1996@gmail.com>
Subject: Re: iio: accel: adxl345 - Questions on Implementation
Message-ID: <20240817174156.401f4be3@jic23-huawei>
In-Reply-To: <CAFXKEHYGHPjS1uh=+++SdYPg45H5VLnH6R6Y1Yb26kr9kOFsdQ@mail.gmail.com>
References: <CAFXKEHYGHPjS1uh=+++SdYPg45H5VLnH6R6Y1Yb26kr9kOFsdQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 00:35:17 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Dear IIO Community!
> 
> TL;DR: I have some general questions on implementing IIO. In
> particular I'm playing with an accel driver. Feel free to answer.
> 
> 
> Some months ago I was lucky to contribute to the adxl345 accelerometer
> driver. The driver has already an (older) implementation in in the
> kernel's input system with more feature support, but most parameters
> hardcoded. In the meanwhile I continued and managed to implement
> somehow the ADXL345 FIFO usage, single tap, double tap,
> activity/inactivity, freefall, standby and low power modes, etc.
> Basically most (almost all?) features available in the input driver,
> but using the iio the features would be even configurable in sysfs.
> Some points are still missing, though, such as adxl346 orientation
> feature and for sure this is just my POC implementation which by far
> would not match kernel quality at the current state.
> I managed implementing / catching those events, with a kind of
> my-understanding-of-IIO-implementation. I was not really able to find
> much documentation. Most often I ended up reading through other
> drivers and trying to understand how things were implemented there. My
> frist approach then was to setup individual "_en" handles for every
> feature in sysfs, and ignore most of the event/channel handling
> (smile). When this worked I actually understood, that there is
> "buffer". Then I got to understand a bit more of "events" and so on
> already providing things. I was in the second or third implementation.
> I tried to interpret the results coming on /dev/iio:device0 using od
> and xxd. This did not work for gesture events like tap events. By
> chance I found there is already a tool for that: iio_event_monitor.
> But this stayed simply mute when I wanted to see my FIFO data coming
> in which worked before. Ugh..
> 
> I don't want to break up a long discussion, but some feedback on the
> following questions of mine would be really, really highly
> appreciate!!
> 
> 1.) First of all, would there be a general interest to integrate
> additional code into the iio/adxl345 driver? If ok, I would love to
> prepare patch series on a per feature basis up for discussion to learn
> and to get it matching your high quality standards.

Absolutely.

> 
> 2.) I assume the key motivation of the IIO events/channel approach is
> to abstract sensor specific functionality to a general IIO/accel
> functionality provided by sysfs in Linux. Do I understand this
> correctly? So, no matter of the implementation, if a feature is
> provided, SW can use that w/o knowing the underlying hardware and
> datasheet in specific.
Yes. The biggest thing IIO brings (and input for that matter) is
a consistent ABI exposed to userspace software so moderately general
applications / libraries can use it without needing tweaking for each
driver.

> 
> 3.) If the above is true, where can I find the documentation of the
> sysfs handles (other than testing/ABI, the iio header files,
> interpretation of types and enums,...)? Which handles are possible is
> all around? How can I use it? And so on? Is there a way to list
> supported features for an iio device?

There are more advanced libraries such as libiio that comes with
tooling to provide some feedback, but fundamentally everything
can be derived from what is in sysfs + the uapi/linux/iio headers

> 
> 4.) My approach was to read through codes and do some creative
> interpretation of namings. I have nothing against reading sources, but
> in some cases this can be quite confusing. Even from a user's
> perspective, e.g. the fifo watermark. Currently I know "watermark" for
> a FIFO can be configured (if "buffer0" has been armed before with some
> length), where hwfifo_watermark can never be configured. Currently I
> understand: hwfifo_watermark is read-only. It reads back what is
> configured in the HW and prints what the hwfifo eventually holds as
> watermark. Is this a halfway correct interpretation of the
> FIFO/watermark mechanism?
Yes. There are two levels of buffering going on.
KFIFO in kernel which provides an efficient path for userspace to read
from and the driver to push to. That is usually much larger than the
hardware fifo on a device (but may have a low watermark)
When we set a watermark it applies to the software fifo and may also
be reflected by the hardware configuration and hardware watermark.
However there doesn't in theory need to be a one to one mapping.
The driver provides hwfifo_set_watermark function which is passed
the value the kfifo watermark is set to (IIRC - it's been a long
time since I looked at this).  The driver then gets to pick an appropriate
hardware value.  Perhaps it can't set it as high as the software request
so instead uses half of that value (two hardware interrupts to one software
signal).



> On the other hand, with my FIFO enabled and configured, e.g. to
> watermark of 30 entries (then it triggers an interrupt, which I catch
> and I yield the data). I can see hex data arriving at
> /dev/iio:device0, which is nice. But checking with 'iio_event_monitor
> /dev/iio:device0' I see nothing. 
Events and buffered are unrelated in IIO (unlike Input).

Buffered data is about normal data flow and for that the example code
is iio_generic_buffer.c

Events go via a separate path (because we don't want to intermix the
data types as that would make userspace data processing much harder).
Those are read by the iio_event_monitor.  Typical events are the taps
and thresholds on signals


> Do I understand this wrong? They
> should come as raw, of course I also could see the values e.g. in
> /sys/bus/iio/..../in_accel_x_raw  - but I guess this is rather for
> debugging. Where /dev/iio:device0 should bring up the bulk of scanned
> values (here x,y,z and in case several FIFO entries of them). Or,
> could someone please explain?
The sysfs access files are for 'slow' usecases.  They are much higher
overhead but in some cases we don't care. Say we have a script that
just wants to check if the device is upside down, then reading
a simple file and getting the acceleration is easier than having
to process the stream of binary data from the chardev.

> 
> 5.) In particular I have questions on the implementation ways, let's
> take "single tap" as another example - Which is the better approach?
>   A) do regmap_write() directly from write_event_value() using mutex
> protection everywhere (I hope my assumption about usage of mutexes is
> correctly here) - i.e. no matter if the sensor is currently running or
> not, there can b e configuration, or
Even configuration 'normally' (it's hardware dependent) doesn't stop
the filling of the fifo etc, so it should be fine to update it live.
Some other things are typically more destructive such as changing
sampling frequency - for  those we use iio_device_claim_direct_mode()
to ensure we aren't streaming data to the buffer before setting them.
Also often do this for things like scaling because there is no way to
align a datastream with the parameter change.

You my not even need an explicit mutex and regmap and the bus have
suitable locks. So it depends on what data you need to protect.
If a complex read modify write is needed then you should indeed lcok.

>   B) init a variable in the driver data "singletap_en", and only write
> all regs at postenable() w/o mutex then, i.e. when I do
> buffer0/enable? - i.e. configuration only when the sensor is not
> running
No. Events are not related to the buffered enabling /disabling.
There are devices where it gets more complex because they have to be
filling their fifos before they bother checking for taps etc. For those
the driver has to enable the buffer but not expose it to IIO unless
buffered IIO capture is also enabled.

> If I take the approach B, I fear I'm implementing the behavior
> differently to other accelerometers. In other words, I feel it would
> be better to implement uniform accelerometer behavior, or to document
> it somewhere. Here I'm unsure, if this is ok or not? Another argument
> for B) was that I guess many of the sensors must be put into
> off/standby for configuration and turned on again. This comes
> implicitely when connecting it to buffer0/enable.

Having an event control require that the device is put into standby first
is fairly unusual but there are examples.  For those we just use
the iio_device_claim_direct_mode() check and fail an attempt to enable
them if buffered capture is in progress.  When it isn't, they can
be enabled immediately though (as then it is safe to switch device
mode briefly and then back again.)

Data flow is king in IIO. You don't interrupt the main buffered
flows for any other feature.

> 
> 7.) So far I managed to implement the following
>  - Configuration of TAP_THRESHOLD register via IIO_EV_INFO_VALUE in
> write_event_value()
>  - Configuration of DURation register via IIO_EV_INFO_RESET_TIMEOUT in
> write_event_value()
>  - Configuration of a single tap enable field via a handle in
> write_event_config()
> In the postenable() I configure the interrupt by the state of the
> enable field. Then I configure a buffer (256 to buffer0/length; 1 to
> buffer0/in_accel_x_en), evntually echo 1 into buffer0/enable. I'm
> watching using the iio_event_monitor on the /dev/iio:device0. I can
> see gesture events. Is this a valid approach?

I haven't looked in detail at device restrictions but normally events
should be handled completely separately from buffer enabling.

> For double tap the
> datasheet additionally describes a "window" parameter to be
> configured. But events does not seem to offer something like that.
> Even the above approach e.g. "IIO_EV_INFO_RESET_TIMEOUT" and the
> resulting handle in sysfs sounds quite different than "duration", and
> is IMHO here also not very intuitive (duration IMHO would be easier to
> understand, but ok). So what to do with a "window"? I might discuss
> that also later when I present the code, perhaps would be easier to
> follow.
Yes, lets leave that for now as it'll probably require some datasheet
diving.  There is no common terminology in the industry unfortunately!

+CC Jagath though who developed the tap interfaces. Perhaps he can
offer some hints in the meantime. I recall it being fiddly to figure
out generic terminology for the various controls - particularly as
there is sometimes no correspondance at all between different hardware
and implicit need to understand the classification algorithm used :(

> 
> Thank you so much if you read +/- up until here. I was told it is ok
> to send my questions to IIO mailing list. So, I hope it was ok, and
> the questions are not too obvious.

Our documentation isn't great and is scattered all over the place
in random slide decks etc, so we rely on the mailing list to point
people in the right direction.  So it is absolutely fine to ask
questions. We may well point you at a previous discussion and in future
we may point others at the discussion here

Jonathan
> 
> Best regards,
> Lothar
> 


