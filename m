Return-Path: <linux-iio+bounces-12160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5BA9C461A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567751F223CC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D441AB51B;
	Mon, 11 Nov 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J+iF+Zeq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACC1A726F
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354361; cv=none; b=tUtbKQW8A/dSICwje6pOfLZtxDhG6kiRGEBjl3fmtiUmrbeBIS0nw4wtAHhHEYlyyNa78H7H81k4a693Bu5ceNg11YB7d/3qyL8AUk0hzCD+oPT+DRAn/J70UG9uVwu8ta1pBELr5obiCJ2lxmxI8s4SO5wwuOKXwHf0xiMygbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354361; c=relaxed/simple;
	bh=HhsITk6+6QukLMeqi+pp1Lps9lgVAngKiKP3NPJ3WQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO44n8GQnSStKHUQ9xy2uY2AowVAdxNVoLRkaIUPX90jUv864EENPjlNOFgDdJ+9kQwccCTAaBTyQwNBZfB7xnNjA6ikrSVHVWeJKbX0NHIdaFuKfIEPK/F6YxW0ccCAGc9TG78/9DrPVSkdz6x1sv8ay7jybRNGw/7ILlJgJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J+iF+Zeq; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-28cdd9d8d01so2523525fac.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731354358; x=1731959158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+UNXPvFiJYKdozi2bLmtL/MfRUPw96dDHh4Di4Qg/E=;
        b=J+iF+ZeqxFRny0zt/Ta2UZLKKQC36H9gAZkdNrymfWF97LNNi+Bt5xbwUopb+Za0ai
         vhJmdxPO3/57Ra6T3wHbIXvrpIqrVPkyQWySiy/HBpz0NkQH3lrIZ05IKxtQTTVkmwik
         Il3fQ36NhCAmkQy9RCbp8qjWR7Gu8LeVHuCS7gnQ3IHZ+ohvgk4AqljpfkokW26DWSTY
         Fv6r5E2n2Tr1e144+IYiWfjxOIDqjgJLRKFQoR14KxKzboRBMM9w2PA0yv/25cZOh99b
         Dqr6HJbzDgvz3cEKPLzbh2ibQedpQ4uG2+AQGkP22YhcxuO/qfnvQ01S4+Z7aDtAW8cN
         HDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354358; x=1731959158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+UNXPvFiJYKdozi2bLmtL/MfRUPw96dDHh4Di4Qg/E=;
        b=i+ehke5tV7gNYcnhL2ly16b+xZ9PWO2I3AG3RCwIpqkZSQvkc2NJwX0XyiKOoPY/B2
         sfq3rB+jiGRDTpNpIzCmPGAOd9Efh8U188DQzYS0CHwqPPswsmSxdObqBytilu5U3aae
         36JjY0wzRdFqy7njzF3rpz7RMX+20RCMMsOewQDF5zMXLVFU8+Y07uEcxa3hdTUwQ1pQ
         1s3yLsS4omR3KCpQ679FBGk9GHgVKK0OWnTBtcEqOgzXIQJrPwXaf5c7D6uhWHWeJNQm
         1tjlcpcB4ZlMW09hPyW+4bY/VqLCvK8TR/ML9XYVE6xUb94qLAgLW8t3Z6Y6tqVk/Q3K
         tYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTK1dfUlUJcOmTwvytXzGJQgbrSimEgiBeVUHGbcZ/mxkcNAwbwHMWoJ5AHRG2rd9mKmj/T9Y5Lrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0QU7DQTlPWG/PyhkwvE+auRdcbupzvlUPzvD+/BFX3CsC9c5
	BraJ6M/e57IZlRsTkF7b/j7Vm10HlJ90yTxFyhg/r6aebrJaly7kmsr2k3p1/QU=
X-Google-Smtp-Source: AGHT+IHzI2fm85aOJIz0hLFIb1FeDMozEBMTSyyRvlCuXW4txD+zMA10To4egPzgrYsuvVd5NCladQ==
X-Received: by 2002:a05:6870:7010:b0:287:b9:349 with SMTP id 586e51a60fabf-295cd38c966mr165947fac.36.1731354358195;
        Mon, 11 Nov 2024 11:45:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546c8eb0fsm2940001fac.14.2024.11.11.11.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:45:56 -0800 (PST)
Message-ID: <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com>
Date: Mon, 11 Nov 2024 13:45:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 u.kleine-koenig@baylibre.com, tgamblin@baylibre.com, fabrice.gasnier@st.com,
 benjamin.gaignard@linaro.org, lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 1:19 PM, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Simplify code with cleanup helpers.
> 
> v1 -> v2:
> 
> 1. Remove unsuitable dev_err_probe().
> ---

...

> @@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	case IIO_CHAN_INFO_ENABLE:
> -		mutex_lock(&priv->lock);
> -		if (val) {
> -			if (!priv->enabled) {
> -				priv->enabled = true;
> -				clk_enable(priv->clk);
> -			}
> -			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> -		} else {
> -			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> -			if (priv->enabled) {
> -				priv->enabled = false;
> -				clk_disable(priv->clk);
> +
> +		scoped_guard(mutex, &priv->lock) {
> +			if (val) {
> +				if (!priv->enabled) {
> +					priv->enabled = true;
> +					ret = clk_enable(priv->clk);
> +					if (ret)
> +						return ret;
> +				}
> +				regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> +			} else {
> +				regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
> +				if (priv->enabled) {
> +					priv->enabled = false;
> +					clk_disable(priv->clk);
> +				}
>  			}
>  		}
> -		mutex_unlock(&priv->lock);
> +		
>  		return 0;
>  	}


Another way to do this that avoids changing the indent
so much is placing braces around the case body like this.
This also avoids the compile error from using guard after
case directly.


 	case IIO_CHAN_INFO_ENABLE: {
		guard(mutex)(&priv->lock);

		if (val) {
			if (!priv->enabled) {
				priv->enabled = true;
				ret = clk_enable(priv->clk);
				if (ret)
					return ret;
			}
			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
		} else {
			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
			if (priv->enabled) {
				priv->enabled = false;
				clk_disable(priv->clk);
			}
		}
		
 		return 0;
 	}


