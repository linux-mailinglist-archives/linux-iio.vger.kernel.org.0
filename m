Return-Path: <linux-iio+bounces-21840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6FB0CAB8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 20:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06367A7666
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 18:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359D21FF45;
	Mon, 21 Jul 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5QrpwzZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF521FF2B
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124133; cv=none; b=Gj5B+OidhIvvHamH8WH1Mz2tWck6ZgHICwmueK0nbj4hB2ZUo0eAGIBZEWKRY0UiHsFmJ1e5vmkmDvgamqKvMUkLp4fGaGOnTozrxZrRDkkUyHcSoOI3D9+CsA3GYOtkBLePUWhHR1UZKB53TSmx7TnOc7cUjZPwfgwQ/allDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124133; c=relaxed/simple;
	bh=UWmm0U08qalgvcEn0ImNVRoC5yXR3yGRa1ihzOVVXD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umZpqMyCsMoagDs8wyYp5qFKJOKJx/Gj8kuc9YiCeFLYaZLouKl52bEejsidKW2aE6PVzzIAD9ZZArbrM+0K9IRLHoBju8afQNRNnaWNmNULydJhifbeUOk/tVMll9C4jPO1EuqQblrnLMHAb/UshylKgtBbvPMuFOY78Aqivi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5QrpwzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8134C4CEED;
	Mon, 21 Jul 2025 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124133;
	bh=UWmm0U08qalgvcEn0ImNVRoC5yXR3yGRa1ihzOVVXD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i5QrpwzZg6lOE4NFlnmhIrN7oFbRiUjgyjUGFjjG2Ke0Quv7J7BfG6mGfrZjv745q
	 lrb/RTPEEYTTHWA/a+SyjEtnhr+G2t3Imx9QtBdVGMGRW1mbQKi5Q5Q2xIQmwik31c
	 a/OfSrkxG/r4DxnsTB1bbiC96/ZymE4unpZbpTyEDCHe9pErUjBmUIvzzX2bHvmgNb
	 MxCS0CFO8XhcrdlL/4EA8+bO3+wmX9Sp2qOSNXg5eCzz4Nl/05WiA0+2QH4SsdjZRI
	 PmE/WaAkfG8ZqftQGMK1XH7fGsSxZUaOx6jbcE3XFptzmxDcOIzWtSfEd4XYVd1rvA
	 DLf9dnBsIHxwA==
Message-ID: <b396496a-5b53-4d68-910e-3b8eb21f3097@kernel.org>
Date: Mon, 21 Jul 2025 20:55:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
 <73409000-c68b-4c22-966e-aaa56ca3744b@baylibre.com>
 <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
 <86d38006-b7e0-4b01-82e3-779896c9b091@baylibre.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <86d38006-b7e0-4b01-82e3-779896c9b091@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21-Jul-25 8:51 PM, David Lechner wrote:
> On 7/21/25 1:42 PM, Hans de Goede wrote:
>> Hi David,
>>
>> Thank you from your review.
>>
>> On 21-Jul-25 7:59 PM, David Lechner wrote:
>>> On 7/21/25 10:06 AM, Hans de Goede wrote:
>>>> Before this change iio_read_channel_processed_scale() always assumes that
>>>> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
>>>> IIO_VAL_INT on success.
>>>>
>>>> Ignoring any fractional values from drivers which return
>>>> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
>>>> might become non fractional after scaling so these should be taken into
>>>> account.
>>>>
>>>> While at it also error out for IIO_VAL_* values which
>>>> iio_read_channel_processed_scale() does not know how to handle.
>>>>
>>>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>>>> ---
>>>> Changes in v2:
>>>> - New patch in v3 of this patch-series
>>>> ---
>>>>  drivers/iio/inkern.c | 24 +++++++++++++++++++++---
>>>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>>> index c174ebb7d5e6..e9669f552eb3 100644
>>>> --- a/drivers/iio/inkern.c
>>>> +++ b/drivers/iio/inkern.c
>>>> @@ -714,18 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>>>>  				     unsigned int scale)
>>>>  {
>>>>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>>>> -	int ret;
>>>> +	int ret, val2;
>>>>  
>>>>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>>>>  	if (!chan->indio_dev->info)
>>>>  		return -ENODEV;
>>>>  
>>>>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>>>> -		ret = iio_channel_read(chan, val, NULL,
>>>> +		ret = iio_channel_read(chan, val, &val2,
>>>>  				       IIO_CHAN_INFO_PROCESSED);
>>>>  		if (ret < 0)
>>>>  			return ret;
>>>> -		*val *= scale;
>>>> +
>>>> +		switch (ret) {
>>>> +		case IIO_VAL_INT:
>>>> +			*val *= scale;
>>>> +			break;
>>>
>>> Just return 0 here.
>>
>> Hmm, before this commit this function used to return the iio_channel_read()
>> value as is, so e.g. IIO_VAL_INT. So this would be a behavior change.
>>
>> I checked and at least drivers/iio/afe/iio-rescale.c relies on
>> the current behavior of returning IIO_VAL_INT, etc.
> 
> Ah right. So all successful cases should now return IIO_VAL_INT
> even when the original processed was something else since we
> are scaling an truncating it as an int.
>>
>>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>>> +			*val *= scale;
>>>> +			*val += div_u64((u64)val2 * scale, 1000000LLU);
>>>
>>> If the processed value is between 0 and -1, then val2 will be negative
>>> (val is 0 in this case, which can't be negative so val2 contains the
>>> sign), so casting without checking the sign first isn't safe.
>>
>> Ah ok, so I'll change the 2 u64-s here to s64 then. I originally
>> had copied this from iio_convert_raw_to_processed_unlocked() with
>> s64 but then thought I might as well make it u64, now I've learned
>> I should not have changed this ...
>>
>>> Also, would just use MICRO from linux/units.h instead of 1000000LLU.
>>
>> iio_convert_raw_to_processed_unlocked() uses 1000000LL, so for
>> consistency I would prefer to change this to 1000000LL (dropping the 'U').
>>
>>>> +			break;
>>>> +		case IIO_VAL_INT_PLUS_NANO:
>>>> +			*val *= scale;
>>>> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);
>>>
>>> Same applies here of course.
>>
>> Ack.
>>
>>>> +			break;
>>>> +		default:
>>>> +			dev_err_once(&chan->indio_dev->dev,
>>>> +				     "unsupported processed IIO-val-type: %d\n",
>>>> +				     ret);
>>>> +			return -EINVAL;
>>>> +		}
>>>>  
>>>>  		return ret;
>>>
>>> And drop this return as all cases should return directly.
>>
>> See above.
>>
>> Also IIRC some older gcc versions will complain about a missing ret,
>> even if there is a switch case with a default: label and all cases
>> returning.
> 
> We do early returns in switch statements like this in the IIO subsystem
> and haven't had any issues with complaints from older compilers. So I
> think it would still be preferred to do it that way to be consistent
> with the rest of the subsystem.

Ok, I'll make all the cases early return IIO_VAL_INT and drop the
return ret at the end.

Regards,

Hans


