Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332824AB04D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBFPjG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 10:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 10:39:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA247C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 07:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5123C61172
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 15:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D54C340E9;
        Sun,  6 Feb 2022 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644161942;
        bh=OGqvnmonEtiAhnIWeHetKlqC8ka8nmut+DwwXkxOm24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MJS4SR4eY+XJZuc2tv1BHlIBugpioP18YG/QutpXC6YAKX+ctv8/x+iCmAzHKvbqE
         qvy4k/pkbFaUMVmmGs6mF8xyNF0AIOX8IeI5N4jmooC3fgKWitHLd+2XfQVp98eOL3
         tgzvE2+MhDH+RrsomCpo4rniBv0Fx/iBSBCM0Z/B2wtmVs2X8DAh5Q22+KZTu9y3NP
         hpmtrnhOuzhkloQhTF2wfqxbWTiLeiOi7/QdIffQY7DGr/UzlYbvbVAS0gQX1rKWAw
         YdPr4mJ6S4PJ1CotTBeWmX7YY5l50D2EuAUcMqMUjNM1BdLe04T4KP7CrscT3xS7As
         g3ttglpqFBCPA==
Date:   Sun, 6 Feb 2022 15:45:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 06/12] iio: st_sensors: Stop abusing mlock to ensure
 internal coherency
Message-ID: <20220206154533.3153e610@jic23-huawei>
In-Reply-To: <20220202140208.391394-7-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
        <20220202140208.391394-7-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Feb 2022 15:02:02 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> An odr_lock has been introduced to protect local accesses to the odr
> internal cache and ensure the cached value always reflected the actual
> value. Using the mlock() for this purpose is no longer needed, so let's
> drop these extra mutex_lock/unlock() calls.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Obviously a different issue but all the write_raw() functions should
use the pattern used in st_pressure_core.c and do early
returns seeing as there doesn't seem to be any cleanup to do.

We can tidy that up in a follow up patch as I'm sure there are other
areas in these drivers where direct returns would be nicer than
what is there currently!

Otherwise looks good to me.

> ---
>  drivers/iio/accel/st_accel_core.c       | 5 ++---
>  drivers/iio/gyro/st_gyro_core.c         | 5 ++---
>  drivers/iio/magnetometer/st_magn_core.c | 5 ++---
>  drivers/iio/pressure/st_pressure_core.c | 8 ++------
>  4 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 31ea19d0ba71..d314125269e4 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -1139,10 +1139,9 @@ static int st_accel_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +
>  		err = st_sensors_set_odr(indio_dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> -		return err;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 201050b76fe5..46e3df1bfacb 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -415,10 +415,9 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +
>  		err = st_sensors_set_odr(indio_dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> -		return err;
> +		break;
>  	default:
>  		err = -EINVAL;
>  	}
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 0806a1e65ce4..7b48e7a29cee 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -549,10 +549,9 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +
>  		err = st_sensors_set_odr(indio_dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> -		return err;
> +		break;
>  	default:
>  		err = -EINVAL;
>  	}
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 26a1ee43d56e..05a909eeaff0 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -560,16 +560,12 @@ static int st_press_write_raw(struct iio_dev *indio_dev,
>  			      int val2,
>  			      long mask)
>  {
> -	int err;
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> -		err = st_sensors_set_odr(indio_dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> -		return err;
> +
> +		return st_sensors_set_odr(indio_dev, val);
>  	default:
>  		return -EINVAL;
>  	}

