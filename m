Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E631AB808
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 08:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407956AbgDPGaA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 02:30:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:52766 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408089AbgDPG3z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 02:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QybabIqwohpn9O1FnmFltvFDw7aWCHKglwxAyd7SJUw=; b=HGrs7bHQSBbDWCz6DsIrljIdJa
        vEPWCh6HEgse/2C05pjWRKgMAJGKXwOU3fVtqfxEPXItWKy4VZsUsEuETsg3OjhCLr4ne8KY0F+4N
        Wzdo2jQUSQoBZjCFW/zLi4tqQMBKGyHvKqTeAODeflhOmcj5IIC5Ci4EBJt2PAYLeBRNkk3ec1DO0
        48JhZO75uuIhFSH332kRrf9QGS0+hUumM8OaAXnn1sdUNo56qQpjF5LUHUlBrIsZ4ZHP5P6CCAa1W
        C6OJ6R3O1RoPg23c38FP6Wgas1+0KQWkcV04aCkN1WC4U0kSFz5anwz+hHpzcifqO7kChwVdlouQB
        +WuPf19A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jOy20-0001pb-Jb; Thu, 16 Apr 2020 08:29:48 +0200
Received: from [82.135.73.197] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jOy20-0002EA-B3; Thu, 16 Apr 2020 08:29:48 +0200
Subject: Re: [PATCH 1/3] iio: adc: ti-ads8344: properly byte swap value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200415212257.161238-1-alexandre.belloni@bootlin.com>
 <20200415212257.161238-2-alexandre.belloni@bootlin.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <696223d6-3804-0d22-7564-37161feca869@metafoo.de>
Date:   Thu, 16 Apr 2020 08:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415212257.161238-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25783/Wed Apr 15 14:03:13 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/15/20 11:22 PM, Alexandre Belloni wrote:
> The first received byte is the MSB, followed by the LSB so the value needs
> to be byte swapped.
>
> Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> bytes to get the last bit.
>
> Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/iio/adc/ti-ads8344.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 9a460807d46d..6da50ea35217 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -29,7 +29,6 @@ struct ads8344 {
>   	struct mutex lock;
>   
>   	u8 tx_buf ____cacheline_aligned;
> -	u16 rx_buf;
>   };
>   
>   #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
> @@ -76,6 +75,7 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>   {
>   	struct spi_device *spi = adc->spi;
>   	int ret;
> +	u8 buf[3];
Same as with spi_write(), spi_read() transfer buffers should not be on 
the stack in case the driver tries to use it for DMA.
>   
>   	adc->tx_buf = ADS8344_START;
>   	if (!differential)
> @@ -89,11 +89,11 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>   
>   	udelay(9);
>   
> -	ret = spi_read(spi, &adc->rx_buf, 2);
> +	ret = spi_read(spi, buf, sizeof(buf));
>   	if (ret)
>   		return ret;
>   
> -	return adc->rx_buf;
> +	return buf[0] << 9 | buf[1] << 1 | buf[2] >> 7;
>   }
>   
>   static int ads8344_read_raw(struct iio_dev *iio,


