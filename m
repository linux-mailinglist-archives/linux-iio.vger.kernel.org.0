Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EF34C48A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC2HG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 03:06:26 -0400
Received: from www381.your-server.de ([78.46.137.84]:36858 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhC2HGT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 03:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=go7FKVgJ9/ZPz+OtwD52LLLt4SGNDzqZQ/KSBZeA42E=; b=bvMSiYb2EOVzbhpEN8D1Cd3Z59
        ZSHSEdjXc89SyhFLOYI3b2IS5AmZiO+9/VkcmfmXVp1GDaxgp0/bxK5bcDeyKb7nsVR9SQvlPOVGu
        2i90F0bAmIHKSuTbjbrUEwy549SnifHU9VxNuPJueU6OJc1QhjiV0qbrQj8G81tLy64a0vLQ9ua2P
        EcB/cMMH59feRcrg+Lu7uwSX0W4b+H7boheRxUViwalVt76jbNdb88qCosDAbSsFdOePfKwb/oIHY
        EkIx6lf6ViXijmzXYIkAZP8tQOKVuysGolL5LG5vM/ZizSXmehxGjcunQv042ufdvSxv9860jrvlA
        VgIEf5/Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lQlyZ-0009jg-Cu; Mon, 29 Mar 2021 09:06:15 +0200
Received: from [2001:a61:2aba:2d01:224:d7ff:fe9f:8154]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lQlyZ-000DR2-8N; Mon, 29 Mar 2021 09:06:15 +0200
Subject: Re: [PATCH 3/3] iio: adc: ad7923: register device with
 devm_iio_device_register
To:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Michael.Hennerich@analog.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1616966903.git.lucas.p.stankus@gmail.com>
 <b0146465d52f4e259f5f95c83c71e72f065093da.1616966903.git.lucas.p.stankus@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1548d948-bd01-a8db-6ecc-720bb7ca73a9@metafoo.de>
Date:   Mon, 29 Mar 2021 09:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b0146465d52f4e259f5f95c83c71e72f065093da.1616966903.git.lucas.p.stankus@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26123/Sun Mar 28 13:10:54 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/28/21 11:46 PM, Lucas Stankus wrote:
> Registers the device using the devm variant.
> This is the final step of converting the ad7923 to only use devm routines,
> meaning that the ad7923_remove() function is no longer needed to release
> resources on device detach.
> 
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>

Hi,

Thanks for the patches.T his looks good, just one small comment.

> ---
>   drivers/iio/adc/ad7923.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index d07eaf3111ed..f7af2f194789 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -356,16 +356,7 @@ static int ad7923_probe(struct spi_device *spi)
>   	if (ret)
>   		return ret;
>   
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int ad7923_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);

This removes the last user of get_drvdata() on the SPI device. This means you 
can also remove the spi_set_drvdata() in the probe function.

> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>   }
