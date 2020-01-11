Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34987138155
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 13:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgAKMPY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 07:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgAKMPY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 07:15:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DED20678;
        Sat, 11 Jan 2020 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578744923;
        bh=oMKHT38K8YjLo43EbfHwiqlyic+/+ZE9C7+CeSiZayc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QEymRDYK5DsVLAu86mlLc9wWagST/FTM3JqpW6pZN0sYpRfGFGFjNkaTkaUT0hRZL
         zqaP7YqHj8O6wGGXo+Ge9NZ72DDHX1e9gpPUOqs2H8Kp8TE98IexFTFaBSSm3hvGoO
         qCufp1IV96HVebl5rvFA0b59PpMOi7Y361fQkQwo=
Date:   Sat, 11 Jan 2020 12:15:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: add mount matrix support
Message-ID: <20200111121518.34162e02@archlinux>
In-Reply-To: <20200104132052.28337-1-martin.kepplinger@puri.sm>
References: <20200104132052.28337-1-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jan 2020 14:20:52 +0100
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> Allow to read the mount-matrix device tree property and provide the
> mount_matrix file for userspace to read.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> tested using the lsm9ds1 on the librem5-devkit (and userspace tools like
> iio-sensor-proxy) where this will be needed.
> 
> thanks,
> 
>                                        martin
> 
> revision history
> ----------------
> v2: additions and simplifications according to Lorenzo's review. thanks.
> 
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 19 +++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index a763ff46f596..7076fc8c4c3b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -76,6 +76,7 @@ enum st_lsm6dsx_hw_id {
>  		.endianness = IIO_LE,					\
>  	},								\
>  	.event_spec = &st_lsm6dsx_event,				\
> +	.ext_info = st_lsm6dsx_accel_ext_info,				\
>  	.num_event_specs = 1,						\
>  }
>  
> @@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
>   * @enable_event: enabled event bitmask.
>   * @iio_devs: Pointers to acc/gyro iio_dev instances.
>   * @settings: Pointer to the specific sensor settings in use.
> + * @orientation: sensor chip orientation relative to main hardware.
>   */
>  struct st_lsm6dsx_hw {
>  	struct device *dev;
> @@ -406,6 +408,8 @@ struct st_lsm6dsx_hw {
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>  
>  	const struct st_lsm6dsx_settings *settings;
> +
> +	struct iio_mount_matrix orientation;
>  };
>  
>  static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
> @@ -479,4 +483,19 @@ st_lsm6dsx_write_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
>  	return err;
>  }
>  
> +static const inline struct iio_mount_matrix *
> +st_lsm6dsx_get_mount_matrix(const struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +
> +	return &hw->orientation;
> +}
> +
> +static const struct iio_chan_spec_ext_info st_lsm6dsx_accel_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
> +	{ }
> +};
> +
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 0c64e35c7599..27e157f8a031 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2325,7 +2325,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  	    (pdata && pdata->wakeup_source))
>  		device_init_wakeup(dev, true);
>  
> -	return 0;
> +	return iio_read_mount_matrix(hw->dev, "mount-matrix", &hw->orientation);

Race condition.  iio_device_register has already been called by this point.
Hence userspace interfaces are exposed.  Userspace can read the mount matrix
before it is initialized.  This needs to be earlier in probe.

Jonathan

>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
>  

