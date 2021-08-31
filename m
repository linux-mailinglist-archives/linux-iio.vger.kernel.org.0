Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE11E3FC87C
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 15:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhHaNmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 09:42:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39998 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233789AbhHaNmj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 09:42:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17V921ZZ014213;
        Tue, 31 Aug 2021 15:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xBK3pqlFL97RTUxttGzt1l2EgAMHJw/Nm5xYjtTYw7M=;
 b=CrDRIxtCxVYJHaq/yc9f6cFjObY9OA1OZcmuFIQTXa0NYgzvrLvieOr8U77xZadenCsA
 Pe8oeqlvHKPF8gu317rlicl/gd5A6sbvoNW0Lc7111CX6mybEZ7V86+vo2FrespkfLuJ
 AxYoEATcJW2DdKvDkSgJ3o61HvATIQLDIW5/5Tn65aJ6EH0Q4GCNf6tkwVI2kc38R4fJ
 2jF/vcSdGpSY45Qz8EsK9L3DMXh5JgpHCgNw2w7lPenjCe1hnFSpU+FKS3ycjxJqlO6y
 UVKvbSxw/tDbrXbh6JcZoMHxnSWHhRy2Ln8ENodH+PqHKnZtKjVKuRYP6u9ki6Uwof6A cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3asheh1hcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:40:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B40410002A;
        Tue, 31 Aug 2021 15:40:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0306424692E;
        Tue, 31 Aug 2021 15:40:40 +0200 (CEST)
Received: from [10.211.11.146] (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 15:40:38 +0200
Subject: Re: [PATCH v16 02/14] counter: stm32-timer-cnt: Provide defines for
 slave mode selection
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@pengutronix.de>, <a.fatoum@pengutronix.de>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <alexandre.belloni@bootlin.com>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <syednwaris@gmail.com>,
        <patrick.havelange@essensium.com>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <o.rempel@pengutronix.de>, <jarkko.nikula@linux.intel.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <ad3d9cd7af580d586316d368f74964cbc394f981.1630031207.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <ad245fd3-5751-08e6-3f3a-30522822f0af@foss.st.com>
Date:   Tue, 31 Aug 2021 15:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ad3d9cd7af580d586316d368f74964cbc394f981.1630031207.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_05,2021-08-31_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> The STM32 timer permits configuration of the counter encoder mode via
> the slave mode control register (SMCR) slave mode selection (SMS) bits.
> This patch provides preprocessor defines for the supported encoder
> modes.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 16 ++++++++--------
>  include/linux/mfd/stm32-timers.h  |  4 ++++
>  2 files changed, 12 insertions(+), 8 deletions(-)

Hi William,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 3fb0debd7425..1fbc46f4ee66 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -93,16 +93,16 @@ static int stm32_count_function_get(struct counter_device *counter,
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
>  
>  	switch (smcr & TIM_SMCR_SMS) {
> -	case 0:
> +	case TIM_SMCR_SMS_SLAVE_MODE_DISABLED:
>  		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
>  		return 0;
> -	case 1:
> +	case TIM_SMCR_SMS_ENCODER_MODE_1:
>  		*function = STM32_COUNT_ENCODER_MODE_1;
>  		return 0;
> -	case 2:
> +	case TIM_SMCR_SMS_ENCODER_MODE_2:
>  		*function = STM32_COUNT_ENCODER_MODE_2;
>  		return 0;
> -	case 3:
> +	case TIM_SMCR_SMS_ENCODER_MODE_3:
>  		*function = STM32_COUNT_ENCODER_MODE_3;
>  		return 0;
>  	default:
> @@ -119,16 +119,16 @@ static int stm32_count_function_set(struct counter_device *counter,
>  
>  	switch (function) {
>  	case STM32_COUNT_SLAVE_MODE_DISABLED:
> -		sms = 0;
> +		sms = TIM_SMCR_SMS_SLAVE_MODE_DISABLED;
>  		break;
>  	case STM32_COUNT_ENCODER_MODE_1:
> -		sms = 1;
> +		sms = TIM_SMCR_SMS_ENCODER_MODE_1;
>  		break;
>  	case STM32_COUNT_ENCODER_MODE_2:
> -		sms = 2;
> +		sms = TIM_SMCR_SMS_ENCODER_MODE_2;
>  		break;
>  	case STM32_COUNT_ENCODER_MODE_3:
> -		sms = 3;
> +		sms = TIM_SMCR_SMS_ENCODER_MODE_3;
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> index f8db83aedb2b..5f5c43fd69dd 100644
> --- a/include/linux/mfd/stm32-timers.h
> +++ b/include/linux/mfd/stm32-timers.h
> @@ -82,6 +82,10 @@
>  #define MAX_TIM_ICPSC		0x3
>  #define TIM_CR2_MMS_SHIFT	4
>  #define TIM_CR2_MMS2_SHIFT	20
> +#define TIM_SMCR_SMS_SLAVE_MODE_DISABLED	0 /* counts on internal clock when CEN=1 */
> +#define TIM_SMCR_SMS_ENCODER_MODE_1		1 /* counts TI1FP1 edges, depending on TI2FP2 level */
> +#define TIM_SMCR_SMS_ENCODER_MODE_2		2 /* counts TI2FP2 edges, depending on TI1FP1 level */
> +#define TIM_SMCR_SMS_ENCODER_MODE_3		3 /* counts on both TI1FP1 and TI2FP2 edges */
>  #define TIM_SMCR_TS_SHIFT	4
>  #define TIM_BDTR_BKF_MASK	0xF
>  #define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
> 
