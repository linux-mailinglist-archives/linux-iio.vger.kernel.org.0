Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1F23FF8E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHIRjm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHIRjm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:39:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16256206C0;
        Sun,  9 Aug 2020 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994782;
        bh=tt9uCUay/V3Ne3luEQ0Gbf3EM1MjXCZLK/K9UQoM59U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F8BYb0sDWkEmMXFyQdwqt4UAtIDzCxeqo+eKLuRJa1XFTGjBPCWTaFta4XQ/NTP9M
         N2JF+EwHxYwQ4Xt2a93xc+GBfq5hHQ3kJAI9FirnksIZVYQlOPM4jtufk3C3xzKBLs
         in0oSDo9rRYlLlkwUKMJpiYD7/SQriL64Q8CBT6w=
Date:   Sun, 9 Aug 2020 18:39:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 27/27] iio:adc:max1118 Fix alignment of timestamp and
 data leak issues
Message-ID: <20200809183938.0f29d680@archlinux>
In-Reply-To: <20200722155103.979802-28-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-28-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:51:03 +0100
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
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
> 
> The explicit alignment of ts is necessary to ensure correct padding
> on architectures where s64 is only 4 bytes aligned such as x86_32.
> 
> Fixes: a9e9c7153e96 ("iio: adc: add max1117/max1118/max1119 ADC driver")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1118.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 01b20e420ac4..6efb0b43d938 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -36,6 +36,11 @@ struct max1118 {
>  	struct spi_device *spi;
>  	struct mutex lock;
>  	struct regulator *reg;
> +	/* Ensure natural alignment of buffer elements */
> +	struct {
> +		u8 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  
>  	u8 data ____cacheline_aligned;
>  };
> @@ -166,7 +171,6 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct max1118 *adc = iio_priv(indio_dev);
> -	u8 data[16] = { }; /* 2x 8-bit ADC data + padding + 8 bytes timestamp */
>  	int scan_index;
>  	int i = 0;
>  
> @@ -184,10 +188,10 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
>  			goto out;
>  		}
>  
> -		data[i] = ret;
> +		adc->scan.channels[i] = ret;
>  		i++;
>  	}
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
>  					   iio_get_time_ns(indio_dev));
>  out:
>  	mutex_unlock(&adc->lock);

