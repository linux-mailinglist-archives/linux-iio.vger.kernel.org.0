Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3262737BE42
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELNcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:32:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230037AbhELNcv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 09:32:51 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CDRF4m010696;
        Wed, 12 May 2021 15:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=tVGPSSrcB1hX8FbH7PKayuvvqw26VQ1tdFSMI497hA8=;
 b=teBR/693+v3LejjwCPObhOQKf76ivbRy8LlFbgvIgRTLQHVm3syDKrBxhbYOGQHqkoAn
 pDPoUjNYq/r5MPs0lyZJEA6ztHGrOK2aeQgUYgmmxVt97Wb8niQYiFMyS/OQalA/LHWa
 phAu5abUNNRSr86egtxmeOhBBj6EuatudOq0R/qeGe0agIQGzBljr/YE290EXEwe7Puw
 9W5vsoj7g8T/fUjYEDKfscp11n5BKYjbMC+aFHL0OlVDzDQa6U59bs8yUdXRp24SaIIl
 4UrZXm6fAO9Pr6hgvWOcDsDl+Q+/Sud32rKwSnbBjYRJ8CtV9mpOzKjHW470tB3ouEqn UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38gcfah9j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 15:31:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF20A10002A;
        Wed, 12 May 2021 15:31:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE8B222560E;
        Wed, 12 May 2021 15:31:34 +0200 (CEST)
Received: from [10.211.1.115] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 15:31:33 +0200
Subject: Re: [PATCH 15/28] iio: adc: stm32-dfsdm: Use
 pm_runtime_resume_and_get() to replace open coding.
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-16-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <b5ee8190-1659-f5ca-def1-6f77069870e5@foss.st.com>
Date:   Wed, 12 May 2021 15:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210509113354.660190-16-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_07:2021-05-12,2021-05-12 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/9/21 1:33 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)


Hi Jonathan,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the patch,
Regards,
Fabrice

> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index bb925a11c8ae..a627af9a825e 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -135,11 +135,9 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  	int ret;
>  
>  	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0) {
> -			pm_runtime_put_noidle(dev);
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
>  			goto error_ret;
> -		}
>  
>  		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
>  		clk_src = priv->aclk ? 1 : 0;
> 
