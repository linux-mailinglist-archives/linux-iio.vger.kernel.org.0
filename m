Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7D26CAD5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIPUPr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 16:15:47 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42012 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727167AbgIPRbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:31:04 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GBhSp1016396;
        Wed, 16 Sep 2020 13:43:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=FE2nDTAv+JDtwnTgqT9lmJ23Dlw6u2h28rI8qGiC8eA=;
 b=0JMkt+X6hSq5eyOmTlt6qSszqkSKHir9kkhUpVC8VsHmu9cacFKA5GYNWhNNTlRJ4NO/
 IxTzi7PqAK127kreoR5ban1a7iisplIV5NLr6BCJ4L3r1VSfLpIopnWFaq7tgpbV1RQf
 q8OEDLGNl70pYMiGhbY4B9wmL9ehyU7lYBZ7w3pyuUPOmh0Q31w8ActzENcfyoHc2uEQ
 /m2/0ksH8fAzBb1MH/eCVmmq047TvXQZ+rsftbjtLznCJTIWvyqit8W+V3bvmgCSSBXy
 MzwzvKd2G9l487+I5xfX7q6DkqiNykwp0+b61uRe0OtKdg1De+0wo/UAHMX49/v4j2wj zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33k691bpdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 13:43:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55C68100143;
        Wed, 16 Sep 2020 12:18:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C1E8212FB3;
        Wed, 16 Sep 2020 12:18:04 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 12:18:03 +0200
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
 <20200916092349.75647-1-alexandru.ardelean@analog.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b8d5cbb5-f393-6a5f-19cd-afa983b9f10a@st.com>
Date:   Wed, 16 Sep 2020 12:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200916092349.75647-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_06:2020-09-16,2020-09-16 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/16/20 11:23 AM, Alexandru Ardelean wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock. The lock protects against potential races when
> reading the CR reg and then updating, so that the state of pm_runtime
> is consistent between the two operations.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dac/stm32-dac.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Hi Alexandru,

Many thanks for this updated patch,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Best regards,
Fabrice

> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 092c796fa3d9..12dec68c16f7 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -26,9 +26,12 @@
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:		reference to DAC common data
> + * @lock:		lock to protect against potential races when reading
> + *			and update CR, to keep it in sync with pm_runtime
>   */
>  struct stm32_dac {
>  	struct stm32_dac_common *common;
> +	struct mutex		lock;
>  };
>  
>  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> @@ -58,10 +61,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	int ret;
>  
>  	/* already enabled / disabled ? */
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&dac->lock);
>  	ret = stm32_dac_is_enabled(indio_dev, ch);
>  	if (ret < 0 || enable == !!ret) {
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&dac->lock);
>  		return ret < 0 ? ret : 0;
>  	}
>  
> @@ -69,13 +72,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  		ret = pm_runtime_get_sync(dev);
>  		if (ret < 0) {
>  			pm_runtime_put_noidle(dev);
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&dac->lock);
>  			return ret;
>  		}
>  	}
>  
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&dac->lock);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "%s failed\n", en ?
>  			"Enable" : "Disable");
> @@ -327,6 +330,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	indio_dev->info = &stm32_dac_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	mutex_init(&dac->lock);
> +
>  	ret = stm32_dac_chan_of_init(indio_dev);
>  	if (ret < 0)
>  		return ret;
> 
