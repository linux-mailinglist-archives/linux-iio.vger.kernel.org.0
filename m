Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F037FC69
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEMRWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhEMRWb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:22:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7C16142C;
        Thu, 13 May 2021 17:21:20 +0000 (UTC)
Date:   Thu, 13 May 2021 18:22:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 01/19] iio: accel: bma180: Fix buffer alignment in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513182228.54e2941f@jic23-huawei>
In-Reply-To: <20210501170121.512209-2-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
        <20210501170121.512209-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 May 2021 18:01:03 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> To make code more readable, use a structure to express the channel
> layout and ensure the timestamp is 8 byte aligned.
> 
> Found during an audit of all calls of this function.
> 
> Fixes: b9a6a237ffc9 ("iio:bma180: Drop _update_scan_mode()")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>

Applied to the togreg branch of iio.git with a minor fix.

Note I'm taking these the slow way and nor marking them for stable
as they've been there a very long time.

> ---
>  drivers/iio/accel/bma180.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index b8a7469cdae4..2e901f900ea7 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -162,7 +162,11 @@ struct bma180_data {
>  	int scale;
>  	int bw;
>  	bool pmode;
> -	u8 buff[16]; /* 3x 16-bit + 8-bit + padding + timestamp */
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		s16 chan[3];
The 8 bit in the comment above is misleading, but made me take another
look at this.   There are actually 4 channels on some devices, the last
of which (temp) is 8 bits in a 16bit field. 

I changed this to be s16 chan[4] to reflect that.

Thanks,

Jonathan

> +		s64 timestamp __aligned(8);
> +	} scan;
>  };
>  
>  enum bma180_chan {
> @@ -938,12 +942,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  			mutex_unlock(&data->mutex);
>  			goto err;
>  		}
> -		((s16 *)data->buff)[i++] = ret;
> +		data->scan.chan[i++] = ret;
>  	}
>  
>  	mutex_unlock(&data->mutex);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  

