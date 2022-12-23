Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F306552F2
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiLWQsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWQsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:48:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEAB2734
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 785FCB820DF
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 16:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0393BC433EF;
        Fri, 23 Dec 2022 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671814087;
        bh=hMmkUhms2Nh5RW9yPUyrhMHIgIpFZQL241CnOhPvW54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MAAbpGi+y9OQuMw9MsFO7bpYNeunRnVqcxnj50ZBmznoOdJwbs/tOxLPMY6RC2cNV
         dRXuZDhY8BCXCmydTGQc0MRCFLKz3auO9DiXtBBX2I+fTvfSOVAAG8tCC0eAp6+a1f
         oStrYKiWnbNCAZKyPu2tqTdGoLHz3Lw542dA2wkXCQaBpOXD5cO9giV+G1zgnetyCL
         Egpr0pVySCZevjCk6Vy01ZoDOEVTK3ucSzl1LN/u0cytAvEni59achemOzaodzBjjk
         7WSdmicnYgC3uZBpsMP43e2KzlquQHtZTcwA61Rcyyp2Bzr98vhRS4Q2e6BjikiPiO
         kxi7fIE02Tf+w==
Date:   Fri, 23 Dec 2022 17:01:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: imu: fxos8700: fix MAGN sensor scale and
 unit
Message-ID: <20221223170116.5eed8649@jic23-huawei>
In-Reply-To: <20221214031503.3104251-6-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
        <20221214031503.3104251-6-carlos.song@nxp.com>
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

On Wed, 14 Dec 2022 11:15:03 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> +/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
> is the magnetic sensitivity parameter. It is referenced as 0.1uT
> according to datasheet and magnetometer channel unit is Gauss in
> sysfs-bus-iio documentation. Gauss and uTesla unit conversion
> relationship as follows: 0.1uT = 0.001Gs.
> 
> Set magnetometer scale and available magnetometer scale as fixed 0.001Gs.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> 
---

as for all the other patches.

3,4,5 look fine to me other than that.  So I'll pick them up once
the patch 1/2 split is sorted out.

Jonathan


> Changes for V2:
> - Modify the magnetometer sensitivity unit to be consistent with the
>   documentation as 0.001g
> - Rework commit log
> Changes for V3:
> - Modify the magnetometer sensitivity unit "g" to standard unit "Gs"
> - Check and confirm uscale value is correct. The readback of
>   MAGN scale is 0.001 Gs
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 7b370bd643a1..8320a3b6f942 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -351,7 +351,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (t == FXOS8700_MAGN) {
> -		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
> +		dev_err(dev, "Magnetometer scale is locked at 0.001Gs\n");
>  		return -EINVAL;
>  	}
>  
> @@ -396,7 +396,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  
>  	if (t == FXOS8700_MAGN) {
> -		*uscale = 1200; /* Magnetometer is locked at 1200uT */
> +		*uscale = 1000; /* Magnetometer is locked at 0.001Gs */
>  		return 0;
>  	}
>  
> @@ -587,7 +587,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
>  static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
>  		      "1.5625 6.25 12.5 50 100 200 400 800");
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
> -static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
> +static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");
>  
>  static struct attribute *fxos8700_attrs[] = {
>  	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,

