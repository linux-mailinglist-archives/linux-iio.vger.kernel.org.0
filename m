Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293753ECA32
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhHOQ31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhHOQ31 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:29:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75655611C4;
        Sun, 15 Aug 2021 16:28:52 +0000 (UTC)
Date:   Sun, 15 Aug 2021 17:31:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        fabrice.gasnier@st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v15 02/13] counter: Internalize sysfs interface code
Message-ID: <20210815173150.29454ed9@jic23-huawei>
In-Reply-To: <9844c0b2845fc001f64ebb0a4bc6d7fb7a08571a.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
        <9844c0b2845fc001f64ebb0a4bc6d7fb7a08571a.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 21:37:27 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This is a reimplementation of the Generic Counter driver interface.
> There are no modifications to the Counter subsystem userspace interface,
> so existing userspace applications should continue to run seamlessly.
> 
> The purpose of this patch is to internalize the sysfs interface code
> among the various counter drivers into a shared module. Counter drivers
> pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> module handles the translation between the sysfs interface and the
> device drivers. This guarantees a standard userspace interface for all
> counter drivers, and helps generalize the Generic Counter driver ABI in
> order to support the Generic Counter chrdev interface (introduced in a
> subsequent patch) without significant changes to the existing counter
> drivers.
> 
> Note, Counter device registration is the same as before: drivers
> populate a struct counter_device with components and callbacks, then
> pass the structure to the devm_counter_register function. However,
> what's different now is how the Counter subsystem code handles this
> registration internally.
> 
> Whereas before callbacks would interact directly with sysfs data, this
> interaction is now abstracted and instead callbacks interact with native
> C data types. The counter_comp structure forms the basis for Counter
> extensions.
> 
> The counter-sysfs.c file contains the code to parse through the
> counter_device structure and register the requested components and
> extensions. Attributes are created and populated based on type, with
> respective translation functions to handle the mapping between sysfs and
> the counter driver callbacks.
> 
> The translation performed for each attribute is straightforward: the
> attribute type and data is parsed from the counter_attribute structure,
> the respective counter driver read/write callback is called, and sysfs
> I/O is handled before or after the driver read/write function is called.
> 
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Hi William,

Given we haven't had any of the reviews of the stm32 and ftm-quadec
changes I took a closer look myself.

A side effect of the warning fixes is that we now have some 'magic numbers'
for register fields.  Some of them were there already, but now there are more.

My suggestions is that you use some defines (or indeed the original enums
if appropriate) to provide text names to the register field values.
I've highlighted another driver that does it the way I'd like to see it done.

