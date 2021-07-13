Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1E3C75E4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 19:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGMRsa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 13:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMRsa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Jul 2021 13:48:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C0461358;
        Tue, 13 Jul 2021 17:45:36 +0000 (UTC)
Date:   Tue, 13 Jul 2021 18:47:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, andy.shevchenko@gmail.com,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: fxls8962af: fix potential use of
 uninitialized symbol
Message-ID: <20210713184754.07d4d7c5@jic23-huawei>
In-Reply-To: <20210709071727.2453536-1-sean@geanix.com>
References: <20210709071727.2453536-1-sean@geanix.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  9 Jul 2021 09:17:27 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Fix this warning from kernel test robot:
> smatch warnings:
> drivers/iio/accel/fxls8962af-core.c:640
> fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> Changes since v2:
>  - add commit msg
> 
>  drivers/iio/accel/fxls8962af-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 078d87865fde..0019f1ea7df2 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -637,7 +637,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
>  			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,

