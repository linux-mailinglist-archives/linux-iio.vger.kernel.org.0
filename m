Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9F37FC95
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhEMRha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhEMRh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:37:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C356143D;
        Thu, 13 May 2021 17:36:18 +0000 (UTC)
Date:   Thu, 13 May 2021 18:37:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 05/19] iio: accel: mxc4005: Fix overread of data and
 alignment issue.
Message-ID: <20210513183727.323a3bf6@jic23-huawei>
In-Reply-To: <20210501170121.512209-6-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-6-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 May 2021 18:01:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The bulk read size is based on the size of an array that also has
> space for the timestamp alongside the channels.
> Fix that and also fix alignment of the buffer passed
> to iio_push_to_buffers_with_timestamp.
> 
> Found during an audit of all calls to this function.
> 
> Fixes: 1ce0eda0f757 ("iio: mxc4005: add triggered buffer mode for mxc4005")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can find anything.  Minor tweak to enforce the
8 byte alignment as done in other drivers.
> ---
>  drivers/iio/accel/mxc4005.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index fb3cbaa62bd8..9e6066c6a2df 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -56,7 +56,11 @@ struct mxc4005_data {
>  	struct mutex mutex;
>  	struct regmap *regmap;
>  	struct iio_trigger *dready_trig;
> -	__be16 buffer[8];
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		__be16 chans[3];
> +		s64 timestamp;
Added __aligned(8) here to be consistent and ensure natural alignment.

> +	} scan;
>  	bool trigger_enabled;
>  };
>  
> @@ -135,7 +139,7 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
> -			       data->buffer, sizeof(data->buffer));
> +			       data->scan.chans, sizeof(data->scan.chans));
>  	if (ret < 0) {
>  		dev_err(data->dev, "failed to read axes\n");
>  		return ret;
> @@ -301,7 +305,7 @@ static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
>  	if (ret < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   pf->timestamp);
>  
>  err:

