Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068A1AB7F3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 08:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407867AbgDPG0w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 02:26:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:50540 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407774AbgDPG0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 02:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g7Vi2/Hb9U0pCoO0gaAbAqRZVAlk6m1vSaGchp2ohlg=; b=LK4ebbDCkXX7MaIt9QBxINRgzo
        H7pcr0u7SGyf1iU1JpONUKf7VlmabyIqAHgJ61lIdaGQWS0/bFzTfIqpQpd/t7musWK7OC+T6rdRH
        /G+a4vP16iCVNQbmPCiMAC4cAm9m/FhPCWXJVoVT3pOdUn0VWg3AEGWZib9gW40ejPX4f5Z52guAh
        YzLdLpzG9klokaVfNLrVV9abiIAq7FDt4hkzR0Lf1y8KMcnTjwOfoy75771lgaQxKjU/JTfO00e8L
        Fg6pHzy0ZxYs4WveuKJxNjGuTCi+LDp7/pWVuQim5kY9iShUCV3jgqLHQGECaTIhZqE0mMG45Zm4i
        urzqQY9w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jOxyv-0001c5-Qz; Thu, 16 Apr 2020 08:26:38 +0200
Received: from [82.135.73.197] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jOxyv-000Q4G-FE; Thu, 16 Apr 2020 08:26:37 +0200
Subject: Re: [PATCH 2/3] iio: adc: ti-ads8344: remove tx_buf from driver data
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
 <20200415212257.161238-3-alexandre.belloni@bootlin.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3b3adb8b-24a0-acb8-7b03-d905733319d5@metafoo.de>
Date:   Thu, 16 Apr 2020 08:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415212257.161238-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25783/Wed Apr 15 14:03:13 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/15/20 11:22 PM, Alexandre Belloni wrote:
> There is no need to keep tx_buf around, it is only used for the conversion.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/iio/adc/ti-ads8344.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 6da50ea35217..9b2d3a8ea6bd 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -22,13 +22,7 @@
>   struct ads8344 {
>   	struct spi_device *spi;
>   	struct regulator *reg;
> -	/*
> -	 * Lock protecting access to adc->tx_buff and rx_buff,
> -	 * especially from concurrent read on sysfs file.
> -	 */
> -	struct mutex lock;
> -
> -	u8 tx_buf ____cacheline_aligned;
> +	struct mutex lock; /* protect from concurrent conversions */
>   };
>   
>   #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
> @@ -77,13 +71,13 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>   	int ret;
>   	u8 buf[3];

spi_write() might use the buffer in a DMA transfer, so it can't be on 
the stack and needs to be in its own cacheline.

>   
> -	adc->tx_buf = ADS8344_START;
> +	buf[0] = ADS8344_START;
>   	if (!differential)
> -		adc->tx_buf |= ADS8344_SINGLE_END;
> -	adc->tx_buf |= ADS8344_CHANNEL(channel);
> -	adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
> +		buf[0] |= ADS8344_SINGLE_END;
> +	buf[0] |= ADS8344_CHANNEL(channel);
> +	buf[0] |= ADS8344_CLOCK_INTERNAL;
>   
> -	ret = spi_write(spi, &adc->tx_buf, 1);
> +	ret = spi_write(spi, buf, 1);
>   	if (ret)
>   		return ret;
>   


