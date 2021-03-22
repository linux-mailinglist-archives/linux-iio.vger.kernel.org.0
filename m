Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC4F344B5B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhCVQab (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 12:30:31 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhCVQa2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 12:30:28 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MGQcK1029398;
        Mon, 22 Mar 2021 17:29:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Mm0KMnFbONfx62UvQTCW8mlRbXh1IVs+KqZwdCGnGDo=;
 b=ifyN3U5IykhSraPEAbvAOrXMJL+DAm8tm/j3TXqEgG/En7O4+Im8LFplB+I2UCWfZLp4
 jLxrgwazzpUTUOM8sEdDWUqINgy3obyM/0p/gksDUoFnnEkDAm7FaPh7RxWeDOvg2Naf
 tM48dzJw+cs7by/qnKcESzVUADb9ceJZ4GxeHVWmL+7X9wChf0QvWTV1mkPiBq6KXQ7A
 sZpj7h4Fbfd9Cw07HEKc0LqqDWz3HDMpQ+VR6pBclGfKca1R9DZsE4qnDPrhGEBu1APe
 Cxz4qv2V4m089rMvYQeceUy3zUN91n73sE8oLbYUO76EDc5DWH9IiG8OBoMQKcWbMXFR yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d996adqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:29:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AF2110002A;
        Mon, 22 Mar 2021 17:29:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58C8223463E;
        Mon, 22 Mar 2021 17:29:27 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 17:29:26 +0100
Subject: Re: [Linux-stm32] [PATCH v10 19/33] counter: Standardize to ERANGE
 for limit exceeded errors
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
 <f09068dd8b89aa81c4310ea39cbdb0d631dddf98.1616150619.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <1510a9e6-d1d3-c370-488d-42874f28d129@foss.st.com>
Date:   Mon, 22 Mar 2021 17:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f09068dd8b89aa81c4310ea39cbdb0d631dddf98.1616150619.git.vilhelm.gray@gmail.com>
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
> ERANGE is a semantically better error code to return when an argument
> value falls outside the supported limit range of a device.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c        | 6 +++---
>  drivers/counter/interrupt-cnt.c     | 3 +++
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)

Hi William,

For the STM32 driver, you can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index b7d6c1c43655..0409b1771fd9 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (val > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -669,7 +669,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (preset > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -714,7 +714,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (ceiling > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 0e07607f2cd3..f27dea317965 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -107,6 +107,9 @@ static int interrupt_cnt_write(struct counter_device *counter,
>  {
>  	struct interrupt_cnt_priv *priv = counter->priv;
>  
> +	if (val != (typeof(priv->count.counter))val)
> +		return -ERANGE;
> +
>  	atomic_set(&priv->count, val);
>  
>  	return 0;
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 78f383b77bd2..49aeb9e393f3 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
>  		return ret;
>  
>  	if (ceiling > STM32_LPTIM_MAX_ARR)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	priv->ceiling = ceiling;
>  
> 
