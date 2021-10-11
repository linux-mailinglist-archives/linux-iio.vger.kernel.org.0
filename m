Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727DF429144
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbhJKORB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 10:17:01 -0400
Received: from www381.your-server.de ([78.46.137.84]:55546 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbhJKOPA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 10:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=oXfj/LdcIWi8QBGVWoLeHpPANC5aeTpAQshDalhDSsU=; b=ABxJPME4LUvQro8a+7cOvSj2Xq
        5u7fd18VGVpoabqCh5wyIG9c72ARX2XLGj16aYcTMxEjRTX5/R7OdMVwi4u+r2LkDhJw2dwiiUEjE
        K40PyOLzNLDwNRn//96QNZFKeOCHnI1EgFz0a7WcITS4ij+Tja2Vs1+40EArHVS5nFIldUQG6fk+v
        V4dBk+Gup5aOQnHMD6SqON4DN5EDLSamO2S873iBC5YPhczFN9qqLOx9yZqEsXuS5VOYwXEtlK6GU
        e6lFPNm2NPjQ07o56AyGJEXwQAx/dcRSN1KxYP1+jsOlJtn127RwlEzt5uwR55LweVPMnASfTpgtp
        9JKsNF7Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mZw2y-0001XY-JN; Mon, 11 Oct 2021 16:12:56 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mZw2y-000IkW-DK; Mon, 11 Oct 2021 16:12:56 +0200
Subject: Re: [PATCH] iio: core: do not create debugfs when has no dev name
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     ars@metafoo.de, jic23@kernel.org, alexandru.ardelean@analog.com,
        andy.shevchenko@gmail.com
References: <20211011135654.282958-1-yangyingliang@huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2430dc94-ecf8-c246-beaf-52cc0905e3d4@metafoo.de>
Date:   Mon, 11 Oct 2021 16:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011135654.282958-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26319/Mon Oct 11 10:18:47 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/11/21 3:56 PM, Yang Yingliang wrote:
> I got a null-ptr-deref report when doing fault injection test:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP KASAN PTI
> RIP: 0010:strlen+0x0/0x20
> Call Trace:
>   start_creating+0x199/0x2f0
>   debugfs_create_dir+0x25/0x430
>   __iio_device_register+0x4da/0x1b40 [industrialio]
>   __devm_iio_device_register+0x22/0x80 [industrialio]
>   max1027_probe+0x639/0x860 [max1027]
>   spi_probe+0x183/0x210
>   really_probe+0x285/0xc30
>
> If dev_set_name() fails, the dev_name() is null, add check for
> device name before creating debugfs.

If dev_set_name() fails, shouldn't we better return an error in 
iio_device_alloc()? Otherwise the device has no name and will show up as 
<null> in sysfs.

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e553f182d55b ("staging: iio: core: Introduce debugfs support...")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/iio/industrialio-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dc837db50f7..8974490ad536 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -466,7 +466,7 @@ static void iio_device_register_debugfs(struct iio_dev *indio_dev)
>   	if (indio_dev->info->debugfs_reg_access == NULL)
>   		return;
>   
> -	if (!iio_debugfs_dentry)
> +	if (!iio_debugfs_dentry || !dev_name(&indio_dev->dev))
>   		return;
>   
>   	iio_dev_opaque = to_iio_dev_opaque(indio_dev);


