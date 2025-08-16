Return-Path: <linux-iio+bounces-22852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376DAB29012
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8807E1C879CF
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778212D3A80;
	Sat, 16 Aug 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1FAVt5eW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339891FAC4E
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368669; cv=none; b=LQA20FOYlSSKVHMi/1Cp3jJ2XIwS4HMWdtAwTOE0BYkCjwSC6tAiS1uX3tFJh1GonaaHCIiVmzSF9eWKkFXbInGWK7MBFOxy2/nOk0i3QRmYQpdj8fc04l4K4UdhHFT9lKVlb3BaGhR0LJe9SS9X4N8mTDiGgJRTuTM7iWmMIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368669; c=relaxed/simple;
	bh=JnJIOlsGDO2UgNwnN1Ia+2CZfap16BIfk8Z5hv3zESg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8kH9EWUYsV91wKOpQsJocOw+IQ737O9LP4vB7IP0X2XapyPOPPz1YOvZdzSz6fx+Z9zdkAtg3lXBGgqBh5BFAV775+9MoOupLYzLsxacKnEF451MPwgLv9/jYoia5XKAjIjqydHyvxGbYosYWT3SXhRZeCVynzSMwTJmsA7A20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1FAVt5eW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74381ed5567so1632581a34.1
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755368666; x=1755973466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNUlCKf+PozSMhiOiUc8QNdxtKMKbQOVsk7v2FaWGKw=;
        b=1FAVt5eWY8DS0VDeHQN1P/lVuT7fjFXnqX9KoiolRwnSg8zjv/Z7VVZm/gXVKcwEL+
         KnCAjPuJ4cLpkiipHRAoVipMG32MK/IWfkcxmW3INNm+xgBl8ddH+N/l0sjM+xcQkwa8
         gim0Kp9fq8efYBsGG+URQjY/GNvE2VIeKDxQOpQuxhc63fHl0s9/1qx/BhZ6x+ScgAhs
         NMjVhCKraYxm3CTLYIjc21Oo6wh3hpB9gnRYUDKzRg6ztdFQNzPhUpcxgMuGDWOK/ttd
         fpF5CxYn0M1E5QmlOb43cBIxixol7avtbfaECWWHQaCnVEsgcupis4CcvHJF+JegkoY+
         6bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755368666; x=1755973466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNUlCKf+PozSMhiOiUc8QNdxtKMKbQOVsk7v2FaWGKw=;
        b=Hm6xMTpWwzlKWZRpPnTUzbKfCHAr/19kICSn1pib1u2K2GH7MmQ2doQclrwtbwx4Aa
         IUzrESjI+7ZzyppxOFm2LKi0e3ML0CQdKIkIWfqFuJnbGQpZGzBoAqv2fz190eAZNXXJ
         NVBB0U+0k0hDRiCdbEIrMrRwfsUyDVhzxi/lwTZwz+LOC3g4MEeso33LnIlRaPPGF9Cf
         cEhfxUl+dDHP6+vy5J8FPHuPY2F0O17NSFEQc9ySMkwr+4yHSXyUwdbqFDCStQ0jId/k
         /TAGIe7p+4CRem4tRQzt/ju5/qZ3c5CfNf0H8ItBGnL6gQ9xX2GMRnOtyVmbEk4NzxPe
         WXCA==
X-Gm-Message-State: AOJu0Yxix845NURVpNE+XIXJtx2VSj8tjJyPFrF4+lntxjknRRIkuNIu
	seI2T3kKq9tlXwu2atwi4e5LPq56dGg4Td11Tv9cWoDgbxwYiscYRj3CXYkEgwmtteA=
X-Gm-Gg: ASbGncto8Qz1T1Vo2gzOimfVqp02WE6AT+IxG0CY26PAqGkXCTnw1APkspi40WYfC76
	hlk8cg0sRIALwLLC23G2f9QN6l7hKl8tS11dfVBjqjyINeBocdBs35UGccPrhO3ue3d5nTyjxzS
	kmQf6KwkbZ5nPdOYiJE/cohJniadZbNdFK70N9lAzwku+Ys6HMJKgG527wCLFRhUbA8iIlcjg27
	HqolCeFG+i4+ZBkW/W5M05LyiRNYEnEpVytr0I8C1HozuHl+zPb+yY49Rus2tkH88y2bV98Pwrt
	wl+VsrTUgfabjKnNkd3y0ESAWZvW7S6DQCOJp3kno4KoJ31cVckLBnE2lFB5g9mz9Q7i9XSnAvW
	8QXOU1d0Cwma3QFzwamYdIiKw0POkfLBzunNOdGub72J5PJTeLgLtGicW2YiedMTZB/N18Pj73p
	YHlYRhoPo=
X-Google-Smtp-Source: AGHT+IG4x9+lZonQLtZAv5o+14TpRzPIGvwvJFP8LMAyvwlY/f86+nqIN4zZje7xbJPshmzcKpQvVA==
X-Received: by 2002:a05:6830:2a8a:b0:743:823:a094 with SMTP id 46e09a7af769-743923d34b2mr4625028a34.10.1755368666249;
        Sat, 16 Aug 2025 11:24:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfb2a02sm456819eaf.11.2025.08.16.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 11:24:24 -0700 (PDT)
Message-ID: <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
Date: Sat, 16 Aug 2025 13:24:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250815164627.22002-5-bcollins@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 11:46 AM, Ben Collins wrote:
> dt-bindings documentation for this driver claims to support
> thermocouple-type, but the driver does not actually make use of
> the property.
> 
> Implement usage of the property to configure the chip for the
> selected thermocouple-type.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---

...

> @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  
> +	/* Accept type from dt with default of Type-K. */

We still also need a dt-bindings patch to specify the default there as well.

> +	data->thermocouple_type = THERMOCOUPLE_TYPE_K;
> +	ret = device_property_read_u32(&client->dev, "thermocouple-type",
> +				       &data->thermocouple_type);
> +	if (ret < 0 && ret != -EINVAL)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Error reading thermocouple-type property\n");
> +
> +	if (data->thermocouple_type >= ARRAY_SIZE(mcp9600_type_map))
> +		return dev_err_probe(&client->dev, -EINVAL,
> +				     "Invalid thermocouple-type property %u.\n",
> +				     data->thermocouple_type);
> +
> +	/* Set initial config. */
> +	ret = mcp9600_config(data);
> +	if (ret < 0)
> +		return ret;
> +
>  	ch_sel = mcp9600_probe_alerts(indio_dev);
>  	if (ch_sel < 0)
>  		return ch_sel;


