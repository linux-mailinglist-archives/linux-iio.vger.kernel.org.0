Return-Path: <linux-iio+bounces-10250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0AD991EC7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 16:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D60282537
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293849625;
	Sun,  6 Oct 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDh93Va/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E160BE6C;
	Sun,  6 Oct 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728224301; cv=none; b=T472JhidskYRfgP7mvc/HDC6EPMXAJ0C8VZxEXqlFvbgvELH6wb+66nSlhui8avgVzXgajBzMNtrd4l/siDO9de4cU52OtmOs+GBjcesOnKcQPzJQjGxZdHLDzVD8fwU+ByNbkoVh6/1tYduBMscsTf3G9ynd0FLG1W7KXltmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728224301; c=relaxed/simple;
	bh=E8zE0FPsM+NzL95TqGQap5qX0jjVRpxwP9HfacedVHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHpTcw1zOd10m7gWLyvYEv/JdOod8SyFjNFZvGgQlKeSpxsihU78NnEE8atyc5qVAytYV5CZ+Kmth4uq+x8DGjRFo8i5lSDBN0TQFlLtDW/tTFw93dg31k3WWOdx1BOEoX0/91E/sxXQN7KL3olg3cyoc6hB8vstc0/YNHP2yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDh93Va/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA9FC4CEC5;
	Sun,  6 Oct 2024 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728224299;
	bh=E8zE0FPsM+NzL95TqGQap5qX0jjVRpxwP9HfacedVHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDh93Va/uuUFTCyNQX2nqRgg4FYnJRThIyMxO1hQRC7ZogUl0PNDI7Dh1bjlhO64K
	 wCDC1kYCle7KZrj50znm5xcbUTgzb1piH9WjRoj37UFFb5i+JLwAwODcJfLSn6bSj0
	 7Ho+lrhbHdTVGFsbM1bz6C1CjUI9L/VMahBmmSQDyfi/kzidZNaQUHZGrvch0I03Jf
	 2+OTnym5wCqNrFMlglRaXBDGiuw3oFFj8bB6pjxRyjVyc7knc5tVuO1ETEknCUq9zH
	 cWyInpnjWkX+EUaqAiEKIog7uQaIXp0LrYG66TfkdypoWKfMdDpk1SkdPMylCvhtQr
	 hCkuF02Y1+jEQ==
Date: Sun, 6 Oct 2024 15:18:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: as73211: copy/release available integration
 times to fix race
Message-ID: <20241006151808.1310db7d@jic23-huawei>
In-Reply-To: <20241003-iio-read-avail-release-v1-4-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
	<20241003-iio-read-avail-release-v1-4-c70cc7d9c2e0@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:34:09 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> While available integration times are being printed to sysfs by iio core
> (iio_read_channel_info_avail), the sampling frequency might be changed.
> This could cause the buffer shared with iio core to be corrupted. To
> prevent it, make a copy of the integration times buffer and free it in
> the read_avail_release_resource callback.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index be0068081ebbbb37fdfb252b67a77b302ff725f6..520c898e0ff9c530b4fdd45589559f9014d7992c 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -493,17 +493,33 @@ static int as73211_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec co
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  
> -	case IIO_CHAN_INFO_INT_TIME:
> +	case IIO_CHAN_INFO_INT_TIME: {
>  		*length = ARRAY_SIZE(data->int_time_avail);
> -		*vals = data->int_time_avail;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
> -		return IIO_AVAIL_LIST;
>  
> +		guard(mutex)(&data->mutex);
> +
> +		*vals = kmemdup_array(data->int_time_avail, *length,
> +				      sizeof(int), GFP_KERNEL);
> +		if (!*vals)
> +			return -ENOMEM;
> +
> +		return IIO_AVAIL_LIST;
> +	}
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static void as73211_read_avail_release_res(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   const int *vals, long mask)
> +{
> +	if (mask == IIO_CHAN_INFO_INT_TIME)
> +		kfree(vals);
> +}
> +
Trivial but one blank line is enough.  If there is no other feedback on the
series I can tidy this up whilst applying.

> +
>  static int _as73211_write_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan __always_unused,
>  			       int val, int val2, long mask)
> @@ -699,6 +715,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
>  static const struct iio_info as73211_info = {
>  	.read_raw = as73211_read_raw,
>  	.read_avail = as73211_read_avail,
> +	.read_avail_release_resource = as73211_read_avail_release_res,
>  	.write_raw = as73211_write_raw,
>  };
>  
> 


