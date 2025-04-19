Return-Path: <linux-iio+bounces-18347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A4A94509
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 20:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C53487AD223
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84A141987;
	Sat, 19 Apr 2025 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nSh8NluO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EE213B2A4
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745087574; cv=none; b=Tayi12OJq2W6aPF5E99vItGRjagSYPoSmBMAnn/F54JYVxkP3GSQharpR9pNpFnCodGsv0ri/VhqfNbyeDdIyK5+5pW/TFSyetnLlj3ABw7UWBXgxXmuJvpslvqsLIR45CUgStafSl79U+7mIpxERDdmHUkmjibKQODWlYPbMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745087574; c=relaxed/simple;
	bh=ODwOycd1IUOEeekXAJWzOd5/MP7x/GmeK92D6umZdGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUhJByXWmEDY06KBfl1BxIr7igCoyY2780iKV/HX3amBG1YjK5edMWZsCLnhgFALqH5Q7YGpDlxI8plyax8WLWc2H4tjARnr9mYKut0OyOui8yR78Ejnqg6gChlJxTNegEFvttPaXSgNixPTkZPRSKhfiFaTrogWOxKhQF2wkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nSh8NluO; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bbead793dso2058537a34.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745087571; x=1745692371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDFwMaSriHab33Ca2k0ExvDTiZf+tnM2a2QMk4WMFFc=;
        b=nSh8NluOafmayFQjoC09z5MVuLP51UOXr0N4GZzXEFJy2b39aZsqG9VaRprYbQxP2X
         ciLVOYlz1CVdjwXC64kOxdPRUGmwhj/1kte1+p6Xj5b7lb8hJa/23udpd1RencfdBYET
         W6cd2JEA+CCWiP+5gbzjmVD5XxYQHdyS4dQq+weJKJ1Gc01M8gH5ZYI/vca+ve2ymUsc
         0jNv8UOa4pna7eKRvpZdU7G8hemifBaqHV7M9pCd4YwObAIZcyatMNiMhU8waWfX6vuo
         PjcMoewmkZjTDw5qnv/ezIxN0LhnokJNbJITvXoqrCIa1TC2ClbcA6CNwECBTw5Kg5sD
         7HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745087571; x=1745692371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDFwMaSriHab33Ca2k0ExvDTiZf+tnM2a2QMk4WMFFc=;
        b=aWvAAlhBODZmn/YiRKJfpX4WWnoYx83TnPT4QbTjNCUCGDU0lwGCNHWbGkQVG6Yp8m
         gQJbr/Gp0a2mrz683jaPfnPSKO+1yGZJ8ULpM92L+vJtOtFheD4gytQILoZ9dug1nqUW
         Ri2AVd/m5EiVcElw4HwEQRvnb28bHKOJM9d/hScLaA84v2w0CIsjw4ufbMIXlFO6gDxw
         gAq5oGJe7C7cZBhOPa3euo6dIHGpsVQHvXwNxNXGgwgS4dXgvGLHJuB82ij1rYN1xYVF
         63R55aO8KU98O81Hlpb9zvIQuQERkPQgNdIY69AAMzxAD2NnXxKueEbCwrfjb+Wr8kvM
         DwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlt2hA+i85HZJ8LtlwB2rwR/Qaa5H/c3Im0e0gvczSN7JOe2rDEw/Hc5jIoCBzC9EXXrywc3T5Y6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKdkeoR5U3T16S1YurBUhLMf0H6Q5RrChl3PrAq+LOEeOK5wh
	TQ8HZpaNIQM/uD5mg+mrwtV/rzyWC9gYyg7FLDIlFtn7aoGsXmYaR2chRSupNY0=
X-Gm-Gg: ASbGnctL6KX78cxT8q6hjvD2JBbiSmyFiR3BBoCU+tH94ewjrZsqSujMfOu1Et1BI3L
	/NSLqMV5eZk1dM1fUxHxNODp/frC+kqRIGmzvaICsYtZzGcWEoIasItevNJVQPqG1nj3UK847Ej
	wAhXwVVw/WWVgehVQuclLqi6subHcWbmFtBCRGswTL1F+bifckijUI9N0BUc/rBbZ2WTELybA1W
	FyIY5wjn8j2IJRZMC+QcMfuFiNxncQU6/dGGPp+uohmSBjGhXHkMUHvOdz2zgccNob+6TQ8iD91
	wmDQwpKGZ5ymLoqZ7Z5qZrK+BlR2E+P9zWhvooFWh+dxcUM+enIlNMPkBB8spsePLGhbPMdVbm9
	BoKNv4JmOndrz
