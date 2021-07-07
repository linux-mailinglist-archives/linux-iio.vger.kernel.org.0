Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F33BE43D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhGGIVk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 04:21:40 -0400
Received: from www381.your-server.de ([78.46.137.84]:58590 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGIVj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 04:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=qoi+tUBBwDf9oDC3kyQWvZF0CBishJD4LVfLdruMNzw=; b=VAWXUg9X/AH2Ut6QBZhwDbGmwH
        eBXTSbhuSkT9irMM+Z2M/hpQzwlSSXvjuP5aFdr8OHmdeNPI5LJMGAi9aJVuItJsjc+QMf8kQnMcs
        i5LU43vli0NWwLdK8r0b2AiDKpF12mJHwqrQraT8LYobHFyAB+WPDwxob48fu/6xuYr76NByRDGiT
        8hbc8DFh0GIK/abCa/La2UAfiTy8Q0kUVQ9ijeimvi7fybaPcla6ylI49Mf7WQ/ngiPDTOWC723pQ
        4hEkIJTJwv+PQRkphYZE5KMyTZOmr8PS+tvZ+Qxw0LjyAjU8G2VMhVEKlESiytHI22MraFdec5RlC
        /TqjS9ew==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1m12lm-0000NX-CE; Wed, 07 Jul 2021 10:18:58 +0200
Received: from [2001:a61:2b10:2e01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1m12lm-000WAD-5j; Wed, 07 Jul 2021 10:18:58 +0200
Subject: Re: [RESEND PATCH] iio: adis: set GPIO reset pin direction
To:     =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        linux-iio@vger.kernel.org
Cc:     Hannu Hartikainen <hannu@hrtk.in>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <71b46c95-965e-ccc3-3e87-9ec6b0e1e33e@metafoo.de>
Date:   Wed, 7 Jul 2021 10:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26223/Tue Jul  6 13:05:54 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/6/21 11:29 AM, Antti Keränen wrote:
> Use GPIOD_OUT_LOW instead of GPIOD_ASIS as the reset pin needs to be an
> active low output pin.
>
> Suggested-by: Hannu Hartikainen <hannu@hrtk.in>
> Signed-off-by: Antti Keränen <detegr@rbx.email>

Hi,

Thanks for the patch, this looks good.

How about requesting it as GPIOD_OUT_HIGH and removing the 
gpiod_set_value_cansleep(gpio, 1) to avoid unnecessary toggling of the pin.

> ---
> The documentation of GPIO consumer interface states:
>
> Be aware that there is no default direction for GPIOs. Therefore,
> **using a GPIO without setting its direction first is illegal and will
> result in undefined behavior!**
>
> Therefore the direction of the reset GPIO pin should be set as output.
>
>   drivers/iio/imu/adis.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 319b64b2fd88..7f13b3763732 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -415,7 +415,7 @@ int __adis_initial_startup(struct adis *adis)
>   	int ret;
>   
>   	/* check if the device has rst pin low */
> -	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
> +	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_OUT_LOW);
>   	if (IS_ERR(gpio))
>   		return PTR_ERR(gpio);
>   
