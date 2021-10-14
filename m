Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9350342E029
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 19:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhJNRmx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 14 Oct 2021 13:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232779AbhJNRmw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Oct 2021 13:42:52 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3A361037;
        Thu, 14 Oct 2021 17:40:43 +0000 (UTC)
Date:   Thu, 14 Oct 2021 18:44:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imx8qxp-adc: mark PM functions as __maybe_unused
Message-ID: <20211014184448.474849a9@jic23-huawei>
In-Reply-To: <50f71530-bab0-58f4-cf90-a7c1b60b9716@infradead.org>
References: <20211013144338.2261316-1-arnd@kernel.org>
        <20211014012936.GA2999@LAPTOP-UKSR4ENP.internal.baidu.com>
        <50f71530-bab0-58f4-cf90-a7c1b60b9716@infradead.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 13 Oct 2021 18:40:41 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/13/21 6:29 PM, Cai Huoqing wrote:
> > On 13 10月 21 16:43:26, Arnd Bergmann wrote:  
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Without CONFIG_PM_SLEEP, the runtime suspend/resume functions
> >> are unused, producing a warning:
> >>
> >> drivers/iio/adc/imx8qxp-adc.c:433:12: error: 'imx8qxp_adc_runtime_resume' defined but not used [-Werror=unused-function]
> >>    433 | static int imx8qxp_adc_runtime_resume(struct device *dev)
> >>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/iio/adc/imx8qxp-adc.c:419:12: error: 'imx8qxp_adc_runtime_suspend' defined but not used [-Werror=unused-function]
> >>    419 | static int imx8qxp_adc_runtime_suspend(struct device *dev)
> >>        |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> Mark them as __maybe_unused to shut up the compiler.
> >>
> >> Fixes: 7bce634d02e6 ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> > 
> > Reviewed-by: Cai Huoqing <caihuoqing@baidu.com>  
> 
> Looks the same as
> https://lore.kernel.org/all/20211013014658.2798-1-caihuoqing@baidu.com/
> 
> but that one is mixing the Fixes: tag.

Given Cai replied to this one and the presence of the fixes tag + my inherent
laziness, applied this one to the togreg branch of iio.git. I'll push that
out as testing to let 0-day poke it before pushing it out for next to pick up
in a day or 2.

Thanks,

Jonathan

> 
> >> ---
> >>   drivers/iio/adc/imx8qxp-adc.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> >> index 5030e0d8318d..901dd8e1b32f 100644
> >> --- a/drivers/iio/adc/imx8qxp-adc.c
> >> +++ b/drivers/iio/adc/imx8qxp-adc.c
> >> @@ -416,7 +416,7 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
> >>   	return 0;
> >>   }
> >>   
> >> -static int imx8qxp_adc_runtime_suspend(struct device *dev)
> >> +static __maybe_unused int imx8qxp_adc_runtime_suspend(struct device *dev)
> >>   {
> >>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> >> @@ -430,7 +430,7 @@ static int imx8qxp_adc_runtime_suspend(struct device *dev)
> >>   	return 0;
> >>   }
> >>   
> >> -static int imx8qxp_adc_runtime_resume(struct device *dev)
> >> +static __maybe_unused int imx8qxp_adc_runtime_resume(struct device *dev)
> >>   {
> >>   	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >>   	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> >> --   
> 
> 
> 
> 

