Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCFC36E6F3
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhD2IRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 04:17:00 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:11602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232480AbhD2IQ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 04:16:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13T8AjdW007177;
        Thu, 29 Apr 2021 10:16:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=OuvovnZksrZCaSbY5PMovdoAT58xVgjjdSdXd2wOHCU=;
 b=lSR7x1TgxBDV8mPES2XbNdH/Zlid60lZX7sRJxOWFOaVQDZE4+EJZqdJcL/CeUn6jZXx
 csKNgPnp+ggLmpbk/ZrkZQG4OTUG3q+yWAQ9cqNX3pqvA59MPP4Md6b42XHE+am8pf9b
 GhOmdoouqH/ZrTXXBgt8FUch5oGQDGHxzLlekXuYOlhSHq2j4HVQQcQOoHioiWasAEdh
 T6d2CNLj60Nw/rwEBDp61voUAJI3lLiYSpbYEWG0NHdcsvPEIlYxEo3DAiriAE4z1rjW
 eWeS5oBiMgoOGh2Bw0CVgbieIpwVdWoUL75xuJp7fCPEnUhsobQfVf15SOR8jSz+YRgj Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3871k17y4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 10:16:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B90210002A;
        Thu, 29 Apr 2021 10:16:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E2E1420EA00;
        Thu, 29 Apr 2021 10:16:01 +0200 (CEST)
Received: from [10.211.0.181] (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Apr
 2021 10:16:01 +0200
Subject: Re: [PATCH] iio: adc: stm32-adc: Fix docs wrongly marked as
 kernel-doc
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20210428192612.147524-1-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <03045348-8edd-7a93-cdb4-2cb412ff5cd9@foss.st.com>
Date:   Thu, 29 Apr 2021 10:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428192612.147524-1-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_05:2021-04-28,2021-04-29 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/28/21 9:26 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> W=1 highlights these two cases that are obviously not in kernel-doc
> format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Jonathan,

I've been a bit surprised but I finally found out the checks have
evolved [1].
[1] https://lore.kernel.org/linux-next/87pmzlvi0y.fsf@meer.lwn.net/T/

It seems it's exposed by commit:
52042e2db452 ("scripts: kernel-doc: validate kernel-doc markup with the
actual names")

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> ---
>  drivers/iio/adc/stm32-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 922af2d75c1e..5088de835bb1 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -449,7 +449,7 @@ static const struct stm32_adc_regspec stm32h7_adc_regspec = {
>  	.smp_bits = stm32h7_smp_bits,
>  };
>  
> -/**
> +/*
>   * STM32 ADC registers access routines
>   * @adc: stm32 adc instance
>   * @reg: reg offset in adc instance
> @@ -851,7 +851,7 @@ static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -/**
> +/*
>   * Fixed timeout value for ADC calibration.
>   * worst cases:
>   * - low clock frequency
> 
