Return-Path: <linux-iio+bounces-14114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE0A09D8A
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 23:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B797A34EA
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9757212B0D;
	Fri, 10 Jan 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpy70fo9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980B18C928;
	Fri, 10 Jan 2025 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546467; cv=none; b=sp1aZZWxRb3mD6v/lfUrckK1hwLN/qHlwEskl0uDHuC5jF5rd7p52umwpNOE+yBkgy7OFniRm72/yTc9iKbXFhGANptQlE8hVUZQxhhiNaYE2u+WP+TlXJq6hVo8pLV7nx62th5QlehTGl2x5MqQf5+zQsfe6Zunkg4yhxygDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546467; c=relaxed/simple;
	bh=nx0vGlst7NSN4iEe+wwVWxAZXqvm+NL66haZXdwOBis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYKV4FiwBoDiXi56tV1I1vVyXIWmn3nQ9cXolUrd3rysBRLuSsO3OxXzGIL8WgfMgClC/dsu2A4t60HY5X3oCl/0V6U57rOpOAjBHMR3t6VQFnPxXoPXWiucVhOp5/xmrmQx52wT9aKUDkRcCz+KAkEHhgHKEFsB7+eCf4x8X9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpy70fo9; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5174f9c0e63so892368e0c.1;
        Fri, 10 Jan 2025 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736546465; x=1737151265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Q6a8eREW8baTupRj9YbB+04vbxGTMHixhz17VyCiI=;
        b=Wpy70fo9RBZlB3qg8KxAWbP0h5dxlH51U8rd3xWkB8Oos664GtEMQf2fKKyU89KL04
         txQOlpE5kmHDOYXJJ7sI1USYHNqovs1wEEJ6iSJg9AYaY30cAeJ3dVzFmYkigzye1lA+
         ZVp0lIQESVmBAdm8ybAJIf8viU/yryTT33ZeZ20+JRDEO9mETi+JlcuV4iGzWjRO1VpZ
         twrOqB4NzC9zO4ZdMf+J+hZcKdrOzZ5hVkqQDYhRPquJZlH1g6AP34yUN7Mju3lFEHh7
         3rDGB4BXfTdxopoXR8yGHf/Rskbs9X8r4D3jGQgYV7twOAetoMS4QboBJPlzVwXklMVY
         QOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736546465; x=1737151265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0Q6a8eREW8baTupRj9YbB+04vbxGTMHixhz17VyCiI=;
        b=lHhNAz5YD5x9jYgDL3pZn8lQmO/3Q5lsoWipbGaQVsqE6EsO9bVrkSS8za6e13NRID
         tpARfq6g/G7jytFDyj6lM+QBfvQtp7y0cU00vbIcYghB+4+mtffuT+xS00JWLQh0F1Q/
         ezxtVBFBRkQdBmPoniXBmyCaPpvEtaZoJqQO/T9hz5ipcJFs1JYQpKYYhB7TzCRvbhhB
         z21kHCQ48YDfp58DTb7lYziNXXz91KNMU4cnjqj/I2VGPLABjc9CVIH5WaX/hCo/t4Zu
         539ljB7rUxvRLSFhaqmcONeDNjya4v9mxj08CIbC4a1lFaiI0Zlnt5qGKQuXNBh3hyle
         3GWg==
X-Forwarded-Encrypted: i=1; AJvYcCVNYnhuMhli734FMw5pWHACok1jMVoON+y8VC5AW0ZdXSNBkTOkahZ7VMZsQ0AcEg6GP77TSzvZPUxY@vger.kernel.org, AJvYcCWodqtv9YgODitDD5Qnr9ISSM+AgYzKFfA3Cf1NSSUkgBojHdojRQFVCMppCQU7s1zDZZPk11Rq0G2JJII7@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlNhPw6wafxRQswA+qFm2yQwJdUsJ/J1FzKcT/XDCji2u5I+S
	P0g/CNpY9dJwSjcXWmxTy8mE/j9p3AJ++k2g89m+/6abLWIJPYmB5cmY+niM
X-Gm-Gg: ASbGnctL0fU3XBgcmNidlijZVVpXfy7T0y2XVFuSSxSJnopBPMkyamVRG5iGyEN4iox
	Clzt4mjbB3llP2A8sAE7ZqS3FU5HwdkXpcuYNak3UgjdrB6Fr4nD/jaziLS94r654klYuPAQN17
	6lxHRxd7XwarDRzvTZTjMpsBCgBQEzS9nmDnSB4PlLNNVCjaJPdYwM4MIqBOPxPnEt1oext+RZm
	H4DZ2INm05lPSjXd7C2TIidbpE6TpLOBOOOq+bGTuXz9bwsh6BDgMDetmuFiwmdnxc=
X-Google-Smtp-Source: AGHT+IHu1td+hk53+PxpazOkg2dTWM45c2TMPP6yHl25ZxUe70jCvcyhi1IKfkJM/J0MAavivwj5gg==
X-Received: by 2002:a05:6122:2008:b0:517:83d1:d448 with SMTP id 71dfb90a1353d-51c6c2b9570mr11408445e0c.0.1736546464755;
        Fri, 10 Jan 2025 14:01:04 -0800 (PST)
Received: from localhost ([2804:30c:1f79:9d00:c6c6:ec89:7531:7838])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51c7fbd495dsm2736381e0c.20.2025.01.10.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:01:03 -0800 (PST)
Date: Fri, 10 Jan 2025 19:01:35 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 09/15] iio: adc: ad7768-1: Move buffer allocation to a
 separate function
Message-ID: <Z4GYv9YmT38OgQAn@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>

On 01/07, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
...
> @@ -625,37 +661,11 @@ static int ad7768_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> -					  indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7768_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
> -	init_completion(&st->completion);

Isn't the completion also used for single-shot reads?
Well, if triggered_buffer_setup fails the whole probe fails and we never get to
do a single-shot read, but that makes me wonder ... why don't we ever try to
recover from iio_triggered_buffer_setup()? Should we ever do so?

> -
>  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_irq(&spi->dev, spi->irq,
> -			       &ad7768_interrupt,
> -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -			       indio_dev->name, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7768_trigger_handler,
> -					      &ad7768_buffer_ops);
> +	ret = ad7768_triggered_buffer_alloc(indio_dev);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.34.1
> 

