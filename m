Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846B270F62
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgISQSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 12:18:54 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39338 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISQSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Sep 2020 12:18:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 018259E004A;
        Sat, 19 Sep 2020 17:18:52 +0100 (BST)
Date:   Sat, 19 Sep 2020 17:18:51 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v3 24/27] iio:adc:ti-adc0832 Fix alignment issue with
 timestamp
Message-ID: <20200919171851.54d4d4e4@archlinux>
In-Reply-To: <20200722155103.979802-25-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-25-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:51:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> 
> We fix this issues by moving to a suitable structure in the iio_priv()
> data with alignment explicitly requested.  This data is allocated
> with kzalloc so no data can leak apart from previous readings.
> Note that previously no data could leak 'including' previous readings
> but I don't think it is an issue to potentially leak them like
> this now does.
> 
> In this case the postioning of the timestamp is depends on what
> other channels are enabled. As such we cannot use a structure to
> make the alignment explicit as it would be missleading by suggesting
> only one possible location for the timestamp.
> 
> Fixes: 815bbc87462a ("iio: ti-adc0832: add triggered buffer support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Expanded the comment for the data[24] element to explain that it is the
maximum length that may be used, and less may be needed if not all
channels are enabled as long as the timestamp remains naturally aligned.
(case 2 of Andy's review)

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-adc0832.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index c7a085dce1f4..71d49f97ab9c 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -29,6 +29,8 @@ struct adc0832 {
>  	struct regulator *reg;
>  	struct mutex lock;
>  	u8 mux_bits;
> +	/* 16x 1 byte ADC data + 8 bytes timestamp */
> +	u8 data[24] __aligned(8);
>  
>  	u8 tx_buf[2] ____cacheline_aligned;
>  	u8 rx_buf[2];
> @@ -200,7 +202,6 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct adc0832 *adc = iio_priv(indio_dev);
> -	u8 data[24] = { }; /* 16x 1 byte ADC data + 8 bytes timestamp */
>  	int scan_index;
>  	int i = 0;
>  
> @@ -218,10 +219,10 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
>  			goto out;
>  		}
>  
> -		data[i] = ret;
> +		adc->data[i] = ret;
>  		i++;
>  	}
> -	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, adc->data,
>  					   iio_get_time_ns(indio_dev));
>  out:
>  	mutex_unlock(&adc->lock);

