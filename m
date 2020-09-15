Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3384726A2B7
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIOKGu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 15 Sep 2020 06:06:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIOKGs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Sep 2020 06:06:48 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F0A6652B9102A0AA7971;
        Tue, 15 Sep 2020 11:06:45 +0100 (IST)
Received: from localhost (10.52.121.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 11:06:45 +0100
Date:   Tue, 15 Sep 2020 11:05:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Alexandru Ardelean --dry-run <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 01/10] iio: adis16201: Use Managed device functions
Message-ID: <20200915110508.000028f4@Huawei.com>
In-Reply-To: <20200915093345.85614-2-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
        <20200915093345.85614-2-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.217]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 11:33:36 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> Use the adis managed device functions to setup the buffer and the trigger.
> The ultimate goal will be to completely drop the non devm version from
> the lib.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/accel/adis16201.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 59a24c355a1a..a375ec25448a 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -281,32 +281,22 @@ static int adis16201_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>  	if (ret)
>  		return ret;
>  
>  	ret = adis_initial_startup(st);
>  	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto error_cleanup_buffer_trigger;
> -
> -	return 0;
> +		return ret;
>  
> -error_cleanup_buffer_trigger:
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	return ret;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int adis16201_remove(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);

If all you have left in remove is a call to iio_device_unregister()
why not just use devm_iio_device_register in probe and drop the
remove function entirely?

> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
>  
>  	return 0;
>  }


