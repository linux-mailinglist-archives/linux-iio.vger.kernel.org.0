Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0319EB27
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDEMP5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgDEMP5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 08:15:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DD9520659;
        Sun,  5 Apr 2020 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586088956;
        bh=HeajTv27aaOr6Wh9bDShva+F4mn+8ez19i9sqfUv+7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FwFt7t1ObE1bHsst/k3k5yRyL8hFTuZbazrFhJQM3g0jLobhSpqIj4L+IRWO2cMPo
         MWUudo0qIUdK3OgAtBfrLGut3O0Ydrq0MCi7FIgQ+LA61DrOAw0CZbdc9GNxW/bS8u
         h30gZvzHMI2vXeIKXtdKgRR7xBMaDuC1bw6ZriEQ=
Date:   Sun, 5 Apr 2020 13:15:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: xilinx-xadc: Make sure not exceed maximum
 samplerate
Message-ID: <20200405131552.0fa68b71@archlinux>
In-Reply-To: <20200403132717.24682-4-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
        <20200403132717.24682-4-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:27:16 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The XADC supports a samplerate of up to 1MSPS. Unfortunately the hardware
> does not have a FIFO, which means it generates an interrupt for each
> conversion sequence. At one 1MSPS this creates an interrupt storm that
> causes the system to soft-lock.
> 
> For this reason the driver limits the maximum samplerate to 150kSPS.
> Currently this check is only done when setting a new samplerate. But it is
> also possible that the initial samplerate configured in the FPGA bitstream
> exceeds the limit.
> 
> In this case when starting to capture data without first changing the
> samplerate the system can overload.
> 
> To prevent this check the currently configured samplerate in the probe
> function and reduce it to the maximum if necessary.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Looks sensible to me.  This one is a bit more marginal as a 'fix' or
a workaround for silly fpga configurations.  Still probably best to
just give it a fixes tag and merge it with the reset of the series.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 78 +++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 4acababda4d5..c724b8788007 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -102,6 +102,16 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>  
>  #define XADC_FLAGS_BUFFERED BIT(0)
>  
> +/*
> + * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
> + * not have a hardware FIFO. Which means an interrupt is generated for each
> + * conversion sequence. At 1MSPS sample rate the CPU in ZYNQ7000 is completely
> + * overloaded by the interrupts that it soft-lockups. For this reason the driver
> + * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
> + * but still responsive.
> + */
> +#define XADC_MAX_SAMPLERATE 150000
> +
>  static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
>  	uint32_t val)
>  {
> @@ -834,11 +844,27 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
>  	.postdisable = &xadc_postdisable,
>  };
>  
> +static int xadc_read_samplerate(struct xadc *xadc)
> +{
> +	unsigned int div;
> +	uint16_t val16;
> +	int ret;
> +
> +	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
> +	if (ret)
> +		return ret;
> +
> +	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
> +	if (div < 2)
> +		div = 2;
> +
> +	return xadc_get_dclk_rate(xadc) / div / 26;
> +}
> +
>  static int xadc_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	unsigned int div;
>  	uint16_t val16;
>  	int ret;
>  
> @@ -891,41 +917,31 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
>  		*val = -((273150 << 12) / 503975);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
> -		if (ret)
> +		ret = xadc_read_samplerate(xadc);
> +		if (ret < 0)
>  			return ret;
>  
> -		div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
> -		if (div < 2)
> -			div = 2;
> -
> -		*val = xadc_get_dclk_rate(xadc) / div / 26;
> -
> +		*val = ret;
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> -static int xadc_write_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *chan, int val, int val2, long info)
> +static int xadc_write_samplerate(struct xadc *xadc, int val)
>  {
> -	struct xadc *xadc = iio_priv(indio_dev);
>  	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
>  	unsigned int div;
>  
>  	if (!clk_rate)
>  		return -EINVAL;
>  
> -	if (info != IIO_CHAN_INFO_SAMP_FREQ)
> -		return -EINVAL;
> -
>  	if (val <= 0)
>  		return -EINVAL;
>  
>  	/* Max. 150 kSPS */
> -	if (val > 150000)
> -		val = 150000;
> +	if (val > XADC_MAX_SAMPLERATE)
> +		val = XADC_MAX_SAMPLERATE;
>  
>  	val *= 26;
>  
> @@ -938,7 +954,7 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  	 * limit.
>  	 */
>  	div = clk_rate / val;
> -	if (clk_rate / div / 26 > 150000)
> +	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
>  		div++;
>  	if (div < 2)
>  		div = 2;
> @@ -949,6 +965,17 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
>  		div << XADC_CONF2_DIV_OFFSET);
>  }
>  
> +static int xadc_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long info)
> +{
> +	struct xadc *xadc = iio_priv(indio_dev);
> +
> +	if (info != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	return xadc_write_samplerate(xadc, val);
> +}
> +
>  static const struct iio_event_spec xadc_temp_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
> @@ -1234,6 +1261,21 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  
> +	/*
> +	 * Make sure not to exceed the maximum samplerate since otherwise the
> +	 * resulting interrupt storm will soft-lock the system.
> +	 */
> +	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> +		ret = xadc_read_samplerate(xadc);
> +		if (ret < 0)
> +			goto err_free_samplerate_trigger;
> +		if (ret > XADC_MAX_SAMPLERATE) {
> +			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
> +			if (ret < 0)
> +				goto err_free_samplerate_trigger;
> +		}
> +	}
> +
>  	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
>  			dev_name(&pdev->dev), indio_dev);
>  	if (ret)