So unfortunately it looks like this this refactor is going to be in the next
kernel cycle :(  Hopefully we can get it queued up early though so you have
something to do any revisions of the latter patches against.

Jonathan



...

> -static int mchp_tc_count_action_set(struct counter_device *counter,
> -				    struct counter_count *count,
> -				    struct counter_synapse *synapse,
> -				    size_t action)
> +static int mchp_tc_count_action_write(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      struct counter_synapse *synapse,
> +				      enum counter_synapse_action action)
>  {
>  	struct mchp_tc_data *const priv = counter->priv;
>  	u32 edge = ATMEL_TC_ETRGEDG_NONE;
> @@ -217,16 +205,16 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
>  		return -EINVAL;
>  
>  	switch (action) {
> -	case MCHP_TC_SYNAPSE_ACTION_NONE:
> +	case COUNTER_SYNAPSE_ACTION_NONE:
>  		edge = ATMEL_TC_ETRGEDG_NONE;

This is a good example of the sort of use of defines for field values I'm suggesting
for other similar cases. Basically do it like this.


>  		break;
> -	case MCHP_TC_SYNAPSE_ACTION_RISING_EDGE:
> +	case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
>  		edge = ATMEL_TC_ETRGEDG_RISING;
>  		break;
> -	case MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE:
> +	case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
>  		edge = ATMEL_TC_ETRGEDG_FALLING;
>  		break;
> -	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
> +	case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
>  		edge = ATMEL_TC_ETRGEDG_BOTH;
>  		break;
>  	default:
> @@ -240,8 +228,7 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
>  }
>  

> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 13656957c45f..23d43b71f9e4 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>  
>  struct stm32_lptim_cnt {
>  	struct counter_device counter;
> @@ -107,11 +108,7 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
>  	return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
>  }
>  
> -/**
> - * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
> - * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
> - * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
> - *
> +/*
>   * In non-quadrature mode, device counts up on active edge.
>   * In quadrature mode, encoder counting scenarios are as follows:
>   * +---------+----------+--------------------+--------------------+
> @@ -129,33 +126,20 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
>   * | edges   | Low  ->  |   Up     |   Down  |   Down   |   Up    |
>   * +---------+----------+----------+---------+----------+---------+
>   */
> -enum stm32_lptim_cnt_function {
> -	STM32_LPTIM_COUNTER_INCREASE,
> -	STM32_LPTIM_ENCODER_BOTH_EDGE,
> -};
> -
>  static const enum counter_function stm32_lptim_cnt_functions[] = {
> -	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
> -	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
> -};
> -
> -enum stm32_lptim_synapse_action {
> -	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> -	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> -	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> -	STM32_LPTIM_SYNAPSE_ACTION_NONE,
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> -	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
> -	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> -	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> -	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> -	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_NONE,
>  };
>  
>  static int stm32_lptim_cnt_read(struct counter_device *counter,
> -				struct counter_count *count, unsigned long *val)
> +				struct counter_count *count, u64 *val)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  	u32 cnt;
> @@ -170,28 +154,28 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static int stm32_lptim_cnt_function_get(struct counter_device *counter,
> -					struct counter_count *count,
> -					size_t *function)
> +static int stm32_lptim_cnt_function_read(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 enum counter_function *function)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
>  	if (!priv->quadrature_mode) {
> -		*function = STM32_LPTIM_COUNTER_INCREASE;
> +		*function = COUNTER_FUNCTION_INCREASE;
>  		return 0;
>  	}
>  
> -	if (priv->polarity == STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES) {
> -		*function = STM32_LPTIM_ENCODER_BOTH_EDGE;
> +	if (priv->polarity == 2) {

This wants to have some sort of define for the register field value
it corresponds to.

> +		*function = COUNTER_FUNCTION_QUADRATURE_X4;
>  		return 0;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> -static int stm32_lptim_cnt_function_set(struct counter_device *counter,
> -					struct counter_count *count,
> -					size_t function)
> +static int stm32_lptim_cnt_function_write(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  enum counter_function function)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
> @@ -199,12 +183,12 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
>  		return -EBUSY;
>  
>  	switch (function) {
> -	case STM32_LPTIM_COUNTER_INCREASE:
> +	case COUNTER_FUNCTION_INCREASE:
>  		priv->quadrature_mode = 0;
>  		return 0;
> -	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
>  		priv->quadrature_mode = 1;
> -		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
> +		priv->polarity = 2;
>  		return 0;
>  	default:
>  		/* should never reach this path */
> @@ -212,9 +196,9 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
>  	}
>  }

...

>  
> -static int stm32_lptim_cnt_action_get(struct counter_device *counter,
> -				      struct counter_count *count,
> -				      struct counter_synapse *synapse,
> -				      size_t *action)
> +static int stm32_lptim_cnt_action_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       struct counter_synapse *synapse,
> +				       enum counter_synapse_action *action)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	size_t function;
> +	enum counter_function function;
>  	int err;
>  
> -	err = stm32_lptim_cnt_function_get(counter, count, &function);
> +	err = stm32_lptim_cnt_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	switch (function) {
> -	case STM32_LPTIM_COUNTER_INCREASE:
> +	case COUNTER_FUNCTION_INCREASE:
>  		/* LP Timer acts as up-counter on input 1 */
> -		if (synapse->signal->id == count->synapses[0].signal->id)
> -			*action = priv->polarity;
> -		else
> -			*action = STM32_LPTIM_SYNAPSE_ACTION_NONE;
> -		return 0;
> -	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> -		*action = priv->polarity;
> -		return 0;
> +		if (synapse->signal->id != count->synapses[0].signal->id) {
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
> +			return 0;
> +		}
> +
> +		switch (priv->polarity) {
> +		case 0:

These correspond to particular bits. As you use them elsewhere I think
you need some defines.

> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			return 0;
> +		case 1:
> +			*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +			return 0;
> +		case 2:
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +			return 0;
> +		default:
> +			/* should never reach this path */
> +			return -EINVAL;
> +		}
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		switch (priv->polarity) {
> +		case 0:
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +			return 0;
> +		case 1:
> +			*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> +			return 0;
> +		case 2:
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +			return 0;
> +		default:
> +			/* should never reach this path */
> +			return -EINVAL;
> +		}
>  	default:
>  		/* should never reach this path */
>  		return -EINVAL;
>  	}
>  }
>  
> -static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> -				      struct counter_count *count,
> -				      struct counter_synapse *synapse,
> -				      size_t action)
> +static int stm32_lptim_cnt_action_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					struct counter_synapse *synapse,
> +					enum counter_synapse_action action)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	size_t function;
> +	enum counter_function function;
>  	int err;
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
>  
> -	err = stm32_lptim_cnt_function_get(counter, count, &function);
> +	err = stm32_lptim_cnt_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	/* only set polarity when in counter mode (on input 1) */
> -	if (function == STM32_LPTIM_COUNTER_INCREASE
> -	    && synapse->signal->id == count->synapses[0].signal->id) {
> -		switch (action) {
> -		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
> -		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
> -		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
> -			priv->polarity = action;
> -			return 0;
> -		}
> -	}
> +	if (function != COUNTER_FUNCTION_INCREASE
> +	    || synapse->signal->id != count->synapses[0].signal->id)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	switch (action) {
> +	case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
> +		priv->polarity = 0;
> +		return 0;
> +	case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
> +		priv->polarity = 1;
> +		return 0;
> +	case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
> +		priv->polarity = 2;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static const struct counter_ops stm32_lptim_cnt_ops = {
>  	.count_read = stm32_lptim_cnt_read,
> -	.function_get = stm32_lptim_cnt_function_get,
> -	.function_set = stm32_lptim_cnt_function_set,
> -	.action_get = stm32_lptim_cnt_action_get,
> -	.action_set = stm32_lptim_cnt_action_set,
> +	.function_read = stm32_lptim_cnt_function_read,
> +	.function_write = stm32_lptim_cnt_function_write,
> +	.action_read = stm32_lptim_cnt_action_read,
> +	.action_write = stm32_lptim_cnt_action_write,
>  };
>  
>  static struct counter_signal stm32_lptim_cnt_signals[] = {
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 3fb0debd7425..8b3759096d04 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/types.h>
>  
>  #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
>  #define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
> @@ -36,29 +37,15 @@ struct stm32_timer_cnt {
>  	struct stm32_timer_regs bak;
>  };
>  
> -/**
> - * enum stm32_count_function - enumerates stm32 timer counter encoder modes
> - * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
> - * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
> - * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
> - * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
> - */
> -enum stm32_count_function {
> -	STM32_COUNT_SLAVE_MODE_DISABLED,
> -	STM32_COUNT_ENCODER_MODE_1,
> -	STM32_COUNT_ENCODER_MODE_2,
> -	STM32_COUNT_ENCODER_MODE_3,
> -};
> -
>  static const enum counter_function stm32_count_functions[] = {
> -	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_FUNCTION_INCREASE,
> -	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X2_A,
> -	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_FUNCTION_QUADRATURE_X2_B,
> -	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_FUNCTION_QUADRATURE_X4,
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  static int stm32_count_read(struct counter_device *counter,
> -			    struct counter_count *count, unsigned long *val)
> +			    struct counter_count *count, u64 *val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 cnt;
> @@ -70,8 +57,7 @@ static int stm32_count_read(struct counter_device *counter,
>  }
>  
>  static int stm32_count_write(struct counter_device *counter,
> -			     struct counter_count *count,
> -			     const unsigned long val)
> +			     struct counter_count *count, const u64 val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 ceiling;
> @@ -83,9 +69,9 @@ static int stm32_count_write(struct counter_device *counter,
>  	return regmap_write(priv->regmap, TIM_CNT, val);
>  }
>  
> -static int stm32_count_function_get(struct counter_device *counter,
> -				    struct counter_count *count,
> -				    size_t *function)
> +static int stm32_count_function_read(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     enum counter_function *function)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 smcr;
> @@ -94,40 +80,40 @@ static int stm32_count_function_get(struct counter_device *counter,
>  
>  	switch (smcr & TIM_SMCR_SMS) {
>  	case 0:

As below, these case values should be named.

> -		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
> +		*function = COUNTER_FUNCTION_INCREASE;
>  		return 0;
>  	case 1:
> -		*function = STM32_COUNT_ENCODER_MODE_1;
> +		*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
>  		return 0;
>  	case 2:
> -		*function = STM32_COUNT_ENCODER_MODE_2;
> +		*function = COUNTER_FUNCTION_QUADRATURE_X2_B;
>  		return 0;
>  	case 3:
> -		*function = STM32_COUNT_ENCODER_MODE_3;
> +		*function = COUNTER_FUNCTION_QUADRATURE_X4;
>  		return 0;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> -static int stm32_count_function_set(struct counter_device *counter,
> -				    struct counter_count *count,
> -				    size_t function)
> +static int stm32_count_function_write(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      enum counter_function function)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 cr1, sms;
>  
>  	switch (function) {
> -	case STM32_COUNT_SLAVE_MODE_DISABLED:
> +	case COUNTER_FUNCTION_INCREASE:
>  		sms = 0;
This code is odd in the original driver as sms is just set to the values of the 'function'
enum.  Having said that, I think with the refactored code you want some symbolic names (defines)
for the register field values.

>  		break;
> -	case STM32_COUNT_ENCODER_MODE_1:
> +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
>  		sms = 1;
>  		break;
> -	case STM32_COUNT_ENCODER_MODE_2:
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
>  		sms = 2;
>  		break;
> -	case STM32_COUNT_ENCODER_MODE_3:
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
>  		sms = 3;
>  		break;
>  	default:

...


