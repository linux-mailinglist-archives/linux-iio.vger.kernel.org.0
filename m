Return-Path: <linux-iio+bounces-21839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98188B0CAB1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3BE5420E1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FF21D5AF;
	Mon, 21 Jul 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/pyTlpi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7921D3DD
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123881; cv=none; b=Eqx2wmJgOPFaBICgUtmbdeaulkk9e4G7HsZQo8/F0y51Jj5SBGf/2pbvMOUB3IkL9HkeIPLQqy8n7YeWc84aN3XI82L02vny+mIbBCtBAyWpx2LnvOqcqjKD5B36PIA3Ti5lTv0aBXqHNNW2x+9J6ZaR86uEchGGNBp4Q3/QxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123881; c=relaxed/simple;
	bh=nECqZziWuj+AKYwR+UtO0WjbfPz5uWt0FUasJ1dk0Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfkQ8131XBItA38brllrpO5CpUlTLiLtZkztXA4Qs0bNPza8TDwuVQveIVEMv79riXhSxFrK6IFJgn0QOfaD9cI+aBrOZ9nYv5h/ih4ekJlvz5/UaWs9WkxGzB2FwbuU2sosWeF8XmwOscmghaHgtGUziMHVvWAkfPwnDOC88EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I/pyTlpi; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60402c94319so2275018eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753123878; x=1753728678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfxnaeHNf0aLZjSPBkLtv0u1LpEE8Ed1Ce6E/YSlzcs=;
        b=I/pyTlpiXxPJKENum3/B+RW72fowBF5PoGL/Gz4fcdmeHoAT8Q6vFYKtTI3v2XZ6C5
         zOH21z1piNTJKaEPyXmYIPot69R+rNb6VdfHPRnPFmGIYVcOc8kHdFjHeNu8TkbdqMW6
         +W0OKXc7bQ1mlT7/7K4qsWF6PGkb7mRPW9TxfuDe9IS1Sj3rxADiRJUdVQK1nNelc2mi
         j0Nh1e2R8axtPQPUM9j3AB6OIDiBlUCOmZPhxjB2U//ofy2GXolZ/8gPt9M66aEXedXq
         yPBrgeDq46QUzmc+yc54ChNEziZh5kOyKsTUYlKjHM9rvPxON15i4GbHc9JixcQYF4FM
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753123878; x=1753728678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfxnaeHNf0aLZjSPBkLtv0u1LpEE8Ed1Ce6E/YSlzcs=;
        b=hTLB2u4kUpWAnCxXW9ixrKTaI9wOsOfelGHkAv0O8BudRQ+YqUpc+dvI1dl84d/uT/
         bs91+gQqylEGm/+ZX0flmcSSn1M4SK9Esye6wFYCzMtvdhizsOkDyDW+UG3H8ETw8W5o
         YIDrHphyDJKuAqbh9vfBQN3h366vj2AL+rYi75y1PReY9NRufY3ZSSnXVvUlBiOG5hd9
         NLYPoyDg4Tri9Woy5qUJR5ZCBnhPf6aY8/S9Yf3qCmFaE6+a7s6opHxUN2UX8S6HL6Py
         5JLNrN9yjbxVfghcIAYQx8EJPh2u7CtDa2riXJUFvCpsUiJgzlS3vNi+CBFCcAcW9ceV
         lmgg==
X-Forwarded-Encrypted: i=1; AJvYcCWSww6PVaDjhhyDwyXT1zD0eU73fLqJCawesA1+RusUiy/3JIGDrLlinPM9KfGD1TmN86TLgACzKiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NzgHakOGOzrbvP75oLfOFq41Cw/86rPXoN+m5hVAl1kBKqyZ
	yIiNQEtT+hUYCQpeHBQdr+oYbLeM+5SrHDEGBNBZqmEOIM2scqTuEqbNL/aVI64zKLQ=
X-Gm-Gg: ASbGnct3rrMCEEe2o/LWl19Crar+QEnyDGDJQ/9DwL4wB+ExVI+ZnC7gQL6R+zD9zeN
	nVH3YieDmRZFAQ4v4ARlLyI/Gym7cpY7RGsCNUavb2AeYIFUwLn16mmEXFoT9HI68RrLw7GyA62
	n/A2hF3ViSvtlM5VDAjKv9Nf9h4KPFEamYQnZkg3uBYt2bko6Ea0M2/Rj7mnoyYVGn6qxW4K3wo
	8k8AHEMxWZJ12zXSbb0oTyTi4h6dfT8YLmh/3RJordiqqEid6XsItXpASOPwvutGHwQoFhWLq9z
	DC+juklL/9vg3rheEKHLy0BQBSe7tSxyDe28KYWq64A7iTfFB8igeAOdX17cOe1gm60SyldPM7k
	E4PqO7bNmVqZ9kFbbaLKzPe8M7uY5onYPS/8gmCOMP/OeMksWERvAUf17IP7VtXiAjBpJUxeLVB
	U=
