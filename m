Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2D35302B
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBUNE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:13:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3512 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:13:04 -0400
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FBrlq47pMzRXlJ;
        Sat,  3 Apr 2021 04:11:03 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:13:00 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:13:00 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag
 instead of request then disable
Thread-Topic: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag
 instead of request then disable
Thread-Index: AQHXJ/C0lObC1AHNxkyKwTICC2pr8qqhp0mg
Date:   Fri, 2 Apr 2021 20:13:00 +0000
Message-ID: <7df210b8251c4c118e6c0b9fe6505b61@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-5-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-5-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, April 3, 2021 7:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Maxime Ripard <maxime.ripard@bootlin.com>
> Subject: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead
> of request then disable
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new flag ensures a requested irq is not autoenabled, thus removing
> the need for the disable_irq() that follows and closing off any chance
> of spurious interrupts.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

>  drivers/iio/adc/sun4i-gpadc-iio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c
> b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 99b43f28e879..2d393a4dfff6 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -470,7 +470,8 @@ static int sun4i_irq_init(struct platform_device *pdev,
> const char *name,
>  	}
> 
>  	*irq = ret;
> -	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
> +	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler,
> +					   IRQF_NO_AUTOEN,
>  					   devname, info);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
> @@ -478,7 +479,6 @@ static int sun4i_irq_init(struct platform_device *pdev,
> const char *name,
>  		return ret;
>  	}
> 
> -	disable_irq(*irq);
>  	atomic_set(atomic, 0);
> 
>  	return 0;
> --
> 2.31.1

