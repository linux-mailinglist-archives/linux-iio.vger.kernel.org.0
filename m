Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454BB353059
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBUhm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 2 Apr 2021 16:37:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3068 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBUhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 16:37:42 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FBsGZ3tT9zWSgj;
        Sat,  3 Apr 2021 04:34:14 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 3 Apr 2021 04:37:37 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Sat, 3 Apr 2021 04:37:37 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq
 request then disable
Thread-Topic: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq
 request then disable
Thread-Index: AQHXJ/C2KFXGa5INrk6vvD00lTP3FKqhrWwg
Date:   Fri, 2 Apr 2021 20:37:37 +0000
Message-ID: <a733aa9b11684bb990f0bc6a50b101e5@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
 <20210402184544.488862-7-jic23@kernel.org>
In-Reply-To: <20210402184544.488862-7-jic23@kernel.org>
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
> <jonathan.cameron@huawei.com>; Alexandru Ardelean <ardeleanalex@gmail.com>;
> Nuno Sa <Nuno.Sa@analog.com>
> Subject: [PATCH 6/7] iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request
> then disable
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is a bit involved as the adis library code already has some
> sanity checking of the flags of the requested irq that we need
> to ensure is happy to pass through the IRQF_NO_AUTOEN flag untouched.
> 
> Using this flag avoids us autoenabling the irq in the adis16460 and
> adis16475 drivers which cover parts that don't have any means of
> masking the interrupt on the device end.
> 
> Note, compile tested only!
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> Cc: Nuno Sa <Nuno.Sa@analog.com>
> ---
>  drivers/iio/imu/adis16460.c    |  4 ++--
>  drivers/iio/imu/adis16475.c    |  5 +++--
>  drivers/iio/imu/adis_trigger.c | 11 ++++++-----
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 74a161e39733..73bf45e859b8 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -403,12 +403,12 @@ static int adis16460_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> 
> +	/* We cannot mask the interrupt, so ensure it isn't auto enabled */
> +	st->adis.irq_flag |= IRQF_NO_AUTOEN;
>  	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;
> 
> -	adis16460_enable_irq(&st->adis, 0);
> -
>  	ret = __adis_initial_startup(&st->adis);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 8f6bea4b6608..1de62fc79e0f 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1258,6 +1258,9 @@ static int adis16475_config_irq_pin(struct adis16475 *st)
>  		return -EINVAL;
>  	}
> 
> +	/* We cannot mask the interrupt so ensure it's not enabled at request */
> +	st->adis.irq_flag |= IRQF_NO_AUTOEN;
> +
>  	val = ADIS16475_MSG_CTRL_DR_POL(polarity);
>  	ret = __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
>  				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> @@ -1362,8 +1365,6 @@ static int adis16475_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> 
> -	adis16475_enable_irq(&st->adis, false);
> -
>  	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index 0f29e56200af..39b50d6fdb6a 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -29,18 +29,19 @@ static const struct iio_trigger_ops adis_trigger_ops = {
> 
>  static int adis_validate_irq_flag(struct adis *adis)
>  {
> +	unsigned long direction = adis->irq_flag & IRQF_TRIGGER_MASK;
>  	/*
>  	 * Typically this devices have data ready either on the rising edge or
>  	 * on the falling edge of the data ready pin. This checks enforces that
>  	 * one of those is set in the drivers... It defaults to
> -	 * IRQF_TRIGGER_RISING for backward compatibility wiht devices that
> +	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
>  	 * don't support changing the pin polarity.
>  	 */
> -	if (!adis->irq_flag) {
> -		adis->irq_flag = IRQF_TRIGGER_RISING;
> +	if (!direction) {

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Though a better way might be:

if (direction == IRQF_TRIGGER_NONE)

> +		adis->irq_flag |= IRQF_TRIGGER_RISING;
>  		return 0;
> -	} else if (adis->irq_flag != IRQF_TRIGGER_RISING &&
> -		   adis->irq_flag != IRQF_TRIGGER_FALLING) {
> +	} else if (direction != IRQF_TRIGGER_RISING &&
> +		   direction != IRQF_TRIGGER_FALLING) {
>  		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
>  			adis->irq_flag);
>  		return -EINVAL;
> --
> 2.31.1

Thanks
Barry

