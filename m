Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B982423FF87
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHIRet (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgHIRet (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:34:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FEF2065D;
        Sun,  9 Aug 2020 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994489;
        bh=KTEt82N9f2jzG6+h0qF0Lkw+0MYoxoDF1V+dk9uXIqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uE7bsbZNEP9DJsbuUgXhhDMX7Z/fPhJKoj0kqJGO7nbP2CEjCAOsSzLp4PSIqgkoV
         Xjpsiyk1ZE63ItZ7A35sgMV+SVBEY55DEox91eqq9E8glZdspjBPfz3LIq+nr0KaKM
         3mbmqKmvYLNhZFSIYIEZ9m9Cq0wtu0woUpR6HRBI=
Date:   Sun, 9 Aug 2020 18:34:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 20/27] iio:adc:ti-adc081c Fix alignment and data leak
 issues
Message-ID: <20200809183445.4a9fad59@archlinux>
In-Reply-To: <20200722155103.979802-21-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-21-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:56 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv().
> 
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
> 
> The eplicit alignment of ts is necessary to ensure correct padding
> on x86_32 where s64 is only aligned to 4 bytes.
> 
> Fixes: 08e05d1fce5c (" ti-adc081c: Initial triggered buffer support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc081c.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 9426f70a8005..cf63983a54d9 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -33,6 +33,12 @@ struct adc081c {
>  
>  	/* 8, 10 or 12 */
>  	int bits;
> +
> +	/* Ensure natural alignment of buffer elements */
> +	struct {
> +		u16 channel;
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  #define REG_CONV_RES 0x00
> @@ -128,14 +134,13 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct adc081c *data = iio_priv(indio_dev);
> -	u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
>  	int ret;
>  
>  	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);
>  	if (ret < 0)
>  		goto out;
> -	buf[0] = ret;
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	data->scan.channel = ret;
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   iio_get_time_ns(indio_dev));
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);

