Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4599542CFEE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 03:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhJNBby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 21:31:54 -0400
Received: from mx22.baidu.com ([220.181.50.185]:44984 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229496AbhJNBbx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Oct 2021 21:31:53 -0400
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id 39C2A29B1AAFB2FFB82D;
        Thu, 14 Oct 2021 09:29:36 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 14 Oct 2021 09:29:35 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Oct 2021 09:29:35 +0800
Date:   Thu, 14 Oct 2021 09:29:36 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imx8qxp-adc: mark PM functions as __maybe_unused
Message-ID: <20211014012936.GA2999@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20211013144338.2261316-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013144338.2261316-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13 10月 21 16:43:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
> are unused, producing a warning:
> 
> drivers/iio/adc/imx8qxp-adc.c:433:12: error: 'imx8qxp_adc_runtime_resume' defined but not used [-Werror=unused-function]
>   433 | static int imx8qxp_adc_runtime_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/iio/adc/imx8qxp-adc.c:419:12: error: 'imx8qxp_adc_runtime_suspend' defined but not used [-Werror=unused-function]
>   419 | static int imx8qxp_adc_runtime_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Mark them as __maybe_unused to shut up the compiler.
> 
> Fixes: 7bce634d02e6 ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Cai Huoqing <caihuoqing@baidu.com>

> ---
>  drivers/iio/adc/imx8qxp-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> index 5030e0d8318d..901dd8e1b32f 100644
> --- a/drivers/iio/adc/imx8qxp-adc.c
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int imx8qxp_adc_runtime_suspend(struct device *dev)
> +static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> @@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int imx8qxp_adc_runtime_resume(struct device *dev)
> +static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> -- 
> 2.29.2
> 
