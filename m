Return-Path: <linux-iio+bounces-13763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6189FB0BE
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 16:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDB5188266C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3F1420A8;
	Mon, 23 Dec 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRq43BHa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5213BAE3;
	Mon, 23 Dec 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734967744; cv=none; b=lBRr2GQC1wnf5i08JHliti+BLiU9lrgVjlnNQsPM+snoEaEsjCwkRer22fzXLQIAESNgWG7z+aRLh+NVXND//a3xjjNeWvgCVE/VozBlRclV6XqQi6PS4RS67Xh3Cda+3fTq/s08UE6FE2/7E74+tz5MWJig/iA2T4Uc0tDGL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734967744; c=relaxed/simple;
	bh=KFhsdA6eDSwSrcF5NvPBNjKneMCmoz6ZTnHC9Rc+wfE=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=HiOHibyNx7EW9wNssSMukC7PEYlDwAIp+9bWeED4n01hYLLvwyvLai6ac+B6mn7g3HTctgccp7BwInDVZBh0aLaQ7CrAP8+dJNfMMvCP59C8R30xTBKBY2c8F+tIO0pFgzRIwdT1tKAJXTkGuoctquU7RrM523lWmegKhomCeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRq43BHa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43675b1155bso21436925e9.2;
        Mon, 23 Dec 2024 07:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734967739; x=1735572539; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHwE6LtboIvzlxb8iakQpdvS1BB/EIuIuwUUFD79eek=;
        b=PRq43BHaolxXLlINsqp7625GtkGyRLWc6TOItHErcC/toAb037xdsUtguKMNyTlP84
         CIIQImnFvOYsdKPaY3u30IhvO1gqZqhj1JBDkiTsPj3HfRWYaaDIJcDF4nGSySiMTDWs
         TqCeP5wTdDPQnAOZjA6xZHrlPLObJVoan3xypbZ+7piSbd64p/yMt+7P7nai+ujZuYEN
         7r21P+E/aluuxx4d0ih+/BQwtjD6vIsPV5njY9Mr3jteTf8PB5MUkWwt1RDOgAYE2BRN
         6rzmoe/Z7a++gj2bUblqP707tN6Huss63sTiLaa1qCHl4Q5vc/EVmtkufDrbD0HEtcDt
         nYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734967739; x=1735572539;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHwE6LtboIvzlxb8iakQpdvS1BB/EIuIuwUUFD79eek=;
        b=enMUhRb3KTwTjdA3f+VClnl9mP5X0U53/9QTwUfKONeg9S3iUCYkXfpmCZ5uGxUajc
         G8GDSB09ht+atEJlDH+Jl5Ce0S75BXLHme6HA/EyQzghHhoP1FQGLUZQcDKfL2wKVBOg
         ptbYy8uaZlryURrec5ahywktA6ZxNkrHom/K16Uq8kWXGk9Z0B1XHW8CPflYKOCljHMX
         AsszS2/ePAKq8rlu6mW5O1cYCm4Zgook8po7hqKpamGJn0OA8fD/h2q0pYiYpNRvAbXt
         VP1ClbbjcOSYcn2INMho+h0M0GNA370uCu6aD3gI4ecY5UPy1pI5jQyasBHJZQM7ApSg
         w7mg==
X-Forwarded-Encrypted: i=1; AJvYcCUeloXKYVwqO6z+NmyuvvqkbIPc6cgsg9qjhCR2uHzXagr7Z/AunnNeoyTK7Xum8R4C/7Huul0jTL4=@vger.kernel.org, AJvYcCVMEE1CJruOKv9GXIS/bXoXGGYGTUIxtSONJCIcRVy88mrL95z90FYPqjtU47dhr6Xr6GHbOC++RrGl4Q==@vger.kernel.org, AJvYcCWELZPzcBDHTpbX/zv3eopD5LNJP7Yxl+b+tHI1CYyISYQNtQd2p8+mU2aMYHV3SSPhMUM7SjtDdoo=@vger.kernel.org, AJvYcCX7ugNoeNbddguvVrIUX53aIeS7fpGn8rOmQWyjKjvUW3oANw70qie5BdvbN2CPMMDs3F7qyafAeRTx2sUc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4O7uMVeHtHFJIJQGgRBmQjqi1i6u/VrBjgVKPvD3ArlAySmDm
	gDZDu6MJ9UeVF+7j+kanNFxkQyDiuMXlpY3gjcZbuW7kkxPNGa4B
X-Gm-Gg: ASbGncsrSxDR3B5EqxOKBhtMCaGrRMw3yoSNZTZTQmbTQZmAL/XA0uuclp+wnOyw+CQ
	WbJ6+TEqMIDmWtInabcxdMi5n3fWpnxUMF93Uz6q4x6SMzZqFTy46vOGUM3iG8AK2URuHuEHhBQ
	+ksJHS1i8YdAtb0Sx/Ksmalthg8Ee5tP1UzHYr6IgT+3bHvQZQCq9qBeKAvvRO7PVXZ86xdM8ok
	bRASALEpTlnYKOueZag1TRWhq8dwZ4zRgTnGwgVae3FOhHggSrUtGiR0y+Ja6wSDMTE6q2/ZYgh
	EmgfyrlXWC1iBC+T35nz9RQ7XSieISTP
X-Google-Smtp-Source: AGHT+IHdoLHgPUm6p00/HMd24H22+KstQWsA4wMptjsPunJTnpxiPD/+WgBnVgwGH9aiqN6S5K+WWw==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-43671247b46mr91357185e9.4.1734967738199;
        Mon, 23 Dec 2024 07:28:58 -0800 (PST)
