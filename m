Return-Path: <linux-iio+bounces-9957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF398B71D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E46E1F22C29
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58519D069;
	Tue,  1 Oct 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nHccNDbE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8746E199953
	for <linux-iio@vger.kernel.org>; Tue,  1 Oct 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771800; cv=none; b=U9UY8qQmUQ4vDiNuVGkP9j0Bh+LMTgztRHyykEr61egFULb2Ur3uMmCe6XjZyKzeNLslh9ygty89MXsTjAZvauXJdH6HmkhNOroerPlC9VFKYODYBAKjCPxAAoQ+TQE1UukO4ftYe2G/zgvxvYEc6EfS9Ar7C8Hoo+UWacAKSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771800; c=relaxed/simple;
	bh=s8yQgqbpqiJJW4fsDu52UKvVj4I70qefK+BiUTDSCKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0sEyYuhyCuws79Vq6ekTdadU1JmJncveM9ndH/UWndcvTZ+tcQ8dfoguOwfPLRwYnxmuqijJfs9I/+SxAJE2Oc8fDaSmhNoFRltBxLkuQJCSaMb+ZIQM9sxpXbxZLZ0i3lfVOMnq82RMa5muhjnOVoW9bPYVXateJ6NXSha+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nHccNDbE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so48327725e9.3
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2024 01:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727771796; x=1728376596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mOBK0pAqTeYNcJo77rPRofGMGVSl1KOZYzYP+PBorDk=;
        b=nHccNDbEsLXRFKUulgDbt9+o3Pn3Jwle3GpoGMIVKzUySj/GBT7ehkLxu0B/+h6aUJ
         Ad18TxkYS1z5sa/+BXgHlfQt9w96kHOdIws57ouCUCUKQ69Ovw1/AbVZ/f0a717vuhU4
         9gh69u4lkLHibp24eYkYVlnyANOxLK0i8Y1X3gXjKmBLHhDxniQxMbJaI3i+aUkkJZp5
         5OhENxRGyDSApTHvQabiPMhmibIk+bVOAwvf6x/zbpcwIWIrhH4MQKuIHeOH/265UoSR
         ujjB2dhoS6Kqn8Q8T3IZBqOI/vlL9SrQyk+I+nr6hO7Xc7nGXmY3z2bEB2nkXwFSUxQy
         UmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771796; x=1728376596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOBK0pAqTeYNcJo77rPRofGMGVSl1KOZYzYP+PBorDk=;
        b=T6R7hIa8Fqs2K55/I6jFft2G3fP2/Pj0v2FgGzYOsZJWts6iI9R1IcuySsywr6elvl
         zkW4RA7b/mPRLY4+xl0lP039E/mY0+kxKiPmTKdKdMe51iVH0l9sIWHLordm2s3MY7g6
         rg6Kmao3Og7ZVf3AA7vOQ4cOdZSuvmL0XirdCTQQMDjSbCneGGLvxVqsdgliIsx8pSph
         EFfh2kttoQnaN+XddLjvSkox+JMaul3jhv+SFcdxRY7Ei5/p7kMkCqdEX5uGP7hUDFS5
         RzhLSgJvOQ+SUbpQ2DS64iM/IXSw6ZazdP466eWhOVGGZs5/q/oO+MkQ3T9+20Z3BKHL
         q3hg==
X-Forwarded-Encrypted: i=1; AJvYcCV8ts5ygsUjy0bhuDO6dULOs8EoW+SWD3qHFCa1RO2DYFpTyNIM8jzROhBtw34p2r6EgZoy7m+t0wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuERd27pGqC1pK5x8GaOMGeDn0aWoKj7gK/tjgF7Rh1Qd2dfD
	KfSwKyRzxt8wQvIcFMn+PY9HrHQy12isvWjdD/yitPvmO+NXVb+x47JoRDvvhxk=
