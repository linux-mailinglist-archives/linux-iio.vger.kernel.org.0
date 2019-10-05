Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE58CC9A4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJELfv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfJELfu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:35:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99C22133F;
        Sat,  5 Oct 2019 11:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570275350;
        bh=EswCIZpfs8myiiOIKl3MGubTUm65NpfDHNAkXjrAnFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2d9GvVnyi3NW+RjvAucK5yB31rLwy4+c3hD0K/XSaSA4Yu2oeYhUsHegkvjhF28J
         PuHUgdjEdInGbsMOSProkefD54njOV2Mcdr0uiIsfJV9Yyi9/SWJZJznNtsXTht3IN
         7YMnVq1iSZFJqpTKPDzJMwAyULYHLx88QJHHcWTs=
Date:   Sat, 5 Oct 2019 12:35:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
Subject: Re: [PATCH v10 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
Message-ID: <20191005123545.1cbbae45@archlinux>
In-Reply-To: <20190916135630.2211714-3-sean@geanix.com>
References: <20190916135630.2211714-1-sean@geanix.com>
        <20190916135630.2211714-3-sean@geanix.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 15:56:28 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> This add ways for the SoC to wake from accelerometer wake events.
> 
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke it.

Thanks,

Jonathan

> ---
> Changes since v4:
>  * More devices supports wakeup
> 
> Changes since v5:
>  * None
> 
> Changes since v6:
>  * None
> 
> Changes since v7:
>  * Add check for hw->enable_event
>  * Moved disable_irq_wake section so it's called
>  * Removed not neeeded continue from disable_irq_wake section
> 
> Changes since v8:
>  * Using sensor->id instead of i in suspend/resume loops
> 
> Changes since v9:
>  * None
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4198ba263d03..a7f12cf57f11 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> +	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
> +		device_init_wakeup(dev, true);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
> @@ -1876,6 +1879,13 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
>  
> +		if (device_may_wakeup(dev) &&
> +		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
> +			/* Enable wake from IRQ */
> +			enable_irq_wake(hw->irq);
> +			continue;
> +		}
> +
>  		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
>  		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
>  		    sensor->id == ST_LSM6DSX_ID_EXT2)
> @@ -1905,6 +1915,10 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
>  			continue;
>  
>  		sensor = iio_priv(hw->iio_devs[i]);
> +		if (device_may_wakeup(dev) &&
> +		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
> +			disable_irq_wake(hw->irq);
> +
>  		if (!(hw->suspend_mask & BIT(sensor->id)))
>  			continue;
>  

