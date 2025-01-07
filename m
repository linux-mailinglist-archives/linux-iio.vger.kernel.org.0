Return-Path: <linux-iio+bounces-13998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263DA04B53
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CADB3A3DCB
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9611F4E48;
	Tue,  7 Jan 2025 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ptjfNupi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22918E02A
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283738; cv=none; b=AX1YNucnUfKtCHK2Y4k7M7VrhHy2DvQSRjq+5UHQbjqQsLV8KOSMlZaZL2p3Lez4JwlOW+C4COJg6Ta/r3vMQjdcWCRFnO0GvoFelhimu0iKXaahvn1FE361Am8uTyF4zeCx9L412IEwHsRChX5b4id/u3ARKXSKZKiVZLZOT7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283738; c=relaxed/simple;
	bh=RAiQKmoPhhDgFGQS+Lev1D4yJuL4voNfsadzpfP/Xc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUJvehNsPpYz4PUGuBTSn19DtYI8V/zrBiukU4nXuJ7swfE3cI7Ssc7QH75e9vRcIKX14flb2ksdJFX3jrkGme3OHmO37qpoOKWpm1e0N2U1be3cecm+rX0yovWCSfazRhE6y+PYPimoLE3Ib7rrpikRJpbhGbABpuvg7PFq9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ptjfNupi; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e16519031so119133a34.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736283734; x=1736888534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZxISArBXhdM3prebti4oFN1Q9XwKL/nN5FqnNyN7Ro=;
        b=ptjfNupisXxvd75no6NQc+gZH8LSZWVFxEIQ+FuVzl1zrWzhJkHZCzqBo+/03u8O0K
         SQ7cDLixCx6C4ByxLhjuWyGNjEbin8YJ5Hr+esjaIelcLI/YO74/U5sSRlvhxk77qU6g
         hgXSFQUUySf0TMjpfXjYnwW7XJgQwOx6lEuI5cBc1n40z9qhPpoJboZPnZ9UiHdndegV
         e44UL4NffEqbUMOE5V1nMS1m4GsqLbqf6yoAwEuacpe2H6wkjbKdTS0Q0MpHiJOGtnNl
         ag9g6XJnwLeVh3ZIRX4vXxIM0dAIppd3IcvjnOlSxCoV/pPgGwuKwq9UiSnCOtt8NPgg
         OqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283734; x=1736888534;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZxISArBXhdM3prebti4oFN1Q9XwKL/nN5FqnNyN7Ro=;
        b=Z3kOMXprWmkKkAb6FT46SzVqXTdw42IgeDsvP/eWR1XtyBdEnRxJKWZiOj+UwriC5z
         aacRT3ljIMVWB2u8+CdbSebvlDX3cOMLIrQttnSNA4vSWn323nCwwcKNJtJSKk1k+nWI
         aL8Z9GR0IEuwkvr9z7GBH2XWDsUVORm/BqB0l/DjFslcFkcZrSZ4SmQPZh+8BWivljtm
         cvM8vFz0IHN+BAkV1yB/nm03zuMzg45uXiIaB0RXk2fDFcC+/KY0XpIVHRWPHaCh8p9t
         +MmzPuTwpGtYMZpcmGW4Br+32guUh+aIsM3a36lXglwCZrQAxUuvonTW8uRMJYGe3vtB
         Q3ww==
X-Forwarded-Encrypted: i=1; AJvYcCWMZIe6/mxKShydBOvEWeV2ZJX9XV9wmYfkeQhDDXqlTlkS4w4F+q6luwOprGG6vujh7BXKBeqig54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLHx+zwH2mLqiKtYJPHtOl/410MGLwnwasWmr9fE82tdUp6K1
	QZsVwN9c8cAEms9KJqY5Q1OmvHWOYSBioI0NsTLMMIXKlYwO96xFA3tU4x10W9M=
X-Gm-Gg: ASbGnct/1HTSzgCVXusog/qAyj+tepuGKMVl9lG5vDh6LBktCGBaypqOG2q1q9Q2M/K
	h7U8QbnInwkzFwITUAGpXkJiB1rkdqYbdH3fZLWeyTsT18nuz5I9CKGSPDPC46d2tICtLUV+23L
	QeEs8KAjxcE9vKXxFwmjTb2dHCld4OJzEYEyl44egNZTeqnjIdOiRcA20N4tOy+boRh72RnYTpt
	toFUYQxQfgzgqcVFfBnIS8NHf0MCJCioZC10VlmGWLfhk44xEKxfwSevDaAJMYotw3f9xc4nhec
	B6gJT176uLGQCPtAug==
