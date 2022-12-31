Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF62B65A512
	for <lists+linux-iio@lfdr.de>; Sat, 31 Dec 2022 15:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiLaOiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Dec 2022 09:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaOiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2022 09:38:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95530CE06
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 06:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56B67B8074C
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2022 14:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1131C433EF;
        Sat, 31 Dec 2022 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672497476;
        bh=Puqr3BotDbDyGcuTI2we8Xoso7YG9+IoMs9z14jc3Jc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzJaNvr2v0AxmC0K3Wt0V08WbFArcrRn4rO0G9HNgzeIuxukHD7h0iVJVxWg6uW8I
         9Ydv8dU9VhJdDc6dKcs2T8nIhrtHb34DCQKIk4PXPquT24AQkq3VHXs6jbb8lvQCGK
         r4VWrxTedL9LfSE4swtg7VdH0iIeoQz83eRotDGpnN22tO8QhMkJGGGBfGdEFq08t5
         OuE5kycRPhacM7PJVP9cLN3Xi1I5R08dM6QmGc4wZnuH2wD4tzKX3GwOElk1LHOUHu
         61uvmXp8J6p1WZHYlOFo6LVGomg2sJwRuY49q5GItBsuFKClcjdu3Y6MGt0f7dPeIP
         DTU6+REVIvVjQ==
Date:   Sat, 31 Dec 2022 14:51:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR mode
 readback
Message-ID: <20221231145115.7d9414e5@jic23-huawei>
In-Reply-To: <20221228093941.270046-2-carlos.song@nxp.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-2-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Wed, 28 Dec 2022 17:39:38 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> The absence of a correct offset leads an incorrect ODR mode
> readback after use a hexadecimal number to mark the value from
> FXOS8700_CTRL_REG1.
> 
> Get ODR mode by field mask and FIELD_GET clearly and conveniently.
> And attach other additional fix for keeping the original code logic
> and a good readability.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
Hi Carlos,

I'm fairly sure the new code doesn't quite work correctly. See inline.

Jonathan

> ---
> Changes for V4:
> - Use ODR_MSK in the first place that merged the first two patches
>   in V3 into this patch.
> - Rework commit log
> Changes for V3:
> - Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a
>   field mask
> - Legal use of filed mask and FIELD_PREP() to select ODR mode
> - Rework commit log
> ---
>  drivers/iio/imu/fxos8700_core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 773f62203bf0..a1af5d0fde5d 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/regmap.h>
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -144,9 +145,9 @@
>  #define FXOS8700_NVM_DATA_BNK0      0xa7
>  
>  /* Bit definitions for FXOS8700_CTRL_REG1 */
> -#define FXOS8700_CTRL_ODR_MSK       0x38
>  #define FXOS8700_CTRL_ODR_MAX       0x00
>  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> +#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
>  
>  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
>  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> @@ -508,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (i >= odr_num)
>  		return -EINVAL;
>  
> -	return regmap_update_bits(data->regmap,
> -				  FXOS8700_CTRL_REG1,
> -				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> -				  fxos8700_odr[i].bits << 3 | active_mode);
> +	val = val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | active_mode;

val |= would be neater.

Also, if I read the existing code correctly, val hasn't been masked, so if active_mode was
set in val, it still will be, hence no need to or it in again.
You also haven't masked out _CTRL_ODR_MSK so as a result of this call you will get the
bitwise or of whatever ODR value you are trying to set and whatever it was set to before.


> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
>  }
>  
>  static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
> @@ -524,7 +523,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (ret)
>  		return ret;
>  
> -	val &= FXOS8700_CTRL_ODR_MSK;
> +	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
>  
>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)

