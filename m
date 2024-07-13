Return-Path: <linux-iio+bounces-7584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F669304ED
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E3B1F2231E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B735A0FE;
	Sat, 13 Jul 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flBeNdWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3F61FD7
	for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865527; cv=none; b=SvFiacTyilnHIoH/yNZPDV6a7gaCwkLkUecwuY5JRTXHEpxNGBcMsf+17yDiT9YA8l+Qoj2WybUxqpL1ek0/eFssVYwmnUJL44X0dIiVrX7E6VLXg4k00os9y9Dqp2fFiAwHPrXpQmVq45mHt4m7yU4qoBHI11E39Lt5cAZrRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865527; c=relaxed/simple;
	bh=2ZJfBjktHWIdU8SMEvO9RemLiImIw7rwLXkxLMziXHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPgfdp0NmpmtRycHY6jIEZaf5RfDXnEPBX+bk/byNqEVpNGt9zg+thJGpzQqZuUf3mhyAzlgRmxkNwiIUbmcvkp5XFc7LUQu88GRZQDTMlNIkFC/RhnXSOU0CgYTNGNMdk9uh0NNw45y39KneIAFsq96zQu4GYC79dCjXdoO44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flBeNdWQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so21752605e9.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Jul 2024 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720865524; x=1721470324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yph9gFOeGCEpZA2i+W95gGdER4UjEJ5BneAesXV/uS4=;
        b=flBeNdWQbE67aWJUma8rZjgPJZE7kb3HF+wvRCmQVr+zLQGZpvvRLzV3LYH2th+gEF
         6W0oBPqLswuESX9kWu8XfAJL7j1TVf6TllMZCf/6hqGWmXj0Pw2vLRzjU7Hu/QrYWaRZ
         3tv6lE/zwpzRXF7KN1VQOqkA5Dg0YH3nAX/35U8+8fgVWdJY0fVkw4dh0/3UcNPthxYh
         ThtQ76WYGImjMybk2Vz+aGLsIOuZrBjog/wOurAzHAbzclKnuuj1jgMNjigIAxtBCnpZ
         EkmBfdmPgY+zGN/HwNFflr1/+eirRf1Pc9f2gb29PP68yPQVNqlrUKxKVG30m8zmG+52
         uU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720865524; x=1721470324;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yph9gFOeGCEpZA2i+W95gGdER4UjEJ5BneAesXV/uS4=;
        b=JjYzTEnLNPyy3PaFBUpnRqTqvGNwnkDQ+WFfjysMRAY+QluHqbK4O7bVcg2ZCanbGU
         A9dJeL0F8fWacZzo8+/uaxkU4yZjyNLFyaYE4c8UdnbWvpTcvR3Qauk3PlDAcKugMJGi
         mIS5K0tKRq79oNRmNGGuATivi4CmzUQVBtVjalgD0i4oFCVVDUAIHu61fWP3215ZwSms
         hwWSq0q3zieS0Fu5sorSpfswDrTSi2F84FbpbKKK3mM8/CEyFbCAuKladjefATxJ/N9b
         yRhuzIhZm833YbSRT0vMyLGjntP0qsNOfKLXrhZusPhFU+xCxhstDEMOs0hm+P7DWgub
         kc0A==
X-Forwarded-Encrypted: i=1; AJvYcCWvPcp1wnQcwrrEcdTEwEmluRSdVQcLQhBK1h/pfSsm9j7lk1fsIpbp9t+P+23XEZ4PWi6ltdpAydSa+jh1eLacAcHl1pd8B1I4
X-Gm-Message-State: AOJu0YxpeIwIS08hwd2Ltn57UIHHdyVo9/lJpRO3WE7OjP3WlWGWyXid
	/2qJ1cxm2w9qwxxgZZwL/Y1nin9RPnX4xlMYHfUpAS/7va2Jo5IfIelOcqeFIo8=
X-Google-Smtp-Source: AGHT+IF4QfSHpcA23GrAdulylnlr2rexELtVRq9YJc4tyipUfsbEdM5QC3JEkXtbHoXLqLe5tWGR8w==
X-Received: by 2002:a05:600c:22d4:b0:425:81bd:e5ee with SMTP id 5b1f17b1804b1-426707d07c5mr123181235e9.16.1720865524316;
        Sat, 13 Jul 2024 03:12:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc42esm49875425e9.32.2024.07.13.03.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 03:12:03 -0700 (PDT)
Message-ID: <e48b2dee-11d2-4dbc-868d-10870e3c07dd@linaro.org>
Date: Sat, 13 Jul 2024 12:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
 <20240607-ad4111-v7-9-97e3855900a0@analog.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240607-ad4111-v7-9-97e3855900a0@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/06/2024 16:53, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> 
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
> 
> This family of ADCs integrates an analog front end suitable for processing
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
> 
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


