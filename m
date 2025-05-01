Return-Path: <linux-iio+bounces-18948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D90AA639B
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D70983E09
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F72253EC;
	Thu,  1 May 2025 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx5Zwyu+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F91DF751;
	Thu,  1 May 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126734; cv=none; b=cJOGuh/f6WMqx1Pg+BEXWNfWtIx2hK++HPl/dZ4dO7Ab/C55VmT1FrIr78W18nic3RKAlXgwm6+r/5DUxf10le2WGZoqUcvrUEM5X82+lSfj8iNfzyfFJACvitrEtosxywv1zW2GKxAlqH/ii2ymeIoCBPHBHaRFdqFhUYp/0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126734; c=relaxed/simple;
	bh=ss0uztebcyaEd4cGVpwkyscRaDhNmYF1y+2lvIAANtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGbSwIFd0j3G9gOUHyxyP56xdrIgCn7LzyEPiQh8L/kS6q4DBrWPelhJPftOAMNPI6IMhiJN2hEj8a021i6pqxUGsmx8sNlEKLSROB3rCYzWDFn3AMwCKTUwCSEniYukOGSgI/0TwJ6ZT/x1Ehy8843BPasE9yrj3gWErgrekEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx5Zwyu+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1566968b3a.2;
        Thu, 01 May 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746126732; x=1746731532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8XwQlbRUOq02VFOg0a4bdaqdHVLvNav1JyIBl9/KBw=;
        b=Mx5Zwyu+3xFHBC/wLW6bDeQO8Petgnp54R7GhhtXkhFUBlRj6pw89y0VIJCfZ/rRRd
         R5Lxgs1ZS4Oo8G1jPaWwuNXTqeeGDvelZyrW0JGmxAXfeO/Np224RqlTokV7ylPE3JlU
         i7zlYlZSkjsH0tWD/5gg1XqfnOuIuq8WBJIC83fR0QONsiZjQZ/61/YcHHl/u9Shr7+l
         UHj9vCbJvmaClLKkMQBuNostTxtct/JpJect08WDARuv70qtaWCPW0gAzAQoYJJUG/y+
         eCWo2J4TRd9KC/SDOOC4HGKWjmz499lzSybUEW0/TLRFgkXDIsTkV+O58euXwGJQEKGK
         c2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746126732; x=1746731532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8XwQlbRUOq02VFOg0a4bdaqdHVLvNav1JyIBl9/KBw=;
        b=Qoj8+kPMf0Rt/Yh2cbrKdd9duiNskh2AIfFQUk5XhhHpLLlGvqwVug2OFebiddk/n+
         j0B13P5IJsIXQ+U3HsT1OD+SJSzj98GSZM9o8cZt5ALWWV8+ObITl/TOvOUXglvYaHB3
         4mXJozS73bsSIHmccmwPQaFVko0pivRA7uE+QQwda5abPxZHX51I7jfdEu3uZKtzS3qc
         pjBr77ZLEXHObGQzPIRW190+i/KkaE5AtSyVN5+AXcUyXtL+NH3lkowEZHQO4NDSXohP
         uPI3dV7AVmnstvAfr8Ufoz/pqQDAjOchO39xBOHc/qdUWFdFw3iIEKCLn33spaGf1tb6
         TwUA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXJORavkG+gWANmDDmPPeYXaan2dJjh5kA0E7QqiCuSEuSM7mbya+85XBnQgULzsSq9wfyn5NwLab4jW/@vger.kernel.org, AJvYcCWXncLRXi+MQQQFYF8xnHtgdBabh9jY5AC02c+IpXucRyPSTvMRqfKGjizddka4HkRNYjwBDDNM@vger.kernel.org, AJvYcCWb1+GPfxKVdc8zFhuS4kfCW+uS/6JCUJnCHaD5uUFecREU9H8aVie2jSqWTH31RYdPKFiFHGiup04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgJAMjpqPKiUDzOwlOfNfwqCDbv0VfW1QfrlJzmzuK1LdEl+5
	udpGW5ECRo01kagLZd/OR+XkHvx3eQrr5unbU+eQ2zliTKk/Zj8F
X-Gm-Gg: ASbGncvm3AC3adGsp7DHgSpXsDgyLTe5PUEKNcP5u2FAjW/f5zTz6ekWC3jarhXtNDL
	OaElq+SwHjisa3Yx9vDAvNm6Jjsz6/vUaaVUMEBiMgkCONWIrR1kWrxO6QZyvh5C7L5tFUVp5pg
	vcaJNBbLzIkkzLtiuQxszNLFHXkOcty/VFurwQPOA44sZ/Mv0+NWN4cJBbCIDHvZZIv7FQ4mSbU
	OPJ2JnDIOCaTOE+JuKPDHfdtYEzjMgEi0uHOBlls47tmC79RUoD+rqUoTrpoRvbhGv653tRwQJF
	dGe0ABzsQJlBc6nvBJlS5XiOMibg79M26g2nLV4D7Ixferjjcw==
X-Google-Smtp-Source: AGHT+IGn1l3iFf96vF6BOVg4Mjq8PFdDHCipAacwlN62HyZL35PDp0hJAG9Ny11kN7uS1RSXAEbCcQ==
X-Received: by 2002:a05:6a00:8d86:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-740589026cemr181908b3a.4.1746126731847;
        Thu, 01 May 2025 12:12:11 -0700 (PDT)
Received: from localhost ([2804:30c:4024:1700:8e03:72a4:b895:b221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058d7adb1sm20155b3a.36.2025.05.01.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 12:12:10 -0700 (PDT)
Date: Thu, 1 May 2025 16:13:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix temperature calculation
Message-ID: <aBPH2dHgwI_4lHvj@debian-BULLSEYE-live-builder-AMD64>
References: <20250501-fxls-v1-1-f54061a07099@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250501-fxls-v1-1-f54061a07099@geanix.com>

Hello Sean,

Overall, this looks good to me.
Only thing I think need to (not) change is the offset (see comment below).

Regards,
Marcelo

On 05/01, Sean Nyekjaer wrote:
> According to spec temperature should be returned in milli degrees Celsius.
> Add in_temp_scale to calculate from Celsius to milli Celsius.
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 17 ++++++++++++++---
...
>  
>  /* Raw temp channel offset */
> -#define FXLS8962AF_TEMP_CENTER_VAL		25
> +#define FXLS8962AF_TEMP_CENTER_VAL		25000
I think the offset was correct the way it was before.
For example, if the sensor at 37°C, the output code will be 0b00001100, 12 (decimal).
Then (_raw + _offset) * _scale = (12 + 25) * 1000 = 37000 milli °C

> +/* Raw temp channel scale */
> +#define FXLS8962AF_TEMP_SCALE			1000
>  
...
> @@ -736,6 +746,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
>  	.type = IIO_TEMP, \
>  	.address = FXLS8962AF_TEMP_OUT, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE) | \
>  			      BIT(IIO_CHAN_INFO_OFFSET),\
>  	.scan_index = -1, \
>  	.scan_type = { \
Datasheet page 39 says 'the TEMP_OUT register contains the 8-bit, 2's complement
temperature value.'
So I think we can make the temperature scan element signed.
		.sign = 's',	\

Though, I guess that would be a thing for a separate patch.

