Return-Path: <linux-iio+bounces-13675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1049F8252
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A9C167E54
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35A19CD07;
	Thu, 19 Dec 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxZ3sbz+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6E1A0BF2;
	Thu, 19 Dec 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630095; cv=none; b=jE92u+VoOPIUJFIJowAdMD1jjwjmZUnnLfvis0wl1VEW92YVnmBq1Aicb8IkO/KRnW1DwjJNUZQB2nMmutC9CSvgUjPis8dVGAJ/jH3bFRDINBtygw4SuHHUEEarHlonslwwYUU8az5KXQRcHkRd8TGYz1zcDE8XT9qTIe2kK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630095; c=relaxed/simple;
	bh=+VPcmkh5U0In89UK8H1fXfUKHxHILa3R6gwrx5c/CS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROwcuZCiHaUnIK2CnnBpT6J+co094AND35cGsRfa+BB7kTFP9QFDRClLxYKm2/32ATicLuWKtziMHFUiTlzs3hjjSi3IYpgrZ3DrYvwNHs49pTlcdFIXW+4SqXtpIs7kx2pTf/6FonSrWgk1EulF0OTGYHbntfN6C54IWe+0BgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxZ3sbz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A944C4CECE;
	Thu, 19 Dec 2024 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630094;
	bh=+VPcmkh5U0In89UK8H1fXfUKHxHILa3R6gwrx5c/CS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxZ3sbz+D6f3hJeEZ3jlH8PX+d7f09M/VyHcWNHH7z/OPh5Hkhi1v7WJkT+DtKWjh
	 8Sm8sq7M7OppkG1MMzITMMFS1Di9Q8M/errJrw5AFJ6QH/IWkH99YMbY7MhPczBSu5
	 JPWg0Zgua359dRRB726a58xBQR3eu2+W0d1oJeOgpNNul4W9KqWODkD4OtyDFDi/ul
	 4iECrbhyGhUM1zdC8db0clA7OWpymYqMPNum8Mki2+P7LM2Qs7K9tAy1lsTZUwcKFg
	 YT5InTphQHwwo47ZwfXOIAGg5i/dhesrYLKnHXPW77nuTO0oeHrcRezZtbdVQq1xU9
	 c+4DSc6lGGIxQ==
Date: Thu, 19 Dec 2024 17:41:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, jackoalan@gmail.com,
 k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: adc: dln2-adc: zero full struct instead of
 just the padding
Message-ID: <20241219174125.1a75a429@jic23-huawei>
In-Reply-To: <20241214191421.94172-2-vassilisamir@gmail.com>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
	<20241214191421.94172-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 20:14:18 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Drop a minor optimization of zeroing the padding between data and
> timestamp and zero the whole structure. This is done in favor of
> simpler code, and in order to drop the usage of the internal private
> variable "scan_timestamp" of the struct iio_dev.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/adc/dln2-adc.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 30328626d9be..221a5fdc1eaa 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -66,8 +66,6 @@ struct dln2_adc {
>  	/* Demux table */
>  	unsigned int demux_count;
>  	struct dln2_adc_demux_table demux[DLN2_ADC_MAX_CHANNELS];
> -	/* Precomputed timestamp padding offset and length */
> -	unsigned int ts_pad_offset, ts_pad_length;
>  };
>  
>  struct dln2_adc_port_chan {
> @@ -111,8 +109,6 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
>  	if (iio_get_masklength(indio_dev) &&
>  	    (*indio_dev->active_scan_mask & 0xff) == 0xff) {
>  		dln2_adc_add_demux(dln2, 0, 0, 16);
> -		dln2->ts_pad_offset = 0;
> -		dln2->ts_pad_length = 0;
>  		return;
>  	}
>  
> @@ -127,16 +123,6 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
>  		out_loc += 2;
>  		in_loc += 2;
>  	}
> -
> -	if (indio_dev->scan_timestamp) {
> -		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
> -
> -		dln2->ts_pad_offset = out_loc;
> -		dln2->ts_pad_length = ts_offset * sizeof(int64_t) - out_loc;
> -	} else {
> -		dln2->ts_pad_offset = 0;
> -		dln2->ts_pad_length = 0;
> -	}
>  }
>  
>  static int dln2_adc_get_chan_count(struct dln2_adc *dln2)
> @@ -494,6 +480,8 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>  	if (ret < 0)
>  		goto done;
>  
> +	memset(&data, 0, sizeof(data));
> +
>  	/* Demux operation */
>  	for (i = 0; i < dln2->demux_count; ++i) {
>  		t = &dln2->demux[i];
> @@ -501,11 +489,6 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>  		       (void *)dev_data.values + t->from, t->length);
>  	}
>  
> -	/* Zero padding space between values and timestamp */
> -	if (dln2->ts_pad_length)
> -		memset((void *)data.values + dln2->ts_pad_offset,
> -		       0, dln2->ts_pad_length);
> -
>  	iio_push_to_buffers_with_timestamp(indio_dev, &data,
>  					   iio_get_time_ns(indio_dev));
>  


