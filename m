Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA502A851D
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgKERju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 12:39:50 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36910 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730805AbgKERju (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Nov 2020 12:39:50 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5HM74i017207;
        Thu, 5 Nov 2020 18:39:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=vsR5ldt560beF0b1zd/ViQ5vBMqLihhw3wpz3tsDQzE=;
 b=NgwFkJrR13eJCbOeQncy7/0EXsyN/EBNRijv6a1KwAv83uRCZAvr3jX52ikSGpQunsHo
 wCOf1TU6eey4DZzyjeqvMf+RGIxoP1JeP/qJLUOWKkd2EgI2p9lUC7GYBRWbkRpmGFSm
 QMkUcXDwExZajkjboejUENQHdp+qIMSm1z79tl48CAfRtfv4Q2rwo91k5r/yv1HTaNIQ
 mzaFDQ81/y0ZHmkzURRFSeCM2XROgWCVU+KwpANXJl9jcW0j3QxuFRAzGGh1d1Jog94J
 qOXRtONZwHKoHZc/wRBxNU68MfCN/4jxt/C19vusUyY5CLFeLgQAtgwB7AaDbO01pWXb lA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywr9fa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Nov 2020 18:39:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C5D310002A;
        Thu,  5 Nov 2020 18:39:25 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EA2602255CE;
        Thu,  5 Nov 2020 18:39:24 +0100 (CET)
Received: from [10.211.7.187] (10.75.127.44) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 18:38:28 +0100
Subject: Re: [PATCH] iio: adc: stm32-adc: dma transfers cleanup
To:     Olivier Moysan <olivier.moysan@st.com>, <jic23@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <alexandre.torgue@st.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201105142941.27301-1-olivier.moysan@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <8ed73130-57e7-4073-cdf2-5f31596e728c@st.com>
Date:   Thu, 5 Nov 2020 18:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105142941.27301-1-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_11:2020-11-05,2020-11-05 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/5/20 3:29 PM, Olivier Moysan wrote:
> - Remove processing related to DMA in irq handler as this
> data transfer is managed directly in DMA callback.
> - Update comment in stm32_adc_set_watermark() function.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>

Hi Olivier,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
> ---
>  drivers/iio/adc/stm32-adc.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index b3f31f147347..08be826f1462 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1310,7 +1310,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	 * dma cyclic transfers are used, buffer is split into two periods.
>  	 * There should be :
>  	 * - always one buffer (period) dma is working on
> -	 * - one buffer (period) driver can push with iio_trigger_poll().
> +	 * - one buffer (period) driver can push data.
>  	 */
>  	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
>  	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
> @@ -1573,31 +1573,14 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
>  
>  	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
>  
> -	if (!adc->dma_chan) {
> -		/* reset buffer index */
> -		adc->bufi = 0;
> -		iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> -						   pf->timestamp);
> -	} else {
> -		int residue = stm32_adc_dma_residue(adc);
> -
> -		while (residue >= indio_dev->scan_bytes) {
> -			u16 *buffer = (u16 *)&adc->rx_buf[adc->bufi];
> -
> -			iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -							   pf->timestamp);
> -			residue -= indio_dev->scan_bytes;
> -			adc->bufi += indio_dev->scan_bytes;
> -			if (adc->bufi >= adc->rx_buf_sz)
> -				adc->bufi = 0;
> -		}
> -	}
> -
> +	/* reset buffer index */
> +	adc->bufi = 0;
> +	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> +					   pf->timestamp);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	/* re-enable eoc irq */
> -	if (!adc->dma_chan)
> -		stm32_adc_conv_irq_enable(adc);
> +	stm32_adc_conv_irq_enable(adc);
>  
>  	return IRQ_HANDLED;
>  }
> 
