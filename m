Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB72252997
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgHZI5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 04:57:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35356 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727798AbgHZI5d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 04:57:33 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q8uxk8013542;
        Wed, 26 Aug 2020 10:57:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=nfnzZRDCN46NnRol+LMu+aCQr7PtIZM6+ud79PtgOvE=;
 b=0RLwk4OtEiJSTlh+zVA4Y8TG4jTUXDYAYEG2q+wUoaotWfyREEf0g+nJEFpVlbwCg2Hc
 sHrLpRGW5GRr+/LtewwQLS3KtJ7zu10mVx3/cmalv0gwIsL8fpD04lOpXzY6n+38uhYG
 pS5fqhfzE2onG4uwGCr18yaAdkKAqsW1qNbMFvrrlm0xc6a09eFxu9MNn7bHAUxP0CXC
 U2mVhZ6GUKQkKnAg0JkUEMhJHoGA+Zm7BnDJZzsN21B4wui4b6S2mldg4GUJQ+77P6S7
 3RDrGigrtRbQDp+nB8OLukZS95lv9OV1WOyK2c2R01t3Gh+VCvKDcgBlcB5tsXlqvyPC fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8ft355-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 10:57:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 24E4310002A;
        Wed, 26 Aug 2020 10:57:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E39A21CA7D;
        Wed, 26 Aug 2020 10:57:17 +0200 (CEST)
Received: from [10.211.2.168] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Aug
 2020 10:57:15 +0200
Subject: Re: [PATCH] iio: stm32-dac: Replace indio_dev->mlock with own device
 lock
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jic23@kernel.org>, <alexandre.torgue@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <1c32f6b5-deb6-e310-4bc4-a871719cc8f3@st.com>
Date:   Wed, 26 Aug 2020 10:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826063850.47625-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_06:2020-08-25,2020-08-26 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/26/20 8:38 AM, Alexandru Ardelean wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> The patch also does a minor whitespace change to align the 'lock' with the
> 'common' field via tabs.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dac/stm32-dac.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index 092c796fa3d9..fc636812c17e 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -26,9 +26,11 @@
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:		reference to DAC common data
> + * @lock:		lock to protect the data buffer during regmap ops

Hi Alexandru,

I think the same patch has been sent by Sergiu already [1].
Jonathan and I had a minor comment at that time: E.g. could you please
update the comment ?

[1] https://lkml.org/lkml/2020/5/18/254

>   */
>  struct stm32_dac {
> -	struct stm32_dac_common *common;
> +	struct stm32_dac_common	*common;

Is above change needed?

Best Regards,
Fabrice

> +	struct mutex		lock;
>  };
>  
>  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> @@ -58,10 +60,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
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
> @@ -69,13 +71,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
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
> @@ -327,6 +329,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	indio_dev->info = &stm32_dac_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	mutex_init(&dac->lock);
> +
>  	ret = stm32_dac_chan_of_init(indio_dev);
>  	if (ret < 0)
>  		return ret;
> 
