Return-Path: <linux-iio+bounces-13994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A2A04AE6
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 21:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9D3166EF9
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3241F5403;
	Tue,  7 Jan 2025 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lmOspixe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82418D620
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281301; cv=none; b=ZutpjPvJvZEMyRg9GnjAa+me4UmGtJC701PePEw8/45brU7OHMqUY5Tb/MPcTssqjglglVNzArgTdGWSoFtI3QS41DlX73CwY2IVovBvctcvvWAdgdp0napD9qbvFufRlH7SNNQQ6xvnK3d8p6vS6HkjwxZJMX+IengWPw69N+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281301; c=relaxed/simple;
	bh=DDCF/bACMSBCaQ0r8jqYjpUgAM3Mv9a8r7t9AFsTiyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qadCgr627pkd71wKWjUqjItfVm/gJUYLYhxYU4ArFBwDwpLQ4LQFJHk4FMR5R+JSnFt4QSWJYn4z3pFBjvuk6q6gI/urkYpl95IzvC/c9Plw25MNJg+qtlhsxqGstJyWn3++lMR8VGnwK4QBG/ZO3Ovu5ETiP+/rrLzpEaTYjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lmOspixe; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-468f6b3a439so133600811cf.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736281297; x=1736886097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZXED0N0ifdmys79THqoBFcO9C/LEJOBvhpy2BpHB1o=;
        b=lmOspixe52FF1coI5NB0U6z49BH3mVxWOz7ys2+JLZ0tE/jCKmB633FfDKNn4p8SV7
         grwSw79FHt3hIwt27SHr3R2VSTvxlFVwl2jKiQoKmfi8XMRxThDXrJhXbZzSpAI6B/em
         YYd73evx+GnroeH9p5litVQvnMeenp1f6+i7TcRpoe6YTziE1wVpd8++QLiKhhp7Id43
         QzYXAX/VmaxZHT5v4KijDOYbdLBG5UX5yCuMpu0IH69PkjeY7/+EAnazqEJaB+k5haie
         ND7g4+IkIGAt5VDDzr9t2/3n+pc/SULGpuQIUNhwluUEAKI178azIjk3nY4fPcCw+NRV
         O9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281297; x=1736886097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZXED0N0ifdmys79THqoBFcO9C/LEJOBvhpy2BpHB1o=;
        b=nJ5L2FZA/MjFL4EHSE0N+1vzymjzvhQqyRFMAldzMurGazFwEAgn1ALfCiBBCyErFU
         ep2f4/MPbQbYP3zK5SnB18iSYJpUdKpQsQK26sXuCFhAWRFq5BgIHh7wiOOj2DJ9/fy1
         tpni4AOwUgzXugxDehqqc7BAT9ivmimO97IrTcDg2gDiF5fIdN0NA1wQzOvBjZR5oFG4
         Kd8GQDSRPNVV/B62QbAuzEimTdtxafUnZeTYBbI3b06r/pMWJiA9GmxZgnvVzcSc4p9b
         McblKkAlY3s/y04nB3NzRIOZVzdIsScRaTEuKqYHHu19yERLPQf31sfFNRWu1jyEw/Ay
         V3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUld8Hrn4prvsXZCpL/Gi5UunaVevdld9n6dtETANgKpt4+O8lOgo1Lj2ZFUEURONnLm4rv7ACA7V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnAnsQGxcaxSKkZUEK8BXXSrNBkTUK6YyV7LrPfJ5QLYWHK58
	gNgTYtTMq024P+Bik4bFiBF17W29mzcH51uWknZXzRyEqUEoEtts+C0D5DSnKo8=
X-Gm-Gg: ASbGncsAZEPfxP7We0pZzE4nkhvI9WVBPZ28ZIv9hH7+yzoDSpAg3v8GfI2sBD1jgst
	s6PnIsSfn6GIAQ2Y2oRg76eUvEiGfuVshSPBpzpveG136i7NyCFRFLeAUCxtkNP1o0oTQSxMwPH
	NvjqQYFmmXBbH/dEXn75Z46nfpvNnHzBIvcPjyifth9lSayxbc9+Gf3/SrtDnpQRAXswxEf4sPO
	yUDnTMSFUer5rM2ECgaNFI9dken6L2NA2suojNmh8TTT/2elhrbtGptzECoOnjjjOeHX8y/nqEd
	ASqCbnrj7FZKt/E3EDwDCT8j
X-Google-Smtp-Source: AGHT+IEk8eY06r7V6KzVmBOZ2xkke3SXkW/Ijdj5K0dkEnUZEQU7ux5vyTTDmHg0pLosEs+8Rntjng==
X-Received: by 2002:a05:622a:11d4:b0:467:451b:eba3 with SMTP id d75a77b69052e-46c70fd2146mr3541411cf.8.1736281296934;
        Tue, 07 Jan 2025 12:21:36 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e677a55sm188887291cf.27.2025.01.07.12.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 12:21:36 -0800 (PST)
