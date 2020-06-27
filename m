Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02C20C135
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgF0MLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 08:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0MLC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 08:11:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9219C21789;
        Sat, 27 Jun 2020 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593259861;
        bh=X98djl+qxvpoKxRTiVbFGJz/LANvWGwjhofFPZ4q2SY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YgE25G7tz46m90UCXeAmqg+WtD0SF3JWG2p7udYlr94BMqE3SO+ouqryF4Bh4ut+0
         o9y19JS404KcN7rvFdYRmkBYYdshqqR5hCXiKkx3fpyBLANlzhy2AV7ZhD85vPHQmp
         PhA5Pftp31EDzvpdqRgSm3//TvGnXxVSWV5irSeo=
Date:   Sat, 27 Jun 2020 13:10:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v6 3/3] iio: adc: rockchip_saradc: Add support iio
 buffers
Message-ID: <20200627131055.7dfd9fed@archlinux>
In-Reply-To: <20200623233011.2319035-3-heiko@sntech.de>
References: <20200623233011.2319035-1-heiko@sntech.de>
        <20200623233011.2319035-3-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Jun 2020 01:30:11 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> From: Simon Xue <xxm@rock-chips.com>
> 
> Add the ability to also support access via (triggered) buffers
> next to the existing direct mode.
> 
> Device in question is the Odroid Go Advance that connects a joystick
> to two of the saradc channels for X and Y axis and the new (and still
> pending) adc joystick driver of course wants to use triggered buffers
> from the iio subsystem.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> [some simplifications and added commit description]
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
I made one trivial tweak...  Applied to the togreg branch of iio.git and
pushed out as testing to see if they autobuilders can find anything we
missed.

Thanks,

Jonathan

