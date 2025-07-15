Return-Path: <linux-iio+bounces-21690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23452B06351
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EAA5684B7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03F246BBE;
	Tue, 15 Jul 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j1kYShup"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333823A9A5
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594201; cv=none; b=nc0qdhST3wZNIz3QSTIfGvlDbngmfm3CwIorVqtWHEN5TbvuhuebY+aLx0mq6LDixT2tKX4vUeqlkBrkaIDPdgRUwtOkDJ4OdB1Cz0JdK8xiBD6CoSK+YCkpYnpiZysJDaehrd+KbGHggwxmUVQd+fscKyKU1MaSgjanTlLCiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594201; c=relaxed/simple;
	bh=2qOP//IOuFNiND67qbG03AyZLv8KzplvCeO8jjJwAxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNvhrNiOn9gFo67XV1jKc/ecJcynWBm+xcbCea/NKEk7ZT6uJDvs1wpiVPnXOe54IADoypiaDOp+5mV6L7ufc2qjydvs5xrBvwDaI2ojDkLUr8MTD7c6fBRHnjdXyllywjR6OvMvR/X3T+KvzkcCKd7zQrvme+l/OQRE77+fNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j1kYShup; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e598681-f0a2-4ced-8f68-17384ef95de4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752594197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RmwEJgC6pKX64OYzTfryWl+HVNIeelnAHGQgIarxaCo=;
	b=j1kYShupGRDkHp4Thq1/sbnKdmYAbllmA4OsfD/Dyrdmrr/OzHEQHnlyh7HlrDb8L7xuUg
	5rSGQIhcDkfv1SOOyj+9k5p7MoN/nPWTZAfN2t7pkgA6XtmzIVvEdiFq4B6+owbkXRQOxO
	8JLQZC9R1MLOK6/vnlist3zRvXEz6pk=
Date: Tue, 15 Jul 2025 11:43:14 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-3-sean.anderson@linux.dev>
 <0fad26b4384e4163f4807f6b779361099f505a86.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <0fad26b4384e4163f4807f6b779361099f505a86.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 06:35, Nuno Sá wrote:
> On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:
>> Add an in-kernel API for reading/writing event properties. Like the
>> raw-to-processed conversion, with processed-to-raw we only convert the
>> integer part, introducing some round-off error.
>> 
>> A common case is for other drivers to re-expose IIO events as sysfs
>> properties with a different API. To help out with this, iio_event_mode
>> returns the appropriate mode. It can also be used to test for existence
>> if the consumer doesn't care about read/write capability.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
> 
> Just one comment on top of Andy's review
> 
>> 
>>  drivers/iio/inkern.c         | 198 +++++++++++++++++++++++++++++++++++
>>  include/linux/iio/consumer.h |  56 ++++++++++
>>  2 files changed, 254 insertions(+)
>> 
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index c174ebb7d5e6..d3bbd2444fb5 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -1028,3 +1028,201 @@ ssize_t iio_read_channel_label(struct iio_channel
>> *chan, char *buf)
>>  	return do_iio_read_channel_label(chan->indio_dev, chan->channel,
>> buf);
>>  }
>>  EXPORT_SYMBOL_GPL(iio_read_channel_label);
>> +
>> +static bool iio_event_exists(struct iio_channel *channel,
>> +			     enum iio_event_type type,
>> +			     enum iio_event_direction dir,
>> +			     enum iio_event_info info)
>> +{
>> +	struct iio_chan_spec const *chan = channel->channel;
>> +	int i;
>> +
> 
> Can we iio_event_exists() -> iio_event_exists_locked()? Or likely the best way

wouldn't _unlocked be the convention for this file?

> would be to annotate it with lockdep (though that would mean some dance to get
> the opaque object.

I will add a lockdep annotation.

--Sean

> Anyways, bottom line is it should clear that iio_event_exists() is to be called
> with the lock held.
> 
> - Nuno Sá
> 
>> +	if (!channel->indio_dev->info)
>> +		return false;
>> +
>> +	for (i = 0; i < chan->num_event_specs; i++) {
>> +		if (chan->event_spec[i].type != type)
>> +			continue;
>> +		if (chan->event_spec[i].dir != dir)
>> +			continue;
>> +		if (chan->event_spec[i].mask_separate & BIT(info))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type type,
>> +		       enum iio_event_direction dir, enum iio_event_info
>> info)
>> +{
>> +	struct iio_dev *indio_dev = chan->indio_dev;
>> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> +	umode_t mode = 0;
>> +
>> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>> +	if (!iio_event_exists(chan, type, dir, info))
>> +		return 0;
>> +
>> +	if (info == IIO_EV_INFO_ENABLE) {
>> +		if (indio_dev->info->read_event_config)
>> +			mode |= 0444;
>> +
>> +		if (indio_dev->info->write_event_config)
>> +			mode |= 0200;
>> +	} else {
>> +		if (indio_dev->info->read_event_value)
>> +			mode |= 0444;
>> +
>> +		if (indio_dev->info->write_event_value)
>> +			mode |= 0200;
>> +	}
>> +
>> +	return mode;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_event_mode);
>> +
>> +int iio_read_event_processed_scale(struct iio_channel *chan,
>> +				   enum iio_event_type type,
>> +				   enum iio_event_direction dir,
>> +				   enum iio_event_info info, int *val,
>> +				   unsigned int scale)
>> +{
>> +	struct iio_dev *indio_dev = chan->indio_dev;
>> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>> +	int ret, raw;
>> +
>> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>> +	if (!iio_event_exists(chan, type, dir, info))
>> +		return -ENODEV;
>> +
>> +	if (info == IIO_EV_INFO_ENABLE) {
>> +		if (!indio_dev->info->read_event_config)
>> +			return -EINVAL;
>> +
>> +		raw = indio_dev->info->read_event_config(indio_dev,
>> +							 chan->channel, type,
>> +							 dir);
>> +		if (raw < 0)
>> +			return raw;
>> +
>> +		*val = raw;
>> +		return 0;
>> +	}
>> +
>> +	if (!indio_dev->info->read_event_value)
>> +		return -EINVAL;
>> +
>> +	ret = indio_dev->info->read_event_value(indio_dev, chan->channel,
>> type,
>> +						dir, info, &raw, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return iio_convert_raw_to_processed_unlocked(chan, raw, val, scale);
>> +}
>> +EXPORT_SYMBOL_GPL(iio_read_event_processed_scale);
>> +
>> +static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
>> +						 int processed, int *raw,
>> +						 unsigned int scale)
>> +{
>> +	int scale_type, scale_val, scale_val2;
>> +	int offset_type, offset_val, offset_val2;
>> +	s64 r, scale64, raw64;
>> +
>> +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>> +				      IIO_CHAN_INFO_SCALE);
>> +	if (scale_type < 0) {
>> +		raw64 = processed / scale;
>> +	} else {
>> +		switch (scale_type) {
>> +		case IIO_VAL_INT:
>> +			scale64 = (s64)scale_val * scale;
>> +			if (scale64 <= INT_MAX && scale64 >= INT_MIN)
>> +				raw64 = processed / (int)scale64;
>> +			else
>> +				raw64 = 0;
>> +			break;
>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +			scale64 = scale_val * scale * 1000000LL + scale_val2;
>> +			raw64 = div64_s64_rem(processed, scale64, &r);
>> +			raw64 = raw64 * 1000000 +
>> +				div64_s64(r * 1000000, scale64);
>> +			break;
>> +		case IIO_VAL_INT_PLUS_NANO:
>> +			scale64 = scale_val * scale * 1000000000LL +
>> scale_val2;
>> +			raw64 = div64_s64_rem(processed, scale64, &r);
>> +			raw64 = raw64 * 1000000000 +
>> +				div64_s64(r * 1000000000, scale64);
>> +			break;
>> +		case IIO_VAL_FRACTIONAL:
>> +			raw64 = div64_s64((s64)processed * scale_val2,
>> +					  (s64)scale_val * scale);
>> +			break;
>> +		case IIO_VAL_FRACTIONAL_LOG2:
>> +			raw64 = div64_s64((s64)processed << scale_val2,
>> +					  (s64)scale_val * scale);
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
>> +				       IIO_CHAN_INFO_OFFSET);
>> +	if (offset_type >= 0) {
>> +		switch (offset_type) {
>> +		case IIO_VAL_INT:
>> +		case IIO_VAL_INT_PLUS_MICRO:
>> +		case IIO_VAL_INT_PLUS_NANO:
>> +			raw64 -= offset_val;
>> +			break;
>> +		case IIO_VAL_FRACTIONAL:
>> +			raw64 -= offset_val / offset_val2;
>> +			break;
>> +		case IIO_VAL_FRACTIONAL_LOG2:
>> +			raw64 -= offset_val >> offset_val2;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	*raw = clamp(raw64, (s64)INT_MIN, (s64)INT_MAX);
>> +	return 0;
>> +}
>> +
>> +int iio_write_event_processed_scale(struct iio_channel *chan,
>> +				    enum iio_event_type type,
>> +				    enum iio_event_direction dir,
>> +				    enum iio_event_info info, int processed,
>> +				    unsigned int scale)
>> +{
>> +	struct iio_dev *indio_dev = chan->indio_dev;
>> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan-
>> >indio_dev);
>> +	int ret, raw;
>> +
>> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>> +	if (!iio_event_exists(chan, type, dir, info))
>> +		return -ENODEV;
>> +
>> +	if (info == IIO_EV_INFO_ENABLE) {
>> +		if (!indio_dev->info->write_event_config)
>> +			return -EINVAL;
>> +
>> +		return indio_dev->info->write_event_config(indio_dev,
>> +							   chan->channel,
>> type,
>> +							   dir, processed);
>> +	}
>> +
>> +	if (!indio_dev->info->write_event_value)
>> +		return -EINVAL;
>> +
>> +	ret = iio_convert_processed_to_raw_unlocked(chan, processed, &raw,
>> +						    scale);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return indio_dev->info->write_event_value(indio_dev, chan->channel,
>> +						  type, dir, info, raw, 0);
>> +}
>> +EXPORT_SYMBOL_GPL(iio_write_event_processed_scale);
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index 6a4479616479..16e7682474f3 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -451,4 +451,60 @@ ssize_t iio_write_channel_ext_info(struct iio_channel
>> *chan, const char *attr,
>>   */
>>  ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
>>  
>> +/**
>> + * iio_event_mode() - get file mode for an event property
>> + * @chan: Channel being queried
>> + * @type: Event type (theshold, rate-of-change, etc.)
>> + * @dir: Event direction (rising, falling, etc.)
>> + * @info: Event property (enable, value, etc.)
>> + *
>> + * Determine an appropriate mode for sysfs files derived from this event.
>> + *
>> + * Return:
>> + *   - `0000` if the event is unsupported or otherwise unavailable
>> + *   - `0444` if the event is read-only
>> + *   - `0200` if the event is write-only
>> + *   - `0644` if the event is read-write
>> + */
>> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type type,
>> +		       enum iio_event_direction dir, enum iio_event_info
>> info);
>> +
>> +/**
>> + * iio_read_event_processed_scale() - Read an event property
>> + * @chan: Channel being queried
>> + * @type: Event type (theshold, rate-of-change, etc.)
>> + * @dir: Event direction (rising, falling, etc.)
>> + * @info: Event property (enable, value, etc.)
>> + * @val: Processed property value
>> + * @scale: Factor to scale @val by
>> + *
>> + * Read a processed (scaled and offset) event property of a given channel.
>> + *
>> + * Return: 0 on success, or negative error on failure
>> + */
>> +int iio_read_event_processed_scale(struct iio_channel *chan,
>> +				   enum iio_event_type type,
>> +				   enum iio_event_direction dir,
>> +				   enum iio_event_info info, int *val,
>> +				   unsigned int scale);
>> +
>> +/**
>> + * iio_write_event_processed_scale() - Read an event property
>> + * @chan: Channel being queried
>> + * @type: Event type (theshold, rate-of-change, etc.)
>> + * @dir: Event direction (rising, falling, etc.)
>> + * @info: Event property (enable, value, etc.)
>> + * @processed: Processed property value
>> + * @scale: Factor to scale @processed by
>> + *
>> + * Write a processed (scaled and offset) event property of a given channel.
>> + *
>> + * Return: 0 on success, or negative error on failure
>> + */
>> +int iio_write_event_processed_scale(struct iio_channel *chan,
>> +				    enum iio_event_type type,
>> +				    enum iio_event_direction dir,
>> +				    enum iio_event_info info, int processed,
>> +				    unsigned int scale);
>> +
>>  #endif


