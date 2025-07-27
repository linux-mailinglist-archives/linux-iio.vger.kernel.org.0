Return-Path: <linux-iio+bounces-22055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF1B1304F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777A43B081E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D521B9F1;
	Sun, 27 Jul 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNJ0R9oj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079686337;
	Sun, 27 Jul 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753632834; cv=none; b=bU9EZuIVoE3u1P7wrWkqCC1e4slAzaEOjrWXTkOn6hjHq7DWmdsiAzdxUtPahLFBt0lQhtNZs5SRg/e+fzJQqgTgSOiv+6W5+PGU9vn9ouNHRt8rC1lEwgfsrhDqmtaltN9I+1q/RpaezPHfQBY4xFcw+38VgF4duOZrkE9VExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753632834; c=relaxed/simple;
	bh=UHmAc462e38aBUPTK4SctjnMx407u356UEsrj9uxrk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBbMQ3QsEB6yiZ5yWEWjc2VbAfspjr3EU/3Eh6+UaX8/ZblFmPZ1VsMuEK4DNmfjbl3CxRqSyY+pFT9AW++zx04jIdpYprOOKySzU1yAy+eZ7H1zkxMX5ugtlwMqLCe9qTx2xLDDV6Nvrptyw6Vu22+qjF1yU9jbeQkR2BDpf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNJ0R9oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84377C4CEEB;
	Sun, 27 Jul 2025 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753632833;
	bh=UHmAc462e38aBUPTK4SctjnMx407u356UEsrj9uxrk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNJ0R9ojqZZjfNn8kwYWTSsSMPzhd5+jyOR/1CQfTjb3LlQC44u7rk/u9W7d0XpJ9
	 IySnSvDo/+aLodQaae8MK8voljeCkJoCGw8bQBHsqZKGVowVVyO5xqklDmb/O+LY0u
	 qQJp5HyT0513kJD2P/GVIjuYALlTQYz1/qe8KXRxf//kS1ZJ+/iNTXYKzRPB9fKxlY
	 joTHfHeNsrzBfAJQGrcg/7z5UQrouJ/8bjMWaI6f5PSKrn3AWK2osTP7ihyT9D9GRi
	 wWwsAV+RvDp8FfuRfymAaDu640OBDBy6U9N35L1rGpPxz3GdlWqz7DF7umPEE/bSsv
	 vMCNrfuQ0z8ag==
Date: Sun, 27 Jul 2025 17:13:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/7] iio: inkern: Add API for reading/writing events
Message-ID: <20250727171347.61a97f83@jic23-huawei>
In-Reply-To: <20250715012023.2050178-3-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-3-sean.anderson@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 21:20:18 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Add an in-kernel API for reading/writing event properties. Like the
> raw-to-processed conversion, with processed-to-raw we only convert the
> integer part, introducing some round-off error.
> 
> A common case is for other drivers to re-expose IIO events as sysfs
> properties with a different API. To help out with this, iio_event_mode
> returns the appropriate mode. It can also be used to test for existence
> if the consumer doesn't care about read/write capability.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Hi Sean,

A few minor comments inline.

> ---
> 
>  drivers/iio/inkern.c         | 198 +++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h |  56 ++++++++++
>  2 files changed, 254 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c174ebb7d5e6..d3bbd2444fb5 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -1028,3 +1028,201 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
>  	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
>  }
>  EXPORT_SYMBOL_GPL(iio_read_channel_label);

> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type type,
> +		       enum iio_event_direction dir, enum iio_event_info info)
> +{
> +	struct iio_dev *indio_dev = chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	umode_t mode = 0;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return 0;
> +
> +	if (info == IIO_EV_INFO_ENABLE) {
> +		if (indio_dev->info->read_event_config)
> +			mode |= 0444;
> +
> +		if (indio_dev->info->write_event_config)
> +			mode |= 0200;
> +	} else {
> +		if (indio_dev->info->read_event_value)
> +			mode |= 0444;
> +
> +		if (indio_dev->info->write_event_value)
> +			mode |= 0200;
> +	}
> +
> +	return mode;
> +}
> +EXPORT_SYMBOL_GPL(iio_event_mode);
> +
> +int iio_read_event_processed_scale(struct iio_channel *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,

Maybe rename info to ev_info or similar to avoid confusion with
indio_dev->info

> +				   unsigned int scale)
> +{
> +	struct iio_dev *indio_dev = chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +	int ret, raw;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return -ENODEV;
> +
Perhaps a local variable 
	struct iio_info info;

	info = indio_dev->info;

> +	if (info == IIO_EV_INFO_ENABLE) {
> +		if (!indio_dev->info->read_event_config)
> +			return -EINVAL;
> +
> +		raw = indio_dev->info->read_event_config(indio_dev,
		raw = info->read_event_config(indio_dev, chan->channel,
					      type, dir);

> +							 chan->channel, type,
> +							 dir);
> +		if (raw < 0)
> +			return raw;
> +
> +		*val = raw;
> +		return 0;
> +	}
> +
> +	if (!indio_dev->info->read_event_value)
> +		return -EINVAL;
> +
> +	ret = indio_dev->info->read_event_value(indio_dev, chan->channel, type,
> +						dir, info, &raw, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_convert_raw_to_processed_unlocked(chan, raw, val, scale);
> +}
> +EXPORT_SYMBOL_GPL(iio_read_event_processed_scale);

> +
> +int iio_write_event_processed_scale(struct iio_channel *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int processed,
> +				    unsigned int scale)
> +{
> +	struct iio_dev *indio_dev = chan->indio_dev;
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
> +	int ret, raw;
> +
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!iio_event_exists(chan, type, dir, info))
> +		return -ENODEV;
> +
> +	if (info == IIO_EV_INFO_ENABLE) {
> +		if (!indio_dev->info->write_event_config)
> +			return -EINVAL;
> +
> +		return indio_dev->info->write_event_config(indio_dev,

Similar to above, feels like a local variable to shorten these would be good,

> +							   chan->channel, type,
> +							   dir, processed);
> +	}
> +
> +	if (!indio_dev->info->write_event_value)
> +		return -EINVAL;
> +
> +	ret = iio_convert_processed_to_raw_unlocked(chan, processed, &raw,
> +						    scale);
> +	if (ret < 0)
> +		return ret;
> +
> +	return indio_dev->info->write_event_value(indio_dev, chan->channel,
> +						  type, dir, info, raw, 0);
> +}
> +EXPORT_SYMBOL_GPL(iio_write_event_processed_scale);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 6a4479616479..16e7682474f3 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -451,4 +451,60 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
>   */
>  ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf);
>  
> +/**
> + * iio_event_mode() - get file mode for an event property

Can we name this something more specific.  Sounds like it might be
the mode of the events, not the mode of the file.

> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + *
> + * Determine an appropriate mode for sysfs files derived from this event.

This isn't precise unfortunately as if we have a mix of read only and rw
for different events (maybe some thresholds fixed and others not).
We should maybe say that it may indicate more control than actually possible.
In most cases it'll be right though.

> + *
> + * Return:
> + *   - `0000` if the event is unsupported or otherwise unavailable
> + *   - `0444` if the event is read-only
> + *   - `0200` if the event is write-only
> + *   - `0644` if the event is read-write
> + */

So here is one of those bits of "don't do it the way we currently do it".
Move the docs next to the implementation in the c file rather than the header.
We are horribly inconsistent in IIO mostly because of younger me making a mess
of it.  General thinking today is that we are much less likely to forget
to update docs if they are next to the code.


> +umode_t iio_event_mode(struct iio_channel *chan, enum iio_event_type type,
> +		       enum iio_event_direction dir, enum iio_event_info info);
> +
> +/**
> + * iio_read_event_processed_scale() - Read an event property
> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + * @val: Processed property value
> + * @scale: Factor to scale @val by
> + *
> + * Read a processed (scaled and offset) event property of a given channel.
> + *
> + * Return: 0 on success, or negative error on failure
> + */
> +int iio_read_event_processed_scale(struct iio_channel *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   unsigned int scale);
> +
> +/**
> + * iio_write_event_processed_scale() - Read an event property
> + * @chan: Channel being queried
> + * @type: Event type (theshold, rate-of-change, etc.)
> + * @dir: Event direction (rising, falling, etc.)
> + * @info: Event property (enable, value, etc.)
> + * @processed: Processed property value
> + * @scale: Factor to scale @processed by
> + *
> + * Write a processed (scaled and offset) event property of a given channel.
> + *
> + * Return: 0 on success, or negative error on failure
> + */
> +int iio_write_event_processed_scale(struct iio_channel *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int processed,
> +				    unsigned int scale);
> +
>  #endif


