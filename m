Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1189B62F2
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfIRMQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 08:16:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42792 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729277AbfIRMQ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 08:16:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ICGHlD023163;
        Wed, 18 Sep 2019 14:16:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=8ZrDgpdMzmVLj7n/V3GIOKe3N2fmdar22nZB+6Ict7A=;
 b=mgB12bKFeCYXRhIpeAtPbS9Zfwm43cBJZp0bNavNip6flNtwPIumKcFTh6OLAOVMAsAx
 COfjJjXm6iBTbFUQDOSFEhrsJWTccbg7j65Rs6jn0RZOEquxh6qKKY5YiIftRd5a0gb7
 el1zYHht8VrLnzV1fwVfrOP/EYjtE3kQi4txyEHgLhhi29+2bT6P07GSoPr+5vjwvH0u
 FXT7au5v8AAI0ejYQKs/os6aqsz28tmPt6byktnAs4azLc24Q67B8lQuF6iiIIp59ACK
 sKHe2uIr+JDjma+shOJC10MjBnLzjQ3WKhLp7LQVMs3EiZu1q6DqyIq7OZP9X+NBmScn zg== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v37kmc2ps-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 18 Sep 2019 14:16:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8DAFA24;
        Wed, 18 Sep 2019 12:16:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 154F22C4735;
        Wed, 18 Sep 2019 14:16:40 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep
 2019 14:16:40 +0200
Received: from [10.48.1.232] (10.48.1.232) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 18 Sep 2019 14:16:39
 +0200
Subject: Re: [PATCH v2 7/7] counter: stm32-timer-cnt: Update count_read and
 count_write callbacks
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        <jic23@jic23.retrosnub.co.uk>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <patrick.havelange@essensium.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
 <327fe01b7ce4feb0fc3d854393691664a6a36b40.1568792697.git.vilhelm.gray@gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <a5891ee5-162e-6a72-261d-e736f5088020@st.com>
Date:   Wed, 18 Sep 2019 14:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <327fe01b7ce4feb0fc3d854393691664a6a36b40.1568792697.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.232]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_07:2019-09-17,2019-09-18 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/18/19 9:52 AM, William Breathitt Gray wrote:
> The count_read and count_write callbacks pass unsigned long now.
> 
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,

I tested your series for STM32 timer and LPtimer drivers. Maybe you can
squash as suggested by Benjamin ?
With that, you can add my acked-by for the two STM32 drivers.

Thanks,
Fabrice

> ---
>  drivers/counter/stm32-timer-cnt.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 644ba18a72ad..839083543323 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -48,34 +48,27 @@ static enum counter_count_function stm32_count_functions[] = {
>  };
>  
>  static int stm32_count_read(struct counter_device *counter,
> -			    struct counter_count *count,
> -			    struct counter_count_read_value *val)
> +			    struct counter_count *count, unsigned long *val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
>  	u32 cnt;
>  
>  	regmap_read(priv->regmap, TIM_CNT, &cnt);
> -	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
> +	*val = cnt;
>  
>  	return 0;
>  }
>  
>  static int stm32_count_write(struct counter_device *counter,
>  			     struct counter_count *count,
> -			     struct counter_count_write_value *val)
> +			     const unsigned long val)
>  {
>  	struct stm32_timer_cnt *const priv = counter->priv;
> -	u32 cnt;
> -	int err;
> -
> -	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
> -	if (err)
> -		return err;
>  
> -	if (cnt > priv->ceiling)
> +	if (val > priv->ceiling)
>  		return -EINVAL;
>  
> -	return regmap_write(priv->regmap, TIM_CNT, cnt);
> +	return regmap_write(priv->regmap, TIM_CNT, val);
>  }
>  
>  static int stm32_count_function_get(struct counter_device *counter,
> 
