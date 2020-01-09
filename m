Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8F13554C
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 10:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgAIJNW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 04:13:22 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41161 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728862AbgAIJNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 04:13:22 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00997oCh021592;
        Thu, 9 Jan 2020 10:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=WeMi3HpOU5AF0rGrPKqX2WxavTF7Z+TyGKSaY1oSknc=;
 b=oWnYAgf2miTJ94ASkmeXawkZn7a43R5ZQu/HUcQXoRuUmxx/jNDbbufLprF050RfmSoc
 FKcPzdnfhEYDHzhXBmrkPyh+9keWY1lWsMY4JdQLyhPnpfXPFlgTeELJnmhVTNG3D+pJ
 Pcpc8ncq2IiK5n3FCOYZgVuewJ2IoIgVUP5Fbk0qa5sy/EY4fxNxesWIfLfUJGjYXAM9
 xYiJe4UQDMYCSc0Rn5paW6LJWC6C1pyUOB/Wl9E2HsjzIbdQ/SB0H8v2I8WrCmAXFonN
 LAzniOJggG4aIcFKZN8JWhwJN6KCquIkxooO2vPVuEI44LkUXYTcptFXxRqBv7F5/jSb xA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakur0jsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 10:13:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13E74100038;
        Thu,  9 Jan 2020 10:13:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 033752A6184;
        Thu,  9 Jan 2020 10:13:04 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 10:13:03 +0100
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <jic23@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
References: <20200107114532.6697-1-peter.ujfalusi@ti.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <eade6657-8470-0d70-b3c1-fcdddf891c6c@st.com>
Date:   Thu, 9 Jan 2020 10:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107114532.6697-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-08,2020-01-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/7/20 12:45 PM, Peter Ujfalusi wrote:
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
> - Fall back to IRQ mode for ADC only in case of ENODEV

Hi Peter,

Thanks for the patch,

Please find a minor comment here after. Apart from that, you can add my:

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>


> 
> Regards,
> Peter
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index e493242c266e..74a2211bdff4 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1383,9 +1383,13 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  
> -	adc->dma_chan = dma_request_slave_channel(&indio_dev->dev, "rx");
> -	if (!adc->dma_chan)
> -		return -EINVAL;
> +	adc->dma_chan = dma_request_chan(&indio_dev->dev, "rx");
> +	if (IS_ERR(adc->dma_chan)) {
> +		int ret = PTR_ERR(adc->dma_chan);
> +
> +		adc->dma_chan = NULL;
> +		return ret;

You may "return PTR_ERR(adc->dma_chan);" directly here.

Best Regards,
Fabrice

> +	}
>  
>  	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
>  					 DFSDM_DMA_BUFFER_SIZE,
> @@ -1509,7 +1513,16 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  	init_completion(&adc->completion);
>  
>  	/* Optionally request DMA */
> -	if (stm32_dfsdm_dma_request(indio_dev)) {
> +	ret = stm32_dfsdm_dma_request(indio_dev);
> +	if (ret) {
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&indio_dev->dev,
> +					"DMA channel request failed with %d\n",
> +					ret);
> +			return ret;
> +		}
> +
>  		dev_dbg(&indio_dev->dev, "No DMA support\n");
>  		return 0;
>  	}
> 
