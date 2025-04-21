Return-Path: <linux-iio+bounces-18430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FDA95139
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992D23B224B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE39A2641C0;
	Mon, 21 Apr 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgv+YWhT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787562905;
	Mon, 21 Apr 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239830; cv=none; b=cGrIyY7b63KiM73vgC+Wk5uYfzRxASwvJmYwbddvR+9CPreFRUDopTzNeOMeB8RVCkcU1XoYnD2E5o/V3DUD/OvgtgFdgFmmbk5Nohahqn+ttqJQdNHtjLDlxzuxkdFn0Vm9CV8c8H6q5Xr9p4WOL4u+aFc6niYaaQXre6rRzy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239830; c=relaxed/simple;
	bh=aQVZG5DEu8YE5FWBUQD4b4UZYTXfV9Xxq60orHtA5b4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPmBVSDlJJe8Ot1Afe5GHSFhqW6DJT0o3XAzwegnTlqaE0ZEU81cKSCF0vrSNalqdJEHo1Oxd3KSyLMgmJ+ZjQZdDydgGCfn1Qw8UdDgJby/NaYMG+xF5p838mSeQKq1Mu3ISQwqzyigrMV6Ih545ZBRBUkVV2YUx/iLQus8Gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgv+YWhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF85C4CEE4;
	Mon, 21 Apr 2025 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745239829;
	bh=aQVZG5DEu8YE5FWBUQD4b4UZYTXfV9Xxq60orHtA5b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fgv+YWhTU2HZODtmds8W4MVh0NOcX3pzh1JMJjm4ozbVVxXfAuwjFwWkU2wNHLcAg
	 OQormlguLaQi6KPpvhIB1Xokig1AbU1uJZRmanxrJ/6gS8PlHMwpUhW58UBVURV1J6
	 1pBu9cAJAXKy4jxd/xmxkKqp9t+nGonliE3Yyd3TJjDimpojTYoUu0xND/HKcpJZYB
	 m17EpGWcFS3RshIWBHmaTRfRN2AjZJR3Jfj9JSdAEuJMtTtQqwxSo561wmZT/a9Arn
	 zKzdXe7ukWAo1rSJWgWDrzEcJLZE6v5kWBLjVl8JPpJbhEYeXCYtgzR3ootD+VGP03
	 IAS8oOpGFdHEA==
Date: Mon, 21 Apr 2025 13:50:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250421135022.2ab97685@jic23-huawei>
In-Reply-To: <a834e345-6d44-4fe6-a3ed-cc856e9dc4d3@baylibre.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
	<20250418-iio-introduce-iio_declare_buffer_with_ts-v1-2-ee0c62a33a0f@baylibre.com>
	<aAPRbb93lJrnEE5l@smile.fi.intel.com>
	<a834e345-6d44-4fe6-a3ed-cc856e9dc4d3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 12:57:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/19/25 11:38 AM, Andy Shevchenko wrote:
> > On Fri, Apr 18, 2025 at 05:58:33PM -0500, David Lechner wrote:  
> >> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
> >> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> >> and understand.
> >>
> >> AD4695_MAX_CHANNEL_SIZE macro is dropped since it was making the line
> >> too long and didn't add that much value.
> >>
> >> AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
> >> previously we were overallocating. AD4695_MAX_CHANNELS is the number of
> >> of voltage channels and + 1 is for the temperature channel.  
> > 
> > ...
> >   
> >> -/* Max size of 1 raw sample in bytes. */
> >> -#define AD4695_MAX_CHANNEL_SIZE		2  
> >   
> >>  	/* Raw conversion data received. */
> >> -	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
> >> -		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> >> +	IIO_DECLARE_BUFFER_WITH_TS(u8, buf, (AD4695_MAX_CHANNELS + 1) * 2)
> >> +		__aligned(IIO_DMA_MINALIGN);  
> > 
> > I would rather expect this to be properly written as u16 / __le16 / __be16
> > instead of playing tricks with u8.
> > 
> > With all comments given so far I would expect here something like:
> > 
> > 	IIO_DECLARE_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
> > 
> >   
> 
> We would have to make significant changes to the driver to allow u16 instead
> of u8. I don't remember why I did it that way in the first place, but I consider
> changing it out of scope for this patch.

There are drivers where the size varies depending on the exact part.
Maybe this is a cut and paste from one of those or you thought this might get
bigger to support > 16bit channels in the future.  Either way, right now
it is always 16 bits so an appropriately sized type would be good as you
say.   I think such a change should be in a precursor patch probably
rather than left for another day.  Looks trivial to me given st->buf
is only accessed directly in 2 places.

Jonathan

