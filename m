Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7007E37F3A3
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEMHnA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 03:43:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:40950 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhEMHmX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 03:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=el2eGxu5J0rMqoH1qZy0H2WURI5gij0pZVf3VsWO9YI=; b=huDkE0W3olgD2G/bQZDjk635Co
        9QOSiHapIkwngBIxo2hdHwvCngp1iVIr+J1HjPStx7ewPyiT3qmxMTb9Ct+y30uKiNUE4A63OQ1i1
        8TiUpSg1Y7uo4Ysk4vodwZL+ZojSUwaTFcOXnrT6Pk6dKuoZFdHykyJdijl6UTiGUX/rsOZ15SiZ6
        fBIuwUg7gSL+CM1bYeFOpixo++w/skixN6/rzrE4yqhPriiVrlcIRYytmlQ0+j4pGX6cTKfMSd/Yt
        5A5Dq2QGAfNTmFVu8ocUdHQVZ4mRg82YckJo2iWIv+wIffdynr3ORqv3XchSDQciaqYj5Diqb1SFV
        1bd5Dhag==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lh5y3-000D8q-5g; Thu, 13 May 2021 09:41:11 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lh5y2-000GQV-Qb; Thu, 13 May 2021 09:41:10 +0200
Subject: Re: [PATCH v3 04/12] iio: adc: ad7192: handle zero Avdd regulator
 value
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com
References: <20210512174914.10549-1-aardelean@deviqon.com>
 <20210512174914.10549-5-aardelean@deviqon.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <46a03414-0ead-46a1-f0fe-20f1c22a70b5@metafoo.de>
Date:   Thu, 13 May 2021 09:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210512174914.10549-5-aardelean@deviqon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26168/Wed May 12 13:07:33 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/12/21 7:49 PM, Alexandru Ardelean wrote:
> This change fixes a corner-case, where for a zero regulator value, the
> driver would exit early, initializing the driver only partially.
> The driver would be in an unknown state.
>
> If the regulator value is zero, then the internal reference will be zero
> (though that value will be zero for anything less than 1 millivolt).
>
> Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> ---
>   drivers/iio/adc/ad7192.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d3be67aa0522..9da394ad3868 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -951,7 +951,7 @@ static int ad7192_probe(struct spi_device *spi)
>   
>   	voltage_uv = regulator_get_voltage(st->avdd);
>   
> -	if (voltage_uv > 0) {
> +	if (voltage_uv >= 0) {
>   		st->int_vref_mv = voltage_uv / 1000;
>   	} else {
>   		ret = voltage_uv;

More idiomatic would be to check for voltage_uv < 0.

     if (voltage_uv < 0) {
         ret = voltage_uv;
         dev_err(&spi->dev, "Device tree error, reference voltage 
undefined\n");
         goto error_disable_avdd;
     }

     st->int_vref_mv = voltage_uv / 1000;

