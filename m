Return-Path: <linux-iio+bounces-16713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B97A5A5BB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C47A1850
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758421DE2DF;
	Mon, 10 Mar 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ocwxXALJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24810BA3D
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641035; cv=none; b=kQACeKOp3z5kdQg/iHF6afe4FLaOP27Uj0gGYlbk0UL4CKt/35BBo8aK4jCsKSznkiCw57imdgMd4aHvl3gJTCembPtbB4Ask6Ej7OHCqWAKtiwoneSsCi98G3fyNHlg0lBGAk++sBrlU5XeqN6ZW7lwdl9ZF6Wh6krH7SI+Id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641035; c=relaxed/simple;
	bh=kDeyRgKu6ElTXESNIdP8GAzZaHzHSgio1viamIrUDaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVI44VgueuVGxv9VgoFBWL9sIHOc9VOZPRjsqrTqYHQKZvUYrBo62VTkFfPqhPfYc+h4bv8MYR98lkWSdKBHkn1FgUGUgtHBgFMGwcOKr0mtvaMfteqUjIKjQlvrOYXwiCPHW1dSJq7Y3x0Mnh7VQ0tXEOK1+z1cEQ8bJhPqO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ocwxXALJ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fe944a4243so1212288eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741641032; x=1742245832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3rpWhwZrBPn4rrbBGcdRZZuf2XwyMGHUdtQybAM3RWc=;
        b=ocwxXALJqOEVHOAKjAcCEakDUNNjHS3TVeHnWFdeArm450nCEVq1c2GIESqyqSdSCH
         4O8/8jGBZm18gi5w7w09fP+dxE69mJ7hNG+24zM3NZBLMh/vYS7WUtkSiqS/btqmOyvR
         nabp1CDQIk/aH31pvmVN8gWMkK0xmCiAlyVv4jw2iQ08CbG1AChRqmjzDZO255hz0kuU
         LYm3T5cIQpZgZ2u8l1+0u5SqrvSCr9OAG1O/kDdBuOVnVQhAP06uEC1X5bF9d6+ZNIbV
         OPq9de+KUIc4Yqf+qIvNl3JVHm991Ac3ifqlVCDUU3uTaqc5xGvDj7KfBH3f79hrwKJa
         pDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641032; x=1742245832;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rpWhwZrBPn4rrbBGcdRZZuf2XwyMGHUdtQybAM3RWc=;
        b=J4cY/9I5D2Zeq1bbqUqfzut6kAgB5BN7QYz9JCOCqi/CZp/bFNCkJFNdS8b0X6NXNA
         ucl60y/EoTLwGLHwmzjBH5Go4ewA0fMPr9iye3zmJb7Yi+4b5v2T5pFwhYUfrdGPtSov
         GkCaGJa64n9+58ACkzA8q5JGD3YQJ7SG3gFM6LAc7a8gmLmPPZiRhrvDeZK/V2IxcPqY
         jD9T5/utc3JZD+NxBk/00ydlvOPEdLs4S3r9/pGhWZN2aUE+pef0qM9DPhemqLrQ3wBH
         oQlGi54/bMBFeye+gWgiEYBPnCuXpEFFBIVHGks5oWwi7RqOkhNrsIK04W1bT/GnpA7z
         duIA==
X-Forwarded-Encrypted: i=1; AJvYcCWiHJ2l7ucWGVvOCTm8Sm0aVP1KTzQPmV3pYYYjyiO3yOALZj2S6PpZvVIRPUi6UmwH5zjD76n0YwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuyuNnW08iwHlmMEYqzG1NuNE7aC8s+GhrAd9jdUoL+fmGLcu
	NmXuVNr1tH7x0lgouplrZHqNnkN0qCLscqpO99WavxzrnR2bW7CHRg9iOyVU8ao=
X-Gm-Gg: ASbGncs3VFRZSGe2FyTnMVkoWLOlEY7oKW7Wks7WQGGLHsTXUmgOZoTOfQNnOK+p7ry
	54Rtzw1XMy/xWel+la33vF4IhN8/OsnCRxwfTKLbcivChRgUSwukMuYJBC0bpd8MZKnkSByKbsd
	6VoMfgLCo3AmTIpzmumlzZCpW4He0YRcWlinafLpzweTgZlktArBX2WyUOzN4nX0q/aQmCb46j7
	XGEnKUS92tDsYBJ78BjtaFFHu+mJ32/GLZQeCOYabOyCQAShGWHGwWrGoZXBbgf96mqwDizePT2
	U88YZzxqyvEKrwn/QPsQYlBHa2lSmQA83RJn+92KaTohha8DdbQMETREUFkzQZ18sY8KMxRDh+d
	NWPhNNw==
X-Google-Smtp-Source: AGHT+IHzvySHKMASLsXDZrmorl0FlQadPUNgEk845o578mKj3jD7iYvMa3hPupUEcWsIhADHyD6/rQ==
X-Received: by 2002:a05:6820:1805:b0:601:a4df:27e5 with SMTP id 006d021491bc7-601a4df28c1mr4220073eaf.8.1741641032202;
        Mon, 10 Mar 2025 14:10:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60040d1fff3sm1916639eaf.0.2025.03.10.14.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 14:10:30 -0700 (PDT)
Message-ID: <16765a2d-086b-4711-97fd-8e04661ba6e0@baylibre.com>
Date: Mon, 10 Mar 2025 16:10:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] iio: dummy: Use a fixed structure to build up scan
 to push to buffers.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-3-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309182100.1351128-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> It has long been discouraged for drivers to make use of iio_dev->scan_bytes
> directly as that is an implementation detail of the core. As such our
> example driver should definitely not be doing so.
> 
> A simple anonymous structure definition suffices here as even though
> we have a mixture of signed and unsigned channels only the signed ones
> use the full storage so the unsigned channels can used signed types as
> well.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index 288880346707..050dd993f012 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -46,11 +46,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	int i = 0, j;
> -	u16 *data;
> -
> -	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!data)
> -		goto done;

Maybe worth a comment that stack allocated is only OK if not used with DMA?

> +	struct {
> +		s16 data[ARRAY_SIZE(fakedata)];
> +		aligned_s64 timestamp;
> +	} scan;
>  
>  	/*
>  	 * Three common options here:

