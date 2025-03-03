Return-Path: <linux-iio+bounces-16252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B6A4B946
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 09:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A15118873F8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873DC1EF099;
	Mon,  3 Mar 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="SrRa8Xlq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08561EF08D
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990514; cv=none; b=QPwsP3arCfvE758v1ylPJoGtBw9dfeaPhDoFJn7AXJaPp/+Jne2Kv7yMDW48/NtcILSL4OtgyU2DEUGf/8+VUtk1K1xbFcWOG3qPsUe5O9/BPpE38d/mHuFcmSiA90wvXEkgCOzXApK2p8jk7TIXQ4emCZj7Qa1bXzymhST312A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990514; c=relaxed/simple;
	bh=vn4uUAOxHL4xNpWQx1w7T/QzgTeLHfcz3m2pqPNmXeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIjjIvfDGIR0rQwgD8J6FdsVBGpxMDXpOli3pxu8BItMH47o5q4oDLBbz+Ev58TAa2uE3WH33IArNuUW0mLxnbu2GSg2TthXZ48cwyyHwNVru3/zV/6iBnD7EiT9pZVg+zBnip3LoB8ZXaRhRjmu1hIbDfkYGkl7MEJC+GfO20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=SrRa8Xlq; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=faxAO4aiY4ll+/5SJ/txmaMEq1y/Nw8JWRch36mRZ8o=;
	b=SrRa8XlqVyxRv2v4tXJ11LoTshnohU9InG0jZIukPC6UV3CwEyN9ZwN16gSCFVfX1Yaj9yX5n11Jm
	 3Fp1Tm3+42d0ucHilm0Pw5V7WfnZiMpaAFhEKaa+MN9xQI/epKcDohmo+gm22TzHZjSbT8Cp+35pcC
	 zwSYUfBKVKzFsMIhezky6B4nLIxiornmHL5Tgwzi+x1UPQT3V30EtG9As644o1F2n5F4QpJFQFWcm3
	 IAqrhWgpUU3ImLMCYTlD2N9avjM2eE5qDPsaYi8xPwysNF8oUJxnUQW5GPUGdhrN16DQkvA77KHCVc
	 U5qCQmDjUinlmmmYU59VAN7HOmqZRPA==
X-MSG-ID: 77cb1355-f809-11ef-8b46-005056817704
Date: Mon, 3 Mar 2025 09:28:21 +0100
From: David Jander <david@protonic.nl>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Message-ID: <20250303092821.51f7ed11@erd003.prtnl>
In-Reply-To: <09afc3cc-a307-4662-bd70-0cf83f8f38e0@baylibre.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<09afc3cc-a307-4662-bd70-0cf83f8f38e0@baylibre.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Dear David,

Thanks for reviewing!

On Fri, 28 Feb 2025 16:36:31 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/27/25 10:28 AM, David Jander wrote:
> > Request for comments on: adding the Linux Motion Control subsystem to the
> > kernel.
> > 
> > The Linux Motion Control subsystem (LMC) is a new kernel subsystem and
> > associated device drivers for hardware devices that control mechanical
> > motion. Most often these are different types of motors, but can also be
> > linear actuators for example.  
> 
> This is something that I played around with when I first got into Linux
> kernel hacking as a hobbyist. It's something I've always wanted to see get
> upstreamed, so feel free to cc me on any future revisions of this series.
> I'm very interested. :-)

Cool! Will keep you posted.

> We made drivers for basic DC motors driven by an H-bridge both with and without
> position feedback and also a driver for hobby-type servo motors. For those
> interested, there is code [1] and docs [2]. One thing we would do different
> if doing it over again is use a character device instead of sysfs attributes
> as the interface for starting/stopping/adjusting actuation.
> 
> [1]: https://github.com/ev3dev/lego-linux-drivers/tree/ev3dev-stretch/motors
> [2]: http://docs.ev3dev.org/projects/lego-linux-drivers/en/ev3dev-stretch/motors.html
> 
> > 
> > This subsystem defines a new UAPI for motion devices on the user-space
> > side, as well as common functionality for hardware device drivers on the
> > driver side.
> > 
> > The UAPI is based on a ioctl() interface on character devices representing
> > a specific hardware device. The hardware device can control one or more
> > actuators (motors), which are identified as channels in the UAPI. It is
> > possible to execute motions on individual channels, or combined
> > affecting several selected (or all) channels simutaneously. Examples of
> > coordinated movements of several channels could be the individual axes
> > of a 3D printer or CNC machine for example.
> > 
> > On the hardware side, this initial set of patches also includes two drivers
> > for two different kinds of motors. One is a stepper motor controller
> > device that containes a ramp generator capable of autonomously executing
> > controlled motions following a multi-point acceleration profile
> > (TMC5240), as well as a simple DC motor controller driver that can control
> > DC motors via a half-bridge or full H-bridge driver such as the TI DRV8873
> > for example.
> > 
> > Towards the IIO subsystem, LMC supports generating iio trigger events that
> > fire at certain motion events, such as passing a pre-programmed position or
> > when reaching the motion target position, depending on the capabilities of
> > the hardware device. This enables for example triggering an ADC measurement
> > at a certain position during a movement.  
> 
> I would expect to be using the counter subsystem for position, at least in
> cases where there is something like a quadrature encoder involved.

I will have to think about it. Since there are some Linux capable SoC's that
have counter inputs able to do quadrature decoding, it might make sense to
support that. For now, the TMC5240 controller for example has support for
encoders and while in this patch-set support for it is minimal, the idea was
that a motion controller that supports an encoder would just offer the option
to use the encoder as the authoritative source for position information. So
let's say you have a DC motor for example. Without an encoder or any other
means for of speed/position feedback, the best one can do is establish a 1:1
relationship between duty-cycle and speed, obviating all inaccuracies of doing
so. So a motion controller using a DC motor would just do that if it has no
encoder. OTOH, if there is an encoder as a source of position and speed
information, the driver could work with more accurate data. It all depends, but
in the end the interface towards the user is the same: move with some speed
towards some position or for some amount of time.

> > In the future, making use of PREEMPT_RT, even dumb STEP/DIR type stepper
> > motor controller drivers may be implemented entirely in the kernel,
> > depending on some characteristics of the hardware (latency jittter,
> > interrupt latency and CPU speed mainly).
> > 
> > The existence of this subsystem may affect other projects, such as
> > Linux-CNC and Klipper for example.
> > 
> > This code is already in use controlling machines with up to 16 stepper
> > motors and up to 4 DC motors simutaneously. Up to this point the UAPI
> > has shown to be adequate and sufficient. Careful thought has gone into
> > the UAPI design to make sure it coveres as many use-cases as possible,
> > while being versioned and extensible in the future, with backwards
> > compatibility in mind.
> > 
> > David Jander (7):
> >   drivers: Add motion control subsystem  
> 
> Would it be too broad to call this an actuation subsystem instead where motion
> is just one kind of actuation?

I think it is hard enough already to make a UAPI for motion that is general
enough to encompass all types of different motors and motion actuators.
Generalizing even further without a serious risk of shortcomings seems almost
impossible, but I am open to suggestions.

Best regards,

-- 
David Jander

