Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE63543773C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhJVMlX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 08:41:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46396 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230408AbhJVMlX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 08:41:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19M8oAI7015574;
        Fri, 22 Oct 2021 14:38:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IZsl6uDSkRbqjxsBR6K5ycdFS1rDWon59p3JRZb3iOM=;
 b=jb8gedRa3xzAwLy6UUq/gI/pRUBCNz1C5kZgjuKb49JM2Lr8b1ZLLgSCACwz5tKTHOYB
 ftQlPTmFYPy8/394Xf//A0tAvyzrVgmrZUKMqOuZwifIDH/o65s07702E/HEdQYVPptc
 I1taEqI37dQOCFJ9A4BzTzAzn4xryoiXCiY0JLNopQx3IP8heytrmTU78TPDqopiT0QR
 CyrUlJpUfFfzIdOoVF4JdcbiXrg9huswzpMC5qbqjlnR4g4yOuw18EjuCEJLQk9BCyhM
 rO9Cg/OV1ESGcZvCIOirfBzPLlDIKqOcsiyzLdoDFFXKDJKx4rLU2cotssEjDikGmup4 hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3but4y1cc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 14:38:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81F9F10002A;
        Fri, 22 Oct 2021 14:38:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A5F821F0A5;
        Fri, 22 Oct 2021 14:38:54 +0200 (CEST)
Received: from lmecxl0577.lme.st.com (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 22 Oct
 2021 14:38:53 +0200
Subject: Re: [PATCH] iio: adc: stm32: fix a leak by resetting pcsel before
 disabling vdda
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
Message-ID: <77f3593a-0e94-f5ab-f102-86ba8d0f1a3b@foss.st.com>
Date:   Fri, 22 Oct 2021 14:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_03,2021-10-22_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Fabrice,

On 10/22/21 2:19 PM, Fabrice Gasnier wrote:
> Some I/Os are connected to ADC input channels, when the corresponding bit
> in PCSEL register are set on STM32H7 and STM32MP15. This is done in the
> prepare routine of stm32-adc driver.
> There are constraints here, as PCSEL shouldn't be set when VDDA supply
> is disabled. Enabling/disabling of VDDA supply in done via stm32-adc-core
> runtime PM routines (before/after ADC is enabled/disabled).
> 
> Currently, PCSEL remains set when disabling ADC. Later on, PM runtime
> can disable the VDDA supply. This creates some conditions on I/Os that
> can start to leak current.
> So PCSEL needs to be cleared when disabling the ADC.
> 
> Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   drivers/iio/adc/stm32-adc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 5088de8..e3e7541 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -975,6 +975,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
>   {
>   	struct stm32_adc *adc = iio_priv(indio_dev);
>   
> +	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
>   	stm32h7_adc_disable(indio_dev);
>   	stm32h7_adc_enter_pwr_down(adc);
>   }
> 

Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>

Thanks
Olivier
