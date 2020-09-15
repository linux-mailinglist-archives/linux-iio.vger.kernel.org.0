Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E226A2CA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIOKJY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 15 Sep 2020 06:09:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgIOKJX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Sep 2020 06:09:23 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7443A9FFD2F95662EDE4;
        Tue, 15 Sep 2020 11:09:22 +0100 (IST)
Received: from localhost (10.52.121.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 11:09:21 +0100
Date:   Tue, 15 Sep 2020 11:07:45 +0100
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
Subject: Re: [PATCH 07/10] iio: adis16480: Use Managed device functions
Message-ID: <20200915110745.00007a9c@Huawei.com>
In-Reply-To: <20200915093345.85614-8-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
        <20200915093345.85614-8-nuno.sa@analog.com>
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

On Tue, 15 Sep 2020 11:33:42 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> Use the adis managed device functions to setup the buffer and the trigger.
> The ultimate goal will be to completely drop the non devm version from
> the lib.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16480.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 1eb4f98076f1..b6a129a70d4b 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -1264,20 +1264,18 @@ static int adis16480_probe(struct spi_device *spi)
>  		st->clk_freq = st->chip_info->int_clk;
>  	}
>  
> -	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
> +	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		goto error_clk_disable_unprepare;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_cleanup_buffer;
> +		goto error_clk_disable_unprepare;
>  
>  	adis16480_debugfs_init(indio_dev);
>  
>  	return 0;
>  
> -error_cleanup_buffer:
> -	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
>  error_clk_disable_unprepare:
>  	clk_disable_unprepare(st->ext_clk);
>  error_stop_device:
> @@ -1293,7 +1291,6 @@ static int adis16480_remove(struct spi_device *spi)
>  	iio_device_unregister(indio_dev);
>  	adis16480_stop_device(indio_dev);
>  
> -	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
This change the remove order so that it will not be a reverse of the order
seen in probe.   Perhaps you can solve that by using
devm_add_action_or_reset() calls to handle the few other remaining things
in remove?

Thanks,

Jonathan

>  	clk_disable_unprepare(st->ext_clk);
>  
>  	return 0;


