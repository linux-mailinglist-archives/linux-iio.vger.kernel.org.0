Return-Path: <linux-iio+bounces-12163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3099C47D1
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907951F2169D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E6C1A070E;
	Mon, 11 Nov 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jutLyyHu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DA1A08A3
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359704; cv=none; b=hXlFcZAyafPFC6Y7r1iiZ21YNeE1tcX9+uAjkfyEFfsiYtZFvCGqPxj3oDNHTcKHAyLI0Bj3el6HF1bBprJeD5FGeOV4ZYVJd87RB3AW2MIe/xW5UymXlm464KYh23HVUziJIHDWnjmPV2/z9Lk52wEF6zP9X0Nkk7g/PyGye8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359704; c=relaxed/simple;
	bh=UEUEi0g5baFKPd/yPrSTFO2qUqenSovbQvK2ijrjRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlUX4u63XNHujbtT7OrKEqZZXusiV38Vivn49B3EnR+hsG+FArqQ9O+Jdh4dpUoc+nF1NL28pREPiYJ5p1wwIOgNJUIfEwttgAU2D1w3MlR5aNMWlPC032SML3i3rUTbDxbA6HrAOpthqWJwb2JUzwXfw2dl9QPgpTu6ml0yQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jutLyyHu; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5eb73ec1e1aso2419739eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 13:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731359701; x=1731964501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKvPigbrA0Z/Q/kUzViZAw8L2iJnfB5YOIybKqYcsY8=;
        b=jutLyyHuY7Z8mo0iZ+cQZP9vQugjxBCpFj+qo+EVUrLaFP3zIhc+UswzEbtL7vvG/J
         jI4S9wssX0HdUtrZPrga/IuABGh17HJ4taBpNSpZjlK+CXPB1yPlxtP40h6aaQtcILul
         EITo0i/FbB/IiQ/uQHKXWCwTz5OzIl1gNfCxXTlKauRvhdxRN76j7v3LNfbFGMB23rI/
         ZV2YwYtjA8b3tsva9o4/NgdvTs4q+aQApvR3V4pFHbTUfiEJrtyqEJ+IJKoZ4gHWyoFQ
         mwdamYv1MZOd6hMfHHt6iR6JZAWMqSuwfr+Y8jivPfeaFK8xYvXFbgTW2J0ezc9Rh2wB
         JrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731359701; x=1731964501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKvPigbrA0Z/Q/kUzViZAw8L2iJnfB5YOIybKqYcsY8=;
        b=fag1sKowFIa0yb3gVKhq0BZkpnABlA0y5uyFtSI5GfNkFJoIzRvc4N56iF+5G+y5Cn
         YqpWnu/PB9ucNd6hFHh6tLPjzzJHUYCz6GqGEDkXLQj2dLCpVSpF1VjDpFYwSgXHpGgz
         tbhUE0WzZ3HOwu2/XwaaxqcFeP8MKg5Drmw22NOoVela+HIQdGEdFxNnTR9NDt6J8Z74
         h4pBHrSzjfi7lcZxMFVVPpLeLYzQDGBM6iDRpD40s5t0tho6hbvFP1JQ231mO/T+zju2
         9bsseUg5P9n3XTWqu86wy3kiOOpHQhTEnMwI+haq6xQ0Kj5xnskknE1uc/PjpEBxKv7S
         ZSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwUZ1cryCzRsn7kGzx0HxdpzssXOjtIsU+M5bqgjIO5ywYceCdHc3ZV6tgnQRZe82JHYHK+HXl/bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJE07y9Gw7e/SB2YPa6VjrpdNXWzxLIWcvm8sIevcn0EEfOvE
	0qvWmgc3qAGurs1mVFgExNWINXxQH/TyO4+zcGfmzUyC1ZdliamiHaeK7jB6tcA=
X-Google-Smtp-Source: AGHT+IGnDhH00NIUNGxRkfa8oULGq+weqFX/R55G+H4lngweXnOIQ7C2jE6iYgJfdqCvn2ECiusFDA==
X-Received: by 2002:a05:6820:1f08:b0:5eb:d1ac:21c4 with SMTP id 006d021491bc7-5ee57d2887amr9655428eaf.8.1731359700898;
        Mon, 11 Nov 2024 13:15:00 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb095sm2064551eaf.6.2024.11.11.13.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:14:59 -0800 (PST)
