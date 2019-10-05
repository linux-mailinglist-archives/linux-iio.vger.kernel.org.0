Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78264CC97D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJEK6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 06:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJEK6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 06:58:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E7B2133F;
        Sat,  5 Oct 2019 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570273096;
        bh=SBAPTFSFr7iG08e2OS+Z6nnZGofW0KHlpyH7EuglEOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UxDokmgrPh11uUXpoau6IejKBdcy7TT/2qT/ExwdXEATCgb+lUzXSwds+tpLJskzc
         2C1VuPjI0MEJh0Bp60r12HSfzO30mXA8664dHQisjCc+/qdOA0OIEViHVzbCs8myFY
         wKf+pjOtXYBUKKvxUgXupq/khUhZlCf7SXZHT8oI=
Date:   Sat, 5 Oct 2019 11:58:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] iio: imu: inv_mpu6050: add header include
 protection macro
Message-ID: <20191005115812.42f8e408@archlinux>
In-Reply-To: <20190916094128.30122-3-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
        <20190916094128.30122-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:42:00 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index cbbb2fb8949a..7cfd3a05c144 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -2,6 +2,10 @@
>  /*
>  * Copyright (C) 2012 Invensense, Inc.
>  */
> +
> +#ifndef INV_MPU_IIO_H_
> +#define INV_MPU_IIO_H_
> +
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/mutex.h>
> @@ -344,3 +348,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> +
> +#endif