Received: from localhost (host-80-180-16-130.retail.telecomitalia.it. [80.180.16.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm172106015e9.32.2024.12.23.07.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 07:28:57 -0800 (PST)
Date: Mon, 23 Dec 2024 16:28:56 +0100
Message-ID: <131f45cc31f29afd9b0e368ae7db378b@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers
	<ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil
	<paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20241215134654.676e9020@jic23-huawei>
References: <e56a8f3c81429c465e87a3abcccec1b4@gmail.com>
	<Zztlz08Wm-mGdy7p@smile.fi.intel.com>
	<65e16f628245a78da5c9d870d6c5c5a9@gmail.com>
	<Zzx_C60W48ujpis9@smile.fi.intel.com> <20241123141320.326b3340@jic23-huawei>
	<9b2f3557dc93c4b75752f812e2645262@gmail.com>
	<20241126174147.23fed403@jic23-huawei>
	<9db64d227f70f016b614a9cff5469f2d@gmail.com>
	<Z03xngKjNQYrKvgw@smile.fi.intel.com>
	<ed7b48be0216bab2a81e74cf905814d2@gmail.com>
	<Z1rt2IGAtcRNm9n7@smile.fi.intel.com> <20241215134654.676e9020@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Sun, 15 Dec 2024 13:46:54 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 12 Dec 2024 16:06:16 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Thu, Dec 12, 2024 at 10:46:04AM +0100, Matteo Martelli wrote:
> > > On Mon, 2 Dec 2024 19:42:54 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Fri, Nov 29, 2024 at 05:04:54PM +0100, Matteo Martelli wrote:  
> > > > > On Tue, 26 Nov 2024 17:41:47 +0000, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > > > On Tue, 26 Nov 2024 17:31:16 +0100
> > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:  
> > > > > > > On Sat, 23 Nov 2024 14:13:20 +0000, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > > > > > > On Tue, 19 Nov 2024 14:05:31 +0200
> > > > > > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > > > > > > On Tue, Nov 19, 2024 at 12:25:18PM +0100, Matteo Martelli wrote:    
> > > > > > > > > > On Mon, 18 Nov 2024 18:05:35 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:      
> > > > > > > > > > > On Mon, Nov 18, 2024 at 03:45:25PM +0100, Matteo Martelli wrote:      
> > > > > > > > > > > > On Mon, 18 Nov 2024 12:21:44 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:      
> > > > > > > > > > > > > On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:      
> > > > > > > > > > > > > > On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:      
> > > > > > > > > > > > > > > Quoting Jonathan Cameron (2024-10-31 15:31:29)      
> > > > > > > > > > > > > > > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > > > > > > > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:      
> > > > > > > > > > > > > > > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)      
> > > > > > > > > > > > > > > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > > > > > > > > > > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:      
> > > > > > > > > > > > > > > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)        
> > > > > > > > > > > > > > > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:          
> > > > > > > > >     
> > > > > > > > > > > > > > > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > > > > > > > > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > > > > > > > > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > > > > > > > > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > > > > > > > > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > > > > > > > > > > > > > > locked.
> > > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > > > > > > > > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > > > > > > > > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > > > > > > > > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > > > > > > > > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > > > > > > > > > > > > > > but stores the available values in the returned variable.          
> > > > > > > > > 
> > > > > > > > > ...
> > > > > > > > >     
> > > > > > > > > > > > > > > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > > > > > > > > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > > > > > > > > +     kfree(vals);
> > > > > > > > > > > > > > > > > > > > > +}
> > > > > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > > > > > > > > > > > > > > >                             int val, int val2, long mask)
> > > > > > > > > > > > > > > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > > > > > > > > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > > > > > > > > > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > > > > > > > > > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > > > > > > > > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > > > > > > > > > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > > > > > > > > > > > > > > >  };          
> > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > > > > > > > > > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > > > > > > > > > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > > > > > > > > > > > > > > at least these two comes to my mind:
> > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > > > > > > > > > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > > > > > > > > > > > > > > after all;
> > > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.          
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > > > > > > > > > > > > > > usage examples?
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > > > > > > > > > > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > > > > > > > > > > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > > > > > > > > > > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > > > > > > > > > > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > > > > > > > > > > > > > > to let the driver keep the release control through a callback for two
> > > > > > > > > > > > > > > > > > > reasons:
> > > > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > > > > > > > > > > > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > > > > > > > > > > > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > > > > > > > > > > > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > > > > > > > > > > > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > > > > > > > > > > > > > > >    not?        
> > > > > > > > > > > > > > > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > > > > > > > > > > > > > > not needed and that it prevents any optimization like you mention.        
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > > > > > > > > > > > > > > without replacing the original .read_avail(), so all the current drivers that
> > > > > > > > > > > > > > > > > use a constant avail list would not be affected.      
> > > > > > > > >     
> > > > > > > > > > > > > Yes.      
> > > > > > > > >     
> > > > > > > > > > > > > > > > > And I think this was the same
> > > > > > > > > > > > > > > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > > > > > > > > > > > > > > read_avail() we were considering in [1]. So I would think that
> > > > > > > > > > > > > > > > > iio_read_channel_info_avail() would do something like the following:
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > > > > > > > > > >         indio_dev->info->read_avail_with_copy(vals);
> > > > > > > > > > > > > > > > >     else
> > > > > > > > > > > > > > > > >         indio_dev->info->read_avail(vals);
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > >     ...
> > > > > > > > > > > > > > > > >     iio_format_avail_list(vals);
> > > > > > > > > > > > > > > > >     ...
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > > > > > > > > > > > > > >         kfree(vals);      
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Right. At least that's what I see can be done with the existing users.
> > > > > > > > > > > > >       
> > > > > > > > > > > > > > > > Ok, sure that would work, but...
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > I don't really see this as being much less fragile than
> > > > > > > > > > > > > > > > the existing solution + in cases that we do have where
> > > > > > > > > > > > > > > > only some available are not const we will have to copy them
> > > > > > > > > > > > > > > > all.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > If anything it's more complex than making it a driver problem
> > > > > > > > > > > > > > > > to provide the release call however it wants to do it.      
> > > > > > > > > > > > > 
> > > > > > > > > > > > > ...but make a driver to allocate what's needed as well then.
> > > > > > > > > > > > >       
> > > > > > > > > > > > > > > > > And the drivers would choose whether to define the read_avail or the
> > > > > > > > > > > > > > > > > read_avail_with_copy.      
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Either way drivers should know what to do with a data supplied to read_aval().
> > > > > > > > > > > > > In one case we assume the [simple] workflow in the core, in the other we all
> > > > > > > > > > > > > rely on the driver. Current approach makes a mix of these two. And that's what
> > > > > > > > > > > > > I don't like.      
> > > > > > > > > > > > 
> > > > > > > > > > > > If I understand your concern correctly, you are referring to the inkern
> > > > > > > > > > > > iio_channel_read_avail() that makes the allocation for the consumer's
> > > > > > > > > > > > buffer copy and you are suggesting that such copy should be done by the
> > > > > > > > > > > > consumer driver code itself, this to be consistent with the producer
> > > > > > > > > > > > drivers which directly handle the allocation of the copy.      
> > > > > > > > > > > 
> > > > > > > > > > > One of the options, yes.
> > > > > > > > > > >       
> > > > > > > > > > > > One thing to notice is that the inkern iio_channel_read_avail() does
> > > > > > > > > > > > together producer->read_avail() + copy + producer->read_avail_release()
> > > > > > > > > > > > with info_exists locked. Also, the consumer driver would need to know
> > > > > > > > > > > > the avail buffer size to allocate the buffer copy prior the
> > > > > > > > > > > > iio_channel_read_avail() call, but such size is unknown before calling
> > > > > > > > > > > > the actual producer's read_avail(). This would mean calling the
> > > > > > > > > > > > producer's read_avail() and read_avail_release() callbacks separately
> > > > > > > > > > > > without the lock held, with the risk of a memleak if the producer is
> > > > > > > > > > > > unregistered between those calls.      
> > > > > > > > > > > 
> > > > > > > > > > > Thanks for explaining this, but it even more makes me think that the design
> > > > > > > > > > > is broken and your approach is rather a hack. So, what's the problem to
> > > > > > > > > > > make IIO core to take care of the allocating and cleaning then without driver
> > > > > > > > > > > being involved? Yes, this might require a hint from the driver on what to copy
> > > > > > > > > > > if we want to avoid copying everything.      
> > > > > > > > > > 
> > > > > > > > > > I am not particularly against it, other than the concerns that have
> > > > > > > > > > emerged during this (and previous) discussion. Let me summarize them:      
> > > > > > > > > 
> > > > > > > > > Thank you for a very good summary and fix-N proposals. I think I have nothing
> > > > > > > > > to add and we should wait for Jonathan to finally choose (or propose a fix-N+1)
> > > > > > > > > here.    
> > > > > > > > Agreed. This is very useful enumeration of various options with plenty
> > > > > > > > of details!
> > > > > > > > 
> > > > > > > > One absolute key thing to note here is we should not care at all what
> > > > > > > > inkern does for it's handling internally of the available lists.  The big
> > > > > > > > ABI question is all about consumers drivers directly using the resulting list of
> > > > > > > > available values.  The use in the IIO core and the inkern helpers should
> > > > > > > > naturally follow.
> > > > > > > >   
> > > > > > > > > > fix-1) the current one. Your concerns are:
> > > > > > > > > >     * for consumers the copy allocation is taken care by the inkern API
> > > > > > > > > >       but the release is handled by the consumer driver code, making it
> > > > > > > > > >       a fragile design.    
> > > > > > > > 
> > > > > > > > So this was something I'm not sure I agree with.  There are plenty
> > > > > > > > of get / release patterns out there. This is just another one of those
> > > > > > > > but perhaps it doesn't 'smell' enough like that.
> > > > > > > > 
> > > > > > > > Perhaps think of it as
> > > > > > > > 
> > > > > > > > int *iio_channel_avail_get()
> > > > > > > > void iio_channel_avail_release()
> > > > > > > > 
> > > > > > > > We could perhaps make it look more standard using a cookie rather than
> > > > > > > > reconstructing the equivalent data at the release call.    
> > > > > > > 
> > > > > > > Would this imply that also the read_info callback provided by the
> > > > > > > iio_info struct should be replaced? Something like info->get_avail()
> > > > > > > returning a iio_avail_cookie instead of info->read_avail(const int **vals)?
> > > > > > > * If yes, that would be a big impact in the current code as all
> > > > > > > iio drivers defining read_avail would need to be changed (I am not
> > > > > > > against it but better consider it).
> > > > > > > * If no, then I find odd that iio_info->avail_release(cookie) gets a
> > > > > > > cookie that has been allocated outside the provider driver: the read
> > > > > > > functions gives something to the user and its corresponing release
> > > > > > > handle another type of object (even it's just a wrapper). Is this the
> > > > > > > usual pattern for cookies?  
> > > > > > 
> > > > > > I think the trick here is that the provider drivers wouldn't be involved
> > > > > > in the cookie handling. We might have done it differently if we
> > > > > > were starting from scratch, but the legacy is a pain as normal!
> > > > > > Consumers can stay the same as you have here as all the information in
> > > > > > the cookie would be gathered from existing read_avail plus the parameters.
> > > > > > Tricky bit is the provider_priv, but we may not even need that.  If that
> > > > > > becomes a useful thing we'd need a new optional get_avail_with_priv()
> > > > > > or something like that.  Might need to stash the channel info in the
> > > > > > cookie as well.
> > > > > > 
> > > > > > Provider wouldn't see the cookie at release either as we'd just
> > > > > > pass parameters from the cookie into the release callback then free
> > > > > > the cookie in the core code.  Technically ownership of the cookie
> > > > > > would lie with the consumer not the provider but we'd hide all that
> > > > > > away from the consumer.  
> > > > > 
> > > > > I see now that your suggestion to use the cookie would only affect
> > > > > consumers. What confused me is your example below where the producer's
> > > > > release would use the cookie as well:
> > > > > 
> > > > >             iio_dev->info->avail_release(cookie);
> > > > > 
> > > > > Anyway, if iio_info->read_avail and
> > > > > iio_info->read_avail_release_resource are not going to be changed, how
> > > > > could we address the case where the consumers simply forwards their
> > > > > providers avail data back to the core for sysfs print, like as follows?
> > > > > 
> > > > > static int dpot_dac_read_avail(struct iio_dev *indio_dev,
> > > > > 			       struct iio_chan_spec const *chan,
> > > > > 			       const int **vals, int *type, int *length,
> > > > > 			       long mask)
> > > > > {
> > > > > 	struct dpot_dac *dac = iio_priv(indio_dev);
> > > > > 
> > > > > 	switch (mask) {
> > > > > 	case IIO_CHAN_INFO_RAW:
> > > > > 		*type = IIO_VAL_INT;
> > > > > 		return iio_read_avail_channel_raw(dac->dpot, vals, length);
> > > > > 
> > > > > 		/* NOTE: Here we could call the cookie = iio_channel_avail_get() and
> > > > > 		  fill the return arguments with the content of the
> > > > > 		  cookie, but wouldn't the cookie be lost? How to return
> > > > > 		  it to caller? */
> > > > > 	}
> > > > > 
> > > > > 	return -EINVAL;
> > > > > }
> > > > > 
> > > > > static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > 					    struct iio_chan_spec const *chan,
> > > > > 					    const int *vals, long mask)
> > > > > {
> > > > > 	kfree(vals);
> > > > > 	/* NOTE: Here the consumer should access the cookie to call
> > > > > 	 * iio_channel_avail_release(cookie), but how can it? */
> > > > > }
> > > > > ...
> > > > > static const struct iio_info dpot_dac_info = {
> > > > > 	.read_avail = dpot_dac_read_avail,
> > > > > 	.read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > };
> > > > > 
> > > > >   
> > > > > > 
> > > > > > Whether we would use the cookie magic in the inkern code other
> > > > > > than the getter itself would depend a bit on what it looks like
> > > > > > 
> > > > > > We might need to do a global rename of read_avail to get_avail
> > > > > > though to make the relationship to release_avail obvious.
> > > > > > 
> > > > > >   
> > > > > > >   
> > > > > > > > 
> > > > > > > > struct iio_avail_cookie {
> > > > > > > > 	const int *avail;
> > > > > > > > 	void *provider_priv;
> > > > > > > > // see later for a maybe...
> > > > > > > > 	struct iio_dev *indio_dev;
> > > > > > > > };
> > > > > > > > 
> > > > > > > > const int *iio_avail_from_cookie(struct iio_avail_cookie *cookie)
> > > > > > > > {
> > > > > > > > 	return cookie->avail;
> > > > > > > > }
> > > > > > > >    
> > > > > > > 
> > > > > > > I suppose that struct iio_avail_cookie and their access functions like
> > > > > > > iio_avail_from_cookie would be define in iio.h as they are required for
> > > > > > > producer drivers too. Correct?  
> > > > > > 
> > > > > > Initially at least I'd try just making them visible to the consumer.
> > > > > >   
> > > > > > >   
> > > > > > > > 
> > > > > > > > struct iio_avail_cookie *iio_channel_avail_get(struct iio_dev, struct iio_chan_spec)
> > > > > > > > {
> > > > > > > > 	allocate a cookie and fill it in.
> > > > > > > > }
> > > > > > > > 
> > > > > > > > and code would always explicitly release after it is done with the cookie.
> > > > > > > > 
> > > > > > > > Something like
> > > > > > > > 
> > > > > > > > void iio_channel_avail_release(struct iio_dev *iio_dev, struct iio_avail_cookie *cookie)
> > > > > > > > // could even move the iio_dev pointer into the cookie, so it becomes
> > > > > > > > // iio_channel_avail_release(struct iio_avail_cookie *cookie) and suitable for __free magic.
> > > > > > > > {
> > > > > > > > 	if (iio_dev->info->avail_release)
> > > > > > > > 		iio_dev->info->avail_release(cookie);
> > > > > > > > 	kfree(cookie);
> > > > > > > > 	/*
> > > > > > > > 	 * Could add optimizations around cookie handling to avoid alloc + free in most cases
> > > > > > > > 	 * or use an object pool.
> > > > > > > > 	 */
> > > > > > > > }    
> > > > > > > 
> > > > > > > Do these two functions refer to inkern consumer APIs? Would
> > > > > > > iio_channel_avail_get() replace the current inkern
> > > > > > > iio_read_avail_channel_attribute()?   
> > > > > > 
> > > > > > Yes.
> > > > > >   
> > > > > > >In that case I think
> > > > > > > iio_channel_avail_get() would copy the cookie (and its inner avail
> > > > > > > buffer) from the provider driver, or allocate a new cookie with the
> > > > > > > copied avail buffer if info->read_avail() is kept unchanged, and
> > > > > > > immediately call the provider info->avail_release(cookie) to do
> > > > > > > copy+release with info_exist_lock locked.  
> > > > > > 
> > > > > > I don't think the provider ever explicitly deals with the cookie,
> > > > > > just data read from it in the inkern code.
> > > > > >   
> > > > > > > At that point
> > > > > > > iio_channel_avail_release() would only need to call
> > > > > > > kfree(iio_avail_from_cookie(cookie)) and kfree(cookie).  
> > > > > > 
> > > > > > 
> > > > > > Ah. I'm forgetting the issue with the provider device instance
> > > > > > going away. In that case it may well have to copy the avail data
> > > > > > to fill the cookie returned to the consumer driver much like we
> > > > > > copy it now.+ free it.  We could do something smarter with that
> > > > > > cookie though to avoid a free if it's static const stuff as the
> > > > > > provider module should be locked in place I think.
> > > > > >   
> > > > > > >   
> > > > > > > > 
> > > > > > > > The current proposal just avoid the need for a cookie as for all known cases so far
> > > > > > > > provider_priv could == the channel requested.
> > > > > > > > 
> > > > > > > >     
> > > > > > > > > >     * consumers and producers manage the allocation differently, the
> > > > > > > > > >       first handles it via the inkern API, the second one in the
> > > > > > > > > >       producer driver code, making it inconsistent.    
> > > > > > > > 
> > > > > > > > The inkern API changes are mostly an attempt to reduce boiler plate. The only
> > > > > > > > case we really should be worrying about to my mind is the consumer wanting
> > > > > > > > to access the full available list. 
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > > fix-2) adding a read_avail_with_copy(): a driver with both const avail
> > > > > > > > > > lists and mutable avail lists would always return a copy for all of
> > > > > > > > > > them, including the const ones. Example above.    
> > > > > > > > 
> > > > > > > > Hmm. So this could work but with the firm rule that a provider must never
> > > > > > > > provide both options and a core check on drivers to enforce that probe.
> > > > > > > > Any existing consumers must be modified to try both paths
> > > > > > > > (read_avail_with_copy then read_avail) to avoid regressions.
> > > > > > > > 
> > > > > > > > For future code, if we miss a case that doesn't do this then the upshot
> > > > > > > > is that the call will fail and the consumer needs fixing but at least
> > > > > > > > it is not a regression because it will never have worked for that
> > > > > > > > particular consumer + producer pair.  Not too horrible, but I'm not
> > > > > > > > really seeing it as better than option 1.
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > > fix-3) adding a release_avail return param to read_avail(): this would
> > > > > > > > > > require a change to all the drivers using it. Also it
> > > > > > > > > > looks to me an unusual pattern, are there other similar patterns around
> > > > > > > > > > the codebase? Example below.    
> > > > > > > > 
> > > > > > > > No advantage that I can see vs an explicit get / release where the
> > > > > > > > release may do nothing if there was no allocation.
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > > fix-4) adding a new enum variant to the avail type like
> > > > > > > > > > IIO_AVAIL_LIST_ALLOC: to me this looks hacky as it mixes the logic type
> > > > > > > > > > of the data structure and how it is handled in memory. I think the
> > > > > > > > > > latter should better fit in a different field, however this modification
> > > > > > > > > > would have little impact in the current code. Example below.    
> > > > > > > > 
> > > > > > > > This one I really don't like. Needs non obvious / subtle handling in the
> > > > > > > > consumer drivers.
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > > So far these alternatives only consider moving the release of the copy
> > > > > > > > > > buffer in the IIO core but not its allocation.    
> > > > > > > > 
> > > > > > > > I'm confused.  Moving it in, or out of the core?  What does this mean
> > > > > > > > for a consumer driver after the avail list?
> > > > > > > >     
> > > > > > > > > You also suggest to make    
> > > > > > > > > > the IIO core take care of the copy allocation. The problem I see with
> > > > > > > > > > this is that if the copy is handled outside the driver it could take
> > > > > > > > > > place concurrently with the modification of the original buffer since it
> > > > > > > > > > would not be locked by driver private mutex, thus making the copy
> > > > > > > > > > useless. This might be worked around by adding an additional optional
> > > > > > > > > > callback (e.g. read_avail_will_copy/read_avail_is_mutable) to just take
> > > > > > > > > > the size and check if a copy will be provided, so maybe something like:
> > > > > > > > > > 
> > > > > > > > > > fix-5) iio_read_channel_info_avail():    
> > > > > > > > 
> > > > > > > > This is picking on the wrong code for this discussion.  Use
> > > > > > > > iio_read_avail_channel_attribute() for example because that's the one
> > > > > > > > where ABI matters.  Anything within the IIO core is just a question of
> > > > > > > > 'niceness' it isn't important like a function called by a consumer driver.
> > > > > > > > 
> > > > > > > > Code of a consumer driver will be similar to this however.  A few things
> > > > > > > > would be needed to make this pattern work.
> > > > > > > >      
> > > > > > > > > > {
> > > > > > > > > >     ...
> > > > > > > > > >     int *vals;
> > > > > > > > > >     bool copy = false;
> > > > > > > > > >     if (indio_dev->info->read_avail_will_copy) {
> > > > > > > > > >         copy = indio_dev->info->read_avail_will_copy(..., &length, ...);    
> > > > > > > > 
> > > > > > > > return length as 0 can reasonably mean we don't need to allocate.
> > > > > > > > That value must be the maximum possible size that can ever be needed, not the
> > > > > > > > current one.
> > > > > > > >     
> > > > > > > > > >         if (copy) {
> > > > > > > > > >             vals = kcalloc(length, sizeof(int), GFP_KERNEL);
> > > > > > > > > >         }
> > > > > > > > > >     }
> > > > > > > > > > 
> > > > > > > > > >     indio_dev->info->read_avail(&vals, ...);    
> > > > > > > > 
> > > > > > > > For iio_read_avail_channel_attribute it will a little fiddlier but end result
> > > > > > > > is the same but done under the exist lock. If the device went away before this
> > > > > > > > call then we will get an error, otherwise this will fill vals and provide
> > > > > > > > the right length. 
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > >     if (ret < 0)
> > > > > > > > > >             return ret;
> > > > > > > > > >     switch (ret) {
> > > > > > > > > >     case IIO_AVAIL_LIST:
> > > > > > > > > >             ret = iio_format_avail_list(buf, vals, type, length);
> > > > > > > > > >     case IIO_AVAIL_RANGE:
> > > > > > > > > >             ret = iio_format_avail_range(buf, vals, type);
> > > > > > > > > >     default:
> > > > > > > > > >             ret = -EINVAL;
> > > > > > > > > >     }
> > > > > > > > > > 
> > > > > > > > > >     if (copy)
> > > > > > > > > >         kfree(vals);
> > > > > > > > > > }
> > > > > > > > > > 
> > > > > > > > > > If I am not missing anything this could work and maybe it could also
> > > > > > > > > > avoid the double copy on the consumers but would require all of them to
> > > > > > > > > > wrap the read_avail_will_copy(). Also, I find it quite a weird pattern
> > > > > > > > > > that in some cases vals would be an input buffer to be filled and in
> > > > > > > > > > other cases it would be a return argument pointing to the const buffer
> > > > > > > > > > stored inside the driver. At least I wouldn't say it's more robust than
> > > > > > > > > > the current fix-1.    
> > > > > > > > Agreed. It works, but I'm not seeing the advantage and the multiple use
> > > > > > > > of the vals parameter is too subtle to be maintainable.
> > > > > > > >     
> > > > > > > > > > 
> > > > > > > > > > All these alternatives also prevents some potential optimization already
> > > > > > > > > > mentioned before. Reporting it again as it is now lost in the mess below:
> > > > > > > > > >     Some driver might want to avoid allocating a new copy of a big table if
> > > > > > > > > >     the race does not occur (e.g. with additional checks on buffer access
> > > > > > > > > >     code) and thus wouldn't call a free() in the release callback.
> > > > > > > > > > 
> > > > > > > > > > In the end I don't find any of the above alternatives to provide an
> > > > > > > > > > obvious better solution.    
> > > > > > > > 
> > > > > > > > Agreed.  My only question vs just taking the existing solution is whether
> > > > > > > > it makes sense to use a more explicit struct iio_avail_cookie
> > > > > > > > to hold all the info that we pass to release.  I don't particularly like
> > > > > > > > that we'll end up allocating that cookie structure but it would make it more
> > > > > > > > like a typical get / release and perhaps closer to what readers would
> > > > > > > > expect to see?
> > > > > > > > 
> > > > > > > > What do you think?    
> > > > > > > 
> > > > > > > I cannot answer about what readers would expect since I am quite new to
> > > > > > > kernel internals and I was not aware about the cookie pattern myself.
> > > > > > > However, I agree that it seems more clear than the current solution but
> > > > > > > only if it's going to replace the iio_info read_avail() callback,
> > > > > > > otherwise I think that only using the cookie on the release callback
> > > > > > > would make it even more confusing. It is worth noting that in that case
> > > > > > > all current provider drivers defining the read_avail callback should be
> > > > > > > changed.  
> > > > > > Key I think is we really don't need to be careful with what happens in inkern.c
> > > > > > (though obviously good to use infrastructure we invent for other things),
> > > > > > only what is presented by consumer.h interfaces to consumer drivers.
> > > > > > Those get and release the cookie.
> > > > > > 
> > > > > > That's a much smaller set of drivers to modify.
> > > > > > 
> > > > > > Or as Andy suggested, maybe it's just a question of naming and we need
> > > > > > a get and release but otherwise don't bother with the complexity of the cookie.
> > > > > > Maybe just rename read_avail to make it obvious.
> > > > > > 
> > > > > > Right now I'm thinking the cookie wrappers around get_avail / release_avail
> > > > > > to wrap up basically the parameters passed to get_avail + the output so
> > > > > > that we have a neat package to pass to release_avail will end up the neatest
> > > > > > solution but I may be wrong :(  
> > > > > 
> > > > > If there is a way to address my issue above I can see some benefits in
> > > > > terms of clarity. In general I think it's more clear to return a struct
> > > > > instead of using return arguments, it would also simplify the __free()
> > > > > cleanup as we wouldn't need the additional *_retvals wrapper for that
> > > > > purpose. Also, I think using an inkern helper for the release adds more
> > > > > clarity to the consumer drivers even if it's just a wrapper to kfree(),
> > > > > but that could be achieved without the cookie too.  
> > > > 
> > > > IIUC we need also new read_avail_alloc() which returns cookie structure,
> > > > in this case the read_aval_release() will take it as a parameter. It means
> > > > it will be the driver's responsibility to carry on the cookie.  
> 
> That's a no because of the cost in driver rework as any driver
> could have it's read_avail_alloc() call called if they provide
> a read_avail() today.  We could provide a default function but that's
> effectively the same as just doing the handling the IIO core and leaving
> the provider drivers alone.  I don't mind this approach if it makes it
> look more standard but I'm not seeing the advantage so far.
> 
> > > 
> > > I think this would be in contrast of Jonathan's suggestion to keep the
> > > cookie pattern out of the provider drivers scope.  
> > 
> > In my understanding of cookies is that it's an opaque pointer / object,
> > so it is fine to pass it through the caller / user. We do cookies, e.g.,
> > in DMA engine subsystem and it's fine, the actual cookie's data is kept
> > out of the scope of the provider drivers.
> > 
> > Did I miss anything?
> 
> If we were starting from scratch, then pushing it all the way through would
> maybe be fine (with a bunch of helpers to avoid the pain for the really simple
> (and way more frequent) cases.
> 
> The problem here is a big miss balance.  Lots of drivers c. 100 from a
> quick grep, provide the relevant available callbacks because they are
> mostly just used by the IIO core to provide data for sysfs functions. We could
> fix all those drivers up but in general I don't want to complicate
> that path (which doesn't have these lifetimes or ownership issues) or
> the vast majority of drivers that don't have this lifetime issue because
> the data they are providing is const.
> 
> So to keep this simple, I think we can have cookies that only the consumer
> side (which is way smaller, just a few drivers) + the IIO core have to
> deal with.
> 
> That also means they aren't exposed for the inkern calls that just grab
> one number from an array (we have min and max) and hence can manage
> the lifetime themselves.
> 
> We only need them in the tiny fraction of cases where the array of
> data itself is passed to the consumer.  Therefore, if we create
> the cookies in the interface layer it all looks like the ideal situation
> for those consumers (nice opaque object + a few accessor calls) and
> keeps the complexity out of the provider drivers.  If later we need
> to provide alternative paths into the providers for when they do need
> to more directly manage the cookie (i.e. squirt more data in it for
> some reason) that is fine, because it only affects the providers
> that need it - not all of them.
> 
> So in conclusion, I'm thinking we either:
> 1) Push the cookie allocator to a default function that is used in all provider
>    drivers but in theory can be overridden - maybe it is worth overriding
>    for those cases that were modified in this set. I'm not sure we gain
>    anything but I haven't looked closely.
> 
> 2) For now just do the cookie allocator in the core with the option later
>    to push it to provider drivers where they want to do something different
>    from the provider.
> 
> Perhaps have a play with doing option 1 and see how bad it is? I think
> it only makes sense if we end up with no special casing in the core
> and that means every iio_info structure with a read_avail needs the
> new callback set as well + runtime checks that we have done that.
> (whereas option 2 is basically just have the 'special' case code in the
>  core).

I had a play with your last suggested solution, and if I understood it
correctly it would look something like the code below. I am not really
convinced this would improve clarity, see for example the dpot-dac
consumer driver which forwards its provider's avail data back to the
core for sysfs exposure. The read_avail callback does not operate on the
cookie and therefore it cannot be passed to the inkern helpers either,
while the release callback is aware of the cookie. I also can't see how
the cookie allocator callback can help here as the provider's avail data
must be read+copied+released in one place with the lock_exists mutex
locked. The only thing that comes to my mind is to call the inkern
iio_read_avail_channel_raw() in the allocator callback, and let it
return the allocated cookie directly. At this point the read_avail would
be a dummy return 0 as the provider data would have already been read
during the allocator callback. Sounds like an hack though. I think the
cookie struct would be useful only if iio_info->read_avail would be
changed so that it can handle it directly, otherwise I think it only
makes things more messy. Please correct me if I missed any detail.

/* dpot-dac.c consumer driver */
/* ... */
static int dpot_dac_read_avail(struct iio_dev *indio_dev,
			       struct iio_chan_spec const *chan,
			       const int **vals, int *type, int *length,
			       long mask)
{
	struct dpot_dac *dac = iio_priv(indio_dev);

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		*type = IIO_VAL_INT;
		return iio_read_avail_channel_raw(dac->dpot, vals, length);
	}

	return -EINVAL;
}

