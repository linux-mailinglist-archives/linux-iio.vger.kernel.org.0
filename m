Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5BF69A3
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 16:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfKJPWW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 10:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfKJPWW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 10:22:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6A0206DF;
        Sun, 10 Nov 2019 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573399341;
        bh=nEDa+tXCJnvYht98rfP2wKCr2CuuZ9MyQB4PLW93SZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jGSFznz649v3h+/bCIiEXQwYo6k8zWR+PiDzkKKn0RVxEqjnktK9Cq0A/RxQwdTH0
         IMD+25FSy8P44yq8EGHC/LzzAYOfGiPGeJwmVvvnBmKhw9q7CuDztIZTR8e9+acV/K
         RWkxB1wAGf0KiEImMY9ZhcPaguPuT08J4mOgBWvw=
Date:   Sun, 10 Nov 2019 15:22:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     fabien.lahoudere@collabora.com, enric.balletbo@collabora.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec_baro: set
 info_mask_shared_by_all_available field
Message-ID: <20191110152216.28ed370f@archlinux>
In-Reply-To: <20191106175533.199257-1-gwendal@chromium.org>
References: <20191106175533.199257-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  6 Nov 2019 09:55:33 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Field was already set for light/proximity and
> accelerometer/gyroscope/magnetometer sensors.
> 
> Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
> cros_ec_sensors frequency range via iio sysfs")
> 
> Change-Id: Iffa4c47979994eaaf1abb609c75c080923ecf600
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Seems independent of the large set you have in flight so applied
to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> Changes in v2:
>  Forgot to add read_avail entry point.
> 
>  drivers/iio/pressure/cros_ec_baro.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 2354302375de..52f53f3123b1 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -114,6 +114,7 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
>  static const struct iio_info cros_ec_baro_info = {
>  	.read_raw = &cros_ec_baro_read,
>  	.write_raw = &cros_ec_baro_write,
> +	.read_avail = &cros_ec_sensors_core_read_avail,
>  };
>  
>  static int cros_ec_baro_probe(struct platform_device *pdev)
> @@ -149,6 +150,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_FREQUENCY);
> +	channel->info_mask_shared_by_all_available =
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>  	channel->scan_type.shift = 0;

