Return-Path: <linux-iio+bounces-23017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E2B2CE2A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D297BA717
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA633CE83;
	Tue, 19 Aug 2025 20:37:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE62E2292
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635873; cv=none; b=LgC9U/9bjvuU2YRshOwAZ2Gqh4BtqErYN9YkENZ+kEtZoTQLx3SmasAaN3nynLsUsozwGemUkaANnGV+llsOLF8VaNquBeVNrnaIk8rGW0ju8KOoCViy9if0mNf4zdifC3BUIt5WpFRfNyc3VSfgooS+hd23TfE3QHyNCa1LawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635873; c=relaxed/simple;
	bh=P443IUhsPYciAVZezJoADKRgud6NxnR3q0xgdUzNnms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnAr6DbON02TovmqdJFkjqT3bCYbTWD11OrEikzyqkn4saIH3+e6e479Z12HQAqaeSSdaN7yUapi2gIIQogqfE6p4ofGqzJdym6h0oc9/9DPBKJId1VV3hNRbGSUTVkSEFW32C8l4IAuELjp+BWGGqr6GqfE5SUEcEFCsPhzaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 16:37:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081916-abstract-manatee-be4ac4@boujee-and-buff>
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
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819192851.6179e598@jic23-huawei>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 07:28:51PM -0500, Jonathan Cameron wrote:
> On Mon, 18 Aug 2025 16:00:20 -0400
> Ben Collins <bcollins@kernel.org> wrote:
> 
> > On Mon, Aug 18, 2025 at 08:10:35PM -0500, Jonathan Cameron wrote:
> > >   
> > > > > >  	case IIO_CHAN_INFO_SCALE:
> > > > > >  		*val = 62;
> > > > > >  		*val2 = 500000;
> > > > > >  		return IIO_VAL_INT_PLUS_MICRO;
> > > > > > +    
> > > > > If you want the extra space put it in previous patch.
> > > > >     
> > > > > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > > > > >  		*val = mcp9600_tc_types[data->thermocouple_type];
> > > > > >  		return IIO_VAL_CHAR;
> > > > > > +
> > > > > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > > > > +		if (data->filter_level == 0)    
> > > > > 
> > > > > Return the current requested value. An error is just going to confuse
> > > > > someone who tried to write this before enabling the filter and then
> > > > > checked to see if the write was successful.    
> > > > 
> > > > I could not get a concensus on this. On the one hand, if a user sets a
> > > > value here, would they not assume that the filter was enabled? What
> > > > about cases where a filter_type can be more than one valid type with
> > > > different available coefficients for each? What should it show then?  
> > > 
> > > So I was thinking of this like other things with 'enables' such as events.
> > > For those you always set the value first.  They don't really have a type
> > > field though (well they do but the ABI allows multiple at once unlike filters
> > > so we end up with a quite different looking ABI).
> > > 
> > > Agreed it gets challenging with multiple filter types. If it weren't for
> > > advertising the range I'd suggest just stashing whatever was written and
> > > then mapping it to nearest possible when the filter type is set.
> > > That's what the ad7124 does for changing between filters anyway
> > > though oddly it doesn't seem to have a control for filter type.
> > > 
> > > This is a good argument against the whole 'none' value for filter type
> > > - that's not much used so we could deprecate it for new drivers.
> > > 
> > > I'm not particularly keen on filter_enable but seems we are coming back
> > > around to that option to avoid this corner case.  Alternative being what
> > > you have here which isn't great for ease of use.  
> > 
> > I'm somewhat wondering if the filter frequency and frequency_available
> > attributes should not even show in sysfs unless the filter_type was
> > something other than "none".
> > 
> I'm not keen on that and trying to bolt is_visible into the mess of how
> we generate attributes would be hard and actual add and remove of attributes
> is horrible for races with userspace.
> 
> > > So for next version let's go for that. Make sure to include Documentation
> > > in a separate patch though so it's easy to see an poke holes in.  
> > 
> > Just to make sure I understand, you'd like to see a filter_enable
> > attribute and filter_type would not contain "none", then frequency and
> > frequency_available would always show something for whatever was in
> > filter_type?
> 
> Yes.  I think that is best way forwards.  If we want to retrofit the one
> user of none to support the new ABI as well it should be easy to do.

I'm good with that. I'll get a patch to update the ABI, add filter_enable
usage in mcp9600 IIR patch, and provide another patch for ad4080 to convert
to this.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