X-Google-Smtp-Source: AGHT+IHihtMMKLbaI6TqLC/OpBC6LWijtaUTg5w8rF7lkwxjK5VZDuBdOylX5NWJZWyygb8D2cwnEQ==
X-Received: by 2002:a05:6830:4998:b0:72b:ad34:f0bb with SMTP id 46e09a7af769-7300634e703mr4462853a34.26.1745087570918;
        Sat, 19 Apr 2025 11:32:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:79a:b8ae:edee:ec5? ([2600:8803:e7e4:1d00:79a:b8ae:edee:ec5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489b02bsm784211a34.61.2025.04.19.11.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 11:32:50 -0700 (PDT)
Message-ID: <906f8d69-d08d-4150-9f84-2ce714cccb3c@baylibre.com>
Date: Sat, 19 Apr 2025 13:32:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
To: Arthur Pilone <art.pilone@gmail.com>, jic23@kernel.org
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
 arthurpilone@usp.br, bruno.stephan@usp.br, aschwarz@usp.br
References: <20250419161347.28157-1-arthurpilone@usp.br>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250419161347.28157-1-arthurpilone@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 11:13 AM, Arthur Pilone wrote:
> From: Arthur Pilone <art.pilone@gmail.com>
> 
> Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
> same test, checking whether a given 'reg' code is
> AD7091R_REG_RESULT or AD7091R_REG_ALERT. While ad7091r_volatile_reg
> returned true, ad7091r_writeable_reg returned false for the same
> condition. As such, both functions introduced duplicate code.
> 
> We chose to implement the test as the AD7091R_IS_VOLATILE_REG
> macro to remove the duplicate code without introducing new
> function calls, which would be the case if we chose to fix the
> duplicate code with one of the two following alternatives:
> 
>  A) Extracting a new function out of the test
> 
>  B) Rewriting ad7091r_writeable_reg to call
>     ad7091r_volatile_reg or vice-versa.
> 
> Signed-off-by: Arthur Pilone <art.pilone@gmail.com>
> Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
> Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
> Co-developed-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Andre de Lima <aschwarz@usp.br>
> ---
>  drivers/iio/adc/ad7091r-base.c | 16 ++--------------
>  drivers/iio/adc/ad7091r-base.h |  2 ++
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 931ff71b2888..8329552f0be8 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -375,25 +375,13 @@ EXPORT_SYMBOL_NS_GPL(ad7091r_probe, "IIO_AD7091R");
>  
>  bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
>  {
> -	switch (reg) {
> -	case AD7091R_REG_RESULT:
> -	case AD7091R_REG_ALERT:
> -		return false;
> -	default:
> -		return true;
> -	}
> +	return !AD7091R_IS_VOLATILE_REG(reg);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
>  
>  bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -	switch (reg) {
> -	case AD7091R_REG_RESULT:
> -	case AD7091R_REG_ALERT:
> -		return true;
> -	default:
> -		return false;
> -	}
> +	return AD7091R_IS_VOLATILE_REG(reg);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, "IIO_AD7091R");
>  
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 092ddea0f395..1b4e0ef43260 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -17,6 +17,8 @@
>  #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
>  #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
>  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> +#define AD7091R_IS_VOLATILE_REG(reg) (reg == AD7091R_REG_RESULT \
> +	|| reg == AD7091R_REG_ALERT)
>  
>  /* AD7091R_REG_RESULT */
>  #define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)

TBH, I think the old code is more readable than hiding the values in a macro
even if it is duplicating a few lines of code.

But if everyone else thinks this is better, I would at least suggest to make
the macro AD7091R_IS_READ_ONLY_REG instead of volatile. Using not volatile
as an indicator of writable seems really strange. But using readonly as an
indication of volatile seems more logical. A comment to the effect of "the
read-only registers also happen to be the only volatile registers" in the
ad7091r_volatile_reg() function would help too.


