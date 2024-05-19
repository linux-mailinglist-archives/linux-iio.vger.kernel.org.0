Return-Path: <linux-iio+bounces-5137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215D48C969A
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 22:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA0E285223
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265166A332;
	Sun, 19 May 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2mOMqWX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245F5024E;
	Sun, 19 May 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150776; cv=none; b=hSGxj0jguP3SKGqsN7h+RDdbZwTR+B+ennDxFRAF2El2ekEeDBmVANzDxzMP76iNauzaZpXQWY4ABQnzfq6kufZ5gjX7IAwj3kyKq9a3DcX4WlVBM4imbusXA5o5vZ/AMLMqR6715KOVYl0HU3xcjMyuGBHXnwxefvaZERQ0u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150776; c=relaxed/simple;
	bh=B67zx55BXVPRDqr+VxV/B3N9LmQjSyqMHUdH6fCQoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr2UwMthrJrIvFYuPHxd7RMvwQPuI7STbWvsC8Amm2wsIb/MRUcBVB4Lc5tq3GK9tN3udXEFQq7OL8DPSr/NdVV9PdCAbDgUw8QHJVe5t2I4jNIBPRuX4aSe5dkqm8zgVNYBj9TXoIepjkHes9Ufl2QrtMhAUDx/45dHMeUuqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2mOMqWX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202ca70287so10951525e9.3;
        Sun, 19 May 2024 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716150773; x=1716755573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhgPuzlxsOcCWNyFWxUD91IphBlIn/MfHVkMLGAcKZ8=;
        b=m2mOMqWXpze7CMUBr5vgUC4AuSA+D+7nxWRxLSSR9IKWJzchd/XsUq5DyczDau9Ad0
         qynQ/dyRjbYinhj/5a2mMwRyP17HaDFdsEFPD+Hqy0P+tpJRqsctxMrnxloljdumpkDv
         h6oUuakWoWdVvOj5apfuEJ8kiEoL5l53Tmx9Abvuw+MtOxKnTpN6Cj5fAEWe9gRT6m/1
         Lg8YSxI6TlWXzS1vba0MeTnO+O1sF72Y3hfuOYkiUJlu4xbwNEXo5NBDO+dU2WgmJOwC
         7Th2AKByKyRQCedJHaPypa6f63GrJpwYbtOq+/d5IbEEdTFLHTl68mO7ZgMUKRGhoHpi
         m1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716150773; x=1716755573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhgPuzlxsOcCWNyFWxUD91IphBlIn/MfHVkMLGAcKZ8=;
        b=KmxPp8W6M36YRK94ikeMUQ8BEF/yvNWW/t/79h5acED2mqHJ8/Fb4I87nLEcxtVI1y
         59lB0zkH19gSzEWqtA2spjEM32rwaExy+xmRa36Va11nI/laOta+E3HyBxD/dau/gjo4
         1aYSYkYI165wg50IHqjzf+BgRwYzqtzfzA/bHJ1PogrKrEZ/wPn0l/y9YmfJW3+Z3qiY
         CKHsPglyF7ZEZ6x4WXmUjrfJyf0A7EcGuKfXQ8iDHxmil92gXcD3ENfjThOoBk2hqrJ9
         lwzcNqn633c5BHqW3JjNayvL3PpGx7RwfcN++WQ7n7LF9jci6tu5jPWk/ppUBIBGoIU1
         UirQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+cTbdtYwy/b7UtN8rq9QidQQJLXMCVUsO9B9IgbV23nn4lztRowe3u54zuJPz7aTQ+Cphdmi9Ih+OM8PVbnp5G9+Sh2z4dlKe3tsyS0zKLGtHE67HG22NYWlzqUhaH4mxSXVW1JC
X-Gm-Message-State: AOJu0YwS55eabGtOQTfBj7+swCtxlRqYGc6o3s+RXT9obG7/in6l9tQR
	mj1UXUCZeMuEFICfo8llqp+telFYKhb5pEUGtGqZCJVza4MX+ulW
