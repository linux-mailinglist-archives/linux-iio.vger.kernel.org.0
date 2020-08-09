Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE423FF71
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHIRRn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRRn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:17:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37166206A2;
        Sun,  9 Aug 2020 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993463;
        bh=uc26ozDmw+sC1xVWwb6POwL36K609S5X/oUFQeNBNjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkyhqvUzjn9U8qm5ZjAKswO1gyFi4lHOCOC8fxhtmWoCqvCgYd6ieverA8QgFPVBD
         To7nQI4KVUQmL8f79YzKKrIHkc3Adzqy5yPFSla4Ot7Vq6XYZId03OnHbgqb/1z0jE
         UumkywbUPQVHe5pPaDctREN4lFEaCbNslEml76SY=
Date:   Sun, 9 Aug 2020 18:14:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 02/27] iio:accel:mma8452: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200809181420.337909ec@archlinux>
In-Reply-To: <20200722155103.979802-3-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-3-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte u8 array on the stack.  As Lars also noted
> this anti pattern can involve a leak of data to userspace and that
> indeed can happen here.  We close both issues by moving to
> a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
> 
> The additional forcing of the 8 byte alignment of the timestamp
> is not strictly necessary but makes the code less fragile by
> making this explicit.
> 
> Fixes: c7eeea93ac60 ("iio: Add Freescale MMA8452Q 3-axis accelerometer driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index ba27f8673131..1cf2b5db26ca 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -110,6 +110,12 @@ struct mma8452_data {
>  	int sleep_val;
>  	struct regulator *vdd_reg;
>  	struct regulator *vddio_reg;
> +
> +	/* Ensure correct alignment of time stamp when present */
> +	struct {
> +		__be16 channels[3];
> +		s64 ts __aligned(8);
> +	} buffer;
>  };
>  
>   /**
> @@ -1091,14 +1097,13 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
>  	int ret;
>  
> -	ret = mma8452_read(data, (__be16 *)buffer);
> +	ret = mma8452_read(data, data->buffer.channels);
>  	if (ret < 0)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   iio_get_time_ns(indio_dev));
>  
>  done:

