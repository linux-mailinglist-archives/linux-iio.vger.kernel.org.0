Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470D353022
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhDBUKm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:10:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3327 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUKm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:10:42 -0400
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FBrgR5bFmz14BpQ;
        Sat,  3 Apr 2021 04:07:15 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme710-chm.china.huawei.com (10.1.199.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:10:38 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:10:38 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce
 boilerplate
Thread-Topic: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce
 boilerplate
Thread-Index: AQHXJ/CwG35VktMgKE2wXpk9Ze8O56qhpe3A
Date:   Fri, 2 Apr 2021 20:10:38 +0000
Message-ID: <339f74d2c0f64516b697b17aa306d20e@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-2-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-2-jic23@kernel.org>
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
> <jonathan.cameron@huawei.com>; Lars-Peter Clausen <lars@metafoo.de>
> Subject: [PATCH 1/7] iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce
> boilerplate
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As iio_poll_trigger() is safe against spurious interrupts when the
> trigger is not enabled, this is not a fix despite looking like
> a race.  It is nice to simplify the code however so the interrupt
> is never enabled in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

BTW, +Cc Tiantao as Tao might be moving drivers to
use IRQF_NO_AUTOEN.


>  drivers/iio/adc/ad7766.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 829a3426f235..1e41759f3ee5 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -255,18 +255,17 @@ static int ad7766_probe(struct spi_device *spi)
>  		ad7766->trig->ops = &ad7766_trigger_ops;
>  		iio_trigger_set_drvdata(ad7766->trig, ad7766);
> 
> -		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> -			IRQF_TRIGGER_FALLING, dev_name(&spi->dev),
> -			ad7766->trig);
> -		if (ret < 0)
> -			return ret;
> -
>  		/*
>  		 * The device generates interrupts as long as it is powered up.
>  		 * Some platforms might not allow the option to power it down so
> -		 * disable the interrupt to avoid extra load on the system
> +		 * don't enable the interrupt to avoid extra load on the system
>  		 */
> -		disable_irq(spi->irq);
> +		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> +				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
> +				       dev_name(&spi->dev),
> +				       ad7766->trig);
> +		if (ret < 0)
> +			return ret;
> 
>  		ret = devm_iio_trigger_register(&spi->dev, ad7766->trig);
>  		if (ret)
> --
> 2.31.1

