Return-Path: <linux-iio+bounces-12378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2589D137F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E239F1F22231
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A482B1AA1DA;
	Mon, 18 Nov 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFFidJAM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611451991B8;
	Mon, 18 Nov 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941130; cv=none; b=JusUgT45xtfN/M69IneIgGR/qWx6WhEWlGPJk5swFKML5POYLiepOs29ZN83zJiIWf85O1DHSnC9GTYBo3UD+NuO8pOyiyRAnIfAKMf2PETZtu3HfsAPnQ2Dj1WcC9+RF4nTSYu3Cx5Ur7W1RkQIeBO2MigV6Uxumq6zBKVweJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941130; c=relaxed/simple;
	bh=bwBXPYUGmEj7VIzPyGuJGDJlplFGg5JxziZ5f9N/8s8=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=W7nxorGXoY4epPhba45kiBSRVhN5HnfLSX6MGR1DDpoXjsYBJ4c0+lbddoARTNJh5P6oJCsKWl+o6FtZldWxQ5R+YcziZlnXm64tPWH2xPiBoewBYIc05TrBXE3lW5XZXkMhkOoBqCR8Ms74SG5dvAdooiBO3RK/6HeMu6VKMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFFidJAM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382433611d0so1329354f8f.3;
        Mon, 18 Nov 2024 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941127; x=1732545927; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=54MjqZiF9+lnHndqtwcm3VNH+zJ2njJJl9CBXjOnllY=;
        b=CFFidJAMu+O8vRMLPJ88FjvZwuMgp2JdrGyvTmSU9p2Icvn9af4TOjG3sXUyinfiDe
         LM3KEQbb0p/E0cLezyRtIqGelQXxkEvH8pIG3eFY1loXH56BKjUbKk/QxxN57y2f2BNp
         akLcVFywrR3rF33lEzbQ4sAfZL9uBUZULJL6zHpMg1fP0ljVTY2tAamAZ0l5puRQd6Vc
         sDgJ07qbuQX4lIrcVXTc1TIlGQagXLEolpXBHOYO8FXA/LvUWGuBnRQ9H1K8YNBMl6su
         ph1h00zHf08xK5gmhw/pPLxryf0kUX5yQk0BMSWFyU34Jc3woYT8w61V/dQN4FzbpjuV
         Dn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941127; x=1732545927;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54MjqZiF9+lnHndqtwcm3VNH+zJ2njJJl9CBXjOnllY=;
        b=AUFx+4rBpWckaw4LpQcgCT7ZHIfCC9pdrCv/Jsd3JNiOe5gxtaWq7h0kyJAKBYF+fh
         kHf0PE/2TJjvMTfNz+Tb2bom9c+jN4rmb0xI6SajrTH4Z7Eyq7TyEY+HZTxd+v9fLuhB
         pHg/4rZC8uT++m1vS0X5CxTVKX+fLWhO+N3IjPpiKXsorgEQCzEumLdFgwUVj8pBLDfO
         Nb3UZcscVeB2GQvPoJMBkUI9orYrH3E3i+7SsVVdxR1eFYz6W9Av1vuxMfq40h0m8D1B
         DctQ+2r1oL/+htqOtDgh7hFwq1/52YZocCBsT0D9jtfq99ZlumoXpHqzJiJQAIi6vYJI
         iOyw==
X-Forwarded-Encrypted: i=1; AJvYcCUNzuPt/nRuDlauGR7ucGVuQw+IiPWftP3PX0iq1bXvg1MaFViKz7NtfTvkIN6YvVMkRBWRPMNwpAM=@vger.kernel.org, AJvYcCVI50K9QFxvVthCsdA3M9KSxpW6mS0vMHuqDt44mZuX6rMDrV5Ssmxy2tVzEqacFdLSbi1CwWaEGtwIzA==@vger.kernel.org, AJvYcCVnKZUBISzLfOndlUJy1KX+K6wTxuBno+gMc/0cFaRkf60+C3pGFgCE9kQhFGZO0CP+6eAjhUqg4lj4utuE@vger.kernel.org, AJvYcCVuBVbxQhGWBrTlHInKorkEVSDLRAc97FOZqkeUhXunGwclgwEguHcDTq3Hq/Q14U8xbhyscUCQAV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9RvzYHPH4gwEPKGZ5dQj3jXTYDD22XwsCuuvgu1HdcZ3aUrs
	3zjC7QjMkXass32j7UNLRPQ7zLTmg8CyqlWXJwUegcAeJZLUEA6y
