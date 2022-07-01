Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16856311E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Jul 2022 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiGAKPP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Jul 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiGAKPO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Jul 2022 06:15:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A573933
        for <linux-iio@vger.kernel.org>; Fri,  1 Jul 2022 03:15:12 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LZ9xS26kNz6FBRg;
        Fri,  1 Jul 2022 18:12:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 1 Jul 2022 12:15:10 +0200
Received: from localhost (10.81.215.232) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 1 Jul
 2022 11:15:09 +0100
Date:   Fri, 1 Jul 2022 11:15:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 4/4] iio: adc: qcom-vadc: Move symbol exports to
 IIO_QCOM_VADC namespace
Message-ID: <20220701111508.00005b5e@Huawei.com>
In-Reply-To: <20220604155306.422937-5-jic23@kernel.org>
References: <20220604155306.422937-1-jic23@kernel.org>
        <20220604155306.422937-5-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.215.232]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jun 2022 16:53:06 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Avoid unnecessary pollution of the global symbol namespace by
> moving library functions in to a specific namespace and import
> that into the drivers that make use of the functions.
> 
> For more info: https://lwn.net/Articles/760045/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> Link: https://lore.kernel.org/r/20220220173701.502331-6-jic23@kernel.org

Dropped for now after a build issue found in linux next as
there are a few calls into this made from a thermal driver.

I'll send out a new version at somepoint.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c |  1 +
>  drivers/iio/adc/qcom-spmi-adc5.c    |  1 +
>  drivers/iio/adc/qcom-spmi-vadc.c    |  1 +
>  drivers/iio/adc/qcom-vadc-common.c  | 16 ++++++++--------
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index 5e9e56821075..e2ef89dcaa5e 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -1028,3 +1028,4 @@ module_platform_driver(pm8xxx_xoadc_driver);
>  MODULE_DESCRIPTION("PM8xxx XOADC driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:pm8xxx-xoadc");
> +MODULE_IMPORT_NS(IIO_QCOM_VADC);
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 87438d1e5c0b..10bb51b648c1 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -925,3 +925,4 @@ module_platform_driver(adc5_driver);
>  MODULE_ALIAS("platform:qcom-spmi-adc5");
>  MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 ADC driver");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_QCOM_VADC);
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 34202ba52469..cb0c6af091ac 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -935,3 +935,4 @@ MODULE_DESCRIPTION("Qualcomm SPMI PMIC voltage ADC driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
>  MODULE_AUTHOR("Ivan T. Ivanov <iivanov@mm-sol.com>");
> +MODULE_IMPORT_NS(IIO_QCOM_VADC);
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index d5209f32adb3..7ca191ea1a65 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -662,7 +662,7 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
>  		return -EINVAL;
>  	}
>  }
> -EXPORT_SYMBOL(qcom_vadc_scale);
> +EXPORT_SYMBOL_NS(qcom_vadc_scale, IIO_QCOM_VADC);
>  
>  u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>  				 u32 full_scale_code_volt, int temp)
> @@ -675,7 +675,7 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
>  					     temp);
>  	return qcom_vadc_scale_voltage_code(voltage, prescale, full_scale_code_volt, 1000);
>  }
> -EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
> +EXPORT_SYMBOL_NS(qcom_adc_tm5_temp_volt_scale, IIO_QCOM_VADC);
>  
>  u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
>  {
> @@ -704,7 +704,7 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
>  	return scale_adc5_fn[scaletype].scale_fn(prescale, data,
>  					adc_code, result);
>  }
> -EXPORT_SYMBOL(qcom_adc5_hw_scale);
> +EXPORT_SYMBOL_NS(qcom_adc5_hw_scale, IIO_QCOM_VADC);
>  
>  int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
>  {
> @@ -720,7 +720,7 @@ int qcom_adc5_prescaling_from_dt(u32 numerator, u32 denominator)
>  
>  	return pre;
>  }
> -EXPORT_SYMBOL(qcom_adc5_prescaling_from_dt);
> +EXPORT_SYMBOL_NS(qcom_adc5_prescaling_from_dt, IIO_QCOM_VADC);
>  
>  int qcom_adc5_hw_settle_time_from_dt(u32 value,
>  				     const unsigned int *hw_settle)
> @@ -734,7 +734,7 @@ int qcom_adc5_hw_settle_time_from_dt(u32 value,
>  
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL(qcom_adc5_hw_settle_time_from_dt);
> +EXPORT_SYMBOL_NS(qcom_adc5_hw_settle_time_from_dt, IIO_QCOM_VADC);
>  
>  int qcom_adc5_avg_samples_from_dt(u32 value)
>  {
> @@ -743,7 +743,7 @@ int qcom_adc5_avg_samples_from_dt(u32 value)
>  
>  	return __ffs(value);
>  }
> -EXPORT_SYMBOL(qcom_adc5_avg_samples_from_dt);
> +EXPORT_SYMBOL_NS(qcom_adc5_avg_samples_from_dt, IIO_QCOM_VADC);
>  
>  int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
>  {
> @@ -756,7 +756,7 @@ int qcom_adc5_decimation_from_dt(u32 value, const unsigned int *decimation)
>  
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL(qcom_adc5_decimation_from_dt);
> +EXPORT_SYMBOL_NS(qcom_adc5_decimation_from_dt, IIO_QCOM_VADC);
>  
>  int qcom_vadc_decimation_from_dt(u32 value)
>  {
> @@ -766,7 +766,7 @@ int qcom_vadc_decimation_from_dt(u32 value)
>  
>  	return __ffs64(value / VADC_DECIMATION_MIN);
>  }
> -EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
> +EXPORT_SYMBOL_NS(qcom_vadc_decimation_from_dt, IIO_QCOM_VADC);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Qualcomm ADC common functionality");

