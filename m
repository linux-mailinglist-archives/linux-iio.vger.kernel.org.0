Return-Path: <linux-iio+bounces-3053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AB9862A6A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6921F21516
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8111C85;
	Sun, 25 Feb 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag0DgJpw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42B79D3
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866734; cv=none; b=rbqfW14mKONakszTE9ip5V/qqSbyKBroXcMfuNQ62hD/ad22JKNcpI+px5t5iqY5AYM53YdZi5ugzayxoCZuPoj9cIWQSmL5g5e+4c+z0jK00yUueE2yg4999Ubl3mlTE26/WLf8U0uOgYMD5z2azjnKkqZJAX4rwj9ERXZVRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866734; c=relaxed/simple;
	bh=eW1fFiGEKXRu5gc5naBk9Mmgx5/vQUOJc4ehxYy9QIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYUaYq+Sfd3ubdMNJ2E4r7rfaiSfDlR6TQt2F6g4lkaHVACZ4M++49UuZQYoPjEzXTJ4VmBg4xOU5dAyBk+07tQxCBQvzN117esO2ryMfmXeBNWwchtZYP9BypTXVtduYuuO3yup8CJFafDP9iwAPFqcOq5/064fNSB9jdTwd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag0DgJpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C3DC433F1;
	Sun, 25 Feb 2024 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866734;
	bh=eW1fFiGEKXRu5gc5naBk9Mmgx5/vQUOJc4ehxYy9QIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ag0DgJpwmUWFFXmYIXaz2nOSdqmS6pOdW/f9dDz1FEj70MF4hu7kuCf8Iopnbbnci
	 ZQuou+xcJyMjUr5LqRXaaLKoyDJ0gpKOWJRdegPExQQL8ZBPF97lw6Ayt95XWR3k7F
	 xNxDKrZbYYKH0I3CfzGhHc/A4zvAQPvekpew6pBM7VBn965nu6gEdj+3Rcbfc2n52T
	 V9rkDWR6SNbYe5EEckGnDXCvwjotmIMTZocf7C37H7fm2Q/avVU7Ig8qDhKdcJRrOj
	 6Uc+8+Dja8kuGVl5QgLB4G8TqvgzLMWcddT6PH+iWVn543TkSYoKRDC7JZFSv96kjE
	 DWQdl+EtFoRsg==
Date: Sun, 25 Feb 2024 13:12:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: inkern: move to the cleanup.h magic
Message-ID: <20240225131202.165d9c34@jic23-huawei>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-5-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	<20240223-iio-use-cleanup-magic-v2-5-f6b4848c1f34@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:43:48 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 224 ++++++++++++++++-----------------------------------
>  1 file changed, 71 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 7a1f6713318a..6a1d6ff8eb97 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2011 Jonathan Cameron
>   */
> +#include <linux/cleanup.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/minmax.h>
> @@ -43,30 +44,26 @@ static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
>  
>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
> -	int i = 0, ret = 0;
> +	int i = 0;
>  	struct iio_map_internal *mapi;
>  
>  	if (!maps)
>  		return 0;
>  
> -	mutex_lock(&iio_map_list_lock);
> +	guard(mutex)(&iio_map_list_lock);
>  	while (maps[i].consumer_dev_name) {
>  		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
>  		if (!mapi) {
> -			ret = -ENOMEM;
> -			goto error_ret;
> +			iio_map_array_unregister_locked(indio_dev);
> +			return -ENOMEM;

break this out to a separate error path via a goto.
The cleanup is not totally obvious so I'd like it to stand out more
than being burried here.  This wasn't good in original code either
as that should just have duplicated the mutex_unlock.


>  		}
>  		mapi->map = &maps[i];
>  		mapi->indio_dev = indio_dev;
>  		list_add_tail(&mapi->l, &iio_map_list);
>  		i++;
>  	}
> -error_ret:
> -	if (ret)
> -		iio_map_array_unregister_locked(indio_dev);
> -	mutex_unlock(&iio_map_list_lock);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_map_array_register);

...

