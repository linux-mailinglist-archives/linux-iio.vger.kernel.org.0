Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4264947B
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLKNgL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:36:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A2DE97
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:36:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 142ED60C99
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAEAC433F0;
        Sun, 11 Dec 2022 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765768;
        bh=sQBIOn5+nmAhYjHmY4rs5fOii/cDMDFjSjVe4RrtmGQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mzhx2G/EEGRQ/ZV0IgvgHV3/RZC+plr9xiFO16MbxbWURSxBelfVms/qo8ksyFpb0
         cLlZvt1l/eMguNFFIw5h4lM6mqC86GVI/9eLQCEMsHL6pP+iXrp1+YcVZbHvvadDtp
         h9s/osOBJW2FagpsArbHLC/0zjQivQtStlT2aLNlq5EgKVu7omS86ObslbbL7FI57V
         8sPgAas2brnG1zc6FnGBcMPh3sU8ws571aLQv+wlIQKNiOJKjqY76yNO2LEUovwlJh
         x5wXa0+TGR1UbC7SxsgR6DO2QMu9axK0Q1ZP18ok5e1dqz1TcOYBShdL8iuIVAcAlj
         W+eXmAXFvS9zw==
Date:   Sun, 11 Dec 2022 13:49:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: imu: fxos8700: fix IMU data bits returned
 to user space
Message-ID: <20221211134902.0ada6e44@jic23-huawei>
In-Reply-To: <20221208071911.2405922-5-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-5-carlos.song@nxp.com>
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

On Thu,  8 Dec 2022 15:19:08 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> ACCEL output data registers contain the X-axis, Y-axis, and Z-axis
> 14-bit left-justified sample data and MAGN output data registers
> contain the X-axis, Y-axis, and Z-axis 16-bit sample data. The ACCEL
> raw register output data should be divided by 4 before sent to
> userspace.
> 
> Apply a 2 bits signed right shift to the raw data from ACCEL output
> data register but keep that from MAGN sensor as the origin.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
I made one tweak (see below). 

Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

> ---
> Changes for V2:
> - Store the shift in the switch and apply a shift by 2 for ACCEL
>   and shift by 0 for MAGN
> - Confirm the scaling is still correct for the acceleration channels
>   given we are effectively dividing by 4 compared to the previous code
> - Rework the comment
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index b62bc92bbacc..d2e784628820 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -394,6 +394,7 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
>  			     int axis, int *val)
>  {
>  	u8 base, reg;
> +	s16 tmp;
>  	int ret;
>  
>  	/*
> @@ -421,8 +422,33 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
>  	/* Convert axis to buffer index */
>  	reg = axis - IIO_MOD_X;
>  
> +	/*
> +	 * Convert to native endianness. The accel data and magn data
> +	 * are signed, so a forced type conversion is needed.
> +	 */
> +	tmp = be16_to_cpu(data->buf[reg]);
> +
> +	/*
> +	 * ACCEL output data registers contain the X-axis, Y-axis, and Z-axis
> +	 * 14-bit left-justified sample data and MAGN output data registers
> +	 * contain the X-axis, Y-axis, and Z-axis 16-bit sample data. Apply
> +	 * a signed 2 bits right shift to the readback raw data from ACCEL
> +	 * output data register and keep that from MAGN sensor as the origin.
> +	 * Value should be extended to 32 bit.
> +	 */
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		tmp = tmp >> 2;
> +		break;
> +	case IIO_MAGN:
> +		tmp = tmp >> 0;
I replaced this no operation line with a comment
/* Nothing to do */ 

otherwise it's the sort of thing some static checker might moan about :)

Jonathan

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	/* Convert to native endianness */
> -	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
> +	*val = sign_extend32(tmp, 15);
>  
>  	return 0;
>  }

