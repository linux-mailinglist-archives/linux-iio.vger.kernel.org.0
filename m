Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C43264B1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 16:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZPZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 10:25:28 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48068 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229745AbhBZPZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 10:25:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QFMuTb029488;
        Fri, 26 Feb 2021 16:24:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=enMfC+PWGoNkoTGsyvHg5qpNwFuwchf5UpLej42yuI4=;
 b=iuI1YDxdQ5L5AWX9ZzptPh6xYtZ+Lr9X6+B1p0cGGIQKVfuk8ajUV9kJjDJ/2HR/CiMd
 4TK6E1cOpWDsrgQRkdliLuft43Yf0lczUm+NE5Yv9FSJ1bov6/+N57u/HwHvN2B+5EB1
 C/IrWCM+9vpLooIx8+sODbh2Y74Cc58civ9xu1M2aISqIf6+sKoBfGDox+0UXP7sWLKp
 jeDglU9SNBz7u3XSf41RzmNz8f1/ssE5omdXOJLZ0jQ+TfaH8+aKxu9ozmcBjgyxc1Ay
 3ddcfTtMZpoHN3McsyQAMgB3rm0apz+y8rYhYlSd6U+frPM2eQyr0YApv2QWKUYi6wt2 yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36w66vxdrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:24:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B7F010002A;
        Fri, 26 Feb 2021 16:24:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4983724ABBE;
        Fri, 26 Feb 2021 16:24:34 +0100 (CET)
Received: from [10.211.2.127] (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Feb
 2021 16:24:33 +0100
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: Report count function when
 SLAVE_MODE_DISABLED
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <benjamin.gaignard@st.com>
References: <20210226012931.161429-1-vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <d6ae294d-5d49-bb3f-6456-a485a247323c@foss.st.com>
Date:   Fri, 26 Feb 2021 16:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226012931.161429-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_03:2021-02-24,2021-02-26 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/26/21 2:29 AM, William Breathitt Gray wrote:
> When in SLAVE_MODE_DISABLED mode, the count still increases if the
> counter is enabled because an internal clock is used. This patch fixes
> the stm32_count_function_get() and stm32_count_function_set() functions
> to properly handle this behavior.
> 
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
> Changes in v2:
>  - Support an explicit 0 case for function_get()/function_set()
> 
>  drivers/counter/stm32-timer-cnt.c | 39 ++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 14 deletions(-)

Hi William,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Many thanks for this fix.
Best Regards,
Fabrice


> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index ef2a974a2f10..cd50dc12bd02 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -44,13 +44,14 @@ struct stm32_timer_cnt {
>   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
>   */
>  enum stm32_count_function {
> -	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
> +	STM32_COUNT_SLAVE_MODE_DISABLED,
>  	STM32_COUNT_ENCODER_MODE_1,
>  	STM32_COUNT_ENCODER_MODE_2,
>  	STM32_COUNT_ENCODER_MODE_3,
>  };
>  
>  static enum counter_count_function stm32_count_functions[] = {
> +	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
>  	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
>  	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
>  	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> @@ -90,6 +91,9 @@ static int stm32_count_function_get(struct counter_device *counter,
>  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
>  
>  	switch (smcr & TIM_SMCR_SMS) {
> +	case 0:
> +		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
> +		return 0;
>  	case 1:
>  		*function = STM32_COUNT_ENCODER_MODE_1;
>  		return 0;
> @@ -99,9 +103,9 @@ static int stm32_count_function_get(struct counter_device *counter,
>  	case 3:
>  		*function = STM32_COUNT_ENCODER_MODE_3;
>  		return 0;
> +	default:
> +		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
>  }
>  
>  static int stm32_count_function_set(struct counter_device *counter,
> @@ -112,6 +116,9 @@ static int stm32_count_function_set(struct counter_device *counter,
>  	u32 cr1, sms;
>  
>  	switch (function) {
> +	case STM32_COUNT_SLAVE_MODE_DISABLED:
> +		sms = 0;
> +		break;
>  	case STM32_COUNT_ENCODER_MODE_1:
>  		sms = 1;
>  		break;
> @@ -122,8 +129,7 @@ static int stm32_count_function_set(struct counter_device *counter,
>  		sms = 3;
>  		break;
>  	default:
> -		sms = 0;
> -		break;
> +		return -EINVAL;
>  	}
>  
>  	/* Store enable status */
> @@ -274,31 +280,36 @@ static int stm32_action_get(struct counter_device *counter,
>  	size_t function;
>  	int err;
>  
> -	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
> -	*action = STM32_SYNAPSE_ACTION_NONE;
> -
>  	err = stm32_count_function_get(counter, count, &function);
>  	if (err)
> -		return 0;
> +		return err;
>  
>  	switch (function) {
> +	case STM32_COUNT_SLAVE_MODE_DISABLED:
> +		/* counts on internal clock when CEN=1 */
> +		*action = STM32_SYNAPSE_ACTION_NONE;
> +		return 0;
>  	case STM32_COUNT_ENCODER_MODE_1:
>  		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
>  		if (synapse->signal->id == count->synapses[0].signal->id)
>  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		else
> +			*action = STM32_SYNAPSE_ACTION_NONE;
> +		return 0;
>  	case STM32_COUNT_ENCODER_MODE_2:
>  		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
>  		if (synapse->signal->id == count->synapses[1].signal->id)
>  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		else
> +			*action = STM32_SYNAPSE_ACTION_NONE;
> +		return 0;
>  	case STM32_COUNT_ENCODER_MODE_3:
>  		/* counts up/down on both TI1FP1 and TI2FP2 edges */
>  		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		return 0;
> +	default:
> +		return -EINVAL;
>  	}
> -
> -	return 0;
>  }
>  
>  static const struct counter_ops stm32_timer_cnt_ops = {
> 
