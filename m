Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D026A2C1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgIOKH7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 15 Sep 2020 06:07:59 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgIOKH7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Sep 2020 06:07:59 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1409080E4D05EEF65931;
        Tue, 15 Sep 2020 11:07:58 +0100 (IST)
Received: from localhost (10.52.121.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 11:07:57 +0100
Date:   Tue, 15 Sep 2020 11:06:19 +0100
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
Subject: Re: [PATCH 03/10] iio: adis16136: Use Managed device functions
Message-ID: <20200915110619.00005e5d@Huawei.com>
In-Reply-To: <20200915093345.85614-4-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
        <20200915093345.85614-4-nuno.sa@analog.com>
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

On Tue, 15 Sep 2020 11:33:38 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> Use the adis managed device functions to setup the buffer and the trigger.
> The ultimate goal will be to completely drop the non devm version from
> the lib.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/gyro/adis16136.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index d8a96f6bbae2..a4b060d9d23f 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -552,13 +552,13 @@ static int adis16136_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = adis_setup_buffer_and_trigger(&adis16136->adis, indio_dev, NULL);
> +	ret = devm_adis_setup_buffer_and_trigger(&adis16136->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;
>  
>  	ret = adis16136_initial_setup(indio_dev);
>  	if (ret)
> -		goto error_cleanup_buffer;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -570,21 +570,16 @@ static int adis16136_probe(struct spi_device *spi)
>  
>  error_stop_device:
>  	adis16136_stop_device(indio_dev);
> -error_cleanup_buffer:
> -	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
>  	return ret;
>  }
>  
>  static int adis16136_remove(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis16136 *adis16136 = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  	adis16136_stop_device(indio_dev);

As adis16136_stop_device() is always run in remove, I'd suggest using
devm_add_action_or_reset at appropriate place in probe to use
the automated unrolling for that as well, letting you get rid of this
remove function.

>  
> -	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
> -
>  	return 0;
>  }
>  


