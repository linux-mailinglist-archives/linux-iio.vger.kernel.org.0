Return-Path: <linux-iio+bounces-12305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042029CE12F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 15:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884761F22EE0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DB1CEE88;
	Fri, 15 Nov 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgLrvYlV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E61B218E;
	Fri, 15 Nov 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680713; cv=none; b=O0x6SB4X1ScPuKKHEzSrGR48P1KTp9Bb1l2yJE6v8T92MppWOiJIM8SSdCySXhA/vImy60MOWNb7Q1+ww7kH1NAgZdls7APN+PzWpdER1RiB5eRebZ7UDKMffJKkjJIv52oJlTFkGdNcq6fo0/DhGmGGvwvNYBp6PD4ce7Nd0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680713; c=relaxed/simple;
	bh=i0J9YgKrlwFGfJuGRYdXWxMQtfccCScGcb3RUoJTSr8=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=Yt0JPXNB99ECKc/5kx7U1kx8MbsA5RKeXrvCS4SIpK0Eam6bebs4jpCyZhNWQ6paWfdxA1b3/1tkRv8GlSMF9c2N2h4Teqrs+UGBgm84CyG1jKPRgUMtWoHcgr0ypj7tsyPG3kRrVUJ7dKomdPAh13Nm/iqPEXrCuFwFy/nOJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgLrvYlV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso14790885e9.1;
        Fri, 15 Nov 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731680709; x=1732285509; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=huYdQY6mriqKFmtZHIEpj3W9QBUQ/Y1F8VwJADSGD04=;
        b=WgLrvYlVB5Qgyw0Ly3d8HYkiNOGJ3MkqJcrMiOu2RofFIX8SIzcXlhhRlcUyOHqxde
         wwZ8o3tWv69m0nqxSnfsMcy1LIxELvMrXR9vbe9Dra9H4TlOR77WAieINjJSvr/+EZmy
         1e7f3oPOVh2rE7raShCMGVUDJpy2w5ikAGgxj5jvb4UyR7oqXco65EV53MaB+ej8k/OK
         OfeLomCDmfmAmIRb/AbcQfuncG7yi5bBrAze7mRUHp/bhn1CmBtQz5RkPv6sq7qT9HgT
         iWKEkSvdWynVl7ny4JThLRDtWmFtZJga/7ftOTeJozMYLh+4hxmCs0Wg+VFjLy8wK/J4
         px3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680709; x=1732285509;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huYdQY6mriqKFmtZHIEpj3W9QBUQ/Y1F8VwJADSGD04=;
        b=m6fOx5BG5izAujCpFxTZDZizDJfyPEilcLAad4otLmsf0l0ynNVGrEMbhnec5dWPpk
         g2lDYD7osuXnXsFzH+MKbtswu8J2vpiRGavDkgUCdDo+TrE+WHTGtYKDSfVf0v4ZbqHl
         6ImsCjPBjG1I9nuJ4xGIZ/MwSPcXeqamiQUwfKDcaK+3eUO8+W8lzO1Dcuil2AbfspnZ
         /ouRiWWm8anuW5JkFXUNiDTECVALGCSCDXQI2K+hHnsNjimNkzWKpgE/KQhrnR8vcOQV
         r95vjMmpcf9H7CjhjXAQot9uxtHZO1xyncBC4QhQCpO46OReEq4ky7wnZOjEi2pki8Xq
         xRRA==
X-Forwarded-Encrypted: i=1; AJvYcCUI4VB6Ie2sVQ1r3tOcjFFl38ltxs9Gz9x5uf3EDvUrVVutsMVfYM/MY+GCsf9AXgShMPy72ad997E=@vger.kernel.org, AJvYcCUPDNKxc29d5pePq7Vx1ZzwsRH36wbEXjFVxl3nIJf71jE8MgYtMzyFKfzIqBIR6PCg5kmYASNokg8=@vger.kernel.org, AJvYcCXhXhZGln/oc7wwHGRqdYCDSFJ3YmECNf/M5Q7wpeZyWi+ekkWqcetaZ3vRigSKWvZ/N6hcVsnPfi+A6H45@vger.kernel.org, AJvYcCXlawIDMtGtRlBQNvpyqiptg/I/s5OFWEULqdD01pRomqbnPJeJ+pZm9Bp/aH1jUnnkjHUmEH3flHnIew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaX0dADFLH+AkfEanbLn+rcli5MIO5fbOxqAircisImSkHnCjs
	7EkAnIJxFrR5qefXQPYINz+JZ4XNMC+FbtcYOBj4mTwxqHpqU5+q
X-Google-Smtp-Source: AGHT+IFeR2Eue7s/9O+/fjwsUcRKHzKZtQ/Ca+D3UCUrEfMOuXVULfMsSamBMgupClYDWWXIic4iKw==
X-Received: by 2002:a05:600c:1c97:b0:431:50fa:89c4 with SMTP id 5b1f17b1804b1-432df71c02fmr26239725e9.3.1731680708463;
        Fri, 15 Nov 2024 06:25:08 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0aca0sm54961665e9.29.2024.11.15.06.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:25:07 -0800 (PST)
