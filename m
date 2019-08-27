Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F139F3BE
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfH0UGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 16:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfH0UGZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 16:06:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0DD217F5;
        Tue, 27 Aug 2019 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566936384;
        bh=N9yAiTPtSh+p9ZHVaeoxEuwe5OQd5ogwpLgcUVsw6jY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QKXt0iZaWtEK3xLdh7+bJ/b+PM8krTOw6gqw+vCnSalBkOMllpMIOSFF/L0LSvq4H
         yeCgGc6KhZp4abHdGq2eXenBrtqU3pncWmG9CoTIvZE46oqdoEwyLyOpIpG2c++DFD
         9Y0jMGlSJ9/hKJLoCBkfUZE8d4Yb6X15jo3QFr2Q=
Date:   Tue, 27 Aug 2019 21:06:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        nvaccaro@chromium.org
Subject: Re: [PATCH v2] iio: cros_ec: set calibscale for 3d MEMS to unit
 vector
Message-ID: <20190827210617.13f6cb7d@archlinux>
In-Reply-To: <20190826230258.203235-1-gwendal@chromium.org>
References: <20190826230258.203235-1-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Aug 2019 16:02:58 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> By default, set the calibscale vector to unit vector.
> When calibrating one axis, the other axis calibrations  are sent as well.
> If left to 0, sensor data from uncalibrated axis are zero'ed out until
> all axis are calibrated.
> 
> Fixes: ed1f2e85da79 ("iio: cros_ec: Add calibscale for 3d MEMS ")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Just made it before what will probably be the last pull request from
me for this cycle.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Add fixes tag.
> - Improve description.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index fd833295bb173..d44ae126f4578 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -90,7 +90,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	u32 ver_mask;
> -	int ret;
> +	int ret, i;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -136,6 +136,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		/* Set sign vector, only used for backward compatibility. */
>  		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>  
> +		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
> +			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> +
>  		/* 0 is a correct value used to stop the device */
>  		state->frequencies[0] = 0;
>  		if (state->msg->version < 3) {

