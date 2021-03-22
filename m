Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984BB344B43
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 17:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCVQ1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 12:27:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:28406 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231142AbhCVQ1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 12:27:24 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MGMvHv030099;
        Mon, 22 Mar 2021 17:26:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=njz669Z3QQdJ4hJbI1GB/Wc42/9Usg2LVkptUBbrEb8=;
 b=MdBh1N8DA+ERt5yhkcx2EsANla4WZlgG9g+QuHzgyiqdyoYihOJYXeM4iHHO0yIPxmjI
 CNzJk/q/a9A16fjbcjCkJKaOAX4V3pA6F8f43PHPdq3gwl9LrsD18dyEx2Tf5Vtn3CI8
 U7eLFQweUr2gHgp6lrWW3tpnfGjn9W8F1qqFvUFQiMpA7mkZ9p0zk0Kg8pGr1WMzbHso
 yPtQYipKRMbEx/da5cD8hNK/bPnLJobr+9XfRocx787f8UXd4vHmrf/teURKfN2iEycL
 MADYk7qIi7CrI1LiQU4+/biKlDSTYwblMlfB3jDzcdl5SrNjEbSOQzlRcR4IfTp4boT+ Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d72djsft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:26:18 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCEA810002A;
        Mon, 22 Mar 2021 17:26:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB4EE22F114;
        Mon, 22 Mar 2021 17:26:17 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 17:26:16 +0100
Subject: Re: [Linux-stm32] [PATCH v10 18/33] counter: Return error code on
 invalid modes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <david@lechnology.com>, <linux-iio@vger.kernel.org>,
        <patrick.havelange@essensium.com>, <alexandre.belloni@bootlin.com>,
        <mcoquelin.stm32@gmail.com>, <linux-kernel@vger.kernel.org>,
        <o.rempel@pengutronix.de>, <kernel@pengutronix.de>,
        <fabrice.gasnier@st.com>, <syednwaris@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <alexandre.torgue@st.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <e1dd9e43f713ccaa29e1c05d7b21d86bff02ab34.1616150619.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <91f41020-d042-e69a-e1e8-ef4a0ebe4bf8@foss.st.com>
Date:   Mon, 22 Mar 2021 17:26:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e1dd9e43f713ccaa29e1c05d7b21d86bff02ab34.1616150619.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_08:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/21 12:00 PM, William Breathitt Gray wrote:
> Only a select set of modes (function, action, etc.) are valid for a
> given device configuration. This patch ensures that invalid modes result
> in a return -EINVAL. Such a situation should never occur in reality, but
> it's good to define a default switch cases for the sake of making the
> intent of the code clear.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c            | 20 +++++++----
>  drivers/counter/microchip-tcb-capture.c |  6 ++++
>  drivers/counter/stm32-lptimer-cnt.c     | 10 +++---

Hi William,

Fro the STM32 driver, You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice


>  drivers/counter/ti-eqep.c               | 45 +++++++++++--------------
>  4 files changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 09d779544969..b7d6c1c43655 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -273,6 +273,10 @@ static int quad8_function_set(struct counter_device *counter,
>  			*scale = 2;
>  			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
>  			break;
> +		default:
> +			/* should never reach this path */
> +			mutex_unlock(&priv->lock);
> +			return -EINVAL;
>  		}
>  	}
>  
> @@ -349,7 +353,7 @@ static int quad8_action_get(struct counter_device *counter,
>  	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
>  		if (synapse->signal->id == signal_a_id)
>  			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> -		break;
> +		return 0;
>  	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
>  		if (synapse->signal->id == signal_a_id) {
>  			quad8_direction_get(counter, count, &direction);
> @@ -359,17 +363,18 @@ static int quad8_action_get(struct counter_device *counter,
>  			else
>  				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
>  		}
> -		break;
> +		return 0;
>  	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
>  		if (synapse->signal->id == signal_a_id)
>  			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		return 0;
>  	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
>  		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		return 0;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
> -
> -	return 0;
>  }
>  
>  static const struct counter_ops quad8_ops = {
> @@ -529,6 +534,9 @@ static int quad8_count_mode_set(struct counter_device *counter,
>  	case COUNTER_COUNT_MODE_MODULO_N:
>  		cnt_mode = 3;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	mutex_lock(&priv->lock);
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 51b8af80f98b..0c9a61962911 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -133,6 +133,9 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
>  		bmr |= ATMEL_TC_QDEN | ATMEL_TC_POSEN;
>  		cmr |= ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_ABETRG | ATMEL_TC_XC0;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	regmap_write(priv->regmap, ATMEL_TC_BMR, bmr);
> @@ -226,6 +229,9 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
>  	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
>  		edge = ATMEL_TC_ETRGEDG_BOTH;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	return regmap_write_bits(priv->regmap,
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index c19d998df5ba..78f383b77bd2 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -206,9 +206,10 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
>  		priv->quadrature_mode = 1;
>  		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
>  		return 0;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
>  }
>  
>  static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
> @@ -326,9 +327,10 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
>  	case STM32_LPTIM_ENCODER_BOTH_EDGE:
>  		*action = priv->polarity;
>  		return 0;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
> -
> -	return -EINVAL;
>  }
>  
>  static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 65df9ef5b5bc..878725c2f010 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -157,44 +157,39 @@ static int ti_eqep_action_get(struct counter_device *counter,
>  		 * QEPA and QEPB trigger QCLK.
>  		 */
>  		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> -		break;
> +		return 0;
>  	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
>  		/* In direction-count mode only rising edge of QEPA is counted
>  		 * and QEPB gives direction.
>  		 */
> -		switch (synapse->signal->id) {
> -		case TI_EQEP_SIGNAL_QEPA:
> -			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> -			break;
> -		default:
> +		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB)
>  			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> -			break;
> -		}
> -		break;
> +		else
> +			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;
>  	case TI_EQEP_COUNT_FUNC_UP_COUNT:
>  	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
>  		/* In up/down-count modes only QEPA is counted and QEPB is not
>  		 * used.
>  		 */
> -		switch (synapse->signal->id) {
> -		case TI_EQEP_SIGNAL_QEPA:
> -			err = regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> -			if (err)
> -				return err;
> -
> -			if (qdecctl & QDECCTL_XCR)
> -				*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> -			else
> -				*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> -			break;
> -		default:
> +		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB) {
>  			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> -			break;
> +			return 0;
>  		}
> -		break;
> -	}
>  
> -	return 0;
> +		err = regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> +		if (err)
> +			return err;
> +
> +		if (qdecctl & QDECCTL_XCR)
> +			*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +		else
> +			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +		return 0;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
>  }
>  
>  static const struct counter_ops ti_eqep_counter_ops = {
> 