static void dpot_dac_read_avail_release(struct iio_avail_cookie *avail)
{
	kfree(iio_avail_vals(avail));
	kfree(avail);
}


/* industrialio-core.c */
/* ... */
/* IIO avail cookie interface */
struct iio_avail_cookie { //NOTE: cookie suffix needed?
	const int *vals;
	int val_type; //NOTE: renamed from type to avoid confusion with former return type (SCALE|RANGE)
	int length;
	int type; //NOTE: former provider's return.
	struct iio_chan_spec const *channel;
	long mask;
	struct iio_dev *indio_dev;
};

inline const int *iio_avail_vals(struct iio_avail_cookie *avail)
{
	return avail->vals;
}
/*... other accessor helpers ... */

/* NOTE: Default cookie allocator: will be assigned to iio_info->read_avail_alloc */
static struct iio_avail_cookie *
__iio_read_avail_alloc(struct iio_dev *indio_dev,
		       struct iio_chan_spec const *chan, long mask)

{
	if (!indio_dev->info || !indio_dev->info->read_avail ||
	    !indio_dev->info->read_avail_release)
		return ERR_PTR(-EINVAL);

	struct iio_avail_cookie *cookie =
		kzalloc(sizeof(struct iio_avail_cookie), GFP_KERNEL);

	if (!cookie)
		return ERR_PTR(-ENOMEM);

	cookie->indio_dev = indio_dev;
	cookie->channel = chan;
	cookie->mask = mask;

	return cookie;
}

/* NOTE: Default cookie destructor, will be assigned to iio_info->read_avail_release */
static inline void __iio_read_avail_release(struct iio_avail_cookie *cookie)
{
	kfree(cookie);
}

/* Cookie destructor helper to allow __free() pattern */
void iio_avail_cookie_release(struct iio_avail_cookie *cookie)
{
	if (IS_ERR_OR_NULL(cookie))
		return;

	if (WARN_ON_ONCE(!cookie->indio_dev || !cookie->indio_dev->info ||
			 !cookie->indio_dev->info->read_avail_release))
		return __iio_read_avail_release(cookie);

	cookie->indio_dev->info->read_avail_release(cookie);
}
EXPORT_SYMBOL_GPL(iio_avail_cookie_release);

/* NOTE: read avail wrapper helper, not necessary but just for convenience */
int iio_avail_cookie_read(struct iio_avail_cookie *cookie)
{
	if (IS_ERR_OR_NULL(cookie))
		return -EINVAL;

	if (WARN_ON_ONCE(!cookie->indio_dev || !cookie->indio_dev->info ||
			 !cookie->indio_dev->info->read_avail))
		return -EINVAL;

	return cookie->indio_dev->info->read_avail(
		cookie->indio_dev, cookie->channel, &cookie->vals,
		&cookie->val_type, &cookie->length, cookie->mask);
}
EXPORT_SYMBOL_GPL(iio_avail_cookie_read);

/* ... */

/* NOTE: Register default cookie allocator and destructor during registration.
	 Is this the best way/place to set defaults? */
static int iio_device_register_sysfs(struct iio_dev *indio_dev)
{
	/* ... */
	/* Set default alloc/release for info avail data */
	if (indio_dev->info->read_avail) {
		struct iio_info *info = (struct iio_info *)indio_dev->info;

		if (!info->read_avail_alloc)
			info->read_avail_alloc = __iio_read_avail_alloc;
		
		if (!info->read_avail_release)
			info->read_avail_release = __iio_read_avail_release;
	}

/* ... */

static ssize_t iio_read_channel_info_avail(struct device *dev,
					   struct device_attribute *attr,
					   char *buf)
{
	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
	int ret;

	if (!indio_dev->info->read_avail ||
	    !indio_dev->info->read_avail_alloc ||
	    !indio_dev->info->read_avail_release)
		return -EINVAL;

	struct iio_avail_cookie *avail __free(iio_avail_cookie) =
		indio_dev->info->read_avail_alloc(indio_dev, this_attr->c,
						  this_attr->address);
	if (IS_ERR(avail))
		return PTR_ERR(avail);

	ret = iio_avail_cookie_read(avail);
	if (ret < 0)
		return ret;

	avail->type = ret;

	switch (avail->type) {
	case IIO_AVAIL_LIST:
		return iio_format_avail_list(buf, avail->vals, avail->val_type,
					     avail->length);
	case IIO_AVAIL_RANGE:
		return iio_format_avail_range(buf, avail->vals,
					      avail->val_type);
	default:
		return -EINVAL;
	}
}


/* iio.h */
//TODO: docs for iio_avail_cookie interface
struct iio_avail_cookie;
void iio_read_avail_release(struct iio_avail_cookie *avail);
const int *iio_avail_vals(struct iio_avail_cookie *avail);
int iio_avail_val_type(struct iio_avail_cookie *avail);
int iio_avail_length(struct iio_avail_cookie *avail);
int iio_avail_type(struct iio_avail_cookie *avail);
struct iio_chan_spec const *iio_avail_channel(struct iio_avail_cookie *avail);
int iio_avail_mask(struct iio_avail_cookie *avail);
int iio_avail_cookie_read(struct iio_avail_cookie *avail);
void iio_avail_cookie_release(struct iio_avail_cookie *avail);
DEFINE_FREE(iio_avail_cookie, struct iio_avail_cookie *, iio_avail_cookie_release(_T))


/* inkern.c */
static int iio_channel_read_avail(struct iio_channel *chan,
				  const int **vals, int *type, int *length,
				  enum iio_chan_info_enum info)
{
	const struct iio_info *iio_info = chan->indio_dev->info;
	int ret;

	if (!iio_channel_has_available(chan->channel, info))
		return -EINVAL;

	if (!iio_info->read_avail || !iio_info->read_avail_alloc ||
	    !iio_info->read_avail_release)
		return -EINVAL;

	struct iio_avail_cookie *avail __free(iio_avail_cookie) =
		iio_info->read_avail_alloc(chan->indio_dev, chan->channel,
					   info);
	if (IS_ERR(avail))
		return PTR_ERR(avail);

	ret = iio_avail_cookie_read(avail);
	if (ret < 0)
		return ret;

	/*
	 * Copy the producer's avail buffer with lock_exists locked to
	 * avoid possible race with producer unregistration.
	 */
	*vals = kmemdup_array(iio_avail_vals(avail), iio_avail_length(avail),
			      sizeof(int), GFP_KERNEL);
	if (!*vals)
		return -ENOMEM;

	return ret;
}
/* ... */

> 
> Jonathan
> 

Best regards,
Matteo Martelli

