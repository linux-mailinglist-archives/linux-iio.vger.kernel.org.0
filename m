Return-Path: <linux-iio+bounces-3567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB29A87DB53
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A3C281921
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905041B59A;
	Sat, 16 Mar 2024 19:38:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE61BC4E
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710617895; cv=none; b=E/q8DAPu66OMmCvYr1WfRzmfjSJ3770NjDntk0ZjtQGsryZWe4DoSDcz/cmd97gkve2tUGSrwpiH8KcwQwwvkl5f206I9+/kZ3+0c3P/cFwobrAIcxPnQOosfZ19gm92QVvsBmAapDeqzKPlVktuCNzY2/KwZdeTXIvTtORc5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710617895; c=relaxed/simple;
	bh=uXsS5zTiusI5pqdOhUWkKKT3Y6JssicyrypQgxmA4dY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSd0DLb5iD9jBcFWuYXigWv4kLc+nqLpc/dl3K9ejb+tDAuLcU1B7fa4PUN2FfdIcMzIbi4RLxrSMRS4/UGvmBxI/O+avrZC/rWiENQLYZ0SR84lmnXiUOogAJWiUz4XzyCiyvBRzJSWCYemwnhpfW2GeqvHTVvPZ7bDqs2hQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b543d057-e3cc-11ee-abf4-005056bdd08f;
	Sat, 16 Mar 2024 21:38:05 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:38:04 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/4] iio: buffer: iio: core: move to the cleanup.h
 magic
Message-ID: <ZfX1HGqT1LwA2b73@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-3-c3d34889ae3c@analog.com>

Thu, Feb 29, 2024 at 04:10:27PM +0100, Nuno Sa kirjoitti:
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.

...

>  	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
>  	if (ret < 0)
> -		goto error_ret;
> -	if (!state && ret) {
> -		ret = iio_scan_mask_clear(buffer, this_attr->address);
> -		if (ret)
> -			goto error_ret;
> -	} else if (state && !ret) {
> +		return ret;
> +
> +	if (state && ret)
> +		return len;

I would leave the original checks. It's natural pattern

	if (foo && !bar)
	if (!foo && bar) // or 'else if' depending on the context

> +	if (state)
>  		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
> -		if (ret)
> -			goto error_ret;
> -	}
> +	else
> +		ret = iio_scan_mask_clear(buffer, this_attr->address);
> +	if (ret)
> +		return ret;
>  
> -error_ret:
> -	mutex_unlock(&iio_dev_opaque->mlock);
> -
> -	return ret < 0 ? ret : len;
> +	return len;

...

>  	/* Already in desired state */
>  	if (inlist == requested_state)
> -		goto done;
> +		return len;

Returning error code immediately is fine, but splitting return success seems to
me a bit too much. It is harder to follow (you really need to understand how many
"success" variants can be).

>  	if (requested_state)
>  		ret = __iio_update_buffers(indio_dev, buffer, NULL);
>  	else
>  		ret = __iio_update_buffers(indio_dev, NULL, buffer);
> +	if (ret)
> +		return ret;
>  
> -done:
> -	mutex_unlock(&iio_dev_opaque->mlock);
> -	return (ret < 0) ? ret : len;
> +	return len;
>  }

-- 
With Best Regards,
Andy Shevchenko



