Return-Path: <linux-iio+bounces-22744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6092B27037
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 22:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12C35E71FD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 20:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311042417D1;
	Thu, 14 Aug 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/v/UMPO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A32431984B
	for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203589; cv=none; b=aHmwH9RJPt3u/P0XtJFVEuM0/KEVW/ZmT2BPtYTPVDcRuPePuyPo0AvpyEzeh56ESymQwNixmhKg3jGpfU2pRGGR7arpS/dY43iUHvVI+RamlMPMn5me33e63iLPSDmMs7ye+MUBQTMz5xtzbISJcYJIXNy3G2BLhGBOnfOk74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203589; c=relaxed/simple;
	bh=QpK9ppLx/T7Yns3RR/9cGSPnxmMeDYeVxuRSJ6Ozl6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rINxOdEFgRlD/4Y+uOTQA+5NDqeAOHVEFJjo4tiG5nEcY12FSiT6J66eHtGif9vBRaIziSZFFnzmfPcHScIwmlg9ZZw4cmyn8YnhO9Y+mhhhiELmQ+ojWYhGxoFDN2MTRkRI7NcCuf7NCDvfooLRGk6VHo77KKmbGNCSVq3JbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E/v/UMPO; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce50b75aso855761fac.0
        for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755203586; x=1755808386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acJtPZQbHmSrsmTGtW3hW5dg2aOk8MGpzjwaGK6v6Po=;
        b=E/v/UMPOaqztexcUEtNT0oVokv4C8C1c6pX2+Ex1NN6xjAriQvrFEczvj/BplLuCRs
         jNDifam/jGUOGHj1hbiJQ6A2K3qLVsEyqQ/cwA8uHNJPAqIdiOjz/cdajh0fozSbvCoa
         WOSrpUuRyqQVcx6Z9B62QBKJ0WltdKJ++47N+KbyQQV/2f4+3ZVWUGTfvH/b7JC1D4BP
         HWoCYkHiMpuSY/xXgoGfZFZs9Ks3BJQcJJEvPRcp8lockwQn7MyTyRm3u3NTk37TAJKT
         Vskq8nc8oZobgcCSraAvis9xW502IsacZBDu9vwu/V9egYvn8HEVMZnyzsFncYnjxjn6
         5Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203586; x=1755808386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acJtPZQbHmSrsmTGtW3hW5dg2aOk8MGpzjwaGK6v6Po=;
        b=c407061m8jOql3oEb6RVSS18JmgH2C0qjhNJDXEQ2X6BF8f1LwALGr16ZsiNk7vLOm
         fsEDUpbKeT3R4GEpsLYklPbyk1QkpY16Bz23ZCAxIm2jIjMjWDtDxjLxZwsRITYVH/7J
         gkxeythuvalzcO/eCyBUGajnVW754ROg6jrZSQy1G1fW/DR0f5HfuzdPot3iwcR9UXJQ
         O02MffokhuG6XNwk1uZa0+pMr5vd8x0C5oaLOv8OwGoi8bm/UUSyTr0nAwVbr79kiTWJ
         G6u29LREG/EJbawFHu33hKhhl9HS+J2ZcfPnxLlfdkTZ3slT0+dynTFckXV+58KD9rk6
         27Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXU7Pf8Fz0T5F43dJtbiCfbD81nxdUz0GiGkvpKo3IUIpTVmdJHc8EoY4bDBnWjFn3/LkfM8T6Sf0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLkN7nhijsR85kxH+JoGbDXKYHY4PFUrzNYoQt/PfNnPZf9dx
	PnxhwLGpFWp2E7+c7eyZnf+0Vln1XOITOP8kmgor+5tsYmG7oqtaigPu0BaN1aoT8tYSajibzgy
	GPKE7
X-Gm-Gg: ASbGncs16upsJMm7n19TbIZHEeJlqkxvVRVfwEBybls5aaRQPjJgj5plmziYuJfGWCl
	S7wDEEtX+fFT0MekDJDUxGAcBsNevhTiS5VolxJnHN4uL/7ak382VcYWUjg7Sbg802slu5rFtWn
	BsymoR6l0PYg4A0njsTGyhdkYdYjuU+43f0hcquISG2IlC6qe4hMnPUr4CQ+2L2BNo/dCMk2VAN
	2XgMDWWXegcDi/mj+f6xo+NlOjb028llZRCGqmJbl8evSjEEvVCrp1C6Q5V27zHT0jPSIeoNqtd
	T4EB22UjvvtIBjdvMAotVAfyxRE3Ns6j3eoBwHgGrbeotrIkegpoQsdXrsa66sWo/BsyXOjwLmk
	wf9J3Nk9Xy9Ag3kW0ZMHgV32jZ+/f5dNiIFEjwu3SbhwsRcVW8TW4ArtffhP3Ob71/8ARhYJ02X
	w=
X-Google-Smtp-Source: AGHT+IGvcqG+ZYqhL0kXfFsXjlH+JBXcMZhwcTVtYN1yoHhGeAZzerX7F81HDOq+IvqLKMnrmtZSeg==
X-Received: by 2002:a05:6870:9726:b0:30c:99ff:730a with SMTP id 586e51a60fabf-30cd12cabb4mr3285308fac.23.1755203586029;
        Thu, 14 Aug 2025 13:33:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ccfe5491asm909695fac.8.2025.08.14.13.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:33:05 -0700 (PDT)
Message-ID: <c225eb3a-c595-465d-9fb2-8fc2a885d99c@baylibre.com>
Date: Thu, 14 Aug 2025 15:33:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] iio: Improve iio_read_channel_processed_scale()
 precision
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
References: <20250811155453.31525-1-hansg@kernel.org>
 <20250811155453.31525-5-hansg@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250811155453.31525-5-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 10:54 AM, Hans de Goede wrote:
> Before this change iio_read_channel_processed_scale() always assumes that
> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
> IIO_VAL_INT on success.
> 
> Ignoring any fractional values from drivers which return
> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
> might become non fractional after scaling so these should be taken into
> account for better precision.
> 
> Use the new iio_multiply_value() helper to do proper scaling taking
> the fractionional values into account.
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
> Changes in v4:
> - Use the new iio_multiply_value() helper
> ---
>  drivers/iio/inkern.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index af1da729d18e..2a1ecef2b820 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -722,20 +722,19 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  				     unsigned int scale)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
> -	int ret;
> +	int ret, val2;
>  
>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>  	if (!chan->indio_dev->info)
>  		return -ENODEV;
>  
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
> -		ret = iio_channel_read(chan, val, NULL,
> +		ret = iio_channel_read(chan, val, &val2,
>  				       IIO_CHAN_INFO_PROCESSED);
>  		if (ret < 0)
>  			return ret;
> -		*val *= scale;
>  
> -		return ret;
> +		return iio_multiply_value(val, scale, ret, *val, val2);

Passing val to iio_multiply_value() as 2 different args is a bit
confusing.

I would add one more local variable for the processes val. e.g.

int ret, pval, pval2;


>  	} else {
>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)


