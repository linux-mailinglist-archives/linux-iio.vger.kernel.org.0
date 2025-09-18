Return-Path: <linux-iio+bounces-24273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C264B86A80
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 21:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648B15660F3
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF62D24B2;
	Thu, 18 Sep 2025 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zQtHLl7I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF90221F29
	for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223182; cv=none; b=hStXxEbV0GF18kXugVr/McDID19YJQWNHFLN45qY7FbKa3GFXq2IqntAsrkpcD066hqZwqSlZbW5Wg17qVdvvU0CyR2RUmyyw9pqSuyEvWSdvhasTeYOD4+Pzkk5NM57lSeaoDKe7DFr2Jm0rTmJTV3u89fSK3thbjawPkWhIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223182; c=relaxed/simple;
	bh=VAds+2wzYTdgT84lPSyZuzQ1VykRr5iVJf9THaSbedk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMMRewpJzgH3vsV+e32e93dOlfmVZ80e2qDAlemyq6tJHgC20PgtnjVeY2KaVKI/uHyDODSPyH35VnYXUBgdIfDwp30Wo4Rluohyo+IBPOcT6gJrLgHWjL6Awaxpd6zxE2n6oW6oyt55+q9cHKlpSkufHsEpLtHQ9Jn7xw62AJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zQtHLl7I; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74c1251df00so745486a34.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Sep 2025 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758223179; x=1758827979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=zQtHLl7Iorfc9SfkZwEg/3fvbJiHAoF7kl3AnRY47ZIFEX6ytjMBBas/bT/S+U7a4M
         1DIMbb4aC4eaWscTqm6W7FevPXiKw+9b0WVdSR9P5PNeTblxszszWONnjXOldqAOobIf
         d4hpK692wbFMJiLK9JMG+N0uqzgJwJVnZv+wjf5QDDfTqXHbr0/Nqeqh+hCNZ6V63zK5
         UMaKPv5QkbWKTyeoowY41KZWsvfcVGut+/iCoQ9EfluvhXagxqHBVkwI1hFUrd3FLdDB
         YG1Rw2PfTnBZGSNZuDy8bad/yYxe3nKyEAlEe7S3iOY2ibT+dQtds4bKBmr1ZlCFQUov
         SiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223179; x=1758827979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r74pu9DjNLXnTw+Oetk6FMAjK2ne5DYjMQsYnuscUPo=;
        b=pDOz6XlPfcmY/pOcVi/Qnfpo3ST+r7oHWgRlOGgo5XHBv5vXvgQc+F0DRbOsQ1rIKt
         4E5434QPUKCfEo9BEgHJRHL8LFxXTB+ubiWCvJfnVKjJSfrpciavkgDPJmxCRWGiDJSP
         d1RaVks/+vJP1pIuvSSqs35Ga0fOvk2KdjK8zWBPKatmrylu7aP4LRWhg3HSEMub9M/3
         A++v975c4MQ4QgDiW3ibYIudlF36/8sOy4Qfw6b1+gPvbjvPObwXoj8A5Y4QFgUyXLRi
         DQgx6k6wl+4G2sgvQQGtHnkA6m9CXTJ0KuDdFd/cugO4l+zaU4BhLiwGsOZls7nZVBV5
         b82Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVRNUmkikwEEyP3Ab0svdQrwlNE9oxWY9MPNwW1AaYw7HcpYg4/MfMY4wKLM68SZWFYviqKSxkHkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIj1d/yKL4IIg9Robk7WTuFSc7mWwJMIkU/OvObZQfgKWpCc5m
	qR5/3Ff3Z+m3pvNb0vJB6uyLgaSbctDBBvEpXurwsJzg+opUZ9fuzeg7sceqVWsAtvg=
X-Gm-Gg: ASbGnctLfNfLzieioGq3SKBOawm+Cuhx1y6W39VQT/D8HNXxU4ayJPBfkd01SC07P7S
	B3iGEX1cqWotaiIIRiMexALOPh6X6LxfFZ0wVspZRlwbLE2DfmGNqAxZQF4iZV7hfVAbPXbkDPJ
	bgpVTIRjfdUpGedkUYtBnzPESIFfpc99+Y4abxPEUZou00Kupdwruv09ysdTOJ1qyptYkOc2iZ5
	ohG/JDOUmoTcEdUur/nSd3lxYJI4/0+nG1DVcWSRTk1l7y/4aKk6KOwI0oqoPf7fCNAKUYPZ2fQ
	+nUNlabi0BcQJGkNq6xHFEVcQKvdWPQSjx+sTQ4rdeasNDqXa/RsEPDzhFEcwuKyW9xXpex/K1R
	y6XVpkoqo4faUIdgqU2XkOySXz+KPMPzHlHqeDeVVi1f06Vua88yhgIQHTgfRZEXm8z7Ta/KFA7
	EjDOnc/rLT/9hJJnxMmg==
X-Google-Smtp-Source: AGHT+IFYizUXzzXfO+m4EDIZA0JMmJrXu4MhcrJu81pFbRnpj6sLHpXHOc03v96Ezh1XqVDz3IUWwA==
X-Received: by 2002:a05:6808:1b26:b0:43d:24a5:e9ce with SMTP id 5614622812f47-43d6c2d02e5mr324464b6e.45.1758223178893;
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm1751557fac.17.2025.09.18.12.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:19:38 -0700 (PDT)
Message-ID: <813ddecb-efde-4c11-be45-e894fc52f752@baylibre.com>
Date: Thu, 18 Sep 2025 14:19:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-offload-trigger-pwm: Use duty offset
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1758206554.git.marcelo.schmitt@analog.com>
 <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <181f64a4e9f0d6788f325a200b24b0166cb8c346.1758206554.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:34 PM, Marcelo Schmitt wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Pass the duty offset to the waveform pwm.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-offload-trigger-pwm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
> index 805ed41560df..3e8c19227edb 100644
> --- a/drivers/spi/spi-offload-trigger-pwm.c
> +++ b/drivers/spi/spi-offload-trigger-pwm.c
> @@ -51,12 +51,14 @@ static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
>  	if (ret < 0)
>  		return ret;
>  
>  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
> +	periodic->offset_ns = wf.duty_offset_ns;
>  
>  	return 0;
>  }
> @@ -77,6 +79,7 @@ static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
>  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
>  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
>  	wf.duty_length_ns = wf.period_length_ns / 2;
> +	wf.duty_offset_ns = periodic->offset_ns;
>  
>  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
>  }

Does this really need to be a separate patch from the one
that adds the field?

