Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42288641D86
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 15:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLDOuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 09:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLDOuo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 09:50:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3150512D15
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 06:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCED260EA0
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 14:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DC1C433C1;
        Sun,  4 Dec 2022 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670165442;
        bh=rZLaiWXyb4QkDTQy/3Rxsi8IgcXYoc0iaq2YNkCQ2fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFbJC41Cg4GHSHRdbea5Ye3mUTUSDM3L/pEHa+5jjBcDkYUSSqkdEH4jFwxY59DYF
         2bjE/5BHw1D3At6m4Jz3ImEa15ZtX2jgRlEoQ58HdSRLv01psE7zCMcVOn+Vmm+ucB
         CpZpVf78FZCawW+KAaETdVbfSOFb3K2EB1XI37h1xqDN/G78UJpS/1dO+vAy5rPHta
         I6Ze9EynGiMO10CiXfPmeWhVjE27iBdAqJiiFGlehOcUMuNMKlCZpZiMFGDdXPyK1+
         JP5BRlRwJDfnsfvTv+y/fPmm98eA7onDff7Kfqm1wIYEnf9u6WdUJ57YAwv1pI09Eb
         GcpttkX0ias1w==
Date:   Sun, 4 Dec 2022 15:03:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: imu: fxos8700: fix get data function error
Message-ID: <20221204150328.1c917bb7@jic23-huawei>
In-Reply-To: <20221202103538.2218925-2-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
        <20221202103538.2218925-2-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri,  2 Dec 2022 18:35:35 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> Types of raw data include acceleration and magnetism, so base
> address should vary with raw data types rightly.

You need to be much clearer on what you saying here.  I 'think'
the point could be put as:

"Fix swapped accelerometer and magnetometer channels readback."
> The function
> for data acquisition is incorrect because of not considering
> msb data and lsb data. Acceleration raw data is 14 bits and
> magnetism raw data is 16 bits, data reprocessing is necessary
> accordingly.
> 
> Rewrite the function for data acquisition. Base data register
> address is configured correctly varied with acceleration and
> magnetism raw data, and data reprocessing method is added.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Fixes: c9a8417a13ed ("iio: imu: fxos8700: Fix alignment for DMA safety")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Hi Carlos

This needs to be a minimal fix for backporting.  So keep reading all the
channels, just fix the base. We do not want to backport more than
the absolute minimum needed to fix the issue.  So I think that
means one patch to fix the switch registers only and a second
one to apply the shift.

Once that is done you can then send optimizations.

Please also confirm that the scaling is still correct for the
acceleration channels given we are effectively dividing by 4 compared
to the previous code.  If it always assumed 14 bits then just state
that in the cover letter, if it didn't then you need to fix that as well.



> ---
>  drivers/iio/imu/fxos8700_core.c | 39 +++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 423cfe526f2a..a69122799892 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -162,12 +162,10 @@
>  
>  #define FXOS8700_DEVICE_ID          0xC7
>  #define FXOS8700_PRE_DEVICE_ID      0xC4
> -#define FXOS8700_DATA_BUF_SIZE      3
>  
>  struct fxos8700_data {
>  	struct regmap *regmap;
>  	struct iio_trigger *trig;
> -	__be16 buf[FXOS8700_DATA_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);

I'd definitely expect to see a statement in the patch text on why
a DMA safe buffer is no longer required.

Unless things have changed, regmap may require DMA safe buffers for SPI in the
future even if it does not happen to do so today.  That's why we go through
this dance. Now as there are only bulk reads you may be fine, but you
definitely don't do just make this sort of change without a clearly
reasoned explanation.  Also if it is justified, do it in a separate patch 
so that we can clearly analyse that change on it's own.

>  };
>  
>  /* Regmap info */
> @@ -391,25 +389,42 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
>  }
>  
>  static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
> -			     int axis, int *val)
> +				 int axis, int *val)

Avoid white space changes in a patch that does anything else.
I'm also fairly sure this doesn't comply with the kernel preferred convention
of aligning parameters on later lines with the start of the ones after the (


>  {
> -	u8 base, reg;
> +	u8 base, offset;
> +	__be16 buf;
> +	s16 tmp;
>  	int ret;
>  	enum fxos8700_sensor type = fxos8700_to_sensor(chan_type);
>  
> -	base = type ? FXOS8700_OUT_X_MSB : FXOS8700_M_OUT_X_MSB;
> +	/*
> +	 * FXOS8700_M_OUT_X_MSB is magnetic X-axis output data register address.
> +	 * FXOS8700_OUT_X_MSB is acceler X-axis output data register address.
> +	 * Type is 1 for FXOS8700_MAGN, 0 for FXOS8700_ACCEL.
> +	 */
> +	base = type ? FXOS8700_M_OUT_X_MSB : FXOS8700_OUT_X_MSB;

This bug hasn't been noticed before because using an enum is a ternary is
really hard to read. Either use an explicit match or a switch statement.

There is also no point in converting the IIO type to the local one for this.
	switch (chan_type) {
	case IIO_ACCEL:
		base = FXOS8700_OUT_X_MSB;
		break;
	case IIO_ANGL_VEL: /* WHERE DID THIS COME FROM!!! SHOULD BE IIO_MAGN I THINK */
		base = FXOS8700_M_OUT_X_MSB;
		break;
	default:
		return -EINVAL;
	}
	
> -	/* Block read 6 bytes of device output registers to avoid data loss */

If this comment was untrue, please state that very clearly in the patch introduction
seeing as you are changing the logic so that whatever that was warning against
isn't going to happen any more.

> -	ret = regmap_bulk_read(data->regmap, base, data->buf,
> -			       FXOS8700_DATA_BUF_SIZE);
> +	/* Convert axis to offset index */
> +	offset = axis - IIO_MOD_X;
> +
> +	ret = regmap_bulk_read(data->regmap, base + offset, &buf, 2);
sizeof(buf) instead of hardcoded 2.

>  	if (ret)
>  		return ret;
>  
> -	/* Convert axis to buffer index */
> -	reg = axis - IIO_MOD_X;
> +	/*
> +	 * Convert to native endianness. The accel data and magn data
> +	 * are signed, so a forced type conversion is needed.
> +	 */
> +	tmp = be16_to_cpu(buf);
> +
> +	/*
> +	 * Accel raw data is 14 bit, magn raw data is 16 bit, value should be
> +	 * extended to 32 bit.
> +	 */
> +	if (!type)

Store the needed shift in the switch and apply it here unconditionally.
A shift by 0 is fine for the case where it's 16 bits.

> +		tmp = tmp >> 2;
>  
> -	/* Convert to native endianness */
> -	*val = sign_extend32(be16_to_cpu(data->buf[reg]), 15);
> +	*val = sign_extend32(tmp, 15);
>  
>  	return 0;
>  }

