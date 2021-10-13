Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB242B43A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 06:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhJMEdS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 00:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJMEdQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 00:33:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478ECC061746;
        Tue, 12 Oct 2021 21:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=P4OeZjPq6pl0dzHErks1QX3HFdD5jgl9QICOpRRuaIo=; b=HVBXOCPi40PrlitUMF5nPp4Qls
        ue9WnTbfFrlcfX3uxFnj17y8HFN4RqO9cjMviuAUfhH8KHfoPppqM7fSJWJEg4g97VsSAwD9pEn4G
        jy269FYbzjRogv1QWSd8T3wvEUbG7XBKZE1EVmEymo6FABkHPxcjL042G+P/VFA7OW06AYcXzR436
        CYd8PqDJi4/dqrsnD1MVnuvxrqUpJkuMuLTTHNqpzJXk/kxISRGuA4RHDrgH4ey04aRr6sYFv98Nb
        0QNdHld0RtLtjpV9bXj6Kib7Vlbi//VJ1y3kzGT23uUT7QFDdlGGv6kJHY7bsmCTyfC39AQ8R/P/P
        MgA4Q3hg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maVv2-00EpHw-Ru; Wed, 13 Oct 2021 04:31:08 +0000
Subject: Re: [PATCH] iio: imx8qxp-adc: Fix the error - defined but not used
 for runtime pm API
To:     Cai Huoqing <caihuoqing@baidu.com>, jic23@kernel.org,
        lars@metafoo.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211013014658.2798-1-caihuoqing@baidu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <41381e8c-78f2-67ee-5ed0-dcf176f65da1@infradead.org>
Date:   Tue, 12 Oct 2021 21:31:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013014658.2798-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/12/21 6:46 PM, Cai Huoqing wrote:
> Add the prefix '__maybe_unused' to imx8qxp_adc_runtime_suspend/resume()
> to avoid the compiler complain without setting CONFIG_SUSPEND,
> CONFIG_HIBERNATION and CONFIG_PM.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>   drivers/iio/adc/imx8qxp-adc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> index 5030e0d8318d..011bef4b5dda 100644
> --- a/drivers/iio/adc/imx8qxp-adc.c
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int imx8qxp_adc_runtime_suspend(struct device *dev)
> +static int __maybe_unused imx8qxp_adc_runtime_suspend(struct device *dev)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> @@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int imx8qxp_adc_runtime_resume(struct device *dev)
> +static int __maybe_unused imx8qxp_adc_runtime_resume(struct device *dev)
>   {
>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> 


-- 
~Randy