X-Google-Smtp-Source: AGHT+IFlWWgytCJs+WKhAd33D/rEEpmibnOJHFIk5o4CFwRodsSZ9nOuvWqNV8e3Kk/MSSTxWJOZ4w==
X-Received: by 2002:a5d:6c66:0:b0:382:372a:573a with SMTP id ffacd0b85a97d-382372a5ba9mr8918175f8f.50.1731941126409;
        Mon, 18 Nov 2024 06:45:26 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824259de02sm4844348f8f.53.2024.11.18.06.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:45:25 -0800 (PST)
Date: Mon, 18 Nov 2024 15:45:25 +0100
Message-ID: <e56a8f3c81429c465e87a3abcccec1b4@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>,
	Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <ZzsVOGvzgNTvuEtD@smile.fi.intel.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
	<20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
	<ZyJHFp6vbQ7deLFs@black.fi.intel.com>
	<173031260171.39393.109639772708550094@njaxe.localdomain>
	<20241030203050.5cdf3450@jic23-huawei>
	<173037398492.12348.265826723028347056@njaxe.localdomain>
	<20241031143129.0000014e@Huawei.com>
	<173039799203.1353.4404042832923090619@njaxe.localdomain>
	<b56ba6a0db195ad44158509f3adb157b@gmail.com>
	<ZzsVOGvzgNTvuEtD@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Mon, 18 Nov 2024 12:21:44 +0200, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> On Fri, Nov 15, 2024 at 03:25:06PM +0100, Matteo Martelli wrote:
