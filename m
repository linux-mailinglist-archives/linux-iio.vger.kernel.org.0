Return-Path: <linux-iio+bounces-10801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C64F9A4F15
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6DA1F224DF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B816BB5B;
	Sat, 19 Oct 2024 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmsCbAJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B5EAC7;
	Sat, 19 Oct 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729351496; cv=none; b=qJMbig154CCejWQx4Udz5nqQtLhVzh1SzNQjDwxwwKE2BgNPxuX7OJ+/KdE4XBiVYDH36CyyaP8eh6ifD4QxEVTKy9Y0SuyC5uheUXD/qFJ9TXVCM3Pze1rxk4Il/By10ZJlAXZuFXJ3MBENzgQa6gPcyhFvhRf1XC55MJpWyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729351496; c=relaxed/simple;
	bh=2rgS0ryQcXd05F22SgBalZfutACrIoPMjOz8GLEHDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsD7DvXFRzr/pdy1lGb3MbvjH380IDFBXt+edIcSENfubFzx0GEfAF/xfJ80MVSIvL3R5AxA7IWIRHRNA6bsZ+EK/9coMuoqNLd7mCDSgXnIXV21ZFvAX39NOnfTwMlrZkA7S4RTKCd0wn0Dqbn3jJB+gNdmWVMdZfizZkmvrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmsCbAJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DBC4CEC5;
	Sat, 19 Oct 2024 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729351495;
	bh=2rgS0ryQcXd05F22SgBalZfutACrIoPMjOz8GLEHDzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmsCbAJ4qJscKBC0cidSAIpv20f4l8U/gkgqDaUwK7zBHMWieDdoWrnjJQ0RCwgIt
	 +q1PS/UX2cenveSLzYl32doM4qjsaltPQZpIKztST0Yj2RDW3ai39M5smZET6TAM7R
	 N+CeVP1wWTw0BXik8ovmJsAMuKt5NpATv/FHr6cpV8YtMATASpWiiq//t53k2FCIZL
	 fLVm9AHTI0DBaQ0h+hU/2vxXisB+1DYngVx3TPHXFjzFIIHchahNhgBikaz3vT68Fo
	 tbGdS6rob/uvypJJYYU2BOPnEgpiKbVjHFXzdGLaYFteE+Wppeq8CjPG9LL3s8Tgvy
	 rfRfDuTm2KFEw==
Date: Sat, 19 Oct 2024 16:24:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241019162437.500b6ac4@jic23-huawei>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 12:08:13 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add High Speed ad3552r platform driver.
> 
> The ad3552r DAC is controlled by a custom (fpga-based) DAC IP
> through the current AXI backend, or similar alternative IIO backend.
> 
> Compared to the existing driver (ad3552r.c), that is a simple SPI
> driver, this driver is coupled with a DAC IIO backend that finally
> controls the ad3552r by a fpga-based "QSPI+DDR" interface, to reach
> maximum transfer rate of 33MUPS using dma stream capabilities.
> 
> All commands involving QSPI bus read/write are delegated to the backend
> through the provided APIs for bus read/write.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo,

You have lots of review already. Just one trivial addition from me.

Jonathan

> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> new file mode 100644
> index 000000000000..cb29a600e141
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -0,0 +1,526 @@

> +static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
> +{

> +
> +	switch (*indio_dev->active_scan_mask) {
> +	case AD3552R_CH0_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = 2;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
> +		break;
> +	case AD3552R_CH1_ACTIVE:
> +		st->single_channel = true;
> +		loop_len = 2;
> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		break;
> +	case AD3552R_CH0_CH1_ACTIVE:
	case AD3552R_CH0_ACTIVE | AD3552R_CH1_ACTIVE:


> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index 088eb8ecfac6..fc00ed4c2565 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h

> @@ -129,6 +131,11 @@
>  #define AD3552R_GAIN_SCALE				1000
>  #define AD3552R_LDAC_PULSE_US				100
>  
> +#define AD3552R_CH0_ACTIVE				BIT(0)
> +#define AD3552R_CH1_ACTIVE				BIT(1)
> +#define AD3552R_CH0_CH1_ACTIVE				(AD3552R_CH0_ACTIVE | \
> +							 AD3552R_CH1_ACTIVE)

I'd just put that one inline in the case statement.

> +
>  #define AD3552R_MAX_RANGES	5
>  #define AD3542R_MAX_RANGES	6
>  
> 


