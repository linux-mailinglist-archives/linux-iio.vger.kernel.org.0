Return-Path: <linux-iio+bounces-3885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4FC8903DD
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89607295A76
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297D12F5A4;
	Thu, 28 Mar 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQqmrJXR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135C26AF6;
	Thu, 28 Mar 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641102; cv=none; b=AZ7uBR05Q2CbJvmCHdCYTbLgu8LUxKEcWhKmRLLVMLkzHLsgJsCr2K+UB3p5NhbrN+cZgQqyoNj1hUliUAYrjz7s05t5Bs2IeChiMGPjPz43NF05YLXIrJXvOT0gpUZVhYjMOjh9GLo9t5shVU/wTEOYQWx0JAjpJQoQU2Y8Qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641102; c=relaxed/simple;
	bh=gkDy3joEZ0D//F1NGrrJWhA91UrLrC0s8Tg5LIaZrJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfSwaTSbYbV1dLpGNzLJktD1MwcNzm1pTudey03AFAIzwd8jAWc36DZgnyI9aVBdZ/fru2mGwYUhkIYMB/0ORX3E1wzAa3Dp3jHGDrLt2w2s13dimhWCj9aqmWkfsYGLAI74K6qt2uD5NAGX56Su9+9CDQqwAyPkH94YIg58T48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQqmrJXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06C5C433F1;
	Thu, 28 Mar 2024 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641102;
	bh=gkDy3joEZ0D//F1NGrrJWhA91UrLrC0s8Tg5LIaZrJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tQqmrJXR1FWVySbgQWtxmKoiNAZAEBITrnJF0+QoOXLO4QAt0QECiAYWaoA51pfNp
	 /WyTz6VADsRNl1XmTfbXuFBCDTVtynZvkx/fl76KYv/zPmG67EVjBMzcylL2+6jBYc
	 R5bovOq8n1MgN8s33kooYvL0b2eAmXuS0NC1470tcKg6aqJ8M9mgwb0mBHwlbZ0iiZ
	 VerJpyy8reVSnYedwbhTn2mf+H8pqG53s76UL9izNl4bZ4yb9rRSs1HVwNqwfwy4mv
	 RUi+RRIhJpAAR2fAZzMq3R+17g04FravuArFLDg7JsSkGu75Z+i9oQZE9CACHcqjuK
	 5Ljl583FU95Bw==
Date: Thu, 28 Mar 2024 15:51:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 10/10] iio: dac: support the ad9739a RF DAC
Message-ID: <20240328155126.2575d754@jic23-huawei>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-10-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	<20240328-iio-backend-axi-dac-v1-10-afc808b3fde3@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 14:22:34 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
> of synthesizing wideband signals from dc up to 3 GHz.
DC perhaps

> 
> A dual-port, source synchronous, LVDS interface simplifies the digital
> interface with existing FGPA/ASIC technology. On-chip controllers are used
> to manage external and internal clock domain variations over temperature to
> ensure reliable data transfer from the host to the DAC core.
> 
> Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

A few questions / comments inline but on the whole looking good to me.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-ad9739a |  17 +
>  MAINTAINERS                                     |   1 +
>  drivers/iio/dac/Kconfig                         |  16 +
>  drivers/iio/dac/Makefile                        |   1 +
>  drivers/iio/dac/ad9739a.c                       | 445 ++++++++++++++++++++++++
>  5 files changed, 480 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad9739a b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
> new file mode 100644
> index 000000000000..8a8a5cd10386
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Dac operating mode. One of the following modes can be selected:

DAC operating mode. ...

> +         * normal: This is DAC normal mode.
> +         * mixed-mode: In this mode the output is effectively chopped at the

Spaces and tabs mixed...

> +                       DAC sample rate. This has the effect of reducing the
> +                       power of the fundamental signal while increasing the
> +                       power of the images centered around the DAC sample rate,
> +                       thus improving the output power of these images.

Any idea why it is called mixed mode?  Name doesn't suggest to me what the Docs say
this does.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode_available
> +KernelVersion:	6.9
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Available operating modes.