> > On Thu, 31 Oct 2024 19:06:32 +0100, Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > Quoting Jonathan Cameron (2024-10-31 15:31:29)
> > > > On Thu, 31 Oct 2024 12:26:24 +0100
> > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > > > > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > > > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > > > > > > Quoting Andy Shevchenko (2024-10-30 15:47:50)  
> > > > > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:    
> 
> > > > > > > > > Consumers need to call the producer's read_avail_release_resource()
> > > > > > > > > callback after reading producer's available info. To avoid a race
> > > > > > > > > condition with the producer unregistration, change inkern
> > > > > > > > > iio_channel_read_avail() so that it copies the available info from the
> > > > > > > > > producer and immediately calls its release callback with info_exists
> > > > > > > > > locked.
> > > > > > > > > 
> > > > > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > > > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > > > > > > > after calling these functions. To let users free the copied buffer with
> > > > > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > > > > > > consumer helper that is equivalent to iio_read_avail_channel_attribute()
> > > > > > > > > but stores the available values in the returned variable.    
> 
> ...
> 
> > > > > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> > > > > > > > > +                                         struct iio_chan_spec const *chan,
> > > > > > > > > +                                         const int *vals, long mask)
> > > > > > > > > +{
> > > > > > > > > +     kfree(vals);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > >                             struct iio_chan_spec const *chan,
> > > > > > > > >                             int val, int val2, long mask)
> > > > > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > > > > >  static const struct iio_info dpot_dac_info = {
> > > > > > > > >       .read_raw = dpot_dac_read_raw,
> > > > > > > > >       .read_avail = dpot_dac_read_avail,
> > > > > > > > > +     .read_avail_release_resource = dpot_dac_read_avail_release_res,
> > > > > > > > >       .write_raw = dpot_dac_write_raw,
> > > > > > > > >  };    
> > > > > > > > 
> > > > > > > > I have a problem with this approach. The issue is that we allocate
> > > > > > > > memory in one place and must clear it in another. This is not well
> > > > > > > > designed thingy in my opinion. I was thinking a bit of the solution and
> > > > > > > > at least these two comes to my mind:
> > > > > > > > 
> > > > > > > > 1) having a special callback for .read_avail_with_copy (choose better
> > > > > > > > name) that will dump the data to the intermediate buffer and clean it
> > > > > > > > after all;
> > > > > > > > 
> > > > > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.    
> > > > > > > 
> > > > > > > Could you elaborate more about these potential solutions? Maybe with some
> > > > > > > usage examples?
> > > > > > > 
> > > > > > > If I get it correctly, in both cases you are suggesting to pass ownership
> > > > > > > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > > > > > > case, so that it would take care of freeing the buffer after calling
> > > > > > > iio_format_after_*(). We considered this approach during an initial
> > > > > > > discussion with Jonathan (see read_avail_ext() in [1]), where he suggested
> > > > > > > to let the driver keep the release control through a callback for two
> > > > > > > reasons:
> > > > > > > 
> > > > > > > 1) Apparently it's a bad pattern to pass the buffer ownership to the core,
> > > > > > >    maybe Jonathan can elaborate why? The risk I can think of is that the driver
> > > > > > >    could still keep the buffer copy in its private data after giving it away,
> > > > > > >    resulting in fact in a double ownership. However I think it would be clear
> > > > > > >    enough in this case that the copy should be handled by the caller, or maybe
> > > > > > >    not?  
> > > > > > Mostly the lack of desire to have to copy for the 95% of cases where it's
> > > > > > not needed and that it prevents any optimization like you mention.  
> > > > > 
> > > > > I think the suggestion here is to add an additional .read_avail_with_copy()
> > > > > without replacing the original .read_avail(), so all the current drivers that
> > > > > use a constant avail list would not be affected.
> 
> Yes.
> 
> > > > > And I think this was the same
> > > > > idea for the additional read_avail_ext() or the additional argument for the
> > > > > read_avail() we were considering in [1]. So I would think that
> > > > > iio_read_channel_info_avail() would do something like the following:
> > > > > 
> > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > >         indio_dev->info->read_avail_with_copy(vals);
> > > > >     else
> > > > >         indio_dev->info->read_avail(vals);
> > > > > 
> > > > >     ...
> > > > >     iio_format_avail_list(vals);
> > > > >     ...
> > > > > 
> > > > >     if (indio_dev->info->read_avail_with_copy)
> > > > >         kfree(vals);
> 
> Right. At least that's what I see can be done with the existing users.
> 
> > > > Ok, sure that would work, but...
> > > > 
> > > > I don't really see this as being much less fragile than
> > > > the existing solution + in cases that we do have where
> > > > only some available are not const we will have to copy them
> > > > all.
> > > > 
> > > > If anything it's more complex than making it a driver problem
> > > > to provide the release call however it wants to do it.
> 
> ...but make a driver to allocate what's needed as well then.
> 
> > > > > And the drivers would choose whether to define the read_avail or the
> > > > > read_avail_with_copy.
> 
> Either way drivers should know what to do with a data supplied to read_aval().
> In one case we assume the [simple] workflow in the core, in the other we all
> rely on the driver. Current approach makes a mix of these two. And that's what
> I don't like.
> 

If I understand your concern correctly, you are referring to the inkern
iio_channel_read_avail() that makes the allocation for the consumer's
buffer copy and you are suggesting that such copy should be done by the
consumer driver code itself, this to be consistent with the producer
drivers which directly handle the allocation of the copy.

One thing to notice is that the inkern iio_channel_read_avail() does
together producer->read_avail() + copy + producer->read_avail_release()
with info_exists locked. Also, the consumer driver would need to know
the avail buffer size to allocate the buffer copy prior the
iio_channel_read_avail() call, but such size is unknown before calling
the actual producer's read_avail(). This would mean calling the
producer's read_avail() and read_avail_release() callbacks separately
without the lock held, with the risk of a memleak if the producer is
unregistered between those calls.

