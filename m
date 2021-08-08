Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7A3E3BD6
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhHHRNN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 8 Aug 2021 13:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhHHRNN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:13:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6330760EC0;
        Sun,  8 Aug 2021 17:12:49 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:15:38 +0100
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
Subject: Re: [PATCH v14 05/17] counter: Rename counter_count_function to
 counter_function
Message-ID: <20210808181130.2c855897@jic23-huawei>
In-Reply-To: <8268c54d6f42075a19bb08151a37831e22652499.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
        <8268c54d6f42075a19bb08151a37831e22652499.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Aug 2021 21:06:15 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The phrase "Counter Count function" is verbose and unintentionally
> implies that function is a Count extension. This patch adjusts the
> Counter subsystem code to use the more direct "Counter function" phrase
> to make the intent of this code clearer.
> 
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

this one doesn't build cleanly for me.

drivers/counter/microchip-tcb-capture.c:40:42: error: array type has incomplete element type ‘enum counter_count_function’
   40 | static const enum counter_count_function mchp_tc_count_functions[] = {
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/bits.h:22,
                 from ./include/linux/bitops.h:6,
                 from ./include/linux/kernel.h:12,
                 from ./include/linux/clk.h:13,
                 from drivers/counter/microchip-tcb-capture.c:7:
./include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                   ^
./include/linux/compiler.h:256:33: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
  256 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
      |                                 ^~~~~~~~~~~~~~~~~
./include/linux/kernel.h:44:59: note: in expansion of macro ‘__must_be_array’
   44 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      |                                                           ^~~~~~~~~~~~~~~
drivers/counter/microchip-tcb-capture.c:260:34: note: in expansion of macro ‘ARRAY_SIZE’
  260 |                 .num_functions = ARRAY_SIZE(mchp_tc_count_functions),
      |                                  ^~~~~~~~~~
drivers/counter/microchip-tcb-capture.c:40:42: warning: ‘mchp_tc_count_functions’ defined but not used [-Wunused-variable]
   40 | static const enum counter_count_function mchp_tc_count_functions[] = {
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~
drivers/counter/104-quad-8.c:58: warning: Function parameter or member 'lock' not described in 'quad8'
make[2]: *** [scripts/Makefile.build:271: drivers/counter/microchip-tcb-capture.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  CHECK   drivers/counter/counter.c
  CHECK   drivers/counter/intel-qep.c
make[1]: *** [scripts/Makefile.build:514: drivers/counter] Error 2
make: *** [Makefile:1841: drivers] Error 2

I fixed it by changing the type to counter_function to match the other cases and applied that.

Please take a quick look to make sure I didn't mess it up.

Jonathan




> ---
>  drivers/counter/104-quad-8.c            | 10 +++----
>  drivers/counter/counter.c               | 38 ++++++++++++-------------
>  drivers/counter/ftm-quaddec.c           |  5 ++--
>  drivers/counter/intel-qep.c             |  4 +--
>  drivers/counter/interrupt-cnt.c         |  4 +--
>  drivers/counter/microchip-tcb-capture.c |  4 +--
>  drivers/counter/stm32-lptimer-cnt.c     |  6 ++--
>  drivers/counter/stm32-timer-cnt.c       | 10 +++----
>  drivers/counter/ti-eqep.c               | 10 +++----
>  include/linux/counter.h                 | 20 ++++++-------
>  10 files changed, 55 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index b4dd07cf51eb..5283ff128c17 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -194,11 +194,11 @@ enum quad8_count_function {
>  	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
>  };
>  
> -static const enum counter_count_function quad8_count_functions_list[] = {
> -	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +static const enum counter_function quad8_count_functions_list[] = {
> +	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_FUNCTION_PULSE_DIRECTION,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_FUNCTION_QUADRATURE_X4
>  };
>  
>  static int quad8_function_get(struct counter_device *counter,
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index cb92673552b5..de921e8a3f72 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -744,15 +744,15 @@ static ssize_t counter_count_store(struct device *dev,
>  	return len;
>  }
>  
> -static const char *const counter_count_function_str[] = {
> -	[COUNTER_COUNT_FUNCTION_INCREASE] = "increase",
> -	[COUNTER_COUNT_FUNCTION_DECREASE] = "decrease",
> -	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
> +static const char *const counter_function_str[] = {
> +	[COUNTER_FUNCTION_INCREASE] = "increase",
> +	[COUNTER_FUNCTION_DECREASE] = "decrease",
> +	[COUNTER_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
> +	[COUNTER_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
> +	[COUNTER_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
> +	[COUNTER_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
> +	[COUNTER_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
> +	[COUNTER_FUNCTION_QUADRATURE_X4] = "quadrature x4"
>  };
>  
>  static ssize_t counter_function_show(struct device *dev,
> @@ -764,7 +764,7 @@ static ssize_t counter_function_show(struct device *dev,
>  	const struct counter_count_unit *const component = devattr->component;
>  	struct counter_count *const count = component->count;
>  	size_t func_index;
> -	enum counter_count_function function;
> +	enum counter_function function;
>  
>  	err = counter->ops->function_get(counter, count, &func_index);
>  	if (err)
> @@ -773,7 +773,7 @@ static ssize_t counter_function_show(struct device *dev,
>  	count->function = func_index;
>  
>  	function = count->functions_list[func_index];
> -	return sprintf(buf, "%s\n", counter_count_function_str[function]);
> +	return sprintf(buf, "%s\n", counter_function_str[function]);
>  }
>  
>  static ssize_t counter_function_store(struct device *dev,
> @@ -785,14 +785,14 @@ static ssize_t counter_function_store(struct device *dev,
>  	struct counter_count *const count = component->count;
>  	const size_t num_functions = count->num_functions;
>  	size_t func_index;
> -	enum counter_count_function function;
> +	enum counter_function function;
>  	int err;
>  	struct counter_device *const counter = dev_get_drvdata(dev);
>  
>  	/* Find requested Count function mode */
>  	for (func_index = 0; func_index < num_functions; func_index++) {
>  		function = count->functions_list[func_index];
> -		if (sysfs_streq(buf, counter_count_function_str[function]))
> +		if (sysfs_streq(buf, counter_function_str[function]))
>  			break;
>  	}
>  	/* Return error if requested Count function mode not found */
> @@ -880,25 +880,25 @@ static int counter_count_ext_register(
>  }
>  
>  struct counter_func_avail_unit {
> -	const enum counter_count_function *functions_list;
> +	const enum counter_function *functions_list;
>  	size_t num_functions;
>  };
>  
> -static ssize_t counter_count_function_available_show(struct device *dev,
> +static ssize_t counter_function_available_show(struct device *dev,
>  	struct device_attribute *attr, char *buf)
>  {
>  	const struct counter_device_attr *const devattr = to_counter_attr(attr);
>  	const struct counter_func_avail_unit *const component = devattr->component;
> -	const enum counter_count_function *const func_list = component->functions_list;
> +	const enum counter_function *const func_list = component->functions_list;
>  	const size_t num_functions = component->num_functions;
>  	size_t i;
> -	enum counter_count_function function;
> +	enum counter_function function;
>  	ssize_t len = 0;
>  
>  	for (i = 0; i < num_functions; i++) {
>  		function = func_list[i];
>  		len += sprintf(buf + len, "%s\n",
> -			       counter_count_function_str[function]);
> +			       counter_function_str[function]);
>  	}
>  
>  	return len;
> @@ -968,7 +968,7 @@ static int counter_count_attributes_create(
>  	parm.group = group;
>  	parm.prefix = "";
>  	parm.name = "function_available";
> -	parm.show = counter_count_function_available_show;
> +	parm.show = counter_function_available_show;
>  	parm.store = NULL;
>  	parm.component = avail_comp;
>  	err = counter_attribute_create(&parm);
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 9371532406ca..53c15f84909b 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -171,9 +171,8 @@ enum ftm_quaddec_count_function {
>  	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
>  };
>  
> -static const enum counter_count_function ftm_quaddec_count_functions[] = {
> -	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +static const enum counter_function ftm_quaddec_count_functions[] = {
> +	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X4
>  };
>  
>  static int ftm_quaddec_count_read(struct counter_device *counter,
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 204f94577666..8a6847d5fb2b 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -126,8 +126,8 @@ static int intel_qep_count_read(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static const enum counter_count_function intel_qep_count_functions[] = {
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +static const enum counter_function intel_qep_count_functions[] = {
> +	COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  static int intel_qep_function_get(struct counter_device *counter,
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index d06367bef8f0..1de4243db488 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -115,8 +115,8 @@ static int interrupt_cnt_write(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static const enum counter_count_function interrupt_cnt_functions[] = {
> -	COUNTER_COUNT_FUNCTION_INCREASE,
> +static const enum counter_function interrupt_cnt_functions[] = {
> +	COUNTER_FUNCTION_INCREASE,
>  };
>  
>  static int interrupt_cnt_function_get(struct counter_device *counter,
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 6be3adf74114..4c57d43e7d66 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -38,8 +38,8 @@ enum mchp_tc_count_function {
>  };
>  
>  static const enum counter_count_function mchp_tc_count_functions[] = {
> -	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
> -	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_FUNCTION_INCREASE,
> +	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  enum mchp_tc_synapse_action {
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 49aeb9e393f3..13656957c45f 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -134,9 +134,9 @@ enum stm32_lptim_cnt_function {
>  	STM32_LPTIM_ENCODER_BOTH_EDGE,
>  };
>  
> -static const enum counter_count_function stm32_lptim_cnt_functions[] = {
> -	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
> -	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +static const enum counter_function stm32_lptim_cnt_functions[] = {
> +	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
> +	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  enum stm32_lptim_synapse_action {
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 603b30ada839..3fb0debd7425 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -50,11 +50,11 @@ enum stm32_count_function {
>  	STM32_COUNT_ENCODER_MODE_3,
>  };
>  
> -static const enum counter_count_function stm32_count_functions[] = {
> -	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
> -	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> -	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +static const enum counter_function stm32_count_functions[] = {
> +	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_FUNCTION_INCREASE,
> +	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
>  static int stm32_count_read(struct counter_device *counter,
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index c303eb17c111..94fe58bb3eab 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -294,11 +294,11 @@ static struct counter_signal ti_eqep_signals[] = {
>  	},
>  };
>  
> -static const enum counter_count_function ti_eqep_position_functions[] = {
> -	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> -	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> -	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
> -	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
> +static const enum counter_function ti_eqep_position_functions[] = {
> +	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_FUNCTION_QUADRATURE_X4,
> +	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_FUNCTION_PULSE_DIRECTION,
> +	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_FUNCTION_INCREASE,
> +	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_FUNCTION_DECREASE,
>  };
>  
>  static const enum counter_synapse_action ti_eqep_position_synapse_actions[] = {
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 79f5dcaf6ba0..d16ce2819b48 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -162,15 +162,15 @@ struct counter_count_ext {
>  	void *priv;
>  };
>  
> -enum counter_count_function {
> -	COUNTER_COUNT_FUNCTION_INCREASE = 0,
> -	COUNTER_COUNT_FUNCTION_DECREASE,
> -	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +enum counter_function {
> +	COUNTER_FUNCTION_INCREASE = 0,
> +	COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X1_B,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	COUNTER_FUNCTION_QUADRATURE_X4
>  };
>  
>  /**
> @@ -192,7 +192,7 @@ struct counter_count {
>  	const char *name;
>  
>  	size_t function;
> -	const enum counter_count_function *functions_list;
> +	const enum counter_function *functions_list;
>  	size_t num_functions;
>  
>  	struct counter_synapse *synapses;

