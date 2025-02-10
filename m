Return-Path: <linux-iio+bounces-15298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7BBA2FAD9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E210A3A4673
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2A264615;
	Mon, 10 Feb 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yjrkPaox"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B9264603
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220126; cv=none; b=uRVYzCtDO1fypi5nHjURclFsVApjW9AWG0KHVf3RoaJqEo/x9bxyQ0FovTDMeOMePUJ9A8p8yuosYNbODllmmyvLs+tTAFleMLvsx/4m3yzq19CfHvoiMk+3bCm207R5Vmnsdi+gUV9ZIILNGN+9zdCx2F3hf0NtVGV+LPxZ9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220126; c=relaxed/simple;
	bh=LZK52sN6xKz5e0cxi1jyEskOoHVCK0oOXBq8lcjmYI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1YsEQsk62syysnCR30ckbU46Cmuwjl1IEScNLjN3qDeR/+Nw2H/H6+09tsVIYVYWb/xX/v4PW97bx0mn+wKUaQE5/a0PCzfoR99bYWgIaUIFzVksF2cNvb0wZyRRdTwamqgu7Bg8hQc+gJH2hNrq9XczjXdv4gXBQp8LKkjq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yjrkPaox; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c05b91245fso95284685a.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739220122; x=1739824922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWIqkfiAlllX+sdfSqusAXqRIO/gfWorBPQNzhmxr6s=;
        b=yjrkPaoxjWtBxU61ItyKHkOOh5F2hQafUXVfxx8Hp+aPzWfdqxrHcLNxTs64FK9fgz
         7Gc7p2GjoCg5pxP8vSOGaCJ8FerF4v3cF5cFS08OOJ5M5wQEk28ZS0tV3+FOL+xj3Jv5
         XCt07GBPCzII700EU8jptDhrLD3gSzwAE2VlKkHXhVMkbFTzca78SsqUyyzuc8WWQjUX
         2Rn+oUZNL6Fe4p3dWY3QiMZFnddT04f1AQ54lT/7p7Pi8LNrUVHiX/RQsJEugPS/9MFQ
         Y3+Hi5zVB7E8FRo8iINtJAUMPcce2Qfzj3xeLC/9LR+Fh3NbEOdddwor0CUsSHr43r8W
         AcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220122; x=1739824922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWIqkfiAlllX+sdfSqusAXqRIO/gfWorBPQNzhmxr6s=;
        b=ZBJJbWv4QyIBonH/65kUY6osimlnZwcAY1W5a2e34uhlsW34ZtK1L9lgKbeyEC42LD
         77ow/Xr5pIeLD0pZMuQr7zDgebF/a+1bh4fd2AM9I2QxGOZC73QN6t5Og9qKckKXnzSp
         EEF2h7v/tO2mtYucqnkisTHemj712EX0LXK9XJbs68EYY4sp4NOsm8WsNGMEa9SgqD2H
         IRVouMgfXAyCwCmtg+NSvBVjnLHr1QLCwC3FxGqv9QJx0YoZu4tCqg8uGtJvTs1gX6aG
         PIafEObl8IYv8+O1T/IalYtyr5Zb7Nab0CEnLv2ZkFAjRIOGJQhmpkUh2t0ANKgnchPa
         ft6A==
X-Forwarded-Encrypted: i=1; AJvYcCUdsrIuUT1tueaPyrLPXC6kYVuNf3cUDm8+lKLHsrJrxX9gs/hMc2vxkirw+unN1G0f6OIJMzLI1+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWoynO5oMO3nNFpegN95sZFEshrf4KQjgbPqfQH/+Let8UGvA
	FF21O1Yqb6waxkB26HXK5a8QWpwpyWEV403Zb4hC6V53GY1Q0499wO2NzM6MAxg=
X-Gm-Gg: ASbGncvdiSu1NyxvxT3/b+2rGpgIEIVqrpAnSypaQskZjNcxU9c4XgLsBguTxuC5kfd
	8kuAMeyq/38vqufF5I04EB6cpb6kbGyOZ0s1rUorX0naLZUS0gJfysuqt1HDrJ0r3T4Oy0+2xCZ
	WfAEJBbwLtLE/JksHsKgj5oicOsi7pYtyAXd5ePhJxHzr5WtzEcPd40mTZMk0Xo5M/6Fg0E16m0
	6rr6sduCYoOfS5Ao0hEuohXNyWQmp7v6Tpr9T002Az/OKHRLcSN+VDq2D5p5SHjI43kWLDtLgvc
	dPWWq+aeUXxv9oZAG3nQJilVDqDuS8XOCHqII2kqsNGhIXPhNQEiGMhtH5g=
