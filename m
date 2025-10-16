Return-Path: <linux-iio+bounces-25156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7880BE4A4A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1B5E31F9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449232AAC5;
	Thu, 16 Oct 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T2W3iMen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9132AABB
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632805; cv=none; b=SWiFFsURgMm7pI8fqMKMcphOyDRFQAKGpxL35aj+X7ZYOscrtSU7jnVoVt1MsoFvJjUliesJhCtMs0STK8gW3totEzJCjFhR8cifCgqkkOK8+4hrVbSLDbt/0Cw9rulE1cMh9kplCdyXuf+lqDXIyyRlaXR0oNdtUuIuxHTI0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632805; c=relaxed/simple;
	bh=fAy0qTfnAXO/6EQMnYKaPYicZoGB0T9zmBBxnPK0NOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU559XIGkhhonnWOZYfQW4IPCvp5YM+aVR09y9kn5KRzYT5vYQ1ZUI5T83GbhjoFI6nPm5ShOUwGmUXd3okXzkOulwHEeSEbaNAGhlEh7KzcVCoCkrJuHy0izWRRrkM8lHNAtYByvM9oL4/ijMAmLIjUMHSOnXrzfjTy1dif164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T2W3iMen; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4433456f043so307928b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760632802; x=1761237602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsQuRwyP1p/e1he4VsfHdVAYFfbdIjuplIMgM12qXSw=;
        b=T2W3iMen5Btho0jh/zJWPYlUK/puSk+xSWi/eaw1FQQo8/ROrBY8XtGE/fFmsODy8V
         ZxIdP9PT7lXzEzOuk0MO+WNOuvKBL39Ik+LFb02oN9xg5h5W6h/nUb5GlFrDOklxeDhk
         nPrkr6hbbFtjrLtGcvwytter2hzyzAayPsKzonzOhddnUWmtbxlmqt52qCq9W+ikooG8
         8f8yv25Vgl7NaCoE0WzOuX3hSWLo7+LoGJqavpMeaB128Wv0oTfC29dQ790gWXM34n6G
         49Hy70SU00/lMtIJL7x9cLBJomTmAhCbYQV1WLLgu46dV7DC+j7IHFHjzYjm4hRyNgoo
         2pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632802; x=1761237602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsQuRwyP1p/e1he4VsfHdVAYFfbdIjuplIMgM12qXSw=;
        b=F2gXsP+gP18r8aeVPauwZHRnxOEttPVpum1Lt8o9/4Zy4sHbxnVQEAMNLnNsROwqe7
         /aQSfgUwGDNjx8pU8J7JFTTd+CL6iAvMFhzLReEU8kqn89mRoQXvTFtCk7TVB+jiYYcd
         P+XBdhCuMsjKfIhhx9Wl86ohoSWJTphlx/h/fWNLTneCcZZQUKijfNeQVCEekonqDV34
         X7bwJE+P8Cbz7TmAP4CJVinAJutxchlOVYd4EtMEL+J2smULNqMJRgHmoLkUZC4rcbC1
         huIpfYy/kEhLyB2BvuI3ENUiGSqcvNG5X6iDl1BatQGueYQaf13lLhuYSEvYR5RYLpdp
         FOSw==
X-Forwarded-Encrypted: i=1; AJvYcCXNbiIotylZqiMyYgDOfBeWm5E3P0rLW5gQe/IBgEiZHAuun4DJoLdgwkMgYSLVbYpQV6p6wPD6Ivk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweso6Ry2GIGqd4Ahlq+VT6xt46kqFKQzETBxM5bAJUN7GhSBeO
	hfL03LW4W4zxBLO3Z00itGqaRgF4D6y1wVaXFaqDIjNY1DO5s7JOBbF4bsHsQxqnH80=
X-Gm-Gg: ASbGncsnMmUggCBxNUMdhd4QDm5Sn6r16+6MqCnUYDZHZ9oDM4hczan6geODcY21lor
	cxdeajb/HgNcVvKLaa0saExncAxrByBAe7xGTqzzgtSuXWoVKBdBTwiFSoDsCZAwL+GaaMO0lXD
	T/g68y1nnOcHIVIeRwECQJpguNoqhKY2EdrJtycq4Z2ygZxE1M8Y85WFbXn64DmqbQv+oBGS7hh
	U08VgCbz3rWRjuSZuEmC+8Y4mUnvIr7OgevwLwlyyB3eMqx0Z4qsvlXj9ymGRq+kccxfEuIqVgC
	vd0+92jelaR+ZXKMgYv260eg9VT0CrVlXxlLWVJp181k9NJKQY4rjJiJ0hgofc72yvoWw2cEDPC
	ZWZ7EaC/NUssM9KAZ3S/B3AciH9rYwwpC2yXZlVvB8AnjtpjiAV25aPyGtGiy99y9vNYZ7SXAXd
	9xqUPvz0vsFa3L5D6hIeqwgiC3FkhLSy1t5+dqWhDuH3fiN93GTt0XW9KIJw==
X-Google-Smtp-Source: AGHT+IGJQbkADeOGeeq+XXpp0qjL/b2uHxGRvBGfLM+HLMnOyZaMlEMCLtXYRNuc+IVudZac5N5ulA==
X-Received: by 2002:a05:6808:2508:b0:441:8f74:e98 with SMTP id 5614622812f47-443a317a0f0mr272432b6e.66.1760632802325;
        Thu, 16 Oct 2025 09:40:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:86b5:623:b364:9913? ([2600:8803:e7e4:500:86b5:623:b364:9913])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419893b4dcsm4837281b6e.16.2025.10.16.09.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 09:40:01 -0700 (PDT)
Message-ID: <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>
Date: Thu, 16 Oct 2025 11:40:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 5:22 PM, Marcelo Schmitt wrote:
> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.
> 
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v4 -> v5
> - Made Kconfig entry depend on PWM and select other features.
> - Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
> - Dropped common-mode voltage support on SPI offload setup.

Curious why you chose this. I guess it will be fine to add it later
if anyone ever actually needs it.

> - Adjusted offload trigger period calculation.
> - No longer setting data frame mode from ad4030_set_avg_frame_len().
> - Rearranged code to reduce patch diff.
> 
>  drivers/iio/adc/Kconfig  |   5 +
>  drivers/iio/adc/ad4030.c | 425 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 416 insertions(+), 14 deletions(-)
> 

...

> @@ -512,11 +643,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
>  	struct ad4030_state *st = iio_priv(dev);
>  	unsigned int avg_log2 = ilog2(avg_val);
>  	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> +	int freq_hz;
>  	int ret;
>  
>  	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
>  		return -EINVAL;
>  
> +	if (st->offload_trigger) {
> +		/*
> +		 * The sample averaging and sampling frequency configurations
> +		 * are mutually dependent one from another. That's because the

s/one from another/on each other/

"one from another" makes it sound like they are independent rather than
dependent.

> +		 * effective data sample rate is fCNV / 2^N, where N is the
> +		 * number of samples being averaged.
> +		 *
> +		 * When SPI offload is supported and we have control over the
> +		 * sample rate, the conversion start signal (CNV) and the SPI
> +		 * offload trigger frequencies must be re-evaluated so data is
> +		 * fetched only after 'avg_val' conversions.
> +		 */
> +		ad4030_get_sampling_freq(st, &freq_hz);
> +		ret = ad4030_update_conversion_rate(st, freq_hz, avg_log2);
> +		if (ret)
> +			return ret;
> +	}
> +
LGTM.

Reviewed-by: David Lechner <dlechner@baylibre.com>


