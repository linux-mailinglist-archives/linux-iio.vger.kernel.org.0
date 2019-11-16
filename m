Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A4BFEBE9
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 12:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKPLmP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 06:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfKPLmO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 06:42:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872EA206D6;
        Sat, 16 Nov 2019 11:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573904534;
        bh=xwWEZmLdfRvFjBKrfuUpm0w5tnQ2hcrbT7NWa3O7GEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YyN2HWxD1+mTBTF8wF3GsjpzIebVgsUbDcg/SlWKfRFqB/930697YHP/BsIkJGHEo
         O7NsTHTF3E0pD+rOGWtcEZGTh4LZSUDnCCZOJT5OvtIodIuiw7me5tmA0HLomsqJtb
         BpZUjL2a76vnXsv/UTUPMTcUssSRFwivyX18ZhH4=
Date:   Sat, 16 Nov 2019 11:42:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 13/18] iio: expose iio_device_set_clock
Message-ID: <20191116114208.1f92d4c4@archlinux>
In-Reply-To: <20191115093412.144922-14-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
        <20191115093412.144922-14-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 01:34:07 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Some IIO devices may want to override the default (realtime) to another
> clock source by default.
> It can beneficial when timestamps coming from the hardware or underlying
> drivers are already in that format.
> It can always be overridden by attribute current_timestamp_clock.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Definitely a step in the right direction.  We may want to also
consider a 'lock' on the value to prevent userspace overriding it, or
to perhaps limit the available choices.

For now though this lets you move forwards

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/industrialio-core.c | 8 +++++++-
>  include/linux/iio/iio.h         | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a46cdf2d8833..92815bdc14ee 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -188,7 +188,12 @@ ssize_t iio_read_const_attr(struct device *dev,
>  }
>  EXPORT_SYMBOL(iio_read_const_attr);
>  
> -static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
> +/**
> + * iio_device_set_clock() - Set current timestamping clock for the device
> + * @indio_dev: IIO device structure containing the device
> + * @clock_id: timestamping clock posix identifier to set.
> + */
> +int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>  {
>  	int ret;
>  	const struct iio_event_interface *ev_int = indio_dev->event_interface;
> @@ -206,6 +211,7 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(iio_device_set_clock);
>  
>  /**
>   * iio_get_time_ns() - utility function to get a time stamp for events etc
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 862ce0019eba..b18f34a8901f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -627,6 +627,8 @@ static inline clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
>  	return indio_dev->clock_id;
>  }
>  
> +int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id);
> +
>  /**
>   * dev_to_iio_dev() - Get IIO device struct from a device struct
>   * @dev: 		The device embedded in the IIO device

