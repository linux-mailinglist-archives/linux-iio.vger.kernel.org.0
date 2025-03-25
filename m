Return-Path: <linux-iio+bounces-17261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CCA6E977
	for <lists+linux-iio@lfdr.de>; Tue, 25 Mar 2025 07:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC6A3B2DFF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Mar 2025 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF92517B5;
	Tue, 25 Mar 2025 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYWq8NZ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A693627715;
	Tue, 25 Mar 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882798; cv=none; b=OEdmrqCZQnjy7G9JfiZ51GorG0OYZQnIPuuxJBEPf4KF9Ye1OZYpmKHSsfeQVOPXou2XrLScn8UizeqYUIh5nbHGeWMWKOWJ77INs61msP/9czl/XaKLTMgesaVDpUhB2Aa+EO2rJew1rFiINXcJAAEll9ytuTgtZO0LxWIPfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882798; c=relaxed/simple;
	bh=9ZXBVJNsyDfqRp/o8wh7kd/ITZw/ZBWgMcYZkWBzxcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=byfedITaOKrDN+a2tfXmID5ASx2nZgxpIQ3ZXmH268iDUx8IT7yQZgj8NlEymENOCfCba9ZM0yg6qUxyfFNvI63dFiHSStJnrXKHa4Ds4Fsnr5+YuzLTJFuXIMV4xqBLOzZwAIkyDjjt7jVgInmcZrrJA5t+xMhBozR6nvHr23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYWq8NZ6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so6051764e87.3;
        Mon, 24 Mar 2025 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742882795; x=1743487595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpkYXileyTcIk8TFV6as38CU1iJIxbB4fpN2GYjcrIo=;
        b=nYWq8NZ6Da9Mwq9T7lSKlcTM0BfMXvoFqMjzELOu/ODPxZKz5b2SjIpFT9it45Zu9P
         CcxVhnE5VLVJ3UO5x0IlooklTNQQyrhjaAlLinT1trlKVd4ZqQgXjcTYBXgtyOa8W5Ht
         dsRt1kHkKlSWGl+5lGRoPhoiXhm3qBZ6kGutoV0crbMOGHTslJib+1fLs2FUm5UrK9kM
         SGS6mMWTwzjU7UOU/wKMSlAEMfNUghsfNoh8QmBFF2eJ/vpfzjpLfN0fZ/h3Y0Qev+AR
         kFDnieMGW+yUrcPkaliQrdUt/VHMaG8HZ21KwqOVHdN5nbszeYXSH/gWAmvWDRTEtgjB
         64Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742882795; x=1743487595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpkYXileyTcIk8TFV6as38CU1iJIxbB4fpN2GYjcrIo=;
        b=nnex5ccJg7hc1KKuMTvXH+5FJjh2877cDnZF9RWZSgVpkv+DzboGad09f1IWN7VhN3
         2TB0Ijb6Hds1U+L6ZldfcNcBqiwfbBcM377hNqe0skR52PlFLpyYmFOO8QKYPDGsVIhr
         dIW+drtyBtrFIgvofr5GyHeXmtQI6aMDj+kfme+ArKYmQArg1ABwPJQCYkdzl6ovPEn+
         nCftNgh5SX+B2iwHT9/q498RC2fL6lG/Gh3XO1ia0oLN98jrZf1E3PrDpk0SaGzOvRrY
         tQXHNTpiCGxaQKo1nnRtEh3q31/HUXQ+4QxdK7vqPeFEKe7qJEv2xdBKUJBzJTpXDPmn
         7ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaY9J0rRjjUy1pSB7M96bC7aWYh3cGO9xbA6wxzDX+3RnnLtU9uT/73dkUiA8dbuSSVxhc3ARDcs7a@vger.kernel.org, AJvYcCWaThbzg5xW6FdKt3/d1W0WVrkI8LMUw+X53LxAMuBpV5nV7skZk0ND8C0NoIkUz4qHiR8Y+GUSg/pweLbE@vger.kernel.org, AJvYcCX+T3mBsy4j6W0wKKOYsTX8TFMZ+7HSpRIfaTh+SwHKhfIRNF6TzL74cBTQDuMsNTkrT+1oAQDaQpGo@vger.kernel.org
X-Gm-Message-State: AOJu0YzL542mZ9U/zcVR/i2qqIXGjGfCH0KOWMP2viTu9/TMIasC6ZQ4
	Mo8Dkb1IdTwCwdoVnLA61hxPytI3moMEKchXzCkjBlTDzyv/UMLJ
X-Gm-Gg: ASbGncv42Blyf3F0gMiOHVgvpXxeky4BABPDZCBdU1Vru/BkizW504JxnrYGawG5poG
	JLdKIMS4CTjc348aNbgGz9qHBflMg+SaBzNy3zcUYi6mRzTd0O3N6G4swkw7Q8FeBWzx0+o9S4Y
	XSZpgQ3zTi6vc/hbcmGtB3xMQipQm4d14O026/q1LFbxPlPcmqkZsfdO02ke2UgweiYO9heQbQ/
	5r/qddziQ+oO8ZJGboVPUaYZdGynZfHS88s0Gc1UEz4CPuili0kqBdSyOIcDh4z2CenY77rXuYr
	yM4XEJI3fl344e/HEJJ7LcHiJI7AikBOqKX67rHB3gauIe8suHfIrcwjTNA0OXwefYcWkjcafEU
	NKqTwkP7U+Hr0s7bvBYf3epsStOBft3CnQiNG
X-Google-Smtp-Source: AGHT+IHRTEer1v2dD1wPBDR8uDVpWnU/Fj1Edj8fXP52s1Zi+C3mR/ra+yeS2GT0K1XmpsBuk0gkKg==
X-Received: by 2002:a05:6512:ea2:b0:544:ffbe:cd22 with SMTP id 2adb3069b0e04-54ad6500d8fmr5018858e87.46.1742882794350;
        Mon, 24 Mar 2025 23:06:34 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad65037d5sm1368146e87.180.2025.03.24.23.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 23:06:32 -0700 (PDT)
Message-ID: <007c6e9b-ffcd-42ef-a3f2-4b8fb62e99eb@gmail.com>
Date: Tue, 25 Mar 2025 08:06:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: Use unevaluatedProperties for SPI
 devices
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Anshul Dalal <anshulusr@gmail.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Robert Budai <robert.budai@analog.com>,
 Petre Rodan <petre.rodan@subdimension.ro>, Andreas Klinger
 <ak@it-klinger.de>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324125313.82226-1-krzysztof.kozlowski@linaro.org>
 <20250324125313.82226-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250324125313.82226-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 14:53, Krzysztof Kozlowski wrote:
> SPI devices should use unevaluatedProperties:false instead of
> additionalProperties:false, to allow any SPI device properties listed in
> spi-peripheral-props.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!!

