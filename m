Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2E23FF7F
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIR1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgHIR1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:27:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41FD206C3;
        Sun,  9 Aug 2020 17:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994053;
        bh=0qi68VaL/NPvlVeSfairC7cMSgFjOoFfDTjEvbDCT8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tKdWU8CnLWlAesyYew/ui9TzZC5eUIozBv3XJTI2cOqKBy7shTH4edSmfrVOizA8x
         qzTRL8PJhkF8KIdEteIYc+eQ5qkYVOuHRV6Fa+850liO/cIinIjQ2AWO7linY+SWvc
         BlZZR/MxfHhrE324mJx3geNy/wHmIe86wperQUGk=
Date:   Sun, 9 Aug 2020 18:27:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 12/27] iio:light:ltr501 Fix timestamp alignment
 issue.
Message-ID: <20200809182730.638a032c@archlinux>
In-Reply-To: <20200722155103.979802-13-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-13-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> Here we use a structure on the stack.  The driver already did an
> explicit memset so no data leak was possible.
> 
> Forced alignment of ts is not strictly necessary but probably makes
> the code slightly less fragile.
> 
> Note there has been some rework in this driver of the years, so no
> way this will apply cleanly all the way back.
> 
> Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 4bac0646398d..b4323d2db0b1 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1243,13 +1243,16 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ltr501_data *data = iio_priv(indio_dev);
> -	u16 buf[8];
> +	struct {
> +		u16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
>  	__le16 als_buf[2];
>  	u8 mask = 0;
>  	int j = 0;
>  	int ret, psdata;
>  
> -	memset(buf, 0, sizeof(buf));
> +	memset(&scan, 0, sizeof(scan));
>  
>  	/* figure out which data needs to be ready */
>  	if (test_bit(0, indio_dev->active_scan_mask) ||
> @@ -1268,9 +1271,9 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  		if (ret < 0)
>  			return ret;
>  		if (test_bit(0, indio_dev->active_scan_mask))
> -			buf[j++] = le16_to_cpu(als_buf[1]);
> +			scan.channels[j++] = le16_to_cpu(als_buf[1]);
>  		if (test_bit(1, indio_dev->active_scan_mask))
> -			buf[j++] = le16_to_cpu(als_buf[0]);
> +			scan.channels[j++] = le16_to_cpu(als_buf[0]);
>  	}
>  
>  	if (mask & LTR501_STATUS_PS_RDY) {
> @@ -1278,10 +1281,10 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  				       &psdata, 2);
>  		if (ret < 0)
>  			goto done;
> -		buf[j++] = psdata & LTR501_PS_DATA_MASK;
> +		scan.channels[j++] = psdata & LTR501_PS_DATA_MASK;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>  					   iio_get_time_ns(indio_dev));
>  
>  done:

