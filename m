Return-Path: <linux-iio+bounces-19316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F12AB0097
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E920179B30
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA328315D;
	Thu,  8 May 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iKQlWLZR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3222A4E1
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746722517; cv=none; b=Xk7VU30FxeBeomF0WK/8SjKfI3nC2dr2pgaCA4nFSSbrAe1aeqN2heaLhYxY+4op3VuFNqGEk8V/gm8ag+T+0/Hiv+eLk9Pqtqoaj7poswlzZCug8tV1pFms35lu/KENWLlvATViWeu1rRUiO/Ckw/aTgf2QuOT+1IW8upOPMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746722517; c=relaxed/simple;
	bh=lQO1jHxaiYx52ybVdJLV2CjY0oqw5bUftoInQJ2KDP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s1w0xu+WpHBWv94r9Ec7ExyVVJeMWV6DRo+D6e4ieOST8L/4wyWO9yTTkN0Hcctc9ifb08ia+D0THRLUwTsdxMxNVu8qyL0DSwQpy4xNcg0R7axH+79+RQsMIbIBzA36gVh0IIn92v07Cct01igjoRaXr0tiplDP/9OM8IQjxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iKQlWLZR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso933089fac.0
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746722513; x=1747327313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNOV3q6ACWoDC2oi9ipTkEmiaERn4Lb/0vudYXDkojM=;
        b=iKQlWLZRmIgcFpoKq1X8P17IrPm0e0oIhqpT24TAjeaEEhz8DHgWQd1sHUXo+9yFDT
         pm+Pu1aNRPS0lAMd07EEt35SOk6Owzh6/iQ4oDaPMDVgXaC52rK0RhYJo1zOte9QfjPk
         WAm6ajepUQrmLPgu5cp7jJpsXRGE7hPI+16iveAOuWx+faPypBE2gPHOIN88u6Xkm7Vd
         b2gtS+/11NfBJWlINQXXy4UpKkeaNnhGlXBHLM/6aHsIYN+wekjJmJJdCiA93YxOA2HQ
         jNG1UlC8L8ieHX/hJwn4oK3NblRHt0VRW+bbAZM9ECTrwpsDDPXcFSrhKuelLsdZ0VJg
         GAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746722513; x=1747327313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNOV3q6ACWoDC2oi9ipTkEmiaERn4Lb/0vudYXDkojM=;
        b=CgxzegF76xuuJbHjAuk0vqxbiNUx+GBecIaFpLEwNPoNQ1E4vER/lPwTDCsTlAlK4y
         4xjaAJipIdFO5QU+0V+L3TlaPipiqdp0xTINMqym+WqOuI+ISnrC/wKKPFcoRBobFdz0
         aL0ebK/zfAZkBxr3MJMh8jld5NvVxLCQS1JGMAQdGvRNaJvILNv4LeS2xf9oQPhA+XWf
         8KWTHO/6MFKxz9Ock7OcNSEiU6avz6R2azm577XTPI17ERq7FsBKxt70kgG4Lp9cjRhW
         6Xgeo3GmzF7dGxjtOwahHivLEX+qOgHtjAUiK/2FdWnCanyZYRjUoG0P2DHlcaPj4g6R
         60FA==
X-Forwarded-Encrypted: i=1; AJvYcCX69HdTSP+8+HniMF20jqoG3z8byQO0MDiB0b61V/YFAxrwkPSA6OEg3FeW4oT5X8JzCnpK38Ipyfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUmROYUiVJl/bCW4UTPr9ps54yMz50rtbhoRVF536lb8HbU+Y
	J6DKzuJwl2/xGRWRfK0TL6/1WobWxki68lYN5WodLnxjbU5wNkG4yK4Fxh0H7Pg=
X-Gm-Gg: ASbGnctyTtGZxo+p1sWZsYOU2bNiY4YUWOoWX1jNR6WsDdX3I/uIYdLqVfawHEomhT+
	TILYrKe14+1x9D30j55Rfxi0zrEd8HLxnm9U/ASRDsFufkcZt+cWUQnopX/3YrOjGETxgWg9oQT
	pCPRMfjcDRZyHIzz+l59QRPXle+fbK98/1xw6pVUWQmCwCfpvqm9o82xokXsYFeBA2i4CmJZv8e
	z5EzehZ2tQd4rT+j4rHywSeUUdeHIVUDCsOr7rWSjgIuasm91fUadVkL+cerMnAziyuFPxQ5h2n
	DTuyVePT7poqTXtokHRMeZ696oQGD7ix5lzvoUEJIgkY8NvRAX6wGCL+d9Scv8kPFIEJV9lqA7a
	rDid5cPbnEWEc8WF58A==
X-Google-Smtp-Source: AGHT+IGNhnI7HfO8AULxSLmDUzdqJUBnRfjFQE3CN52ECHOPdXWRZ2JFQRrWSXPaydXFEJiS+fRYog==
X-Received: by 2002:a05:6871:80d:b0:2d5:b7b7:2d6e with SMTP id 586e51a60fabf-2dba45e8ce5mr83184fac.38.1746722513514;
        Thu, 08 May 2025 09:41:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e? ([2600:8803:e7e4:1d00:1120:d1cf:c64a:ac7e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2dba0b7ebfesm127024fac.46.2025.05.08.09.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:41:52 -0700 (PDT)
Message-ID: <20c76ae9-02dd-4f77-8676-523892a33c1d@baylibre.com>
Date: Thu, 8 May 2025 11:41:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iio: backend: update
 iio_backend_oversampling_ratio_set
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250508123107.3797042-1-pop.ioan-daniel@analog.com>
 <20250508123107.3797042-2-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250508123107.3797042-2-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 7:30 AM, Pop Ioan Daniel wrote:
> In the function iio_backend_oversampling_ratio_set the chan parameter
> was added. The function can be used in contexts where the channel
> must be specified. All affected files have been modified.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - remove iio_backend_set_dec_rate function and use 
>    iio_backend_oversampling_ratio_set function
>  drivers/iio/adc/ad4851.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c      | 3 ++-
>  drivers/iio/industrialio-backend.c | 3 ++-
>  include/linux/iio/backend.h        | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> index 98ebc853db79..a943d5aac9e5 100644
> --- a/drivers/iio/adc/ad4851.c
> +++ b/drivers/iio/adc/ad4851.c
> @@ -321,7 +321,7 @@ static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
>  			return ret;
>  	}
>  
> -	ret = iio_backend_oversampling_ratio_set(st->back, osr);
> +	ret = iio_backend_oversampling_ratio_set(st->back, chan, osr);

Isn't this a compile error? chan here is const struct iio_chan_spec *, not
unsigned int.

>  	if (ret)
>  		return ret;
>  

