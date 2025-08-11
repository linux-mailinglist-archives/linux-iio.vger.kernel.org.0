Return-Path: <linux-iio+bounces-22604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D4B2164D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 22:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F06464094
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805D2D97BA;
	Mon, 11 Aug 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNEGBvBs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971C277026
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943272; cv=none; b=s/eJJVMUZqaU5me7mXAk+NNZ6xTzx+EWaU5JBBRuP8YaQb8L38aHMGsctp/oSkNoHSe+qoNv5Y0u59P1HIuswIvIqme+v+HS2WqPxq5G4mpLF+ei3aWGDIwQUDIsqm2xmh4jHj6A8hngGBuNf/bLhmRjredrbtWB8wE7W9S8ZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943272; c=relaxed/simple;
	bh=c7EFtVFzkfVggrAgSi2hYBskm0FFjPucVgx4eIoIvRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwMRpktD9IV470DKKVOTPmGwmdDb98JCSaPFxEwt6g08x6gd1nYcDFcGxC5Y0SAU1q70E1MvHGOzTMxzwuhb4LP/680yTnlp636r/sH7ESmvS+eOMYHup6feWDzJygIeEdBISQ/X7oNvrE/iogj9gJwac22FLf/Z8uTXFA0M1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNEGBvBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E42FC4CEED;
	Mon, 11 Aug 2025 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754943270;
	bh=c7EFtVFzkfVggrAgSi2hYBskm0FFjPucVgx4eIoIvRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNEGBvBsLWJ3Jrr9CtUMBwdPtL+rsYmTrjWcvHfjqSJp40QxPW6o9b77SHsYCInf3
	 rVTCF+JVgh6QuGf5GRPOyQjq9+Fgr5cBJmrEZqiYUCAR4uLXfqLhHeFFEfZycxCY/l
	 OFVtqwAq8UjfKlhjzYEX7RMSrv37nzkuQ1+faJpKPtxjykgWM0izd/5BoedRY4QA7h
	 yYl2EZZotwiahls4MmLOP2QbXmOPmLo30Z7IhIckYJNle5wimR3u2GMPYYmwTaHeHN
	 fuyZ/6Eesj/t2FcAKXuBpd3PmLYDhNBT0vzanU/CuAwZ2TxkUNwYs+DT8z1ODYdYhL
	 0i32v+FuzCABA==
Date: Mon, 11 Aug 2025 21:14:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: ASSI <Stromeko@nexgo.de>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bmp280 v1 4/6] iio: pressure: bmp280: enable filter settings
 for BMx280
Message-ID: <20250811211423.3e52a67a@jic23-huawei>
In-Reply-To: <87bjonf1bv.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-5-Achim.Gratz@Stromeko.DE>
	<20250810191338.12b568df@jic23-huawei>
	<87bjonf1bv.fsf@Gerda.invalid>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 21:01:24 +0200
ASSI <Stromeko@nexgo.de> wrote:

> Jonathan Cameron writes:
> > On Sun,  3 Aug 2025 16:08:00 +0200
> > Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:
> >  
> >> These devices were using a hardcoded IIR filter of length 4.  Enable
> >> filter_low_pass_3db_frequency settings to control the filter length
> >> settings of the device (as done already for the BMx380 and BMx580
> >> devices, even though the 3dB corner has an inverse relation to the
> >> filter length).  Remove an offset of 1 from the internal handling of
> >> the available values.  
> >
> > This confuses me.  Are we saying those other devices have a 3db frequency
> > control that is not obeying the ABI? If so that sneaked in past me but
> > please don't continue that (and we should fix that broken use of the ABI).  
> 
> This is correct.  The attribute directly controls the tap length of the
> filter and more taps means lower 3dB corner frequency.  Besides, it
> isn't easy to even figure out what the corner frequency is, since it
> depends both on further settings of the device (provided you want the
> actual corner frequency and not one that's normalized to the sampling
> frequency) and the internal IIR equation, although you could sort of
> reverse engineer it from the step response graph in the datasheet since
> it's unlikely to be something complex.  I've had a brief look, but there
> doesn't appear to be a more appropriate attribute that could be used
> within the IIO framework, like timeconstant / tau maybe?
> 

We stuck to 3DB point for these because all most anything else is annoyingly
filter type dependent with no real consistency of meaning.  At least 3dB is
something you can establish if you have a reasonable amount of info about the
filter (or a plot!)
Obviously they are almost always effected by sampling frequency so that maths
can be rather non trivial.

Vs a completely misleading tap length control, an approx 3dB eyeballed
off a plot is an improvement. 

Adding more filter parameters is likely to end up with a very complex
userspace, so if we have any way to get an approx 3dB point, stick to that.
Been way to long since I last did any digital filter stuff, but poking google
ai thing with "IIR filter y_t = (a -1)/a * y_(t-1) + x_t/a"
came back with 3dB in digital angular frequency as

w_c = arccos ((2a^2 - 2a - 1) / (2a(a - 1)) 
Which might be right.

It's pretty unusual to not find a frequency plot that we could read it
directly off on a datasheet :(

Any filter design folk about who can sanity check the AI output?

Jonathan


> 
> Regards,
> Achim.


