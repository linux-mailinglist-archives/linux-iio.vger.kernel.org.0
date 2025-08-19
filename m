Return-Path: <linux-iio+bounces-23013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BF8B2CC42
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885213AA72D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B471030F555;
	Tue, 19 Aug 2025 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIy7Ypcr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709C22E2295;
	Tue, 19 Aug 2025 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628863; cv=none; b=RC2Xth4ZpIg0TeoUwjcGqu8kTKONz+fsQKiiO3mCgv59bHSSfFjNbYYzFnYQNBRyIlf4g0u6s7LtbnlEIjx5iVKZXOTV5Nkbj/mv1VLjVW8HAaeYWjm28zEK4qdR0lvKIL+Ad9U/wAIz9vX9oToqBZDtdAN3mYmzNDDcBT3vcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628863; c=relaxed/simple;
	bh=0a1jA64zP85j5nkCKum14RPsanSAtddm4BAol+hu3AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7XGk81NfPm0upazulktkHT8sKEiFD6N+iLWUGX8HVJOeaNoRQUlgG4M8ijnGzFz0FhnyLyQMa3u9MwhevVeC2Tr1OaS9uaPIHq8HdALfXVIvtdMFUjdq07f++l7/hBb0SOKp7ehyNiH+cW4bx7nAtJJoswQgBmcUYBj9QtkA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIy7Ypcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A4C4CEF1;
	Tue, 19 Aug 2025 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628863;
	bh=0a1jA64zP85j5nkCKum14RPsanSAtddm4BAol+hu3AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YIy7YpcrY7SumkQHG8opUqm8sXckUSbVHJxmubw6VkbMspaa3SJ3Q6iqtNImSiJlN
	 c3LvsUk3zIoqDaGJBuHnJgJkrU+ZjhoT/967TUEJBcjI6mxYfjxQDRiyv5ik7s9URi
	 1TP13XUa0GKKjvGDyL4hwYXEX/iuiiQ39XlwpFklQzIkyZuai+DZKTGC9a/vBgk1RF
	 oKnGZuqxjMYTVgSlJyzfmXiqj48EyN8vemrim6E91D4VvXDz6LbReVdYqaz/p3ZbeL
	 nPwGWYVr8ecetgJv7Jt8pq1JHkCDxG1abs4WMoXqnULIPbAfzSCysBCK30PGt+Z3+1
	 KNFRAv9sp6kXQ==
Date: Tue, 19 Aug 2025 19:40:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
Message-ID: <20250819194055.09c59121@jic23-huawei>
In-Reply-To: <3e00a420-0db7-4df4-8164-a48dffd864e7@baylibre.com>
References: <20250818183214.380847-1-bcollins@kernel.org>
	<20250818183214.380847-7-bcollins@kernel.org>
	<f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
	<2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
	<f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
	<2025081910-shiny-trout-a937ef@boujee-and-buff>
	<3e00a420-0db7-4df4-8164-a48dffd864e7@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 09:43:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/19/25 9:32 AM, Ben Collins wrote:
> > On Tue, Aug 19, 2025 at 09:15:23AM -0500, David Lechner wrote:  
> >> On 8/19/25 9:11 AM, Ben Collins wrote:  
> >>> On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:  
> >>>> On 8/18/25 1:32 PM, Ben Collins wrote:  
> >>>>> From: Ben Collins <bcollins@watter.com>
> >>>>>
> >>>>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>>>> to allow get/set of this value.
> >>>>>
> >>>>> Use a filter_type[none, ema] for enabling the IIR filter.
> >>>>>
> >>>>> Signed-off-by: Ben Collins <bcollins@watter.com>
> >>>>> ---
> >>>>> +		if (data->filter_level == 0)
> >>>>> +			return -EINVAL;  
> >>>>
> >>>> To implement Jonathan's request from v5, drop this error return.
> >>>> We'll also need a separate bool data->is_filter_enabled field so
> >>>> that we can keep the last set filter_level even when the filter
> >>>> is disabled. (i.e. data->filter_level is never == 0).
> >>>>
> >>>> This way, if you set the filter level, you can enable and disable
> >>>> the filter via filter_type and still have the same filter level.
> >>>>  
> >>>
> >>> Thanks, David. This is exactly what I've implemented, plus the
> >>> filter_enable attribute.
> >>>
> >>> Adding the ABI doc updates as well.
> >>>  
> >>
> >>
> >> Don't add the filter_enable attribute. The filter_type attribute
> >> already does the job.  
> > 
> > That doesn't solve the problem at hand. An example:
> > 
> > - Driver has 3 possible filter_type's, plus "none"
> > - User cats filter_type_available and sees [none, sinc4, sinc5, sinc5+avg]
> > - User cats filter_type and sees "none"
> > - User cats frequency_available: What do they see?
> > - User cats frequency: What do they see?  
> 
> The ones for the last selected filter before it was changed to "none".
> If the driver starts in the "none" state a probe, just pick sinc4
> as the default.

That works, or presenting no available frequencies if "none"
- empty list.  Though check the standard wrapper for available works
with a list of size 0. Not something we've done before.  Maybe a risk
of tripping up some userspace code?

Unlike some attribute/controls this one is unlikely to ever be destructive if we
have to pass through unusual states. Might have a slightly slower
transition to steady state if we are going through something inappropriate
briefly.

> 
> > 
> > Without filter_enable, [none, ema] driver works just fine. But the
> > above driver does not.
> >   
> 
> We can wait and see what Jonathan thinks. But if we introduce a
> new filter_enable attribute, then we need to think about what to
> do about the ad4080 driver since it was the one that recently
> introduced the filter_type = "none". Ideally we would change it
> to work the same so that we are consistent between drivers. But
> there is always the consideration that we can't go breaking existing
> ABI.
I was thinking we could paper over it (hence the email I sent
30 seconds before opening this) with a bonus attribute and basing
both filter_enable and none setting on the same underlying state.
Not that intuitive though as I think more about it. 

Setting off none would enable the filter when maybe a user was just
expecting to be able to see what was available (as will work for
any driver not implementing the 'none' value).  The ABI has always
allowed for interactions like this as sometimes we can't avoid them
but here maybe we can.

So ignore email of 2 mins ago, David's suggestion works better
(with modification for not showing any frequencies when on none possibly?)

Anyhow, lets take a little more time on this. I for one shouldn't
make any decisions quickly as is clear here!

Jonathan



