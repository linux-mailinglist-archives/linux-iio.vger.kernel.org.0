Return-Path: <linux-iio+bounces-3704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A18879E2
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 19:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08265282155
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD454772;
	Sat, 23 Mar 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9/VDTVl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3D4D9ED
	for <linux-iio@vger.kernel.org>; Sat, 23 Mar 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711217405; cv=none; b=dBgA1+ITh3mwfNn7lZz16f9/LQq3pw3jLDq/LAo84eCtmCtgq8MJjbCFtY2E8NkNitc6NzIuyzRZ+qAm3Ny7JAz9nwzomaNYLv8rPjexlYqj8jKS/5mzrPzLDuY6v6oGIsV1IOXj8XeV/IiiREParplfW2KdU4HZcgnIh9HbvF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711217405; c=relaxed/simple;
	bh=4QBrM+MLxNHP+XSxqfZPZ17R3s3ofDWD5M3NJ/roqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGe0ByntWf2PuMiTjX4zX9WkPuzH0Vg/zLMkdV2RKDvHqufDDDD2W6fXmelwQ7Z1P/x5Oh6ZbNaD60btjNLw9oz2Mp9kKzoKVt+4nSfAbud4BZwm5IP8OiACKjaDpJTjp0/WDdnGp/9HjxQGfH1e6WSFqEekCtr/ibtV6Lf70qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9/VDTVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19794C433F1;
	Sat, 23 Mar 2024 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711217404;
	bh=4QBrM+MLxNHP+XSxqfZPZ17R3s3ofDWD5M3NJ/roqFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A9/VDTVlCS6oVk6DdzhUW9icJE0V80Ken7VXb2NA4L+GCLRjkcjzE+TEHPQTPQchf
	 wwiKJfQpXRi+VwG3tVBk/bAZdRxkTZtB9dG3ZvqR/KrHd5SFZoQmxC3qGAgPyJbOfy
	 ewpg5ChiE6n7fuMDbOBRrL58i7sD2ATx3wdULyXxFb8E2qYLgOimZPptQNmurgenNl
	 71Wzlzav/vMzdsQWdsTGMqMl/9+xnUvsF7aYVxnM3OQGehdOULWFVgLQkYLXgcdPly
	 VyYTIkArRHnNCakUg+XxSTkXPKxBE6f5V7xVd/2UhmbLRZXjsLkbPSRjBpk5CpRhSb
	 CfmftxXIeM8uA==
Date: Sat, 23 Mar 2024 18:09:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Message-ID: <20240323180951.5e990e11@jic23-huawei>
In-Reply-To: <ZfX3gnbwYcZlGpBq@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
	<ZfX3gnbwYcZlGpBq@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 21:48:18 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Feb 29, 2024 at 04:10:28PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us to
> > greatly simplify some code paths.
> > 
> > While at it, also use __free(kfree) where allocations are done and drop
> > obvious comment in iio_channel_read_min().  
> 
> ...
> 
> >  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
> >  {
> > -	int i = 0, ret = 0;
> > +	int i = 0, ret;
> >  	struct iio_map_internal *mapi;  
> 
> Why not making it reversed xmas tree order at the same time?
> 

I tweaked this. Went a bit further as mixing declarations that
set values and ones that don't is a bad pattern for readability.

	struct iio_map_internal *mapi;
	int i = 0;
	int ret;

> >  	if (!maps)
> >  		return 0;  
> 
> ...
> 
> > -error_ret:
> > -	if (ret)
> > -		iio_map_array_unregister_locked(indio_dev);
> > -	mutex_unlock(&iio_map_list_lock);
> >  
> > +	return 0;
> > +error_ret:
> > +	iio_map_array_unregister_locked(indio_dev);
> >  	return ret;
> >  }  
> 
> Do we really need to split this? (I'm fine with a new code, but seems to me as
> unneeded churn.)

I much prefer not to have the
	if (ret) // error case
		do something.

	//back to both good and bad paths.
	return ret;

pattern - so I've very keen to have this spit as I disliked the original
code and there is even less reason to combine the paths now we don't need
the mutex_unlock.


> 
> ...
> 
> > +	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
> > +							    GFP_KERNEL);  
> 
> I would indent a bit differently:
> 
> 	struct iio_channel *channel __free(kfree) =
> 					kzalloc(sizeof(*channel), GFP_KERNEL);
> 
> (maybe less TABs, but you got the idea)
Given I was rebasing anyway, tidied this up (in 4 places) as well (fewer tabs ;)

> 
> >  	if (!channel)
> >  		return ERR_PTR(-ENOMEM);  
> 
> ...
> 
> > +	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
> > +							  sizeof(*chans),
> > +							  GFP_KERNEL);  
> 
> Ditto.
> 
> >  	if (!chans)
> >  		return ERR_PTR(-ENOMEM);  
> 
> ...
> 
> >  	/* first find matching entry the channel map */
> > -	mutex_lock(&iio_map_list_lock);
> > -	list_for_each_entry(c_i, &iio_map_list, l) {
> > -		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> > -		    (channel_name &&
> > -		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
> > -			continue;
> > -		c = c_i;
> > -		iio_device_get(c->indio_dev);
> > -		break;
> > +	scoped_guard(mutex, &iio_map_list_lock) {
> > +		list_for_each_entry(c_i, &iio_map_list, l) {
> > +			if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> > +			    (channel_name &&
> > +			     strcmp(channel_name, c_i->map->consumer_channel) != 0))  
> 
> I would kill these ' != 0' pieces, but I see they are in the original code.

Don't mind a change doing that, but not in this patch.

> 
> > +				continue;
> > +			c = c_i;
> > +			iio_device_get(c->indio_dev);
> > +			break;
> > +		}
> >  	}  
> 
> ...
> 
> > -	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> > +	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
> > +							    GFP_KERNEL);  
> 
> Indentation?
> 
> ...
> 
> > -error_no_chan:
> > -	kfree(channel);
> >  error_no_mem:
> >  	iio_device_put(c->indio_dev);
> >  	return ERR_PTR(err);  
> 
> Effectively you move kfree after device put, would it be a problem?
It's not immediately obvious what that put pairs with so we should probably
address that a bit more clearly anyway - but the change should be safe.

> 
> ...
> 
> >  struct iio_channel *iio_channel_get_all(struct device *dev)
> >  {
> >  	const char *name;
> > -	struct iio_channel *chans;
> > +	struct iio_channel *fw_chans;
> >  	struct iio_map_internal *c = NULL;  
> 
> Move it here for better ordering?
Trivial, but meh, I'm tweaking anyway so done.
> 
> >  	int nummaps = 0;
> >  	int mapind = 0;  
> 
> ...
> 
> > -	chans = fwnode_iio_channel_get_all(dev);
> > +	fw_chans = fwnode_iio_channel_get_all(dev);  
> 
> I would move it before conditional...
> 
> >  	/*
> >  	 * We only want to carry on if the error is -ENODEV.  Anything else
> >  	 * should be reported up the stack.
> >  	 */
> > -	if (!IS_ERR(chans) || PTR_ERR(chans) != -ENODEV)
> > -		return chans;  
> 
> ...here.
> 
> > +	if (!IS_ERR(fw_chans) || PTR_ERR(fw_chans) != -ENODEV)
> > +		return fw_chans;  
> 
> ...
> 
> > +	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
> > +							  sizeof(*chans),
> > +							  GFP_KERNEL);  
> 
> Indentation?
> 
> > +	if (!chans)
> > +		return ERR_PTR(-ENOMEM);  
> 


