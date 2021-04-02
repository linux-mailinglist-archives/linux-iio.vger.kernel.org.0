Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545B9353028
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhDBUMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:12:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUMR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:12:17 -0400
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FBrjG5GD8zWCPG;
        Sat,  3 Apr 2021 04:08:50 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:12:13 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:12:13 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of
 request then disable
Thread-Topic: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of
 request then disable
Thread-Index: AQHXJ/CwzVCiYa90gUWgg8+W18Pc2aqhpxDA
Date:   Fri, 2 Apr 2021 20:12:13 +0000
Message-ID: <cad32695dac24a109b0004d613cc66db@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-4-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-4-jic23@kernel.org>
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
> <jonathan.cameron@huawei.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>
> Subject: [PATCH 3/7] iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request
> then disable
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst a race during interrupt enabling is probably not a problem,
> it is better to not enable the interrupt at all.  The new
> IRQF_NO_AUTOEN flag allows us to do that.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

>  drivers/iio/adc/nau7802.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index 07c85434b568..bb70b51d25b1 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -498,7 +498,8 @@ static int nau7802_probe(struct i2c_client *client,
>  		ret = request_threaded_irq(client->irq,
>  				NULL,
>  				nau7802_eoc_trigger,
> -				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +				IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
> +				IRQF_NO_AUTOEN,
>  				client->dev.driver->name,
>  				indio_dev);
>  		if (ret) {
> @@ -513,8 +514,7 @@ static int nau7802_probe(struct i2c_client *client,
>  			dev_info(&client->dev,
>  				"Failed to allocate IRQ, using polling mode\n");
>  			client->irq = 0;
> -		} else
> -			disable_irq(client->irq);
> +		}
>  	}
> 
>  	if (!client->irq) {
> --
> 2.31.1

