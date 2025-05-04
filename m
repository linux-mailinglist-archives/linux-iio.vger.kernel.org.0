Return-Path: <linux-iio+bounces-19067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15CAA88D4
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00743B09C4
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777F24676A;
	Sun,  4 May 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6NiNpQn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CA1FDE39;
	Sun,  4 May 2025 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746381453; cv=none; b=J8OMoGE3MoUoi6HezTj5JHWmd65rXaOFmc7uUZh0m6T15Tvau0b9cCmmmZfIZGI2IPYDm9e+2cSpVTECCwGB410ZW9QIIsS71r64/D0BaH5N+rbw6HrznLm9awiw3bQwpiiuv2n9rg3+kaGhq0Eis7y06x4kIW8xnPZXv8CP0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746381453; c=relaxed/simple;
	bh=AYJi3MszYKQEu2bQRpuTI0bPXe/bbOcOcx8CNFtW89w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrzSl5Xl9E1F82iT09AME/ETern2DSE0vz6CxfGGbOo+PybkvzwBy6tfzhAZOAiveSbUAGGflGLA9IErHpbKqF/uXKQZWxrBXEi8wUkHQFKxztU5t+1tyNZ8nt5YsCkjTL1i0wyfRcPkNPY09shSU5cm1J8gSqRqHSJOjemWkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6NiNpQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96E6C4CEE7;
	Sun,  4 May 2025 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746381453;
	bh=AYJi3MszYKQEu2bQRpuTI0bPXe/bbOcOcx8CNFtW89w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6NiNpQnmYuFLky9beQly5JrXAnkvM+4pIlnw3b5l3GwWqsb4F5HT1k8lZF2OdDtI
	 h8msmHMTdDwaciJgsgC0VE+W1WF4ialgmxMGk4YfsfOPRXp7gdT4pyPNWQZcsEj/wn
	 ezV4sAt5ZkzSeWnCNpG3Pv8kEL7evQHnkUrZa7DJMLLvdMfXAZS86x8T+gDlewSEzf
	 ecK5BZxMy4CarACxMHft6eC3g31xWixE6/eTWPWhTAYAfnexiARS3WzzmVsefv1ZAT
	 AkiJSjOjefUAs9w0dfC3Jl/x57yDLE46/yN0yQXLnOEh5o0cWTfIybEKjvWOeqsN+v
	 DP8o4ADcoBWNQ==
Date: Sun, 4 May 2025 18:57:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <20250504185724.4700284f@jic23-huawei>
In-Reply-To: <db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 09:28:20 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend the AD4170 driver to allow buffered data capture in continuous read
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks the aforementioned
> condition is met.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
A few minor things spotted inline.

Thanks,

Jonathan

> ---
> changes since v1
> - Using bitmap_weight().
> - rx_buf changed from __be32 to u8 array to better cope with new regmap config.
> 
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4170.c | 199 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 199 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d5d0308da007..9b4787c127fc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -75,6 +75,8 @@ config AD4170
>  	tristate "Analog Device AD4170 ADC Driver"
>  	depends on SPI
>  	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD4170 SPI analog
>  	  to digital converters (ADC).
> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 4d0af15cb48d..5fcf1c023ac2 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -10,8 +10,12 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
> @@ -54,6 +58,7 @@
>  #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
>  #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
>  #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
> +#define AD4170_ADC_CTRL_CONT_READ_EXIT_REG		0x200 /* virtual reg */
>  
>  #define AD4170_REG_READ_MASK				BIT(14)
>  
> @@ -221,6 +226,7 @@ static const unsigned int ad4170_reg_size[] = {
>  	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
>  	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
>  	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
> +	[AD4170_ADC_CTRL_CONT_READ_EXIT_REG] = 0,
>  };
>  
>  enum ad4170_ref_buf {
> @@ -347,12 +353,16 @@ struct ad4170_state {
>  	u32 int_pin_sel;
>  	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
>  	struct completion completion;
> +	struct iio_trigger *trig;
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +	__be32 bounce_buffer[AD4170_MAX_CHANNELS];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the transfer buffers
>  	 * to live in their own cache lines.
>  	 */
>  	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> -	u8 rx_buf[AD4170_SPI_MAX_XFER_LEN];
> +	u8 rx_buf[4];

Why this change?

>  };

> +
> +static int ad4170_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_CONT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Enables continuous data register read.
> +	 * This enables continuous read of the ADC Data register. The ADC must

First two sentences seem to say the same thing.

> +	 * be in a continuous conversion mode.
> +	 */
> +	return regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				  AD4170_ADC_CTRL_CONT_READ_MSK,
> +				  FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
> +					     AD4170_ADC_CTRL_CONT_READ_ENABLE));
> +}
> +
> +static int ad4170_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	int ret, i;
> +
> +	/*
> +	 * Use a high register address (virtual register) to request a write of
> +	 * 0xA5 to the ADC during the first 8 SCLKs of the ADC data read cycle,
> +	 * thus exiting continuous read.
> +	 */
> +	ret = regmap_write(st->regmap, AD4170_ADC_CTRL_CONT_READ_EXIT_REG, 0);
> +
> +	ret = regmap_update_bits(st->regmap, AD4170_ADC_CTRL_REG,
> +				 AD4170_ADC_CTRL_CONT_READ_MSK,
> +				 FIELD_PREP(AD4170_ADC_CTRL_CONT_READ_MSK,
> +					    AD4170_ADC_CTRL_CONT_READ_DISABLE));
> +	if (ret)
> +		return ret;
> +
> +	ret =  ad4170_set_mode(st, AD4170_ADC_CTRL_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The ADC sequences through all the enabled channels (see datasheet
> +	 * page 95). That can lead to incorrect channel being read if a
> +	 * single-shot read (or buffered read with different active_scan_mask)
> +	 * is done after buffer disable. Disable all channels so only requested
> +	 * channels will be read.
> +	 */
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = ad4170_set_channel_enable(st, i, false);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;

return 0;  When we know we are in a good path we should make that clear.

> +}



