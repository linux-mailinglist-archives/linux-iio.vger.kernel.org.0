Return-Path: <linux-iio+bounces-14035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A7A0659E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A5C3A52B3
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F39201262;
	Wed,  8 Jan 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aGstr54T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912F1A8403
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736366083; cv=none; b=TnR+816kn/RLPTQdhCoFui/N0+WKtBGTD9ieJdc3SLjB5kOK1HKp98Ro5q8jgkWLYEK/kkWqaQXx49Ka7ipW4u9xlMnDHM0jskPtTUKI+n5ppr8ptyOJmxvnNMsympuMQJwf4KRWYCkdXm9kHrFWP5QACa/g8wsNvY03R2LcfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736366083; c=relaxed/simple;
	bh=C1/uSt29Z7szw8XkZQAWSHQ+Z5mvd/7B/Kyd6DoLGcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssfRS83wKOAmLr5IkPl+1iZXPioUjUAMDDE5tI8WHMCmTuFSFlVwACnUz4awaf0ok9KRpUAlSGAZiY3QNSBqrkMpM3v0h/Bl7EWhKYajBNqd8kXFP8NV23nYndRWyeNpQP5xB8pcqt3D3s9X/bdnpHHztCirHGQT1JRQZgk0mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aGstr54T; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46772a0f85bso735101cf.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736366079; x=1736970879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WMAvTH1lV39HYnAYNAQk4zKitV1LjMad/RFWOGRodQ=;
        b=aGstr54TcbySi/gXV1UgrdTKuOj83e0E8G9I3P64347x8zFFQhcYfZYLytDf3CKeLq
         BIln2UaxAxvFK7n1ruYUj0+ERtG1CXa2k/LNz5SQidUJp+hzjGaGYMTtB/E2uxK2aoL1
         pBTNg77gyNEQVdX3yn9B2sjzo8BO7t4v6hgZ0CSoMiJHjW5suKSj+qJI1OauLq9FFCpj
         /mKRFB7SW0eso9QrI68c0Gto/Pyk5oRrOsSSunr2/cQnHE9F2xNZgP0r31q/gugQsgss
         StUjoPD5IQMUsgYdQf11tW6d7nWCZZc8ple+vStl2qWlqfiglkz1azIO1ucvGrI5UERQ
         qYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736366079; x=1736970879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WMAvTH1lV39HYnAYNAQk4zKitV1LjMad/RFWOGRodQ=;
        b=qrombuKdRzSlkKKugu82qda6awiC1lPaQIcq6yDGh+T+KU9yk8r0OOiJCjtS0ybn1y
         QM/kmOMBfuLV58sqozaavAstBDY4fMUgDp4TRwCjqn3Ief/5x8uCDgHwPyc0nSAPiZCm
         ZM8npp1+UQnDabLT5XB19+TF3qhkQnV5rSPdmcemXVda4/GleL5TeP+h8JlMLk0OCYsm
         TgLVHxUzDQNARBh+Gq3xFS/2mkG0qiQYsugIPRMx1aA9CJ1wa2/9A2Eo9qWvRYucISmx
         CqSCJoDvtxQuddp9ZEaysXnpSSs1tA26Ky94sYYLhxSX/tIz5nKr9vGZmR2lMj5zp5WY
         5Itg==
X-Forwarded-Encrypted: i=1; AJvYcCUNO3fOZsUBFI6HNjR0FcSmM3HJYaZQ70+6zjnHMA0PrCiA9RjXT8PX8yjkVAq33cNMstvEjJUFh5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfGv26c+QqmC+zcpcwtX1TmSwPnldg+4AO7CDgl7XBZJcZjdq
	VtZ7BgMv0/iuOQFfG7WuoMr+T744Mt4OjLkc7x9Syo96d5RVTZe5mptzTp9CMTk=
X-Gm-Gg: ASbGncvQXA9v8rvekiMMjdEX2yuhfMND4D4PKnUCqL0xOuT11hbyTx/t+tVqs/TOiTO
	cqy2WZfzRPROgHQ2XdmHPG2cLpwkNlWC2Hkqww7U4a+XAK0lmONea/fMGinlHaFw6LsII9H0jaj
	nslnTOaQxYJbOn/YqzhoTOe/8Sg0mnExuDAgJTkMoKnAVVQmx8pte6tLE51XFY9N5b/HDbEucE3
	4JVMfUeZfrOWn7j7zKWEAOpxOlaqNizpsc4kNpqmYVuS2Yev4vkhPV9+Zij1d4HqhCVm4cJ19ae
	lMzWHa7V2Gr1lzZEwm4acgvU
