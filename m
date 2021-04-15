Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A514F360ECD
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDOPVR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhDOPUu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:20:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C7C061348;
        Thu, 15 Apr 2021 08:19:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso7583138pjg.2;
        Thu, 15 Apr 2021 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBsPWbKMibZIZP0spYDnVJJ9XeFtdFxsNH9/u61CIT0=;
        b=t7Fr7sBZtaRzy6h4SJEtUxXbGWu/Ict000/2uHhLl7YXGPTGr9X7AxLMSG33PikVpF
         HwR/RWGhm+FV7Pb4x90fb99Uew1lqgb31Vv2/J/gcAR2HP9VljBW8GC59Umz9E20sao7
         nOy257XjR6AWGQSG+teGPor2jr/EsPeeShCM2vXjs5B3qcwiUKPzX7lib3numuSLxDp1
         773Kh4H2DYbQbT/qgJWIbV05hG4hSANGMUjtDEaKkkqLy0elBny4jx+xlOLsph62S/LR
         7Dq3UbT8dlk31Iqg7Cg/TzPhSRb48g/Y1pdax9SDfI0qdwoQ/v/11hwgtJ8vkYTf1U0p
         4vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBsPWbKMibZIZP0spYDnVJJ9XeFtdFxsNH9/u61CIT0=;
        b=VcpnuZ5CGgcJ1qz7emCdfZgDFxxJK7te+DC+RWcJi+5bWYw1YQ2iNVwy4Av9BjyJCp
         7RnvWAZq53+TRn0unWoY3gfj9apHQjux+l/8W5RgvTHx+JYhHnBFOQervwVNoZc+7E53
         ScBb1PazkaTUsiTVKOEGEZxEFYm/3wgzbCdJi0LGXSWF0J8nt7d14xVEemcqxOhJPcJX
         q2l5sdHEc4oloWjKoBWxV/zJ9/8xc/YQT8q1hkzKK2/9WHyTnXCwJRwwjmrzJx7yf8WU
         WlBpvt9UvNTRp3Z2OXnfPJfgsEd4guDg4nIzkGYXiabDKZYKU+URl4pHU9CcE2aSN7TF
         c5rw==
X-Gm-Message-State: AOAM5336lStyh1SjFk9FPlWcKNschONsJLLF3IcfapY3HHOS41ny2Ypv
        ycryAiV5IY3OW+gcADhPvE0=
X-Google-Smtp-Source: ABdhPJxTUzaNy/K2Y5YrEVP+tZIuAN1FbphT+vlG5WrudPuiXfMKdZzYF+iqg+DQt6iqwrzTMRd1VA==
X-Received: by 2002:a17:90a:4b8c:: with SMTP id i12mr4468436pjh.66.1618499985445;
        Thu, 15 Apr 2021 08:19:45 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id 4sm2892328pjl.51.2021.04.15.08.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:19:45 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:49:34 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v10 18/33] counter: Return error code on invalid modes
Message-ID: <20210415151934.GG8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <e1dd9e43f713ccaa29e1c05d7b21d86bff02ab34.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1dd9e43f713ccaa29e1c05d7b21d86bff02ab34.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:37PM +0900, William Breathitt Gray wrote:
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

For the 104-quad-8 driver:
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

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
> -- 
> 2.30.2
> 
