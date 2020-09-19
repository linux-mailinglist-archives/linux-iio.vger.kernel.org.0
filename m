Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67771270F37
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgISP6t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgISP6t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:58:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6FC208DB;
        Sat, 19 Sep 2020 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600531128;
        bh=kIGSkptJrSzPRVEisvkW87TbcgTtO/LCx5j9PLx3vu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSEapzNo+6cdJREQdsUdo6x4u5bzjbvjwW+3tp7IA4q36CwvqadxFC2RlWJQvp+HJ
         LmpbAaGYayK/TMQkrToZySJB8sSgt3IBEE+mKLJtAczfjL6CPJFJU4HHW3aPJo9nny
         iTECESSLTovIrWgWWVd7Zy6n0Rl1nkRog3Ap8XHY=
Date:   Sat, 19 Sep 2020 16:58:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 15/27] iio:imu:bmi160 Fix alignment and data leak
 issues
Message-ID: <20200919165843.64d86d8f@archlinux>
In-Reply-To: <20200722155103.979802-16-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-16-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:51 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable array in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak apart from previous readings.
> 
> In this driver, depending on which channels are enabled, the timestamp
> can be in a number of locations.  Hence we cannot use a structure
> to specify the datalayout without it being missleading.
> 
> Fixes: 77c4ad2d6a9b ("iio: imu: Add initial support for Bosch BMI160")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Daniel Baluta  <daniel.baluta@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I applied this one then backed it out after realising that the device doesn't
have 9 channels despite the comment in place saying it does.
This particular device only has an accelerometer and a gyroscope, each
with 3 axes.

Daniel, can you confirm my interpretation on that?
I think we only need a buffer with space for
6 __le16 channels, 4 bytes padding and an s64 for the
timestamp.

So __le16 buffer[12].

Thanks,

Jonathan


> ---
>  drivers/iio/imu/bmi160/bmi160.h      | 2 ++
>  drivers/iio/imu/bmi160/bmi160_core.c | 5 ++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
> index a82e040bd109..d29f1b5d1658 100644
> --- a/drivers/iio/imu/bmi160/bmi160.h
> +++ b/drivers/iio/imu/bmi160/bmi160.h
> @@ -10,6 +10,8 @@ struct bmi160_data {
>  	struct iio_trigger *trig;
>  	struct regulator_bulk_data supplies[2];
>  	struct iio_mount_matrix orientation;
> +	/* Ensure natural alignment for timestamp if present */
> +	__le16 buf[16] __aligned(8);
>  };
>  
>  extern const struct regmap_config bmi160_regmap_config;
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 222ebb26f013..86cfd75ea125 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -427,7 +427,6 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmi160_data *data = iio_priv(indio_dev);
> -	__le16 buf[16];
>  	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
>  	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>  	__le16 sample;
> @@ -438,10 +437,10 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  				       &sample, sizeof(sample));
>  		if (ret)
>  			goto done;
> -		buf[j++] = sample;
> +		data->buf[j++] = sample;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;

