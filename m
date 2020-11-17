Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793252B6965
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKQQHi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:07:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2125 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgKQQHi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:07:38 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb9lW4vPxz67Cqs;
        Wed, 18 Nov 2020 00:05:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 17:07:32 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 16:07:31 +0000
Date:   Tue, 17 Nov 2020 16:07:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     <jic23@kernel.org>, <lorenzo.bianconi@redhat.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add vdd-vddio voltage
 regulator
Message-ID: <20201117160723.00003ac2@Huawei.com>
In-Reply-To: <823bbe45fc7b7feb144bd16a6757816ba5e67b86.1605625579.git.lorenzo@kernel.org>
References: <cover.1605625579.git.lorenzo@kernel.org>
        <823bbe45fc7b7feb144bd16a6757816ba5e67b86.1605625579.git.lorenzo@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 16:11:37 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Like all other ST sensors, st_lsm6dsx devices have VDD and VDDIO power
> lines. Introduce voltage regulators to control them.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Looks good to me.

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 ++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 1f31657a7a0e..4b4ec39d4400 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
>  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> @@ -368,6 +369,7 @@ struct st_lsm6dsx_sensor {
>   * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
>   * @dev: Pointer to instance of struct device (I2C or SPI).
>   * @regmap: Register map of the device.
> + * @regulators: VDD/VDDIO voltage regulators.
>   * @irq: Device interrupt line (I2C or SPI).
>   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
> @@ -390,6 +392,7 @@ struct st_lsm6dsx_sensor {
>  struct st_lsm6dsx_hw {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct regulator_bulk_data regulators[2];
>  	int irq;
>  
>  	struct mutex fifo_lock;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index da91f5e7e86d..8b9b724121a8 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2549,6 +2549,40 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  	return 0;
>  }
>  
> +static int st_lsm6dsx_init_regulators(struct device *dev)
> +{
> +	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
> +	int err;
> +
> +	/* vdd-vddio power regulators */
> +	hw->regulators[0].supply = "vdd";
> +	hw->regulators[1].supply = "vddio";
> +	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(hw->regulators),
> +				      hw->regulators);
> +	if (err) {
> +		dev_err(dev, "failed to get regulators: %d\n", err);
> +		return err;
> +	}
> +
> +	err = regulator_bulk_enable(ARRAY_SIZE(hw->regulators),
> +				    hw->regulators);
> +	if (err) {
> +		dev_err(dev, "failed to enable regulators: %d\n", err);
> +		return err;
> +	}
> +
> +	msleep(50);
> +
> +	return 0;
> +}
> +
> +static void st_lsm6dsx_chip_uninit(void *data)
> +{
> +	struct st_lsm6dsx_hw *hw = data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(hw->regulators), hw->regulators);
> +}
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -2568,6 +2602,14 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  	mutex_init(&hw->conf_lock);
>  	mutex_init(&hw->page_lock);
>  
> +	err = st_lsm6dsx_init_regulators(dev);
> +	if (err)
> +		return err;
> +
> +	err = devm_add_action_or_reset(dev, st_lsm6dsx_chip_uninit, hw);
> +	if (err)
> +		return err;
> +
>  	hw->buff = devm_kzalloc(dev, ST_LSM6DSX_BUFF_SIZE, GFP_KERNEL);
>  	if (!hw->buff)
>  		return -ENOMEM;

