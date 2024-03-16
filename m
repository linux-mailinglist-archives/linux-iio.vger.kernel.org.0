Return-Path: <linux-iio+bounces-3569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E1987DB56
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE9E2817DB
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521081BDD0;
	Sat, 16 Mar 2024 19:48:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC11A38E5
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710618510; cv=none; b=TzicOZ24c19ShUxM8k2/y2b1LuqWdmtLtceMcQwg/lgivWXiey8TaiKT2tU+WLDlr4zQkfMMJWIY/Tdcy+PIAcRO3iiq/DBVeD3pecup7SlxcM2Ngfib1qunTtifXqezfkVjxQzIdNI75Mrc3OE+pF+gI0XuF8Tb4Klv0UnAW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710618510; c=relaxed/simple;
	bh=YYQFCy5Dw0D7P0hdmJrapITmlWuJyMxKXKC8Pyhh6BM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLhBEliq/d6YjQLCWwb5D6tDYRhGhoT7QWdGBuNv2P7lJQclbXS1jP8gfVF3Ll+hfcCHBU2UzKxCMF6qh/YNuws6VwW226COrkiRKq12W4d3HigxUkwRvKgpP2drr/bfNXpDBACxLYYlWIZo/q2mqeKN0PPxi279DMNvS9QUTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 234970f1-e3ce-11ee-a9de-005056bdf889;
	Sat, 16 Mar 2024 21:48:19 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:48:18 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Message-ID: <ZfX3gnbwYcZlGpBq@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>

Thu, Feb 29, 2024 at 04:10:28PM +0100, Nuno Sa kirjoitti:
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> While at it, also use __free(kfree) where allocations are done and drop
> obvious comment in iio_channel_read_min().

...

>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
> -	int i = 0, ret = 0;
> +	int i = 0, ret;
>  	struct iio_map_internal *mapi;

Why not making it reversed xmas tree order at the same time?

>  	if (!maps)
>  		return 0;

...

> -error_ret:
> -	if (ret)
> -		iio_map_array_unregister_locked(indio_dev);
> -	mutex_unlock(&iio_map_list_lock);
>  
> +	return 0;
> +error_ret:
> +	iio_map_array_unregister_locked(indio_dev);
>  	return ret;
>  }

Do we really need to split this? (I'm fine with a new code, but seems to me as
unneeded churn.)

...

> +	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
> +							    GFP_KERNEL);

I would indent a bit differently:

	struct iio_channel *channel __free(kfree) =
					kzalloc(sizeof(*channel), GFP_KERNEL);

(maybe less TABs, but you got the idea)

>  	if (!channel)
>  		return ERR_PTR(-ENOMEM);

...

> +	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
> +							  sizeof(*chans),
> +							  GFP_KERNEL);

Ditto.

>  	if (!chans)
>  		return ERR_PTR(-ENOMEM);

...

>  	/* first find matching entry the channel map */
> -	mutex_lock(&iio_map_list_lock);
> -	list_for_each_entry(c_i, &iio_map_list, l) {
> -		if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> -		    (channel_name &&
> -		     strcmp(channel_name, c_i->map->consumer_channel) != 0))
> -			continue;
> -		c = c_i;
> -		iio_device_get(c->indio_dev);
> -		break;
> +	scoped_guard(mutex, &iio_map_list_lock) {
> +		list_for_each_entry(c_i, &iio_map_list, l) {
> +			if ((name && strcmp(name, c_i->map->consumer_dev_name) != 0) ||
> +			    (channel_name &&
> +			     strcmp(channel_name, c_i->map->consumer_channel) != 0))

I would kill these ' != 0' pieces, but I see they are in the original code.

> +				continue;
> +			c = c_i;
> +			iio_device_get(c->indio_dev);
> +			break;
> +		}
>  	}

...

> -	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> +	struct iio_channel *channel __free(kfree) = kzalloc(sizeof(*channel),
> +							    GFP_KERNEL);

Indentation?

...

> -error_no_chan:
> -	kfree(channel);
>  error_no_mem:
>  	iio_device_put(c->indio_dev);
>  	return ERR_PTR(err);

Effectively you move kfree after device put, would it be a problem?

...

>  struct iio_channel *iio_channel_get_all(struct device *dev)
>  {
>  	const char *name;
> -	struct iio_channel *chans;
> +	struct iio_channel *fw_chans;
>  	struct iio_map_internal *c = NULL;

Move it here for better ordering?

>  	int nummaps = 0;
>  	int mapind = 0;

...

> -	chans = fwnode_iio_channel_get_all(dev);
> +	fw_chans = fwnode_iio_channel_get_all(dev);

I would move it before conditional...

>  	/*
>  	 * We only want to carry on if the error is -ENODEV.  Anything else
>  	 * should be reported up the stack.
>  	 */
> -	if (!IS_ERR(chans) || PTR_ERR(chans) != -ENODEV)
> -		return chans;

...here.

> +	if (!IS_ERR(fw_chans) || PTR_ERR(fw_chans) != -ENODEV)
> +		return fw_chans;

...

> +	struct iio_channel *chans __free(kfree) = kcalloc(nummaps + 1,
> +							  sizeof(*chans),
> +							  GFP_KERNEL);

Indentation?

> +	if (!chans)
> +		return ERR_PTR(-ENOMEM);

-- 
With Best Regards,
Andy Shevchenko