Message-ID: <9128ecae-73e9-4a66-8cd0-4d98c14ff05f@baylibre.com>
Date: Tue, 7 Jan 2025 15:21:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
 <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
 <20241219161301.3f708302@jic23-huawei>
 <1c641b37-475a-4153-bcfc-e0e72d79fa76@baylibre.com>
 <20250104123029.12a4e19e@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250104123029.12a4e19e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-01-04 07:30, Jonathan Cameron wrote:
> On Thu, 2 Jan 2025 13:19:19 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> On 2024-12-19 11:13, Jonathan Cameron wrote:
>>> On Tue, 17 Dec 2024 16:47:28 -0500
>>> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>>>   
>>>> Add support for the ad4695's oversampling feature when SPI offload is
>>>> available. This allows the ad4695 to set oversampling ratios on a
>>>> per-channel basis, raising the effective-number-of-bits from 16
>>>> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
>>>> full cycle through the auto-sequencer). The logic for reading and
>>>> writing sampling frequency for a given channel is also adjusted based on
>>>> the current oversampling ratio.
>>>>
>>>> The non-offload case isn't supported as there isn't a good way to
>>>> trigger the CNV pin in this mode. Support could be added in the future
>>>> if a use-case arises.
>>>>
>>>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>>> Hi Trevor,
>>>
>>> The clamping fun of get_calibbias seems overkill. If this isn't going to ever
>>> overflow an s64 maybe just use the high precision to do it the easy way.
>>> I'm not sure you can't just fit it in an s32 for that matter. I've just
>>> not done the maths to check.
>>>
>>> Jonathan
>>>
>>>   
>>>> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
>>>> +{
>>>> +	unsigned int reg_val;
>>>> +
>>>> +	switch (osr) {
>>>> +	case 4:
>>>> +		if (val2 >= 0 && val > S16_MAX / 2)
>>>> +			reg_val = S16_MAX;
>>>> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)
>>> It has been a while, but IIRC if val2 < 0 then val == 0 as otherwise
>>> we carry the sign in the val part.  Sometimes we generalize that to
>>> make life easier for driver writers but I think you can use that here
>>> to simplify things.
>>>
>>> (for background look at __iio_str_to_fixpoint() - it's a bit of a hack
>>> to deal with integers have no negative 0)
>>>
>>> 		if (val > S16_MAX / 2)
>>> 			...
>>> 		else if (val < S16_MIN / 2)
>>> 			...	
>>> 		else if (val2 < 0) etc
>>>
>>> You may feel it is better to keep the code considering the val2 < 0 when
>>> val != 0 case and I don't mind that as it's not wrong, just overly complex!
>>>
>>> If you can easily clamp the overall range you can just do some maths
>>> with enough precision to get one number (probably a s64) and clamp that.
>>> Easy to sanity check for overflow based on val to ensure no overflows.
>> Hi Jonathan,
>>
>> I'm reviewing this again but I'm not entirely clear what you mean.
>>
>> Are you suggesting that the entire switch block could be simplified
>> (i.e. eliminating the previous simplification for the val2 < 0 case in
>> the process), or that the calls to clamp_t can be combined?
>>
>> I've tested out simplifying the val2 < 0 case locally and driver
>> functionality still seems OK. Maybe I'm missing a third option.
Hi Jonathan,
> The extra info we can use is that val2 is always positive
> if val != 0 and it never takes a value beyond +- MICRO because
> otherwise val would be non 0 instead.
>
>
> Taking original code and ruling out cases.
> +	case 4:
> +		if (val2 >= 0 && val > S16_MAX / 2)
> // If val is non 0 then val2 is postive, so
> //		if (val > S16_MAX / 2)
> //			reg_val = S16_MAX;
>
> +			reg_val = S16_MAX;
> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)
>
> // If val2 < 0 then val == 0 which is never less than S16_MIN / 2
> // So this condition never happens.
Thanks for catching these.
>
> +			reg_val = S16_MIN;
> +		else if (val2 < 0)
> // likewise, this is actually clamping val2 * 2 / MICRO which
> // is never going to be anywhere near S16_MIN or S16_MAX as I think
> // it is always between +1 and -1 as val2 itself is limited to -MICRO to MICRO
>
> +			reg_val = clamp_t(int,
> +				-(val * 2 + -val2 * 2 / MICRO),
> +				S16_MIN, S16_MAX);
> +		else if (val < 0)
> //This one is fine.
> +			reg_val = clamp_t(int,
> +				val * 2 - val2 * 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		else
> //As is this one
> +			reg_val = clamp_t(int,
> +				val * 2 + val2 * 2 / MICRO,
> +				S16_MIN, S16_MAX);
> +		return reg_val;
>
> Maybe trick is to reorder into 3 conditions and set the value in a temporary integer.
> 	int val_calc;
> 	if (val > 0)
> 		val_calc = val * 2 + val2 * 2 / MICRO;
> 	else if (val < 0)
> 		val_calc = -(val * 2 - val2 * 2 / MICRO);
> 	else /* Only now does val2 sign matter as val == 0 */
> 		val_calc = val2 * 2 / MICRO;

I've been testing out these simplifications (but using the scaling 
suggestion from below, which is great - for some reason I had it in my 
head that doing so wasn't an option).

These seem to have some issues with signs for particularly small 
calibbias values. I think it's because while my (val2 < 0) case was 
doing unnecessary clamping, the math itself was OK.

I did some more experimenting, and came up with a new version of the 
function that looks like this:

static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
{
         int val_calc, scale;

         switch (osr) {
         case 4:
                 scale = 4;
                 break;
         case 16:
                 scale = 2;
                 break;
         case 64:
                 scale = 1;
                 break;
         default:
                 scale = 8;
                 break;
         }

         /* Note that val2 > 0 if val != 0 and val2 range +- MICRO */
         if (val < 0)
                 val_calc = val * scale - val2 * scale / MICRO;
         else if (val2 < 0)
                 /* if val2 < 0 then val == 0 */
                 val_calc = -(-val2 * scale / MICRO);
         else
                 val_calc = val * scale + val2 * scale / MICRO;

         val_calc /= 2;

         return clamp_t(int, val_calc, S16_MIN, S16_MAX);
}

This seems to match all of the expected outputs for the 
pre-simplification version in this patch series when I test it. If there 
are no issues with it, I'll send a v2.

>
> Which can simplify because we know val is 0 for last case.
> Whether this is worth doing depends on trade off between
> docs needed to explain the code and shorter code.
>
> 	/* Note that val2 > 0 if val != 0 and val2 range +- MICRO */
> 	if (val < 0)
> 		val_calc = val * 2 - val2 * 2 / MICRO;
> 	else
> 		val_calc = val * 2 + val2 * 2 / MICRO;
>
> 	reg_val = clamp_t(int, val_calc, S16_MIN, S16_MAX);
> 	
> One trivial additional simplication below.
>
> You might also be able to scale temporary up by 2 and ust
> have the switch statement set a scaling value.
>
> In this case scale == 4 in other cases below, 2, 1, and 8 for the default
>
>
> 	if (val < 0)
> 		val_calc = val * scale - val2 * scale / MICRO;
> 	else
> 		val_calc = val * scale + val2 * scale / MICRO;
>
> 	val_calc /= 2; /* to remove the factor of 2 */
>
> 	reg_val = clamp_t (int, val_calc, S16_MIN, S16_MAX);
> after the switch statement with comments when setting scale on the * 2
> multiplier to avoid the / 2 for case 64.
>
>> - Trevor
>>
>>> 		
>>>
>>>   
>>>> +			reg_val = S16_MIN;
>>>> +		else if (val2 < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				-(val * 2 + -val2 * 2 / MICRO),
>>>> +				S16_MIN, S16_MAX);
>>>> +		else if (val < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				val * 2 - val2 * 2 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		else
>>>> +			reg_val = clamp_t(int,
>>>> +				val * 2 + val2 * 2 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		return reg_val;
>>>> +	case 16:
>>>> +		if (val2 >= 0 && val > S16_MAX)
>>>> +			reg_val = S16_MAX;
>>>> +		else if ((val2 < 0 ? -val : val) < S16_MIN)
>>>> +			reg_val = S16_MIN;
>>>> +		else if (val2 < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				-(val + -val2 / MICRO),
>>>> +				S16_MIN, S16_MAX);
>>>> +		else if (val < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				val - val2 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		else
>>>> +			reg_val = clamp_t(int,
>>>> +				val + val2 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		return reg_val;
>>>> +	case 64:
>>>> +		if (val2 >= 0 && val > S16_MAX * 2)
>>>> +			reg_val = S16_MAX;
>>>> +		else if ((val2 < 0 ? -val : val) < S16_MIN * 2)
>>>> +			reg_val = S16_MIN;
>>>> +		else if (val2 < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				-(val / 2 + -val2 / 2 / MICRO),
>>>> +				S16_MIN, S16_MAX);
>>>> +		else if (val < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				val / 2 - val2 / 2 / MICRO,
> For these val2 / 2 / MICRO always 0 so value of val2 never matters.
>
>>>> +				S16_MIN, S16_MAX);
>>>> +		else
>>>> +			reg_val = clamp_t(int,
>>>> +				val / 2 + val2 / 2 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		return reg_val;
>>>> +	default:
>>>> +		if (val2 >= 0 && val > S16_MAX / 4)
>>>> +			reg_val = S16_MAX;
>>>> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
>>>> +			reg_val = S16_MIN;
>>>> +		else if (val2 < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				-(val * 4 + -val2 * 4 / MICRO),
>>>> +				S16_MIN, S16_MAX);
>>>> +		else if (val < 0)
>>>> +			reg_val = clamp_t(int,
>>>> +				val * 4 - val2 * 4 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		else
>>>> +			reg_val = clamp_t(int,
>>>> +				val * 4 + val2 * 4 / MICRO,
>>>> +				S16_MIN, S16_MAX);
>>>> +		return reg_val;
>>>> +	}
>>>> +}
>>>> +

