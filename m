Return-Path: <linux-iio+bounces-23204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C057B33C58
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF8E1894909
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5021CD208;
	Mon, 25 Aug 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvII6ne8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122032A1CF;
	Mon, 25 Aug 2025 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116962; cv=none; b=mM5t/X10+R0hOc6vWSUsN6+jIzcnuMsB3C7gtDhznL+ib9tTDZhhnzynTrLzDtb1lDqs9KGKWWG/WTQ/5hveP142IrEwC/r83xlQ1qAZiM6f5mdYOrnLj7CQMZY/2SB7GSq/4ka4ywA1zFsEUeLwFYC8/JmwnaPvIj+r/bcJwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116962; c=relaxed/simple;
	bh=oCbS/ihcaDianENF/v0KaYr1WL8E5HJlXGrGW4T02NA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUKjQ3ykst2eAO/Dv7RHah+DVpIHkQt3lUL/yBhaV7Kz8FKneMXKPUVeFJTxRdxxAnLUytZ06XTJbQfKxqHYsPielTnXVryXjlIemGIsLp+Aie6X34SKS4KiSj/YiEdSQEQ66zJe8VR0+dP0nAyTt/Q7m4ueb+bXszdxSbwUgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvII6ne8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA73C4CEED;
	Mon, 25 Aug 2025 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756116961;
	bh=oCbS/ihcaDianENF/v0KaYr1WL8E5HJlXGrGW4T02NA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QvII6ne8O9GPFXUf1OnZES44t/y+cqF3c7gnd7dl9fOznMWnLz0jPT/MTDU8GMkra
	 Fa5fAxW3FbEuPOu9y8ZtS6gLbi4Wju0sJge/5VqVrh2uN7ZeXoBBjCKVGkG7qr7gEb
	 5L+3c7XzGjCh4DmZkrDkwNtIofoKuhki/OTrx2gc9sv8wISfn/BNx8/B/GG+10M4b/
	 5WT3vPZHW1S/8mmjtf/5ZZaBx1LuvWWJxXjHYayVX2sVefjLaOzGVqDh6DXKhSLkGO
	 /Z5vVVFiQgYKgNpddz8QUtXMUyYMzGRmeidATh3Aeomg3ywwCMXooTBzDZLew9W5HN
	 LQ7lQ3MvzmCKQ==
Date: Mon, 25 Aug 2025 11:15:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ioana Risteiu <Ioana.Risteiu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ramona Nechita <ramona.nechita@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: update ad7779 to use IIO backend
Message-ID: <20250825111550.2af1ed7b@jic23-huawei>
In-Reply-To: <aKXZHVpcenaOkvrv@smile.fi.intel.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
	<20250820120247.3012-5-Ioana.Risteiu@analog.com>
	<aKXZHVpcenaOkvrv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 17:18:05 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 20, 2025 at 03:02:45PM +0300, Ioana Risteiu wrote:
> > Add a new functionality to ad7779 driver that streams data through data
> > output interface using IIO backend interface.  

A few follow ups from me.

Jonathan

> ...
> 
> > +static int ad7779_set_data_lines(struct iio_dev *indio_dev,
> > +				 unsigned int num_lanes)
> > +{
> > +	struct ad7779_state *st = iio_priv(indio_dev);  
> 
> > +	int ret = -EINVAL;  
> 
> In general the split assignment is easier to maintain and less prone to subtle
> errors. In this case it's even worse as it's not needed...
> 
> > +	if (num_lanes != AD7779_1LINE &&
> > +		num_lanes != AD7779_2LINES &&
> > +		num_lanes != AD7779_4LINES)
> > +		return ret;  
> 
> ...just return the error code directly here.

Those enum values in general seem like a bad idea.  Just use numbers.
If the enum was used as a type it would be a different situation but here it
is used as a glorified way to give the 1 lane to the value 1 etc which just
makes it harder to read.


> 
> > +	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = iio_backend_num_lanes_set(st->back, num_lanes);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> > +				    AD7779_DOUT_FORMAT_MSK,
> > +				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
> > +}  
> 
> ...
> 
> > +static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)
> > +{
> > +	struct iio_chan_spec *channels;
> > +	struct device *dev = &st->spi->dev;
> > +
> > +	channels = devm_kmemdup_array(dev, st->chip_info->channels,
> > +					ARRAY_SIZE(ad7779_channels),
> > +					sizeof(*channels), GFP_KERNEL);  
> 
> Indentation...
> 
> > +	if (!channels)
> > +		return -ENOMEM;
> > +
> > +	for (int i = 0; i < ARRAY_SIZE(ad7779_channels); i++)  
> 
> Why signed iterator?
> 
> > +		channels[i].scan_type.endianness = IIO_CPU;
> > +
> > +	indio_dev->channels = channels;
> > +
> > +	return 0;
> > +}  
> 
> ...
> 
> > +static int ad7779_setup_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
> > +{
> > +	struct device *dev = &st->spi->dev;  
> 
> > +	int ret = -EINVAL;  
> 
> Why?!
> 
> > +	int num_lanes;  
> 
> Can it be negatie?

Good spot.

Even beyond sign it needs to be a u32 given how it is used.

> 
> > +	indio_dev->info = &ad7779_info_data;
> > +
> > +	ret = ad7779_setup_channels(indio_dev, st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->back = devm_iio_backend_get(dev, NULL);
> > +	if (IS_ERR(st->back))
> > +		return dev_err_probe(dev, PTR_ERR(st->back),
> > +				     "failed to get iio backend");
> > +
> > +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_iio_backend_enable(dev, st->back);
> > +	if (ret)
> > +		return ret;
> > +
> > +	num_lanes = 4;
> > +	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
> > +	if (ret && ret != -EINVAL)
> > +		return ret;
> > +
> > +	return ad7779_set_data_lines(indio_dev, num_lanes);
> > +}  
> 