> > > > > What I was referring to is that, back then, you mentioned you would have
> > > > > preferred to avoid passing ownership of the buffer around:
> > > > > 
> > > > > > That's a corner case we should think about closing. Would require an indicator
> > > > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > > > free on completion of the string building.  I don't like passing ownership
> > > > > > of data around like that, but it is fiddly to do anything else given
> > > > > > any simple double buffering is subject to race conditions.  
> > > > > 
> > > > > I guess there is some other reason other than avoiding the copy when not
> > > > > necessary, since by introducing an additional function or argument or return
> > > > > type, most of the unnecessary copies would already be avoided right?
> > > > 
> > > > It's not a strong reason beyond limiting scope of clever design +
> > > > the key bit my mind is that the above is not substantially simpler and
> > > > reduces our flexibility.
> > > > 
> > > > > Anyway any of this solutions would still prevent the potential optimizations of
> > > > > point 2). It's worth mentioning that those kind of optimizations are currently
> > > > > not adopted by any driver.
> > > > 
> > > > That one indeed not, but mixing dynamic and non dynamic is something
> > > > you do in your pac1921 patch.
> > > 
> > > Good point! I didn't think about it, or more likely I forgot, that with an
> > > additional read_avail_with_copy() used as in the example you cannot mix dynamic
> > > and non dynamic available lists, thus those drivers that need at least one
> > > dynamic available list would always copy all of them as they need to rely to
> > > the read_avail_with_copy(). I guess this could be worked around with an
> > > additional return argument for the read_avail() or an additional type like the
> > > IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
> > > the list after use. However, I think they would introduce a more invasive
> > > change in the current API compared to an additional optional callback,
> 
> It even sounds originally that it should be more invasive, so I don't think it's
> a problem here.
> 

In the hope it helps the discussion let me provide examples for the
additional two options we have other than the current
read_avail_release_resource() (fix-1) and the read_avail_with_copy()
(fix-2) already shown above:

fix-3) iio_read_channel_info_avail():
{
    ...
    bool release_avail = false;

    ret = indio_dev->info->read_avail(vals, ..., &release_avail);

    ...
    ret = iio_format_avail_list(vals, ...);
    ...

    if (release_avail)
        kfree(vals);

    return ret;
}


fix-4) iio_read_channel_info_avail():
{
    ...
    indio_dev->info->read_avail(vals, ...);

    if (ret < 0)
            return ret;
    switch (ret) {
    case IIO_AVAIL_LIST_ALLOC:
            ret = iio_format_avail_list(buf, vals, type, length);
            kfree(vals);
            return ret;
    case IIO_AVAIL_LIST:
            return iio_format_avail_list(buf, vals, type, length);
    case IIO_AVAIL_RANGE:
            return iio_format_avail_range(buf, vals, type);
    default:
            return -EINVAL;
    }

}

> > > so I agree that the current release callback is still a better option.
> 
> I disagree on this as I pointed above why.
> 
> > > > > > > 2) Some driver might want to avoid allocating a new copy of a big table if
> > > > > > >    the race does not occur (e.g. with additional checks on buffer access
> > > > > > >    code) and thus wouldn't call a free() in the release callback.
> > > > > > >   
> > > > > > > > In any case it looks fragile and not scalable. I propose to drop this
> > > > > > > > and think again.    
> > > > > > > 
> > > > > > > I see your concerns, I am open to reconsider this in case we come up with
> > > > > > > better solution after addressing the points above.
> > > > > > >   
> > > > > > > > Yes, yes, I'm fully aware about the problem you are trying to solve and
> > > > > > > > agree on the report, I think this solution is not good enough.
> > > > > > > 
> > > > > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-huawei/
> > > > > 
> > > > > I hope I've brought a little more clarity to the discussion by providing some
> > > > > history instead of making it more confusing.
> > > > 
> > > > Sure, the code example in particular is useful.
> > 
> > Just a friendly reminder this has been sitting for a while, any news or
> > additional considerations?
> 
> Moving the allocation control to the drivers will satisfy me as well, however
> it makes even more duplication of the code, but at least it will be cleaner
> design-wise in my opinion.

Would it work with the constraints on the info_exists lock mentioned
above?

> 
> In any case the last word is on Jonathan.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Matteo Martelli


