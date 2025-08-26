Return-Path: <linux-iio+bounces-23311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB2DB372A1
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667775E8689
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6323C2F0C48;
	Tue, 26 Aug 2025 18:52:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FE3AC22
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234356; cv=none; b=fH2728OdzFo7f32ZMOp8OVmHZDOKkPVD5esTRonyri9Rjo4Wh3yCWKRyOxyn98F+iiOGErhf8ODLDYCULaJyc5jtmiYjoExoDIsmYeyofkcDnTLYCTe3j5StLqk2iDpWWDtzeDxc/Tn6XxVxi8klZ1mDrkKjiyRXfebIFnHv7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234356; c=relaxed/simple;
	bh=ysGMvxjXeLxucIqZRoBjJFzvfOCN+qR2v3Hnbp0cf4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKA73dw/bgtLsTSqkUWZJn4KqiKOKWAoEu25q6IrvakA5fHmu/fqi57TywvOnV0QSOIuKaKTj8OmGAYHAwDViyNjbRAolxNTJkIjbPHldSPycwKaF4PBORpkwAt1Sse7dai9CMCwBahy1XGCrKGd1KyHVAPYgklzeMT3I9oXXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Aug 2025 14:52:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] iio: core: Add IIO_VAL_EMPTY type
Message-ID: <2025082614-passionate-panther-8016ba@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
 <20250825-mcp9600-iir-v7-1-2ba676a52589@kernel.org>
 <9fd7f08f-51cc-4155-a5e2-c6ba2f1c4897@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd7f08f-51cc-4155-a5e2-c6ba2f1c4897@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 26, 2025 at 12:00:05PM -0500, David Lechner wrote:
> On 8/25/25 7:10 PM, Ben Collins wrote:
> > In certain situations it may be necessary to return nothing when reading
> > an attribute.
> > 
> > For example, when a driver has a filter_type of "none" it should not
> > print any information for frequency or available frequencies.
> > 
> > Signed-off-by: Ben Collins <bcollins@kernel.org>
> > ---
> >  drivers/iio/industrialio-core.c | 1 +
> >  include/linux/iio/types.h       | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 159d6c5ca3cec3f5c37ee9b85ef1681cca36f5c7..e4ff5b940223ab58bf61b394cc9357cd3674cfda 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -702,6 +702,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> >  	case IIO_VAL_INT_64:
> >  		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> >  		return sysfs_emit_at(buf, offset, "%lld", tmp2);
> > +	case IIO_VAL_EMPTY:
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > index ad2761efcc8315e1f9907d2a7159447fb463333e..261745c2d94e582bcca1a2abb297436e8314c930 100644
> > --- a/include/linux/iio/types.h
> > +++ b/include/linux/iio/types.h
> > @@ -32,6 +32,7 @@ enum iio_event_info {
> >  #define IIO_VAL_FRACTIONAL 10
> >  #define IIO_VAL_FRACTIONAL_LOG2 11
> >  #define IIO_VAL_CHAR 12
> > +#define IIO_VAL_EMPTY 13
> >  
> >  enum iio_available_type {
> >  	IIO_AVAIL_LIST,
> > 
> 
> This is an interesting idea, but I think it would be a lot of work
> to teach existing userspace tools to handle this new possibility.
> 
> On top of that, I'm not quite convinced it is necessary. If a numeric
> value is undefined, then there is already a well known expression for
> that: "nan". Or in the case of this series, the 3dB point when the
> filter is disable could also be considered "inf". Using these would have
> a better chance of working with existing userspace tools since things
> like `scanf()` can already handle these.

I'm ok with "inf", but then would there also be an "inf" in available
frequencies?

This would take us all the way back to where I could just not even need
a filter_type==none and make the 3db available values:

{ inf, 0.5xxx, ... }

And inf would just be the filter is disabled.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

