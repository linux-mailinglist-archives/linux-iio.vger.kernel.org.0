Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFB132CCA
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAGRQG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 12:16:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728262AbgAGRQG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 12:16:06 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007H3kew001693;
        Tue, 7 Jan 2020 18:15:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ZdllE0Z52H4x4guhjbA8dQk3Mh5olK1KPHIfgCgmdic=;
 b=HgavD/C6uGnl1U0aWLn+F2XXveASexh0qsxQwqzTfILkv4s7dTPS3wJ7bJWSh30iurFc
 2cyCo7fHS5bGx16UpGNPedY6X0L6KRStaBMHLLCniSkoHFCZGzKJjqc9sKRfP9fCSaFI
 9U8cwTlMur71kI2a1PmK7LvJGmkNdQdDtKnmTeYqVazThi4IQi2Fq6Zdtrf9WmoB4Yhb
 nREmzBkgQEhyqPtPtGG3T6+UX3GkP88IGE9bwJvZtxTjdXjTXpuqvCFodnVGwej8idVA
 QuGt2iF4nH1Qa4queQizpckiFbYv7wj0YKALXI4G36IDEL4EnCZtt/C0TPfI+PO76nx1 oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2xakkaqn9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 18:15:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56183100034;
        Tue,  7 Jan 2020 18:15:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 455CE21F729;
        Tue,  7 Jan 2020 18:15:50 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 18:15:49 +0100
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <jic23@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <20200107114125.6095-1-peter.ujfalusi@ti.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <5146b085-d92d-7230-9a05-87926711dafa@st.com>
Date:   Tue, 7 Jan 2020 18:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107114125.6095-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_05:2020-01-07,2020-01-07 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/7/20 12:41 PM, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi,
> 
> Changes since v1:
> - Fall back to IRQ mode only in case of ENODEV
> 
> Regards,
> Peter

Hi Peter,

Thanks for the patch,

In case you send another version... I've just a minor suggestion
regarding the comment (see after). Apart from that, you can add my:

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Best Regards,
Fabrice

> 
>  drivers/iio/adc/stm32-adc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3b291d72701c..df5f5d61f9f9 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1746,9 +1746,21 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>  	struct dma_slave_config config;
>  	int ret;
>  
> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> -	if (!adc->dma_chan)
> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	if (IS_ERR(adc->dma_chan)) {
> +		ret = PTR_ERR(adc->dma_chan);
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&indio_dev->dev,
> +					"DMA channel request failed with %d\n",
> +					ret);
> +			return ret;
> +		}
> +
> +		/* Ignore errors to fall back to IRQ mode */
		               ^
		          error
alternate suggestion:
		/* DMA is optional: fall back to IRQ mode */

> +		adc->dma_chan = NULL;
>  		return 0;
> +	}
>  
>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>  					 STM32_DMA_BUFFER_SIZE,
> 