> ---
> changes in v6:
> - remove unneeded header
> - remove unneeded blank line change
> changes in v5:
> - use IIO_CPU instead of IIO_LE as suggested by Peter
> changes in v4:
> - comment for the channel-num sanity check in probe
> - move to struct for data+timestamp, that way we get the 8-byte
>   alignment automatically - checked by comparing sizeof results
> changes in v3:
> - split buffer struct into values and timestamp area similar to dln2-adc
>   and make sure timestamp gets 8-byte aligned - ALIGN uses 4 as it aligns
>   u16 elements not bytes - hopefully I got it right this time ;-)
> changes in v2:
> - use devm_iio_triggered_buffer_setup
> - calculate data array size from channel number (curtesy of at91-sama5d2_adc)
> 
>  drivers/iio/adc/Kconfig           |   2 +
>  drivers/iio/adc/rockchip_saradc.c | 147 +++++++++++++++++++++++-------
>  2 files changed, 114 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5b57437cef75..ddf830267e24 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -865,6 +865,8 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 5d2e07dc72fd..eb2222c312da 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -15,7 +15,10 @@
>  #include <linux/delay.h>
>  #include <linux/reset.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define SARADC_DATA			0x00
>  
> @@ -32,9 +35,9 @@
>  #define SARADC_DLY_PU_SOC_MASK		0x3f
>  
>  #define SARADC_TIMEOUT			msecs_to_jiffies(100)
> +#define SARADC_MAX_CHANNELS		6
>  
>  struct rockchip_saradc_data {
> -	int				num_bits;
>  	const struct iio_chan_spec	*channels;
>  	int				num_channels;
>  	unsigned long			clk_rate;
> @@ -49,8 +52,37 @@ struct rockchip_saradc {
>  	struct reset_control	*reset;
>  	const struct rockchip_saradc_data *data;
>  	u16			last_val;
> +	const struct iio_chan_spec *last_chan;
>  };
>  
> +static void rockchip_saradc_power_down(struct rockchip_saradc *info)
> +{
> +	/* Clear irq & power down adc */
> +	writel_relaxed(0, info->regs + SARADC_CTRL);
> +}
> +
> +static int rockchip_saradc_conversion(struct rockchip_saradc *info,
> +				   struct iio_chan_spec const *chan)
> +{
> +	reinit_completion(&info->completion);
> +
> +	/* 8 clock periods as delay between power up and start cmd */
> +	writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> +
> +	info->last_chan = chan;
> +
> +	/* Select the channel to be used and trigger conversion */
> +	writel(SARADC_CTRL_POWER_CTRL
> +			| (chan->channel & SARADC_CTRL_CHN_MASK)
> +			| SARADC_CTRL_IRQ_ENABLE,
> +		   info->regs + SARADC_CTRL);
> +
> +	if (!wait_for_completion_timeout(&info->completion, SARADC_TIMEOUT))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
>  static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec const *chan,
>  				    int *val, int *val2, long mask)
> @@ -62,22 +94,11 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&indio_dev->mlock);
>  
> -		reinit_completion(&info->completion);
> -
> -		/* 8 clock periods as delay between power up and start cmd */
> -		writel_relaxed(8, info->regs + SARADC_DLY_PU_SOC);
> -
> -		/* Select the channel to be used and trigger conversion */
> -		writel(SARADC_CTRL_POWER_CTRL
> -				| (chan->channel & SARADC_CTRL_CHN_MASK)
> -				| SARADC_CTRL_IRQ_ENABLE,
> -		       info->regs + SARADC_CTRL);
> -
> -		if (!wait_for_completion_timeout(&info->completion,
> -						 SARADC_TIMEOUT)) {
> -			writel_relaxed(0, info->regs + SARADC_CTRL);
> +		ret = rockchip_saradc_conversion(info, chan);
> +		if (ret) {
> +			rockchip_saradc_power_down(info);
>  			mutex_unlock(&indio_dev->mlock);
> -			return -ETIMEDOUT;
> +			return ret;
>  		}
>  
>  		*val = info->last_val;
> @@ -91,7 +112,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		*val = ret / 1000;
> -		*val2 = info->data->num_bits;
> +		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		return -EINVAL;
> @@ -104,10 +125,9 @@ static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
>  
>  	/* Read value */
>  	info->last_val = readl_relaxed(info->regs + SARADC_DATA);
> -	info->last_val &= GENMASK(info->data->num_bits - 1, 0);
> +	info->last_val &= GENMASK(info->last_chan->scan_type.realbits - 1, 0);
>  
> -	/* Clear irq & power down adc */
> -	writel_relaxed(0, info->regs + SARADC_CTRL);
> +	rockchip_saradc_power_down(info);
>  
>  	complete(&info->completion);
>  
> @@ -118,51 +138,55 @@ static const struct iio_info rockchip_saradc_iio_info = {
>  	.read_raw = rockchip_saradc_read_raw,
>  };
>  
> -#define SARADC_CHANNEL(_index, _id) {				\
> +#define SARADC_CHANNEL(_index, _id, _res) {			\
>  	.type = IIO_VOLTAGE,					\
>  	.indexed = 1,						\
>  	.channel = _index,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>  	.datasheet_name = _id,					\
> +	.scan_index = _index,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = _res,				\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
>  }
>  
>  static const struct iio_chan_spec rockchip_saradc_iio_channels[] = {
> -	SARADC_CHANNEL(0, "adc0"),
> -	SARADC_CHANNEL(1, "adc1"),
> -	SARADC_CHANNEL(2, "adc2"),
> +	SARADC_CHANNEL(0, "adc0", 10),
> +	SARADC_CHANNEL(1, "adc1", 10),
> +	SARADC_CHANNEL(2, "adc2", 10),
>  };
>  
>  static const struct rockchip_saradc_data saradc_data = {
> -	.num_bits = 10,
>  	.channels = rockchip_saradc_iio_channels,
>  	.num_channels = ARRAY_SIZE(rockchip_saradc_iio_channels),
>  	.clk_rate = 1000000,
>  };
>  
>  static const struct iio_chan_spec rockchip_rk3066_tsadc_iio_channels[] = {
> -	SARADC_CHANNEL(0, "adc0"),
> -	SARADC_CHANNEL(1, "adc1"),
> +	SARADC_CHANNEL(0, "adc0", 12),
> +	SARADC_CHANNEL(1, "adc1", 12),
>  };
>  
>  static const struct rockchip_saradc_data rk3066_tsadc_data = {
> -	.num_bits = 12,
>  	.channels = rockchip_rk3066_tsadc_iio_channels,
>  	.num_channels = ARRAY_SIZE(rockchip_rk3066_tsadc_iio_channels),
>  	.clk_rate = 50000,
>  };
>  
>  static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
> -	SARADC_CHANNEL(0, "adc0"),
> -	SARADC_CHANNEL(1, "adc1"),
> -	SARADC_CHANNEL(2, "adc2"),
> -	SARADC_CHANNEL(3, "adc3"),
> -	SARADC_CHANNEL(4, "adc4"),
> -	SARADC_CHANNEL(5, "adc5"),
> +	SARADC_CHANNEL(0, "adc0", 10),
> +	SARADC_CHANNEL(1, "adc1", 10),
> +	SARADC_CHANNEL(2, "adc2", 10),
> +	SARADC_CHANNEL(3, "adc3", 10),
> +	SARADC_CHANNEL(4, "adc4", 10),
> +	SARADC_CHANNEL(5, "adc5", 10),
>  };
>  
>  static const struct rockchip_saradc_data rk3399_saradc_data = {
> -	.num_bits = 10,
>  	.channels = rockchip_rk3399_saradc_iio_channels,
>  	.num_channels = ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
>  	.clk_rate = 1000000,
> @@ -214,6 +238,47 @@ static void rockchip_saradc_regulator_disable(void *data)
>  	regulator_disable(info->vref);
>  }
>  
> +static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *i_dev = pf->indio_dev;
> +	struct rockchip_saradc *info = iio_priv(i_dev);
> +	/*
> +	 * @values: each channel takes an u16 value
> +	 * @timestamp: will be 8-byte aligned automatically
> +	 */
> +	struct {
> +		u16 values[SARADC_MAX_CHANNELS];
> +		int64_t timestamp;
> +	} data;
> +	int ret;
> +	int i, j = 0;
> +
> +	mutex_lock(&i_dev->mlock);
> +
> +	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
> +		const struct iio_chan_spec *chan = &i_dev->channels[i];
> +
> +		ret = rockchip_saradc_conversion(info, chan);
> +		if (ret) {
> +			rockchip_saradc_power_down(info);
> +			goto out;
> +		}
> +
> +		data.values[j] = info->last_val;
> +		j++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(i_dev, &data,
> +					   iio_get_time_ns(i_dev));
Given new relaxed view on lines just over 80 chars I might tweak that whilst 
applying to a more readable single line.

> +out:
> +	mutex_unlock(&i_dev->mlock);
> +
> +	iio_trigger_notify_done(i_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rockchip_saradc_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_saradc *info = NULL;
> @@ -242,6 +307,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  
>  	info->data = match->data;
>  
> +	/* Sanity check for possible later IP variants with more channels */
> +	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
> +		dev_err(&pdev->dev, "max channels exceeded");
> +		return -EINVAL;
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	info->regs = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(info->regs))
> @@ -357,6 +428,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	indio_dev->channels = info->data->channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> +	ret = devm_iio_triggered_buffer_setup(&indio_dev->dev, indio_dev, NULL,
> +					      rockchip_saradc_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret)
>  		return ret;

