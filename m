Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B145B78F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 10:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhKXJhI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 04:37:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229675AbhKXJhH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 04:37:07 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AO965co002275;
        Wed, 24 Nov 2021 10:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ZsoVhYB+6YXmCEuk/ZwSe/1ggtk/eWeg7AQEH3l6lTM=;
 b=nghTKTl5wsvREbEWTBe08sSvvrcbRSXHVsH3oJuWP+QGpPXi2WWQR7FbFOJONLY0a3lj
 kgXkZBvbdLGbN3pHUNUpBjwUgsUOMn5rmpfKtkI7/Bg4jRvPPiPGDssTkksvjs3iQMH1
 6pZ8uc9UYkL37UYlxOmJ5i+pyPCrkvmggh1TMUrw/qsghn6z9dD/tQ3UMHE4jFRMhfD3
 7b2Fs3zHbESVTa0KNvuqp63W8Z6M+u2bOt+/yOXthkBDy6di9sZN9xY45ri1Gk/EcdkV
 UFCAMTmfVbnk4fPK53a0I9kOx1iwoCDvhlSL2IKGR5NPc1IUh9oCQrMxnnW9x2bZzZnL iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3chbneab84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 10:33:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58B7110002A;
        Wed, 24 Nov 2021 10:33:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 47DF921CA8E;
        Wed, 24 Nov 2021 10:33:37 +0100 (CET)
Received: from [10.211.3.49] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 24 Nov
 2021 10:33:36 +0100
Subject: Re: [PATCH 16/49] iio:adc:stm32:Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
 <20211123211019.2271440-17-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <3b1cd6d9-a761-86fe-7ed6-6b2290286913@foss.st.com>
Date:   Wed, 24 Nov 2021 10:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211123211019.2271440-17-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_03,2021-11-23_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/23/21 10:09 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 

Hi Jonathan,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for your patch,
Best Regards,
Fabrice

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc-core.c | 12 +++++-------
>  drivers/iio/adc/stm32-adc.c      | 16 ++++++----------
>  2 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index b6e18eb101f7..316ae84ab961 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -763,28 +763,26 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_PM)
> -static int stm32_adc_core_runtime_suspend(struct device *dev)
> +static __maybe_unused int stm32_adc_core_runtime_suspend(struct device *dev)
>  {
>  	stm32_adc_core_hw_stop(dev);
>  
>  	return 0;
>  }
>  
> -static int stm32_adc_core_runtime_resume(struct device *dev)
> +static __maybe_unused int stm32_adc_core_runtime_resume(struct device *dev)
>  {
>  	return stm32_adc_core_hw_start(dev);
>  }
>  
> -static int stm32_adc_core_runtime_idle(struct device *dev)
> +static __maybe_unused int stm32_adc_core_runtime_idle(struct device *dev)
>  {
>  	pm_runtime_mark_last_busy(dev);
>  
>  	return 0;
>  }
> -#endif
>  
> -static const struct dev_pm_ops stm32_adc_core_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops stm32_adc_core_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>  				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
> @@ -836,7 +834,7 @@ static struct platform_driver stm32_adc_driver = {
>  	.driver = {
>  		.name = "stm32-adc-core",
>  		.of_match_table = stm32_adc_of_match,
> -		.pm = &stm32_adc_core_pm_ops,
> +		.pm = pm_ptr(&stm32_adc_core_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_adc_driver);
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 7f1fb36c747c..2d94de6de848 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2351,8 +2351,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_PM_SLEEP)
> -static int stm32_adc_suspend(struct device *dev)
> +static __maybe_unused int stm32_adc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
> @@ -2362,7 +2361,7 @@ static int stm32_adc_suspend(struct device *dev)
>  	return pm_runtime_force_suspend(dev);
>  }
>  
> -static int stm32_adc_resume(struct device *dev)
> +static __maybe_unused int stm32_adc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	int ret;
> @@ -2381,21 +2380,18 @@ static int stm32_adc_resume(struct device *dev)
>  
>  	return stm32_adc_buffer_postenable(indio_dev);
>  }
> -#endif
>  
> -#if defined(CONFIG_PM)
> -static int stm32_adc_runtime_suspend(struct device *dev)
> +static __maybe_unused int stm32_adc_runtime_suspend(struct device *dev)
>  {
>  	return stm32_adc_hw_stop(dev);
>  }
>  
> -static int stm32_adc_runtime_resume(struct device *dev)
> +static __maybe_unused int stm32_adc_runtime_resume(struct device *dev)
>  {
>  	return stm32_adc_hw_start(dev);
>  }
> -#endif
>  
> -static const struct dev_pm_ops stm32_adc_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops stm32_adc_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
>  	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
>  			   NULL)
> @@ -2452,7 +2448,7 @@ static struct platform_driver stm32_adc_driver = {
>  	.driver = {
>  		.name = "stm32-adc",
>  		.of_match_table = stm32_adc_of_match,
> -		.pm = &stm32_adc_pm_ops,
> +		.pm = pm_ptr(&stm32_adc_pm_ops),
>  	},
>  };
>  module_platform_driver(stm32_adc_driver);
> 
