Return-Path: <linux-iio+bounces-4823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46328BC345
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D703AB2119E
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB566E605;
	Sun,  5 May 2024 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsTvxLrC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF76E54C;
	Sun,  5 May 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714937711; cv=none; b=hgTTMuz2czw4HpO13c+kLbkvHUH1Fyj+XWHnvheJPrws755fnge8iCuCha3AQJgdszoIxMwF8UcRfR8el8yIfTfZBBfoYpqoD3BVPrw8km1xIKOBd+MTsBeYXiQplWCQUuXDNEMA18tR+FWics3UUlGKDVh4ElzbUrWjo0u2Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714937711; c=relaxed/simple;
	bh=VkxMDtsny24XcJVYTcFBblK3g3hI+2cPLXzaBz3PeGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiojWiuM0DhAAHBzu6TJXdTaALH3v0UfjQ0zBpzIrU5FnhDw83H20a/w4CO0j3iYeuW/zcSy3zZKkrxDrGJNgpRsWiZfqjZxtoYqkjqtsuxNVXGiemMUjWJawcKcy5WYetUlnTyqj+dTKGsN+KV7b77uMPV5I3Sx3w6xnbVB8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsTvxLrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44587C113CC;
	Sun,  5 May 2024 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714937709;
	bh=VkxMDtsny24XcJVYTcFBblK3g3hI+2cPLXzaBz3PeGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dsTvxLrCKnhUIzmfWZOGyRXiMXsggzwEaXK+xm+fXGCrvZ+MlTfjqpgZgw3O7a041
	 fl48q+3ST+nwbK38xAELnKKr2CkTxL05jns8yHcIuX98f2d5qp6hDT8WavsK4OBQAf
	 M3uhe9pjVCnhgMB8NPt5ahGyWYWh6Ll5yfLO4QbIijH4CFA2OnFlsV7IT9IBMcCZsr
	 FH4RlpTUNhqwcoCgldx6gYflTKVWT65AdH8J2mwqEAC5pSxrZOPT4Rr2qPRebfHu3b
	 q+T/9kA3ls5YV9qVkyfhGoaRLW7FCkEEcXyohcrBUXWMLyGD6r8R6MSUPBGddd62AE
	 3Jpd4gQetL6xA==
Date: Sun, 5 May 2024 20:34:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240505203456.0c4c0c90@jic23-huawei>
In-Reply-To: <20240429190046.24252-11-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-11-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:46 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> temperature, pressure and humidity readings. This facilitates the
> use of burst/bulk reads in order to acquire data faster. The
> approach is different from the one used in oneshot captures.
> 
> BMP085 & BMP1xx devices use a completely different measurement
> process that is well defined and is used in their buffer_handler().
> 
> Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hi Vasileois,

Just one question on this inline. (patches 8 and 9 look good to me)

For v6, only need to send the patches that I haven't already applied.

Thanks,

Jonathan

>  
> +static irqreturn_t bmp180_buffer_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +	int ret, chan_value;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = bmp180_read_temp(data, &chan_value);
> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	data->sensor_data[1] = chan_value;
> +
> +	ret = bmp180_read_press(data, &chan_value);

So I 'think' that after all the refactoring you end up reading the temperature
twice.  To avoid that you need to pull the read_temp() and read_press()
function implementations here and only do the (currently duplicated) steps once.

You seem to have done this for the other case, but missed the bmp180?
Maybe I'm missing some reason it doesn't work for this one!

> +	if (ret < 0)
> +		return IRQ_HANDLED;
> +
> +	data->sensor_data[0] = chan_value;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +					   iio_get_time_ns(indio_dev));
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}

