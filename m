Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D625A37BE39
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELNbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:31:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45970 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230037AbhELNbl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 09:31:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CDS5pK020489;
        Wed, 12 May 2021 15:30:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0TtSf6S1Z1b35zVfeOahUF4D/YOMVW/CULSJ+EFG6Q4=;
 b=AsTCRuGKUfNncZT6keHarlgt3MZMyTKLIXfXo3x4m0Nda13AAggYTVVKshkrNKWA4x++
 rUt0RjIsBG2mJYuqm4j6r74s+zQz11MKgOA5NFIS2/FckLzVyLpVoWo3jsb5AhFPQg3P
 ja3ybbhaANp1cXpsru81SCDCh+9wi/Sy2cYBLpFfU4pQVOxb35T8kAdhvTjwL3DvxfFQ
 tIN9YMEv28j+surcfDe8ShXYwfHmLaygfjBQN2zMZwf9DFx0yLyB6+coK6F+g11YUuQ3
 g6c9SvQyacLzzuOLE8Gw1TIAlXPAGFodU1GxtugEhMOGIUBigMaU1XAb2dZ2ikWEsFCw rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38fq9tqr7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 15:30:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E47D7100034;
        Wed, 12 May 2021 15:30:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 91EED225609;
        Wed, 12 May 2021 15:30:16 +0200 (CEST)
Received: from [10.211.1.115] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 15:30:15 +0200
Subject: Re: [PATCH 14/28] iio: adc: stm32-adc: Use
 pm_runtime_resume_and_get() to replace open coding.
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-15-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <68dbe680-ff35-91d8-55f7-a3e0e65f29e7@foss.st.com>
Date:   Wed, 12 May 2021 15:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210509113354.660190-15-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_07:2021-05-12,2021-05-12 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Hi Jonathan,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the patch,
Regards,
Fabrice

> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index c9d36c88ee6a..5088de835bb1 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1158,11 +1158,9 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  
>  	adc->bufi = 0;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/* Apply sampling time settings */
>  	stm32_adc_writel(adc, regs->smpr[0], adc->smpr_val[0]);
> @@ -1364,11 +1362,9 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
>  
> @@ -1413,11 +1409,9 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	if (!readval)
>  		stm32_adc_writel(adc, reg, writeval);
> @@ -1537,11 +1531,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	struct device *dev = indio_dev->dev.parent;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
>  	if (ret) {
> 
