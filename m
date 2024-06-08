Return-Path: <linux-iio+bounces-6043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ACB900FA9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 07:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801C61C21566
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 05:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C31581E4;
	Sat,  8 Jun 2024 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EssJnPTo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC2610C
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 05:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717823995; cv=none; b=FAxZyQWx2Lbt2uPh3BME9BZFHs+I2CY6p2cWs7it9wbzS+K411BEWW5raqWEgHprpIPO/KsCoFQkD42rrU4g8k2/ryVaCAYlSWKKbp1R3npK6xxlqsl/7wnSjzCPSHnygqssh0TZ839m63s7rZzsX+ZyOwzoSNOsi823NSkNXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717823995; c=relaxed/simple;
	bh=8aUpZnH+ubhhleujEJoZv296qv8+ZWLrcT4lPZ/0LD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPPEV6x508Pq/R33gkyFAvhWQisMngTC5ZVzrR8oqzIh2SgqUm6cQ6ImuyHhwolSjsWgwp12ZTxX71BrBuCyBBJjSSVnFa1LSA0K3mF62ozaIVu9zQgX9ncNdlYFwu2j4mEZj7mNsaTn05UT48azFsSnadTtvz/KlV0lGudCC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EssJnPTo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f67fa9cd73so28147625ad.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2024 22:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717823994; x=1718428794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z/TA7keNDK90gOx0DKL+0qYyVr2XTB8dx+AVH5+IuEw=;
        b=EssJnPTo7a17GFW1JLX/yrAN1bpn1gcJ06z3YkDzZfNq4W10Sg+Ex3jIj+b22/bAfI
         v+U7hzBwaNKE6UFkleno1TN9EpduZ3Mk03WZ3mhgGB6/r6PthamkyHBIgC74G9PoO7Bl
         q2MB5dhhCnTHse1h9/GdU89TtD/noRVcp1S3TqPA7mtOL18ExPuVAsDDz04Ot3ZjBEbI
         bapNx1YJEQpJvacHrQh9wZEn4wtdUgyBCwo85O3zjWw8mVe7KdgMfD+d/ZSbvukLs91G
         w0lXuleTiN8Ob6ec781U1OOEVfAYFwamHVevXHT11Ctx1HjjE2zEYNXiMN5xmnAnvSiG
         74rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717823994; x=1718428794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/TA7keNDK90gOx0DKL+0qYyVr2XTB8dx+AVH5+IuEw=;
        b=k0Jx+9GpaBR6gnwepzz/cyVNcJJldGrOzrjubgQCDdcifYkZUBG2HCQst7S52etlk4
         vMxe1GhOOh2m1Af5nTdZMoQKvItRZCIkBF4q4p25XxIBHA45Q2c9V1N3iHnR7tDOt74f
         iWSDrkfT0qs/Mi5LnkLyafczrYK2be/J5cd3KhfHLlUtJ8Zqb4z5SCv4vCC8UmL0db20
         Cck+w5DB/9J4OiDzMFDppUMnzG6W3Bee65l5W+KdJi1H/hrEfO++xmoTQsIPn0eh4h4r
         T3rLoDsVAcihSavLfMca95P+jrOFxYvRVbQLExSrcyS5NRnXpsw/TzAPSBJhQW1u5Tdg
         oJzw==
X-Gm-Message-State: AOJu0YwBbKi+L9jJqAx+cJvkd6gAy8N4tEVtg8tOv7+cyM3/PgmPhWRQ
	joBRuAEEjHkYIkwpo/pz8JG4QuJFM/DGAOqLGlcpyZLlRSKxvEsQ
X-Google-Smtp-Source: AGHT+IGZsUhWaxcbgpEVWpXxEL/7txoU6faJFjlPIeu+/K6GDP1B7oF0ynvBYlvBvXKzpsQ4iAmzMA==
X-Received: by 2002:a17:902:d2d2:b0:1f6:6c39:9714 with SMTP id d9443c01a7336-1f6b8f08786mr105645245ad.21.1717823993631;
        Fri, 07 Jun 2024 22:19:53 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f7e7sm43366025ad.38.2024.06.07.22.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 22:19:52 -0700 (PDT)
Date: Sat, 8 Jun 2024 02:21:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2 2/3] iio: adc: ad7266: Use
 iio_device_claim_direct_scoped()
Message-ID: <ZmPqQwqYjU9oWQXh@debian-BULLSEYE-live-builder-AMD64>
References: <20240508155435.183850-1-hagisf@usp.br>
 <20240603180757.8560-1-hagisf@usp.br>
 <20240603180757.8560-2-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603180757.8560-2-hagisf@usp.br>

Looks good overall, but a couple of untidy bits slipped through into the patch.

On 06/03, Fernando Yang wrote:
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
The line right bellow adds 3 tabs. Don't add them so no need to remove them in patch 3. ;)
> +			
> +			if (ret < 0)
> +				return ret;
> +			*val = (*val >> 2) & 0xfff;
> +			if (chan->scan_type.sign == 's')
Keep chan aligned to *val
> +				*val = sign_extend32(*val,
> +							 chan->scan_type.realbits - 1);

				*val = sign_extend32(*val,
						     chan->scan_type.realbits - 1);

> +
> +			return IIO_VAL_INT;
> +		}
> +		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_mv = st->vref_mv;
>  		if (st->mode == AD7266_MODE_DIFF)
> -- 
> 2.34.1
> 
> 

