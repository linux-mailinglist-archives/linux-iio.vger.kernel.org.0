Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A176E4AF39E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiBIOFK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Feb 2022 09:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234730AbiBIOFJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 09:05:09 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF723C0613C9
        for <linux-iio@vger.kernel.org>; Wed,  9 Feb 2022 06:05:12 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2199mVxB022765;
        Wed, 9 Feb 2022 15:04:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=A74Wr9O9bxdrRwl/sEOdLMz20YTA0PHdX58HXaz6imk=;
 b=JUgcwLh47XO+7JuY/HfN3pQtMoeD6/hKKGCFR1Fc/9BOX9LKbtq5BIEmTfYISDjUWSG7
 1Dd5nHN0zMKoO6AzI3XIJcuKTWFY9HCyXQzLBgLkIN+oar1sIL+ve3FRa1rENPPBJq4V
 eGEsEmRrN3jiTSsKARc1PSHtXjxsgoGUqta2YCBTbbgzX81CWFEJvtU4wNZRlHsp6jT3
 oHujkNlgAYdwYW7PHL6J3d7Mmsihy2jCZwYoViQT7mg9zb348lZEHpzqrzOZnMpTR9eV
 LDvMVp4dWDWDVhJExDt81wztZhCz9t4qzFK02iXQbtDZUuCClbSOkeY8n/NXVPDT9Nd8 aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4ba9hd47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 15:04:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0D4F4100038;
        Wed,  9 Feb 2022 15:04:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF2C42248A8;
        Wed,  9 Feb 2022 15:04:56 +0100 (CET)
Received: from [10.211.4.65] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 9 Feb
 2022 15:04:55 +0100
Subject: Re: [PATCH v3 50/50] iio:adc:stm32*: Use pm[_sleep]_ptr() etc to
 avoid need to make pm __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier Moysan <olivier.moysan@st.com>
References: <20220130193147.279148-1-jic23@kernel.org>
 <20220130193147.279148-51-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <857eeea2-8b9b-bfd9-33f6-49e811989a08@foss.st.com>
Date:   Wed, 9 Feb 2022 15:04:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220130193147.279148-51-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_07,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/30/22 8:31 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The combinations of either
> * pm_sleep_ptr() and DEFINE_SIMPLE_DEV_PM_OPS()
> * pm_ptr() and RUNTIME_PM_OPS()/SYSTEM_SLEEP_PM_OPS
> Make sure the functions are always visible to the compiler and removed by
> it rather than requring #ifdef magic.
> 
> This removes the need to mark the functions as __maybe_unused and saves
> additional space with some build options as the dev_pm_ops structure
> itself can be dropped automatically if CONFIG_PM is not enabled.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Olivier Moysan <olivier.moysan@st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

Hi Jonathan,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the patch,
Best Regards,
Fabrice

