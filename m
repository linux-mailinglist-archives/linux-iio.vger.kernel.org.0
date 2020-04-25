Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC9F1B8904
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDYTc7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgDYTc6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:32:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8E5206D4;
        Sat, 25 Apr 2020 19:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587843177;
        bh=vwXLD9lvvrgotnSeRiexX3V6IUknH2f685jXiYAQpts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tTStbuXuvUyRZFY3qLTN39bCZiDS+r6c3Ceu9qY6BvW504X6/8Cf3/J7nxFIJFaHJ
         UF3HMBHyMIk+10yMr6dqbzQPLp+UzFO+frh1NOVu+C6HvZw1i94HfS85ElZgCgdg0a
         Vow6gyusjAXDe6Dap257k8zVgrpGQuvvl7SGLr5k=
Date:   Sat, 25 Apr 2020 20:32:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        kever.yang@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v5 3/3] iio: adc: rockchip_saradc: Add support iio
 buffers
Message-ID: <20200425203252.26944817@archlinux>
In-Reply-To: <20200419100207.58108-3-heiko@sntech.de>
References: <20200419100207.58108-1-heiko@sntech.de>
        <20200419100207.58108-3-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Apr 2020 12:02:07 +0200
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
I think you have one unneeded header. Otherwise looks good to me.

Thanks,

Jonathan

> ---
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
>  drivers/iio/adc/rockchip_saradc.c | 149 ++++++++++++++++++++++--------
>  2 files changed, 115 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 12bb8b7ca1ff..8d2dd60614c6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -809,6 +809,8 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 29d7f6e4057e..bdb23088e046 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -15,7 +15,11 @@
>  #include <linux/delay.h>
>  #include <linux/reset.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>

I don't think you need to include trigger.h as that's for drivers providing
a trigger and this one doesn't that I can see...

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define SARADC_DATA			0x00
>  
> @@ -32,9 +36,9 @@
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
> @@ -49,8 +53,37 @@ struct rockchip_saradc {
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
> @@ -62,24 +95,12 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
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
> -

nitpick.  don't mess with unrelated white space :)

>  		*val = info->last_val;
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
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
> @@ -202,6 +226,47 @@ static void rockchip_saradc_disable(void *data)
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
> @@ -230,6 +295,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
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
> @@ -332,6 +403,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
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

