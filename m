Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70882271
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfHEQcd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 12:32:33 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46610 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHEQcd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 12:32:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 907549E6A78;
        Mon,  5 Aug 2019 17:32:32 +0100 (BST)
Date:   Mon, 5 Aug 2019 17:32:26 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add header include protection
 macro
Message-ID: <20190805173226.71757a05@archlinux>
In-Reply-To: <20190805122513.8399-1-jmaneyrol@invensense.com>
References: <20190805122513.8399-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 12:25:43 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
No problem with adding this,  but why specifically did you do so?

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index db1c6904388b..e64eb978e810 100644
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
> @@ -342,3 +346,5 @@ void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> +
> +#endif

