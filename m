Return-Path: <linux-iio+bounces-17638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8536A7C9FD
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6B27A8494
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75281531F0;
	Sat,  5 Apr 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD7sGTlY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729322BCF5;
	Sat,  5 Apr 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743867651; cv=none; b=XshH5zWqwJCAaXCkZyuc562YEILNuqfsNXWCmwisO3O1w2rch0iAbDmU+E3DJ4BwvfuSbS6oXptQKdqLmMk0AHS3FtmDqipcnEx1toLRm5RN9LWUD3yq/usn9VyjC+mfdJEhp0p9+VrLEDugK4AgCAxxiNVZBqGoAIIUf8xbcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743867651; c=relaxed/simple;
	bh=LI2K+tXsrt+xkorD2Q3Y2V8s6J7dF31sI326xEe91tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAp/gAoA2/JkE42ZtAREoqRMNn1r7QMMTfdVu1plqq/sF2GfF8wyl3mCSSwqwqVwHme3OZi1NkgXHyfDublZ0KTR1VkTXpfD1X+D8xZ1YI/AWQNKq1frZWaVMcNsGkj1hYL2yCsEvoXsRr81FAMSqdlucSWxOGFBxzYrnaCrFH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD7sGTlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A521C4CEE4;
	Sat,  5 Apr 2025 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743867650;
	bh=LI2K+tXsrt+xkorD2Q3Y2V8s6J7dF31sI326xEe91tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YD7sGTlYUKBbnuaoKQmSMvR/QYHogoeKBE7mehUn1BmB8R2qyPou0TzsIyTOWW7ud
	 DYKruRV1pEnIwWqMcsAy21UaGgVZJJ8GomHU+O0GvlgE8clTpwGDNo5RQ6crH82KV4
	 uLikPWrHH1Kx9HBL8oZDiVSg7hUbLcDwEX+94GOdAEXfAkbVksVgMSricsbNKOfuaM
	 EYRw3BxpA03BSHuo1Ka4pNnJNTckUVQy2StXiRDs4PDmAWIXuEbWkTqWps3Lf+ZXC6
	 Z+HrSfoEHAqd7aF0t4rBSMG1fhwWalNg5bnq0Ed3jZ9Pg9/5hOfDaBnoYgtJjCL0Gg
	 omsXkE47++gNQ==
Date: Sat, 5 Apr 2025 16:40:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Message-ID: <20250405164041.7d2e586b@jic23-huawei>
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

On Thu, 03 Apr 2025 18:19:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add SPI offload support for this family.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo,

Code looks fine, but there is a TODO I'd like to know more about
as it sounds 'ominous'. 

Otherwise this needs a dt review for patch 1 before I queue it up.

Jonathan
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index b2b975fb7fea4d1af6caef59e75ca495501bc140..b086122497eb22042171580878160334f56baa23 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c

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

I don't understand this todo. Perhaps some more details?

> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
> +							     bus_data->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +		rx_dma, IIO_BUFFER_DIRECTION_IN);
> +	if (ret)
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



