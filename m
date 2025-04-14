Return-Path: <linux-iio+bounces-18098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98DA88AF4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2303B39A6
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6828B50A;
	Mon, 14 Apr 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbJwJVMh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F5280A4D;
	Mon, 14 Apr 2025 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655070; cv=none; b=G7s+EM6LaOZrYgFfZPFS066T5EOiYnd39TMWjtH4j1ECVQaZ6QNdqF3AbreJl/Zo87dLSfZcjWFxZ8FCbbwBBUJj3AT35D4G8DIE9wHMD5NZDITA2rmSa9TlvXUzOwvh22eZl882VgylQdYAzIcGuLHnq4LQ18KB7oRHh116BVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655070; c=relaxed/simple;
	bh=u1SSCsR65+z/52ozbHPvT+TScO/1kMgnydsLbhQEYF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arlKctBRkrihHoMqdBIJqc9I+FPXlKqXyVvhr/3tlPHdaoH5RxPYYAj+G2fZxV2cmdw5hjX/XLdXGmWwWcltJUig011XJPv5p0f1xsdYz+SluINWzOZpp5i2QkgPgg1fmC7J7/modIaI2e+9EuiDI/vU04G1qFtDqVRMUMfok64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbJwJVMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF52C4CEE2;
	Mon, 14 Apr 2025 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655069;
	bh=u1SSCsR65+z/52ozbHPvT+TScO/1kMgnydsLbhQEYF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbJwJVMh+kwVSRlafiLsR9NsZhKRc23wpBBil5TPnGF46i+c6S3NjHpChwxmGT7g8
	 jkfyhK+4pXh/3o8KSmPU8HwplLS/H5CMpbQrq+Xi4Iw6cJLQMM86syEILgfdVM31W2
	 dQnxVc8iKpwaoF3eR7jCTnbozSpgv3QUhpGYsOoGb6ra/cSAqdVNWx6nvB17MWtw49
	 htu0GCew+cwGs/DtlIkTCVS1feL0ba/UrmKhcbyhZ3EAiTql0mAyPlzQzYZaruTT8N
	 XB5btK3BTlJCkbA4IKM5TyHI68uj7hn61huKFzGai1m8cRlmCd7I+VpNsmKS73zk0r
	 tUpOlLE+bgY1w==
Date: Mon, 14 Apr 2025 19:24:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Message-ID: <20250414192422.039817b7@jic23-huawei>
In-Reply-To: <20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
	<20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> +static int ad7606_spi_offload_probe(struct device *dev,
> +				    struct iio_dev *indio_dev)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_bus_data *bus_data;
> +	struct dma_chan *rx_dma;
> +	struct spi_offload_trigger_info trigger_info = {
> +		.fwnode = dev_fwnode(dev),
> +		.ops = &ad7606_offload_trigger_ops,
> +		.priv = st,
> +	};
> +	int ret;
> +
> +	bus_data = devm_kzalloc(dev, sizeof(*bus_data), GFP_KERNEL);
> +	if (!bus_data)
> +		return -ENOMEM;
> +	st->bus_data = bus_data;
> +
> +	bus_data->offload = devm_spi_offload_get(dev, spi,
> +						 &ad7606_spi_offload_config);
> +	ret = PTR_ERR_OR_ZERO(bus_data->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
> +	/* Allow main ad7606_probe function to continue. */
> +	if (ret == -ENODEV)
> +		return 0;
> +
> +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register offload trigger\n");
> +
> +	bus_data->offload_trigger = devm_spi_offload_trigger_get(dev,
> +		bus_data->offload, SPI_OFFLOAD_TRIGGER_DATA_READY);
> +	if (IS_ERR(bus_data->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(bus_data->offload_trigger),
> +				     "failed to get offload trigger\n");
> +
> +	/* TODO: PWM setup should be ok, done for the backend. PWM mutex ? */
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
> +							     bus_data->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> +	if (ret)

should be ret;  Thanks to 0-day for the report and fixed up.

> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to setup offload RX DMA\n");
> +
> +	/* Use offload ops. */
> +	indio_dev->setup_ops = &ad7606_offload_buffer_setup_ops;
> +
> +	st->offload_en = true;
> +
> +	return 0;
> +}

