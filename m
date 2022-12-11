Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619C964946E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLKN3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKN3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:29:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D6FD2A
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:29:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A9A4B80884
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF6C433D2;
        Sun, 11 Dec 2022 13:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765348;
        bh=h6/9BE/WJst4yatIF6OSrGvajFNtqPhJSv7ZvFuxjbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GeOepo3JnS8qDCJh/4ejd8K9OREPecDsCx4oPJt3+hvuR3O6DzxInlb3OOGi5ZPVU
         Zfb+2838vx+Ah7vnULXRbz+yuJFJNoYz+y6HARqq4GYD6J1lj39l+XAW4CVSBrAiPM
         yPamxZKEwmLtsZCw+hFH6laK5g6TivKlgktp0SScbeUVLYB1c0PfwmZBIQ9ikkDT6k
         Pl2tJVyhT26uVNaz8Uq2DvR5iObYSeBlFXNmviTuVs6++yMTUxBJhrVoYMPt3Vkt5l
         qqnoGOkCaRA+Ab281Q5cpunq/RB5QyzYHG7C65skvMG8UixphPU9R4hNYvZL0eqYEN
         yTS2oJ2GEQ4sg==
Date:   Sun, 11 Dec 2022 13:42:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: imu: fxos8700: fix map lable of channel
 type to MAGN sensor
Message-ID: <20221211134202.6b64c717@jic23-huawei>
In-Reply-To: <20221208071911.2405922-2-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-2-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  8 Dec 2022 15:19:05 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> FXOS8700 is an IMU sensor with ACCEL sensor and MAGN sensor.
> Sensor type is indexed by corresponding channel type in a switch.
> IIO_ANGL_VEL channel type mapped to MAGN sensor has caused confusion.
> 
> Fix the mapping lable of "IIO_MAGN" channel type instead of
> "IIO_ANGL_VEL" channel type to MAGN sensor.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
Applied to the fixes-togreg branch of iio.git and marked for stable
inclusion.

Thanks,

Jonathan

> ---
> Changes for V2:
> - Modify the magnetometer sensitivity unit to be consistent with the
>   documentation as 0.001g
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 423cfe526f2a..235b02b2f4e5 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -320,7 +320,7 @@ static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_type)
>  	switch (iio_type) {
>  	case IIO_ACCEL:
>  		return FXOS8700_ACCEL;
> -	case IIO_ANGL_VEL:
> +	case IIO_MAGN:
>  		return FXOS8700_MAGN;
>  	default:
>  		return -EINVAL;

