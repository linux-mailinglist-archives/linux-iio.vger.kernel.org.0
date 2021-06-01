Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23CE39781F
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhFAQgQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:36:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3126 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:36:14 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fvcr142PZz6J8tl;
        Wed,  2 Jun 2021 00:22:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:34:31 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:34:30 +0100
Date:   Tue, 1 Jun 2021 17:34:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v1 5/9] iio: afe: rescale: add support for temperature
 sensors
Message-ID: <20210601173424.00001ce8@Huawei.com>
In-Reply-To: <20210530005917.20953-6-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-6-liambeguin@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.71]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 May 2021 20:59:13 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add support for various linear temperature sensors.
> 
> temperature-sense-rtd is used when the measured temperature is a
> function of the sensor's resistance (like RTD sensors).
> 
> temperature-sense-current is used when the measured temperature is a
> function of the sensor's output current (like the AD590)
> 
> temperature-sense-amplifier is used when the measured temperature is a
> function of the sensor's voltage (like the LTC2997)
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
Hi Liam,

Comments in here follow through from the bindings.

Jonathan

> ---
>  drivers/iio/afe/iio-rescale.c | 141 ++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 3bd1f11f21db..eb53d833bf7c 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -222,10 +222,133 @@ static int rescale_voltage_divider_props(struct device *dev,
>  	return 0;
>  }
>  
> +static int rescale_temp_sense_rtd_props(struct device *dev,
> +					struct rescale *rescale)
> +{
> +	u32 factor;
> +	u32 alpha;
> +	u32 iexc;
> +	u32 tmp;
> +	int ret;
> +	u32 r0;
> +
> +	ret = device_property_read_u32(dev, "excitation-current-microamp",
> +				       &iexc);
> +	if (ret) {
> +		dev_err(dev, "failed to read excitation-current-microamp: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "alpha-micro-ohms-per-ohm-celsius",
> +				       &alpha);
> +	if (ret) {
> +		dev_err(dev, "failed to read alpha-micro-ohms-per-celsius: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "r-naught-ohms", &r0);
> +	if (ret) {
> +		dev_err(dev, "failed to read r-naught-ohms: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The transfer function:
> +	 *
> +	 *	- V(T) = R(T) * iexc
> +	 *	- R(T) = r0 * (1 + alpha * T)
> +	 *
> +	 *	T = 1 / (alpha * r0 * iexc) * (V - r0 * iexc)
> +	 */
> +	tmp = r0 * iexc * alpha / 1000000;
> +	factor = gcd(tmp, 1000000);
> +	rescale->numerator = 1000000 / factor;
> +	rescale->denominator = tmp / factor;
> +
> +	rescale->offset = -1 * ((r0 * iexc) / 1000);
> +
> +	return 0;
> +}
> +
> +static int rescale_temp_sense_current_props(struct device *dev,
> +					    struct rescale *rescale)
> +{
> +	u32 alpha;
> +	u32 sense;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "sense-resistor-ohms", &sense);
> +	if (ret) {
> +		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "alpha-micro-amps-per-degree",
> +				       &alpha);
> +	if (ret) {
> +		dev_err(dev, "failed to read alpha-micro-amps-per-degree: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The transfer function:
> +	 *
> +	 *	- V(K) = Rsense * Isense(K)
> +	 *	- K = Isense(K) / alpha
> +	 *	- C = K - 273.15
> +	 *
> +	 *	C = 1 / (Rsense * alpha) * (V - 273.15 * Rsense * alpha)
> +	 */
> +	rescale->numerator = 1000000;
> +	rescale->denominator = alpha * sense;
> +
> +	if (device_property_read_bool(dev, "use-kelvin-scale"))
> +		rescale->offset = -1 * ((27315 * alpha * sense) / 100000);

As below. Generic offset, not this specific one please ;)

> +
> +	return 0;
> +}
> +
> +static int rescale_temp_sense_amplifier_props(struct device *dev,
> +					      struct rescale *rescale)
> +{
> +	u32 alpha;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "alpha-micro-volts-per-degree",
> +				       &alpha);
> +	if (ret) {
> +		dev_err(dev, "failed to read alpha-micro-volts-per-degree: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The transfer function:
> +	 *
> +	 *	- K = V(K) / alpha
> +	 *	- C = K - 273.15
> +	 *
> +	 *	C = 1 / (alpha) * (V - 273.15 * alpha)
> +	 */
> +	rescale->numerator = 1000000;
> +	rescale->denominator = alpha;
> +
> +	if (device_property_read_bool(dev, "use-kelvin-scale"))

As mentioned later, stick to celcius + an explicit offset.

There will be devices that have their own offset which doesn't happen to
be -273.15

> +		rescale->offset = -1 * ((27315 * alpha) / 100000);
> +
> +	return 0;
> +}
> +
>  enum rescale_variant {
>  	CURRENT_SENSE_AMPLIFIER,
>  	CURRENT_SENSE_SHUNT,
>  	VOLTAGE_DIVIDER,
> +	TEMP_SENSE_RTD,
> +	TEMP_SENSE_CURRENT,
> +	TEMP_SENSE_AMPLIFIER,
>  };
>  
>  static const struct rescale_cfg rescale_cfg[] = {
> @@ -241,6 +364,18 @@ static const struct rescale_cfg rescale_cfg[] = {
>  		.type = IIO_VOLTAGE,
>  		.props = rescale_voltage_divider_props,
>  	},
> +	[TEMP_SENSE_RTD] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_sense_rtd_props,
> +	},
> +	[TEMP_SENSE_CURRENT] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_sense_current_props,
> +	},
> +	[TEMP_SENSE_AMPLIFIER] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_sense_amplifier_props,
> +	},
>  };
>  
>  static const struct of_device_id rescale_match[] = {
> @@ -250,6 +385,12 @@ static const struct of_device_id rescale_match[] = {
>  	  .data = &rescale_cfg[CURRENT_SENSE_SHUNT], },
>  	{ .compatible = "voltage-divider",
>  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> +	{ .compatible = "temperature-sense-rtd",
> +	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
> +	{ .compatible = "temperature-sense-current",
> +	  .data = &rescale_cfg[TEMP_SENSE_CURRENT], },
> +	{ .compatible = "temperature-sense-amplifier",
> +	  .data = &rescale_cfg[TEMP_SENSE_AMPLIFIER], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rescale_match);