Message-ID: <b2f6db15-51a8-498d-ab5b-52f0f6a2e098@baylibre.com>
Date: Mon, 11 Nov 2024 15:14:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com, benjamin.gaignard@linaro.org,
 lee@kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
 <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com>
 <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/24 2:36 PM, Jiasheng Jiang wrote:
> On Mon, Nov 11, 2024 at 2:45 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> On 11/11/24 1:19 PM, Jiasheng Jiang wrote:
>>> Add check for the return value of clk_enable() in order to catch the
>>> potential exception.
>>>
>>> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
>>> ---
>>> Changelog:
>>>
>>> v2 -> v3:
>>>
>>> 1. Simplify code with cleanup helpers.
>>>
>>> v1 -> v2:
>>>
>>> 1. Remove unsuitable dev_err_probe().
>>> ---
>>
>> ...
>>
>>> @@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>>>               return -EINVAL;
>>>
>>>       case IIO_CHAN_INFO_ENABLE:
>>> -             mutex_lock(&priv->lock);
>>> -             if (val) {
>>> -                     if (!priv->enabled) {
>>> -                             priv->enabled = true;
>>> -                             clk_enable(priv->clk);
>>> -                     }
>>> -                     regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> -             } else {
>>> -                     regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> -                     if (priv->enabled) {
>>> -                             priv->enabled = false;
>>> -                             clk_disable(priv->clk);
>>> +
>>> +             scoped_guard(mutex, &priv->lock) {
>>> +                     if (val) {
>>> +                             if (!priv->enabled) {
>>> +                                     priv->enabled = true;
>>> +                                     ret = clk_enable(priv->clk);
>>> +                                     if (ret)
>>> +                                             return ret;
>>> +                             }
>>> +                             regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> +                     } else {
>>> +                             regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>> +                             if (priv->enabled) {
>>> +                                     priv->enabled = false;
>>> +                                     clk_disable(priv->clk);
>>> +                             }
>>>                       }
>>>               }
>>> -             mutex_unlock(&priv->lock);
>>> +
>>>               return 0;
>>>       }
>>
>>
>> Another way to do this that avoids changing the indent
>> so much is placing braces around the case body like this.
>> This also avoids the compile error from using guard after
>> case directly.
>>
>>
>>         case IIO_CHAN_INFO_ENABLE: {
>>                 guard(mutex)(&priv->lock);
>>
>>                 if (val) {
>>                         if (!priv->enabled) {
>>                                 priv->enabled = true;
>>                                 ret = clk_enable(priv->clk);
>>                                 if (ret)
>>                                         return ret;
>>                         }
>>                         regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>                 } else {
>>                         regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
>>                         if (priv->enabled) {
>>                                 priv->enabled = false;
>>                                 clk_disable(priv->clk);
>>                         }
>>                 }
>>
>>                 return 0;
>>         }
>>
> 
> Looks great.
> But there is no indentation between "switch" and "case".
> As a result, the closing braces of "switch" and "case" will
> be placed in the same column.
> 
> Like this:
> 
> switch(mask) {
> case IIO_CHAN_INFO_ENABLE: {
> 
> }
> }
> 
> -Jiasheng


Usually, there is a default: case as well, so we could move the
final return and make it look like this:

	switch (mask) {
	case IIO_CHAN_INFO_RAW:
		return regmap_write(priv->regmap, TIM_CNT, val);

	case IIO_CHAN_INFO_SCALE:
		/* fixed scale */
		return -EINVAL;

	case IIO_CHAN_INFO_ENABLE: {
		guard(mutex)(&priv->lock);
		if (val) {
			if (!priv->enabled) {
				priv->enabled = true;
				clk_enable(priv->clk);
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
		default:
			return -EINVAL;
	}


And it is unusual, but I found kvm_arm_pmu_v3_get_attr() that
also has this double inline brace at the end of a switch statement.

	}
	}

So even if it doesn't look so nice, it does seem to be the
"correct" style.

