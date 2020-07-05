Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480B3214C23
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGELqY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 07:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELqY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 07:46:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FC820723;
        Sun,  5 Jul 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949583;
        bh=kne9EYJ4T8/SbQzhB367RpNpUpsH55nn4sRe8//oqmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z70l5DFx5U9me+xraMFWph/IxIPmf9E7LqdFCvKTp4gGVpm3SqXyT2P8c7CemV8Oj
         YtjFA3NpPbyOt1gxx5ZKaXJQtaAvtiAiJDJfpGJjjTt8hSTljiJHbMVFZWLZs4wm/3
         w/xeGn2D3fsK2XeS1pH09OaLBkFkbf63lFL/p9kk=
Date:   Sun, 5 Jul 2020 12:46:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH 16/32] iio:humidity:hdc100x Fix alignment and data leak
 issues
Message-ID: <20200705124619.69363731@archlinux>
In-Reply-To: <20200607155408.958437-17-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-17-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Jun 2020 16:53:52 +0100
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
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
> 
> Fixes: 16bf793f86b2 ("iio: humidity: hdc100x: add triggered buffer support for HDC100X")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git.
I'm scooping up all the ones in this series that have have acks etc
as then I can work on getting eyes on the remainder.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hdc100x.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 3331141734c8..e64af35f5f6f 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -38,6 +38,11 @@ struct hdc100x_data {
>  
>  	/* integration time of the sensor */
>  	int adc_int_us[2];
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		__be16 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  /* integration time in us */
> @@ -322,7 +327,6 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>  	struct i2c_client *client = data->client;
>  	int delay = data->adc_int_us[0] + data->adc_int_us[1];
>  	int ret;
> -	s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
>  
>  	/* dual read starts at temp register */
>  	mutex_lock(&data->lock);
> @@ -333,13 +337,13 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
>  	}
>  	usleep_range(delay, delay + 1000);
>  
> -	ret = i2c_master_recv(client, (u8 *)buf, 4);
> +	ret = i2c_master_recv(client, (u8 *)data->scan.channels, 4);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "cannot read sensor data\n");
>  		goto err;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   iio_get_time_ns(indio_dev));
>  err:
>  	mutex_unlock(&data->lock);