X-Google-Smtp-Source: AGHT+IHwHSvzYXZP63dc1ggv+efXfJTVJ2qzT4c3+KBMcqG+xS/4e8BrkRc5655ZOfJrvxkOKEJcIw==
X-Received: by 2002:a05:600c:46cb:b0:42c:bb41:a077 with SMTP id 5b1f17b1804b1-42f58497f0fmr93793585e9.23.1727771795795;
        Tue, 01 Oct 2024 01:36:35 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f244asm173501805e9.17.2024.10.01.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:36:35 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:35:17 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 05/10] iio: backend: extend features
Message-ID: <urf6tm7iosewgb42cd6q3ssx2hjaysuzhk2weu4xmoq5xsm7ir@hvwb7qgxko2h>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-5-a17b9b3d05d9@baylibre.com>
 <20240929120535.6b41c37e@jic23-huawei>
 <c9e30ebf-c661-4345-87bd-3169b57175fc@baylibre.com>
 <3370ba6d9a6bb8da5ca1415c354a6076de6f1d79.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3370ba6d9a6bb8da5ca1415c354a6076de6f1d79.camel@gmail.com>

On 01.10.2024 10:14, Nuno Sá wrote:
> On Mon, 2024-09-30 at 14:25 -0500, David Lechner wrote:
> > On 9/29/24 6:05 AM, Jonathan Cameron wrote:
> > > On Thu, 19 Sep 2024 11:20:01 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > 
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > 
> > > > Extend backend features with new calls needed later on this
> > > > patchset from axi version of ad3552r.
> > > > 
> > > > The follwoing calls are added:
> > > > 
> > > > iio_backend_ext_sync_enable
> > > > 	enable synchronize channels on external trigger
> > > > iio_backend_ext_sync_disable
> > > > 	disable synchronize channels on external trigger
> > > > iio_backend_ddr_enable
> > > > 	enable ddr bus transfer
> > > > iio_backend_ddr_disable
> > > > 	disable ddr bus transfer
> > > > iio_backend_set_bus_mode
> > > > 	select the type of bus, so that specific read / write
> > > > 	operations are performed accordingly
> > > > iio_backend_buffer_enable
> > > > 	enable buffer
> > > > iio_backend_buffer_disable
> > > > 	disable buffer
> > > > iio_backend_data_transfer_addr
> > > > 	define the target register address where the DAC sample
> > > > 	will be written.
> > > > 
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > Hi Angelo,
> > > A few trivial comments inline.
> > > 
> > > > ---
> > > >  drivers/iio/industrialio-backend.c | 111
> > > > +++++++++++++++++++++++++++++++++++++
> > > >  include/linux/iio/backend.h        |  23 ++++++++
> > > >  2 files changed, 134 insertions(+)
> > > > 
> > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > b/drivers/iio/industrialio-backend.c
> > > > index 20b3b5212da7..f4802c422dbf 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -718,6 +718,117 @@ static int __devm_iio_backend_get(struct device
> > > > *dev, struct iio_backend *back)
> > > ...
> > > 
> > > > +/**
> > > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate)
> > > > mode
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disabling DDR data is generated byt the IP at rising or falling front
> > > 
> > > Spell check your comments.
> > > 
> > > > + * of the interface clock signal (SDR, Single Data Rate).
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ddr_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > > 				 struct fwnode_handle *fwnode)
> > > >  {
> > > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > > > index 37d56914d485..41619b803cd6 100644
> > > > --- a/include/linux/iio/backend.h
> > > > +++ b/include/linux/iio/backend.h
> > > > @@ -14,12 +14,14 @@ struct iio_dev;
> > > >  enum iio_backend_data_type {
> > > >  	IIO_BACKEND_TWOS_COMPLEMENT,
> > > >  	IIO_BACKEND_OFFSET_BINARY,
> > > > +	IIO_BACKEND_DATA_UNSIGNED,
> > > >  	IIO_BACKEND_DATA_TYPE_MAX
> > > >  };
> > > >  
> > > >  enum iio_backend_data_source {
> > > >  	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
> > > >  	IIO_BACKEND_EXTERNAL,
> > > > +	IIO_BACKEND_INTERNAL_RAMP_16BIT,
> > > >  	IIO_BACKEND_DATA_SOURCE_MAX
> > > >  };
> > > >  
> > > > @@ -89,6 +91,13 @@ enum iio_backend_sample_trigger {
> > > >   * @read_raw: Read a channel attribute from a backend device
> > > >   * @debugfs_print_chan_status: Print channel status into a buffer.
> > > >   * @debugfs_reg_access: Read or write register value of backend.
> > > > + * @ext_sync_enable: Enable external synchronization.
> > > > + * @ext_sync_disable: Disable external synchronization.
> > > > + * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> > > > + * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> > > > + * @buffer_enable: Enable data buffer.
> > > > + * @buffer_disable: Disable data buffer.
> > > 
> > > This needs more specific text. What buffer?  I think this came
> > > up earlier but it needs to say something about the fact it's enabling
> > > or disabling the actual capture of data into the DMA buffers that
> > > userspace will read.
> > > 
> > > > + * @data_transfer_addr: Set data address.
> > > >   **/
> > > >  struct iio_backend_ops {
> > > >  	int (*enable)(struct iio_backend *back);
> > > > @@ -129,6 +138,13 @@ struct iio_backend_ops {
> > > >  					 size_t len);
> > > >  	int (*debugfs_reg_access)(struct iio_backend *back, unsigned int
> > > > reg,
> > > >  				  unsigned int writeval, unsigned int
> > > > *readval);
> > > > +	int (*ext_sync_enable)(struct iio_backend *back);
> > > I know we've done it this way for existing items, but I wonder if we should
> > > squish down the ops slightly and have new enable/disable pairs as
> > > single functions.
> > > 	int (*ext_sync_set_state)(struct iio_backend *back, bool enable);
> > > etc.  If nothing else reduces how many things need documentation ;)
> > > 
> > > Nuno, what do you think? Worth squashing these pairs into single
> > > callbacks?
> > 
> > I'm not a fan of combining enable and disable functions into one function.
> > 
> > The implementation will pretty much always be:
> > 
> > if (enabled) {
> >         /* so stuff */
> > } else {
> >         /* do other stuff */
> > }
> > 
> > Which just adds indent and makes code harder to read.
> > 
> 
> Hi Jonathan and David,
> 
> Yeah, I have this on my todo list and to be fair with Angelo, he already had
> something like you're suggesting. I kind of asked him to postpone that so we
> don't have mixed styles in the file for now. Then I would convert them all. My
> plan would be to squash the .ops into one and then have inline
> enable()/disable() helpers (at least for the current users in order to keep
> things easier to convert).
> 
> As for David's comment, I see your point but one can always improve things a bit
> 
> if (enable) {
> 	/* do stuff */
> 	return;
> }
> 
> /* do disable stuff */
> return 0
> 
> I'm aware the above is always not that straight... but I do think there's always
> ways to rearrange things a bit to make it better. Because even with the
> enable()/disable() approach, if you start to have a lot of common code, likely
> you'll add an helper function. In some cases, one can even add the helper right
> away with an 'enable' argument effectively doing what is being suggested in
> here. It always depends on the person implementing the ops :)
> 
> Anyways, I really don't have a strong feeling about this. I had in my mind to do
> something like this. It feels that Jonathan would already be ok with it. If it's
> not that awful for David, I'll eventually send the patches (unless Angelo wants
> to take care if it in this series).
>

I agree a single function for enable/disable may be good, reducing the calls and
also the code size should benefit of some few bytes.

Honestly, i would not do this in this patchset since i am a bit in difficulties
to have this job accepted as is, and also cannot retest all of them properly
right now.
 
> - Nuno Sá
> > 

-- 
Regards,
  Angelo
       

