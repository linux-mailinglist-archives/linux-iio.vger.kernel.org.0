Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D58342E22
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCTQDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 12:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhCTQDk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 12:03:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CBC6196A;
        Sat, 20 Mar 2021 16:03:38 +0000 (UTC)
Date:   Sat, 20 Mar 2021 16:03:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Use as standalone trigger
Message-ID: <20210320160336.6f53dad5@jic23-huawei>
In-Reply-To: <20210319133357.541183-1-linus.walleij@linaro.org>
References: <20210319133357.541183-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 14:33:57 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> It may happen that the MPU6050 is the only hardware
> trigger available on your system such as this:
> 
> > lsiio  
> Device 003: hscdtd008a
> Device 001: mpu6050
> Device 002: gp2ap002
> Device 000: ab8500-gpadc
> Trigger 000: mpu6050-dev1
> 
> And when you want to use it to read periodically from
> your magnetometer like this:
> 
> > iio_generic_buffer -a -c 100 -n hscdtd008a -t mpu6050-dev1  
> 
> Then the following happens:
> 
> [  209.951334] Internal error: Oops: 5 [#1] SMP ARM
> (...)
> [  209.981969] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
> [  209.988925] PC is at inv_scan_query_mpu6050+0x8/0xb8
> [  209.993914] LR is at inv_mpu6050_set_enable+0x40/0x194
> 
> This is because since we are not using any channels from the
> same device, the indio_dev->active_scan_mask is NULL.
> 
> Just checking for that and bailing out is however not enough:
> we have to enable some kind of FIFO for the readout to work.
> So enable the temperature as a dummy FIFO and all works
> fine.

Ah. This corner case. I have a suspicion a lot of drivers
suffer from this case.  I confess I'm often too lazy to
look at it in a great deal of depth because it's not a particularly
common thing to do - and we long ago dropped the equivalent
triggers that just used a periodic interrupt on the basis that
they didn't add any significant improvement in precision of
capture over an hrtimer based trigger.

Mind you we should definitely close down the bug either way.

Jonathan

> 
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index f7b5a70be30f..6946d50b874a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -11,6 +11,17 @@ static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  	unsigned int mask;
>  
> +	/*
> +	 * If the MPU6050 is just used as a trigger, then the scan mask
> +	 * is not allocated so we simply enable the temperature channel
> +	 * as a dummy and bail out.
> +	 */
> +	if (!indio_dev->active_scan_mask) {
> +		st->chip_config.temp_fifo_enable = true;
> +		mask = INV_MPU6050_SENSOR_TEMP;
> +		return mask;
> +	}
> +
>  	st->chip_config.gyro_fifo_enable =
>  		test_bit(INV_MPU6050_SCAN_GYRO_X,
>  			 indio_dev->active_scan_mask) ||

