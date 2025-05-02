Return-Path: <linux-iio+bounces-18996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7FAA74FC
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 16:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6239217D1D1
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F12566E6;
	Fri,  2 May 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk/y2DpQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED8254AFB;
	Fri,  2 May 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196161; cv=none; b=eIbDg52+47qlPy7SYDSHGO07echS8CLBGnwfgxHfn/Htbfj2c9Kmgt4x7Am5jvz9AIET/49RgaTqhfBlr+7e2mJwzaIjv6T3+2qnttWqEual1EtTtknlZC8ChMlXQ7VhG6xXkdGogOvcTPkkwDt3c/WiRZ5hCLane3DsnbgZ2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196161; c=relaxed/simple;
	bh=glgP2H8iltkXz/0itYKcwN3X2MmC22mzZto+Unw1AGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly9s3utAtXa8gd6A1UBxC2avSlhjXQMSTVHCmZ+u6ua62zLBgJCmUud77HbnlTsBnIkATo6PJFEuLPMWi8jg4a0Hh+wx4Z5mTzMF41XhSSmufUcsq8yizpoUmCiYL6AjTxX+vndWL76gXhrZTVWVECXjeG7H5KRMNBEdunlsXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk/y2DpQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso2837113a91.0;
        Fri, 02 May 2025 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746196157; x=1746800957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uv62vQqp6Wg2reIArK9ykz+gkyvcDoUeNoaYwXskcxk=;
        b=Zk/y2DpQ3084WO1fnma3F35iHrHxRUA4l8H+6zd1SGzujCppfg4xAL7jOOx3GcCVLh
         dfGfTbFi9KkM83m5+8YKG3tbBCb49ryfhlepuAvLnVfK0343cjPVek6VajLcb2VmSYi8
         yvQa4b0YCst1mjFwzr5j+3Nd1nTfo14MFg2JlJ+lCkXJ6DrNP08LXzqhbNURTQ1QNsqr
         qLtADPFlR2rJ6+NhFbTmbFVRJsw312oJeDr4r+X55C9Qdc8m+mQoDRKZUiPMHEGKm8Bv
         MM9PaEb5YSza6UbLqoHT7Dvdwq8Y3nhId+KENFhz0ZNUAQhXVTw337vovrfJ9rN9aCDZ
         eCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196157; x=1746800957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv62vQqp6Wg2reIArK9ykz+gkyvcDoUeNoaYwXskcxk=;
        b=obkj4Ig7C8V1TMeVv2pUHeKK4RZqbDdQ6MdyhzvlgaHg6VuJhgrkhtbP6sd3YyFyGh
         yJ3owsp4zL4emzqI2/5g3Fj5kS2oR3mZFCtm1fQv9/g2Om0bCKOijSzhkuDzq99+ZjGk
         5NlpFiktl+3evY0IgMS3wj4z8dNgBDJzlG3LVAx0fFRXrzu6KEfGIPHNs4YYkC0NXgyw
         xnlqtXyn7qMekCfWczuTpuJ4JkbE8O11ng3RRZ/x9f9raqzNZqw4IgQW9aMS76ljIoW7
         eX6lYD+hlKB/150mlXLT9VZzjdFtfsCDp5A6u5WFYKtynqp58w70SUKNZTTve7yrO/Ff
         PBKg==
X-Forwarded-Encrypted: i=1; AJvYcCUYnAKUODEfmAxPwyRs4KfErhebiky5dqPIxiGrUwnhT81vrTxd4DN5oSc/TodRx52bee3fDLhZV6vmXw==@vger.kernel.org, AJvYcCUut1lmQsUVK+fyiG7LNkl0E///WkEhvh9e5VsevGd/OyR09TY/xS1HVd3/dEc8vGUT50psIoaaqeYA@vger.kernel.org, AJvYcCX20ldXsh86z/Y58jTC+fXhYydEuqGhB80ACUxx21KI2tv2jqqGE5ykENgoHuCxecS57IZ/h7y4TxIbkz5j@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOG2tFPSnxKTioYLjABPqQFdwsCesGTMfrypoqt68xj9UPWYE
	OqO4eCBMpbKgk24jBfZshy/mlnSl3bNoPXNWoS5jIjsDiprhgZ9R
X-Gm-Gg: ASbGncsA/SrvWqIkjabaSS6pBEI2kOO3N/w092k6S8GmDd+cPy6tWUypRaYbnZgE3Aa
	ysTewtmXS7M3T9csaXg5YWlt3VRu0ibQDJW59LMTsE3tXNPauqmkwCRvtWtcLusECrxAFmIldh8
	/QCNtCzvQ1v0xmEKWBeXJSnGT7KrV90lIMhnKrmfeDFCyA1AErQzL3L6FMphEshjk2qBbkaOT2I
	PlutP+brzPfo4UFthmMfKsBnN9089HnUftwAKofE/ddGzEWwcMGGi+bSlDZsOXTKNcvTRcRTqUn
	jng3iq4/b4fCO12smArGpIvjat4dHSuAVTf3XHj5gdsF7queSxMSMD1gTHSF
X-Google-Smtp-Source: AGHT+IGcxrpY5FwVcx8yrFraaIa7JOCgeuZA4gWlDNgGNkVeXC5Z1ByWUsBuDYSZ9H3EEoZMid1q1w==
X-Received: by 2002:a17:90b:55d0:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-30a4e5ab679mr5576244a91.14.1746196157465;
        Fri, 02 May 2025 07:29:17 -0700 (PDT)
Received: from localhost ([2804:30c:4024:1700:8e03:72a4:b895:b221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1659f8b8sm4747735ad.14.2025.05.02.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:29:16 -0700 (PDT)
Date: Fri, 2 May 2025 11:30:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	jonath4nns@gmail.com, dlechner@baylibre.com,
	David Lechner <dlechner@baylire.com>
Subject: Re: [PATCH v6 07/11] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <aBTXCi0HINcrvXay@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>

Hi Jonathan,

The new adjustable sample rate / precision patch looks good to me.
My only concern is about one error handling path in the trigger handler function.
With that sorted out
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

On 04/27, Jonathan Santos wrote:
> When the device is configured to decimation x8, only possible in the
> sinc5 filter, output data is reduced to 16-bits in order to support
> 1 MHz of sampling frequency due to clock limitation.
> 
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and
> 16-bit resolution.
> 
> Reviewed-by: David Lechner <dlechner@baylire.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
...
> +enum ad7768_scan_type {
> +	AD7768_SCAN_TYPE_NORMAL,
> +	AD7768_SCAN_TYPE_HIGH_SPEED,
> +};
> +
> +static const int ad7768_mclk_div_rates[4] = {
I think we can omit the 4 constant here
static const int ad7768_mclk_div_rates[] = {

Probably not a reason for a v7 if the other parts of the series are good.
> +	16, 8, 4, 2,
> +};
> +
...
>  
> @@ -674,9 +722,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
>  	int ret;
>  
> -	ret = spi_read(st->spi, &st->data.scan.chan, 3);
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);

The IRQ never gets handled if we get an error from iio_get_current_scan_type()?
Maybe make it jump to out?
	if (IS_ERR(scan_type))
		goto out;

> +
> +	ret = spi_read(st->spi, &st->data.scan.chan,
> +		       BITS_TO_BYTES(scan_type->realbits));
>  	if (ret < 0)
>  		goto out;
>  

Best regards,
Marcelo

