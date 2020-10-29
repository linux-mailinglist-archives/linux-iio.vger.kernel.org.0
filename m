Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5929EA9B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgJ2Lcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 07:32:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44794 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727677AbgJ2Lcb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 07:32:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TBR0AU012814;
        Thu, 29 Oct 2020 12:32:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=4+1Op2RV/23UrA0vNOm4u+eLDwQyANlhkaHLvGe8m90=;
 b=H3H1DRysG8v90GAtNTaGhNmqWClcg/HhSZpCi2ghtH2m+RX2aQXCkTmx1lBc0C67oF+f
 YkGc4Z0cT7Pw4+nvd4TxXsyrWJmNrm3IXGjcpUKsf/gQ4fBG1NoqMscPzK2Vh6hAdylz
 iBsE04GNKWIJhvJiIClt1opt143h2Frci7Du2DYw9L0ABFvhNG/jINYmiKcldSaTmpDU
 iGzeVSCW+qh+DjjcZRRrWiahDOd2hpCKdCA2e+/7XsgeZODTH90p+AKyzKWmILYAtCsR
 swMQThecQBhhU5y2LXbhlUKmDOPfQR92xKFhB/paBvkEDayrxyzZA0Bb5ibfJr6LLYan Zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccffrq0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 12:32:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 39C7C100038;
        Thu, 29 Oct 2020 12:32:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 052082823BD;
        Thu, 29 Oct 2020 12:32:10 +0100 (CET)
Received: from [10.48.1.149] (10.75.127.44) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 12:31:19 +0100
Subject: Re: [PATCH 10/15] iio: adc: stm32: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
 <20201029074910.227859-10-coiby.xu@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <0d58cf8c-997c-959f-f952-999b0d3acdb1@st.com>
Date:   Thu, 29 Oct 2020 12:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029074910.227859-10-coiby.xu@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_06:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/29/20 8:49 AM, Coiby Xu wrote:
> SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index b3f31f147347..42f9013730f8 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1988,7 +1988,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_PM_SLEEP)

Hi Coiby,

This generates warnings when building with W=1 and CONFIG_PM_SLEEP=n.
Could you please add also "__maybe_unused" attribute in suspend / resume
routines below.

>  static int stm32_adc_suspend(struct device *dev)
             ^
e.g. like: static int __maybe_unused stm32_adc_...

>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -2018,7 +2017,6 @@ static int stm32_adc_resume(struct device *dev)
>  
>  	return stm32_adc_buffer_postenable(indio_dev);
>  }
> -#endif
>  
>  #if defined(CONFIG_PM)

Same could be done also for runtime PM routines. For my own curiosity,
do you plan to do this as well ?

Best regards,
Fabrice
>  static int stm32_adc_runtime_suspend(struct device *dev)
> 