>  EXPORT_SYMBOL_GPL(iio_map_array_unregister);
>  
> @@ -337,17 +329,17 @@ static struct iio_channel *iio_channel_get_sys(const char *name,
>  		return ERR_PTR(-ENODEV);
>  
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
> +				continue;
> +			c = c_i;
> +			iio_device_get(c->indio_dev);
> +			break;
This mix of continue and break is odd. But not something to cleanup in this patch.
It's based on assumption we either have name or channel_name which is checked above.
			if ((name && strcmp(name, c_i->map->consumer_dev_name) == 0) ||
			    (!name && stcmp(channel_name, c_i->map->consumer_channel == 0)) {
				c = c_i;
				iio_device_get(c->indio_dev);
				break;
			}
is I think equivalent. Still too complex for this patch I think.

> +		}
>  	}
> -	mutex_unlock(&iio_map_list_lock);
>  	if (!c)
>  		return ERR_PTR(-ENODEV);
>  
> @@ -469,7 +461,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  
>  	name = dev_name(dev);
>  
> -	mutex_lock(&iio_map_list_lock);
> +	guard(mutex)(&iio_map_list_lock);
>  	/* first count the matching maps */
>  	list_for_each_entry(c, &iio_map_list, l)
>  		if (name && strcmp(name, c->map->consumer_dev_name) != 0)
> @@ -477,17 +469,13 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  		else
>  			nummaps++;
>  
> -	if (nummaps == 0) {
> -		ret = -ENODEV;
> -		goto error_ret;
> -	}
> +	if (nummaps == 0)
> +		return ERR_PTR(-ENODEV);
>  
>  	/* NULL terminated array to save passing size */
>  	chans = kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);

as below, consider dragging the instantiation down here and use __free(kfree) for this
plus make sure to return_ptr() at the good exit path.

> -	if (!chans) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (!chans)
> +		return ERR_PTR(-ENOMEM);
>  
>  	/* for each map fill in the chans element */
>  	list_for_each_entry(c, &iio_map_list, l) {
> @@ -509,7 +497,6 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  		ret = -ENODEV;
>  		goto error_free_chans;
>  	}
> -	mutex_unlock(&iio_map_list_lock);
>  
>  	return chans;
>  
> @@ -517,9 +504,6 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
>  	for (i = 0; i < nummaps; i++)
>  		iio_device_put(chans[i].indio_dev);
>  	kfree(chans);

Could use __free(kfree) and return_ptr(chans);  Not a huge gain though
so maybe not worth it.

> -error_ret:
> -	mutex_unlock(&iio_map_list_lock);
> -
>  	return ERR_PTR(ret);
>  }


>  EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
>  
> @@ -757,30 +713,25 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>  	int ret;
>  
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (!chan->indio_dev->info) {
> -		ret = -ENODEV;
> -		goto err_unlock;
> -	}
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!chan->indio_dev->info)
> +		return -ENODEV;
>  
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>  		ret = iio_channel_read(chan, val, NULL,
>  				       IIO_CHAN_INFO_PROCESSED);
>  		if (ret < 0)
> -			goto err_unlock;
> +			return ret;
> +
>  		*val *= scale;
> -	} else {

Whilst unnecessary I'd keep the else as it documents the clear choice between
option a and option b in a way that an if (x) return;  carry on
doesn't.

> -		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
> -		if (ret < 0)
> -			goto err_unlock;
> -		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
> -							    scale);
> +		return ret;
>  	}
>  
> -err_unlock:
> -	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> +	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret;
> +	return iio_convert_raw_to_processed_unlocked(chan, *val, val, scale);
>  }


>  
>  int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
> -	int ret = 0;
> -	/* Need to verify underlying driver has not gone away */
>  
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (!chan->indio_dev->info) {
> -		ret = -ENODEV;
> -		goto err_unlock;
> -	}
> +	/* Need to verify underlying driver has not gone away */

We only have this comment in some cases. I'd just drop it as kind of obvious
given the naming.  If you do this though add a note to the patch description.

> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!chan->indio_dev->info)
> +		return -ENODEV;
>  
>  	*type = chan->channel->type;
> -err_unlock:
> -	mutex_unlock(&iio_dev_opaque->info_exist_lock);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_get_channel_type);
>  



