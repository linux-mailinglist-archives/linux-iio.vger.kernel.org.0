Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D21333AB54
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 06:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhCOF42 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 01:56:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:56206 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOFz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 01:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=IkS7ZuA8VoKHngBBwqAzIVCXTQiYiHJGfANbczzqcLE=; b=UDczlLy35ac1fu1ljGMSRYoN2S
        +9sL9QhBPmqp5KcQYespc0HPIdXWwYCzEtJJZwEs3lsM+VWz3MdQI86iBxSEn9zXWIsOPYr8b+rJy
        cFse3+Btd5GGu6ckDf1ZFM/5AQHUVVsBTGG6u7xL0ZShajT4Bboabwm/Qt11HpfD32w2o/P/HdH+O
        mgeMW566navEw7mr6GA8szputEE+mZgDC8j6OTKSadu+dPJhQxa5c1jpLP0Fym25H5hEh4IarYQA7
        ssBSiXNT/4c7wxF+aIUee1FPhym6894dzRpAT1IAb2MnH3oQQiNlneEwjqUQcuoy7cP6Ot3si1xba
        pHTx0dVQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lLgCn-00030V-QM; Mon, 15 Mar 2021 06:55:53 +0100
Received: from [2001:a61:2aea:a901:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lLgCn-000N93-KS; Mon, 15 Mar 2021 06:55:53 +0100
Subject: Re: [PATCH v2] iio:dac:max517.c: Use devm_iio_device_register()
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        ardeleanalex@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210314093356.10609-1-dmugil2000@gmail.com>
 <20210314175709.34301-1-dmugil2000@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <707e5ff3-c38a-c0fe-e6b9-1e054cc46606@metafoo.de>
Date:   Mon, 15 Mar 2021 06:55:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314175709.34301-1-dmugil2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26108/Sun Mar 14 13:05:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/14/21 6:57 PM, Mugilraj Dhavachelvan wrote:
> Use devm_iio_device_register() to avoid remove function and
> drop explicit call to iio_device_unregister().
>
> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
>
> changes v1->v2:
> 	-As sugested by Alexandru removed i2c_set_clientdata() because the stored
> 	 data will be never used.

Hi,

This looks good!

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

One thing process wise. I know it is tempting to send version 2 as a 
reply to version 1, but this way it is also easy for the messages to get 
lost in longer threads. At least for the IIO mailinglist we have decided 
that it is best to send new versions of a patch series as their own 
threads so that they stand own and get noticed.

- Lars

> ---
>   drivers/iio/dac/max517.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 7e01838ef4d0..00f0062a0298 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -153,7 +153,6 @@ static int max517_probe(struct i2c_client *client,
>   	if (!indio_dev)
>   		return -ENOMEM;
>   	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
>   	data->client = client;
>   
>   	/* establish that the iio_dev is a child of the i2c device */
> @@ -189,13 +188,7 @@ static int max517_probe(struct i2c_client *client,
>   			data->vref_mv[chan] = platform_data->vref_mv[chan];
>   	}
>   
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int max517_remove(struct i2c_client *client)
> -{
> -	iio_device_unregister(i2c_get_clientdata(client));
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>   }
>   
>   static const struct i2c_device_id max517_id[] = {
> @@ -214,7 +207,6 @@ static struct i2c_driver max517_driver = {
>   		.pm	= &max517_pm_ops,
>   	},
>   	.probe		= max517_probe,
> -	.remove		= max517_remove,
>   	.id_table	= max517_id,
>   };
>   module_i2c_driver(max517_driver);


