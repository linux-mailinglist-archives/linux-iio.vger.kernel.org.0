Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDA43DF21
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1KpF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1KpE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 06:45:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B396B60F58;
        Thu, 28 Oct 2021 10:42:34 +0000 (UTC)
Date:   Thu, 28 Oct 2021 11:47:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 05/10] iio: add modifers for pitch, yaw, roll
Message-ID: <20211028114700.788635ba@jic23-huawei>
In-Reply-To: <20211028101840.24632-6-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-6-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:35 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch adds modifiers for reporting rotations as euler angles (i.e.
> yaw, pitch and roll).
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Same comment on tools update, and a few editorial things inline.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 5 ++++-
>  include/uapi/linux/iio/types.h  | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a79cb32207e4..d2ebbfa8b9fc 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -136,7 +136,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_O2] = "o2",
>  	[IIO_MOD_ACCEL_LINEAR_X] = "linear_x",
>  	[IIO_MOD_ACCEL_LINEAR_Y] = "linear_y",
> -	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z"
> +	[IIO_MOD_ACCEL_LINEAR_Z] = "linear_z",

Move the comman to the previous patch.

> +	[IIO_MOD_PITCH] = "pitch",
> +	[IIO_MOD_YAW] = "yaw",
> +	[IIO_MOD_ROLL] = "roll"
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index db00f7c45f48..fc9909ca4f95 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -98,6 +98,9 @@ enum iio_modifier {
>  	IIO_MOD_ACCEL_LINEAR_X,
>  	IIO_MOD_ACCEL_LINEAR_Y,
>  	IIO_MOD_ACCEL_LINEAR_Z,
> +	IIO_MOD_PITCH,
> +	IIO_MOD_YAW,
> +	IIO_MOD_ROLL

And add a comma here to make extending this in future easy.

>  };
>  
>  enum iio_event_type {

