Return-Path: <linux-iio+bounces-21837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E1FB0CAA9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AA3B5DCA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA317C21E;
	Mon, 21 Jul 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk3anl/3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAA4689
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123360; cv=none; b=hSy/qAc1Vh+4n1Utt25puQHbCE9vuvqYjBSL+BSFR8cgvXei/5lKwbweN7hNj/+2ETQPfsR5Ct2D5R1gzuNfGbdeVTkmZynRYMrVRCQQAcwOBLokZ6Y06INk4y2XDYOFzzSz0teYQF4Sy5iic0Ut5omaJuErx9iFhGRJBgVvHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123360; c=relaxed/simple;
	bh=beYutf3Qt5f5fAzjsTA00sKRi4E3InlGB2RE9s7itAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZTSR8eJw7T/An1X1rkFP3kBBSj2hR3rEUzeypxrWGo7ZUxK649AJu4KtYCtfQU5PfZ0os9BZuAhyEmWuPNZyxBUFTgUVmSO6w/au/mAWw4L1RvizclEFabevn5sXXPoyAqrzy/F2XHBlQJ2SU+/rAhB1LaufuOlLIKknp/nu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk3anl/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DEC4CEED;
	Mon, 21 Jul 2025 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753123360;
	bh=beYutf3Qt5f5fAzjsTA00sKRi4E3InlGB2RE9s7itAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tk3anl/3s7gS8cr9uIVgUaeQieb3B4ufuRKOCLR/oV3K7CT6l7lv03lcf+beO5MZP
	 WEkXHDHd1Cu93tRzLFvauuKZGc3GuUJeTWNccXf/wp7hA+IR8YGqvwA0lXek0Mjco0
	 uDouaS7yuTKxOC8BY/qBp1kMCDH2ZVMitcGrV5LJlNrJTGyyjyo1uqqO106j/iFhoN
	 bXcQ4wnSACKE8pzQnqkPL1UQlxPZVcP0zLS1qZYcNgmBe+ldS7naYpzGoI3hEiu/gS
	 CZ4rnaoLzoRT/mEq0pxpI+M3LyOUJm7LqzX5fZMqpaqyw7AHthjANDU+RL19/i0D/r
	 hsxxyWBiqdG6w==
Message-ID: <94e006f6-0800-4105-92ed-626399ff62f3@kernel.org>
Date: Mon, 21 Jul 2025 20:42:36 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <73409000-c68b-4c22-966e-aaa56ca3744b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

Thank you from your review.

On 21-Jul-25 7:59 PM, David Lechner wrote:
> On 7/21/25 10:06 AM, Hans de Goede wrote:
>> Before this change iio_read_channel_processed_scale() always assumes that
>> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
>> IIO_VAL_INT on success.
>>
>> Ignoring any fractional values from drivers which return
>> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
>> might become non fractional after scaling so these should be taken into
>> account.
>>
>> While at it also error out for IIO_VAL_* values which
>> iio_read_channel_processed_scale() does not know how to handle.
>>
>> Signed-off-by: Hans de Goede <hansg@kernel.org>
>> ---
>> Changes in v2:
>> - New patch in v3 of this patch-series
>> ---
>>  drivers/iio/inkern.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index c174ebb7d5e6..e9669f552eb3 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -714,18 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>>  				     unsigned int scale)
>>  {
>>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>> -	int ret;
>> +	int ret, val2;
>>  
>>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>>  	if (!chan->indio_dev->info)
>>  		return -ENODEV;
>>  
>>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>> -		ret = iio_channel_read(chan, val, NULL,
>> +		ret = iio_channel_read(chan, val, &val2,
>>  				       IIO_CHAN_INFO_PROCESSED);
>>  		if (ret < 0)
>>  			return ret;
>> -		*val *= scale;
>> +
>> +		switch (ret) {
>> +		case IIO_VAL_INT:
>> +			*val *= scale;
>> +			break;
>
> Just return 0 here.

Hmm, before this commit this function used to return the iio_channel_read()
value as is, so e.g. IIO_VAL_INT. So this would be a behavior change.

I checked and at least drivers/iio/afe/iio-rescale.c relies on
the current behavior of returning IIO_VAL_INT, etc.

>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +			*val *= scale;
>> +			*val += div_u64((u64)val2 * scale, 1000000LLU);
> 
> If the processed value is between 0 and -1, then val2 will be negative
> (val is 0 in this case, which can't be negative so val2 contains the
> sign), so casting without checking the sign first isn't safe.

Ah ok, so I'll change the 2 u64-s here to s64 then. I originally
had copied this from iio_convert_raw_to_processed_unlocked() with
s64 but then thought I might as well make it u64, now I've learned
I should not have changed this ...

> Also, would just use MICRO from linux/units.h instead of 1000000LLU.

iio_convert_raw_to_processed_unlocked() uses 1000000LL, so for
consistency I would prefer to change this to 1000000LL (dropping the 'U').

>> +			break;
>> +		case IIO_VAL_INT_PLUS_NANO:
>> +			*val *= scale;
>> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);
> 
> Same applies here of course.

Ack.

>> +			break;
>> +		default:
>> +			dev_err_once(&chan->indio_dev->dev,
>> +				     "unsupported processed IIO-val-type: %d\n",
>> +				     ret);
>> +			return -EINVAL;
>> +		}
>>  
>>  		return ret;
> 
> And drop this return as all cases should return directly.

See above.

Also IIRC some older gcc versions will complain about a missing ret,
even if there is a switch case with a default: label and all cases
returning.

Regards,

Hans