X-Google-Smtp-Source: AGHT+IHaJjEL1Gp2Ho+pA1tatTv89QHKWm/BOtcbdDsG+9qI68YjZwdTNsHZOC8y9IQq5XHrIzMGPQ==
X-Received: by 2002:a05:6820:4ccb:b0:615:c599:36af with SMTP id 006d021491bc7-615c599387fmr9810006eaf.1.1753123877762;
        Mon, 21 Jul 2025 11:51:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcec793dsm2220343eaf.35.2025.07.21.11.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 11:51:17 -0700 (PDT)
Message-ID: <86d38006-b7e0-4b01-82e3-779896c9b091@baylibre.com>
Date: Mon, 21 Jul 2025 13:51:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
 <73409000-c68b-4c22-966e-aaa56ca3744b@baylibre.com>
 <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 1:42 PM, Hans de Goede wrote:
> Hi David,
> 
> Thank you from your review.
> 
> On 21-Jul-25 7:59 PM, David Lechner wrote:
>> On 7/21/25 10:06 AM, Hans de Goede wrote:
>>> Before this change iio_read_channel_processed_scale() always assumes that
>>> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
>>> IIO_VAL_INT on success.
>>>
>>> Ignoring any fractional values from drivers which return
>>> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
>>> might become non fractional after scaling so these should be taken into
>>> account.
>>>
>>> While at it also error out for IIO_VAL_* values which
>>> iio_read_channel_processed_scale() does not know how to handle.
>>>
>>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>>> ---
>>> Changes in v2:
>>> - New patch in v3 of this patch-series
>>> ---
>>>  drivers/iio/inkern.c | 24 +++++++++++++++++++++---
>>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>> index c174ebb7d5e6..e9669f552eb3 100644
>>> --- a/drivers/iio/inkern.c
>>> +++ b/drivers/iio/inkern.c
>>> @@ -714,18 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>>>  				     unsigned int scale)
>>>  {
>>>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>>> -	int ret;
>>> +	int ret, val2;
>>>  
>>>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>>>  	if (!chan->indio_dev->info)
>>>  		return -ENODEV;
>>>  
>>>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>>> -		ret = iio_channel_read(chan, val, NULL,
>>> +		ret = iio_channel_read(chan, val, &val2,
>>>  				       IIO_CHAN_INFO_PROCESSED);
>>>  		if (ret < 0)
>>>  			return ret;
>>> -		*val *= scale;
>>> +
>>> +		switch (ret) {
>>> +		case IIO_VAL_INT:
>>> +			*val *= scale;
>>> +			break;
>>
>> Just return 0 here.
> 
> Hmm, before this commit this function used to return the iio_channel_read()
> value as is, so e.g. IIO_VAL_INT. So this would be a behavior change.
> 
> I checked and at least drivers/iio/afe/iio-rescale.c relies on
> the current behavior of returning IIO_VAL_INT, etc.

Ah right. So all successful cases should now return IIO_VAL_INT
even when the original processed was something else since we
are scaling an truncating it as an int.
> 
>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>> +			*val *= scale;
>>> +			*val += div_u64((u64)val2 * scale, 1000000LLU);
>>
>> If the processed value is between 0 and -1, then val2 will be negative
>> (val is 0 in this case, which can't be negative so val2 contains the
>> sign), so casting without checking the sign first isn't safe.
> 
> Ah ok, so I'll change the 2 u64-s here to s64 then. I originally
> had copied this from iio_convert_raw_to_processed_unlocked() with
> s64 but then thought I might as well make it u64, now I've learned
> I should not have changed this ...
> 
>> Also, would just use MICRO from linux/units.h instead of 1000000LLU.
> 
> iio_convert_raw_to_processed_unlocked() uses 1000000LL, so for
> consistency I would prefer to change this to 1000000LL (dropping the 'U').
> 
>>> +			break;
>>> +		case IIO_VAL_INT_PLUS_NANO:
>>> +			*val *= scale;
>>> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);
>>
>> Same applies here of course.
> 
> Ack.
> 
>>> +			break;
>>> +		default:
>>> +			dev_err_once(&chan->indio_dev->dev,
>>> +				     "unsupported processed IIO-val-type: %d\n",
>>> +				     ret);
>>> +			return -EINVAL;
>>> +		}
>>>  
>>>  		return ret;
>>
>> And drop this return as all cases should return directly.
> 
> See above.
> 
> Also IIRC some older gcc versions will complain about a missing ret,
> even if there is a switch case with a default: label and all cases
> returning.

We do early returns in switch statements like this in the IIO subsystem
and haven't had any issues with complaints from older compilers. So I
think it would still be preferred to do it that way to be consistent
with the rest of the subsystem.

> 
> Regards,
> 
> Hans
> 
> 


