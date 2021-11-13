Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA744F41D
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhKMQ0z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 11:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235980AbhKMQ0z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 11:26:55 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3302961077;
        Sat, 13 Nov 2021 16:24:01 +0000 (UTC)
Date:   Sat, 13 Nov 2021 16:28:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ad7768-1: Call iio_trigger_notify_done() on
 error
Message-ID: <20211113162847.3f1eb11d@jic23-huawei>
In-Reply-To: <20211101144055.13858-2-lars@metafoo.de>
References: <20211101144055.13858-1-lars@metafoo.de>
        <20211101144055.13858-2-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 15:40:55 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> IIO trigger handlers must call iio_trigger_notify_done() when done. This
> must be done even when an error occurred. Otherwise the trigger will be
> seen as busy indefinitely and the trigger handler will never be called
> again.
> 
> The ad7768-1 driver neglects to call iio_trigger_notify_done() when there
> is an error reading the converter data. Fix this by making sure that
> iio_trigger_notify_done() is included in the error exit path.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Hi Lars,

I've always meant to have a hard think about what we 'should' do in the event
of an error in one of these trigger handlers.   Definitely don't want to get
stuck so these patches make sense, but I'd also at somepoint like to explore
if we should stop the device capture and do something like poison the kfifo
output so that we know it was broken. 

Anyhow, a discussion for another day.

Applied these two to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7768-1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 2c5c8a3672b2..aa42ba759fa1 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -480,8 +480,8 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
>  					   iio_get_time_ns(indio_dev));
>  
> -	iio_trigger_notify_done(indio_dev->trig);
>  err_unlock:
> +	iio_trigger_notify_done(indio_dev->trig);
>  	mutex_unlock(&st->lock);
>  
>  	return IRQ_HANDLED;

