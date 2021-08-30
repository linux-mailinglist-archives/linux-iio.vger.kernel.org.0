Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABB43FB7CA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhH3OUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237015AbhH3OUJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:20:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5BE60F23;
        Mon, 30 Aug 2021 14:19:09 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:22:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 35/40] iio: adc: ti_am335x_adc: Wait the idle state to
 avoid stalls
Message-ID: <20210830152221.610b6bb7@jic23-huawei>
In-Reply-To: <20210825152518.379386-36-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-36-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:13 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> A simple:
> $ cat /sys/bus/iio/devices/iio\:deviceX/in_voltage*_raw
> can stall forever. It seems that it comes from the fact that the
> internal state machine does not have enough time to return to its idle
> state in this situation before receiving another request, leading to an
> internal stall.

Interesting and non obvious... Good work figuring that out.

> 
> Add a tiadc_wait_idle() helper to ensure no new conversion is requested
> while the FSM is still busy.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index ebf6326af60d..d4619fd6fd54 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_device.h>
>  #include <linux/iio/machine.h>
>  #include <linux/iio/driver.h>
> +#include <linux/iopoll.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  #include <linux/iio/buffer.h>
> @@ -94,6 +95,15 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
>  	return 1 << adc_dev->channel_step[chan];
>  }
>  
> +static int tiadc_wait_idle(struct tiadc_device *adc_dev)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(adc_dev->mfd_tscadc->tscadc_base + REG_ADCFSM,
> +				  val, !(val & SEQ_STATUS), 10,
> +				  IDLE_TIMEOUT_MS * 1000 * adc_dev->channels);
> +}
> +
>  static void tiadc_step_config(struct iio_dev *indio_dev)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> @@ -268,6 +278,11 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	int i, fifo1count;
> +	int ret;
> +
> +	ret = tiadc_wait_idle(adc_dev);
> +	if (ret)
> +		return ret;
>  
>  	tiadc_writel(adc_dev, REG_IRQCLR,
>  		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
> @@ -419,12 +434,12 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  			  long mask)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -	int ret = IIO_VAL_INT;
>  	int i, map_val;
>  	unsigned int fifo1count, read, stepid;
>  	bool found = false;
>  	u32 step_en;
>  	unsigned long timeout;
> +	int ret;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
> @@ -434,6 +449,11 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	mutex_lock(&adc_dev->fifo1_lock);
> +
> +	ret = tiadc_wait_idle(adc_dev);
> +	if (ret)
> +		goto err_unlock;
> +
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	while (fifo1count--)
>  		tiadc_readl(adc_dev, REG_FIFO1);
> @@ -482,7 +502,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  
>  err_unlock:
>  	mutex_unlock(&adc_dev->fifo1_lock);
> -	return ret;
> +	return ret ? ret : IIO_VAL_INT;
>  }
>  
>  static const struct iio_info tiadc_info = {

