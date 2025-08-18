Return-Path: <linux-iio+bounces-22952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF31B2B14D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 21:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DE47B91F6
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172DF13C3F6;
	Mon, 18 Aug 2025 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAmv/8cf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F73451A0;
	Mon, 18 Aug 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544242; cv=none; b=oSEwRDO7o1egJHArRoH1j4U67jbhjI8h+w+f4HolDf5izP9KfQT5QYmD0mBsNJ6SZsXFEyk/vJjzUvSg8RpNDaz0/A+HdJFO34SotSMlGr+N3stLgnr2w1M8To3GABXDnu5EkP6yOzvPD8bMGd+H4YC7cDRWBvh6xEz+N3yhIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544242; c=relaxed/simple;
	bh=5/ixijNOzOLZSZAqRBwF7DSxVCuJHp2ukINgkc6/kM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9+7llwgPNmwhY/RY8LveBXjSv2UMeFk6YEED401VwECFwJOF/sPWlRNQX0kYM7KOOLnGWcfvqmIhBBCSUs7m/NJDGM/fkDAGJ+51xn1+RBIFHKXPIX7jenQA1q6reOPnNBV0w9pdfbd+h/i1r9XOrxj2Fyer5ViHCyKubmOcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAmv/8cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB611C4CEEB;
	Mon, 18 Aug 2025 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755544242;
	bh=5/ixijNOzOLZSZAqRBwF7DSxVCuJHp2ukINgkc6/kM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EAmv/8cfXKp+Lwqc8z3dR0fQ5chBKPisEW1JT8cYm5TexEmeus7XhKdfbB3CpClXL
	 OsgR972i8zITPKCLegQgYCXgaERYoSQF9A1lzRQz3pFkg1spGlX/6gyW3a6UpBMh9D
	 P9g5b9dguTAbEhUU287EuIUIPUx+z8UW2gKBam1QZCPsFLk9ZtVSQyx5JJoGWKo92K
	 VgVbezGFbuujHn7AyNDzVEwfPGzYK5gc9Lvd/wQPxYLhAasGJdCmfUZlMPu771QQv0
	 XI73vJCvoVrojmseX/bPM8Nm3oU3cohLWzVU9xAqZn6FGvMAJ+66kYTEBRbnMKcOU2
	 juJ7o6GrXAbbQ==
Date: Mon, 18 Aug 2025 20:10:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250818201035.7a107dec@jic23-huawei>
In-Reply-To: <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
References: <20250818035953.35216-1-bcollins@kernel.org>
	<20250818035953.35216-6-bcollins@kernel.org>
	<20250818191539.69e1882a@jic23-huawei>
	<2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > >  	case IIO_CHAN_INFO_SCALE:
> > >  		*val = 62;
> > >  		*val2 = 500000;
> > >  		return IIO_VAL_INT_PLUS_MICRO;
> > > +  
> > If you want the extra space put it in previous patch.
> >   
> > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > >  		*val = mcp9600_tc_types[data->thermocouple_type];
> > >  		return IIO_VAL_CHAR;
> > > +
> > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > +		if (data->filter_level == 0)  
> > 
> > Return the current requested value. An error is just going to confuse
> > someone who tried to write this before enabling the filter and then
> > checked to see if the write was successful.  
> 
> I could not get a concensus on this. On the one hand, if a user sets a
> value here, would they not assume that the filter was enabled? What
> about cases where a filter_type can be more than one valid type with
> different available coefficients for each? What should it show then?

So I was thinking of this like other things with 'enables' such as events.
For those you always set the value first.  They don't really have a type
field though (well they do but the ABI allows multiple at once unlike filters
so we end up with a quite different looking ABI).

Agreed it gets challenging with multiple filter types. If it weren't for
advertising the range I'd suggest just stashing whatever was written and
then mapping it to nearest possible when the filter type is set.
That's what the ad7124 does for changing between filters anyway
though oddly it doesn't seem to have a control for filter type.

This is a good argument against the whole 'none' value for filter type
- that's not much used so we could deprecate it for new drivers.

I'm not particularly keen on filter_enable but seems we are coming back
around to that option to avoid this corner case.  Alternative being what
you have here which isn't great for ease of use.

So for next version let's go for that. Make sure to include Documentation
in a separate patch though so it's easy to see an poke holes in.

ABI design is a pain sometimes.

Thanks,

Jonathan

