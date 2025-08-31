Return-Path: <linux-iio+bounces-23537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5825B3D41B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C818940CE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762A1E32B7;
	Sun, 31 Aug 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxXcvXzW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74EF9C1;
	Sun, 31 Aug 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653559; cv=none; b=dFiE53bYAO0KpoA7+slwykIkRfYqmfkNG3aCJaqE6yXShR3qBQvWdAg4VibwccsAJoGH3elqWvR0/nSCIXB3YXCag4rmeYUKu15/WrC5tMi/JZ4x8ew0qrqPKQvwLnTY3+eTy0xa1uBX9d60JLnjQZMd4v5CTBs20ml37lA5bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653559; c=relaxed/simple;
	bh=k5YZDIOppyOF38dq64awhf4ryTjgDCmFCyXppZD/UM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlHE+il4zu7pg0tHzpkdRhaFd72z5DDVzo2dyQnXSbdae4NBYShIlQVUQOi8kSRzg6dAn3yZXa4p3dPPCwyv7N8IKf0fskqW0AHEnVUopeCVEbFbh0jDiFy0ho2820TMmrH3mPcHZRtXZ8oimguDsA36wDPb0nT10ff2gHRsVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxXcvXzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D363C4CEED;
	Sun, 31 Aug 2025 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756653558;
	bh=k5YZDIOppyOF38dq64awhf4ryTjgDCmFCyXppZD/UM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxXcvXzWReOQNLCeTsMYBnzew4uVjTNuOt9hnNDhuM+FbGuZAChutQsOH3axImH0k
	 OlC8lUYeRJDCTmACu7MT2geiIqGjMSnIsi4Nwd93kn3GroYemd3RZonfXbFDQU1IwK
	 1civbB6stT7qmsVPfORp+m9gOgrgYkHCkuwXQYoQUUHiG48n6/7Zu0TvcvLwt7UFYB
	 qeGOohwgDnYUKjP+7Rh3szxlrEOwKjQ36//0Ci+3qHXbHD0YFa7mkjSYDU69+Ce/Gg
	 ylaOSrVl5GXMwY/NFVjZ/FhJWs9hnP2r0y8BP9a7UB8mAumo5XHUvOLYFYhSVf401H
	 eIjjeUVg0OSXg==
Date: Sun, 31 Aug 2025 16:19:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] iio: core: Add IIO_VAL_EMPTY type
Message-ID: <20250831161909.1bc5872a@jic23-huawei>
In-Reply-To: <2025082614-passionate-panther-8016ba@boujee-and-buff>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
	<20250825-mcp9600-iir-v7-1-2ba676a52589@kernel.org>
	<9fd7f08f-51cc-4155-a5e2-c6ba2f1c4897@baylibre.com>
	<2025082614-passionate-panther-8016ba@boujee-and-buff>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 14:52:27 -0400
Ben Collins <bcollins@kernel.org> wrote:

> On Tue, Aug 26, 2025 at 12:00:05PM -0500, David Lechner wrote:
> > On 8/25/25 7:10 PM, Ben Collins wrote:  
> > > In certain situations it may be necessary to return nothing when reading
> > > an attribute.
> > > 
> > > For example, when a driver has a filter_type of "none" it should not
> > > print any information for frequency or available frequencies.
> > > 
> > > Signed-off-by: Ben Collins <bcollins@kernel.org>
> > > ---
> > >  drivers/iio/industrialio-core.c | 1 +
> > >  include/linux/iio/types.h       | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > index 159d6c5ca3cec3f5c37ee9b85ef1681cca36f5c7..e4ff5b940223ab58bf61b394cc9357cd3674cfda 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -702,6 +702,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
> > >  	case IIO_VAL_INT_64:
> > >  		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
> > >  		return sysfs_emit_at(buf, offset, "%lld", tmp2);
> > > +	case IIO_VAL_EMPTY:
> > >  	default:
> > >  		return 0;
> > >  	}
> > > diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> > > index ad2761efcc8315e1f9907d2a7159447fb463333e..261745c2d94e582bcca1a2abb297436e8314c930 100644
> > > --- a/include/linux/iio/types.h
> > > +++ b/include/linux/iio/types.h
> > > @@ -32,6 +32,7 @@ enum iio_event_info {
> > >  #define IIO_VAL_FRACTIONAL 10
> > >  #define IIO_VAL_FRACTIONAL_LOG2 11
> > >  #define IIO_VAL_CHAR 12
> > > +#define IIO_VAL_EMPTY 13
> > >  
> > >  enum iio_available_type {
> > >  	IIO_AVAIL_LIST,
> > >   
> > 
> > This is an interesting idea, but I think it would be a lot of work
> > to teach existing userspace tools to handle this new possibility.
> > 
> > On top of that, I'm not quite convinced it is necessary. If a numeric
> > value is undefined, then there is already a well known expression for
> > that: "nan". Or in the case of this series, the 3dB point when the
> > filter is disable could also be considered "inf". Using these would have
> > a better chance of working with existing userspace tools since things
> > like `scanf()` can already handle these.  
> 
> I'm ok with "inf", but then would there also be an "inf" in available
> frequencies?
> 
> This would take us all the way back to where I could just not even need
> a filter_type==none and make the 3db available values:
> 
> { inf, 0.5xxx, ... }
> 
> And inf would just be the filter is disabled.
> 

Definitely an interesting concept and with appropriate documentation
additions I rather like it.  What particular formating of INF do
fscanf and friends accept?  looks like it's the strtod() man page
which says INF of INFINITY (disregarding case).  So indeed inf seems
like a valid choice.

Jonathan


