Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB02CC99C
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfJEL1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEL1Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:27:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328162084D;
        Sat,  5 Oct 2019 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570274843;
        bh=HAPXcGEBd2W5YuWLs6NLPzyFMjkKzx+OQw2tS/n15ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2TEoRL1mY1gHEn/A4wbkN2K+xkBMsu1XdHDq9j6eeIof1r/VtEj6ZG+PIYfhc5s7i
         GH0fjC9mCi9oo8hQsQcE7JzTorF+LsycUhZ5s7RiYRwBeMnS5CCh5DXNUUy7CmI0FU
         +CAHCsHEKcouctXtqCOfXLZRv0uHA54W46IzMTQo=
Date:   Sat, 5 Oct 2019 12:27:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v10 1/5] iio: imu: st_lsm6dsx: move interrupt thread to
 core
Message-ID: <20191005122718.43d23a5a@archlinux>
In-Reply-To: <20190916135630.2211714-1-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 15:56:26 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This prepares the interrupt to be used for other stuff than
> fifo reading + event readings.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with them.

Thanks,

Jonathan

> ---
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 78 +---------------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 88 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index b0f3da1976e4..ef579650fd52 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -30,8 +30,6 @@
>   * Denis Ciocca <denis.ciocca@st.com>
>   */
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -42,10 +40,6 @@
>  
>  #include "st_lsm6dsx.h"
>  
> -#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
> -#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
> -#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
> -#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
>  #define ST_LSM6DSX_REG_FIFO_MODE_ADDR		0x0a
>  #define ST_LSM6DSX_FIFO_MODE_MASK		GENMASK(2, 0)
>  #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
> @@ -654,25 +648,6 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
>  	return err;
>  }
>  
> -static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> -{
> -	struct st_lsm6dsx_hw *hw = private;
> -
> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> -}
> -
> -static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> -{
> -	struct st_lsm6dsx_hw *hw = private;
> -	int count;
> -
> -	mutex_lock(&hw->fifo_lock);
> -	count = hw->settings->fifo_ops.read_fifo(hw);
> -	mutex_unlock(&hw->fifo_lock);
> -
> -	return count ? IRQ_HANDLED : IRQ_NONE;
> -}
> -
>  static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> @@ -702,59 +677,8 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
>  
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  {
> -	struct device_node *np = hw->dev->of_node;
> -	struct st_sensors_platform_data *pdata;
>  	struct iio_buffer *buffer;
> -	unsigned long irq_type;
> -	bool irq_active_low;
> -	int i, err;
> -
> -	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> -
> -	switch (irq_type) {
> -	case IRQF_TRIGGER_HIGH:
> -	case IRQF_TRIGGER_RISING:
> -		irq_active_low = false;
> -		break;
> -	case IRQF_TRIGGER_LOW:
> -	case IRQF_TRIGGER_FALLING:
> -		irq_active_low = true;
> -		break;
> -	default:
> -		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
> -		return -EINVAL;
> -	}
> -
> -	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
> -				 ST_LSM6DSX_REG_HLACTIVE_MASK,
> -				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> -					    irq_active_low));
> -	if (err < 0)
> -		return err;
> -
> -	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> -	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> -	    (pdata && pdata->open_drain)) {
> -		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
> -					 ST_LSM6DSX_REG_PP_OD_MASK,
> -					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> -						    1));
> -		if (err < 0)
> -			return err;
> -
> -		irq_type |= IRQF_SHARED;
> -	}
> -
> -	err = devm_request_threaded_irq(hw->dev, hw->irq,
> -					st_lsm6dsx_handler_irq,
> -					st_lsm6dsx_handler_thread,
> -					irq_type | IRQF_ONESHOT,
> -					"lsm6dsx", hw);
> -	if (err) {
> -		dev_err(hw->dev, "failed to request trigger irq %d\n",
> -			hw->irq);
> -		return err;
> -	}
> +	int i;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		if (!hw->iio_devs[i])
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b65a6ca775e0..ef838206b30f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -50,6 +50,8 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> @@ -65,6 +67,11 @@
>  #define ST_LSM6DSX_REG_BDU_ADDR			0x12
>  #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
>  
> +#define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
> +#define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
> +#define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
> +#define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
> +
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>  	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> @@ -1525,6 +1532,83 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
>  
> +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> +{
> +	struct st_lsm6dsx_hw *hw = private;
> +
> +	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> +}
> +
> +static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> +{
> +	struct st_lsm6dsx_hw *hw = private;
> +	int count;
> +
> +	mutex_lock(&hw->fifo_lock);
> +	count = hw->settings->fifo_ops.read_fifo(hw);
> +	mutex_unlock(&hw->fifo_lock);
> +
> +	return count ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> +{
> +	struct st_sensors_platform_data *pdata;
> +	struct device_node *np = hw->dev->of_node;
> +	unsigned long irq_type;
> +	bool irq_active_low;
> +	int err;
> +
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_HIGH:
> +	case IRQF_TRIGGER_RISING:
> +		irq_active_low = false;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_FALLING:
> +		irq_active_low = true;
> +		break;
> +	default:
> +		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
> +		return -EINVAL;
> +	}
> +
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
> +				 ST_LSM6DSX_REG_HLACTIVE_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> +					    irq_active_low));
> +	if (err < 0)
> +		return err;
> +
> +	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> +	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> +	    (pdata && pdata->open_drain)) {
> +		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
> +					 ST_LSM6DSX_REG_PP_OD_MASK,
> +					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> +						    1));
> +		if (err < 0)
> +			return err;
> +
> +		irq_type |= IRQF_SHARED;
> +	}
> +
> +	err = devm_request_threaded_irq(hw->dev, hw->irq,
> +					st_lsm6dsx_handler_irq,
> +					st_lsm6dsx_handler_thread,
> +					irq_type | IRQF_ONESHOT,
> +					"lsm6dsx", hw);
> +	if (err) {
> +		dev_err(hw->dev, "failed to request trigger irq %d\n",
> +			hw->irq);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -1573,6 +1657,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  	}
>  
>  	if (hw->irq > 0) {
> +		err = st_lsm6dsx_irq_setup(hw);
> +		if (err < 0)
> +			return err;
> +
>  		err = st_lsm6dsx_fifo_setup(hw);
>  		if (err < 0)
>  			return err;

