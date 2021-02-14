Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6A31B16D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhBNRIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 12:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhBNRIc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 12:08:32 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05ECA64DBA;
        Sun, 14 Feb 2021 17:07:47 +0000 (UTC)
Date:   Sun, 14 Feb 2021 17:07:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 09/22] counter: Return error code on invalid modes
Message-ID: <20210214170743.090e8b60@archlinux>
In-Reply-To: <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
        <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 21:13:33 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Only a select set of modes (function, action, etc.) are valid for a
> given device configuration. This patch ensures that invalid modes result
> in a return -EINVAL. Such a situation should never occur in reality, but
> it's good to define a default switch cases for the sake of making the
> intent of the code clear.

In many of these cases it may make sense to also return early
in the good paths rather than share a return 0 at the
end of the function?


> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c            | 10 ++++++++++
>  drivers/counter/microchip-tcb-capture.c |  6 ++++++
>  drivers/counter/stm32-lptimer-cnt.c     | 10 ++++++----
>  drivers/counter/stm32-timer-cnt.c       |  3 +++
>  drivers/counter/ti-eqep.c               |  3 +++
>  5 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9a96296b0625..674263b4d2c4 100644
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
> @@ -367,6 +371,9 @@ static int quad8_action_get(struct counter_device *counter,
>  	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
>  		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> @@ -529,6 +536,9 @@ static int quad8_count_mode_set(struct counter_device *counter,
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
> index 710acc0a3704..ee979b011012 100644
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
> index 937439635d53..daf988e7b208 100644
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
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index ef2a974a2f10..431a3d08ed6c 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -296,6 +296,9 @@ static int stm32_action_get(struct counter_device *counter,
>  		/* counts up/down on both TI1FP1 and TI2FP2 edges */
>  		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	return 0;
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index a60aee1a1a29..7844fdf78a97 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -192,6 +192,9 @@ static int ti_eqep_action_get(struct counter_device *counter,
>  			break;
>  		}
>  		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
>  	}
>  
>  	return 0;


