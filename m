Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3162A214C19
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGELoC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 07:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELoB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 07:44:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB1F20723;
        Sun,  5 Jul 2020 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949441;
        bh=Mp0OZ78nKDygctQuSPpG5pCPpNwfGBfIkMaAgxyxlgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UUqEYHLz1jzcke1pGxQF9VXIJDx/1mfdx+z3QmWqqtQ4KIThRRoLhXQdkpNn5FuXD
         LNi6xLl4LfXQ2/W/hMaofuy69VuKg7KHNhwjuPFF/WT3NcySR2um8KN4hK0t4x4Fib
         EB4BR9YRTa66ilVKuo+ECqxw8CrLYx3ifZgu2sK8=
Date:   Sun, 5 Jul 2020 12:43:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 13/32] iio:magnetometer:ak8974: Fix alignment and data
 leak issues
Message-ID: <20200705124357.1fc7316d@archlinux>
In-Reply-To: <20200607155408.958437-14-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-14-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Jun 2020 16:53:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> 
> This data is allocated with kzalloc so no data can leak appart from
> previous readings.
> 
> Fixes: 7c94a8b2ee8cf ("iio: magn: add a driver for AK8974")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git. I'm picking up
all the ones in the series which I have had positive feedback on.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8974.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index c2260c84f7f1..ea09b549ec4e 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -192,6 +192,11 @@ struct ak8974 {
>  	bool drdy_irq;
>  	struct completion drdy_complete;
>  	bool drdy_active_low;
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  static const char ak8974_reg_avdd[] = "avdd";
> @@ -657,7 +662,6 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
>  {
>  	struct ak8974 *ak8974 = iio_priv(indio_dev);
>  	int ret;
> -	__le16 hw_values[8]; /* Three axes + 64bit padding */
>  
>  	pm_runtime_get_sync(&ak8974->i2c->dev);
>  	mutex_lock(&ak8974->lock);
> @@ -667,13 +671,13 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
>  		dev_err(&ak8974->i2c->dev, "error triggering measure\n");
>  		goto out_unlock;
>  	}
> -	ret = ak8974_getresult(ak8974, hw_values);
> +	ret = ak8974_getresult(ak8974, ak8974->scan.channels);
>  	if (ret) {
>  		dev_err(&ak8974->i2c->dev, "error getting measures\n");
>  		goto out_unlock;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, hw_values,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &ak8974->scan,
>  					   iio_get_time_ns(indio_dev));
>  
>   out_unlock:

