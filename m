Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB8342E16
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCTP6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 11:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhCTP6X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 11:58:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5525C61966;
        Sat, 20 Mar 2021 15:58:09 +0000 (UTC)
Date:   Sat, 20 Mar 2021 15:58:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: accel: bmc150: Accept any trigger
Message-ID: <20210320155806.6aac93a7@jic23-huawei>
In-Reply-To: <20210319124709.484859-1-linus.walleij@linaro.org>
References: <20210319124709.484859-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 13:47:09 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The BMC150 driver checks to see that the trigger it is
> using is one of its own.
> 
> Not nice for my system where the IRQ line from the BMA222
> is not connected so there is *no* trigger I can use.
> 
> This seems just plain wrong to me. Certainly a userspace
> process will want to use the trigger from one single sensor
> even of it is reading say three different sensors for some
> sensor fusion.
> 
> Delete this trigger check.
Hi Linus,

Given it's rare for anyone to implement the validate callback
(and often only happens because I asked someone to add it)
I had a bit of a dig...

So the 'normal' reason for this is complexity around fifos
that mean supporting other triggers requires a bunch of extra
code (basically can't use a fifo without access to it's
watermarks interrupt etc - it could be done but it's
more than a little crazy - what does it meant to use
an hrtimer to read from a fifo running at a different
rate?).

Now this driver has two different struct iio_info structures.
Only one of those has this particular restriction - the
other one just doesn't enable the fifo and will run in data-ready
mode, or using another trigger.

The decision is based on whether the bus supports block reads.
So I'd argue what we actually need for your unwired interrupt
case is to fallback to the same mode we get if we can't
do the fifo anyway.

	if (block_supported && irq > 0) {
at line 1734 should work I think...

Who buys a nice device like this and doesn't wire up the interrupt?
Crazy people :)

Jonathan

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 7e425ebcd7ea..ae81b547dcfc 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -853,20 +853,6 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
> -					 struct iio_trigger *trig)
> -{
> -	struct bmc150_accel_data *data = iio_priv(indio_dev);
> -	int i;
> -
> -	for (i = 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> -		if (data->triggers[i].indio_trig == trig)
> -			return 0;
> -	}
> -
> -	return -EINVAL;
> -}
> -
>  static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
>  					       struct device_attribute *attr,
>  					       char *buf)
> @@ -1217,7 +1203,6 @@ static const struct iio_info bmc150_accel_info_fifo = {
>  	.write_event_value	= bmc150_accel_write_event,
>  	.write_event_config	= bmc150_accel_write_event_config,
>  	.read_event_config	= bmc150_accel_read_event_config,
> -	.validate_trigger	= bmc150_accel_validate_trigger,
>  	.hwfifo_set_watermark	= bmc150_accel_set_watermark,
>  	.hwfifo_flush_to_buffer	= bmc150_accel_fifo_flush,
>  };