X-Google-Smtp-Source: AGHT+IG/pUPh5oFZgJvnAqyY5u8bfPLLosDJtDnmFZTmZjvoyQYt5CXVBLaAyl6COW8K7MuKwCV+hw==
X-Received: by 2002:a05:6830:6616:b0:71e:1511:5d7 with SMTP id 46e09a7af769-721e27da35fmr296972a34.5.1736283734382;
        Tue, 07 Jan 2025 13:02:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc976ba23sm10566121a34.1.2025.01.07.13.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 13:02:13 -0800 (PST)
Message-ID: <f801aecd-be1c-45f5-9ea0-081162dd74e2@baylibre.com>
Date: Tue, 7 Jan 2025 15:02:13 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>
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
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <9128ecae-73e9-4a66-8cd0-4d98c14ff05f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/7/25 2:21 PM, Trevor Gamblin wrote:
> 
> On 2025-01-04 07:30, Jonathan Cameron wrote:
>> On Thu, 2 Jan 2025 13:19:19 -0500
>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>
>>> On 2024-12-19 11:13, Jonathan Cameron wrote:
>>>> On Tue, 17 Dec 2024 16:47:28 -0500
>>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>>  
>>>>> Add support for the ad4695's oversampling feature when SPI offload is
>>>>> available. This allows the ad4695 to set oversampling ratios on a
>>>>> per-channel basis, raising the effective-number-of-bits from 16
>>>>> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
>>>>> full cycle through the auto-sequencer). The logic for reading and
>>>>> writing sampling frequency for a given channel is also adjusted based on
>>>>> the current oversampling ratio.
>>>>>
>>>>> The non-offload case isn't supported as there isn't a good way to
>>>>> trigger the CNV pin in this mode. Support could be added in the future
>>>>> if a use-case arises.
>>>>>
>>>>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

...

>> Maybe trick is to reorder into 3 conditions and set the value in a temporary integer.
>>     int val_calc;
>>     if (val > 0)
>>         val_calc = val * 2 + val2 * 2 / MICRO;
>>     else if (val < 0)
>>         val_calc = -(val * 2 - val2 * 2 / MICRO);
>>     else /* Only now does val2 sign matter as val == 0 */
>>         val_calc = val2 * 2 / MICRO;
> 
> I've been testing out these simplifications (but using the scaling suggestion from below, which is great - for some reason I had it in my head that doing so wasn't an option).
> 
> These seem to have some issues with signs for particularly small calibbias values. I think it's because while my (val2 < 0) case was doing unnecessary clamping, the math itself was OK.
> 

Mail is easier to read when wrapped to 80 chars. ;-)


> I did some more experimenting, and came up with a new version of the function that looks like this:
> 
> static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
> {
>         int val_calc, scale;
> 
>         switch (osr) {
>         case 4:
>                 scale = 4;
>                 break;
>         case 16:
>                 scale = 2;
>                 break;
>         case 64:
>                 scale = 1;
>                 break;
>         default:
>                 scale = 8;
>                 break;
>         }
> 
>         /* Note that val2 > 0 if val != 0 and val2 range +- MICRO */

This comment doesn't seem 100% accurate. val2 range is (-MICRO, MICRO) if
val == 0 or [0, MICRO) if val != 0.

>         if (val < 0)
>                 val_calc = val * scale - val2 * scale / MICRO;
>         else if (val2 < 0)
>                 /* if val2 < 0 then val == 0 */
>                 val_calc = -(-val2 * scale / MICRO);

Could also write this as `val2 * scale / (int)MICRO` lest someone try to remove
the double negative and break it (because MICRO is unsigned).

This also calls into question if MICRO and similar macros should actually be
unsigned because it can lead to subtle bugs since it is perfectly reasonable
to expect -1 * MICRO to be -1000000, but it isn't.

>         else
>                 val_calc = val * scale + val2 * scale / MICRO;
> 
>         val_calc /= 2;
> 
>         return clamp_t(int, val_calc, S16_MIN, S16_MAX);
> }
> 
> This seems to match all of the expected outputs for the pre-simplification version in this patch series when I test it. If there are no issues with it, I'll send a v2.

Probably not a big deal, but there is unhanded overflow when val is near S32_MAX
or S32_MIN.


