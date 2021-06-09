Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542303A1A03
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhFIPrh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:47:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234271AbhFIPrg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:47:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE8B61351;
        Wed,  9 Jun 2021 15:45:37 +0000 (UTC)
Date:   Wed, 9 Jun 2021 16:47:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v11 18/33] counter: Return error code on invalid modes
Message-ID: <20210609164731.2180e4e4@jic23-huawei>
In-Reply-To: <6f74bf8b237340ef079b7d3e3553f47434f47f67.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <6f74bf8b237340ef079b7d3e3553f47434f47f67.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:21 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Only a select set of modes (function, action, etc.) are valid for a
> given device configuration. This patch ensures that invalid modes result
> in a return -EINVAL. Such a situation should never occur in reality, but
> it's good to define a default switch cases for the sake of making the
> intent of the code clear.
> 
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi,

I've been lazy and not looked at these in sufficient depth before now :(

There are a few cases in here that I think could be handled more
elegantly and in a fashion more likely to expose potential bugs
if enums change number of entries in future etc.

I've very keen on a compiler being able to see when we have a
switch on an enum.

Jonathan


> ---
>  drivers/counter/104-quad-8.c            | 20 +++++++----
>  drivers/counter/microchip-tcb-capture.c |  6 ++++
>  drivers/counter/stm32-lptimer-cnt.c     | 10 +++---
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

In this particular case we are already exhaustive.  So we should have neither default
nor ideally the return below.  

If we have a local variable of the relevant enum type, then I think the compiler
should be able to tell this is exhaustive and usefully it will then issue
a warning should the enum gain more entries in future.

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

Same in this path.

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
I'd rather see this as

case TI_EQEP_SIGNAL_QEPA:
caes TI_EQEP_SIGNAL_QEPB:

To make it clear what the two cases are.  Then we don't need the default
assuming the type is right so the compiler should be able to see
that we have been exhaustive.


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

Same as above

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

