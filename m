Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D6380468
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhENHhV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 03:37:21 -0400
Received: from www381.your-server.de ([78.46.137.84]:45848 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhENHhT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 03:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PWTmH56HY36qKMzCnSYGCgSGgKhWjIRrgfj8aQWb0qs=; b=N/v3irlWROUoBoZFePCB9SyUS5
        E17ewZyDf9n3SQ/iP1WRxXHcYwb+AvW0O4ZZkKnCZ9kgLT02VsFfSDB8bFWw26ESxo2QmccZ7BtVG
        ev/dS+GgAU/jb7YJ6Ubeaa2ncbiJLfI/9BmxlTZK0NkMGWxRT/PT+rFfLEzFcOPJLeR4S7+ksQji7
        xJ0EebuygcZxGwSCc4gVkX/seWJSYZOp8VDal9aKvIwt8OfEf0RAgVkcRUzVqyRijxPCDY1Nymhtw
        FhA9AXXHjlMpNfjNuP4z/6qh7gpObSgFj7Re9MMYWHj7kLcxyLVawGBQSJ9aCDxtui8VdgJkcttsG
        YPZxNz4A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lhSMb-0002qM-KS; Fri, 14 May 2021 09:36:01 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lhSMb-000E9Z-FX; Fri, 14 May 2021 09:36:01 +0200
Subject: Re: [PATCH -next] iio: adc: ad7793: Add missing error code in
 ad7793_setup()
To:     YueHaibing <yuehaibing@huawei.com>, Michael.Hennerich@analog.com,
        jic23@kernel.org, gregkh@suse.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210514065431.4328-1-yuehaibing@huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fb7f5595-5e70-98a1-220a-935f899773c6@metafoo.de>
Date:   Fri, 14 May 2021 09:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514065431.4328-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26169/Thu May 13 13:04:54 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/14/21 8:54 AM, YueHaibing wrote:
> Set error code while device ID query failed.
>
> Fixes: 88bc30548aae ("IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI ADC")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Hi,

Thanks for finding and fixing this. One small comment.


> ---
>   drivers/iio/adc/ad7793.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 5e980a06258e..b4f9ac3838e1 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -279,6 +279,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>   	id &= AD7793_ID_MASK;
>   
>   	if (id != st->chip_info->id) {
> +		ret = -EINVAL;
Usually we use ENODEV as the error code when the device ID does not match.
>   		dev_err(&st->sd.spi->dev, "device ID query failed\n");
>   		goto out;
>   	}


