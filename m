Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9219CC989
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJELAR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJELAR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:00:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CAB82133F;
        Sat,  5 Oct 2019 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570273216;
        bh=EIjpaa8VFnqXu90vbZsxoYJMJniSwMCzhewiv+ZiAUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dpegw3n6Vsk+YGxpJgkbGcdnsCmxykaKa17rFd7wiHJFgUhaO+4kj9RrRL4VRj5LC
         ILrmBg8rGnoJRwnTfqBONXZ0kO475Q87c/FULL9u2ragQrpRHfX8S+RH7lFkgCow0/
         0POOe3ANGLnoTSyM+AxxyjJgb5pUwhrARKa0T6P8=
Date:   Sat, 5 Oct 2019 12:00:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iio: imu: inv_mpu6050: fix objects syntax in
 Makefile
Message-ID: <20191005120012.7b6cd1ad@archlinux>
In-Reply-To: <20190916094128.30122-5-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
        <20190916094128.30122-5-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:42:04 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Use the correct syntax *-y for declaring object files.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index 70ffe0d13d8c..33bec09fee9b 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -4,10 +4,10 @@
>  #
>  
>  obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
> -inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
> +inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
> -inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
> +inv-mpu6050-i2c-y := inv_mpu_i2c.o inv_mpu_acpi.o
>  
>  obj-$(CONFIG_INV_MPU6050_SPI) += inv-mpu6050-spi.o
> -inv-mpu6050-spi-objs := inv_mpu_spi.o
> +inv-mpu6050-spi-y := inv_mpu_spi.o

