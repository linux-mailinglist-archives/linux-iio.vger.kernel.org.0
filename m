Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99C1D9E48
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgESR4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:56:04 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbgESR4E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 13:56:04 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D3A42D0D0FE715D87CBA;
        Tue, 19 May 2020 18:56:02 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 18:56:02 +0100
Date:   Tue, 19 May 2020 18:55:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: imu: bmi160: added regulator support
Message-ID: <20200519185535.00003cb7@Huawei.com>
In-Reply-To: <20200519075111.6356-4-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
        <20200519075111.6356-4-jonathan.albrieux@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 09:50:59 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> v2: fixed missing description

Don't put change log here....
> 
> Add vdd-supply and vddio-supply support. Without this support vdd and vddio
> should be set to always-on in device tree

Kind of the opposite.  If they are always on we don't have to provide them
in the device tree.

A few trivial things inline.

> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---

Change log goes here so we don't end up keeping it in the git log.

>  drivers/iio/imu/bmi160/bmi160.h      |  2 ++
>  drivers/iio/imu/bmi160/bmi160_core.c | 27 ++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index 621f5309d735..923c3b274fde 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -3,10 +3,12 @@
>  #define BMI160_H_
>  
>  #include <linux/iio/iio.h>
> +#include <linux/regulator/consumer.h>
>  
>  struct bmi160_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
> +	struct regulator_bulk_data supplies[2];
>  };
>  
>  extern const struct regmap_config bmi160_regmap_config;
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 6af65d6f1d28..9bbe0d8e6720 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/of_irq.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
> @@ -709,6 +710,12 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  	unsigned int val;
>  	struct device *dev = regmap_get_device(data->regmap);
>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = regmap_write(data->regmap, BMI160_REG_CMD, BMI160_CMD_SOFTRESET);
>  	if (ret)
>  		return ret;
> @@ -793,9 +800,17 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
>  static void bmi160_chip_uninit(void *data)
>  {
>  	struct bmi160_data *bmi_data = data;
> +	struct device *dev = regmap_get_device(bmi_data->regmap);
> +	int ret;
>  
>  	bmi160_set_mode(bmi_data, BMI160_GYRO, false);
>  	bmi160_set_mode(bmi_data, BMI160_ACCEL, false);
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(bmi_data->supplies),
> +				     bmi_data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable regulators: %d\n", ret);
> +	}
No need for brackets around a 1 line if block

	if (ret)
		dev_err(dev, "failed to disable regulators: %d\n", ret);

>  }
>  
>  int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> @@ -815,6 +830,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
>  
> +	data->supplies[0].supply = "vdd";
> +	data->supplies[1].supply = "vddio";
> +	ret = devm_regulator_bulk_get(dev,
> +				      ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret) {
> +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = bmi160_chip_init(data, use_spi);
>  	if (ret)
>  		return ret;
> @@ -853,6 +878,6 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>  }
>  EXPORT_SYMBOL_GPL(bmi160_core_probe);
>  
> -MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");

Good fix but shouldn't be in this patch.   Put it a separate patch on it's own.

>  MODULE_DESCRIPTION("Bosch BMI160 driver");
>  MODULE_LICENSE("GPL v2");


