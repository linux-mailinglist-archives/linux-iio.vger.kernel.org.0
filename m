Return-Path: <linux-iio+bounces-14101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347BA095E3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD49016B3B7
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C6212B21;
	Fri, 10 Jan 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bygqjHMj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87308211703
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523447; cv=none; b=V45oNKDH+IsS/khIgy1o0Y1IxVgupwEYlJKJHj9lqikvlVNJIMUXuNDmJ2A/NA2XibNwyKrZJ024z4jBupN9qDFvXFPaXZtLM9IBeXDgpNMQNKUmZo+rziK5mNE3Ock1s4vcYUPSXjOCaohTIDdXJYFiZToLRp3oS3IiGsjtSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523447; c=relaxed/simple;
	bh=NxsyjlRY9eSv8Bx7MvUzChCQ40psdT0zMm//ImIxtL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpSC6gLIW9H/UnwDD6M+rAyBgt/UeeKX44CnJCNXSmPs6L5RfH0TiCZegM9M+BHTJD9EuAS7px5BRRgJPy6ux6jv8Yzi4dFCpl0wlFVYO1xjwViA7FKQwr0pLg5xFG/EtNn1zOlWtcYiMWXSSvoRkwRujgQEsDnTnehSf84l2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bygqjHMj; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e287897ceso1393306a34.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736523443; x=1737128243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFjmL4vQsZVXEWCgmHUIpNa6KkGBfMf79YAzsQMd3fo=;
        b=bygqjHMj0U+UyZxXrBALClkJy1VLnq4ZZNCmxbj8QEgZWV9q8H08qpPS1jd0a1Cdp5
         tBDJhNnKH6RvHlt2NIxwzWSdIrlVHSMnzharTNzbKmvw2i0j98tAYCeuWd0vqkDBykkP
         K2h4yM5WwCF98hEs4daYFweO75dRXHtN4SRKFodbziZPUrCgTkxgbdiHUMP/THQBCXKO
         hPYJmeijyWK6B7OGev0S/IvLrLOhMVvkYYZjjOXDDd64BGfdZB1Ayo+g+OFj8u+/XI3S
         PUasF2J/4aIR6qCq8DfEcR5RY0opPZHS3/KxDDoACDLpeGKvT+hW0K4Fc29RNpuo77aI
         MoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523443; x=1737128243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFjmL4vQsZVXEWCgmHUIpNa6KkGBfMf79YAzsQMd3fo=;
        b=nR18xaFrp+hrar3HHONepZlXVdodznDicFN5jQt7gblA/EZ7NSbBk1ayaazAGMGLDi
         hEjhn1AbE3z7X4IEsQrIc6xydbtQE0YNTqXtIR281Rx5N1qXGJkPuUKTsba4vyoyk9XO
         WYYgfPxadlL+jH5qHJ3uWRFDWeXTsPIOkSyWYrZnGsq1tDmoQaMF7uoFfxCoje0hPl4M
         dFbLwOkWmMEL2DkPazFQdoFg4kE5l1pv2Wxr0ZThC/ghAIbWVst/KNIOwZY/UCV5KA/Q
         tFAmOIP/d4TUAaHuDwHTYpmq0WyiIgOKoHP+wUIwtA3REJaKdzNJWE2WK3npNfzeR6cY
         ArTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW18NJvwqFlO+eak4wngfjZFvItP8C828vFrHhWTzjnxfz7gL1IiotiVONQlsgd7xIX20883D137Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9H4Lkj9I7KLKvYpOqQwZB6sep3XkkCKorr/QfXYBznxpY88f
	Mw6rctLOd9dQiNiueQ8XC5bYZxngWqJeV2yO4LHO0GXU7h77s2zh7YRCIqWtrVE=
X-Gm-Gg: ASbGncs3rin8bEsEs2hQ/niYUkF0CYk2QOuW9ez+HKnUPjiTiQsERxucbNEibiwrPoa
	slfwshpSjJPcbbd7NMqg16xZ3QYm4n4LGCaV1boTlDO8aph8SZ7oza+Ii7y1ecj/vkAQfX+3/2r
	//MyB0W3PQzWM3GmohfC1QWlkrlmMo5Ki5Lzt0am/XPmcetK0d04kQT9BOC+CCwFGmTAwFYV+V5
	9VjrO8LiUI6Hj9aD9kOCiQYoGGGkRpsFz5w+0XhDAtgq7dCRUWdJZk14VfqoWMkPC7o09Lg24ch
	aL2v+j9q7q7PH5hiCQ==
X-Google-Smtp-Source: AGHT+IHrjb11VqIowNyTP1M1tANhFfhWQDQanAzhT94jxSFIb5jVokyRlUAmdyDcUP7GamU0aj/AJg==
X-Received: by 2002:a05:6830:670f:b0:71d:63fc:2ea6 with SMTP id 46e09a7af769-721e2e3103fmr7591412a34.8.1736523443621;
        Fri, 10 Jan 2025 07:37:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231862a20asm876790a34.65.2025.01.10.07.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:37:22 -0800 (PST)
Message-ID: <bacd718d-4e6c-48d7-860f-e6de26bed416@baylibre.com>
Date: Fri, 10 Jan 2025 09:37:20 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-6-ab42aef0d840@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-6-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 4:24 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Use "instruction" mode over initial configuration and all other
> non-streaming operations.
> 
> DAC boots in streaming mode as default, and the driver is not
> changing this mode.
> 
> Instruction r/w is still working becouse instruction is processed

s/becouse/because/

> from the DAC after chip select is deasserted, this works until
> loop mode is 0 or greater than the instruction size.
> 
> All initial operations should be more safely done in instruction
> mode, a mode provided for this.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 27949f207d42..991b11702273 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	/* Primary region access, set streaming mode (now in SPI + SDR). */
> +	ret = ad3552r_qspi_update_reg_bits(st,
> +					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +					   AD3552R_MASK_SINGLE_INST, 0, 1);
> +	if (ret)
> +		return ret;

Do we need to undo this operation before we return in the case of an error
later in this function?

> +
>  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
>  				      loop_len, 1);
>  	if (ret)

