Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21D8312B6F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBHIDo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Feb 2021 03:03:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2518 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBHIDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 03:03:34 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYz1v2BTNz67m3p;
        Mon,  8 Feb 2021 15:59:15 +0800 (CST)
Received: from lhreml711-chm.china.huawei.com (10.201.108.62) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 09:02:52 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:02:51 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 16:02:49 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 08/24] staging:iio:cdc:ad7150: Drop noisy print in probe
Thread-Topic: [PATCH 08/24] staging:iio:cdc:ad7150: Drop noisy print in probe
Thread-Index: AQHW/WjH/i2r5ApDV0qSnIHAB3iZxapN5RYA
Date:   Mon, 8 Feb 2021 08:02:49 +0000
Message-ID: <67cc5fe36f8a4d88acba80e7d73ef394@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-9-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-9-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Monday, February 8, 2021 4:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: [PATCH 08/24] staging:iio:cdc:ad7150: Drop noisy print in probe
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also
> * drop i2c_set_client_data() as now unused.
> * white space cleanups
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  drivers/staging/iio/cdc/ad7150.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index 34e6afe52f0e..8f8e472e3240 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -573,11 +573,9 @@ static int ad7150_probe(struct i2c_client *client,
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
>  		return -ENOMEM;
> +
>  	chip = iio_priv(indio_dev);
>  	mutex_init(&chip->state_lock);
> -	/* this is only used for device removal purposes */
> -	i2c_set_clientdata(client, indio_dev);
> -
>  	chip->client = client;
> 
>  	indio_dev->name = id->name;
> @@ -624,14 +622,7 @@ static int ad7150_probe(struct i2c_client *client,
>  		}
>  	}
> 
> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
> -		 id->name, client->irq);
> -
> -	return 0;
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
> 
>  static const struct i2c_device_id ad7150_id[] = {
> --
> 2.30.0