>  drivers/iio/adc/stm32-dfsdm-adc.c         | 11 ++++++-----
>  drivers/iio/adc/stm32-dfsdm-core.c        | 19 +++++++++----------
>  drivers/iio/dac/stm32-dac-core.c          | 16 ++++++++--------
>  drivers/iio/dac/stm32-dac.c               |  9 ++++-----
>  drivers/iio/trigger/stm32-timer-trigger.c | 12 ++++++------
>  5 files changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 1cfefb3b5e56..9704cf0b9753 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1632,7 +1632,7 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
> +static int stm32_dfsdm_adc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
> @@ -1642,7 +1642,7 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
> +static int stm32_dfsdm_adc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> @@ -1665,14 +1665,15 @@ static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(stm32_dfsdm_adc_pm_ops,
> -			 stm32_dfsdm_adc_suspend, stm32_dfsdm_adc_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_dfsdm_adc_pm_ops,
> +				stm32_dfsdm_adc_suspend,
> +				stm32_dfsdm_adc_resume);
>  
>  static struct platform_driver stm32_dfsdm_adc_driver = {
>  	.driver = {
>  		.name = "stm32-dfsdm-adc",
>  		.of_match_table = stm32_dfsdm_adc_match,
> -		.pm = &stm32_dfsdm_adc_pm_ops,
> +		.pm = pm_sleep_ptr(&stm32_dfsdm_adc_pm_ops),
>  	},
>  	.probe = stm32_dfsdm_adc_probe,
>  	.remove = stm32_dfsdm_adc_remove,
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index a627af9a825e..a3d4de6ba4c2 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -381,7 +381,7 @@ static int stm32_dfsdm_core_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dfsdm_core_suspend(struct device *dev)
> +static int stm32_dfsdm_core_suspend(struct device *dev)
>  {
>  	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
>  	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> @@ -397,7 +397,7 @@ static int __maybe_unused stm32_dfsdm_core_suspend(struct device *dev)
>  	return pinctrl_pm_select_sleep_state(dev);
>  }
>  
> -static int __maybe_unused stm32_dfsdm_core_resume(struct device *dev)
> +static int stm32_dfsdm_core_resume(struct device *dev)
>  {
>  	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
>  	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> @@ -414,7 +414,7 @@ static int __maybe_unused stm32_dfsdm_core_resume(struct device *dev)
>  	return pm_runtime_force_resume(dev);
>  }
>  
> -static int __maybe_unused stm32_dfsdm_core_runtime_suspend(struct device *dev)
> +static int stm32_dfsdm_core_runtime_suspend(struct device *dev)
>  {
>  	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
>  
> @@ -423,7 +423,7 @@ static int __maybe_unused stm32_dfsdm_core_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dfsdm_core_runtime_resume(struct device *dev)
> +static int stm32_dfsdm_core_runtime_resume(struct device *dev)
>  {
>  	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
>  
> @@ -431,11 +431,10 @@ static int __maybe_unused stm32_dfsdm_core_runtime_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops stm32_dfsdm_core_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(stm32_dfsdm_core_suspend,
> -				stm32_dfsdm_core_resume)
> -	SET_RUNTIME_PM_OPS(stm32_dfsdm_core_runtime_suspend,
> -			   stm32_dfsdm_core_runtime_resume,
> -			   NULL)
> +	SYSTEM_SLEEP_PM_OPS(stm32_dfsdm_core_suspend, stm32_dfsdm_core_resume)
> +	RUNTIME_PM_OPS(stm32_dfsdm_core_runtime_suspend,
> +		       stm32_dfsdm_core_runtime_resume,
> +		       NULL)
>  };
>  
>  static struct platform_driver stm32_dfsdm_driver = {
> @@ -444,7 +443,7 @@ static struct platform_driver stm32_dfsdm_driver = {
>  	.driver = {
>  		.name = "stm32-dfsdm",
>  		.of_match_table = stm32_dfsdm_of_match,
> -		.pm = &stm32_dfsdm_core_pm_ops,
> +		.pm = pm_ptr(&stm32_dfsdm_core_pm_ops),
>  	},
>  };
>  
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index bd7a3b20e645..83bf184e3adc 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -195,7 +195,7 @@ static int stm32_dac_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dac_core_resume(struct device *dev)
> +static int stm32_dac_core_resume(struct device *dev)
>  {
>  	struct stm32_dac_common *common = dev_get_drvdata(dev);
>  	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
> @@ -213,23 +213,23 @@ static int __maybe_unused stm32_dac_core_resume(struct device *dev)
>  	return pm_runtime_force_resume(dev);
>  }
>  
> -static int __maybe_unused stm32_dac_core_runtime_suspend(struct device *dev)
> +static int stm32_dac_core_runtime_suspend(struct device *dev)
>  {
>  	stm32_dac_core_hw_stop(dev);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dac_core_runtime_resume(struct device *dev)
> +static int stm32_dac_core_runtime_resume(struct device *dev)
>  {
>  	return stm32_dac_core_hw_start(dev);
>  }
>  
>  static const struct dev_pm_ops stm32_dac_core_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, stm32_dac_core_resume)
> -	SET_RUNTIME_PM_OPS(stm32_dac_core_runtime_suspend,
> -			   stm32_dac_core_runtime_resume,
> -			   NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, stm32_dac_core_resume)
> +	RUNTIME_PM_OPS(stm32_dac_core_runtime_suspend,
> +		       stm32_dac_core_runtime_resume,
> +		       NULL)
>  };
>  
>  static const struct stm32_dac_cfg stm32h7_dac_cfg = {
> @@ -253,7 +253,7 @@ static struct platform_driver stm32_dac_driver = {
>  	.driver = {
>  		.name = "stm32-dac-core",
>  		.of_match_table = stm32_dac_of_match,
> -		.pm = &stm32_dac_core_pm_ops,
> +		.pm = pm_ptr(&stm32_dac_core_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_dac_driver);
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index cd71cc4553a7..b20192a071cb 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -372,7 +372,7 @@ static int stm32_dac_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_dac_suspend(struct device *dev)
> +static int stm32_dac_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	int channel = indio_dev->channels[0].channel;
> @@ -386,9 +386,8 @@ static int __maybe_unused stm32_dac_suspend(struct device *dev)
>  	return pm_runtime_force_suspend(dev);
>  }
>  
> -static const struct dev_pm_ops stm32_dac_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(stm32_dac_suspend, pm_runtime_force_resume)
> -};
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_dac_pm_ops, stm32_dac_suspend,
> +				pm_runtime_force_resume);
>  
>  static const struct of_device_id stm32_dac_of_match[] = {
>  	{ .compatible = "st,stm32-dac", },
> @@ -402,7 +401,7 @@ static struct platform_driver stm32_dac_driver = {
>  	.driver = {
>  		.name = "stm32-dac",
>  		.of_match_table = stm32_dac_of_match,
> -		.pm = &stm32_dac_pm_ops,
> +		.pm = pm_sleep_ptr(&stm32_dac_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_dac_driver);
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 4f9461e1412c..d72ac4c0bca4 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -827,7 +827,7 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
> +static int stm32_timer_trigger_suspend(struct device *dev)
>  {
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  
> @@ -849,7 +849,7 @@ static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
> +static int stm32_timer_trigger_resume(struct device *dev)
>  {
>  	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
>  	int ret;
> @@ -875,9 +875,9 @@ static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
> -			 stm32_timer_trigger_suspend,
> -			 stm32_timer_trigger_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
> +				stm32_timer_trigger_suspend,
> +				stm32_timer_trigger_resume);
>  
>  static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
>  	.valids_table = valids_table,
> @@ -907,7 +907,7 @@ static struct platform_driver stm32_timer_trigger_driver = {
>  	.driver = {
>  		.name = "stm32-timer-trigger",
>  		.of_match_table = stm32_trig_of_match,
> -		.pm = &stm32_timer_trigger_pm_ops,
> +		.pm = pm_sleep_ptr(&stm32_timer_trigger_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_timer_trigger_driver);
> 
