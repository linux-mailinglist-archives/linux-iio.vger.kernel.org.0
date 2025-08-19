Return-Path: <linux-iio+bounces-23018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4CB2CE2D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B2F4E7269
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C29342C91;
	Tue, 19 Aug 2025 20:41:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B2266580
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636073; cv=none; b=YDqZLnWAW5A7DLl2peLQWguzrCdOQZVqWlcjWBeWFPhaDlOLqbkzYHU5FISk1zHF4mE1il4ptFRWDEYS/DfN38Mfcj+nkoY8MdSHdGbmZsfMO3LBrmP4r/hU68G6A/SBSx0L3yq/EJXA3jMr2RgLK89zB71IgsZ6+giSkwHfs8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636073; c=relaxed/simple;
	bh=gT/0vp/aJ1zHc0Fhry31NDZmUKkowzxZyYcX7BD+Avc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkq6lArCJ2BjMllu19XX7zLNtGiFrJrGw9pWesG+Ig9pYSy+Fwt5tEapzrB8oGLb4S/UYmld4CnMjH7tVFduraHCnEUex/2EmXrW41YRMa9/mYNFg3OXmyinAqXTffd0oQgVTHvGghgIWiIFdwDJC5+FAF5iBy7otTPy/1dWwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 16:41:05 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081916-auspicious-centipede-ef9f92@boujee-and-buff>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-6-bcollins@kernel.org>
 <20250818191539.69e1882a@jic23-huawei>
 <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
 <20250818201035.7a107dec@jic23-huawei>
 <2025081815-encouraging-swift-df1d16@boujee-and-buff>
 <20250819192851.6179e598@jic23-huawei>
 <20250819193837.74c762c4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819193837.74c762c4@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 07:38:37PM -0500, Jonathan Cameron wrote:
> On Tue, 19 Aug 2025 19:28:51 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 18 Aug 2025 16:00:20 -0400
> > Ben Collins <bcollins@kernel.org> wrote:
> > 
> > > On Mon, Aug 18, 2025 at 08:10:35PM -0500, Jonathan Cameron wrote:  
> > > >     
> > > > > > >  	case IIO_CHAN_INFO_SCALE:
> > > > > > >  		*val = 62;
> > > > > > >  		*val2 = 500000;
> > > > > > >  		return IIO_VAL_INT_PLUS_MICRO;
> > > > > > > +      
> > > > > > If you want the extra space put it in previous patch.
> > > > > >       
> > > > > > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > > > > > >  		*val = mcp9600_tc_types[data->thermocouple_type];
> > > > > > >  		return IIO_VAL_CHAR;
> > > > > > > +
> > > > > > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > > > > > +		if (data->filter_level == 0)      
> > > > > > 
> > > > > > Return the current requested value. An error is just going to confuse
> > > > > > someone who tried to write this before enabling the filter and then
> > > > > > checked to see if the write was successful.      
> > > > > 
> > > > > I could not get a concensus on this. On the one hand, if a user sets a
> > > > > value here, would they not assume that the filter was enabled? What
> > > > > about cases where a filter_type can be more than one valid type with
> > > > > different available coefficients for each? What should it show then?    
> > > > 
> > > > So I was thinking of this like other things with 'enables' such as events.
> > > > For those you always set the value first.  They don't really have a type
> > > > field though (well they do but the ABI allows multiple at once unlike filters
> > > > so we end up with a quite different looking ABI).
> > > > 
> > > > Agreed it gets challenging with multiple filter types. If it weren't for
> > > > advertising the range I'd suggest just stashing whatever was written and
> > > > then mapping it to nearest possible when the filter type is set.
> > > > That's what the ad7124 does for changing between filters anyway
> > > > though oddly it doesn't seem to have a control for filter type.
> > > > 
> > > > This is a good argument against the whole 'none' value for filter type
> > > > - that's not much used so we could deprecate it for new drivers.
> > > > 
> > > > I'm not particularly keen on filter_enable but seems we are coming back
> > > > around to that option to avoid this corner case.  Alternative being what
> > > > you have here which isn't great for ease of use.    
> > > 
> > > I'm somewhat wondering if the filter frequency and frequency_available
> > > attributes should not even show in sysfs unless the filter_type was
> > > something other than "none".
> > >   
> > I'm not keen on that and trying to bolt is_visible into the mess of how
> > we generate attributes would be hard and actual add and remove of attributes
> > is horrible for races with userspace.
> > 
> > > > So for next version let's go for that. Make sure to include Documentation
> > > > in a separate patch though so it's easy to see an poke holes in.    
> > > 
> > > Just to make sure I understand, you'd like to see a filter_enable
> > > attribute and filter_type would not contain "none", then frequency and
> > > frequency_available would always show something for whatever was in
> > > filter_type?  
> > 
> > Yes.  I think that is best way forwards.  If we want to retrofit the one
> > user of none to support the new ABI as well it should be easy to do.
> > 
> 
> Ignore that. David convinced me otherwise.  Lets take this a bit slow
> and discuss it fully in other branch of this thread.

Maybe a working solution would help the conversation to see how it would
look.

I think I can rework ad4080 so that it keeps "none" filter_type, but
also can make use of filter_enable. That way it can continue to work
for users while still providing a better interface for anything else
moving forward.

I can send this as a separate RFC series from my current mcp9600 changes
to break this out.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

