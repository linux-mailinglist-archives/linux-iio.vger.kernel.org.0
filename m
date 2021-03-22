Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3135D344C0A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVQp3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 12:45:29 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:31816 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229884AbhCVQpS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 12:45:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MGhB4r015474;
        Mon, 22 Mar 2021 17:44:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=esWFrN3SgkHH1O99Ts9C58cDJVumT8dKbp7jmIhwpR0=;
 b=ckWhXkZjwwYZpogkNOg2xrC0fPFa0Q+N31nmjekSyxoO7eXjuJlh6pdja7hwcK+Dus2n
 Qa98lSXJ6BhscP2RRnLeLTYatcBArek6zbCJmPUWSa4fwjoW06jxw65bVAUSdJSbCSeA
 qRkyqc0OIz1V/4vueArUXXDHKyIW3UoHuMnC9ra4ekjwznq9Bbu1ChNpR/dxcMEgqRts
 YVFYno5J9DhE9P6Z+0aN3HxP/9Me9XOGIslyJmlXCZr7AGojQEPphON7TMSMT+K5fByg
 TKL2AWwbWcBtOzSHPpRaU9JLrquBPBEnDikX4PDTeilaglq2GOKe8OZwX95oTxrZ1zOL Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d7d7ttd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:44:05 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73A1810002A;
        Mon, 22 Mar 2021 17:44:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AB47237064;
        Mon, 22 Mar 2021 17:44:04 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 17:44:02 +0100
Subject: Re: [Linux-stm32] [PATCH v10 22/33] counter: Internalize sysfs
 interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <david@lechnology.com>, <linux-iio@vger.kernel.org>,
        <patrick.havelange@essensium.com>, <alexandre.belloni@bootlin.com>,
        <mcoquelin.stm32@gmail.com>, <linux-kernel@vger.kernel.org>,
        <o.rempel@pengutronix.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <kernel@pengutronix.de>, <fabrice.gasnier@foss.st.com>,
        <syednwaris@gmail.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.torgue@foss.st.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <51becb2e067a4d2ee7bd99beb007831022fc4b29.1616150619.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <4cef2478-4093-fdef-2ae5-c27d0e8e1ccd@foss.st.com>
