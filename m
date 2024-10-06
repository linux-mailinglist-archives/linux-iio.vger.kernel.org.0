Return-Path: <linux-iio+bounces-10246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B25991EAF
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2068A1F21B54
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF00EAF9;
	Sun,  6 Oct 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFPaHzTE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65041C125;
	Sun,  6 Oct 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728223105; cv=none; b=pvGmo2PG8YY6L9njeDbr7Ug41fzRG6appbnwKrmhEft7NrsxRL9nRIeP+org+87wmIDPt7L26H+7EKgqzLobaaOaM2Lb6O83kJEPJg3C4tt5UPAe+4onikku5eHQ+ltNDeBdAdvhHytieCEMEX7RVFn/D6OW6hHqdSE4WgaM5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728223105; c=relaxed/simple;
	bh=aLSHWAw8MZCLXxMnSk8j648kIMobJGQACMVLvQVqzOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/1eVxUvpniqgGHara3TBJ3pZdKThrbTS/Ian8tRxOPCCbLuSw3+YGYHwBNjtgfjpHjhsUGkTJpjd5bt2BLmTb5cSistHPLamOWh1L7DSZNAFd8BaJjbaY9hpS96OS0qNaRPlhOx6PuT2xGHohfQxaGyci+/gxQCH916RM5dlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFPaHzTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1530EC4CEC5;
	Sun,  6 Oct 2024 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728223105;
	bh=aLSHWAw8MZCLXxMnSk8j648kIMobJGQACMVLvQVqzOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFPaHzTEa+Ef6TOGYasLnLQFd9A6do4p3qwQwckr4fmw8hUDP+vu27gVzZ6E9hOLh
	 b69FlkpEYbT0cNkPbySy9G8EVO2/en292xL/dCOIICPLajSwgaddGq7f1ZCH+tSMH0
	 kXrhpaSP3ruomq4YPP5I8IXOCSwjhqoVUdZG08gB1hJ2sSvrH3MLoWU9mZ5Gy5lsEn
	 Eqscc8B239jVSm44swBGFFYlMDW3cf3jy4tXKFYUPPUXfMmbFr4m/iyqCMt9ZEyR/G
	 avdWX07MTQAHDWiNXqyW8cK3CI6yN6zBvM+Pv9lR1I/+N7hco09LfvpKxV4nc6JwwF
	 ABOOTib3CxqSg==
Date: Sun, 6 Oct 2024 14:58:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 10/11] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241006145812.3d6679fa@jic23-huawei>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-10-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-10-ceb157487329@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:29:07 +0200
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
Hi Angelo

A few trivial things inline.

Jonathan

>  obj-$(CONFIG_AD5380) += ad5380.o
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> new file mode 100644
> index 000000000000..1e141d573d76
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-hs.c

> +static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> +{
> +	u8 gs_p, gs_n;
> +	s16 goffs;
> +	u16 id, rfb;
> +	u16 gain = 0, offset = 0;
> +	u32 val, range;
> +	int err;
...

> +	err = ad3552r_get_custom_gain(st->dev, child, &gs_p, &gs_n, &rfb,
> +				      &goffs);
> +	if (err)
> +		return err;
> +
> +	gain = ad3552r_calc_custom_gain(gs_p, gs_n, goffs);
> +	offset = abs((s32)goffs);

Why the cast?  abs is special cased for short which should work with s16 I think.

> +
> +	return ad3552r_hs_setup_custom_gain(st, gain, offset);
> +}


> +static int ad3552r_hs_probe(struct platform_device *pdev)
> +{
> +	struct ad3552r_hs_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->dev = &pdev->dev;
> +
> +	st->data = pdev->dev.platform_data;
> +	if (!st->data) {
> +		dev_err(&pdev->dev, "no platform data!\n");
> +		return -ENODEV;

Trivial preference for return dev_err_probe() mostly because
we can then drop the brackets.

> +	}

> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index 088eb8ecfac6..d9da4794fcb3 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h

>  #define AD3552R_GAIN_SCALE				1000
>  #define AD3552R_LDAC_PULSE_US				100
>  
> +#define AD3552R_CH0_ACTIVE				BIT(0)
> +#define AD3552R_CH1_ACTIVE				BIT(1)
> +#define AD3552R_CH0_CH1_ACTIVE				(AD3552R_CH0_ACTIVE | \
> +							AD3552R_CH1_ACTIVE)
Add a space before the above. I think it's aligned with the (
but should be just after that.

> +
>  #define AD3552R_MAX_RANGES	5
>  #define AD3542R_MAX_RANGES	6


