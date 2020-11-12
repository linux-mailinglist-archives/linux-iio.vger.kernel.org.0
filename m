Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A202B024E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKLJyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 04:54:37 -0500
Received: from www381.your-server.de ([78.46.137.84]:36762 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgKLJyg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 04:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=YMQMwTpaxzI06pmi27VpklODHSICBLhVazxEQ59Cm8o=; b=ajfwKlC6WnRJSBpsno0+0ZcUdk
        MwV54OGYBNrhvqy8A+wbm+i4aO+zccN+AXQ+Xo7lr//eSYhjzrTBkNhQcYydHUYF6678kUbgwmDiy
        fcMqTA5ZrIGW1Fh262PpoO/zSbburrxAlggIXJm6SAN3pCONZ+RKaaA1kwTHUhXlzgqHq1TUqJteC
        6m4tfCS/ToofC1YSfYSFrjZ3Goasj2flj6SpBynA0dVahtdgndiKGfOkcpZvsqhAsOR8HS7ivFdfD
        ZB1hvZ6CuMazbDvwdmHWHiF9+RFpUFKixs6ymQspwdA9zNv1zE1guap5EGWjq4c2qnWk3tbNpQp2G
        Fu+BMvfw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kd9JJ-0003Hw-Ja; Thu, 12 Nov 2020 10:54:33 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kd9JJ-000ATN-FP; Thu, 12 Nov 2020 10:54:33 +0100
Subject: Re: [PATCH] iio: ad_sigma_delta: Don't put SPI transfer buffer on the
 stack
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
References: <20201112091050.84991-1-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <49aea6de-9084-d5a2-a6be-967196570830@metafoo.de>
Date:   Thu, 12 Nov 2020 10:54:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112091050.84991-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25985/Wed Nov 11 14:18:01 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/12/20 10:10 AM, Alexandru Ardelean wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Use a heap allocated memory for the SPI transfer buffer. Using stack memory
> can corrupt stack memory when using DMA on some systems.
>
> This change adds 4 bytes at the end of the current DMA buffer, which will
> be used by the trigger handler.
> This is required because the first 4 bytes are reserved for register data.
>
> Fixes: af3008485ea03 ("iio:adc: Add common code for ADI Sigma Delta devices")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>   drivers/iio/adc/ad_sigma_delta.c       | 4 ++--
>   include/linux/iio/adc/ad_sigma_delta.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 86039e9ecaca..33297f26508a 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -395,11 +395,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> +	uint8_t *data = &sigma_delta->data[4];
>   	unsigned int reg_size;
>   	unsigned int data_reg;
> -	uint8_t data[16];
>   
> -	memset(data, 0x00, 16);
> +	memset(data, 0x00, 4);

Younger me didn't know what he was doing, this is wrong. We need the 
extra space for the padding and timestamp.

We also can't put the beginning of the buffer at an 4 byte offset since 
it needs to be 8 byte aligned for the timestamp.

>   
>   	reg_size = indio_dev->channels[0].scan_type.realbits +
>   			indio_dev->channels[0].scan_type.shift;
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index a3a838dcf8e4..ac4ac4752c62 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -80,7 +80,7 @@ struct ad_sigma_delta {
>   	 * DMA (thus cache coherency maintenance) requires the
>   	 * transfer buffers to live in their own cache lines.
>   	 */
> -	uint8_t				data[4] ____cacheline_aligned;
> +	uint8_t				data[8] ____cacheline_aligned;
>   };
>   
>   static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,


