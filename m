Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00961344B6D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCVQdM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 12:33:12 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhCVQch (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 12:32:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MGRM92017735;
        Mon, 22 Mar 2021 17:31:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=eYJ+96GvFVUb6XwZEeRIQ3Su2THKE67+vFfdvVmZEsg=;
 b=bFkGSMGoh/uW1elTO1FZDNRzd7rl8hjGDMPvQX7F7bHsWWu2rVGb31cQMb1DjXr9UyqI
 r5OXQOv9qyjSWEjnms0eSFA3Hu8lJCZkkZ+Eeu3F0wIO8Y/wZksv4qqvPntZbRUb4Dn4
 yt2Ho4lQ6lh7lW0r2UJIfNx8O7XR1Za9hbm2JuVtGWNRcAeObSNCnOMVd5/GREkMDtw+
 gqIfKyti5iZ/QEr4o+pcD19HmbWK5GPSVgTIVpVcYnvfHmgq4TIuPbJWyUMUpCRN/TKE
 dR0ixok7bM/VETJfVjE8FGsGRXfhHoOd6MdO0z0L5kmum838IkMGF//NW/kg8uZpyO4B Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d7d7trgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:31:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D17310002A;
        Mon, 22 Mar 2021 17:31:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAD97235AA2;
        Mon, 22 Mar 2021 17:31:34 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 17:31:33 +0100
Subject: Re: [Linux-stm32] [PATCH v10 21/33] counter: Rename
 counter_count_function to counter_function
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
 <a0e07cf7131556233bbd0236a944a032451c79ae.1616150619.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <d0927ed2-29e3-e922-297c-447452b822b6@foss.st.com>
Date:   Mon, 22 Mar 2021 17:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a0e07cf7131556233bbd0236a944a032451c79ae.1616150619.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_08:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 3/19/21 12:00 PM, William Breathitt Gray wrote:
> The phrase "Counter Count function" is verbose and unintentionally
> implies that function is a Count extension. This patch adjusts the
> Counter subsystem code to use the more direct "Counter function" phrase
> to make the intent of this code clearer.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c            | 10 +++----
>  drivers/counter/counter.c               | 38 ++++++++++++-------------
>  drivers/counter/ftm-quaddec.c           |  5 ++--
>  drivers/counter/interrupt-cnt.c         |  4 +--
>  drivers/counter/microchip-tcb-capture.c |  4 +--
>  drivers/counter/stm32-lptimer-cnt.c     |  6 ++--
>  drivers/counter/stm32-timer-cnt.c       | 10 +++----

Hi William,

For the STM32 drivers, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

>  drivers/counter/ti-eqep.c               | 10 +++----
>  include/linux/counter.h                 | 20 ++++++-------
>  9 files changed, 53 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index fb0f021c0751..5a49ace2d4a6 100644
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
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index cce579c1c6ae..3dbb8acc67eb 100644
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
> index 878725c2f010..04be25ebf4a4 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -284,11 +284,11 @@ static struct counter_signal ti_eqep_signals[] = {
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
> 
