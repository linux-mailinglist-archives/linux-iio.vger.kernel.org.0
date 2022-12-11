Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77264946F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLKNaz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNay (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:30:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F26FD29
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:30:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 373F0CE0B3C
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE86C433EF;
        Sun, 11 Dec 2022 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765449;
        bh=GHFpeq97VDFkrwz8aahDJdeRbzkW758pad4Iux0q2KM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D4F9XTOOiNQB2oHRRYiAHSLQ0jYFqOOvkrb3mCyOAvEJ9fkPiykaVbYAp12te+Cvv
         nTlX+r5Xj0pySQT+rF3ETUnnwpO9bRcGsMUI69RrEcuf6cbBjhbuIJn4wAHTqCWt+3
         VBTCJAvxIvw+IRbIGtjAb+yIkVgpqFuHPfjOy88qVBMrk0yeC/EQtpYRQMjrclFpfL
         Bsrab9FBZ2BggVSIxF6Rev0V+VtIJXUZWckjPlFw7kU4WTO5HcidCprRVK+helW9/D
         pnZlAlUZaEs4rDA+yTj0ABDSWePYOiuafqLeqFYvanBpdLtYU6Oy+36EnxkRyPTJKP
         egCzvcnNnDX8g==
Date:   Sun, 11 Dec 2022 13:43:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: imu: fxos8700: fix swapped ACCEL and MAGN
 channels readback
Message-ID: <20221211134343.516de927@jic23-huawei>
In-Reply-To: <20221208071911.2405922-3-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-3-carlos.song@nxp.com>
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

On Thu,  8 Dec 2022 15:19:06 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> Because ACCEL and MAGN channels data register base address is
> swapped by error judgement, accelerometer and magnetometer
> channels readback is swapped.
> 
> Fix swapped accelerometer and magnetometer channels readback.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
Applied to the fixes-togreg branch of iio.git and marked
for stable.

I tweaked the description a little for readability.

Thanks,

Jonathan

> ---
> Changes for V2:
> - Use a switch statement to instead of an enum to index the base
>   address of the register by the channel type
> - Rework commit log and comments
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 235b02b2f4e5..977eb7dc7dbd 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -395,9 +395,22 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
>  {
>  	u8 base, reg;
>  	int ret;
> -	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
>  
> -	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> +	/*
> +	 * Different register base addresses varies with channel types.
> +	 * This bug hasn't been noticed before because using an enum is
> +	 * really hard to read. Use an a switch statement to take over that.
> +	 */
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		base = FXOS8700_OUT_X_MSB;
> +		break;
> +	case IIO_MAGN:
> +		base = FXOS8700_M_OUT_X_MSB;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	/* Block read 6 bytes of device output registers to avoid data loss */
>  	ret = regmap_bulk_read(data->regmap, base, data->buf,

