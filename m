Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9505037BE44
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhELNdl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:33:41 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:2562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhELNdj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 09:33:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CDSIxf016177;
        Wed, 12 May 2021 15:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ec/O72GQItrzZBLw7js8PJKuJxnNre+CM+ZbreJqxqM=;
 b=zewD4IsuSMeEkA6FCKy5b4F4MpGeIU0i0BEHNDRvVAnFmZtSARH6N8ioVf73e8L1/iZw
 2zMP3hIVruvWGA/9iVeQ9fgbhpvPFVzdhZipKzloi/cabFtbT8KJ5yxWuS8OzkN38+3u
 W6e8kDjywsvLHlZg19jMXRYHGkUGeiFTNP1LIQ/REO0lzftu+J1Hq6S5U8nE06QU+fEb
 uEZowLMVMbO+/ANWXN3ZdMRvMSesemySAMnn06OrXqF1jeiTblWGKyBYtgqPZg28FyXC
 3E2V8vZulhfB0Z3HJWJwdcYmL8i/jIE5zXu/cvF02klyahjQZXr8F4GJ2uCDsx48Chmv IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38g3jac1mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 15:32:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C2CE10002A;
        Wed, 12 May 2021 15:32:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0160622560F;
        Wed, 12 May 2021 15:32:22 +0200 (CEST)
Received: from [10.211.1.115] (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May
 2021 15:32:20 +0200
Subject: Re: [PATCH 16/28] iio: dac: stm32-dac: Use
 pm_runtime_resume_and_get() to replace open coding.
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-17-jic23@kernel.org>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <78fcf796-c84a-92fe-6aad-90b65828638f@foss.st.com>
Date:   Wed, 12 May 2021 15:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210509113354.660190-17-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_06:2021-05-12,2021-05-12 signatures=0
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
> in general
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/iio/dac/stm32-dac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Hi Jonathan,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks for the patch,
Regards,
Fabrice

> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index a5b0a52bf86e..dd2e306824e7 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -69,9 +69,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	}
>  
>  	if (enable) {
> -		ret = pm_runtime_get_sync(dev);
> +		ret = pm_runtime_resume_and_get(dev);
>  		if (ret < 0) {
> -			pm_runtime_put_noidle(dev);
>  			mutex_unlock(&dac->lock);
>  			return ret;
>  		}
> 
