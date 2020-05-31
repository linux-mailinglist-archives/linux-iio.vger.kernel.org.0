Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9693D1E9777
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 14:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgEaMQR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 08:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaMQR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 08:16:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E98206F1;
        Sun, 31 May 2020 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590927376;
        bh=J6x4b1+MubT5rZbsJ2uqsOH9lZsuOHOocKwqIBws2Rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2ajgG3bSz03K1Hs33T7dsZdTWN8bAYzqPMckH1k/eqGixqH1WGEU5S0J4F0LDc9lx
         SJW1mkxMM5VYC79G0LlDtWflkAJKPonxI8BnkDCZU94SQ6RAwr89Hjvh7xoCNaw1k4
         e3ooc9erBqj81p34kmV7M3+vxjZaXYk4DsOe5+tU=
Date:   Sun, 31 May 2020 13:16:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] iio: imu: inv_icm42600: add device interrupt
Message-ID: <20200531131612.027433a5@archlinux>
In-Reply-To: <20200527185711.21331-9-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-9-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 27 May 2020 20:57:07 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add INT1 interrupt support. Support interrupt edge and level,
> active high or low. Push-pull or open-drain configurations.
> 
> Interrupt will be used to read data from the FIFO.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Some nitpicks inline - all cases where a blank line would slightly
help readability.

J

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  2 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 96 ++++++++++++++++++-
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +-
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +-
>  4 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index c534acae0308..43749f56426c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -372,7 +372,7 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
>  int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval);
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  			    inv_icm42600_bus_setup bus_setup);
>  
>  int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index e7f7835aca9b..246c1eb52231 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -9,8 +9,11 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  
> @@ -409,6 +412,79 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
>  	return inv_icm42600_set_conf(st, hw->conf);
>  }
>  
> +static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
> +{
> +	struct inv_icm42600_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int status;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
> +	if (ret)
> +		goto out_unlock;
> +
> +	/* FIFO full */
> +	if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)
> +		dev_warn(dev, "FIFO full data lost!\n");
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * inv_icm42600_irq_init() - initialize int pin and interrupt handler
> + * @st:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
> +				 int irq_type, bool open_drain)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	/* configure INT1 interrupt: default is active low on edge */
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW;
> +		break;
> +	}

blank line here

> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |= INV_ICM42600_INT_CONFIG_INT1_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}

blank line here.

> +	if (!open_drain)
> +		val |= INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;

blank line here

> +	ret = regmap_write(st->map, INV_ICM42600_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Deassert async reset for proper INT pin operation (cf datasheet) */
> +	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,
> +				 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	return devm_request_threaded_irq(dev, irq, NULL,
> +					 inv_icm42600_irq_handler, irq_type,
> +					 "inv_icm42600", st);
> +}
> +
>  static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
>  {
>  	int ret;
> @@ -453,11 +529,14 @@ static void inv_icm42600_disable_pm(void *_data)
>  	pm_runtime_disable(dev);
>  }
>  
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
>  			    inv_icm42600_bus_setup bus_setup)
>  {
>  	struct device *dev = regmap_get_device(regmap);
>  	struct inv_icm42600_state *st;
> +	struct irq_data *irq_desc;
> +	int irq_type;
> +	bool open_drain;
>  	int ret;
>  
>  	if (chip < 0 || chip >= INV_CHIP_NB) {
> @@ -465,6 +544,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  		return -ENODEV;
>  	}
>  
> +	/* get irq properties, set trigger falling by default */
> +	irq_desc = irq_get_irq_data(irq);
> +	if (!irq_desc) {
> +		dev_err(dev, "could not find IRQ %d\n", irq);
> +		return -EINVAL;
> +	}

nitpick: Blank line here

> +	irq_type = irqd_get_trigger_type(irq_desc);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_FALLING;

blank line here.

> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
> +
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>  	if (!st)
>  		return -ENOMEM;
> @@ -518,6 +608,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  	if (ret)
>  		return ret;
>  
> +	ret = inv_icm42600_irq_init(st, irq, irq_type, open_drain);
> +	if (ret)
> +		return ret;
> +
>  	/* setup runtime power management */
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> index 4789cead23b3..85b1934cec60 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -64,7 +64,8 @@ static int inv_icm42600_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_i2c_bus_setup);
> +	return inv_icm42600_core_probe(regmap, chip, client->irq,
> +				       inv_icm42600_i2c_bus_setup);
>  }
>  
>  static const struct of_device_id inv_icm42600_of_matches[] = {
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> index a9c5e2fdbe2a..323789697a08 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -63,7 +63,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  
> -	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_spi_bus_setup);
> +	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> +				       inv_icm42600_spi_bus_setup);
>  }
>  
>  static const struct of_device_id inv_icm42600_of_matches[] = {

