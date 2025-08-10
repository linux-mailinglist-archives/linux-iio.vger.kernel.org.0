Return-Path: <linux-iio+bounces-22536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F6B1FBDE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 21:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E7A1732EE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63E1F5433;
	Sun, 10 Aug 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgWVyE3G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA211E515
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754853950; cv=none; b=rhj8TZQr97RGlTTAB/LXVu+Smb+SsYRIFhqurq78M/56fEuRfhMNULHCCQZ+tvoXCcqL9ETAU9lXp9mv4EGSJ8ZOCQZMzAO6cq6mHr6RCA597qSv7yvE3vNY5T9O3CEYzD+e6+hulm8hoUi4B+eAmFNNkITbip0a2DJSHQM/ACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754853950; c=relaxed/simple;
	bh=W+M9fQ0NnMCLokrWe/jzMU5TB1XZmm6CTNkWSpz/B2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRV/0VjmKVDfPxSX9jFjO23GwLd3CaluDImX85BIogCCCoFnIHBJvzFb8DztHqjWiu4j2NMrJxuIXLsREbDBEgV9FojY7ieEXvOIZ8iKoxxh0s0+g+S0q21IUChSoHoMzEbtQCtEPANPk5lN1yTdmmEd74QRzdswN+piDzpjXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgWVyE3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9923BC4CEF7;
	Sun, 10 Aug 2025 19:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754853949;
	bh=W+M9fQ0NnMCLokrWe/jzMU5TB1XZmm6CTNkWSpz/B2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KgWVyE3G5N1TT1pkrNRMxi4j50q/A1VT94gO4dhIytNsrqY2cmbVuDNfbu335Nasn
	 xYp3WiDtDGNZiapU/rXmgfjUL0D9mYnI9ZphH4ypf8nSCVFqDmrntW2p2Pz6tt+szR
	 gepQTayJo58KY7SV+Jl4yP2ogpP9j1Z89s2AH8+WJ8lBhWu//YeZWHsYXvrDJFX9YQ
	 mR/Hr6IR+R84LaMncJdjbcaR6bB05R7VfFNpqJ3mcVY8RJ1XhFwZCi9bTcuFSSWDBF
	 RadoC03/tk+wr3IfdabGJHxatkH8Fm0RwLt+P2HcbfM5x+9LRg4wNWDu/BB2pKzVNs
	 jf+/aee2MRFrA==
Message-ID: <73d5746d-a9fb-40c2-9ad2-bcf970683284@kernel.org>
Date: Sun, 10 Aug 2025 21:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-2-hansg@kernel.org>
 <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 29-Jul-25 7:26 PM, David Lechner wrote:
> On 7/27/25 4:06 PM, Hans de Goede wrote:
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
>> Changes in v3:
>> - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
>> - Directly return IIO_VAL_INT from valid cases and drop the final
>>   return ret after the switch-case
>>
>> Changes in v2:
>> - New patch in v2 of this patch-series
>> ---
>>  drivers/iio/inkern.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index c174ebb7d5e6..46900be16ff8 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -714,20 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
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
>>  
>> -		return ret;
>> +		switch (ret) {
>> +		case IIO_VAL_INT:
>> +			*val *= scale;
>> +			return IIO_VAL_INT;
>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +			*val *= scale;
>> +			*val += div_s64((s64)val2 * scale, 1000000LL);
>> +			return IIO_VAL_INT;
>> +		case IIO_VAL_INT_PLUS_NANO:
>> +			*val *= scale;
>> +			*val += div_s64((s64)val2 * scale, 1000000000LL);
>> +			return IIO_VAL_INT;
> 
> I would feel better if we had some kunit tests on this function since
> the negative values can be tricky. I.e. something similar to
> iio_test_iio_format_value_fixedpoint() that tests the 4 possible
> interesting cases for val and val2.
> 
> I think that would find a bug here. For example, if the processed
> value is -1.5 with IIO_VAL_INT_PLUS_MICRO, then *val would be
> -1 and *val2 would be 500_000 (before applying scale). And suppose
> scale is 2. The expected result would be -1.5 * 2 = -3. But the math
> here is:
> 
> -1 * 2 + 500_000 * 2 / 1_000_000 = -1 != -3

Ack, after looking at iio_format_value and the kunit test for this
I believe I know how this is supposed to work now.

Note that it seems that iio_convert_raw_to_processed_unlocked()
also seems to get this wrong when the channel scale attribute
is smaller then -1, e.g. your -1.5. Actually it seems that
the code in iio_convert_raw_to_processed_unlocked() is making
the exact same mistake you are highlighting in my code :)

I'll prepare a patch series to try and deal with this.

Regards,

Hans



