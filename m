Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF443DF17
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhJ1KoA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1KoA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 06:44:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80176610CA;
        Thu, 28 Oct 2021 10:41:30 +0000 (UTC)
Date:   Thu, 28 Oct 2021 11:45:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 04/10] iio: add modifiers for linear acceleration
Message-ID: <20211028114557.5b4db778@jic23-huawei>
In-Reply-To: <20211028101840.24632-5-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-5-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:34 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch is preparatory for adding the Bosh BNO055 IMU driver.
> The said IMU can report raw accelerations (among x, y and z axis)
> as well as the so called "linear accelerations" (again, among x,
> y and z axis) which is basically the acceleration after subtracting
> gravity.
> 
> This patch adds IIO_MOD_ACCEL_LINEAR_X, IIO_MOD_ACCEL_LINEAR_Y and
> IIO_MOD_ACCEL_LINEAR_Z modifiers to te IIO core.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>

They sometimes get forgotten but we should also update
tools/iio/iio_event_montitor.c to handle these new modifiers.

That can be a separate patch, but also fine to do it in this one.

> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  include/uapi/linux/iio/types.h  | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2dbb37e09b8c..a79cb32207e4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_ETHANOL] = "ethanol",
>  	[IIO_MOD_H2] = "h2",
>  	[IIO_MOD_O2] = "o2",
> +	[IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
> +	[IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
> +	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 48c13147c0a8..db00f7c45f48 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -95,6 +95,9 @@ enum iio_modifier {
>  	IIO_MOD_ETHANOL,
>  	IIO_MOD_H2,
>  	IIO_MOD_O2,
> +	IIO_MOD_ACCEL_LINEAR_X,
> +	IIO_MOD_ACCEL_LINEAR_Y,
> +	IIO_MOD_ACCEL_LINEAR_Z,

It might be useful for other channel types, so probably drop the ACCEL
part of the name.

I'll admit I can't immediately think of what, but you never know.. :)

>  };
>  
>  enum iio_event_type {
> @@ -114,4 +117,3 @@ enum iio_event_direction {
>  };
>  
>  #endif /* _UAPI_IIO_TYPES_H_ */
> -
?


