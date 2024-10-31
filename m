Return-Path: <linux-iio+bounces-11726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38D9B8588
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349141F25455
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3001CEADC;
	Thu, 31 Oct 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIHKEIaG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE31CEAB4;
	Thu, 31 Oct 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410951; cv=none; b=YV/6+toHkzsPTUK/hbgSRXccmS0W4FLuMAEGdT0ulRVr7WKQAQNH7SO7JLvMByweF5sioGP0WJtvlGZ4hvug0yzleoQOiB3bA6kkMCISmc9KbIOB0107giKLvxnKKHLeBch2HlYjF2/I7acDTkb0oW9RmV9q9ef50pa9r7XWuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410951; c=relaxed/simple;
	bh=M/nJ2l0fqJaVV84y2igSDBRemZ3z7pqu1T4s5N9kYyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnbD3EOpuXWVhT8TGe+YoXh0cd8v9RXcWiFHqEJ/J+mC5n+OHZTCNEmVpaccOs8w8WaFu4PGULTiIJNrbEXmNb5ieQtjqsglUQsPlv2Rhe38NAY9mLsognS/YQFmYTas+HjI5YJ2bbzrjIwmqH3Y1PmM7v7mMK6JBwO3+1pU69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIHKEIaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E16C4CEC3;
	Thu, 31 Oct 2024 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730410951;
	bh=M/nJ2l0fqJaVV84y2igSDBRemZ3z7pqu1T4s5N9kYyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HIHKEIaG/N0k6BXnazG/NnR/G5+pbbbJAblF18UwoZHtODC8jDaPIwzAqOnoWFLXu
	 Y1IT+tPcnRfBez/Y4MOhGqpdCowj3ctmdeH9EJBuLhQWyrflE8uoMKOnCNLya48j54
	 9hUVy5CD5gMqxJ3oQ4gnk/tLw3aH0MdAkN6WS/aUHusFu9FJkjWN+aMfo6LGNefXps
	 mNluhUIKsi52Y2Y2dG0tft/ePlhVH8M4FMGtVgTXfgSWXiodG+MLjvUq9mNAon7SDa
	 HCfE9+g3bmKjLvxv1/y7UTlqD+HIN3defDA4dmlKHv2BPEvHqA7zvmtYz0HJ/gVXTw
	 UfiudqkvgjjUA==
Date: Thu, 31 Oct 2024 21:42:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4000: fix reading unsigned data
Message-ID: <20241031214226.47043d3f@jic23-huawei>
In-Reply-To: <20241030-iio-adc-ad4000-fix-reading-unsigned-data-v1-1-2e28dd75fe29@baylibre.com>
References: <20241030-iio-adc-ad4000-fix-reading-unsigned-data-v1-1-2e28dd75fe29@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 16:09:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix reading unsigned data from the AD4000 ADC via the _raw sysfs
> attribute by ensuring that *val is set before returning from
> ad4000_single_conversion(). This was not being set in any code path
> and was causing the attribute to return a random value.
> 
> Fixes: 938fd562b974 ("iio: adc: Add support for AD4000")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
> ---
> FYI, there is also another unrelated bug I noticed but didn't fix.
> 
> We are calling iio_push_to_buffers_with_timestamp() but there isn't
> actually a IIO_CHAN_SOFT_TIMESTAMP() channel. I assume the intention
> was to have the timestamp channel?

Technically harmless as it can never be turned on, but indeed seems
doubtful - maybe something to treat as a feature rather than a fix though
given it was never there.

> ---
>  drivers/iio/adc/ad4000.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 6ea491245084..fc9c9807f89d 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -344,6 +344,8 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
>  
>  	if (chan->scan_type.sign == 's')
>  		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
> +	else
> +		*val = sample;
>  
>  	return IIO_VAL_INT;
>  }
> 
> ---
> base-commit: fa4076314480bcb2bb32051027735b1cde07eea2
> change-id: 20241030-iio-adc-ad4000-fix-reading-unsigned-data-88a1de88cf57
> 
> Best regards,


