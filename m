Return-Path: <linux-iio+bounces-6287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D899097CB
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA46D1F224A5
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BD3AC0F;
	Sat, 15 Jun 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1QPW/hs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEB3A8F0
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448969; cv=none; b=KqJqC8DgMcZ6GqaBTLLlBRINTt5SIwomXVw6Zt1oFGi0tWJjZFEFgswxzxyTIkxQqxOKt0aLnaqP0BzpXCKU7+n6NVbhZenqTPpTsws+C9gJZyFtxm+zEoOnYR9DgcAlrQ2EdOH6HeHmurshor8tWH1uzWf70V0nmMPpulMjV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448969; c=relaxed/simple;
	bh=ogCqazf5wmGdNHXWx7YfN319aK99bQKpmDEm1Zqwwto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVUwZmX8MJJcZQa4ZsatG7oghD9HzI0hVSsS8t4eM3Nrra8xeTUIGZRBf4NjIEpkSGn7W2WtuN44LkBUnRU8hlDJqtwPtdr90OFwI2OBAsZ1Cwj87tgkSrtNVG5XLISP+Q0ruyFE7kanwTR3Io7IIfpiFld1wUh4u3ZG2HS7rYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1QPW/hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71261C116B1;
	Sat, 15 Jun 2024 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718448968;
	bh=ogCqazf5wmGdNHXWx7YfN319aK99bQKpmDEm1Zqwwto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1QPW/hsJIzI5CNKtapyieyQKHppaym1ZmL56rUpFwtJB2HSe/y+aCwPVr44ZFwAV
	 Vp9tob48AxlmJntV7qeaUd83/JY+e14U6lXCf66ZemjPCnVa0dq6kG1NEE7XaLZkSM
	 +qWtZdG8U+l4QrHzPJd41qn+7xv6PyV3Vl7R0nqtYzvKbHymLhkn4kC5SpRUx6bRBw
	 4AqBVvOYOqav7HDCOITsWXW7EY+TIB/eCZZ/el/ceZx0B0eG7fYlkGI/MJehOq1fBn
	 pESLAdx1wZmmodHpchp30YKk7Tq/xDXWhMUwWsSEBsG1B5n60InWiXWVjib1UYvEXh
	 /p/nUKNHajdGQ==
Date: Sat, 15 Jun 2024 11:56:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Eduardo Figueredo
 <eduardofp@usp.br>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: ad7266: Use
 iio_device_claim_direct_scoped()
Message-ID: <20240615115604.26789693@jic23-huawei>
In-Reply-To: <20240613153920.14647-3-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
	<20240613153920.14647-3-hagisf@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 12:39:19 -0300
Fernando Yang <hagisf@usp.br> wrote:

> Switching to the _scoped() version can make the error handling more
> natural instead of delayed until direct mode was released.
> 
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 13ea8a107..356c2fe07 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -151,20 +151,19 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> -		ret = ad7266_read_single(st, val, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> -
> -		if (ret < 0)
> -			return ret;
> -		*val = (*val >> 2) & 0xfff;
> -		if (chan->scan_type.sign == 's')
> -			*val = sign_extend32(*val,
> -					     chan->scan_type.realbits - 1);
> -
> -		return IIO_VAL_INT;
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = ad7266_read_single(st, val, chan->address);
> +			
Seems to be some stray white space (tabs) on the line above.
Make sure to run checkpatch.pl.

Also reformat this to bring call and error condition together.
		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
			ret = ad7266_read_single(st, val, chan->address);
			if (ret < 0)
				return ret;

			*val = ...

> +			if (ret < 0)
> +				return ret;
> +			*val = (*val >> 2) & 0xfff;
> +			if (chan->scan_type.sign == 's')
> +				*val = sign_extend32(*val,
> +							 chan->scan_type.realbits - 1);
> +
This doesn't look like a correct indent.  Align c with * as done in the original code
> +			return IIO_VAL_INT;
> +		}
> +		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_mv = st->vref_mv;
>  		if (st->mode == AD7266_MODE_DIFF)


