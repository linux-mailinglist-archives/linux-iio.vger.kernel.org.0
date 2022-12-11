Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE64D64948C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLKNwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKNwj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:52:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32928B
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:52:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDC6360C99
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAB1C433EF;
        Sun, 11 Dec 2022 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670766756;
        bh=0ceClWanYjmCw7KM70LATkE5wb2AsNcQIkS7As7vTPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJqWfShJ8fA2yihaRubG4HKw/RAxSQL0OBU4JvnRfDFf+NqK56iUmkpJfyXTypjWg
         K3WEbqo640H+ABDpIbsP9a/629Ki3q11laIhyNU6E4h61n1X/nyQVDa/Oydk8pHzfC
         lfUgQbcr8zDht4Ez1GTYbIw0ywhzCRBLSGjNL/igQEfSn0eP+Scwh0LtQVjHvJWh9P
         oK2SexEblv9cg659DLsJy7DPw4MFso45IL9d42ZCiB8OdhJIK6sKRQbRZsl1LddEVR
         gheFgjVxme8h2fs9XREJ97sj5E0YBUXzPkZeJFC8RvjzPcax9swBV1QxImUNvvBvaT
         8p8yRl1YdMduQ==
Date:   Sun, 11 Dec 2022 14:05:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: imu: fxos8700: fix MAGN sensor scale and
 unit
Message-ID: <20221211140530.158924a4@jic23-huawei>
In-Reply-To: <20221208071911.2405922-8-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-8-carlos.song@nxp.com>
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

On Thu,  8 Dec 2022 15:19:11 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> +/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
> is the magnetic sensitivity parameter. It is referenced as 0.1uT
> according to datasheet and magnetometer channel unit is Gauss in
> sysfs-bus-iio documentation. Gauss and uTesla unit conversion
> relationship as follows: 0.1uT = 0.001g.
> 
> Set magnetometer scale and available magnetometer scale as fixed 0.001g.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Changes for V2:
> - Modify the magnetometer sensitivity unit to be consistent with the
>   documentation as 0.001g
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index b4baef82f6d5..1780ed99d2f9 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -352,7 +352,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
>  	struct device *dev = regmap_get_device(data->regmap);
>  
>  	if (t == FXOS8700_MAGN) {
> -		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
> +		dev_err(dev, "Magnetometer scale is locked at 0.001g\n");

Gauss unit (according to wikipedia) is G or Gs

>  		return -EINVAL;
>  	}
>  
> @@ -397,7 +397,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
>  	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
>  
>  	if (t == FXOS8700_MAGN) {
> -		*uscale = 1200; /* Magnetometer is locked at 1200uT */
> +		*uscale = 1000; /* Magnetometer is locked at 0.001g */
>  		return 0;
>  	}
>  
> @@ -591,7 +591,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
>  static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
>  		      "1.5625 6.25 12.5 50 100 200 400 800");
>  static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
> -static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
> +static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");

Check that against what you get reading the value.  If it is 0.001Gs then
this is right, but the uscale above isn't. (that is 0.0001Gs)

>  
>  static struct attribute *fxos8700_attrs[] = {
>  	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,

