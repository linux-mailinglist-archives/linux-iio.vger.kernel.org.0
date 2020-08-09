Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0785B23FF7B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgHIRXq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgHIRXq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:23:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D132206C3;
        Sun,  9 Aug 2020 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993825;
        bh=t2sSXxwpFTMr2SBhWHsJ4cMFRH5RmX5naU4PRaPpQK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghmkzRT29r1dnJ9/RYOGnu39lDPoqEUDev8DxbtPcxoJ38ZoiibyPP1tW2sl4GjjL
         ymmFkwkDFER+pI86y5p/OKRWnS4ctrXiqbTWLyXxMGMlpJwQ5GBw3iS6G8trjIrOCw
         2MAWg6SRS/SsQmr/PyzOKpDv9gOx9UxOUxBdfEjc=
Date:   Sun, 9 Aug 2020 18:23:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: Re: [PATCH v3 07/27] iio:chemical:ccs811: Fix timestamp alignment
 and prevent data leak.
Message-ID: <20200809182341.5ceadf51@archlinux>
In-Reply-To: <20200722155103.979802-8-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-8-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak appart from previous readings.
> 
> The explicit alignment of ts is necessary to ensure consistent
> padding for x86_32 in which the ts would otherwise be 4 byte aligned.
> 
> Fixes: 283d26917ad6 ("iio: chemical: ccs811: Add triggered buffer support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied
> ---
>  drivers/iio/chemical/ccs811.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 2b007e7568b2..60dd87e96f5f 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -78,6 +78,11 @@ struct ccs811_data {
>  	struct iio_trigger *drdy_trig;
>  	struct gpio_desc *wakeup_gpio;
>  	bool drdy_trig_on;
> +	/* Ensures correct alignment of timestamp if present */
> +	struct {
> +		s16 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  static const struct iio_chan_spec ccs811_channels[] = {
> @@ -327,17 +332,17 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ccs811_data *data = iio_priv(indio_dev);
>  	struct i2c_client *client = data->client;
> -	s16 buf[8]; /* s16 eCO2 + s16 TVOC + padding + 8 byte timestamp */
>  	int ret;
>  
> -	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA, 4,
> -					    (u8 *)&buf);
> +	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA,
> +					    sizeof(data->scan.channels),
> +					    (u8 *)data->scan.channels);
>  	if (ret != 4) {
>  		dev_err(&client->dev, "cannot read sensor data\n");
>  		goto err;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   iio_get_time_ns(indio_dev));
>  
>  err:

