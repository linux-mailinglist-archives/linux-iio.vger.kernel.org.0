Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F101861241B
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2PIi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 11:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJ2PIh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 11:08:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD352EF50
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 08:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EADDB80D21
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 15:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067A5C433C1;
        Sat, 29 Oct 2022 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667056114;
        bh=JG9pkM6VeWGNi5Fij8s5kyZnIYMFuHWHCaRvq8cZLOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AlrI6HLjc3P0RGfu9m1Ac8y9xs0hXmfB6zTOUsVbthRnas/6QzFVzUKuwzXYDTlEv
         1O65uZzWK/q29syEUMXgfFnzrAsuMEIXNJUYl0JUNy5X6EOuXj6JcQvWOQkkFmneSB
         iliq90WE/8EFetTXq4wvpDRtY+FNrBuDtDZ0m4Q3EJyICzGFIgCTfXQDDP2FHDNou+
         LKXYTtmaKazL3cnJAeauQMAIl79RDPPwDB2nUbp7lnazjdyDEJRWR8TsASzG6Hy1qM
         CDhMfMSgTbljhai70M6uVDyDvMkMpFsAIIveD8sr5VsA0zmr7bd1ZRso8dPtGO4knX
         BCpKQa3ME6mCA==
Date:   Sat, 29 Oct 2022 16:20:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce sw trigger support
Message-ID: <20221029162029.31f8291a@jic23-huawei>
In-Reply-To: <93ae6ff1150b531a9d7a4d3d1b1adb8383613717.1666955685.git.lorenzo@kernel.org>
References: <93ae6ff1150b531a9d7a4d3d1b1adb8383613717.1666955685.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Oct 2022 13:23:42 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> There are some hw configuration where irq0 and/or irq1 pins are not
> connected to the SPI or I2C/I3C controller.

The might be connected to lots of other places on the application processor
(doesn't really matter though - I think your meaning is clear enough!)

> In order to avoid polling
> the output register introduce iio-sw trigger support when irq line is
> not available (or hw FIFO is not supported).
> 
> Suggested-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

One comment / question inline.  Otherwise looks good to me.

Jonathan


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 78 ++++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  4 +-
>  3 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 07ad8027de73..6399b0bb6f67 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -424,7 +424,7 @@ struct st_lsm6dsx_hw {
>  	struct {
>  		__le16 channels[3];
>  		s64 ts __aligned(8);
> -	} scan[3];
> +	} scan[ST_LSM6DSX_ID_MAX];
>  };
>  

>  static inline int
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index fe5fa08b68ac..73fd5f038375 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -53,6 +53,8 @@
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/minmax.h>
> @@ -2117,6 +2119,32 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> +static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
> +							void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *iio_dev = pf->indio_dev;
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT2)
> +		st_lsm6dsx_shub_read_output(hw,
> +					    (u8 *)hw->scan[sensor->id].channels,
> +					    sizeof(hw->scan[sensor->id].channels));

Are we guaranteed this particular size of readback?  I'm guessing a bit
as it's been a long time since I looked at this driver in detail, but could
we have sensors with either a different number of axes or different number
of registers per axis?

It might be neater to have two handlers, one for the EXTN cases and one
for the main sensors.  That would push this conditional down to the
point of registration.  I'm not sure it's worth it however so up to you...


> +	else
> +		st_lsm6dsx_read_locked(hw, iio_dev->channels[0].address,
> +				       hw->scan[sensor->id].channels,
> +				       sizeof(hw->scan[sensor->id].channels));
> +
> +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan[sensor->id],
> +					   iio_get_time_ns(iio_dev));
> +	iio_trigger_notify_done(iio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  {
>  	struct st_sensors_platform_data *pdata;
> @@ -2175,6 +2203,46 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  	return 0;
>  }

> +static int st_lsm6dsx_sw_buffers_setup(struct st_lsm6dsx_hw *hw)
> +{
> +	int i;
> +
> +	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		int err;
> +
> +		if (!hw->iio_devs[i])
> +			continue;
> +
> +		err = devm_iio_triggered_buffer_setup(hw->dev,
> +					hw->iio_devs[i], NULL,
> +					st_lsm6dsx_sw_trigger_handler_thread,
> +					&st_lsm6dsx_sw_buffer_ops);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
...

