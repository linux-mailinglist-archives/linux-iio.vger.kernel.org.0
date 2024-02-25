Return-Path: <linux-iio+bounces-3052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8388862A60
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677731F2155A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16710940;
	Sun, 25 Feb 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nu5NFPCn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26410A3C
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708865628; cv=none; b=FM5wy+a1TUcsj89vH+zpvyaYvXebwUQjGpjf/oj+xpnJpZGbnMKtXdjTpPdGLZG9LDxQFV+gI4JPSRKepfBJ/0t4UYFjYCXlNmghULAtDf32MWFvLLzuZ0izMUnEtiQd9TKiUYB7Y75z8quSOn4k7SwGyPUHifYM20YfdEH1WFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708865628; c=relaxed/simple;
	bh=07C4czM1w4CMdiZHAhynBfRIz43nmHnffjeevpS9QQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gv7Xg7kqhixok+Mu3ioSQk2iQhPpOns1ZMTfpxzVdZs4v0XPGNDvd/EuTowuEfEpTazVbCAKTEIAxTu5gDdfT2zTOkqar/nFi3+hpjcV5L2A+wee/72Ub3excmDRLI68Amwvjfus9zPfKvLyIkhhDGnMMuaF1++wpE+O7WsKpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu5NFPCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03CDC433C7;
	Sun, 25 Feb 2024 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708865628;
	bh=07C4czM1w4CMdiZHAhynBfRIz43nmHnffjeevpS9QQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nu5NFPCnD6RZnP3OZG9Xu3VWDQn0gbdzej/Esv3I8CcXz49i2Z05E2cupPgKRQmip
	 LzvawBiCAVu3rEFIu0g50tEXy6lQTV8Nf2SonF+xZU6+U675uk0/kpvUM3lw/pNKhA
	 GLxxmguPTD2OjdNfLUafcx2YMnbxDkqbxbgLqbb89m2ElpwdkDDPxykrw7mphnf8vl
	 01zGn46TpXyAQvz6To+w5NUzrUEMHQFkAVeCK3PGaQmenY4BQO3Ci5ryTjj8qKEEGK
	 Y/9zLDM4yrWlmUOEIXkAl9+HvlcgDf1n0Eud1lvx3bCoBLqXL7uGvlSM1e/7b4hF0D
	 cuJayQOswulLg==
Date: Sun, 25 Feb 2024 12:53:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/5] iio: buffer: iio: core: move to the cleanup.h
 magic
Message-ID: <20240225125336.682aa093@jic23-huawei>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-4-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	<20240223-iio-use-cleanup-magic-v2-4-f6b4848c1f34@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:43:47 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

I think we can do more in here as a result of early returns being available.

> ---
>  drivers/iio/industrialio-buffer.c | 105 ++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b581a7e80566..ec6bc881cf13 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -10,6 +10,7 @@
>   * - Alternative access techniques?
>   */
>  #include <linux/anon_inodes.h>
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/device.h>
> @@ -533,28 +534,25 @@ static ssize_t iio_scan_el_store(struct device *dev,
>  	ret = kstrtobool(buf, &state);
>  	if (ret < 0)
>  		return ret;
> -	mutex_lock(&iio_dev_opaque->mlock);
> -	if (iio_buffer_is_active(buffer)) {
> -		ret = -EBUSY;
> -		goto error_ret;
> -	}
> +
> +	guard(mutex)(&iio_dev_opaque->mlock);
> +	if (iio_buffer_is_active(buffer))
> +		return -EBUSY;
> +
>  	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
>  	if (ret < 0)
> -		goto error_ret;
> +		return ret;

We could short cut this I think and end up with a simpler flow.
The early returns allow something like

	if (state && ret)  /* Nothing to do */
		return len;

	if (state)
  		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
	else
		ret = iio_scan_mask_clear(buffer, this_attr->address);
	if (ret)
		return ret;

	return len;

>  	if (!state && ret) {
>  		ret = iio_scan_mask_clear(buffer, this_attr->address);
>  		if (ret)
> -			goto error_ret;
> +			return ret;
>  	} else if (state && !ret) {
>  		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
>  		if (ret)
> -			goto error_ret;
> +			return ret;
>  	}
>  
> -error_ret:
> -	mutex_unlock(&iio_dev_opaque->mlock);
> -
> -	return ret < 0 ? ret : len;
> +	return len;
>  }
>  



...

>  
> @@ -1326,21 +1305,19 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  	if (ret < 0)
>  		return ret;
>  
> -	mutex_lock(&iio_dev_opaque->mlock);
> +	guard(mutex)(&iio_dev_opaque->mlock);
>  
>  	/* Find out if it is in the list */
>  	inlist = iio_buffer_is_active(buffer);
>  	/* Already in desired state */
>  	if (inlist == requested_state)
> -		goto done;
> +		return len;
>  
>  	if (requested_state)
>  		ret = __iio_update_buffers(indio_dev, buffer, NULL);
>  	else
>  		ret = __iio_update_buffers(indio_dev, NULL, buffer);
>  
> -done:
> -	mutex_unlock(&iio_dev_opaque->mlock);
>  	return (ret < 0) ? ret : len;
Maybe just switch this for

	if (ret < 0)
		return ret;

	return len;

So it looks more like the new return len above?

>  }

> 


