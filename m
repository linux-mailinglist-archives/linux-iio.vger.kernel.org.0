Return-Path: <linux-iio+bounces-10470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCA99AB96
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB83CB24156
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421081D1E80;
	Fri, 11 Oct 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiH8rrKl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565421CCB3B;
	Fri, 11 Oct 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672633; cv=none; b=bNgJh6kianKXNheTGARzUCmTz7zUQWjur9G1lOBIoFuVAPkST3ItfInXLT0jrmkZG7zF/6VHwDpZXwPNvbr81QxJgDAfkTfOXfO8t4bPnvW5+c+da9CJ6K/GsBrNgBpGXFfKTMIN4w6EhE2E/CfL4Y1lAG/9I4UaKEJt57ZIbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672633; c=relaxed/simple;
	bh=3F388Arcqlq2qcRdsmhdhsXmGM25pnqX4Jd+bOEhxeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYhRKl8mlxSTMwrDN9f+Ti0yVnJ0v0WYh31BqaJXoIEai4jb06+Cky3NGnqJ5Yzly5U3Yhbri6if+Q3HUsJPQznAQViDQefKxGJfKWLTwRjZLux6YbOB6D9g+4NkePeDmLw7x2yrOLOa7S7vP94l20zGq8+i1tLDJsdv+uXm3zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiH8rrKl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4311bb9d4beso11875595e9.3;
        Fri, 11 Oct 2024 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672629; x=1729277429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LZDO0xer28pCD5to2ahu/Ktear7k2JWopdBYA6NW9g=;
        b=kiH8rrKlLyMjR3jHDjHmRGYDpffCnWjyiG08sFAQenMnzfZICUsZTJA5Pu6s216D1h
         saYGeF/G7iHuRbfvVQlK6+omPvXdYrNUg+8/XJkwjJQSsq7yw4WagcoGIi1L8zNFyFui
         Vz80OEqkzJJWtT6jCjkvXqeuCiY0siL3nubJGtUKJhRaqoQ3GOTRysKlabIj1HFqYaaw
         ediKYwOLXc7rkhLJVFFqsXu6yl24eKLDabHl/KMwskocMIc6z84z1c4teW0J/85uiYlz
         Ho6F+s6zDjjKd9gEjP6qLi5GR8aZv+P0QlbMntGP0UlVSd1lYmPDx2gxicu/6IvbmouI
         8j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672629; x=1729277429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LZDO0xer28pCD5to2ahu/Ktear7k2JWopdBYA6NW9g=;
        b=GoQH27RaazuQAdHKhz8KaZW9WTf4W7lvCxgEM6sg1fmLBTVpDc+HhCd/DeTC2lMm4a
         Z/QOmb73I3rTQPWcVDzUXwLBEPtYocbPbi+bd3a1NdrxghAMG8QBhtT2vNvSfZb4qMyS
         DtfPRZ19Vh4w0ynfckmw4geQH7gdollNbR8WucYsIZlQMh0QwzYGTGcGjcXvRVHzCEYq
         ewv+uu74MlH6gqhOvFyqeiQOjmJaICwnbEVl/vLLoKACtV068gcDQy0JBbtvgxGtQvK7
         lZrw6x6Xm1IRtLmy95eU4rldAszISKttewPi0EMUx/DYE3OX+spJOk9Q6Xm2atdE3G0V
         z66A==
X-Forwarded-Encrypted: i=1; AJvYcCU+2QvaDDvs9u12brf+0GWRJ1+/LM28Df5BUv3MbJi+TGrbc2cznBX3dKpGQLkWJcTSbSOGyJvCqEZQ@vger.kernel.org, AJvYcCU+Oobyjv/ecOWgBM81Bg519C8zDhjjlrihzrLVuvxshR9CgAGnbeC9bqtocqC8xAb0wrhdkBw4PlNFLgew@vger.kernel.org, AJvYcCUJiv2Jm9GEjJvrL/+AZldgysASiBQFhjSfpk3FA6gDtDtnBvpmDcW+TxrO7D0MZCn8zRX4W/kogQNX@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGYARIs9gvIKuPuqw18nc6l2eHnywviZo6rmT2LZ1CtdvtawG
	8b7x/DSEXZ6xxwzQHswra6e/vrwTNSlDbm4fcO5gFd4/vbgX21a0hC2NsSPept0=
X-Google-Smtp-Source: AGHT+IEr3q+CPFpLeUhCOMvMb+yDvBmHUuTzhTrkQa2EAft0T7nmKrAo6NPXsw2bmDbQ/bKdnPzfqg==
X-Received: by 2002:a05:600c:4f07:b0:42c:bf94:f9a6 with SMTP id 5b1f17b1804b1-431256099f2mr3348175e9.26.1728672629381;
        Fri, 11 Oct 2024 11:50:29 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d748d445sm81489345e9.44.2024.10.11.11.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:50:28 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:50:27 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/13] iio: chemical: bme680: avoid using camel case
Message-ID: <ZwlzczfUPtqA5SA1@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-3-vassilisamir@gmail.com>
 <Zwj3QZE30juE53Vy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj3QZE30juE53Vy@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:00:33PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:19PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Rename camel case variable, as checkpatch.pl complains.
> 
> With given reply to the first patch...
>

Hi Andy,

> ...
> 
> >  	/* Look up table for the possible gas range values */
> > -	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
> > +	static const u32 lookup_table[16] = {2147483647u, 2147483647u,
> >  				2147483647u, 2147483647u, 2147483647u,
> >  				2126008810u, 2147483647u, 2130303777u,
> >  				2147483647u, 2147483647u, 2143188679u,
> 
> ...here is the opportunity to fix indentation while at fixing the code.
> I.o.w. I would reformat the entire table to be
> 
> 	static const u32 lookup_table[16] = {
> 		2147483647u, 2147483647u, 2147483647u, 2147483647u,
> 		2147483647u, 2126008810u, 2147483647u, 2130303777u,
> 		2147483647u, 2147483647u, 2143188679u, ...
> 
> (also note power-of-2 number of items per line which much easier to read and
>  find one you need).
> 

ACK.

> ...
> 
> >  	var1 = ((1340 + (5 * (s64)calib->range_sw_err)) *
> > -			((s64)lookupTable[gas_range])) >> 16;
> > +			((s64)lookup_table[gas_range])) >> 16;
> 
> Also an opportunity to make this neater like
> 
> 	var1 = (1340 + (5 * (s64)calib->range_sw_err)) * (s64)lookup_table[gas_range]);
> 	var1 >>= 16;
> 
> So, at bare minumym there are redundant parentheses. And looking at the table
> and the first argument of multiplication I'm puzzled why casting is needed for
> the second? Shouldn't s64 already be implied by the first one?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

I think the 2nd cast indeed is not needed since the 1st one forces the
s64 so I can remove it.

Cheers,
Vasilis

