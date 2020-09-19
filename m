Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F69270F2A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgISPl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:41:59 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39094 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgISPl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Sep 2020 11:41:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6F5E49E004A;
        Sat, 19 Sep 2020 16:41:55 +0100 (BST)
Date:   Sat, 19 Sep 2020 16:41:53 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 05/27] iio:gyro:itg3200: Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200919164153.07fe0e4f@archlinux>
In-Reply-To: <20200722155103.979802-6-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-6-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte array of smaller elements on the stack.
> This is fixed by using an explicit c structure. As there are no
> holes in the structure, there is no possiblity of data leakage
> in this case.
> 
> The explicit alignment of ts is not strictly necessary but potentially
> makes the code slightly less fragile.  It also removes the possibility
> of this being cut and paste into another driver where the alignment
> isn't already true.
> 
> Fixes: 36e0371e7764 ("iio:itg3200: Use iio_push_to_buffers_with_timestamp()")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
No idea why I didn't pick this one up with the other similar cases as
it fits in Andy's case 1 (no change needed).

Anyhow, now applied to the togreg branch of iio.git as no particular
rush to get this in.

Cc'd stable.

> ---
>  drivers/iio/gyro/itg3200_buffer.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> index d3fbe9d86467..1c3c1bd53374 100644
> --- a/drivers/iio/gyro/itg3200_buffer.c
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -46,13 +46,20 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct itg3200 *st = iio_priv(indio_dev);
> -	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
> -
> -	int ret = itg3200_read_all_channels(st->i2c, buf);
> +	/*
> +	 * Ensure correct alignment and padding including for the
> +	 * timestamp that may be inserted.
> +	 */
> +	struct {
> +		__be16 buf[ITG3200_SCAN_ELEMENTS];
> +		s64 ts __aligned(8);
> +	} scan;
> +
> +	int ret = itg3200_read_all_channels(st->i2c, scan.buf);
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  

