Return-Path: <linux-iio+bounces-8802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A995EFBD
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6857D2835B2
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A8154C0E;
	Mon, 26 Aug 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxplR/7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA21547FF
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671798; cv=none; b=b4BxbkQaPG3dBvS16C3vO8f26h6+bmFOcx71aDvkeCoUATi4sOL8s+jJ07K8qB45VPHfoA6Ra6VyVJsT6cj6keeRAGZXZv/Z4SZETJDH6IXY+q3qHjMIuULYJVTulzYKz0M+umP+NwTbMUZ6m7317nIek3xhE9VZb8P2uhFpMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671798; c=relaxed/simple;
	bh=z62qCVYWkgieOxFQhsDq8p0xIiLOzU6IC81QoHfT0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUNEupgaE/DKDX2fN37zrmlz1p0GH15LWacMtq6S9HuQqgTgndk5uwwQoDog/7zNQd9pOp58xYpbomZRj13X1QnsITTeDJWzr7LZlMIqmQNYbT18dVJt43Xx5mVQ4G8a/YKGcUNogoVLfE30djvU6g1pCahfl2xS7sTfONdlQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxplR/7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52779C51413;
	Mon, 26 Aug 2024 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724671797;
	bh=z62qCVYWkgieOxFQhsDq8p0xIiLOzU6IC81QoHfT0pE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cxplR/7PrveLIydeOYs930FYh1G4XG7hRhRw9u1YSXUiCJ5xasD4wLzsM6cZt9vLt
	 3zEfR+FrTfnsU4Z25hGuK211utD0zVDe+ZGrawzpY/d5Oavzwg0Rto8puEVFlLdBMl
	 Aa2kWRuqXGSS7acyLGy0ubRcqECeInz2gbcpsEFpO/3+m0C3Vppnu38zwDhiS+5eWm
	 RlLVLy4OqfxBr3WEFjSnfcZttRLB5M+Sed2GpTeIPQKa1Yel6Qby44IincKuxb1q5Z
	 0epfjiyV95UL580udtKZfSRFIm+1k+UVl8ZeJVghRbBBgd3FNMKAM+O61wQf6o+548
	 vhvTckri+Sfeg==
Date: Mon, 26 Aug 2024 12:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: iio: trigger: Software Resend of Triggers
Message-ID: <20240826122946.2d57911c@jic23-huawei>
In-Reply-To: <20240824190544.5705-1-ibrahim.bagriyanikb@gmail.com>
References: <20240824190544.5705-1-ibrahim.bagriyanikb@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 22:05:42 +0300
Ibrahim Bagriyanik <ibrahim.bagriyanikb@gmail.com> wrote:

> Dear IIO Community,
> 
> I was developing a device driver for the MAX11040K ADC and have
> encountered an issue where the device begins sampling but stops after
> a few seconds. After debugging, I found that when an interrupt
> arrives while another trigger handler is still in progress -has not
> called iio_trigger_notify_done-, the poll calls seem to get lost.

This isn't unusual as it's often possible to get a sensor to sample
faster than the kernel can handle.

> 
> As you know, the kernel provides the CONFIG_HARDIRQS_SW_RESEND option
> for software resends of IRQs. This feature masks IRQs in the control
> flow and resends them once the current IRQ handler finishes. I looked
> for a similar implementation in the IIO trigger source code but
> couldn't find anything.

It shouldn't be necessary but things can get interesting with
devices not designed for use with a general purpose OS.

HARDIRQS_SW_RESEND is a workaround for broken irq controllers, not
intended for this (as far as I can tell as I hadn't come across that
before).

> 
> Is there a similar mechanism within IIO, or how do others typically
> address this problem on slower processors? If there isn't, would
> implementing such a feature in IIO make sense? I tackled this by
> simply not using IIO triggers, and only thing I thought to make use
> of was simply blocking poll calls with synchronization primitives
> until the former trigger finishes. I would appreciate your thoughts
> and suggestions.

Roughly speaking combination of using level interrupts for
the hardware irq (so we can come around later if the interrupt
won't refire on next sample) and being careful with the sequencing
in the driver.  Also IRQF_ONESHOT typically for the trigger
to ensure interrupt is only enabled when threads are done
(so if the level is still true, you immediately retrigger).
In some more fiddly cases it may be necessary to disable the interrupt
whilst doing handling but that is very rare and usually
because the device does something bad with the interrupt
line during data read out.

Good to have some more details of how you have tied everything
together. 

For the trigger, is it using a threaded interrupt, or calling
iio_trigger_poll() from the non threaded part?

If it's doing it from the threaded part then all the threads
in the IIO device /pollfunc side will finish before
the trigger interrupt (so the hardware one) is reenabled.
It's been a while since I looked at the flow where each
pollfunc had it's own interrupt context part and thread, but
I didn't think we had races there either.

So I'm assuming you are using the device drdyout as the indicator
of data.  Are you treating that as an edge interrupt? If so
you will run into lots of pain. It's a long time since it was
common to get interrupt controllers that couldn't do level
interrupts.

I suspect you want to treat it as a level interrupt with
IRQF_ONESHOT set to indicate that the interrupt should
not be reenabled until the thread is done. That thread
should only be done after all consumers of the trigger
have completed. 

Jonathan

> 
> Best,
> Ibrahim Bagriyanik.