X-Google-Smtp-Source: AGHT+IEKV2eZF4f8NTqe2Y2slOHO93CwAMtBHbYBrP2h1xq2zedV0nBuxdazTtk5EwLRtmcXHZBzFw==
X-Received: by 2002:a05:600c:4f50:b0:420:34a0:bb51 with SMTP id 5b1f17b1804b1-42034a0bbbemr69428995e9.18.1716150773346;
        Sun, 19 May 2024 13:32:53 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24c0sm395094065e9.17.2024.05.19.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 13:32:52 -0700 (PDT)
Date: Sun, 19 May 2024 22:32:50 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for both
 channels
Message-ID: <20240519203250.GA10322@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
 <20240517081050.168698-2-dima.fedrau@gmail.com>
 <20240519171438.08810789@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519171438.08810789@jic23-huawei>

Am Sun, May 19, 2024 at 05:14:38PM +0100 schrieb Jonathan Cameron:
> On Fri, 17 May 2024 10:10:49 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > The mapping from cold junction to ambient temperature is inaccurate. We
> > provide an index for hot and cold junction temperatures.
> > 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Hi Dmitri,
>
Hi Jonathan,

> I'm not sure you replied to the question in previous review of what
> sysfs files exist for this device.  Whilst I am at least a little
> open to changing the ABI, I'd like to fully understand what
> is currently presented and why iio_info is having trouble with it.
> 
I did, see: https://lore.kernel.org/linux-iio/20240509193125.GA3614@debian/T/#u

But maybe not to the point. Sysfs is working correct and iio_info
probably not. There is only one channel found, the temp_ambient. I would
have expected two channels. Instead there are four attributes, I would
have expected two. It seems to me that they are just duplicated. I also
added the output when setting channel2 member of channel 0 to
IIO_MOD_TEMP_OBJECT. This time iio_info works fine.

> I also want an ack from Andrew on this one given might break it existing
> usage.
> 
> The current interface is perhaps less than ideal, but I don't think it
> is wrong as such. Whilst I wasn't particularly keen on the cold junction
> == ambient I'm not sure moving to just indexed is an improvement.
> Hence looking for input from Andrew. +CC Nuno as someone who is both
> active in IIO and has written thermocouple front end drivers in
> the past.
> 
I just thought the setting of channel2 member to IIO_MOD_TEMP_OBJECT was
missing. But it turned out that it is not set for a reason. I'm fine
with the existing mapping, but would be still interesting to know how
others think about the mapping.

Dimitri

> 
> > ---
> >  drivers/iio/temperature/mcp9600.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index 46845804292b..22451d1d9e1f 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -14,6 +14,9 @@
> >  
> >  #include <linux/iio/iio.h>
> >  
> > +#define MCP9600_CHAN_HOT_JUNCTION	0
> > +#define MCP9600_CHAN_COLD_JUNCTION	1
> > +
> >  /* MCP9600 registers */
> >  #define MCP9600_HOT_JUNCTION 0x0
> >  #define MCP9600_COLD_JUNCTION 0x2
> > @@ -25,17 +28,19 @@
> >  static const struct iio_chan_spec mcp9600_channels[] = {
> >  	{
> >  		.type = IIO_TEMP,
> > +		.channel = MCP9600_CHAN_HOT_JUNCTION,
> >  		.address = MCP9600_HOT_JUNCTION,
> >  		.info_mask_separate =
> >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +		.indexed = 1,
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> > +		.channel = MCP9600_CHAN_COLD_JUNCTION,
> >  		.address = MCP9600_COLD_JUNCTION,
> > -		.channel2 = IIO_MOD_TEMP_AMBIENT,
> > -		.modified = 1,
> >  		.info_mask_separate =
> >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +		.indexed = 1,
> >  	},
> >  };
> >  
> 

