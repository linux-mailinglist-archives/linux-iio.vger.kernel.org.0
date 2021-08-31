Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F53FC876
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhHaNlb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 09:41:31 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:39250 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239284AbhHaNla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 09:41:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17V923tF014249;
        Tue, 31 Aug 2021 15:39:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7TWD+I2wmEXOmT9BAsUP1oRCwO+F14w5H0sbol1tPM0=;
 b=GKm6shn98d6ivZJO4J1igf5qaGP/Grc7aFiFfP7e0KzbQtmH6CsDEos2UgkI6/+MmR7f
 PVeynkBbLlk9XbwWU5BIqSiDli9bFWukWfTfx8L1bjuMMHx8UIkmgYR+4rxtbOLNjP0I
 f3lET4OVSlEJ4P2++7ZcWzUda5hURORDBs1c68AcoM6GRSwASN8Q2PzkzZ+hv0NP/9k4
 4XZqdnv7h07XNLR9vMsOwEn4Qi+/iiMPSUHwPQqTtgbtrDsv+Jx6gdZtDwtPyRyQQ6on
 t82JG+oB1DTs4cGRIGr4BOAnxsDnvyPbrSfRG+yotOvZZ4DVd0G0EnysjRO9ct4J8D2S RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3asheh1h64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 15:39:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4AFA510002A;
        Tue, 31 Aug 2021 15:39:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22513246929;
        Tue, 31 Aug 2021 15:39:13 +0200 (CEST)
Received: from [10.211.11.146] (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 15:39:11 +0200
Subject: Re: [PATCH v16 01/14] counter: stm32-lptimer-cnt: Provide defines for
 clock polarities
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@pengutronix.de>, <a.fatoum@pengutronix.de>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <alexandre.belloni@bootlin.com>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <syednwaris@gmail.com>,
        <patrick.havelange@essensium.com>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <o.rempel@pengutronix.de>, <jarkko.nikula@linux.intel.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <a111c8905c467805ca530728f88189b59430f27e.1630031207.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <ec80f7a8-5f2e-522f-6a66-ab25092618c2@foss.st.com>
Date:   Tue, 31 Aug 2021 15:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a111c8905c467805ca530728f88189b59430f27e.1630031207.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-31_05,2021-08-31_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> The STM32 low-power timer permits configuration of the clock polarity
> via the LPTIMX_CFGR register CKPOL bits. This patch provides
> preprocessor defines for the supported clock polarities.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/stm32-lptimer-cnt.c | 6 +++---
>  include/linux/mfd/stm32-lptimer.h   | 5 +++++
>  2 files changed, 8 insertions(+), 3 deletions(-)

Hi William,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 13656957c45f..7367f46c6f91 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -140,9 +140,9 @@ static const enum counter_function stm32_lptim_cnt_functions[] = {
>  };
>  
>  enum stm32_lptim_synapse_action {
> -	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> -	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> -	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> +	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE = STM32_LPTIM_CKPOL_RISING_EDGE,
> +	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE = STM32_LPTIM_CKPOL_FALLING_EDGE,
> +	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES = STM32_LPTIM_CKPOL_BOTH_EDGES,
>  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
>  };
>  
> diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> index 90b20550c1c8..06d3f11dc3c9 100644
> --- a/include/linux/mfd/stm32-lptimer.h
> +++ b/include/linux/mfd/stm32-lptimer.h
> @@ -45,6 +45,11 @@
>  #define STM32_LPTIM_PRESC	GENMASK(11, 9)
>  #define STM32_LPTIM_CKPOL	GENMASK(2, 1)
>  
> +/* STM32_LPTIM_CKPOL */
> +#define STM32_LPTIM_CKPOL_RISING_EDGE	0
> +#define STM32_LPTIM_CKPOL_FALLING_EDGE	1
> +#define STM32_LPTIM_CKPOL_BOTH_EDGES	2
> +
>  /* STM32_LPTIM_ARR */
>  #define STM32_LPTIM_MAX_ARR	0xFFFF
>  
> 
