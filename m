Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD514174A
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgARLia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:38:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgARLi3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:38:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2264824694;
        Sat, 18 Jan 2020 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579347509;
        bh=iIeg+1dnT7OfcbdP0DXFsamukGRmduf5h01dYC6zKIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0He+lfHV+VXLC+Lfx6CVJ14abmFPPWeak+I7ZjKN6i5gVygu39YT05h62tl5y5GuZ
         6rnGtDQEb9/2WIzUP5yWhqrsype863uTLr1B9y6tyX9zjouyeWb29Q1q+jopS4dCEF
         wsmiH5aIVDMcw/kre/owSu4boXloCxPkkW9WgJL0=
Date:   Sat, 18 Jan 2020 11:38:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/2] iio: magnetometer: ak8975: Get rid of platform
 data
Message-ID: <20200118113823.5b68bdd1@archlinux>
In-Reply-To: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
References: <20200115174425.70728-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jan 2020 19:44:24 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since IIO framework supports device property API and driver has been moved
> already to the use of GPIO descriptors the logical continuation is to
> get rid of platform data completely. We are on the safe side here since
> there are no users of it in the kernel.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hmm. Fair enough I guess.

Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c       | 14 +++-----------
>  include/linux/iio/magnetometer/ak8975.h | 15 ---------------
>  2 files changed, 3 insertions(+), 26 deletions(-)
>  delete mode 100644 include/linux/iio/magnetometer/ak8975.h
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 55cffaa82456..8e50e073bcbf 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -28,8 +28,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> -#include <linux/iio/magnetometer/ak8975.h>
> -
>  /*
>   * Register definitions, as well as various shifts and masks to get at the
>   * individual fields of the registers.
> @@ -857,8 +855,6 @@ static int ak8975_probe(struct i2c_client *client,
>  	int err;
>  	const char *name = NULL;
>  	enum asahi_compass_chipset chipset = AK_MAX_TYPE;
> -	const struct ak8975_platform_data *pdata =
> -		dev_get_platdata(&client->dev);
>  
>  	/*
>  	 * Grab and set up the supplied GPIO.
> @@ -883,13 +879,9 @@ static int ak8975_probe(struct i2c_client *client,
>  	data->eoc_gpiod = eoc_gpiod;
>  	data->eoc_irq = 0;
>  
> -	if (!pdata) {
> -		err = iio_read_mount_matrix(&client->dev, "mount-matrix",
> -					    &data->orientation);
> -		if (err)
> -			return err;
> -	} else
> -		data->orientation = pdata->orientation;
> +	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
> +	if (err)
> +		return err;
>  
>  	/* id will be NULL when enumerated via ACPI */
>  	if (id) {
> diff --git a/include/linux/iio/magnetometer/ak8975.h b/include/linux/iio/magnetometer/ak8975.h
> deleted file mode 100644
> index df3697183800..000000000000
> --- a/include/linux/iio/magnetometer/ak8975.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __IIO_MAGNETOMETER_AK8975_H__
> -#define __IIO_MAGNETOMETER_AK8975_H__
> -
> -#include <linux/iio/iio.h>
> -
> -/**
> - * struct ak8975_platform_data - AK8975 magnetometer driver platform data
> - * @orientation: mounting matrix relative to main hardware
> - */
> -struct ak8975_platform_data {
> -	struct iio_mount_matrix orientation;
> -};
> -
> -#endif

