Return-Path: <linux-iio+bounces-23011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209DB2CC02
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6580E1BC77E3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BD30F553;
	Tue, 19 Aug 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jsv02yBs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45630F542;
	Tue, 19 Aug 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628140; cv=none; b=UQOA0um3i/IJTleiAza5VyP3KyJ992DW+x0c9vvfNPgeETSAED1WgoPshcLRushRW08N6/pKABUSQOJj3xH6C9sM4sy/hXDArv/MGilEE4lNQQF92u0iH3cE5XL3e3FH6tqsJ8HFdcyAkGCGTtFgWyjlgJQfsOkLAwyS3bvF9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628140; c=relaxed/simple;
	bh=lfNVFRCVQP9Y2v4BznzPkI4TqLvhY4vcMMGXECKf2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8zxIHWDeS7d+BcttLhJucgM2CM2DP6NQNOz39qG6YWCUbQERA1RECyXHCPKVrDcx/55dKKvgh8ieqyw6k+lyz778nPRNOyg3pNjkFne6w5m56SMqLj7S5mlBMGzmTvVGkUIfzfLG0mdCuT0cPNxhlmQGVQkXtzusdtxxMVG4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jsv02yBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0028C4CEF1;
	Tue, 19 Aug 2025 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755628139;
	bh=lfNVFRCVQP9Y2v4BznzPkI4TqLvhY4vcMMGXECKf2b0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jsv02yBsjgz0TFPQQeXBA3QVA84W9ZrZ8wham88YSgDAetcwwnLdQNfOfIxi7BUsq
	 BTjMdHQLAu2CH07YlMln3jC6zsCPyL925cbPCglgL4XvWUB58KP4ERttYRUY3CRHXn
	 8v1UzFiA+PVEkftniVl6PoSUjZK7bCmvD0lbMf3G/3QDYqgARiXngxTy+JvL6s4vkA
	 DJc1nJMlfvXK0PCDLXTyeV1WVVNdD1+WpV9Ji/ydOE0+Yvy2nb5S5e1YJSkPnOsj8K
	 CilqgzPVrR/pUq/iGP8A4J+6YuRyDZtJdTV1c3NDhneKC+JUYHb61cxsX1/vFp21vO
	 E8vC/AjMRvD8g==
Date: Tue, 19 Aug 2025 19:28:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <20250819192851.6179e598@jic23-huawei>
In-Reply-To: <2025081815-encouraging-swift-df1d16@boujee-and-buff>
References: <20250818035953.35216-1-bcollins@kernel.org>
	<20250818035953.35216-6-bcollins@kernel.org>
	<20250818191539.69e1882a@jic23-huawei>
	<2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
	<20250818201035.7a107dec@jic23-huawei>
	<2025081815-encouraging-swift-df1d16@boujee-and-buff>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 16:00:20 -0400
Ben Collins <bcollins@kernel.org> wrote:

> On Mon, Aug 18, 2025 at 08:10:35PM -0500, Jonathan Cameron wrote:
> >   
> > > > >  	case IIO_CHAN_INFO_SCALE:
> > > > >  		*val = 62;
> > > > >  		*val2 = 500000;
> > > > >  		return IIO_VAL_INT_PLUS_MICRO;
> > > > > +    
> > > > If you want the extra space put it in previous patch.
> > > >     
> > > > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > > > >  		*val = mcp9600_tc_types[data->thermocouple_type];
> > > > >  		return IIO_VAL_CHAR;
> > > > > +
> > > > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > > > +		if (data->filter_level == 0)    
> > > > 
> > > > Return the current requested value. An error is just going to confuse
> > > > someone who tried to write this before enabling the filter and then
> > > > checked to see if the write was successful.    
> > > 
> > > I could not get a concensus on this. On the one hand, if a user sets a
> > > value here, would they not assume that the filter was enabled? What
> > > about cases where a filter_type can be more than one valid type with
> > > different available coefficients for each? What should it show then?  
> > 
> > So I was thinking of this like other things with 'enables' such as events.
> > For those you always set the value first.  They don't really have a type
> > field though (well they do but the ABI allows multiple at once unlike filters
> > so we end up with a quite different looking ABI).
> > 
> > Agreed it gets challenging with multiple filter types. If it weren't for
> > advertising the range I'd suggest just stashing whatever was written and
> > then mapping it to nearest possible when the filter type is set.
> > That's what the ad7124 does for changing between filters anyway
> > though oddly it doesn't seem to have a control for filter type.
> > 
> > This is a good argument against the whole 'none' value for filter type
> > - that's not much used so we could deprecate it for new drivers.
> > 
> > I'm not particularly keen on filter_enable but seems we are coming back
> > around to that option to avoid this corner case.  Alternative being what
> > you have here which isn't great for ease of use.  
> 
> I'm somewhat wondering if the filter frequency and frequency_available
> attributes should not even show in sysfs unless the filter_type was
> something other than "none".
> 
I'm not keen on that and trying to bolt is_visible into the mess of how
we generate attributes would be hard and actual add and remove of attributes
is horrible for races with userspace.

> > So for next version let's go for that. Make sure to include Documentation
> > in a separate patch though so it's easy to see an poke holes in.  
> 
> Just to make sure I understand, you'd like to see a filter_enable
> attribute and filter_type would not contain "none", then frequency and
> frequency_available would always show something for whatever was in
> filter_type?

Yes.  I think that is best way forwards.  If we want to retrofit the one
user of none to support the new ABI as well it should be easy to do.

> 
> > ABI design is a pain sometimes.  
> 
> The epitome of being able to paint yourself into a corner.
> 
Yup.

J


