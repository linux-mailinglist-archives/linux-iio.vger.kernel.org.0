Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49018641D96
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 16:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLDPOT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 10:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDPOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 10:14:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302213F43
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 07:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A8760EA9
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A5C433D6;
        Sun,  4 Dec 2022 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670166857;
        bh=h9n9iGd7yNxGHih5bpKKKNHOdJSoLBnXm8faAHn8tZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RWUvdHCYIXsJGs4/iCOhD/QLFIy5oycnHijN86Tai7MU8jPew4cy1mIvX6w5jubrg
         cgNsuedUNNUl01nP47jJDxN5zQ09t1rZF1+xc+s9ZaOQpydZtNZsicHm5kItAfzgaU
         5kQ/sBk7YoormlCOKiV5FAZGbj28zqe+ycoR39ENwD4raYN42IZdzFwvtv+qOZgEQ7
         Tc+a3C9VKvxTHuYo/avZgxY+RLy1QQ8WKBDo+CXuLY0qdnBDl7ERZOdxEjMPNc+Nvr
         WdQopvgjFu1kLgjJgew0yeUiHWLoDZjtgUeWxFk4dNzL60Y0kur37n8WeSV7tKoq91
         ch94ew5Abb9vA==
Date:   Sun, 4 Dec 2022 15:27:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: imu: fxos8700: fix magnetometer scale getting
 error
Message-ID: <20221204152703.4e83f951@jic23-huawei>
In-Reply-To: <20221202103538.2218925-5-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
        <20221202103538.2218925-5-carlos.song@nxp.com>
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

On Fri,  2 Dec 2022 18:35:38 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> Incorrect iio channel type cause a magnetometer scale getting
> error. Meanwhile magnetometer scale and available magnetometer
> scale should be locked as 0.1uT according to the datasheet.
> 
> Set magn sensor type "IIO_MAGN" and modify magn_scale fixed "0.1uT".
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/iio/imu/fxos8700_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 27e3bd61d054..8d46462dca76 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -319,7 +319,7 @@ static enum fxos8700_sensor fxos8700_to_sensor(enum iio_chan_type iio_type)
>  	switch (iio_type) {
>  	case IIO_ACCEL:
>  		return FXOS8700_ACCEL;
> -	case IIO_ANGL_VEL:
> +	case IIO_MAGN:

Ahah. This had me confused on looking at earlier patch ;)

Amusingly much of the code 'worked' because it was use as a boolean return
so -EINVAL had same affect as FXOS8700_MAGN.

This fix stands on it's own as a separate fix, so I'd rather see it in a
trivial patch of it's own before this one.


>  		return FXOS8700_MAGN;
>  	default:
>  		return -EINVAL;
> @@ -350,7 +350,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (t == FXOS8700_MAGN) {
> -		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
> +		dev_err(dev, "Magnetometer scale is locked at 0.1uT\n");
>  		return -EINVAL;
>  	}
>  
> @@ -393,7 +393,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  
>  	if (t == FXOS8700_MAGN) {
> -		*uscale = 1200; /* Magnetometer is locked at 1200uT */
> +		*uscale = 100000; /* Magnetometer scale is locked at 0.1 uT */
See Documentation/ABI/testing/sysfs-bus-iio
magnetometer channel units are Gauss. 
0.1ut = 0.001g so uscale should be 1000 I think with available changed to match.

>  		return 0;
>  	}
>  
> @@ -563,7 +563,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
>  static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
>  		      "1.5625 6.25 12.5 50 100 200 400 800");
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
> -static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
> +static IIO_CONST_ATTR(in_magn_scale_available, "0.100000")
>  
>  static struct attribute *fxos8700_attrs[] = {
>  	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,

