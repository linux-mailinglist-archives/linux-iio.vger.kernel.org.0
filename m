Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3070513CC24
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 19:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAOSdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 13:33:49 -0500
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17858 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAOSdt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 13:33:49 -0500
Received: from nessie (pool-173-73-58-202.washdc.fios.verizon.net [173.73.58.202]) by mx.zohomail.com
        with SMTPS id 15791131940722.1131942763884126; Wed, 15 Jan 2020 10:33:14 -0800 (PST)
Date:   Wed, 15 Jan 2020 18:17:17 +0000
From:   Dan Robertson <dan@dlrobertson.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma400: integer underflow setting accel scale
Message-ID: <20200115181717.GA22797@nessie>
References: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115174531.p623ukjibn6kg6zz@kili.mountain>
X-ZohoMailClient: External
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 15, 2020 at 08:45:31PM +0300, Dan Carpenter wrote:
> We put an upper bound on "val2" but we also need to prevent negative
> values.
> 
> Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/accel/bma400_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index ab4a158b35af..ffc7b146bbfc 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -752,7 +752,7 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val != 0 || val2 > BMA400_SCALE_MAX)
> +		if (val != 0 || val2 < 0 || val2 > BMA400_SCALE_MAX)

AFAIK if val2 is less than BMA400_SCALE_MIN we should return -EINVAL.

Cheers,

 -Dan