X-Google-Smtp-Source: AGHT+IF2k0f8UoxQ4gUXy7jDYaFSpIyxqTH2gVnyBauxADea4b+vnx5Ou0DhyKxXno6pWcxm1pOSWg==
X-Received: by 2002:a05:622a:254:b0:467:6c95:19de with SMTP id d75a77b69052e-46c7107dc95mr61258801cf.11.1736366079602;
        Wed, 08 Jan 2025 11:54:39 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e65181bsm199161141cf.7.2025.01.08.11.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 11:54:38 -0800 (PST)
Message-ID: <dbf6dc15-ec2e-4779-9a0a-4038aaa59624@baylibre.com>
Date: Wed, 8 Jan 2025 14:54:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
 <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
 <20241219161301.3f708302@jic23-huawei>
 <1c641b37-475a-4153-bcfc-e0e72d79fa76@baylibre.com>
 <20250104123029.12a4e19e@jic23-huawei>
 <9128ecae-73e9-4a66-8cd0-4d98c14ff05f@baylibre.com>
 <f801aecd-be1c-45f5-9ea0-081162dd74e2@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <f801aecd-be1c-45f5-9ea0-081162dd74e2@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-01-07 16:02, David Lechner wrote:
> On 1/7/25 2:21 PM, Trevor Gamblin wrote:
>> On 2025-01-04 07:30, Jonathan Cameron wrote:
>>> On Thu, 2 Jan 2025 13:19:19 -0500
>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>
>>>> On 2024-12-19 11:13, Jonathan Cameron wrote:
>>>>> On Tue, 17 Dec 2024 16:47:28 -0500
>>>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>>>   
>>>>>> Add support for the ad4695's oversampling feature when SPI offload is
>>>>>> available. This allows the ad4695 to set oversampling ratios on a
>>>>>> per-channel basis, raising the effective-number-of-bits from 16
>>>>>> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
>>>>>> full cycle through the auto-sequencer). The logic for reading and
>>>>>> writing sampling frequency for a given channel is also adjusted based on
>>>>>> the current oversampling ratio.
>>>>>>
>>>>>> The non-offload case isn't supported as there isn't a good way to
>>>>>> trigger the CNV pin in this mode. Support could be added in the future
>>>>>> if a use-case arises.
>>>>>>
>>>>>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ...
>
>>> Maybe trick is to reorder into 3 conditions and set the value in a temporary integer.
>>>      int val_calc;
>>>      if (val > 0)
>>>          val_calc = val * 2 + val2 * 2 / MICRO;
>>>      else if (val < 0)
>>>          val_calc = -(val * 2 - val2 * 2 / MICRO);
>>>      else /* Only now does val2 sign matter as val == 0 */
>>>          val_calc = val2 * 2 / MICRO;
>> I've been testing out these simplifications (but using the scaling suggestion from below, which is great - for some reason I had it in my head that doing so wasn't an option).
>>
>> These seem to have some issues with signs for particularly small calibbias values. I think it's because while my (val2 < 0) case was doing unnecessary clamping, the math itself was OK.
>>
> Mail is easier to read when wrapped to 80 chars. ;-)
My bad.
>
>
>> I did some more experimenting, and came up with a new version of the function that looks like this:
>>
>> static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
>> {
>>          int val_calc, scale;
>>
>>          switch (osr) {
>>          case 4:
>>                  scale = 4;
>>                  break;
>>          case 16:
>>                  scale = 2;
>>                  break;
>>          case 64:
>>                  scale = 1;
>>                  break;
>>          default:
>>                  scale = 8;
>>                  break;
>>          }
>>
>>          /* Note that val2 > 0 if val != 0 and val2 range +- MICRO */
> This comment doesn't seem 100% accurate. val2 range is (-MICRO, MICRO) if
> val == 0 or [0, MICRO) if val != 0.
Alright, will fix this.
>
>>          if (val < 0)
>>                  val_calc = val * scale - val2 * scale / MICRO;
>>          else if (val2 < 0)
>>                  /* if val2 < 0 then val == 0 */
>>                  val_calc = -(-val2 * scale / MICRO);
> Could also write this as `val2 * scale / (int)MICRO` lest someone try to remove
> the double negative and break it (because MICRO is unsigned).
And this.
>
> This also calls into question if MICRO and similar macros should actually be
> unsigned because it can lead to subtle bugs since it is perfectly reasonable
> to expect -1 * MICRO to be -1000000, but it isn't.
>
>>          else
>>                  val_calc = val * scale + val2 * scale / MICRO;
>>
>>          val_calc /= 2;
>>
>>          return clamp_t(int, val_calc, S16_MIN, S16_MAX);
>> }
>>
>> This seems to match all of the expected outputs for the pre-simplification version in this patch series when I test it. If there are no issues with it, I'll send a v2.
> Probably not a big deal, but there is unhanded overflow when val is near S32_MAX
> or S32_MIN.
Should I handle that with an extra call to clamp_t()?

