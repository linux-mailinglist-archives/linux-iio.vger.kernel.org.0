Return-Path: <linux-iio+bounces-15962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1BA40A14
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99E83BB222
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30A1FC0FF;
	Sat, 22 Feb 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmtbMmPg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B713C81B;
	Sat, 22 Feb 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241871; cv=none; b=eMGqL2llK8R6DlefOyUpcevjkh/JANd/QVmn93U3tTbxRMTnXSknj6d9KEidUYTb7xM4VxuRdJSld9S1/KXuz2yJoJ5Tjqeu/J5c8znlFzCjagHjvqB477v/QzN0Utr3j70URw4fF0rAQf/BQk01UDeE7E0wSIKAQ5KeSbL5R54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241871; c=relaxed/simple;
	bh=05M9kM9NGiYzKxejehBqSZvmKBza5vKaAJoAQYksG54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haGJCiqQbbsif7jA8D7d/WyEyaKf7HZNSq7o/nenDCT2emG0q+6Nm8RfZImEKPeG5gHIREdUIikcNT0LIfBEFpxxL7+9mbDLRzdrdcJj7Ixb7viuQqrBHC91mhK6tOMGMcDUFrFYhmIs68IqQvzpdr6ens3/0usb58Z8BO+YgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmtbMmPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDF1C4CED1;
	Sat, 22 Feb 2025 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740241871;
	bh=05M9kM9NGiYzKxejehBqSZvmKBza5vKaAJoAQYksG54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmtbMmPgGp+/sZB1iIpS5kIsQR0QboikRkFcR4WXg4UUpk0fljv0w/Ygws3L7+T/K
	 6UsFrrB9WxzOLoQ/d2vMDKdX2+LAgtVwRIVfNXmjzCFuf15tUhSMEfkxequAXr3mIo
	 AswmFarKJgzX7GMciPmpGTwQlhkXfOZsOVH4SAitNrAgLQ+2LWvbJEIIbZrNG8aelP
	 LRfvEX70SWCHPhP1b2JIPebwtVlljVE5WxgbR+g9mKsvDjtYludc0FEtyaz5J3+Z2c
	 lTw54UtkQ7v//4X3yUb5n5jts/AVvW6rm5WqERE1ClXtBjNXSuQYvKxkRAY+ik6Dv1
	 j2iGSd8GUTinw==
Date: Sat, 22 Feb 2025 16:31:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
Message-ID: <20250222163102.20510e8d@jic23-huawei>
In-Reply-To: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 19:03:30 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for SPI offload to the ad7380 driver. SPI offload allows
> sampling data at the max sample rate (2MSPS with one SDO line).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Just one trivial comment from me that I can tidy up when applying if nothing else
comes up.  However, I'd like David to take a look at this before I apply
(+ anyone else who has time!)

Jonathan

> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index a18dcd664c1b5e5032cc55c063e5681d11c23352..492356eed9a9f86c27a00cf1e280bd6432ed30b2 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -15,6 +15,9 @@


> +static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
> +				    struct ad7380_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +	struct device *dev = &spi->dev;
> +	struct dma_chan *rx_dma;
> +	int sample_rate, ret;
> +
> +	indio_dev->setup_ops = &ad7380_offload_buffer_setup_ops;
> +	indio_dev->channels = st->chip_info->offload_channels;
> +	/* Just removing the timestamp channel. */
> +	indio_dev->num_channels--;
> +
> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +		SPI_OFFLOAD_TRIGGER_PERIODIC);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				     "failed to get offload trigger\n");
> +
> +	sample_rate = st->chip_info->max_conversion_rate_hz *
> +		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
> +
> +	st->sample_freq_range[0] = 1; /* min */
> +	st->sample_freq_range[1] = 1; /* step */
> +	st->sample_freq_range[2] = sample_rate; /* max */
> +
> +	/*
> +	 * Starting with a quite low frequency, to allow oversampling x32,
> +	 * user is then reponsible to adjust the frequency for the specific case.
> +	 */
> +	ret = ad7380_set_sample_freq(st, sample_rate / 32);
> +	if (ret)
> +		return ret;
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot setup dma buffer\n");
> +
> +	return ret;
return 0; as it can't be anything else.

> +}

