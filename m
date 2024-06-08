Return-Path: <linux-iio+bounces-6044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24352900FAE
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 07:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E66B1C20B6B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 05:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0017625B;
	Sat,  8 Jun 2024 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuRpCv7l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8B610C
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717824479; cv=none; b=sfaKiAbN65uOi/9dPaIBvPdL24CeRz0scZae0VujIsaiCmnshNhACT1jU61H7M+/vPVM9gQvIK1Bqb/velK0Xzc1SUc2QWWskhNKs3hnK8v6jw5NopUkQLaPmEEmX9iSuIzaNbxBn4Z5xZznZiaWZ77k/7n7nlVPfVRcwuC0SgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717824479; c=relaxed/simple;
	bh=9AwqcM0OxS8cPtNMvlYP62u3carHEGr7SyDrZvCtbEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xas20NVVp12ZSu8T+ySc4JwYzhtBhw/7RB5c/AnpquTvK6r542YFjpxMNEuNmNJ57nM8Uz5FtXy2CrWuUkve1CaOq6LKApBDlZ0p+LC1HC/mNg0bX7YHy02jH4FOEFHGtOTeGmsZd0f0v3CBTC2Jx9CntUAyfk5gvHogasTI5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuRpCv7l; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so154125a12.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2024 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717824477; x=1718429277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYLY/SM4qmTVYW8DlOTsPvEcySzQSLZ+Ut4vN8TFHos=;
        b=ZuRpCv7lHorRNqulpHqkLYEeVbM/S4yBDh0evlH/4MLYX9a+Gh4fiWURko1hb6ImCO
         klCRwLdPFT7YPlkn15ua4rK+S7l2ftcQIL+qT6joj0LB5r3DMet5UBCZ2rl+XH9dTVxx
         Cxz/nFyIGlOeMBuPg507uCI6m6jYwN/SemRh1cIscVb16aqShh6cs83KOcgIYZ8uwdRW
         ePCU1uGtZxIRUN5KVebwT4xzv9ESfLTMuquBa8uiY4xYAI4pF6lewtKD0eAYZ5LWvZ50
         3GRMT8cxnTXxMqyzWTeMx1u7oNvmy7BDdmVAH50ZUdDQ+4KwKZUUqSnHaa734V0mMNwe
         DhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717824477; x=1718429277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYLY/SM4qmTVYW8DlOTsPvEcySzQSLZ+Ut4vN8TFHos=;
        b=hab4juWn+cdDRoCggekHfDFPU8UIwQbqN/rikEcz7HdmFQWUqaixUJND8obBKOIwGH
         pPMfq+8S4hvYF5LijitWBq9p0+NG5uvxqdM/5JaZxTvkX52pgMTbtxpdEd4zY7lCqX5v
         7uSeI/VQSKGKQ9q0um/B4beejrTk39oNXK8Wm1Rj3nlDcO9r/C4RK803jn7StQnMUwjP
         Sbu6CVt+QEej4gqHzl/AhVqJrwcRQet67u+auUFQ6jWEWbl08Y0a4B7QgrUfgqNBRmY7
         E9Hl6/ZNHVz2LCA+BhKxNX/h+lNjqHvjdDLtlRSw9EF4tEHlrFW38eH6cuIeCZQmrGaG
         Co8g==
X-Gm-Message-State: AOJu0YzAronHTYWPGAvyTsWbClYv8PZ7jJiRhlxiGd8p5FRxI60JktpS
	YVs6nlS3T3GWSAsg/dsWDID7LhBHk8pVdkutmc4nmNMq2UNrh/ml
X-Google-Smtp-Source: AGHT+IEdcxf0w9GcCw4k/xcoRv+msPJm6dg91axPNyv3IuumHFdxtXqAjPOW1Z4uNRWIRitZ8nrgGA==
X-Received: by 2002:a05:6a20:918f:b0:1af:cf63:3742 with SMTP id adf61e73a8af0-1b2f9cb14e6mr4774837637.42.1717824476782;
        Fri, 07 Jun 2024 22:27:56 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f298102bsm3601215ad.73.2024.06.07.22.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 22:27:56 -0700 (PDT)
Date: Sat, 8 Jun 2024 02:29:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2 3/3] iio: adc: ad7266: Fix codestyle error
Message-ID: <ZmPsJH8k9ta100Ss@debian-BULLSEYE-live-builder-AMD64>
References: <20240508155435.183850-1-hagisf@usp.br>
 <20240603180757.8560-1-hagisf@usp.br>
 <20240603180757.8560-3-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603180757.8560-3-hagisf@usp.br>

Looks good.
One minor neat being the last change won't be needed after patch 2 is updated.

Also, I think it will help visualize the patch series if a cover letter is added.
If running format-patch, the --cover-letter should help with it. e.g.
git format-patch -v3 --thread=shallow --cover-letter --to="..." --cc="..." -3

On 06/03, Fernando Yang wrote:
> Fix some codestyle errors indicated by checkpatch.pl
> 
> Signed-off-by: Fernando Yang <hagisf@usp.br>
> ---
>  drivers/iio/adc/ad7266.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 356c2fe07..5a2f1bb27 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -63,12 +63,14 @@ static int ad7266_powerdown(struct ad7266_state *st)
>  static int ad7266_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_wakeup(st);
>  }
>  
>  static int ad7266_postdisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> +
>  	return ad7266_powerdown(st);
>  }
>  
> @@ -153,7 +155,7 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>  			ret = ad7266_read_single(st, val, chan->address);
This is not needed as comment on patch 2.
> -			
> +
>  			if (ret < 0)
>  				return ret;
>  			*val = (*val >> 2) & 0xfff;
> -- 
> 2.34.1
> 
> 

