Return-Path: <linux-iio+bounces-14446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B74A15CA0
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333343A8B5F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7218B460;
	Sat, 18 Jan 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv4Hbjkf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA52B9BF;
	Sat, 18 Jan 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202598; cv=none; b=lr1OX99/BxbTwzg4PZOVytiwEpAa7FyKjFPuto/B6vWUwCav8Y7kWORm3BwDeGXhX8OE6Sb9dFXWfXRMJMAb1kXKkWLk5WYXPRZqXb1BpFCLPlIkHwvDMdRbbblw2Ochk6tlIy+Q5pleyM0RU6L5TUHbHGSvU8MQsGriREn6pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202598; c=relaxed/simple;
	bh=8TzYM0pgiUJjvWgMdIrYIP5k9L64JMTdw8ZWvVtpbWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzWQcsxVMzD2nFTqfXOjN3tqjHmvmyH0sXeqK1ZE4MEVApPaYGW/DUHFA+gIM+WpTHU7SaVPORMNnf+SgDNI9mUJrWb2z7vSc84seJdNFzKBpt7TX1EjqH/35oRvj0anEPpsTec7U7fXkrENuJGRwaq7Uzf1wSa70pcggZytBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv4Hbjkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13527C4CED1;
	Sat, 18 Jan 2025 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737202598;
	bh=8TzYM0pgiUJjvWgMdIrYIP5k9L64JMTdw8ZWvVtpbWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mv4HbjkfD0Ru7PJZz/KKw1+9aCeqXxsYLy4cWvDnjruM6NCIqg2UZiiX8KLqm9QDq
	 5u8Yfk5lC53UmHQg/URY9Z6iFxn/0YCoUi8NIAo/FjPMZ6g7hgVjztgjQcYHpnBxBZ
	 rMfByKF2H2pSSyYLGBalGoS4CDDlZhtHWGUz82C88P5ZHlO+o0jjgQ1+VfvI4bn5U9
	 8UkUmVThesORUetz9/k9o9TdzU62sjy5FE5CBRhJ7sl1M/LxzF2wDMfFtzXq3Wj6B3
	 l0kR0yjf/r8NvOq3xKc7lyFKXq3wi5kHwSlXifukisHLqWII9usAsz2Rc1R80hyl6n
	 sFcGvlxGO5UAA==
Date: Sat, 18 Jan 2025 12:16:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Message-ID: <20250118121629.7c3028f6@jic23-huawei>
In-Reply-To: <bdda37a2-5151-409e-9df1-c0cbfc8a5093@gmail.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
	<20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
	<129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
	<D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
	<CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
	<D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
	<CANhJrGOya1tmYcovYJZWkWmVE9NdLFHiDw7izmKtfYTXm57GVQ@mail.gmail.com>
	<D71TEJCQD9XK.5FNF9SJLFJ94@gmail.com>
	<bdda37a2-5151-409e-9df1-c0cbfc8a5093@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 16:26:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 14/01/2025 15:02, Javier Carrasco wrote:
> > On Tue Jan 14, 2025 at 7:43 AM CET, Matti Vaittinen wrote:
> > ...  
> >>> I will give you a simple example, so you can tell me where my reasoning
> >>> fails:
> >>>
> >>> raw = 100 counts
> >>> scale = 2.1504 lux/count (when IT=25ms and GAIN=1/8)
> >>> processed = 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)  
> >>
> >> Your reasoning does not fail. But, the scale = 1 / (N * total_gain),
> >> right? (N here depends on how we choose the scale/gain values) Here,
> >> the total_gain means the effect of both the hardware_gain and the
> >> integration time.
> >>
> >> Hence,
> >> processed =  X * (raw * scale)
> >>  
> >> => processed = X * (raw * (1 / (N * total_gain))
> >> => processed = X * raw / (N * total_gain);  
> >>
> >> Hence I thought you might be able to get rid of this 64bit division by
> >> using the total_gain from the iio_gts_get_total_gain() instead of
> >> using the scale. Or, am I missing something?
> >>  
> > 
> > I am not sure by X you mean the maximum resolution, but if that is the
> > case, the following would work (pseudo-code):  
> 
> Yes. X denoted the value by which the count needs to be multiplied to 
> get the lux (when total gain "in the terms of gts" is x1. I think in 
> this particular case the "gain is x1" is a bit confusing as it appears 
> this really means the hardware gain is 1/8, right?). Anyways, lux/count 
> it is, so in short - yes. :)
> 
> > 
> > /* Maximum resolution (2.1504 lux/count) * 10000 */
> > #define VEML6030_MAX_RES 21504
> > 
> > total_gain = iio_gts_get_total_gain();
> > processed_int = raw * VEML6030_MAX_RES / total_gain / 10000;  
> 
> Yes. This is what I was thinking of.
> 
> > processed_micro = ((raw * VEML6030_MAX_RES / total_gain) % 10000) * 100;  
> 
> gah. I didn't consider representing the micro portion. Staring this 
> makes me feel dizzy :) Well, it looks correct, and I guess the precision 
> is not lost by the division(?) But yes, you did perfectly get what I was 
> after!
> 
> Jonathan, do you think I am just guiding Javier to make a mess? :)

This is an area you've thought about a lot more than me.

Whether it is worth avoiding the 64 bit maths is an interesting question
and I guess depends where this part is typically showing up.

Jonathan

> 
> If not, then this might be the way to go.
> 
> Yours,
> 	-- Matti


