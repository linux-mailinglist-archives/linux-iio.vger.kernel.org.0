Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FC23FF82
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIRao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRao (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:30:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077E2206CD;
        Sun,  9 Aug 2020 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994243;
        bh=Z49o3L+2ZuGYhTRk4b1a+8Ss6BqLtJO8clvwV8JNrOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QY6SJUr4qQIxXMKvFXFPqzmfya90oN5NiArnemclbIsl+iPij/x1chFSu8sIevTRe
         qj2ThtjMRleEhhdtBSuO0dw8QqrTDd1Zq3xxvrMHjAPLqgnIDlGLryljvst+r6pETx
         53WNMF4FFalFjdB0wmV1wOHkMu8BAkjrifzevJ88=
Date:   Sun, 9 Aug 2020 18:30:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 13/27] iio:magnetometer:ak8975 Fix alignment and data
 leak issues.
Message-ID: <20200809183039.0db00485@archlinux>
In-Reply-To: <20200722155103.979802-14-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-14-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:49 +0100
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
> This data is allocated with kzalloc so no data can leak apart from
> previous readings.
> 
> The explicit alignment of ts is not necessary in this case as by
> coincidence the padding will end up the same, however I consider
> it to make the code less fragile and have included it.
> 
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 03d71f796177..623766ff800b 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -366,6 +366,12 @@ struct ak8975_data {
>  	struct iio_mount_matrix orientation;
>  	struct regulator	*vdd;
>  	struct regulator	*vid;
> +
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		s16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  /* Enable attached power regulator if any. */
> @@ -793,7 +799,6 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  	const struct i2c_client *client = data->client;
>  	const struct ak_def *def = data->def;
>  	int ret;
> -	s16 buff[8]; /* 3 x 16 bits axis values + 1 aligned 64 bits timestamp */
>  	__le16 fval[3];
>  
>  	mutex_lock(&data->lock);
> @@ -816,12 +821,13 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  	mutex_unlock(&data->lock);
>  
>  	/* Clamp to valid range. */
> -	buff[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
> -	buff[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
> -	buff[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
> +	data->scan.channels[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
> +	data->scan.channels[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
> +	data->scan.channels[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buff,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   iio_get_time_ns(indio_dev));
> +
>  	return;
>  
>  unlock:

