Return-Path: <linux-iio+bounces-4791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DE68BBAC7
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253ED1F21F80
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAAC1CA92;
	Sat,  4 May 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8BA+E1v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD885221;
	Sat,  4 May 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822493; cv=none; b=IzQ12UQzNiFefbx5Au2F43SrnV+49rdagy0CFkKpXiRoN9e5oU5Gl1AhmTq4mawJWVBdNpK2XAQKAncG+P2NbI+ksBXHG+0iLj5kUnRKUZkAaByG+f8WO1bh27WDXkZmCVTmYmUS77n8qWM5WtkNtqVme4LMciqnT9lULZy4k1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822493; c=relaxed/simple;
	bh=FlpsDRxldopXY85FL3/6FIZP+C4/Fxw8QNBA9w3ZcjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOBdK63CQxlUvosmdkAzN3R8foEa8X5m3jJc2fAQgBkEhd8kxMyM2D/eNQx+Wzzl6Q9x0CsuVsqcOHmOrw4JxMPsvwwPF/bDLJ209v8YcI7U1D/W4Vftax7FW/yopR26uDmUCVDj8A9tEAJyN5nwJSjrDEPmya1Gagnem/m/eO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8BA+E1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3B5C072AA;
	Sat,  4 May 2024 11:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822493;
	bh=FlpsDRxldopXY85FL3/6FIZP+C4/Fxw8QNBA9w3ZcjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8BA+E1vl7PCtvBJQGo/owDI1B7RHj3T8ZoLo30DaWF4fJg/CBcFG4Xfendc8klxg
	 VAYsXVZGQJV7bVdSZlBB2xGocrMZDS4muW1yKb/hmVgA4Q/lxk2jbk2x/B7h85pkXr
	 EO4omqJdyQnUDg2GehIDR+TDmtl6EZTGvTGQqzz7ODQW6dSEJLjj10WsOufgYxf7Tx
	 stpFDJMsnkHNAOnMPXmilJtUW7OARnQ/QhzM201ia4jLQ+s4vz+TVELSwlNTJiBTcP
	 KmYcN74l/VQdINU0o7mRdawWj75CrLberqlOjZ7R1ppzx/bGTlN5Q+YoEwx+YEpgu+
	 DDRYPu/AI80LA==
Date: Sat, 4 May 2024 12:34:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Harrisonn <jorge.harrisonn@usp.br>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, laisnuto@usp.br
Subject: Re: [PATCH 1/2] iio: adc: ad7606: using claim_direct_scoped for
 code simplification
Message-ID: <20240504123443.46949690@jic23-huawei>
In-Reply-To: <20240501215724.26655-2-jorge.harrisonn@usp.br>
References: <20240501215724.26655-1-jorge.harrisonn@usp.br>
	<20240501215724.26655-2-jorge.harrisonn@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 18:57:23 -0300
Jorge Harrisonn <jorge.harrisonn@usp.br> wrote:

> Using iio_device_claim_direct_scoped instead of calling `iio_device
> _claim_direct_modeand later callingiio_device_release_direct_mode`
> 
> This should make code cleaner and error handling easier
> 
> Co-authored-by: Lais Nuto <laisnuto@usp.br>
> Signed-off-by: Lais Nuto <laisnuto@usp.br>
> Signed-off-by: Jorge Harrisonn <jorge.harrisonn@usp.br>
> ---
>  drivers/iio/adc/ad7606.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 1928d9ae5bcf..fa989e0d7e70 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -174,17 +174,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> -
> -		ret = ad7606_scan_direct(indio_dev, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> -
> -		if (ret < 0)
> -			return ret;
> -		*val = (short)ret;
> -		return IIO_VAL_INT;
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = ad7606_scan_direct(indio_dev, chan->address);
> +			if (ret < 0) 

There is a stray space on the line above after the )

Make sure to run checkpatch.pl which should have caught this

> +				return ret;
> +			*val = (short) ret;

Not really part of your patch so I'll leave it alone, but that cast seems rather
pointless.

Applied to the togreg branch of iio.git and pushed out as testing with the
white space above fixed.   Note I'll be rebasing that tree after the
merge window so until then this will only be visible on the testing
branch.

Thanks,

Jonathan

> +			return IIO_VAL_INT;
> +		}
> +		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		if (st->sw_mode_en)
>  			ch = chan->address;


