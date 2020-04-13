Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4277E1A6A1C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgDMQol (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731652AbgDMQok (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:44:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D472063A;
        Mon, 13 Apr 2020 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586796279;
        bh=LTMO40w4vbtz0kp3NkhlxVueLfKUTk9EkWx2SPag1yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JZ49CgC22Tv+Bfns2KD0E0D1RDHccl0+Yvu7ine4KMwy+LJS8Mh3QJzmB1dZjH9CV
         qaM/ImOdl8/Izhdt3T9aCCRuOZCNlK4moOSntrd8Wv73Fq1qPr0EAsCV1/ZgtTJHCs
         rSssuHvZ1RR9qxZnHtSmp5pOi1LxuMTkJAwXtsUk=
Date:   Mon, 13 Apr 2020 17:44:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        kever.yang@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v3] iio: adc: rockchip_saradc: Add support iio buffers
Message-ID: <20200413174434.55b2941a@archlinux>
In-Reply-To: <20200412224251.2919182-1-heiko@sntech.de>
References: <20200412224251.2919182-1-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 00:42:51 +0200
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

Comments inline.

The issue with mixing managed and unmanaged allocations needs tidying up.
Sorry if I missed that one before; I probably didn't open up the current
driver to sanity check it :(

Jonathan

> ---
> changes in v3:
> - split buffer struct into values and timestamp area similar to dln2-adc
>   and make sure timestamp gets 8-byte aligned - ALIGN uses 4 as it aligns
>   u16 elements not bytes - hopefully I got it right this time ;-)
> changes in v2:
> - use devm_iio_triggered_buffer_setup
> - calculate data array size from channel number (curtesy of at91-sama5d2_adc)
> 
>  drivers/iio/adc/Kconfig           |   2 +
>  drivers/iio/adc/rockchip_saradc.c | 146 ++++++++++++++++++++++--------
>  2 files changed, 112 insertions(+), 36 deletions(-)
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
> index 582ba047c4a6..0713363a4b43 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -15,7 +15,11 @@
>  #include <linux/delay.h>
>  #include <linux/reset.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define SARADC_DATA			0x00
>  
> @@ -32,9 +36,12 @@
>  #define SARADC_DLY_PU_SOC_MASK		0x3f
>  
>  #define SARADC_TIMEOUT			msecs_to_jiffies(100)
> +#define SARADC_MAX_CHANNELS		6
> +
> +/* buffer elements are u16, timestamp needs to be 8-byte aligned */
> +#define SARADC_BUFFER_NUM_U16	ALIGN(SARADC_MAX_CHANNELS, 4)
I may be going crazy but I think that will get you the 'start' of the
timestamp, not the length including it.

We should be seeing 24 bytes here = 12 u16s.  Sanity check the value.

Running through the stack of defines.
#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
#define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))

ALIGN(6, 4) == __ALIGN_KERNEL(6, 4)
            == __ALIGN_KERNEL_MASK(6, 3)
            == (((6 + 3) & ~3) 
which is 9 with the bottom two bits masked or b1001 & b1100 = 8 not 12

So I think you are looking for
ALIGN(SARADC_MAX_CHANNELS + sizeof(u64) / sizeof(u16), 4)
which will be ((10 + 3) & ~3) b1101 & b1100 = 12
 
>  
>  struct rockchip_saradc_data {
> -	int				num_bits;
>  	const struct iio_chan_spec	*channels;
>  	int				num_channels;
>  	unsigned long			clk_rate;
> @@ -49,8 +56,37 @@ struct rockchip_saradc {
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
> @@ -62,24 +98,12 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
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
>  		*val = info->last_val;
>  		mutex_unlock(&indio_dev->mlock);
>  		return IIO_VAL_INT;
> @@ -91,7 +115,7 @@ static int rockchip_saradc_read_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		*val = ret / 1000;
> -		*val2 = info->data->num_bits;
> +		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		return -EINVAL;
> @@ -104,10 +128,9 @@ static irqreturn_t rockchip_saradc_isr(int irq, void *dev_id)
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
> @@ -118,51 +141,55 @@ static const struct iio_info rockchip_saradc_iio_info = {
>  	.read_raw = rockchip_saradc_read_raw,
>  };
>  
> -#define ADC_CHANNEL(_index, _id) {				\
> +#define ADC_CHANNEL(_index, _id, _res) {			\
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
> +		.endianness = IIO_LE,				\
> +	},							\
>  }
>  
>  static const struct iio_chan_spec rockchip_saradc_iio_channels[] = {
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> -	ADC_CHANNEL(2, "adc2"),
> +	ADC_CHANNEL(0, "adc0", 10),
> +	ADC_CHANNEL(1, "adc1", 10),
> +	ADC_CHANNEL(2, "adc2", 10),
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
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> +	ADC_CHANNEL(0, "adc0", 12),
> +	ADC_CHANNEL(1, "adc1", 12),
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
> -	ADC_CHANNEL(0, "adc0"),
> -	ADC_CHANNEL(1, "adc1"),
> -	ADC_CHANNEL(2, "adc2"),
> -	ADC_CHANNEL(3, "adc3"),
> -	ADC_CHANNEL(4, "adc4"),
> -	ADC_CHANNEL(5, "adc5"),
> +	ADC_CHANNEL(0, "adc0", 10),
> +	ADC_CHANNEL(1, "adc1", 10),
> +	ADC_CHANNEL(2, "adc2", 10),
> +	ADC_CHANNEL(3, "adc3", 10),
> +	ADC_CHANNEL(4, "adc4", 10),
> +	ADC_CHANNEL(5, "adc5", 10),
>  };
>  
>  static const struct rockchip_saradc_data rk3399_saradc_data = {
> -	.num_bits = 10,
>  	.channels = rockchip_rk3399_saradc_iio_channels,
>  	.num_channels = ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
>  	.clk_rate = 1000000,
> @@ -193,6 +220,42 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
>  	reset_control_deassert(reset);
>  }
>  
> +static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *i_dev = pf->indio_dev;
> +	struct rockchip_saradc *info = iio_priv(i_dev);
> +	struct {
> +		u16 values[SARADC_BUFFER_NUM_U16];
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
> +	iio_push_to_buffers_with_timestamp(i_dev, &data, iio_get_time_ns(i_dev));
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
> @@ -221,6 +284,11 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  
>  	info->data = match->data;
>  
> +	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
> +		dev_err(&pdev->dev, "max channels exceeded");
> +		return -EINVAL;

How can that happen?  Bug in the addition of a new device type?
If it's just paranoia against future code, perhaps add a comment to
say that.

> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	info->regs = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(info->regs))
> @@ -315,6 +383,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	indio_dev->channels = info->data->channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> +	ret = devm_iio_triggered_buffer_setup(&indio_dev->dev, indio_dev, NULL,
> +					      rockchip_saradc_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		goto err_clk;
> +

Please avoid mixing an matching between device managed an unmanaged interfaces.
It means the driver is not 'obviously correct' and hence harder to review.

Two choices here.  Either use devm_add_action_or_reset to automatically
disable each clock + regulator in the managed release path, drop all the error
handling and remove (note this should be a precursor patch), or use
iio_triggered_buffer_setup and manually call iio_triggered_buffer_cleanup
in the right place in the remove function.
 
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto err_clk;

