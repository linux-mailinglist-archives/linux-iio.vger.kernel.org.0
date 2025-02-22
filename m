Return-Path: <linux-iio+bounces-15972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E93A40A60
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB83AEA84
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D07204C1E;
	Sat, 22 Feb 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKi/868A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D93224;
	Sat, 22 Feb 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243379; cv=none; b=iWA2u4allWPHi+QbRY3Tdv+yaSf4fdYQOeR03rQyL+ruOpsqLNa5qDUDEDPPvODzOMsDzyw/zpGXKtE9/5BBKzkbrbbK4rnRxoWPdGk+AbmmeXDOX3VCMYBHIH5+Jqi0sgNGiooTlocgf8G1/07L/xikfX7iw86vMbn0on7Xl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243379; c=relaxed/simple;
	bh=O0SKD4Wy8FGy3IU/nRByoEBBMq9tu3M2J66w6sJuycw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts8j7HwZAxhDFnHMT97I4s35yxLxJOaejVelwhe/cG43+4RDca4pkHo3JxwGfdrGTKYY9irZ7zLHOPHDMJo0DYZZFpULaNBjByi4wZ+RJfO3n+r06cY5Focel9KM7KbB70SDFpmZvPrQkm0slFBdqyTrCSKs6sODrUS3JKgz2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKi/868A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B4C4CED1;
	Sat, 22 Feb 2025 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740243378;
	bh=O0SKD4Wy8FGy3IU/nRByoEBBMq9tu3M2J66w6sJuycw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nKi/868A3X/6arvO+56cZgjC0l9DnbFWtsJj9yQion7pz6Nf6BBthL6fVBNhML3Tw
	 7iPfN+cXQFbNxENRvGKrFnM+krE0ffQEGOCdHr8s4Lc1UrbEg2LEfxLk2e44fuzaW5
	 jAnG0V0EV75Qx7K7U0hfdyVLCgMIcoLlfCPyzHADyu8q7KXv7y9/STi3JQS8MwPQZ0
	 1OyZvfNF+r120qX4fq67T1ipHiyK+fzi/6MLVtfg+y3t3Uz4vlK/XnZaaCaAMY+JV8
	 Nen+tHcfYM4f+BzXeuw/22tc67C/WU7lqJOh8W2XvwXwEntmAindJRooaBXwcxL69k
	 foeRNJvOc2EXg==
Date: Sat, 22 Feb 2025 16:56:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] Add support for AD4080 ADC
Message-ID: <20250222165611.25acc5ef@jic23-huawei>
In-Reply-To: <bc8b0004-6eef-43c0-a07d-a07d2e332737@baylibre.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	<bc8b0004-6eef-43c0-a07d-a07d2e332737@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 14:12:06 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/20/25 7:54 AM, Antoniu Miclaus wrote:
> > The AD4080 is a high-speed, low noise, low distortion, 20-bit, Easy
> > Drive, successive approximation register (SAR) analog-to-digital
> > converter (ADC). Maintaining high performance (signal-to-noise and
> > distortion (SINAD) ratio > 90 dBFS) at signal frequencies in excess
> > of 1 MHz enables the AD4080 to service a wide variety of precision,
> > wide bandwidth data acquisition applications. Simplification of the
> > input anti-alias filter design can be accomplished by applying over-
> > sampling along with the integrated digital filtering and decimation to
> > reduce noise and lower the output data rate for applications that do
> > not require the lowest latency of the AD4080.
> >   
> It looks like this was just copied from the datasheet, so not useful
> at all for a cover letter. We can read it in the datasheet.
> 
> Instead, please spend some time to explain the interesting and
> unusual things about this driver that will help reviewers understand
> *why* you are doing what you are doing. This is a very complex driver!
> 
> In particular, on this one, the documentation on the FPGA IP block isn't
> very detailed. So it will be very helpful to know more about how all of
> the sync stuff is supposed to work and what kind of filtering is the
> FPGA doing in addition to the filtering done in the ADC chip.
> 
> 
> 
> 

This is a somewhat unusual device. I think a nice file with diagrams
etc under Documentation would also be good to have!

Jonathan

