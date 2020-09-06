Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5C25EE1E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgIFOW5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgIFOTg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:19:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1A1207BC;
        Sun,  6 Sep 2020 14:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599401938;
        bh=x5SpaPl7+j5zLdmOEK8MEjhTtGKXPWyBGC1lm3oGlLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kQvT/4jXbe2cHVzo9YoA0i0ntpYrQTDGtqP0+u8RIZn7wxe9G/fGQwT9Js935FHdV
         Cwt16lYzSAoUmTsHTQamhdpnXl5TtLALCIL+Kqeriyyc+34JpV60ZnsSxhX46AmHkK
         Pi6IH+dRWcjjeY6D24SFxF0jfwUW10E2LzTlF+CM=
Date:   Sun, 6 Sep 2020 15:18:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: qcom-vadc: move several adc5 functions
 to common file
Message-ID: <20200906151852.6c93e059@archlinux>
In-Reply-To: <20200903132109.1914011-4-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
        <20200903132109.1914011-4-dmitry.baryshkov@linaro.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Sep 2020 16:21:03 +0300
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> ADC-TM5 driver will make use of several functions from ADC5 driver. Move
> them to qcom-vadc-common driver.
> 
LGTM

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 75 +++---------------------------
>  drivers/iio/adc/qcom-vadc-common.c | 68 ++++++++++++++++++++++++++-
>  drivers/iio/adc/qcom-vadc-common.h | 10 +++-
>  3 files changed, 82 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index b4b73c9920b4..30b8867b31e4 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -154,18 +154,6 @@ struct adc5_chip {
>  	const struct adc5_data	*data;
>  };
>  
> -static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
> -	{.num =  1, .den =  1},
> -	{.num =  1, .den =  3},
> -	{.num =  1, .den =  4},
> -	{.num =  1, .den =  6},
> -	{.num =  1, .den = 20},
> -	{.num =  1, .den =  8},
> -	{.num = 10, .den = 81},
> -	{.num =  1, .den = 10},
> -	{.num =  1, .den = 16}
> -};
> -
>  static int adc5_read(struct adc5_chip *adc, u16 offset, u8 *data, int len)
>  {
>  	return regmap_bulk_read(adc->regmap, adc->base + offset, data, len);
> @@ -181,55 +169,6 @@ static int adc5_masked_write(struct adc5_chip *adc, u16 offset, u8 mask, u8 val)
>  	return regmap_update_bits(adc->regmap, adc->base + offset, mask, val);
>  }
>  
> -static int adc5_prescaling_from_dt(u32 num, u32 den)
> -{
> -	unsigned int pre;
> -
> -	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
> -		if (adc5_prescale_ratios[pre].num == num &&
> -		    adc5_prescale_ratios[pre].den == den)
> -			break;
> -
> -	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
> -		return -EINVAL;
> -
> -	return pre;
> -}
> -
> -static int adc5_hw_settle_time_from_dt(u32 value,
> -					const unsigned int *hw_settle)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
> -		if (value == hw_settle[i])
> -			return i;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static int adc5_avg_samples_from_dt(u32 value)
> -{
> -	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
> -		return -EINVAL;
> -
> -	return __ffs(value);
> -}
> -
> -static int adc5_decimation_from_dt(u32 value,
> -					const unsigned int *decimation)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
> -		if (value == decimation[i])
> -			return i;
> -	}
> -
> -	return -EINVAL;
> -}
> -
>  static int adc5_read_voltage_data(struct adc5_chip *adc, u16 *data)
>  {
>  	int ret;
> @@ -511,7 +450,7 @@ static int adc_read_raw_common(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> -			&adc5_prescale_ratios[prop->prescale],
> +			prop->prescale,
>  			adc->data,
>  			adc_code_volt, val);
>  		if (ret)
> @@ -717,7 +656,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32(node, "qcom,decimation", &value);
>  	if (!ret) {
> -		ret = adc5_decimation_from_dt(value, data->decimation);
> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid decimation %d\n",
>  				chan, value);
> @@ -730,7 +669,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
>  	if (!ret) {
> -		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
>  				chan, varr[0], varr[1]);
> @@ -759,11 +698,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  		if ((dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>  			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR) ||
>  			adc->data->info == &adc7_info)
> -			ret = adc5_hw_settle_time_from_dt(value,
> -							data->hw_settle_2);
> +			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_2);
>  		else
> -			ret = adc5_hw_settle_time_from_dt(value,
> -							data->hw_settle_1);
> +			ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
>  
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
> @@ -777,7 +714,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
>  	if (!ret) {
> -		ret = adc5_avg_samples_from_dt(value);
> +		ret = qcom_adc5_avg_samples_from_dt(value);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid avg-samples %d\n",
>  				chan, value);
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 5113aaa6ba67..d11f3343ad52 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -278,6 +278,18 @@ static const struct vadc_map_pt adcmap7_100k[] = {
>  	{ 2420, 130048 }
>  };
>  
> +static const struct vadc_prescale_ratio adc5_prescale_ratios[] = {
> +	{.num =  1, .den =  1},
> +	{.num =  1, .den =  3},
> +	{.num =  1, .den =  4},
> +	{.num =  1, .den =  6},
> +	{.num =  1, .den = 20},
> +	{.num =  1, .den =  8},
> +	{.num = 10, .den = 81},
> +	{.num =  1, .den = 10},
> +	{.num =  1, .den = 16}
> +};
> +
>  static int qcom_vadc_scale_hw_calib_volt(
>  				const struct vadc_prescale_ratio *prescale,
>  				const struct adc5_data *data,
> @@ -647,10 +659,12 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>  EXPORT_SYMBOL(qcom_vadc_scale);
>  
>  int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
> -		    const struct vadc_prescale_ratio *prescale,
> +		    unsigned int prescale_ratio,
>  		    const struct adc5_data *data,
>  		    u16 adc_code, int *result)
>  {
> +	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
> +
>  	if (!(scaletype >= SCALE_HW_CALIB_DEFAULT &&
>  		scaletype < SCALE_HW_CALIB_INVALID)) {
>  		pr_err("Invalid scale type %d\n", scaletype);
> @@ -662,6 +676,58 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  }
>  EXPORT_SYMBOL(qcom_adc5_hw_scale);
>  
> +int qcom_adc5_prescaling_from_dt(u32 num, u32 den)
> +{
> +	unsigned int pre;
> +
> +	for (pre = 0; pre < ARRAY_SIZE(adc5_prescale_ratios); pre++)
> +		if (adc5_prescale_ratios[pre].num == num &&
> +		    adc5_prescale_ratios[pre].den == den)
> +			break;
> +
> +	if (pre == ARRAY_SIZE(adc5_prescale_ratios))
> +		return -EINVAL;
> +
> +	return pre;
> +}
> +EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
> +
> +int qcom_adc5_hw_settle_time_from_dt(u32 value,
> +				     const unsigned int *hw_settle)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < VADC_HW_SETTLE_SAMPLES_MAX; i++) {
> +		if (value == hw_settle[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
> +
> +int qcom_adc5_avg_samples_from_dt(u32 value)
> +{
> +	if (!is_power_of_2(value) || value > ADC5_AVG_SAMPLES_MAX)
> +		return -EINVAL;
> +
> +	return __ffs(value);
> +}
> +EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
> +
> +int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ADC5_DECIMATION_SAMPLES_MAX; i++) {
> +		if (value == decimation[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
> +
>  int qcom_vadc_decimation_from_dt(u32 value)
>  {
>  	if (!is_power_of_2(value) || value < VADC_DECIMATION_MIN ||
> diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> index 17b2fc4d8bf2..7e5f6428e311 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -168,10 +168,18 @@ struct qcom_adc5_scale_type {
>  };
>  
>  int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
> -		    const struct vadc_prescale_ratio *prescale,
> +		    unsigned int prescale_ratio,
>  		    const struct adc5_data *data,
>  		    u16 adc_code, int *result_mdec);
>  
> +int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
> +
> +int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
> +
> +int qcom_adc5_avg_samples_from_dt(u32 value);
> +
> +int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation);
> +
>  int qcom_vadc_decimation_from_dt(u32 value);
>  
>  #endif /* QCOM_VADC_COMMON_H */

