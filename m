Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3213DD38C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBKR2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 2 Aug 2021 06:17:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3546 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBKR2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:17:28 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdYpF5Ldcz6B9ml;
        Mon,  2 Aug 2021 18:17:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 12:17:16 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 11:17:15 +0100
Date:   Mon, 2 Aug 2021 11:16:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     tangbin <tangbin@cmss.chinamobile.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: fix the right check and
 simplify code
Message-ID: <20210802111647.000012ee@Huawei.com>
In-Reply-To: <b84ea3e4-5650-d6ac-36f6-98067b286b45@cmss.chinamobile.com>
References: <20210727125209.28248-1-tangbin@cmss.chinamobile.com>
        <20210731174551.188aee79@jic23-huawei>
        <b84ea3e4-5650-d6ac-36f6-98067b286b45@cmss.chinamobile.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Aug 2021 10:31:58 +0800
tangbin <tangbin@cmss.chinamobile.com> wrote:

> Hi Jonathan:
> 
> On 2021/8/1 0:45, Jonathan Cameron wrote:
> > On Tue, 27 Jul 2021 20:52:09 +0800
> > Tang Bin <tangbin@cmss.chinamobile.com> wrote:
> >  
> >> For the function of platform_get_irq(), the example in platform.c is
> >> *		int irq = platform_get_irq(pdev, 0);
> >> *		if (irq < 0)
> >> *			return irq;
> >> So the return value of zero is unnecessary to check. And move it
> >> up to a little bit can simplify the code jump.
> >>
> >> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> >> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> >> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>  
> > Hi,
> >
> > Logically it is better to keep the irq handling all together, so
> > I would prefer we didn't move it.  
> Got it in this place.
> >
> > Also, platform_get_irq() is documented as never returning 0, so the current
> > code is not incorrect.  As such, this looks like noise unless there is
> > some plan to make use of the 0 return value?  What benefit do we get from
> > this change?  
> 
> Thanks for your reply, I think the benefit of this change maybe just 
> simplify the code.
> 
> Because the return value is never equal to 0, so the check in here is 
> redundant.
> 
> We can make the patch like this:
> 
> >> ---
> >>   drivers/iio/adc/fsl-imx25-gcq.c | 12 ++++--------
> >>   1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> >> index 8cb51cf7a..d28976f21 100644
> >> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> >> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> >> @@ -320,6 +320,10 @@ static int mx25_gcq_probe(struct platform_device *pdev)
> >>   	if (ret)
> >>   		return ret;
> >>   
> >> +	priv->irq = platform_get_irq(pdev, 0);
> >> +	if (priv->irq < 0)
> >> +		return priv->irq;
> >> +
> >>   	for (i = 0; i != 4; ++i) {
> >>   		if (!priv->vref[i])
> >>   			continue;
> >> @@ -336,14 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
> >>   		goto err_vref_disable;
> >>   	}
> >>   
> >> -	priv->irq = platform_get_irq(pdev, 0);
> >> -	if (priv->irq <= 0) {
> >> -		ret = priv->irq;
> >> -		if (!ret)
> >> -			ret = -ENXIO;
> >> -		goto err_clk_unprepare;
> >> -	}
> >> -  
> 
> 	priv->irq = platform_get_irq(pdev, 0);
> 	if (priv->irq < 0) {
> 		ret = priv->irq;
> 		goto err_clk_unprepare;
> 	}
> 
>      If you think this is ok, I will send V2 for you. If you think these 
> change is meaningless,

OK, it's a minor tidy up, so lets go with that, or perhaps this is even tidier?
Assuming types of ret and irq are appropriate (I've not checked!)


	ret = platform_get_irq(pdev, 0);
	if (ret)
		goto err_clk_unprepare;

	priv->irq = ret;


> 
> just dropped this.
> 
> Thanks
> 
> Tang Bin
> 
> 
> 
> 

