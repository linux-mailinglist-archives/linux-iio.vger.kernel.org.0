Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97642218BC7
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jul 2020 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgGHPmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jul 2020 11:42:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730694AbgGHPmh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:37 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 5E833DD6F4C7748FAA6B;
        Wed,  8 Jul 2020 16:42:36 +0100 (IST)
Received: from localhost (10.52.126.65) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 8 Jul 2020
 16:42:36 +0100
Date:   Wed, 8 Jul 2020 16:41:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio:accel:bma180: Fix the shared by parameter for an
 enum
Message-ID: <20200708164131.00000065@Huawei.com>
In-Reply-To: <20200707203044.369103-1-jic23@kernel.org>
References: <20200707203044.369103-1-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.65]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jul 2020 21:30:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Title on this one is gibberish.  Let us pretend that says

Fix: Use enum value IIO_SHARED_BY_ALL instead of a boolean.

> 
> This takes an enum, not a boolean. Discovered via warning when doing
> a W=1 build.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: fdadbce0da4 ("iio: add Bosch BMA180 acceleration sensor driver")
> ---
>  drivers/iio/accel/bma180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 5b7a467c7b27..3246a5ef7360 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
>  };
>  
>  static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> -	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
> +	IIO_ENUM("power_mode", IIO_SHARED_BY_ALL, &bma180_power_mode_enum),
>  	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
>  	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
>  	{ }


