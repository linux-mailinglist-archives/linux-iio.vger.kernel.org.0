Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5D37ABEC
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhEKQav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 12:30:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:34680 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKQau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 12:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=KIXZb4epiywN4flsC/XjGoOG6B72w2KDpvNR4EiB6fw=; b=VVmYm9LtOfw6aOZUp5JN/UcTMA
        WxMp+SnxfBcByA61sDwErE11KL1UcMLQ+C25l/zhxFA5qpjxdkeo1dV0t8/QY2q1xoK6fba8JyEey
        +oGBlxUJprmvNlJowCx/4/tzn77u3bFOJSxx2ognUl8GdUssqi3/5ELIdl4jg2roSOyb2tE8lHDZS
        T/xoHQuaepAjYwGOZU2A9aG/k3Cty1NBQ+NN96M47sy0vFwCNvEbESOUooYRpsf+6P+d2V1pwBIsQ
        X38fa4ZeCNKFZKvGQ+4E+/ZPCKBQmep4taoy6RTzXlsMcjGUtjChHgZ7CRe7tY2b6oUCjwhujCcp8
        QQh6IoZg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lgVGK-0002Jq-Hx; Tue, 11 May 2021 18:29:36 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lgVGK-000GBH-A5; Tue, 11 May 2021 18:29:36 +0200
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix the right interrupt interface
 calls
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210511153108.14816-1-tangbin@cmss.chinamobile.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e923eaea-bd62-2395-5c71-92eb9d849fd5@metafoo.de>
Date:   Tue, 11 May 2021 18:29:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511153108.14816-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26167/Tue May 11 13:12:12 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/11/21 5:31 PM, Tang Bin wrote:
> In the function ad7768_probe(), the devm_request_irq() should
> call ad7768_interrupt, not &ad7768_interrupt, so fix this mistake.
>
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Hi,

Thanks for the patch. Aren't those two expressions equivalent? Are you 
seeing an issue with the current code? If so can you include that in the 
commit message?

- Lars


> ---
>   drivers/iio/adc/ad7768-1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 0e93b0766..9c9ab56d6 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -605,7 +605,7 @@ static int ad7768_probe(struct spi_device *spi)
>   	init_completion(&st->completion);
>   
>   	ret = devm_request_irq(&spi->dev, spi->irq,
> -			       &ad7768_interrupt,
> +			       ad7768_interrupt,
>   			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>   			       indio_dev->name, indio_dev);
>   	if (ret)


