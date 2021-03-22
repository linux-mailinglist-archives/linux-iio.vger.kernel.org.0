Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADCD344B2E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 17:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCVQZL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 12:25:11 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40732 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhCVQYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 12:24:43 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MGKlFV018645;
        Mon, 22 Mar 2021 17:23:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=S7RCTHzi534pxE4KMJqypcbpIdoTSLI6H/XMtQDWVHU=;
 b=euJe7z5u5KAejDrba1xiC2QFGmeiI7ze9JJIZbWiBx1wGFh9CDj2+3uiP4mDB/PpeGty
 LIphGyAFTQs87VPvNQe/sPU38ZDlZNohNxeeEgw6x88eRNgvO8GvV147+M1qtwaff9fv
 OG5kIywmH7Fr0Ynzm+UlPt5zkHtEWBv0xBYMSCsPtnlYH9pf33gQV1JsbN4fTsO3SYbs
 uSRNMzKysR+Qy7/3WKmsrGbPdfIbx7NS0fJhNGJbK1WzPOTEWXOc0xGRaS1BTi6Rtr1e
 f+Z2Zi4dF6j7fiMVdardjeyeWPL2KHObioJeGWLA+xznkMdM99ZUUHWzOhx3h+hvbtJ3 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d996acwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:23:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73B8B10002A;
        Mon, 22 Mar 2021 17:23:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F17F22A2A3;
        Mon, 22 Mar 2021 17:23:46 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 17:23:44 +0100
Subject: Re: [Linux-stm32] [PATCH v10 16/33] counter: stm32-lptimer-cnt: Add
 const qualifier for actions_list array
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, <jic23@kernel.org>
CC:     <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <david@lechnology.com>, <linux-iio@vger.kernel.org>,
        <patrick.havelange@essensium.com>, <alexandre.belloni@bootlin.com>,
        <mcoquelin.stm32@gmail.com>, <linux-kernel@vger.kernel.org>,
        <o.rempel@pengutronix.de>, <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <syednwaris@gmail.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.torgue@foss.st.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <1a454675b256daed71e0c0053377f36475f920d3.1616150619.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <138989da-a4da-237e-8a42-d0f746768d95@foss.st.com>
Date:   Mon, 22 Mar 2021 17:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a454675b256daed71e0c0053377f36475f920d3.1616150619.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_08:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/21 12:00 PM, William Breathitt Gray wrote:
> The struct counter_synapse actions_list member expects a const enum
> counter_synapse_action array. This patch adds the const qualifier to the
> stm32_lptim_cnt_synapse_actions to match actions_list.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi William,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 0f7d3f1ec1b6..c19d998df5ba 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -146,7 +146,7 @@ enum stm32_lptim_synapse_action {
>  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
>  };
>  
> -static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
> +static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
>  	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
>  	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>  	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> 
