Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3445A2BC85F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 20:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKVTIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 14:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgKVTIk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Nov 2020 14:08:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835C12076C;
        Sun, 22 Nov 2020 19:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606072119;
        bh=7vu49IcgxLEPVch/2Ig4Rhz62Qz/qgMCkVeTL+wDbig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A2TpZzLzTGng/8zRu9yrQ3om2Leinv0eYKl8DqCs72Oq2SSJB67BvmCUcdsrHCz3t
         Mwm0rTbQc2kfY7PZvrBFlr0Rok3mdAN/rM2Q4u5E+0cQP7OWcFVoKVuZouxkQJ4M07
         uEL+xCCbabInxGd2aEpKmsekgejtUxHJt1gPL/+A=
Date:   Sun, 22 Nov 2020 19:08:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: imu: st_lsm6dsx: add vdd-vddio voltage
 regulator
Message-ID: <20201122190834.0a862808@archlinux>
In-Reply-To: <20201122103644.GA14218@lore-desk>
References: <cover.1605631305.git.lorenzo@kernel.org>
        <a0427a66360bdec73c3b1fb536a46240f96b2ae7.1605631305.git.lorenzo@kernel.org>
        <20201121154938.0a9d3b4d@archlinux>
        <20201122103644.GA14218@lore-desk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Nov 2020 11:36:44 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Tue, 17 Nov 2020 17:47:25 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > Like all other ST sensors, st_lsm6dsx devices have VDD and VDDIO power
> > > lines. Introduce voltage regulators to control them.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> > Oops. I should have pointed out the dev_err_probe more appropriate
> > to avoid complaining when we just tried to probe to early in the
> > sequence and will try again later.  I'll hopefully fix this
> > up an apply once I've picked up my own patch to do the yaml conversion.
> >   
> 
> ack, fine for me otherwise I can just send v3. Up to you.
I've done it and applied both this and patch 2 to the togreg branch of
iio.git (having earlier applied the binding conversion patch).

Please take a quick look and make sure it all looks right to you.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 ++
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 ++++++++++++++++++++
> > >  2 files changed, 45 insertions(+)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > index 1f31657a7a0e..4b4ec39d4400 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > @@ -13,6 +13,7 @@
> > >  
> > >  #include <linux/device.h>
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> > >  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> > > @@ -368,6 +369,7 @@ struct st_lsm6dsx_sensor {
> > >   * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
> > >   * @dev: Pointer to instance of struct device (I2C or SPI).
> > >   * @regmap: Register map of the device.
> > > + * @regulators: VDD/VDDIO voltage regulators.
> > >   * @irq: Device interrupt line (I2C or SPI).
> > >   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
> > >   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
> > > @@ -390,6 +392,7 @@ struct st_lsm6dsx_sensor {
> > >  struct st_lsm6dsx_hw {
> > >  	struct device *dev;
> > >  	struct regmap *regmap;
> > > +	struct regulator_bulk_data regulators[2];
> > >  	int irq;
> > >  
> > >  	struct mutex fifo_lock;
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 5e584c6026f1..fde46377826c 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -2533,6 +2533,40 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > >  	return 0;
> > >  }
> > >  
> > > +static int st_lsm6dsx_init_regulators(struct device *dev)
> > > +{
> > > +	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
> > > +	int err;
> > > +
> > > +	/* vdd-vddio power regulators */
> > > +	hw->regulators[0].supply = "vdd";
> > > +	hw->regulators[1].supply = "vddio";
> > > +	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
> > > +				      hw->regulators);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to get regulators: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	err = regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
> > > +				    hw->regulators);
> > > +	if (err) {
> > > +		dev_err(dev, "failed to enable regulators: %d\n", err);
> > > +		return err;
> > > +	}
> > > +
> > > +	msleep(50);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void st_lsm6dsx_chip_uninit(void *data)
> > > +{
> > > +	struct st_lsm6dsx_hw *hw = data;
> > > +
> > > +	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators);
> > > +}
> > > +
> > >  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > >  		     struct regmap *regmap)
> > >  {
> > > @@ -2552,6 +2586,14 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> > >  	mutex_init(&hw->conf_lock);
> > >  	mutex_init(&hw->page_lock);
> > >  
> > > +	err = st_lsm6dsx_init_regulators(dev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	hw->buff = devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
> > >  	if (!hw->buff)
> > >  		return -ENOMEM;  
> >   

