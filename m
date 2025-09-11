Return-Path: <linux-iio+bounces-23990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0CB53C21
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E41BC7611
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059A25A2C8;
	Thu, 11 Sep 2025 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jlMN9IQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91D25484D
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618062; cv=none; b=hQUvscYR8iPSvGw71kPkYi4/TZ6hzf0GnRJjGm8gTAaQ3AyJO5BSvDFKHcgv7l4po6GZRD88kBPREP+KQzjR9u4L9vIlu1yatjQ3GXc7GxB7xU+RlfE+KpJ2HM5fqYGZ3ulIAJE4YdC6JuTOm/o4HfnMY2t2L/bvJ/MJPNdu5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618062; c=relaxed/simple;
	bh=+suFI+idrm8tbVBw6RQ+HBmKYx+LKei3w+o4S9QMfIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=je+uAd1PnKtOL9aqgWbBtJw58QWGxuJRhjXZC0fajx3oVIzTLOJ8JS8FJ0oxgS71o/lfKncU5MiO24X1UnYvSS6ZksXDkCPot2KFE243dkSg5W7BOqa7ZWoQIQ82jy+WepnLqDdrsiKjZ9WsNh+dHGIoOuAje66J1Q+QNVTsAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jlMN9IQT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74c1251df00so648780a34.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757618059; x=1758222859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbjYXNzG+8uMQPqbjs02jQdJu30kPDTAC+8ZcrYbPZM=;
        b=jlMN9IQTZ2TOry97ijK61bU06qsc2+axe+iUWSpqgwbcvVryX/DccD8veFdRnEV4ET
         XdkWhKUQzLuKE6e3582JwLTgs0hk4gjEZTOp9VigGTrGAN9/OlicMkSOMqOd2UYPhsIE
         EPI3fI2Izzpnqzsx93WVejg/JftWNdxC1oSEreBhRsndIpR7ijMkZ7YSGO5O74e90Qtp
         g4oY3xJHbA637iMSsVZntHnRVkYRQWUiA34nddX/cxhfDxuRriGhhinVt6QS24ntCJwY
         y0exkAlIxSrRiX10fuKNjqgUWaP95U+0+muI58EMGdc8+DlN3OyDN1/WS9FwwwwGszsV
         JaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618059; x=1758222859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbjYXNzG+8uMQPqbjs02jQdJu30kPDTAC+8ZcrYbPZM=;
        b=b3bQFjEnSp4nJiXa0R5M7BdxOCAOOwtuDZziM2fyvUp7lmKore1p4L+qlrwFt/SfRD
         T2HZZ0Z1EAqJ2Be9LsvpLOXdAzDm2irnD6ZX5EpI8Tw+WzoQ8A4eMOxQgdy7ZMfw2OhJ
         8gyNdJJXKpnxgNbOuDAHSA/mKYpkq6IOKB8HZcJN71NS8+gBjuTD1ooRsnekPTZqn8rT
         4cBKCiWOhH3ARLVAODZiwxD9nbL7cYHcN5ZKIK/jRlnO8xmn1f5M8bAU0ur4nngTz88Y
         +jHmi3uNR8gsxSEpBmYEp7Ij+/JIspl49fCv5L4BJpweYQkouEvJhRbbY5XjnQboBM1o
         LR8w==
X-Forwarded-Encrypted: i=1; AJvYcCVB5kN7TNDw2M1OmnBlIhHDnDy5CXuFi//aOTfJzo6Dp+9HyGDWAF8WPq6ORitv8sdPQmtR4j0cmFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBI2RP8Bkk0cbDWFQXoSMWjf2ZX2dFensKBVSKUXLorZTXYIO
	2UjYRg+UQNiC21kg3x/nNG0jnO7cewf+45jSRFeGJDTCks8wRjTAntN57KLGNoS51xw=
X-Gm-Gg: ASbGncuWR+E1YxZXAW/qo065A7ZqkmG/eOghk9Cpi3E6jAPIlD2+dNLPHIgCb9NF2X2
	956XEk89HfRA5T1C0jBubic49wxylUjXVWC5ptUj/I3BwtQ1U+IG5PPGCa6FjvkLMFlYelIgkSL
	5JXRw4GpYnqWkZ9gvM3ogynqxx2T+FXzNmIQuyF913k11KACINhKv7/fW8vR3PwPvTOR/oKed21
	5MRD/ZcAMnOh+CnjnwmB1bzDpAI9WazlfWwkr3TBI6cnBG4vlKwZ+2D2We8eIJa3u4ySMOOOQeQ
	Etljj1OLPfcQsjLeIdPHTx1ybCkE+Y1ElXDZDsM+v+OFhF4cSfvxfq86FLzB6YD0Y2nGvMElJah
	YHe/rws+KIdgIMLVsw4Nktc9U9m+h+3U7zP5lDpkXJrHIya0Lz/36vx44++Hv+IxzqRupLt2MzW
	M=
X-Google-Smtp-Source: AGHT+IHWRt3mNvpfuD9mvG71VJuG/JHH61334tAU2612NEkWoiUHxRSWsgSKkz5m9U8/2/mYJTwISw==
X-Received: by 2002:a05:6808:178f:b0:439:b82f:a8 with SMTP id 5614622812f47-43b8d8a09e4mr180795b6e.13.1757618058769;
        Thu, 11 Sep 2025 12:14:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82af6cf2sm386793b6e.29.2025.09.11.12.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:14:18 -0700 (PDT)
Message-ID: <f40f39a5-3115-4eef-a660-59dcd07c973f@baylibre.com>
Date: Thu, 11 Sep 2025 14:14:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> Bring all configuration registers to default values during device probe().
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---

...

>  static int bma220_power(struct spi_device *spi, bool up)
> @@ -244,16 +244,43 @@ static int bma220_power(struct spi_device *spi, bool up)
>  		if (ret < 0)
>  			return ret;
>  
> -		if (up && ret == BMA220_SUSPEND_SLEEP)
> +		if (up && (ret == BMA220_SUSPEND_SLEEP))

Over 80% of existing kernel code doesn't have the unnecessary ()
on similar expressions so I think we should leave it that way.

(just seems like adding noise to me)

>  			return 0;
>  
> -		if (!up && ret == BMA220_SUSPEND_WAKE)
> +		if (!up && (ret == BMA220_SUSPEND_WAKE))
>  			return 0;
>  	}
>  
>  	return -EBUSY;
>  }
>  

