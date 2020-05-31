Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE201E973F
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEaLWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaLWP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:22:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDAFD206F1;
        Sun, 31 May 2020 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590924134;
        bh=qqjFrb4FawDgkfhwmNnKCFw5AoQGX9VgsjzivnRDyiA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ks/fx55JbD2v3q3RZ54b4eH/WbnBZvM5+J1rHKcXNOLIu2nNdXg5ALu63l9kuzrcQ
         xtbaw5pES3wMT2fL88iWaOsY3SpK8wZblThXfU9tJJQCWGhbRCJrbYspDzAh5yuyyw
         CLELd1GQJuMI03tt9R3nDHhmu6vyZThk3QXA4+A8=
Date:   Sun, 31 May 2020 12:22:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: imu: inv_mpu6050: Drop double check for ACPI
 companion device
Message-ID: <20200531122211.580421be@archlinux>
In-Reply-To: <20200528141552.57504-1-andriy.shevchenko@linux.intel.com>
References: <20200528141552.57504-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 17:15:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> acpi_dev_get_resources() does perform the NULL pointer check against
> ACPI companion device which is given as function parameter. Thus,
> there is no need to duplicate this check in the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> index 2f8560ba4572..bf9bdaf6519a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
> @@ -101,8 +101,8 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
>  				       unsigned short *primary_addr,
>  				       unsigned short *secondary_addr)
>  {
> +	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>  	const struct acpi_device_id *id;
> -	struct acpi_device *adev;
>  	u32 i2c_addr = 0;
>  	LIST_HEAD(resources);
>  	int ret;
> @@ -112,10 +112,6 @@ static int inv_mpu_process_acpi_config(struct i2c_client *client,
>  	if (!id)
>  		return -ENODEV;
>  
> -	adev = ACPI_COMPANION(&client->dev);
> -	if (!adev)
> -		return -ENODEV;
> -
>  	ret = acpi_dev_get_resources(adev, &resources,
>  				     acpi_i2c_check_resource, &i2c_addr);
>  	if (ret < 0)