Date:   Mon, 22 Mar 2021 17:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <51becb2e067a4d2ee7bd99beb007831022fc4b29.1616150619.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_09:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 3/19/21 12:00 PM, William Breathitt Gray wrote:
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
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  MAINTAINERS                             |    1 -
>  drivers/counter/104-quad-8.c            |  449 +++----
>  drivers/counter/Makefile                |    1 +
>  drivers/counter/counter-core.c          |  155 +++
>  drivers/counter/counter-sysfs.c         |  846 +++++++++++++
>  drivers/counter/counter-sysfs.h         |   13 +
>  drivers/counter/counter.c               | 1496 -----------------------
>  drivers/counter/ftm-quaddec.c           |   56 +-
>  drivers/counter/interrupt-cnt.c         |   62 +-
>  drivers/counter/microchip-tcb-capture.c |   93 +-
>  drivers/counter/stm32-lptimer-cnt.c     |  162 ++-
>  drivers/counter/stm32-timer-cnt.c       |  147 +--
>  drivers/counter/ti-eqep.c               |  180 +--
>  include/linux/counter.h                 |  629 +++++-----
>  include/linux/counter_enum.h            |   45 -
>  15 files changed, 1857 insertions(+), 2478 deletions(-)
>  create mode 100644 drivers/counter/counter-core.c
>  create mode 100644 drivers/counter/counter-sysfs.c
>  create mode 100644 drivers/counter/counter-sysfs.h
>  delete mode 100644 drivers/counter/counter.c
>  delete mode 100644 include/linux/counter_enum.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddabf7bb5246..1508db256784 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4581,7 +4581,6 @@ F:	Documentation/ABI/testing/sysfs-bus-counter
>  F:	Documentation/driver-api/generic-counter.rst
>  F:	drivers/counter/
>  F:	include/linux/counter.h
> -F:	include/linux/counter_enum.h
>  
>  CPMAC ETHERNET DRIVER
>  M:	Florian Fainelli <f.fainelli@gmail.com>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 5a49ace2d4a6..eb7d63769f4c 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -116,7 +116,7 @@ static int quad8_signal_read(struct counter_device *counter,
>  }
>  
>  static int quad8_count_read(struct counter_device *counter,
> -	struct counter_count *count, unsigned long *val)
> +			    struct counter_count *count, u64 *val)
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> @@ -147,7 +147,7 @@ static int quad8_count_read(struct counter_device *counter,
>  }
>  
>  static int quad8_count_write(struct counter_device *counter,
> -	struct counter_count *count, unsigned long val)
> +			     struct counter_count *count, u64 val)
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int base_offset = priv->base + 2 * count->id;
> @@ -187,22 +187,16 @@ static int quad8_count_write(struct counter_device *counter,
>  	return 0;
>  }
>  
> -enum quad8_count_function {
> -	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
> -	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
> -};
> -
>  static const enum counter_function quad8_count_functions_list[] = {
> -	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_FUNCTION_PULSE_DIRECTION,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_FUNCTION_QUADRATURE_X1_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_FUNCTION_QUADRATURE_X2_A,
> -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_FUNCTION_QUADRATURE_X4
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
>  };
>  
> -static int quad8_function_get(struct counter_device *counter,
> -	struct counter_count *count, size_t *function)
> +static int quad8_function_read(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       enum counter_function *function)
>  {
>  	struct quad8 *const priv = counter->priv;
>  	const int id = count->id;
> @@ -212,25 +206,26 @@ static int quad8_function_get(struct counter_device *counter,
>  	if (priv->quadrature_mode[id])
>  		switch (priv->quadrature_scale[id]) {
>  		case 0:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
>  			break;
>  		case 1:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
>  			break;
>  		case 2:
> -			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
> +			*function = COUNTER_FUNCTION_QUADRATURE_X4;
>  			break;
>  		}
>  	else
> -		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> +		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
>  
>  	mutex_unlock(&priv->lock);
>  
>  	return 0;
>  }

[snip]
>  static const struct atmel_tcb_config tcb_rm9200_config = {
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 13656957c45f..aef78a4217b5 100644
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
> @@ -130,32 +131,46 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
>   * +---------+----------+----------+---------+----------+---------+
>   */
>  enum stm32_lptim_cnt_function {
> -	STM32_LPTIM_COUNTER_INCREASE,
> -	STM32_LPTIM_ENCODER_BOTH_EDGE,
> +	STM32_LPTIM_COUNTER_INCREASE = COUNTER_FUNCTION_INCREASE,
> +	STM32_LPTIM_ENCODER_BOTH_EDGE = COUNTER_FUNCTION_QUADRATURE_X4,

Hi William,

I'm wondering if this enum is still necessary. I noticed the enum is
removed from the 104-quad-8 driver.


>  };
>  
>  static const enum counter_function stm32_lptim_cnt_functions[] = {
> -	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
> -	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
> +	STM32_LPTIM_COUNTER_INCREASE,
> +	STM32_LPTIM_ENCODER_BOTH_EDGE,
>  };
>  
>  enum stm32_lptim_synapse_action {
> +	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */

Arf... I forgot to update this comment in earlier commit:
d8ac6b4 counter: stm32-lptimer-cnt: remove iio counter abi

"stm32_lptim_cnt_polarity" doesn't exist anymore. So, this comment can
be updated. This should match the priv->polarity, as it's used to write
the "CKPOL" bits (e.g. 0x0 for rising, 0x1 falling, 0x2 both).

Or do you wish I send a separate patch ?


>  	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
>  	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
>  	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
>  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
>  };
>  
> -static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> -	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
> +static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_map[] = {
> +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> +	[COUNTER_SYNAPSE_ACTION_NONE] = STM32_LPTIM_SYNAPSE_ACTION_NONE,
> +};
> +
> +static const enum counter_synapse_action stm32_lptim_l2c_actions_map[] = {
>  	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
>  	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
>  	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
>  };
>  
> +static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};
> +

I'm getting confused with the two table entries, and the two enums that
are very similar. Could it be simplified ?

I'm thinking of something more straight-forward... in fact only one
array should be enough, to convert from synapse action to CKPOL value
before it's written to register in stm32_lptim_setup() routine.
This should be easier now that the iio part has been removed.

>  static int stm32_lptim_cnt_read(struct counter_device *counter,
> -				struct counter_count *count, unsigned long *val)
> +				struct counter_count *count, u64 *val)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  	u32 cnt;
> @@ -170,9 +185,9 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
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
> @@ -189,9 +204,9 @@ static int stm32_lptim_cnt_function_get(struct counter_device *counter,
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
> @@ -212,9 +227,9 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
>  	}
>  }
>  
> -static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
> -					   struct counter_count *count,
> -					   void *private, char *buf)
> +static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u8 *enable)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  	int ret;
> @@ -223,22 +238,18 @@ static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
>  	if (ret < 0)
>  		return ret;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
> +	*enable = ret;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *private,
> -					    const char *buf, size_t len)
> +static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					u8 enable)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	bool enable;
>  	int ret;
>  
> -	ret = kstrtobool(buf, &enable);
> -	if (ret)
> -		return ret;
> -
>  	/* Check nobody uses the timer, or already disabled/enabled */
>  	ret = stm32_lptim_is_enabled(priv);
>  	if ((ret < 0) || (!ret && !enable))
> @@ -254,65 +265,54 @@ static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
>  	if (ret)
>  		return ret;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *private, char *buf)
> +static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					u64 *ceiling)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", priv->ceiling);
> +	*ceiling = priv->ceiling;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
> -					     struct counter_count *count,
> -					     void *private,
> -					     const char *buf, size_t len)
> +static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 u64 ceiling)
>  {
>  	struct stm32_lptim_cnt *const priv = counter->priv;
> -	unsigned int ceiling;
> -	int ret;
>  
>  	if (stm32_lptim_is_enabled(priv))
>  		return -EBUSY;
>  
> -	ret = kstrtouint(buf, 0, &ceiling);
> -	if (ret)
> -		return ret;
> -
>  	if (ceiling > STM32_LPTIM_MAX_ARR)
>  		return -ERANGE;
>  
>  	priv->ceiling = ceiling;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
> -	{
> -		.name = "enable",
> -		.read = stm32_lptim_cnt_enable_read,
> -		.write = stm32_lptim_cnt_enable_write
> -	},
> -	{
> -		.name = "ceiling",
> -		.read = stm32_lptim_cnt_ceiling_read,
> -		.write = stm32_lptim_cnt_ceiling_write
> -	},
> +static struct counter_comp stm32_lptim_cnt_ext[] = {
> +	COUNTER_COMP_ENABLE(stm32_lptim_cnt_enable_read,
> +			    stm32_lptim_cnt_enable_write),
> +	COUNTER_COMP_CEILING(stm32_lptim_cnt_ceiling_read,
> +			     stm32_lptim_cnt_ceiling_write),
>  };
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
> @@ -320,12 +320,12 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
>  	case STM32_LPTIM_COUNTER_INCREASE:
>  		/* LP Timer acts as up-counter on input 1 */
>  		if (synapse->signal->id == count->synapses[0].signal->id)
> -			*action = priv->polarity;
> +			*action = stm32_lptim_l2c_actions_map[priv->polarity];
>  		else
> -			*action = STM32_LPTIM_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		return 0;
>  	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> -		*action = priv->polarity;
> +		*action = stm32_lptim_l2c_actions_map[priv->polarity];
>  		return 0;
>  	default:
>  		/* should never reach this path */
> @@ -333,43 +333,39 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
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
> +	if ((enum stm32_lptim_cnt_function)function != STM32_LPTIM_COUNTER_INCREASE

Could COUNTER_FUNCTION_INCREASE be used directly here, to avoid casting ?

> +	    || synapse->signal->id != count->synapses[0].signal->id
> +	    || action == COUNTER_SYNAPSE_ACTION_NONE)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	priv->polarity = stm32_lptim_c2l_actions_map[action];
> +
> +	return 0;
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
> index 3fb0debd7425..c690b76e5dab 100644
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
> @@ -44,21 +45,21 @@ struct stm32_timer_cnt {
>   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
>   */
>  enum stm32_count_function {
> +	STM32_COUNT_SLAVE_MODE_DISABLED = COUNTER_FUNCTION_INCREASE,
> +	STM32_COUNT_ENCODER_MODE_1 = COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	STM32_COUNT_ENCODER_MODE_2 = COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	STM32_COUNT_ENCODER_MODE_3 = COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +

Same as for the LPTIM driver above, I noticed the enum is removed from
the 104-quad-8 driver.

I'm fine both ways... I just feel like this could be more consistent
later in the function read/write routines to report enum from the
counter_function definition (e.g. like COUNTER_FUNCTION_QUADRATURE_X4
instead of STM32_COUNT_ENCODER_MODE_3).

Thanks,
Fabrice

> +static const enum counter_function stm32_count_functions[] = {
>  	STM32_COUNT_SLAVE_MODE_DISABLED,
>  	STM32_COUNT_ENCODER_MODE_1,
>  	STM32_COUNT_ENCODER_MODE_2,
>  	STM32_COUNT_ENCODER_MODE_3,
>  };
>  
> -static const enum counter_function stm32_count_functions[] = {
> -	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_FUNCTION_INCREASE,
> -	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X2_A,
> -	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_FUNCTION_QUADRATURE_X2_B,
> -	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_FUNCTION_QUADRATURE_X4,
> -};
> -
>  static int stm32_count_read(struct counter_device *counter,
> -			    struct counter_count *count, unsigned long *val)
> +			    struct counter_count *count, u64 *val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 cnt;
> @@ -70,8 +71,7 @@ static int stm32_count_read(struct counter_device *counter,
>  }
>  
>  static int stm32_count_write(struct counter_device *counter,
> -			     struct counter_count *count,
> -			     const unsigned long val)
> +			     struct counter_count *count, const u64 val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 ceiling;
> @@ -83,9 +83,9 @@ static int stm32_count_write(struct counter_device *counter,
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
> @@ -110,9 +110,9 @@ static int stm32_count_function_get(struct counter_device *counter,
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
> @@ -150,44 +150,37 @@ static int stm32_count_function_set(struct counter_device *counter,
>  	return 0;
>  }
>  
> -static ssize_t stm32_count_direction_read(struct counter_device *counter,
> +static int stm32_count_direction_read(struct counter_device *counter,
>  				      struct counter_count *count,
> -				      void *private, char *buf)
> +				      enum counter_count_direction *direction)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
> -	const char *direction;
>  	u32 cr1;
>  
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
> -	direction = (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
> +	*direction = (cr1 & TIM_CR1_DIR) ? COUNTER_COUNT_DIRECTION_BACKWARD :
> +		COUNTER_COUNT_DIRECTION_FORWARD;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
> +	return 0;
>  }
>  
> -static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
> -					struct counter_count *count,
> -					void *private, char *buf)
> +static int stm32_count_ceiling_read(struct counter_device *counter,
> +				    struct counter_count *count, u64 *ceiling)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 arr;
>  
>  	regmap_read(priv->regmap, TIM_ARR, &arr);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> +	*ceiling = arr;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
> -					 struct counter_count *count,
> -					 void *private,
> -					 const char *buf, size_t len)
> +static int stm32_count_ceiling_write(struct counter_device *counter,
> +				     struct counter_count *count, u64 ceiling)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
> -	unsigned int ceiling;
> -	int ret;
> -
> -	ret = kstrtouint(buf, 0, &ceiling);
> -	if (ret)
> -		return ret;
>  
>  	if (ceiling > priv->max_arr)
>  		return -ERANGE;
> @@ -196,34 +189,27 @@ static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_write(priv->regmap, TIM_ARR, ceiling);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t stm32_count_enable_read(struct counter_device *counter,
> -				       struct counter_count *count,
> -				       void *private, char *buf)
> +static int stm32_count_enable_read(struct counter_device *counter,
> +				   struct counter_count *count, u8 *enable)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 cr1;
>  
>  	regmap_read(priv->regmap, TIM_CR1, &cr1);
>  
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN));
> +	*enable = cr1 & TIM_CR1_CEN;
> +
> +	return 0;
>  }
>  
> -static ssize_t stm32_count_enable_write(struct counter_device *counter,
> -					struct counter_count *count,
> -					void *private,
> -					const char *buf, size_t len)
> +static int stm32_count_enable_write(struct counter_device *counter,
> +				    struct counter_count *count, u8 enable)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
> -	int err;
>  	u32 cr1;
> -	bool enable;
> -
> -	err = kstrtobool(buf, &enable);
> -	if (err)
> -		return err;
>  
>  	if (enable) {
>  		regmap_read(priv->regmap, TIM_CR1, &cr1);
> @@ -242,70 +228,55 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
>  	/* Keep enabled state to properly handle low power states */
>  	priv->enabled = enable;
>  
> -	return len;
> +	return 0;
>  }
>  
> -static const struct counter_count_ext stm32_count_ext[] = {
> -	{
> -		.name = "direction",
> -		.read = stm32_count_direction_read,
> -	},
> -	{
> -		.name = "enable",
> -		.read = stm32_count_enable_read,
> -		.write = stm32_count_enable_write
> -	},
> -	{
> -		.name = "ceiling",
> -		.read = stm32_count_ceiling_read,
> -		.write = stm32_count_ceiling_write
> -	},
> -};
> -
> -enum stm32_synapse_action {
> -	STM32_SYNAPSE_ACTION_NONE,
> -	STM32_SYNAPSE_ACTION_BOTH_EDGES
> +static struct counter_comp stm32_count_ext[] = {
> +	COUNTER_COMP_DIRECTION(stm32_count_direction_read),
> +	COUNTER_COMP_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
> +	COUNTER_COMP_CEILING(stm32_count_ceiling_read,
> +			     stm32_count_ceiling_write),
>  };
>  
>  static const enum counter_synapse_action stm32_synapse_actions[] = {
> -	[STM32_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
> -	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };
>  
> -static int stm32_action_get(struct counter_device *counter,
> -			    struct counter_count *count,
> -			    struct counter_synapse *synapse,
> -			    size_t *action)
> +static int stm32_action_read(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     struct counter_synapse *synapse,
> +			     enum counter_synapse_action *action)
>  {
> -	size_t function;
> +	enum counter_function function;
>  	int err;
>  
> -	err = stm32_count_function_get(counter, count, &function);
> +	err = stm32_count_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	switch (function) {
>  	case STM32_COUNT_SLAVE_MODE_DISABLED:
>  		/* counts on internal clock when CEN=1 */
> -		*action = STM32_SYNAPSE_ACTION_NONE;
> +		*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		return 0;
>  	case STM32_COUNT_ENCODER_MODE_1:
>  		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
>  		if (synapse->signal->id == count->synapses[0].signal->id)
> -			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		else
> -			*action = STM32_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		return 0;
>  	case STM32_COUNT_ENCODER_MODE_2:
>  		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
>  		if (synapse->signal->id == count->synapses[1].signal->id)
> -			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		else
> -			*action = STM32_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		return 0;
>  	case STM32_COUNT_ENCODER_MODE_3:
>  		/* counts up/down on both TI1FP1 and TI2FP2 edges */
> -		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -315,9 +286,9 @@ static int stm32_action_get(struct counter_device *counter,
>  static const struct counter_ops stm32_timer_cnt_ops = {
>  	.count_read = stm32_count_read,
>  	.count_write = stm32_count_write,
> -	.function_get = stm32_count_function_get,
> -	.function_set = stm32_count_function_set,
> -	.action_get = stm32_action_get,
> +	.function_read = stm32_count_function_read,
> +	.function_write = stm32_count_function_write,
> +	.action_read = stm32_action_read,
>  };
>  
>  static struct counter_signal stm32_signals[] = {
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 04be25ebf4a4..6ff53d3164f5 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/types.h>
>  
>  /* 32-bit registers */
>  #define QPOSCNT		0x0
> @@ -73,19 +74,13 @@ enum {
>  };
>  
>  /* Position Counter Input Modes */
> -enum {
> +enum ti_eqep_count_func {
>  	TI_EQEP_COUNT_FUNC_QUAD_COUNT,
>  	TI_EQEP_COUNT_FUNC_DIR_COUNT,
>  	TI_EQEP_COUNT_FUNC_UP_COUNT,
>  	TI_EQEP_COUNT_FUNC_DOWN_COUNT,
>  };
>  
> -enum {
> -	TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> -	TI_EQEP_SYNAPSE_ACTION_RISING_EDGE,
> -	TI_EQEP_SYNAPSE_ACTION_NONE,
> -};
> -
>  struct ti_eqep_cnt {
>  	struct counter_device counter;
>  	struct regmap *regmap32;
> @@ -93,7 +88,7 @@ struct ti_eqep_cnt {
>  };
>  
>  static int ti_eqep_count_read(struct counter_device *counter,
> -			      struct counter_count *count, unsigned long *val)
> +			      struct counter_count *count, u64 *val)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
>  	u32 cnt;
> @@ -105,7 +100,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
>  }
>  
>  static int ti_eqep_count_write(struct counter_device *counter,
> -			       struct counter_count *count, unsigned long val)
> +			       struct counter_count *count, u64 val)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
>  	u32 max;
> @@ -117,63 +112,99 @@ static int ti_eqep_count_write(struct counter_device *counter,
>  	return regmap_write(priv->regmap32, QPOSCNT, val);
>  }
>  
> -static int ti_eqep_function_get(struct counter_device *counter,
> -				struct counter_count *count, size_t *function)
> +static int ti_eqep_function_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 enum counter_function *function)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
>  	u32 qdecctl;
>  
>  	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> -	*function = (qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT;
> +
> +	switch ((qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT) {
> +	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> +		*function = COUNTER_FUNCTION_QUADRATURE_X4;
> +		break;
> +	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> +		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
> +		break;
> +	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> +		*function = COUNTER_FUNCTION_INCREASE;
> +		break;
> +	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> +		*function = COUNTER_FUNCTION_DECREASE;
> +		break;
> +	}
>  
>  	return 0;
>  }
>  
> -static int ti_eqep_function_set(struct counter_device *counter,
> -				struct counter_count *count, size_t function)
> +static int ti_eqep_function_write(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  enum counter_function function)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
> +	enum ti_eqep_count_func qsrc;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		qsrc = TI_EQEP_COUNT_FUNC_QUAD_COUNT;
> +		break;
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		qsrc = TI_EQEP_COUNT_FUNC_DIR_COUNT;
> +		break;
> +	case COUNTER_FUNCTION_INCREASE:
> +		qsrc = TI_EQEP_COUNT_FUNC_UP_COUNT;
> +		break;
> +	case COUNTER_FUNCTION_DECREASE:
> +		qsrc = TI_EQEP_COUNT_FUNC_DOWN_COUNT;
> +		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
>  
>  	return regmap_write_bits(priv->regmap16, QDECCTL, QDECCTL_QSRC,
> -				 function << QDECCTL_QSRC_SHIFT);
> +				 qsrc << QDECCTL_QSRC_SHIFT);
>  }
>  
> -static int ti_eqep_action_get(struct counter_device *counter,
> -			      struct counter_count *count,
> -			      struct counter_synapse *synapse, size_t *action)
> +static int ti_eqep_action_read(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       struct counter_synapse *synapse,
> +			       enum counter_synapse_action *action)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
> -	size_t function;
> +	enum counter_function function;
>  	u32 qdecctl;
>  	int err;
>  
> -	err = ti_eqep_function_get(counter, count, &function);
> +	err = ti_eqep_function_read(counter, count, &function);
>  	if (err)
>  		return err;
>  
>  	switch (function) {
> -	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
>  		/* In quadrature mode, the rising and falling edge of both
>  		 * QEPA and QEPB trigger QCLK.
>  		 */
> -		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		return 0;
> -	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
>  		/* In direction-count mode only rising edge of QEPA is counted
>  		 * and QEPB gives direction.
>  		 */
>  		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB)
> -			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  		else
> -			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>  		return 0;
> -	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> -	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> +	case COUNTER_FUNCTION_INCREASE:
> +	case COUNTER_FUNCTION_DECREASE:
>  		/* In up/down-count modes only QEPA is counted and QEPB is not
>  		 * used.
>  		 */
>  		if (synapse->signal->id == TI_EQEP_SIGNAL_QEPB) {
> -			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
> +			*action = COUNTER_SYNAPSE_ACTION_NONE;
>  			return 0;
>  		}
>  
> @@ -182,9 +213,9 @@ static int ti_eqep_action_get(struct counter_device *counter,
>  			return err;
>  
>  		if (qdecctl & QDECCTL_XCR)
> -			*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> +			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
>  		else
> -			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> +			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
>  		return 0;
>  	default:
>  		/* should never reach this path */
> @@ -195,82 +226,67 @@ static int ti_eqep_action_get(struct counter_device *counter,
>  static const struct counter_ops ti_eqep_counter_ops = {
>  	.count_read	= ti_eqep_count_read,
>  	.count_write	= ti_eqep_count_write,
> -	.function_get	= ti_eqep_function_get,
> -	.function_set	= ti_eqep_function_set,
> -	.action_get	= ti_eqep_action_get,
> +	.function_read	= ti_eqep_function_read,
> +	.function_write	= ti_eqep_function_write,
> +	.action_read	= ti_eqep_action_read,
>  };
>  
> -static ssize_t ti_eqep_position_ceiling_read(struct counter_device *counter,
> -					     struct counter_count *count,
> -					     void *ext_priv, char *buf)
> +static int ti_eqep_position_ceiling_read(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 u64 *ceiling)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
>  	u32 qposmax;
>  
>  	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
>  
> -	return sprintf(buf, "%u\n", qposmax);
> +	*ceiling = qposmax;
> +
> +	return 0;
>  }
>  
> -static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
> -					      struct counter_count *count,
> -					      void *ext_priv, const char *buf,
> -					      size_t len)
> +static int ti_eqep_position_ceiling_write(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  u64 ceiling)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
> -	int err;
> -	u32 res;
>  
> -	err = kstrtouint(buf, 0, &res);
> -	if (err < 0)
> -		return err;
> +	if (ceiling != (u32)ceiling)
> +		return -ERANGE;
>  
> -	regmap_write(priv->regmap32, QPOSMAX, res);
> +	regmap_write(priv->regmap32, QPOSMAX, ceiling);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *ext_priv, char *buf)
> +static int ti_eqep_position_enable_read(struct counter_device *counter,
> +					struct counter_count *count, u8 *enable)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
>  	u32 qepctl;
>  
>  	regmap_read(priv->regmap16, QEPCTL, &qepctl);
>  
> -	return sprintf(buf, "%u\n", !!(qepctl & QEPCTL_PHEN));
> +	*enable = !!(qepctl & QEPCTL_PHEN);
> +
> +	return 0;
>  }
>  
> -static ssize_t ti_eqep_position_enable_write(struct counter_device *counter,
> -					     struct counter_count *count,
> -					     void *ext_priv, const char *buf,
> -					     size_t len)
> +static int ti_eqep_position_enable_write(struct counter_device *counter,
> +					 struct counter_count *count, u8 enable)
>  {
>  	struct ti_eqep_cnt *priv = counter->priv;
> -	int err;
> -	bool res;
> -
> -	err = kstrtobool(buf, &res);
> -	if (err < 0)
> -		return err;
>  
> -	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, res ? -1 : 0);
> +	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
>  
> -	return len;
> +	return 0;
>  }
>  
> -static struct counter_count_ext ti_eqep_position_ext[] = {
> -	{
> -		.name	= "ceiling",
> -		.read	= ti_eqep_position_ceiling_read,
> -		.write	= ti_eqep_position_ceiling_write,
> -	},
> -	{
> -		.name	= "enable",
> -		.read	= ti_eqep_position_enable_read,
> -		.write	= ti_eqep_position_enable_write,
> -	},
> +static struct counter_comp ti_eqep_position_ext[] = {
> +	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
> +			     ti_eqep_position_ceiling_write),
> +	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
> +			    ti_eqep_position_enable_write),
>  };
>  
>  static struct counter_signal ti_eqep_signals[] = {
> @@ -285,16 +301,16 @@ static struct counter_signal ti_eqep_signals[] = {
>  };
>  
>  static const enum counter_function ti_eqep_position_functions[] = {
> -	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_FUNCTION_QUADRATURE_X4,
> -	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_FUNCTION_PULSE_DIRECTION,
> -	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_FUNCTION_INCREASE,
> -	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_DECREASE,
>  };
>  
>  static const enum counter_synapse_action ti_eqep_position_synapse_actions[] = {
> -	[TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES]	= COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> -	[TI_EQEP_SYNAPSE_ACTION_RISING_EDGE]	= COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> -	[TI_EQEP_SYNAPSE_ACTION_NONE]		= COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_NONE,
>  };
>  
>  static struct counter_synapse ti_eqep_position_synapses[] = {
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index d16ce2819b48..567471818ec3 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,42 +6,184 @@
>  #ifndef _COUNTER_H_
>  #define _COUNTER_H_
>  
> -#include <linux/counter_enum.h>
>  #include <linux/device.h>
> +#include <linux/kernel.h>
>  #include <linux/types.h>
>  
> +struct counter_device;
> +struct counter_count;
> +struct counter_synapse;
> +struct counter_signal;
> +
> +enum counter_comp_type {
> +	COUNTER_COMP_U8,
> +	COUNTER_COMP_U64,
> +	COUNTER_COMP_BOOL,
> +	COUNTER_COMP_SIGNAL_LEVEL,
> +	COUNTER_COMP_FUNCTION,
> +	COUNTER_COMP_SYNAPSE_ACTION,
> +	COUNTER_COMP_ENUM,
> +	COUNTER_COMP_COUNT_DIRECTION,
> +	COUNTER_COMP_COUNT_MODE,
> +};
> +
> +enum counter_scope {
> +	COUNTER_SCOPE_DEVICE,
> +	COUNTER_SCOPE_SIGNAL,
> +	COUNTER_SCOPE_COUNT,
> +};
> +
>  enum counter_count_direction {
> -	COUNTER_COUNT_DIRECTION_FORWARD = 0,
> -	COUNTER_COUNT_DIRECTION_BACKWARD
> +	COUNTER_COUNT_DIRECTION_FORWARD,
> +	COUNTER_COUNT_DIRECTION_BACKWARD,
>  };
> -extern const char *const counter_count_direction_str[2];
>  
>  enum counter_count_mode {
> -	COUNTER_COUNT_MODE_NORMAL = 0,
> +	COUNTER_COUNT_MODE_NORMAL,
>  	COUNTER_COUNT_MODE_RANGE_LIMIT,
>  	COUNTER_COUNT_MODE_NON_RECYCLE,
> -	COUNTER_COUNT_MODE_MODULO_N
> +	COUNTER_COUNT_MODE_MODULO_N,
>  };
> -extern const char *const counter_count_mode_str[4];
>  
> -struct counter_device;
> -struct counter_signal;
> +enum counter_function {
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X1_B,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +
> +enum counter_signal_level {
> +	COUNTER_SIGNAL_LEVEL_LOW,
> +	COUNTER_SIGNAL_LEVEL_HIGH,
> +};
> +
> +enum counter_synapse_action {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
>  
>  /**
> - * struct counter_signal_ext - Counter Signal extensions
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> + * struct counter_comp - Counter component node
> + * @type:		Counter component data type
> + * @name:		device-specific component name
> + * @priv:		component-relevant data
> + * @action_read		Synapse action mode read callback. The read value of the
> + *			respective Synapse action mode should be passed back via
> + *			the action parameter.
> + * @device_u8_read	Device u8 component read callback. The read value of the
> + *			respective Device u8 component should be passed back via
> + *			the val parameter.
> + * @count_u8_read	Count u8 component read callback. The read value of the
> + *			respective Count u8 component should be passed back via
> + *			the val parameter.
> + * @signal_u8_read	Signal u8 component read callback. The read value of the
> + *			respective Signal u8 component should be passed back via
> + *			the val parameter.
> + * @device_u32_read	Device u32 component read callback. The read value of
> + *			the respective Device u32 component should be passed
> + *			back via the val parameter.
> + * @count_u32_read	Count u32 component read callback. The read value of the
> + *			respective Count u32 component should be passed back via
> + *			the val parameter.
> + * @signal_u32_read	Signal u32 component read callback. The read value of
> + *			the respective Signal u32 component should be passed
> + *			back via the val parameter.
> + * @device_u64_read	Device u64 component read callback. The read value of
> + *			the respective Device u64 component should be passed
> + *			back via the val parameter.
> + * @count_u64_read	Count u64 component read callback. The read value of the
> + *			respective Count u64 component should be passed back via
> + *			the val parameter.
> + * @signal_u64_read	Signal u64 component read callback. The read value of
> + *			the respective Signal u64 component should be passed
> + *			back via the val parameter.
> + * @action_write	Synapse action mode write callback. The write value of
> + *			the respective Synapse action mode is passed via the
> + *			action parameter.
> + * @device_u8_write	Device u8 component write callback. The write value of
> + *			the respective Device u8 component is passed via the val
> + *			parameter.
> + * @count_u8_write	Count u8 component write callback. The write value of
> + *			the respective Count u8 component is passed via the val
> + *			parameter.
> + * @signal_u8_write	Signal u8 component write callback. The write value of
> + *			the respective Signal u8 component is passed via the val
> + *			parameter.
> + * @device_u32_write	Device u32 component write callback. The write value of
> + *			the respective Device u32 component is passed via the
> + *			val parameter.
> + * @count_u32_write	Count u32 component write callback. The write value of
> + *			the respective Count u32 component is passed via the val
> + *			parameter.
> + * @signal_u32_write	Signal u32 component write callback. The write value of
> + *			the respective Signal u32 component is passed via the
> + *			val parameter.
> + * @device_u64_write	Device u64 component write callback. The write value of
> + *			the respective Device u64 component is passed via the
> + *			val parameter.
> + * @count_u64_write	Count u64 component write callback. The write value of
> + *			the respective Count u64 component is passed via the val
> + *			parameter.
> + * @signal_u64_write	Signal u64 component write callback. The write value of
> + *			the respective Signal u64 component is passed via the
> + *			val parameter.
>   */
> -struct counter_signal_ext {
> +struct counter_comp {
> +	enum counter_comp_type type;
>  	const char *name;
> -	ssize_t (*read)(struct counter_device *counter,
> -			struct counter_signal *signal, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter,
> -			 struct counter_signal *signal, void *priv,
> -			 const char *buf, size_t len);
>  	void *priv;
> +	union {
> +		int (*action_read)(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   struct counter_synapse *synapse,
> +				   enum counter_synapse_action *action);
> +		int (*device_u8_read)(struct counter_device *counter, u8 *val);
> +		int (*count_u8_read)(struct counter_device *counter,
> +				     struct counter_count *count, u8 *val);
> +		int (*signal_u8_read)(struct counter_device *counter,
> +				      struct counter_signal *signal, u8 *val);
> +		int (*device_u32_read)(struct counter_device *counter,
> +				       u32 *val);
> +		int (*count_u32_read)(struct counter_device *counter,
> +				      struct counter_count *count, u32 *val);
> +		int (*signal_u32_read)(struct counter_device *counter,
> +				       struct counter_signal *signal, u32 *val);
> +		int (*device_u64_read)(struct counter_device *counter,
> +				       u64 *val);
> +		int (*count_u64_read)(struct counter_device *counter,
> +				      struct counter_count *count, u64 *val);
> +		int (*signal_u64_read)(struct counter_device *counter,
> +				       struct counter_signal *signal, u64 *val);
> +	};
> +	union {
> +		int (*action_write)(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    enum counter_synapse_action action);
> +		int (*device_u8_write)(struct counter_device *counter, u8 val);
> +		int (*count_u8_write)(struct counter_device *counter,
> +				      struct counter_count *count, u8 val);
> +		int (*signal_u8_write)(struct counter_device *counter,
> +				       struct counter_signal *signal, u8 val);
> +		int (*device_u32_write)(struct counter_device *counter,
> +					u32 val);
> +		int (*count_u32_write)(struct counter_device *counter,
> +				       struct counter_count *count, u32 val);
> +		int (*signal_u32_write)(struct counter_device *counter,
> +					struct counter_signal *signal, u32 val);
> +		int (*device_u64_write)(struct counter_device *counter,
> +					u64 val);
> +		int (*count_u64_write)(struct counter_device *counter,
> +				       struct counter_count *count, u64 val);
> +		int (*signal_u64_write)(struct counter_device *counter,
> +					struct counter_signal *signal, u64 val);
> +	};
>  };
>  
>  /**
> @@ -57,122 +199,23 @@ struct counter_signal {
>  	int id;
>  	const char *name;
>  
> -	const struct counter_signal_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
> -
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_signal_enum_ext - Signal enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_signal_enum_ext structure can be used to implement enum style
> - * Signal extension attributes. Enum style attributes are those which have a set
> - * of strings that map to unsigned integer values. The Generic Counter Signal
> - * enum extension helper code takes care of mapping between value and string, as
> - * well as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_signal_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter,
> -		   struct counter_signal *signal, size_t *item);
> -	int (*set)(struct counter_device *counter,
> -		   struct counter_signal *signal, size_t item);
> -};
> -
> -/**
> - * COUNTER_SIGNAL_ENUM() - Initialize Signal enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_signal_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_SIGNAL_ENUM_AVAILABLE()
> - */
> -#define COUNTER_SIGNAL_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_signal_enum_read, \
> -	.write = counter_signal_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_SIGNAL_ENUM_AVAILABLE() - Initialize Signal enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_signal_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_SIGNAL_ENUM()
> - */
> -#define COUNTER_SIGNAL_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_signal_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
> -enum counter_synapse_action {
> -	COUNTER_SYNAPSE_ACTION_NONE = 0,
> -	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> -	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> -	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
>  };
>  
>  /**
>   * struct counter_synapse - Counter Synapse node
> - * @action:		index of current action mode
>   * @actions_list:	array of available action modes
>   * @num_actions:	number of action modes specified in @actions_list
>   * @signal:		pointer to associated signal
>   */
>  struct counter_synapse {
> -	size_t action;
>  	const enum counter_synapse_action *actions_list;
>  	size_t num_actions;
>  
>  	struct counter_signal *signal;
>  };
>  
> -struct counter_count;
> -
> -/**
> - * struct counter_count_ext - Counter Count extension
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> - */
> -struct counter_count_ext {
> -	const char *name;
> -	ssize_t (*read)(struct counter_device *counter,
> -			struct counter_count *count, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter,
> -			 struct counter_count *count, void *priv,
> -			 const char *buf, size_t len);
> -	void *priv;
> -};
> -
> -enum counter_function {
> -	COUNTER_FUNCTION_INCREASE = 0,
> -	COUNTER_FUNCTION_DECREASE,
> -	COUNTER_FUNCTION_PULSE_DIRECTION,
> -	COUNTER_FUNCTION_QUADRATURE_X1_A,
> -	COUNTER_FUNCTION_QUADRATURE_X1_B,
> -	COUNTER_FUNCTION_QUADRATURE_X2_A,
> -	COUNTER_FUNCTION_QUADRATURE_X2_B,
> -	COUNTER_FUNCTION_QUADRATURE_X4
> -};
> -
>  /**
>   * struct counter_count - Counter Count node
>   * @id:			unique ID used to identify Count
> @@ -191,108 +234,14 @@ struct counter_count {
>  	int id;
>  	const char *name;
>  
> -	size_t function;
>  	const enum counter_function *functions_list;
>  	size_t num_functions;
>  
>  	struct counter_synapse *synapses;
>  	size_t num_synapses;
>  
> -	const struct counter_count_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
> -
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_count_enum_ext - Count enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_count_enum_ext structure can be used to implement enum style
> - * Count extension attributes. Enum style attributes are those which have a set
> - * of strings that map to unsigned integer values. The Generic Counter Count
> - * enum extension helper code takes care of mapping between value and string, as
> - * well as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_count_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter, struct counter_count *count,
> -		   size_t *item);
> -	int (*set)(struct counter_device *counter, struct counter_count *count,
> -		   size_t item);
> -};
> -
> -/**
> - * COUNTER_COUNT_ENUM() - Initialize Count enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_count_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_COUNT_ENUM_AVAILABLE()
> - */
> -#define COUNTER_COUNT_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_count_enum_read, \
> -	.write = counter_count_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_COUNT_ENUM_AVAILABLE() - Initialize Count enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_count_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_COUNT_ENUM()
> - */
> -#define COUNTER_COUNT_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_count_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * struct counter_device_attr_group - internal container for attribute group
> - * @attr_group:	Counter sysfs attributes group
> - * @attr_list:	list to keep track of created Counter sysfs attributes
> - * @num_attr:	number of Counter sysfs attributes
> - */
> -struct counter_device_attr_group {
> -	struct attribute_group attr_group;
> -	struct list_head attr_list;
> -	size_t num_attr;
> -};
> -
> -/**
> - * struct counter_device_state - internal state container for a Counter device
> - * @id:			unique ID used to identify the Counter
> - * @dev:		internal device structure
> - * @groups_list:	attribute groups list (for Signals, Counts, and ext)
> - * @num_groups:		number of attribute groups containers
> - * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
> - */
> -struct counter_device_state {
> -	int id;
> -	struct device dev;
> -	struct counter_device_attr_group *groups_list;
> -	size_t num_groups;
> -	const struct attribute_group **groups;
> -};
> -
> -enum counter_signal_level {
> -	COUNTER_SIGNAL_LEVEL_LOW,
> -	COUNTER_SIGNAL_LEVEL_HIGH,
>  };
>  
>  /**
> @@ -326,97 +275,29 @@ struct counter_ops {
>  			   struct counter_signal *signal,
>  			   enum counter_signal_level *level);
>  	int (*count_read)(struct counter_device *counter,
> -			  struct counter_count *count, unsigned long *val);
> +			  struct counter_count *count, u64 *value);
>  	int (*count_write)(struct counter_device *counter,
> -			   struct counter_count *count, unsigned long val);
> -	int (*function_get)(struct counter_device *counter,
> -			    struct counter_count *count, size_t *function);
> -	int (*function_set)(struct counter_device *counter,
> -			    struct counter_count *count, size_t function);
> -	int (*action_get)(struct counter_device *counter,
> -			  struct counter_count *count,
> -			  struct counter_synapse *synapse, size_t *action);
> -	int (*action_set)(struct counter_device *counter,
> -			  struct counter_count *count,
> -			  struct counter_synapse *synapse, size_t action);
> -};
> -
> -/**
> - * struct counter_device_ext - Counter device extension
> - * @name:	attribute name
> - * @read:	read callback for this attribute; may be NULL
> - * @write:	write callback for this attribute; may be NULL
> - * @priv:	data private to the driver
> - */
> -struct counter_device_ext {
> -	const char *name;
> -	ssize_t (*read)(struct counter_device *counter, void *priv, char *buf);
> -	ssize_t (*write)(struct counter_device *counter, void *priv,
> -			 const char *buf, size_t len);
> -	void *priv;
> -};
> -
> -/**
> - * struct counter_device_enum_ext - Counter enum extension attribute
> - * @items:	Array of strings
> - * @num_items:	Number of items specified in @items
> - * @set:	Set callback function; may be NULL
> - * @get:	Get callback function; may be NULL
> - *
> - * The counter_device_enum_ext structure can be used to implement enum style
> - * Counter extension attributes. Enum style attributes are those which have a
> - * set of strings that map to unsigned integer values. The Generic Counter enum
> - * extension helper code takes care of mapping between value and string, as well
> - * as generating a "_available" file which contains a list of all available
> - * items. The get callback is used to query the currently active item; the index
> - * of the item within the respective items array is returned via the 'item'
> - * parameter. The set callback is called when the attribute is updated; the
> - * 'item' parameter contains the index of the newly activated item within the
> - * respective items array.
> - */
> -struct counter_device_enum_ext {
> -	const char * const *items;
> -	size_t num_items;
> -	int (*get)(struct counter_device *counter, size_t *item);
> -	int (*set)(struct counter_device *counter, size_t item);
> +			   struct counter_count *count, u64 value);
> +	int (*function_read)(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     enum counter_function *function);
> +	int (*function_write)(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      enum counter_function function);
> +	int (*action_read)(struct counter_device *counter,
> +			   struct counter_count *count,
> +			   struct counter_synapse *synapse,
> +			   enum counter_synapse_action *action);
> +	int (*action_write)(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    enum counter_synapse_action action);
>  };
>  
> -/**
> - * COUNTER_DEVICE_ENUM() - Initialize Counter enum extension
> - * @_name:	Attribute name
> - * @_e:		Pointer to a counter_device_enum_ext structure
> - *
> - * This should usually be used together with COUNTER_DEVICE_ENUM_AVAILABLE()
> - */
> -#define COUNTER_DEVICE_ENUM(_name, _e) \
> -{ \
> -	.name = (_name), \
> -	.read = counter_device_enum_read, \
> -	.write = counter_device_enum_write, \
> -	.priv = (_e) \
> -}
> -
> -/**
> - * COUNTER_DEVICE_ENUM_AVAILABLE() - Initialize Counter enum available extension
> - * @_name:	Attribute name ("_available" will be appended to the name)
> - * @_e:		Pointer to a counter_device_enum_ext structure
> - *
> - * Creates a read only attribute that lists all the available enum items in a
> - * newline separated list. This should usually be used together with
> - * COUNTER_DEVICE_ENUM()
> - */
> -#define COUNTER_DEVICE_ENUM_AVAILABLE(_name, _e) \
> -{ \
> -	.name = (_name "_available"), \
> -	.read = counter_device_enum_available_read, \
> -	.priv = (_e) \
> -}
> -
>  /**
>   * struct counter_device - Counter data structure
>   * @name:		name of the device as it appears in the datasheet
>   * @parent:		optional parent device providing the counters
> - * @device_state:	internal device state container
>   * @ops:		callbacks from driver
>   * @signals:		array of Signals
>   * @num_signals:	number of Signals specified in @signals
> @@ -425,11 +306,11 @@ struct counter_device_enum_ext {
>   * @ext:		optional array of Counter device extensions
>   * @num_ext:		number of Counter device extensions specified in @ext
>   * @priv:		optional private data supplied by driver
> + * @dev:		internal device structure
>   */
>  struct counter_device {
>  	const char *name;
>  	struct device *parent;
> -	struct counter_device_state *device_state;
>  
>  	const struct counter_ops *ops;
>  
> @@ -438,17 +319,159 @@ struct counter_device {
>  	struct counter_count *counts;
>  	size_t num_counts;
>  
> -	const struct counter_device_ext *ext;
> +	struct counter_comp *ext;
>  	size_t num_ext;
>  
>  	void *priv;
> +
> +	struct device dev;
>  };
>  
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
>  			  struct counter_device *const counter);
> -void devm_counter_unregister(struct device *dev,
> -			     struct counter_device *const counter);
> +
> +#define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.device_u8_read = (_read), \
> +	.device_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.count_u8_read = (_read), \
> +	.count_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_U8(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U8, \
> +	.name = (_name), \
> +	.signal_u8_read = (_read), \
> +	.signal_u8_write = (_write), \
> +}
> +
> +#define COUNTER_COMP_DEVICE_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.device_u64_read = (_read), \
> +	.device_u64_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.count_u64_read = (_read), \
> +	.count_u64_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_U64(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_U64, \
> +	.name = (_name), \
> +	.signal_u64_read = (_read), \
> +	.signal_u64_write = (_write), \
> +}
> +
> +#define COUNTER_COMP_DEVICE_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.device_u8_read = (_read), \
> +	.device_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_COUNT_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.count_u8_read = (_read), \
> +	.count_u8_write = (_write), \
> +}
> +#define COUNTER_COMP_SIGNAL_BOOL(_name, _read, _write) \
> +{ \
> +	.type = COUNTER_COMP_BOOL, \
> +	.name = (_name), \
> +	.signal_u8_read = (_read), \
> +	.signal_u8_write = (_write), \
> +}
> +
> +struct counter_available {
> +	union {
> +		const u32 *enums;
> +		const char *const *strs;
> +	};
> +	size_t num_items;
> +};
> +
> +#define DEFINE_COUNTER_AVAILABLE(_name, _enums) \
> +	struct counter_available _name = { \
> +		.enums = (_enums), \
> +		.num_items = ARRAY_SIZE(_enums), \
> +	}
> +
> +#define DEFINE_COUNTER_ENUM(_name, _strs) \
> +	struct counter_available _name = { \
> +		.strs = (_strs), \
> +		.num_items = ARRAY_SIZE(_strs), \
> +	}
> +
> +#define COUNTER_COMP_DEVICE_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.device_u32_read = (_get), \
> +	.device_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +#define COUNTER_COMP_COUNT_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.count_u32_read = (_get), \
> +	.count_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +#define COUNTER_COMP_SIGNAL_ENUM(_name, _get, _set, _available) \
> +{ \
> +	.type = COUNTER_COMP_ENUM, \
> +	.name = (_name), \
> +	.signal_u32_read = (_get), \
> +	.signal_u32_write = (_set), \
> +	.priv = &(_available), \
> +}
> +
> +#define COUNTER_COMP_CEILING(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
> +
> +#define COUNTER_COMP_COUNT_MODE(_read, _write, _available) \
> +{ \
> +	.type = COUNTER_COMP_COUNT_MODE, \
> +	.name = "count_mode", \
> +	.count_u32_read = (_read), \
> +	.count_u32_write = (_write), \
> +	.priv = &(_available), \
> +}
> +
> +#define COUNTER_COMP_DIRECTION(_read) \
> +{ \
> +	.type = COUNTER_COMP_COUNT_DIRECTION, \
> +	.name = "direction", \
> +	.count_u32_read = (_read), \
> +}
> +
> +#define COUNTER_COMP_ENABLE(_read, _write) \
> +	COUNTER_COMP_COUNT_BOOL("enable", _read, _write)
> +
> +#define COUNTER_COMP_FLOOR(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> +
> +#define COUNTER_COMP_PRESET(_read, _write) \
> +	COUNTER_COMP_COUNT_U64("preset", _read, _write)
> +
> +#define COUNTER_COMP_PRESET_ENABLE(_read, _write) \
> +	COUNTER_COMP_COUNT_BOOL("preset_enable", _read, _write)
>  
>  #endif /* _COUNTER_H_ */
> diff --git a/include/linux/counter_enum.h b/include/linux/counter_enum.h
> deleted file mode 100644
> index 9f917298a88f..000000000000
> --- a/include/linux/counter_enum.h
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Counter interface enum functions
> - * Copyright (C) 2018 William Breathitt Gray
> - */
> -#ifndef _COUNTER_ENUM_H_
> -#define _COUNTER_ENUM_H_
> -
> -#include <linux/types.h>
> -
> -struct counter_device;
> -struct counter_signal;
> -struct counter_count;
> -
> -ssize_t counter_signal_enum_read(struct counter_device *counter,
> -				 struct counter_signal *signal, void *priv,
> -				 char *buf);
> -ssize_t counter_signal_enum_write(struct counter_device *counter,
> -				  struct counter_signal *signal, void *priv,
> -				  const char *buf, size_t len);
> -
> -ssize_t counter_signal_enum_available_read(struct counter_device *counter,
> -					   struct counter_signal *signal,
> -					   void *priv, char *buf);
> -
> -ssize_t counter_count_enum_read(struct counter_device *counter,
> -				struct counter_count *count, void *priv,
> -				char *buf);
> -ssize_t counter_count_enum_write(struct counter_device *counter,
> -				 struct counter_count *count, void *priv,
> -				 const char *buf, size_t len);
> -
> -ssize_t counter_count_enum_available_read(struct counter_device *counter,
> -					  struct counter_count *count,
> -					  void *priv, char *buf);
> -
> -ssize_t counter_device_enum_read(struct counter_device *counter, void *priv,
> -				 char *buf);
> -ssize_t counter_device_enum_write(struct counter_device *counter, void *priv,
> -				  const char *buf, size_t len);
> -
> -ssize_t counter_device_enum_available_read(struct counter_device *counter,
> -					   void *priv, char *buf);
> -
> -#endif /* _COUNTER_ENUM_H_ */
> 
