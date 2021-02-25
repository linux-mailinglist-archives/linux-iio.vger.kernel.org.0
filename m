Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A689324F03
	for <lists+linux-iio@lfdr.de>; Thu, 25 Feb 2021 12:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBYLUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 06:20:22 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54324 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234675AbhBYLUV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 06:20:21 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PBHF5r006407;
        Thu, 25 Feb 2021 12:19:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=CMTm/gPp7SHBgmvKDTH9L2sSez0dNF3orqXJb1JT8M4=;
 b=MvAR4Vv/NHFJsNA0pv6LrnxkIuwZSUtNrUvWrBXo0SthxC6nF3KtidapmIO5QY/f5M3Y
 bxoONQEw5hO7tv23xOkXyF62AHTjNfLewBoyfnbFOLdSpR31ACHQWKZODGlOREIH7JF/
 AQPXmzqtZaGDi+JOyWU31Ums/ms7LV/q1XYdjftFs2DcUamHJnG1e08Z95p2Of/nFEy3
 BMPV/Ad9zkCO90nd19ZDMjnwcAzfE910H3U2+AxtoJE3uGEla5qhqPKwIGiN2DJya9bH
 35btoWnIfhT8uIxctSmhof5jOMMWVqhdlNlDrjUIt8fubQpS7+QtuMh4SXMqq7cWle7q 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36w66cn91j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 12:19:26 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DE3A710002A;
        Thu, 25 Feb 2021 12:19:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A25F22529A;
        Thu, 25 Feb 2021 12:19:20 +0100 (CET)
Received: from [10.211.6.253] (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Feb
 2021 12:19:19 +0100
Subject: Re: [PATCH] counter: stm32-timer-cnt: Report count function when
 SLAVE_MODE_DISABLED
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210219095906.220382-1-vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <288929fc-6984-072b-359a-10e163056bad@foss.st.com>
Date:   Thu, 25 Feb 2021 12:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210219095906.220382-1-vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_06:2021-02-24,2021-02-25 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/19/21 10:59 AM, William Breathitt Gray wrote:
> When in SLAVE_MODE_DISABLED mode, the count still increases if the
> counter is enabled because an internal clock is used. This patch fixes
> the stm32_count_function_get() function to properly report this
> behavior.

Hi William,

Thanks for the patch, that's something I also noticed earlier.
Please find few comment below.

> 
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/stm32-timer-cnt.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index ef2a974a2f10..ec6d9e89c028 100644
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
> @@ -99,9 +100,10 @@ static int stm32_count_function_get(struct counter_device *counter,
>  	case 3:
>  		*function = STM32_COUNT_ENCODER_MODE_3;
>  		return 0;
> +	default:

I'd rather add a 'case 0', as that's the real value for slave mode
disabled. For reference, here's what the STM32 timer spec says on slave
mode selection:
0000: Slave mode disabled - if CEN = ‘1’ then the prescaler is clocked
directly by the internal clock.

> +		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
> +		return 0;
>  	}
> -
> -	return -EINVAL;

Other slave modes could be added later (like counting on external
signals: channel A, B, ETR or other signals). But this isn't supported
right now in the driver.
Then I suggest to keep the returning -EINVAL for the default case here.
Do you agree with this approach ?

>  }
>  
>  static int stm32_count_function_set(struct counter_device *counter,
> @@ -274,31 +276,36 @@ static int stm32_action_get(struct counter_device *counter,
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

This makes sense, in case the error reporting is kept above. Otherwise,
it always returns 0.

>  
>  	switch (function) {
>  	case STM32_COUNT_ENCODER_MODE_1:
>  		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
>  		if (synapse->signal->id == count->synapses[0].signal->id)
>  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		else
> +			*action = STM32_SYNAPSE_ACTION_NONE;

More a question here...

> +		return 0;
>  	case STM32_COUNT_ENCODER_MODE_2:
>  		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
>  		if (synapse->signal->id == count->synapses[1].signal->id)
>  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		else
> +			*action = STM32_SYNAPSE_ACTION_NONE;

..., not related to your fix: In "quadrature x2 a" or "quadrature x2 b",
the other signal determines the counting direction.
I feel like this isn't really represented with the "none" action.

I just realized if we want to extend this driver to add new signals
(e.g. like counting on chA, chB or even by adding other signals like ETR
on STM32 with the increase function), this may start to be confusing.
Currently only the two signal names could give some hint (so it's rather
obvious currently).

Maybe there could be some change later to indicate the other signal
(channel A or channel B) participates in quadrature encoding ?


Thanks and best regards,
Fabrice

> +		return 0;
>  	case STM32_COUNT_ENCODER_MODE_3:
>  		/* counts up/down on both TI1FP1 and TI2FP2 edges */
>  		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		return 0;
> +	case STM32_COUNT_SLAVE_MODE_DISABLED:
> +		/* counts on internal clock when CEN=1 */
> +		*action = STM32_SYNAPSE_ACTION_NONE;
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