X-Google-Smtp-Source: AGHT+IEMjXJvDef9P4rap26kwWYFjE5BNIyxGYznn1+Pr0PfR68QMcTrO7XUW+fLRJcbcMtrdSheew==
X-Received: by 2002:a05:620a:25c9:b0:7b6:dc74:82ac with SMTP id af79cd13be357-7c047ba6246mr1979567385a.1.1739220121869;
        Mon, 10 Feb 2025 12:42:01 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041decf43sm574544985a.7.2025.02.10.12.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:42:01 -0800 (PST)
Message-ID: <c03ec6fb-8cde-47b6-82e5-e91723dd7af3@baylibre.com>
Date: Mon, 10 Feb 2025 15:41:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
 <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
 <e3fd7f56675908a60d8ce6bcb6ad4f05b828e132.camel@gmail.com>
 <efba6746-47a6-484f-ade5-f1e17246ac68@baylibre.com>
 <20250210190338.484c463e@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20250210190338.484c463e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-02-10 14:03, Jonathan Cameron wrote:
> On Mon, 13 Jan 2025 11:49:49 -0500
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> On 2025-01-13 09:35, Nuno Sá wrote:
>>> On Thu, 2025-01-09 at 13:47 -0500, Trevor Gamblin wrote:
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
>>>> ---
>>> LGTM, just one small thing inline... Either way:
>>>
>>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>>>   
>>>>    drivers/iio/adc/ad4695.c | 333 ++++++++++++++++++++++++++++++++++++++++++----
>>>> -
>>>>    1 file changed, 303 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
>>>> index c8cd73d19e86..0caaeaa310ed 100644
>>>> --- a/drivers/iio/adc/ad4695.c
>>>> +++ b/drivers/iio/adc/ad4695.c
>>>> @@ -79,6 +79,7 @@
>>>>    #define   AD4695_REG_CONFIG_IN_MODE			  BIT(6)
>>>>    #define   AD4695_REG_CONFIG_IN_PAIR			  GENMASK(5, 4)
>>>>    #define   AD4695_REG_CONFIG_IN_AINHIGHZ_EN		  BIT(3)
>>>> +#define   AD4695_REG_CONFIG_IN_OSR_SET			  GENMASK(1, 0)
>>>>    #define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
>>>>    #define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
>>>>    #define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
>>>> @@ -127,6 +128,7 @@ struct ad4695_channel_config {
>>>>    	bool bipolar;
>>>>    	enum ad4695_in_pair pin_pairing;
>>>>    	unsigned int common_mode_mv;
>>>> +	unsigned int oversampling_ratio;
>>>>    };
>>>>      
>>> ...
>>>   
>>>> +
>>>> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
>>>> +{
>>>> +	int val_calc, scale;
>>>> +
>>>> +	switch (osr) {
>>>> +	case 4:
>>>> +		scale = 4;
>>>> +		break;
>>>> +	case 16:
>>>> +		scale = 2;
>>>> +		break;
>>>> +	case 64:
>>>> +		scale = 1;
>>>> +		break;
>>>> +	default:
>>>> +		scale = 8;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	val = clamp_t(int, val, S32_MIN / 8, S32_MAX / 8);
>>>> +
>>> Why not clamp()? AFAICS, we have the same type on all the arguments. I also
>>> think clamp*() macros got the same improvements as min/max() ones which means
>>> that using the ones with explicit casts are not so often needed anymore. My
>>> understanding is also that those macros are not that encouraged as it's easy to
>>> go wrong with the casts.
>> I have no preference, this is just a recent habitual use of clamp_t(). If
>> clamp() is preferred I can send a v3. Or maybe Jonathan can tweak it
>> when it is
> I've left it as clamp_T for now.  We can always follow up with a series
> to tidy these up general.
>
> Series applied though a bit provisionally as the SPI offload set needed
> a few tweaks that might get changed.
>
> Pushed out as testing for now.
>
> Thanks,
>
> Jonathan
Thank you!


