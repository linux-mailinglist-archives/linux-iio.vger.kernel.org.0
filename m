Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF13CC3D1
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 16:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhGQOdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 10:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhGQOdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 10:33:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB1E60E0C;
        Sat, 17 Jul 2021 14:30:09 +0000 (UTC)
Date:   Sat, 17 Jul 2021 15:32:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, matt.ranostay@konsulko.com,
        andriy.shevchenko@linux.intel.com, vlad.dogaru@intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [PATCH 1/4] iio: add modifiers for linear acceleration
Message-ID: <20210717153232.2860b7ef@jic23-huawei>
In-Reply-To: <20210715141742.15072-2-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20210715141742.15072-2-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Jul 2021 16:17:39 +0200
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
> Cc: Andrea Merello <andrea.merello@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  include/uapi/linux/iio/types.h  | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6d2175eb7af2..e378f48240ad 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_ETHANOL] = "ethanol",
>  	[IIO_MOD_H2] = "h2",
>  	[IIO_MOD_O2] = "o2",
> +	[IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
> +	[IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
> +	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"

So this is an interesting question.  Should we treat this as 'modified' or is
it better treated as a different channel type?

I guess it's similar in some ways to the magn varients for magnetic north and true
north, so we have precedence for modifier.  It's also a little bit similar to
calculating illuminance from intensity channels which we did as two different
channel types.  Anyhow, I'm fine with this, but open to hearing opinions from others!

Either way we definitely need something new.

Thanks,

Jonathan


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
>  };
>  
>  enum iio_event_type {
> @@ -114,4 +117,3 @@ enum iio_event_direction {
>  };
>  
>  #endif /* _UAPI_IIO_TYPES_H_ */
> -

