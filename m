Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A486DE254
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 19:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDKRTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjDKRTT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 13:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC410FA
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 10:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B5D624C6
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 17:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86544C433D2;
        Tue, 11 Apr 2023 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681233529;
        bh=EC5PTCkjKA8JJ4kkGh/REz01Lo22fZyP4lPj6bSdQ2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G1GON77nnbNKw7gPd4yqNx1z6ckzz19mMH6jw1sAZZsu82Rlxn0lJRvYMS0nZXAw6
         eTmQBZ88FisXphsVvtN8pa8Nbd7luKfMJ0KCS9tUgIwp3y5bpLDOeIQGzr8sbf5D9u
         4Ke7Th+ygDMVAtmSeiGq3n4SzzwOl3GAQChKHlNFMQ86Il3JmMjin38LsUkEhOuqUJ
         eV/j4+qPqOvgTNCX0JSYqyuPe26q1YsqtcajFuNpLz4olDw+dyrKo3ZHlbPGI52E3U
         4xWz22d2id3ajLQECeh4/gZ71nExaLn9KUseM7gjSAePCmxcUipH+7767Pyu04FDkD
         1vTW6YR53vNEw==
Date:   Tue, 11 Apr 2023 18:34:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
Message-ID: <20230411183410.289214e5@jic23-huawei>
In-Reply-To: <20230130201018.981024-3-jic23@kernel.org>
References: <20230130201018.981024-1-jic23@kernel.org>
        <20230130201018.981024-3-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Jan 2023 20:10:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> DSDT ROTM method seen in the wild with SMO8B30 _HID.
> Making assumption it is similar to that used for bmc150 plus
> information from Darrell that the rotation is out by 90 degrees at boot.
> 
> Method (ROTM, 0, NotSerialized)
> {
>     Name (RBUF, Package (0x03)
>     {
>         "0 -1 0",
>         "1 0 0",
>         "0 0 1"
>     })
>     Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
> }
> 
> Reported-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not my best work. 0-day pointed out a few things.

> 
> ---
> Untested.  Fingers crossed.
> 
> We could factor this out if it keeps turning up.  The bmc150 varient
> is more complex as multiple method IDs exist depending on the configuration.
> 
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 65 +++++++++++++++++++-
>  1 file changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 3f6060c64f32..3c2d67f8d9b7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -56,6 +56,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> @@ -2602,6 +2603,61 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
>  	return 0;
>  }
>  
> +static bool lsm6dsx_get_acpi_mount_matrix(struct device *dev,
int not bool.

Also needs ifdef CONFIG_ACPI protections as some of the acpi functions are not stubbed out.

I've tweaked those two things and pushed out again.
If there is anything else I'll probably drop this patch and come back to it
next cycle.



> +					  struct iio_mount_matrix *orientation)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	union acpi_object *obj, *elements;
> +	acpi_status status;
> +	int i, j, val[3];
> +	char *str;
> +
> +	if (!has_acpi_companion(dev))
> +		return -EINVAL;
> +
> +	if (!acpi_has_method(adev->handle, "ROTM"))
> +		return -EINVAL;
> +
> +	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
> +		return -EINVAL;
> +	}
> +
> +	obj = buffer.pointer;
> +	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
> +		goto unknown_format;
> +
> +	elements = obj->package.elements;
> +	for (i = 0; i < 3; i++) {
> +		if (elements[i].type != ACPI_TYPE_STRING)
> +			goto unknown_format;
> +
> +		str = elements[i].string.pointer;
> +		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
> +			goto unknown_format;
> +
> +		for (j = 0; j < 3; j++) {
> +			switch (val[j]) {
> +			case -1: str = "-1"; break;
> +			case 0:  str = "0";  break;
> +			case 1:  str = "1";  break;
> +			default: goto unknown_format;
> +			}
> +			orientation->rotation[i * 3 + j] = str;
> +		}
> +	}
> +
> +	kfree(buffer.pointer);
> +	return 0;
> +
> +unknown_format:
> +	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
> +	kfree(buffer.pointer);
> +	return -EINVAL;
> +}
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -2676,9 +2732,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> -	err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> -	if (err)
> -		return err;
> +	err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
> +	if (err) {
> +		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
> +		if (err)
> +			return err;
> +	}
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		if (!hw->iio_devs[i])

