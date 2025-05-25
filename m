Return-Path: <linux-iio+bounces-19864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE73AC33ED
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F5F175F70
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83631F09AD;
	Sun, 25 May 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBS92/OY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C861EFFA6;
	Sun, 25 May 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169692; cv=none; b=VnOJpr7V8IZKZr2YbiJNiJSB60I/iB0Wy42I3tr64eNSRHv87DqX1LRcetkMsmafpB1Yb9JJutcxLQ4JmYPjs35pNyJCvyfB2N3rXFynSE1ISD1FDXlArctCRDBCemYcx9Vq8SUUpjG6xihYBqmXlIjAH4PAabdB2wBrxzuiP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169692; c=relaxed/simple;
	bh=eppwMoNxuv53Y6dYc/VtrVtiebLIN6LnMv+IH14fL0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4iMkTcsnUm82PiUiVK2msJ5Q4yrCMbHtkZC9mh4jPL0eCg8R/EcEKGEsYpDr/mwSq0RkASsJPnSz69yOVfkUe22bGe6eFaat1TIXwibOAsfMOpbRoObPpDBxnjhZlbqsI2B8dRtWEsMb+yLCUxwaafRvcUNdrdfsqrFZgYKYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBS92/OY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E9FC4CEEA;
	Sun, 25 May 2025 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748169691;
	bh=eppwMoNxuv53Y6dYc/VtrVtiebLIN6LnMv+IH14fL0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBS92/OYdPMJCc70Eb1v2cjA1jukAeytkFQbobj95pQI9hdcGj4ZmTw1LMS6oa787
	 9YB6E92bkTvRI91/3al/pnLjSlp/VsGXaQB77zED8lFuD94w/44n7ntLkysKeW5uLu
	 LTzAJXXFPjTtQoWxkEP7vhEXNV3tjdgmhsTD8ijXl6dqZ+a/2p3EA3XSLx0Cp0dYWN
	 bXksN1BvyM5BfODLcRJy4ISUkL4faNO9NXP+Yx2/AvvsboSKLtkC4nIuGQPwnaSHzA
	 +cfKf0Ti90FEc8dpUoPp+egDUUXNfwr7Dhvst/5rhrkDMb9I18tZJ7imKgVgucFvd1
	 XJLta+CJHt+sA==
Date: Sun, 25 May 2025 11:41:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 05/10] iio: adc: ad4170: Add digital filter and
 sample frequency config support
Message-ID: <20250525114119.655e24ec@jic23-huawei>
In-Reply-To: <c61fc067989f7ceda8ab38d38805839b9912c82e.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<c61fc067989f7ceda8ab38d38805839b9912c82e.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:35:03 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
> sample frequency configuration.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> +static int ad4170_set_filter_type(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int val)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup = &chan_info->setup;
> +	unsigned int old_filter_fs, old_filter, filter_type_conf;
> +	int ret;
> +
> +	switch (val) {
> +	case AD4170_SINC5_AVG:
> +		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5_AVG;
> +		break;
> +	case AD4170_SINC5:
> +		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC5;
> +		break;
> +	case AD4170_SINC3:
> +		filter_type_conf = AD4170_FILTER_FILTER_TYPE_SINC3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->lock);

You need to scope this because otherwise locks are released in a different
order to how they are taken.

	iio_device_claim_direct (takes mlock in the core)
	guard(mutex)(&st->lock)
	iio_device_release_direct (releases mlock in the core.

	... scope finishes
	guard(mutex)(&st->lock) cleanup happens.


Current code might be fine, but it's harder to reason about.

> +	/*
> +	 * The filters provide the same ODR for a given filter_fs value but
> +	 * there are different minimum and maximum filter_fs limits for each
> +	 * filter. The filter_fs value will be adjusted if the current filter_fs
> +	 * is out of the limits of the just requested filter. Since the
> +	 * filter_fs value affects the ODR (sampling_frequency), changing the
> +	 * filter may lead to a change in the sampling frequency.
> +	 */
> +	old_filter = setup->filter;
> +	old_filter_fs = setup->filter_fs;
> +	if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
> +		setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
> +					 AD4170_SINC3_MAX_FS);
> +	else
> +		setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
> +					 AD4170_SINC5_MAX_FS);
> +
> +	setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
> +	setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
> +				    filter_type_conf);
> +
> +	ret = ad4170_write_channel_setup(st, chan->address, false);
> +	if (ret) {
> +		setup->filter = old_filter;
> +		setup->filter_fs = old_filter_fs;
> +	}
> +
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}



