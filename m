Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95841417AD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgARNec (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 08:34:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgARNec (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 08:34:32 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E8C24699;
        Sat, 18 Jan 2020 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579354472;
        bh=/omhXstJLHdtzfL5ZXSP8ni+4NjJtg5VWsRMdJIlRc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gN2+giLR8KsEq+xbkU6SDX15RgiV/I3Ly1v4hIefxhkGzKWy9EcQIvmgdO7oigbBD
         y6kBIJ8dOhizPLSl09bxI54rieOQU6OpGX5WHDweDWwH9MveG6nzmnB2rx6AmomTly
         eVY+NzKYRBpSL7TpAPo0l/JnXoqQt7p8gE+78vek=
Date:   Sat, 18 Jan 2020 13:34:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bma400: prevent setting accel scale too
 low
Message-ID: <20200118133427.07a665f6@archlinux>
In-Reply-To: <20200116100829.thq77nvyqtasdu4j@kili.mountain>
References: <20200115181717.GA22797@nessie>
        <20200116100829.thq77nvyqtasdu4j@kili.mountain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jan 2020 13:08:29 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This puts an upper bound on "val2" but it also needs to have a lower
> bound (BMA400_SCALE_MIN).
> 
> Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to the togreg branch of iio.git and pushed out as testing.
Hopefully I'll sneak in a pull request to get this lined up for
the merge window.

Thanks,

Jonathan

> ---
> v2: the first version just capped it at zero but it should be
>     BMA400_SCALE_MIN (38357).
> 
>  drivers/iio/accel/bma400_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index ab4a158b35af..cc77f89c048b 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -752,7 +752,8 @@ static int bma400_write_raw(struct iio_dev *indio_dev,
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val != 0 || val2 > BMA400_SCALE_MAX)
> +		if (val != 0 ||
> +		    val2 < BMA400_SCALE_MIN || val2 > BMA400_SCALE_MAX)
>  			return -EINVAL;
>  
>  		mutex_lock(&data->mutex);