Date: Fri, 15 Nov 2024 15:25:06 +0100
Message-ID: <b56ba6a0db195ad44158509f3adb157b@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
	<alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
	<peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
	<sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <173039799203.1353.4404042832923090619@njaxe.localdomain>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
	<20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
	<ZyJHFp6vbQ7deLFs@black.fi.intel.com>
	<173031260171.39393.109639772708550094@njaxe.localdomain>
	<20241030203050.5cdf3450@jic23-huawei>
	<173037398492.12348.265826723028347056@njaxe.localdomain>
	<20241031143129.0000014e@Huawei.com>
	<173039799203.1353.4404042832923090619@njaxe.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:
> Quoting Jonathan Cameron (2024-10-31 15:31:29)
> > On Thu, 31 Oct 2024 12:26:24 +0100
> > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > 
> > > Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > >   
> > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)  
> > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:    
> > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > condition with the producer unregistration, change inkern
> > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > locked.
> > > > > > > 
> > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > but stores the available values in the returned variable.    
> > > > > > 
> > > > > > ...
> > > > > >     
> > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > +                                         const int *vals, long mask)
> > > > > > > +{
> > > > > > > +     kfree(vals);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > >                             int val, int val2, long mask)
> > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > >  };    
> > > > > > 
> > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > memory in one place and must clear it in another. This is not well
> > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > at least these two comes to my mind:
> > > > > > 
> > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > after all;
> > > > > > 
> > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.    
> > > > > 
> > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > usage examples?
> > > > > 
> > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > case, so that it would take care of freeing the buffer after calling
> > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > to let the driver keep the release control through a callback for two
> > > > > reasons:
> > > > > 
> > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > >    not?  
> > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > not needed and that it prevents any optimization like you mention.  
> > > 
> > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > without replacing the original .read_avail(), so all the current drivers that
> > > use a constant avail list would not be affected. And I think this was the same
> > > idea for the additional read_avail_ext() or the additional argument for the
> > > read_avail() we were considering in [1]. So I would think that
> > > iio_read_channel_info_avail() would do something like the following:
> > > 
> > >     if (indio_dev->info->read_avail_with_copy)
> > >         indio_dev->info->read_avail_with_copy(vals);
> > >     else
> > >         indio_dev->info->read_avail(vals);
> > > 
> > >     ...
> > >     iio_format_avail_list(vals);
> > >     ...
> > > 
> > >     if (indio_dev->info->read_avail_with_copy)
> > >         kfree(vals);
> > 
> > Ok, sure that would work, but...
> > 
> > I don't really see this as being much less fragile than
> > the existing solution + in cases that we do have where
> > only some available are not const we will have to copy them
> > all.
> > 
> > If anything it's more complex than making it a driver problem
> > to provide the release call however it wants to do it.
> >  
> > 
> > > 
> > > And the drivers would choose whether to define the read_avail or the
> > > read_avail_with_copy.
> > > 
> > > What I was referring to is that, back then, you mentioned you would have
> > > preferred to avoid passing ownership of the buffer around:
> > > 
> > > > That's a corner case we should think about closing. Would require an indicator
> > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > free on completion of the string building.  I don't like passing ownership
> > > > of data around like that, but it is fiddly to do anything else given
> > > > any simple double buffering is subject to race conditions.  
> > > 
> > > I guess there is some other reason other than avoiding the copy when not
> > > necessary, since by introducing an additional function or argument or return
> > > type, most of the unnecessary copies would already be avoided right?
> > 
> > It's not a strong reason beyond limiting scope of clever design +
> > the key bit my mind is that the above is not substantially simpler and
> > reduces our flexibility.
> > 
> > > 
> > > Anyway any of this solutions would still prevent the potential optimizations of
> > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > not adopted by any driver.
> > 
> > That one indeed not, but mixing dynamic and non dynamic is something
> > you do in your pac1921 patch.
> 
> Good point! I didn't think about it, or more likely I forgot, that with an
> additional read_avail_with_copy() used as in the example you cannot mix dynamic
> and non dynamic available lists, thus those drivers that need at least one
> dynamic available list would always copy all of them as they need to rely to
> the read_avail_with_copy(). I guess this could be worked around with an
> additional return argument for the read_avail() or an additional type like the
> IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> the list after use. However, I think they would introduce a more invasive
> change in the current API compared to an additional optional callback, so I
> agree that the current release callback is still a better option.
> 
> > 
> > Jonathan
> > 
> > 
> > > 
> > > > 
> > > > Jonathan  
> > > > > 
> > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > >   
> > > > > > 
> > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > and think again.    
> > > > > 
> > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > better solution after addressing the points above.
> > > > >   
> > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > agree on the report, I think this solution is not good enough.
> > > > > > 
> > > > > > -- 
> > > > > > With Best Regards,
> > > > > > Andy Shevchenko
> > > > > >     
> > > > > 
> > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> > > > > 
> > > > > Best regards,
> > > > > Matteo Martelli  
> > > >   
> > > 
> > > I hope I've brought a little more clarity to the discussion by providing some
> > > history instead of making it more confusing.
> > 
> > Sure, the code example in particular is useful.
> > 
> > Jonathan
> > 
> > > 
> > > Best regards,
> > > Matteo Martelli
> > > 
> > > 
> > 
> Best regards,
> Matteo Martelli

Just a friendly reminder this has been sitting for a while, any news or
additional considerations?

Best regards,
Matteo Martelli

