Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1E36D997
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhD1O3T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 10:29:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2943 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhD1O3S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 10:29:18 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVgld2LV9z6wj3N;
        Wed, 28 Apr 2021 22:20:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 16:28:31 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 15:28:31 +0100
Date:   Wed, 28 Apr 2021 15:26:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] iio: accel: fxls8962af: add interrupt support
Message-ID: <20210428152657.00004199@Huawei.com>
In-Reply-To: <20210428082203.3587022-2-sean@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
        <20210428082203.3587022-2-sean@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 10:22:01 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Preparation commit for the next that adds hw buffered sampling
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Entirely trivial comment inline.  Otherwise looks good.

> ---
> This series depends on "iio: accel: add support for
> FXLS8962AF/FXLS8964AF accelerometers"
> 
>  drivers/iio/accel/fxls8962af-core.c | 116 ++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index b47d81bebf43..848f3d68f5d4 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>  #include <linux/module.h>
> +#include <linux/of_irq.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
> @@ -54,6 +55,10 @@
>  #define FXLS8962AF_SC3_WAKE_ODR_PREP(x)		FIELD_PREP(FXLS8962AF_SC3_WAKE_ODR_MASK, x)
>  #define FXLS8962AF_SC3_WAKE_ODR_GET(x)		FIELD_GET(FXLS8962AF_SC3_WAKE_ODR_MASK, x)
>  #define FXLS8962AF_SENS_CONFIG4			0x18
> +#define FXLS8962AF_SC4_INT_PP_OD_MASK		BIT(1)
> +#define FXLS8962AF_SC4_INT_PP_OD_PREP(x)	FIELD_PREP(FXLS8962AF_SC4_INT_PP_OD_MASK, x)
> +#define FXLS8962AF_SC4_INT_POL_MASK		BIT(0)
> +#define FXLS8962AF_SC4_INT_POL_PREP(x)		FIELD_PREP(FXLS8962AF_SC4_INT_POL_MASK, x)
>  #define FXLS8962AF_SENS_CONFIG5			0x19
>  
>  #define FXLS8962AF_WAKE_IDLE_LSB		0x1b
> @@ -62,6 +67,9 @@
>  
>  #define FXLS8962AF_INT_EN			0x20
>  #define FXLS8962AF_INT_PIN_SEL			0x21
> +#define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
> +#define FXLS8962AF_INT_PIN_SEL_INT1		0x00
> +#define FXLS8962AF_INT_PIN_SEL_INT2		GENMASK(7, 0)
>  
>  #define FXLS8962AF_OFF_X			0x22
>  #define FXLS8962AF_OFF_Y			0x23
> @@ -142,6 +150,11 @@ enum {
>  	fxls8962af_idx_ts,
>  };
>  
> +enum fxls8962af_int_pin {
> +	FXLS8962AF_PIN_INT1,
> +	FXLS8962AF_PIN_INT2,
> +};
> +
>  static int fxls8962af_drdy(struct fxls8962af_data *data)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> @@ -559,6 +572,20 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
>  	return ret;
>  }
>  
> +static irqreturn_t fxls8962af_interrupt(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	return IRQ_NONE;
> +}
> +
>  static void fxls8962af_regulator_disable(void *data_ptr)
>  {
>  	struct fxls8962af_data *data = data_ptr;
> @@ -578,6 +605,89 @@ static void fxls8962af_pm_disable(void *dev_ptr)
>  	fxls8962af_standby(iio_priv(indio_dev));
>  }
>  
> +static void fxls8962af_get_irq(struct device_node *of_node, enum fxls8962af_int_pin *pin)
> +{
> +	int irq;
> +
> +	irq = of_irq_get_byname(of_node, "INT2");
> +	if (irq > 0) {
> +		*pin = FXLS8962AF_PIN_INT2;
> +		return;
> +	}
> +
> +	*pin = FXLS8962AF_PIN_INT1;
> +}
> +
> +static int fxls8962af_irq_setup(struct iio_dev *indio_dev, int irq)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned long irq_type;
> +	bool irq_active_high;
> +	enum fxls8962af_int_pin int_pin;
> +	u8 int_pin_sel;
> +	int ret;
> +
> +	fxls8962af_get_irq(dev->of_node, &int_pin);
> +	switch (int_pin) {
> +	case FXLS8962AF_PIN_INT1:
> +		int_pin_sel = FXLS8962AF_INT_PIN_SEL_INT1;
> +		break;
> +	case FXLS8962AF_PIN_INT2:
> +		int_pin_sel = FXLS8962AF_INT_PIN_SEL_INT2;
> +		break;
> +	default:
> +		dev_err(dev, "unsupported int pin selected\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_PIN_SEL,
> +				 FXLS8962AF_INT_PIN_SEL_MASK,
> +				 int_pin_sel);
> +	if (ret)
> +		return ret;
> +
> +	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_HIGH:
> +	case IRQF_TRIGGER_RISING:
> +		irq_active_high = true;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_FALLING:
> +		irq_active_high = false;
> +		break;
> +	default:
> +		dev_info(dev, "mode %lx unsupported\n", irq_type);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG4,
> +				 FXLS8962AF_SC4_INT_POL_MASK,
> +				 FXLS8962AF_SC4_INT_POL_PREP(irq_active_high));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (device_property_read_bool(dev, "drive-open-drain")) {
> +		ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG4,
> +					 FXLS8962AF_SC4_INT_PP_OD_MASK,
> +					 FXLS8962AF_SC4_INT_PP_OD_PREP(1));
> +		if (ret < 0)
> +			return ret;
> +
> +		irq_type |= IRQF_SHARED;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev,
> +					irq,
> +					NULL, fxls8962af_interrupt,
> +					irq_type | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +
> +	return ret;

Combine these last two lines into 
return devm_request_threaded_irq(...)


> +}
> +
>  int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  {
>  	struct fxls8962af_data *data;
> @@ -637,6 +747,12 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (irq) {
> +		ret = fxls8962af_irq_setup(indio_dev, irq);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = pm_runtime_set_active(dev);
>  	if (ret < 0)
>  		return ret;