>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 7c0a8caa9a34..ee0d9798d8b4 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -131,6 +131,22 @@ config AD5624R_SPI
>  	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
>  	  AD5664R converters (DAC). This driver uses the common SPI interface.
>  
> +config AD9739A
> +	tristate "Analog Devices AD9739A RF DAC spi driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD9739A Digital-to
> +	  Analog Converter.
> +
> +	  The driver requires the assistance of the AXI DAC IP core to operate,

Maybe a depends on || COMPILE_TEST to increase build coverage (compared to
a hard depends on)

> +	  since SPI is used for configuration only, while data has to be
> +	  streamed into memory via DMA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad9739a.
> +


> diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
> new file mode 100644
> index 000000000000..46431fa345a5
> --- /dev/null
> +++ b/drivers/iio/dac/ad9739a.c

> +
> +enum {
> +	AD9739A_NORMAL_MODE,
> +	AD9739A_MIXED_MODE = 2,

Push these next to the relevant registers and more conventional defines.
Not seeing why the enum helps much here.

> +};
> +
> +static int ad9739a_oper_mode_get(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct ad9739a_state *st = iio_priv(indio_dev);
> +	u32 mode;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD9739A_REG_DEC_CNT, &mode);
> +	if (ret)
> +		return ret;
> +
> +	mode = FIELD_GET(AD9739A_DAC_DEC, mode);
> +	/* sanity check we get valid values from the HW */
> +	if (mode != AD9739A_NORMAL_MODE && mode != AD9739A_MIXED_MODE)
> +		return -EIO;
> +	if (!mode)
> +		return AD9739A_NORMAL_MODE;
> +
> +	return AD9739A_MIXED_MODE - 1;

As below. I'd like to see a mapping function, or lookup table or similar
rather than handling this conversion in code.

> +}
> +
> +static int ad9739a_oper_mode_set(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan, u32 mode)
> +{
> +	struct ad9739a_state *st = iio_priv(indio_dev);
> +
> +	if (mode == AD9739A_MIXED_MODE - 1)
> +		mode = AD9739A_MIXED_MODE;

Why?  Feels like a comment is needed. Or a more obvious conversion function.

> +
> +	return regmap_update_bits(st->regmap, AD9739A_REG_DEC_CNT,
> +				  AD9739A_DAC_DEC, mode);
> +}
> +
> +static int ad9739a_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ad9739a_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sample_rate;
> +		*val2 = 0;
> +		return IIO_VAL_INT_64;

Big numbers :)

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +


> +
> +/*
> + * Recommended values (as per datasheet) for the dac clk common mode voltage
> + * and Mu controller. Look at table 29.
> + */
> +static const struct reg_sequence ad9739a_clk_mu_ctrl[] = {
> +	/* DAC clk common mode voltage */
> +	{AD9739A_REG_CROSS_CNT1, 0x0f},
	{ AD9739A_REG_CROSS_CNT1, 0x0f },
etc is more readable in my opinion so is always my preference in IIO.

> +	{AD9739A_REG_CROSS_CNT2, 0x0f},
> +	/* Mu controller configuration */
> +	{AD9739A_REG_PHS_DET, 0x30},
> +	{AD9739A_REG_MU_DUTY, 0x80},
> +	{AD9739A_REG_MU_CNT2, 0x44},
> +	{AD9739A_REG_MU_CNT3, 0x6c},
> +};
> +
> +static int ad9739a_init(struct device *dev, const struct ad9739a_state *st)
> +{
> +	unsigned int i = 0, lock, fsc;
> +	u32 fsc_raw;
> +	int ret;
> +
> +	ret = regmap_multi_reg_write(st->regmap, ad9739a_clk_mu_ctrl,
> +				     ARRAY_SIZE(ad9739a_clk_mu_ctrl));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Try to get the MU lock. Repeat the below steps AD9739A_LOCK_N_TRIES
> +	 * (as specified by the datasheet) until we get the lock.
> +	 */
> +	do {
> +		ret = regmap_write(st->regmap, AD9739A_REG_MU_CNT4,
> +				   AD9739A_MU_CNT4_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		/* Enable the Mu controller search and track mode. */

MU for consistency

> +		ret = regmap_set_bits(st->regmap, AD9739A_REG_MU_CNT1,
> +				      AD9739A_MU_EN_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/* Ensure the DLL loop is locked */
> +		ret = regmap_read_poll_timeout(st->regmap, AD9739A_REG_MU_STAT1,
> +					       lock, lock & AD9739A_MU_LOCK_MASK,
> +					       0, 1000);
		if (ret < 0 && ret != -ETIMEOUT)
			return ret;

i.e. deal with error codes that don't meant it timed out.

> +	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
> +
> +	if (i == AD9739A_LOCK_N_TRIES)
> +		return dev_err_probe(dev, ret, "Mu lock timeout\n");
> +
> +	/* Receiver tracking and lock. Same deal as the Mu controller */

MU or Mu.  Either fine but be consistent in comments. I have no idea what this is
so can't say which is better.

> +	i = 0;
> +	do {
> +		ret = regmap_update_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT4,
> +					 AD9739A_FINE_DEL_SKW_MASK,
> +					 FIELD_PREP(AD9739A_FINE_DEL_SKW_MASK, 2));
> +		if (ret)
> +			return ret;
> +
> +		/* Disable the receiver and the loop. */
> +		ret = regmap_write(st->regmap, AD9739A_REG_LVDS_REC_CNT1, 0);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Re-enable the loop so it falls out of lock and begins the
> +		 * search/track routine again.
> +		 */
> +		ret = regmap_set_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT1,
> +				      AD9739A_RCVR_LOOP_EN_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/* Ensure the DLL loop is locked */
> +		ret = regmap_read_poll_timeout(st->regmap,
> +					       AD9739A_REG_LVDS_REC_STAT9, lock,
> +					       lock == AD9739A_RCVR_TRACK_AND_LOCK,
> +					       0, 1000);

As above, consider other error codes than -ETIMEOUT;

> +	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
> +
> +	if (i == AD9739A_LOCK_N_TRIES)
> +		return dev_err_probe(dev, ret, "Receiver lock timeout\n");
> +
> +	ret = device_property_read_u32(dev, "adi,full-scale-microamp", &fsc);
> +	if (ret && ret == -EINVAL)
> +		return 0;
> +	if (ret)
> +		return ret;
> +	if (!in_range(fsc, AD9739A_FSC_MIN, AD9739A_FSC_RANGE))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid full scale current(%u) [%u %u]\n",
> +				     fsc, AD9739A_FSC_MIN, AD9739A_FSC_MAX);
> +	/*
> +	 * IOUTFS is given by
> +	 *	Ioutfs = 0.0226 * FSC + 8.58
> +	 * and is given in mA. Hence we'll have to multiply by 10 * MILLI in
> +	 * order to get rid of the fractional.
> +	 */
> +	fsc_raw = DIV_ROUND_CLOSEST(fsc * 10 - 85800, 226);
> +
> +	ret = regmap_write(st->regmap, AD9739A_REG_FSC_1, fsc_raw & 0xff);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD9739A_REG_FSC_1,
> +				  AD9739A_FSC_MSB, fsc_raw >> 8);
> +}



> +
> +static int ad9739a_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad9739a_state *st;
> +	unsigned int id;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Could not get clkin\n");
> +
> +	st->sample_rate = clk_get_rate(clk);
> +	if (!in_range(st->sample_rate, AD9739A_MIN_DAC_CLK,
> +		      AD9739A_DAC_CLK_RANGE))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid dac clk range(%lu) [%lu %lu]\n",
> +				     st->sample_rate, AD9739A_MIN_DAC_CLK,
> +				     AD9739A_MAX_DAC_CLK);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad9739a_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = regmap_read(st->regmap, AD9739A_REG_ID, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AD9739A_ID)
> +		return dev_err_probe(dev, -ENODEV, "Unrecognized CHIP_ID 0x%X",
> +				     id);
Do we have to give up here?  Could it be a compatible future part?
If so we should fallback on what firmware told us it was + perhaps a
dev_info() to say we don't recognise the ID register value.


> +
> +	ret = ad9739a_reset(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9739a_init(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_extend_chan_spec(indio_dev, st->back,
> +					   &ad9739a_channels[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_set_sampling_freq(st->back, 0, st->sample_rate);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad9739a";
> +	indio_dev->info = &ad9739a_info;
> +	indio_dev->channels = ad9739a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad9739a_channels);
> +	indio_dev->setup_ops = &ad9739a_buffer_setup_ops;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}


