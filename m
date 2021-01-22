Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4D30003A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 11:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbhAVK05 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 05:26:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32504 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbhAVKZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 05:25:02 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MAGnhf017656;
        Fri, 22 Jan 2021 11:23:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=F3UYlhBVC/4pASDg25u1A1PdjtKhaE7ztzNCp+C1SLo=;
 b=8KCo4S4sWNkUsEBwP+3U7lcU73U/aDulJM7dKmb/CL+XRj7yASBkLG85vB5zww3eOIUm
 b2tYlQIiAbAvYrTtwBzw92V0Gz6qXLIiaM90jEx+mIL6Y4BAmnklU6TfbAFOakx60S30
 wqIP4TiRkz08UuAEQH5cpnxCV40UH3u37Nk6BJ4YY+0ty/tEoHKPk8gBQVF9fSNwtcOt
 yddy+eY9qWY1YSNtH7eX4VeNgRQFi6I8nS6KTWLFv7wT76f9YFwk2oUMBMdkbkxuK+lA
 Iva+m7oFmwGl0VBMThw8Vln95vBfWuOr9blFY5FAqPzSKi9xAtaVsC+GT6BWkHAKEFfL Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3668q08u2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 11:23:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51BC110002A;
        Fri, 22 Jan 2021 11:23:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 34C9D20D085;
        Fri, 22 Jan 2021 11:23:45 +0100 (CET)
Received: from [10.211.13.44] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan
 2021 11:23:43 +0100
Subject: Re: [Linux-stm32] [PATCH] iio: adc: stm32-adc: enable timestamping
 for non-DMA usage
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pengutronix.de>, Holger Assmann <has@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210121180228.30621-1-a.fatoum@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <52a8a7db-72ee-a00f-7ef5-ada85cfe4774@foss.st.com>
Date:   Fri, 22 Jan 2021 11:23:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121180228.30621-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_06:2021-01-21,2021-01-22 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/21/21 7:02 PM, Ahmad Fatoum wrote:
> For non-DMA usage, we have an easy way to associate a timestamp with a
> sample: iio_pollfunc_store_time stores a timestamp in the primary
> trigger IRQ handler and stm32_adc_trigger_handler runs in the IRQ thread
> to push out the buffer along with the timestamp.
>
> For this to work, the driver needs to register an IIO_TIMESTAMP channel.
> Do this.
>
> For DMA, it's not as easy, because we don't push the buffers out of
> stm32_adc_trigger, but out of stm32_adc_dma_buffer_done, which runs in
> a tasklet scheduled after a DMA completion.
>
> Preferably, the DMA controller would copy us the timestamp into that buffer
> as well. Until this is implemented, restrict timestamping support to
> only PIO. For low-frequency sampling, PIO is probably good enough.
>
> Cc: Holger Assmann <has@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/iio/adc/stm32-adc.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index c067c994dae2..91d9483e1f5f 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1718,7 +1718,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
> +static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>  {
>  	struct device_node *node = indio_dev->dev.of_node;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> @@ -1766,6 +1766,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	if (timestamping)
> +		num_channels++;
> +
>  	channels = devm_kcalloc(&indio_dev->dev, num_channels,
>  				sizeof(struct iio_chan_spec), GFP_KERNEL);
>  	if (!channels)
> @@ -1816,6 +1819,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  		stm32_adc_smpr_init(adc, channels[i].channel, smp);
>  	}
>  
> +	if (timestamping) {
> +		struct iio_chan_spec *timestamp = &channels[scan_index];
> +
> +		timestamp->type = IIO_TIMESTAMP;
> +		timestamp->channel = -1;
> +		timestamp->scan_index = scan_index;
> +		timestamp->scan_type.sign = 's';
> +		timestamp->scan_type.realbits = 64;
> +		timestamp->scan_type.storagebits = 64;
> +
> +		scan_index++;
> +	}
> +
>  	indio_dev->num_channels = scan_index;
>  	indio_dev->channels = channels;
>  
> @@ -1875,6 +1891,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	irqreturn_t (*handler)(int irq, void *p) = NULL;
>  	struct stm32_adc *adc;
> +	bool timestamping = false;
>  	int ret;
>  
>  	if (!pdev->dev.of_node)
> @@ -1931,16 +1948,18 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = stm32_adc_chan_of_init(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = stm32_adc_dma_request(dev, indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!adc->dma_chan)
> +	if (!adc->dma_chan) {
>  		handler = &stm32_adc_trigger_handler;

Hi Ahmad,

Just suggesting: maybe add a quick comment to indicate that timestamping
is supported in PIO mode (only), as DMA doesn't fill it into the buffer
(well described in the commit message).

> +		timestamping = true;
> +	}
> +
> +	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
> +	if (ret < 0)
> +		return ret;


DMA resources need to be freed, instead of returning directly here, in
case of error:

     goto err_dma_disable;

With that fixed, you can add my :

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,

Fabrice


>  
>  	ret = iio_triggered_buffer_setup(indio_dev,
>  					 &iio_pollfunc_store_time, handler,
