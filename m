Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4F37FCCC
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEMRut (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhEMRus (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:50:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9013261106;
        Thu, 13 May 2021 17:49:37 +0000 (UTC)
Date:   Thu, 13 May 2021 18:50:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 16/19] iio: magn: bmc150: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513185046.1615083a@jic23-huawei>
In-Reply-To: <20210501170121.512209-17-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-17-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 May 2021 18:01:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
> 
> Found during an audit of all calls of uses of
> iio_push_to_buffers_with_timestamp()
> 
> Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Applied, but with a tiny tweak to make this more obviously correct.

> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 00f9766bad5c..dd5f80093a18 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -138,8 +138,11 @@ struct bmc150_magn_data {
>  	struct regmap *regmap;
>  	struct regulator_bulk_data regulators[2];
>  	struct iio_mount_matrix orientation;
> -	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
> -	s32 buffer[6];
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		s32 chans[4];
The whole point of the structure is to enforce the alignment without needing
to specify padding.   There are only 3 actual chans, so I've reduced this to
s32 chans[3]

Result is exactly the same in practice, but it's more readable.

Thanks,

Jonathan

> +		s64 timestamp __aligned(8);
> +	} scan;
>  	struct iio_trigger *dready_trig;
>  	bool dready_trigger_on;
>  	int max_odr;
> @@ -675,11 +678,11 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
>  	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	ret = bmc150_magn_read_xyz(data, data->buffer);
> +	ret = bmc150_magn_read_xyz(data, data->scan.chans);
>  	if (ret < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   pf->timestamp);
>  
>  err:

