Return-Path: <linux-iio+bounces-11782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EA99B93E8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615491C20BC3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976321AA788;
	Fri,  1 Nov 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2xZoTrs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8819F131;
	Fri,  1 Nov 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473383; cv=none; b=ZAQKkfWdfOEBXLfjxCO3jZtN+s3Nw4AZo7YWLAKFF4D97LT4y89GXLrZJZTRllwWf+zYO1eo4bUs9dJLghtsL6dZbqZxRZwzhrnPCE3dZGSqli2O/XLXpzrXzLSSMu45B/g8So7ffgn8DMytTw2CZfoXZUpnwD4CKa5RlvnQvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473383; c=relaxed/simple;
	bh=v1nMNnF1xZ7ucFPNPFxGfXrwsrL/ya1R0Pbjt6gfM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5l2sRgQGX++IzfTlwcFnOv+3ByxbOVlQ3LeuuPRG13rV2gJJw2A02yQm2tJ675k1meSOzoPH7O+xfaygFew5Wwv777YLOERr2ItP9btV0ZJ4dhFbwcEBzNoDGVZuyd/vjsFEx89pFSoZIdpzkWpoCc0d856uSHXnZ5D32RrE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2xZoTrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E33C4CECD;
	Fri,  1 Nov 2024 15:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730473382;
	bh=v1nMNnF1xZ7ucFPNPFxGfXrwsrL/ya1R0Pbjt6gfM8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2xZoTrsG8TR0Jaz4IkpdjDarQjs2NyhymZQ3Z/UE17Jw7rzUnE5/zzQhy+U0uULK
	 PbSRRmB1ItHcLYS2ydKosJDazl7s+f00kkD5S4Vzr3zq+HOeboeYHFh4fRd6K8efs9
	 j+W0YuJSfea1vRMzA9qwRt5x6CxWAJBjzA8+TUsL6dpDLMXqBwruJNmxreRCKgamwx
	 AQoVhh7levxFg57X6vsH5SHquop0KsVNDCjbkLfOfBdNlfEuTNqMK61iHVx+I+j0vK
	 oiM3duqt4j4PTcWcPJe3hlO17fP7C93wEh0ZcncMx46hvbndTanTTUBCpOZPDjvqwg
	 I+/Mai+IFyOnQ==
Date: Fri, 1 Nov 2024 15:02:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: Mark iio_dev::priv member with __private
Message-ID: <20241101150256.19f542f3@jic23-huawei>
In-Reply-To: <20241101105342.3645018-1-andriy.shevchenko@linux.intel.com>
References: <20241101105342.3645018-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 12:53:42 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The member is not supposed to be accessed directly, mark it with
> __private to catch the misuses up.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Makes sense.  Applied and pushed out as testing for all the normal reasons.


Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  include/linux/iio/iio.h         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6a6568d4a2cb..4c543490e56c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1665,7 +1665,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	indio_dev = &iio_dev_opaque->indio_dev;
>  
>  	if (sizeof_priv)
> -		indio_dev->priv = (char *)iio_dev_opaque +
> +		ACCESS_PRIVATE(indio_dev, priv) = (char *)iio_dev_opaque +
>  			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
>  
>  	indio_dev->dev.parent = parent;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 445d6666a291..5c6682bd4cb9 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -624,7 +624,7 @@ struct iio_dev {
>  	const struct iio_info		*info;
>  	const struct iio_buffer_setup_ops	*setup_ops;
>  
> -	void				*priv;
> +	void				*priv __private;
>  };
>  
>  int iio_device_id(struct iio_dev *indio_dev);
> @@ -785,7 +785,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
>  /* The information at the returned address is guaranteed to be cacheline aligned */
>  static inline void *iio_priv(const struct iio_dev *indio_dev)
>  {
> -	return indio_dev->priv;
> +	return ACCESS_PRIVATE(indio_dev, priv);
>  }
>  
>  void iio_device_free(struct iio_dev *indio_dev);


