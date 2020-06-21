Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D91202C79
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgFUTqb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgFUTqa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:46:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF09C061794
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:46:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so7117101pgq.10
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BJN6SbbjPQIEQpAULqv1coaJiso8HaxaosMAVz8bJD8=;
        b=FgCgBZvsTj6ALSA1gO/TbzB72uhsW/KYc2Qm6SYFVvceBMfzCyiur9pgZ+v7m4Yquk
         X865Ayojx4yoK8Eh7aXXKGLV+6MJ1r3Xavblk6BYlzvGdbT0oOnnuJ88N8KKQTFKh5Yk
         PSuzON5MOBpqYYIoJaL6SxY+RzZTnURpvfggSS/nhBwQIrfhTC1pBYqlGUREFzAyLijl
         4eVezL27Zua+tqyKSqmoNNOtxDzMvKi9dqRFnrOc7lxvR26raS/tLtlN91cq7lCB10hT
         e5nFIBelr8TSPRd/30fs63SbYvUNRrbsuvagJTw+4eA+qG/qFQGgk4srnCoTFmIfbuoh
         FBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJN6SbbjPQIEQpAULqv1coaJiso8HaxaosMAVz8bJD8=;
        b=TUe0n4WBeA/fihAx8mERHePJQgMKOAPDzRdtcO33AAsUgR+GJ0liUjOmdCsD4+h6FB
         mR1ABKO86IHtdNw1v0ByYvpivYhP15BJvI6a6/SoRoXJt60c6LCVTcwUOKdYN2thkzDy
         vjAYtAQzGxNVP7//v0KGoXdfxtAXgx61WnELeGfsoXWI/aGrwdmzQ2b3+pKVMo9N5ApV
         f08DRXY7NgpcKBHjJZMVSmToKlAEz9pdn8gWvD7KO/4XMGAQAOkJ4MtZMcKfAx9O9B+E
         bhvVxVB5y0eJrcWeUSbmvM1X5cQczcasQ/kqYE/rvZZ6EsHxReaMm2KrnXAdPzFPzWnT
         wCcg==
X-Gm-Message-State: AOAM5337+V0ErHBZ3og6snz68Y2L228yUzcDRF0/TP6NJ5IBxYTzFXHO
        cJAdlb/DHEeiTOea4iRj2M3VrnlapjI=
X-Google-Smtp-Source: ABdhPJwqHB2CYAyWLyORUvhB1OKavnbFKMP0ffmtCm+FKriQ+lZdxjjb3RqIuEawD8oOWOe4o1hEaA==
X-Received: by 2002:a62:ac0a:: with SMTP id v10mr17677509pfe.27.1592768789881;
        Sun, 21 Jun 2020 12:46:29 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l83sm11758357pfd.150.2020.06.21.12.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:46:29 -0700 (PDT)
Date:   Sun, 21 Jun 2020 12:43:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: qcom-vadc: move several adc5 functions to
 common file
Message-ID: <20200621194343.GO128451@builder.lan>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
 <20200621193549.2070434-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621193549.2070434-3-dmitry.baryshkov@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun 21 Jun 12:35 PDT 2020, Dmitry Baryshkov wrote:

> ADC-TM5 driver will make use of several functions from ADC5 driver. Move
> them to qcom-vadc-common driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c   | 73 +++---------------------------
>  drivers/iio/adc/qcom-vadc-common.c | 69 +++++++++++++++++++++++++++-
>  drivers/iio/adc/qcom-vadc-common.h | 12 ++++-
>  3 files changed, 85 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 21fdcde77883..10ca0bf77160 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -143,18 +143,6 @@ struct adc5_chip {
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
> @@ -165,55 +153,6 @@ static int adc5_write(struct adc5_chip *adc, u16 offset, u8 *data, int len)
>  	return regmap_bulk_write(adc->regmap, adc->base + offset, data, len);
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
> @@ -396,7 +335,7 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> -			&adc5_prescale_ratios[prop->prescale],
> +			prop->prescale,
>  			adc->data,
>  			adc_code_volt, val);
>  		if (ret)
> @@ -539,7 +478,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32(node, "qcom,decimation", &value);
>  	if (!ret) {
> -		ret = adc5_decimation_from_dt(value, data->decimation);
> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid decimation %d\n",
>  				chan, value);
> @@ -552,7 +491,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
>  	if (!ret) {
> -		ret = adc5_prescaling_from_dt(varr[0], varr[1]);
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
>  				chan, varr[0], varr[1]);
> @@ -580,10 +519,10 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  		/* Digital controller >= 5.3 have hw_settle_2 option */
>  		if (dig_version[0] >= ADC5_HW_SETTLE_DIFF_MINOR &&
>  			dig_version[1] >= ADC5_HW_SETTLE_DIFF_MAJOR)
> -			ret = adc5_hw_settle_time_from_dt(value,
> +			ret = qcom_adc5_hw_settle_time_from_dt(value,
>  							data->hw_settle_2);
>  		else
> -			ret = adc5_hw_settle_time_from_dt(value,
> +			ret = qcom_adc5_hw_settle_time_from_dt(value,
>  							data->hw_settle_1);
>  
>  		if (ret < 0) {
> @@ -598,7 +537,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>  
>  	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
>  	if (!ret) {
> -		ret = adc5_avg_samples_from_dt(value);
> +		ret = qcom_adc5_avg_samples_from_dt(value);
>  		if (ret < 0) {
>  			dev_err(dev, "%02x invalid avg-samples %d\n",
>  				chan, value);
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index 2bb78d1c4daa..ffa578ce76db 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -89,6 +89,18 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
>  	{ 46,	125000 },
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
> @@ -385,10 +397,12 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
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
> @@ -400,6 +414,59 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
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
> +int qcom_adc5_decimation_from_dt(u32 value,
> +			    const unsigned int *decimation)
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
> index e074902a24cc..2c65ddc98696 100644
> --- a/drivers/iio/adc/qcom-vadc-common.h
> +++ b/drivers/iio/adc/qcom-vadc-common.h
> @@ -153,10 +153,20 @@ struct qcom_adc5_scale_type {
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
> +int qcom_adc5_hw_settle_time_from_dt(u32 value,
> +		const unsigned int *hw_settle);
> +
> +int qcom_adc5_avg_samples_from_dt(u32 value);
> +
> +int qcom_adc5_decimation_from_dt(u32 value,
> +			    const unsigned int *decimation);
> +
>  int qcom_vadc_decimation_from_dt(u32 value);
>  
>  #endif /* QCOM_VADC_COMMON_H */
> -- 
> 2.27.0
> 
