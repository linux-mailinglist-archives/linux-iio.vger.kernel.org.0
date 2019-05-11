Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CB1A7AE
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEKLiC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEKLiC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:38:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF7A2146F;
        Sat, 11 May 2019 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557574681;
        bh=7LjTa5GlIJVY0ODcV/4VqIGRylxvc/r6Mm57PXH0pHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T2CAdmwv5xVwhJVIWqKIe2C58ImBZBC1A3HC5TAGrVgcftYgYn+F+Pn12XM8wh6RS
         ZA9ARQ6Sv605VK9FZDYVmP0xebALSoiztpFWa1gooeajyKCRzk1H4BH1Z0+dXtW/sc
         R8GDCB4gjeR0FlxAOczInpWTsBqL7RKvFIThiQDg=
Date:   Sat, 11 May 2019 12:37:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
Message-ID: <20190511123755.2d220233@archlinux>
In-Reply-To: <20190507080225.108000-2-sean@geanix.com>
References: <20190507080225.108000-1-sean@geanix.com>
        <20190507080225.108000-2-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 10:02:25 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This adds support for using iio triggers, this is needed because
> our hardware guys forgot to connect the irq pins from imu device
> to the SoC.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Hi Sean

A small question on the size of the buffer needed inline.  Otherwise looks
good to me.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 1ca69598678f..65ab853202de 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -40,8 +40,11 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> @@ -945,6 +948,30 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
>  	return 0;
>  }
>  
> +static irqreturn_t st_lsm6dsx_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(indio_dev);
> +	u16 buffer[4 * sizeof(s64)/sizeof(u16)];
The size may well be correct, but that particular way of expressing it doesn't make
it terribly clear.

It seems a bit large... You need the space for the timestamp, so it needs to be
padded to a u64, but that would still require your other channels to need
more than 2*sizeof(s64)/sizeof(u16) u16s which is 9 or more of them.

> +	int tmp, bit;
> +
> +	memset(buffer, 0, sizeof(buffer));
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		st_lsm6dsx_read_oneshot(sensor,
> +					indio_dev->channels[bit].address, &tmp);
> +		buffer[bit] = tmp;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns(indio_dev));
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  {
>  	u8 drdy_int_reg;
> @@ -1093,6 +1120,16 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  		err = st_lsm6dsx_fifo_setup(hw);
>  		if (err < 0)
>  			return err;
> +	} else {
> +		for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +			err = devm_iio_triggered_buffer_setup(hw->dev,
> +					hw->iio_devs[i], NULL,
> +					st_lsm6dsx_trigger_handler, NULL);
> +			if (err < 0) {
> +				dev_err(hw->dev, "iio triggered buffer setup failed\n");
> +				return err;
> +			}
> +		}
>  	}
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {

