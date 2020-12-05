Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5437B2CFD4D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgLESao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgLES3y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F63229C4;
        Sat,  5 Dec 2020 18:29:12 +0000 (UTC)
Date:   Sat, 5 Dec 2020 18:29:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        linus.walleij@linaro.org, denis.ciocca@st.com
Subject: Re: [PATCH v2] iio: common: st_sensors: fix possible infinite loop
 in st_sensors_irq_thread
Message-ID: <20201205182907.5d2c948e@archlinux>
In-Reply-To: <58d40383f6e1faa14850f3a9b694b8e4cb4fbbec.1607162799.git.lorenzo@kernel.org>
References: <58d40383f6e1faa14850f3a9b694b8e4cb4fbbec.1607162799.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  5 Dec 2020 11:10:41 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Return a boolean value in st_sensors_new_samples_available routine in
> order to avoid an infinite loop in st_sensors_irq_thread if
> stat_drdy.addr is not defined or stat_drdy read fails
> 
> Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Oops. I should not noticed this and replied here.
See reply to previous version.  I think this will create an infinite
loop in the obscure case of no status register + an edge interrupt.
My gut feeling is we can't support that combination so should fail
at probe time if it is specified.  It's broken hardware / dt.

Jonathan

> ---
> Changes since v1:
> - return true if the sensor does not have stat_drdy register
> ---
>  .../common/st_sensors/st_sensors_trigger.c    | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 0507283bd4c1..d3f047e9d778 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -23,35 +23,31 @@
>   * @sdata: Sensor data.
>   *
>   * returns:
> - * 0 - no new samples available
> - * 1 - new samples available
> - * negative - error or unknown
> + * false - no new samples available or read error
> + * true - new samples available
>   */
> -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> -					    struct st_sensor_data *sdata)
> +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> +					     struct st_sensor_data *sdata)
>  {
>  	int ret, status;
>  
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> -		return -EINVAL;
> +		return true;
>  
>  	/* No scan mask, no interrupt */
>  	if (!indio_dev->active_scan_mask)
> -		return 0;
> +		return false;
>  
>  	ret = regmap_read(sdata->regmap,
>  			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
>  			  &status);
>  	if (ret < 0) {
>  		dev_err(sdata->dev, "error checking samples available\n");
> -		return ret;
> +		return false;
>  	}
>  
> -	if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> -		return 1;
> -
> -	return 0;
> +	return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);
>  }
>  
>  /**

