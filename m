Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF7370E3F
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhEBRqq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 13:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBRqq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 13:46:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CF9611C0;
        Sun,  2 May 2021 17:45:52 +0000 (UTC)
Date:   Sun, 2 May 2021 18:46:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: accel: add support for
 FXLS8962AF/FXLS8964AF accelerometers
Message-ID: <20210502184642.6f998d56@jic23-huawei>
In-Reply-To: <ab6fffc8-2e40-47b4-24f2-6ec5b7803915@vaisala.com>
References: <20210429122806.3814330-1-sean@geanix.com>
        <ab6fffc8-2e40-47b4-24f2-6ec5b7803915@vaisala.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Apr 2021 12:25:48 +0300
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Hi,
> 
> few comments inline below.
> 
> Thanks,
> 
> Tomas

One addition noticed whilst glancing at Tomas' review.


> 
> 
> On 4/29/21 3:28 PM, Sean Nyekjaer wrote:
> > Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
> > accelerometers.
> > It will allow setting up scale/gain and reading x,y,z
> > axis.
> >
> > Datasheet: https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
> > Datasheet: https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > Changes for v2:
> >   - Addressed Kconfig comments
> >   - Using regmap_read_poll_timeout()
> >   - Addresed comments from Andy and Jonathan
> >
> > Changes for v3:
> >   - fixed Kconfig ordering
> >   - read INT_STATUS after reset, to ensure the device is ready
> >   - fixed a few xmas trees
> >   - added datasheet tags
> >
> > Changes for v4:
> >   - reworked read_raw -> fxls8962af_get_out, so we will skip the claim
> >     part.
> >   - Removed the drdy check, worstcase data will be 1,28s/0.781Hz old.
> >
> >   drivers/iio/accel/Kconfig           |  27 ++
> >   drivers/iio/accel/Makefile          |   3 +
> >   drivers/iio/accel/fxls8962af-core.c | 563 ++++++++++++++++++++++++++++
> >   drivers/iio/accel/fxls8962af-i2c.c  |  57 +++
> >   drivers/iio/accel/fxls8962af-spi.c  |  57 +++
> >   drivers/iio/accel/fxls8962af.h      |  22 ++
> >   6 files changed, 729 insertions(+)
> >   create mode 100644 drivers/iio/accel/fxls8962af-core.c
> >   create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
> >   create mode 100644 drivers/iio/accel/fxls8962af-spi.c
> >   create mode 100644 drivers/iio/accel/fxls8962af.h
> >
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 2e0c62c39155..7317d839ca1a 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -208,6 +208,33 @@ config DMARD10
> >   	  Choosing M will build the driver as a module. If so, the module
> >   	  will be called dmard10.
> >     
> 
> ...
> 
> > +}
> > +
> > +static int fxls8962af_power_off(struct fxls8962af_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	int ret;
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	ret = pm_runtime_put_autosuspend(dev);
> > +  
> 
> could drop extra empty line here.
> 
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to power off\n");
> > +	}

Also, kernel style is no brackets around a single line like this.

> > +
> > +	return ret;
> > +}  
> ...
> > +
> > +static int fxls8962af_reset(struct fxls8962af_data *data)
> > +{
> > +	struct device *dev = regmap_get_device(data->regmap);
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
> > +				 FXLS8962AF_SENS_CONFIG1_RST,
> > +				 FXLS8962AF_SENS_CONFIG1_RST);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* TBOOT1, TBOOT2, specifies we have to wait between 1 - 17.7ms */
> > +	ret = regmap_read_poll_timeout(data->regmap, FXLS8962AF_INT_STATUS, reg,
> > +			(reg & FXLS8962AF_INT_STATUS_SRC_BOOT), 1000, 18000);
> > +	if (ret)
> > +		dev_err(dev, "reset timeout, int_status = 0x%x\n", reg);  
> 
> Should check for -ETIMEDOUT here rather than generic error? and handle 
> both cases.
> 
> > +
> > +	return ret;
> > +}
> > +
> > +static void fxls8962af_regulator_disable(void *data_ptr)
> > +{
> > +	struct fxls8962af_data *data = data_ptr;
> > +
> > +	regulator_disable(data->vdd_reg);
> > +}
> > +
> > +static void fxls8962af_pm_disable(void *dev_ptr)
> > +{
> > +	struct device *dev = dev_ptr;
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_suspended(dev);
> > +	pm_runtime_put_noidle(dev);
> > +
> > +	fxls8962af_standby(iio_priv(indio_dev));
> > +}
> > +
> > +int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
> > +{
> > +	struct fxls8962af_data *data;
> > +	struct iio_dev *indio_dev;
> > +	unsigned int reg;
> > +	int ret, i;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	dev_set_drvdata(dev, indio_dev);
> > +	data->regmap = regmap;
> > +
> > +	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->vdd_reg = devm_regulator_get(dev, "vdd");
> > +	if (IS_ERR(data->vdd_reg))
> > +		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
> > +				     "Failed to get vdd regulator\n");
> > +
> > +	ret = regulator_enable(data->vdd_reg);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, fxls8962af_regulator_disable, data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
> > +	if (ret < 0)
> > +		return ret;  
> Could consider to use if (ret) consistently throughout this function?
> > +
> > +	for (i = 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
> > +		if (fxls_chip_info_table[i].chip_id == reg) {
> > +			data->chip_info = &fxls_chip_info_table[i];
> > +			break;
> > +		}
> > +	}
> > +	if (i == ARRAY_SIZE(fxls_chip_info_table)) {
> > +		dev_err(dev, "failed to match device in table\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	indio_dev->channels = data->chip_info->channels;
> > +	indio_dev->num_channels = data->chip_info->num_channels;
> > +	indio_dev->name = data->chip_info->name;
> > +	indio_dev->info = &fxls8962af_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = fxls8962af_reset(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = pm_runtime_set_active(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	ret = devm_add_action_or_reset(dev, fxls8962af_pm_disable, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> > +
> > +  

