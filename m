Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5A4F489
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFVIy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfFVIy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 04:54:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F572089C;
        Sat, 22 Jun 2019 08:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561193666;
        bh=kQuDG9P7GT4mBpe49vCLPobIP/JxzGZ+/TGdxu04U3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FkjpFNKLhMZSkqbIbQHJb6MlZ7kZL7Sob2q1ys/Yitf0vK0EH29nI/0JdrsIJyOxq
         l0NZJTBfaqpNGdYcRmQbW4spXcClXUKS4CiY0tR4SThvEqCAyHqrxZv1lRzdm+7NLh
         re7feAzwa3vEVUu1Ozzpy0x13+D9r7ISm23albYo=
Date:   Sat, 22 Jun 2019 09:54:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/2] iio: cros_ec: Add sign vector in core for
 backward compatibility
Message-ID: <20190622095421.6b4e38e9@archlinux>
In-Reply-To: <20190621024106.158589-2-gwendal@chromium.org>
References: <20190621024106.158589-1-gwendal@chromium.org>
        <20190621024106.158589-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jun 2019 19:41:05 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
> 
> On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
I'm guessing that you have a whole pile of code that isn't using
the mounting_matrix ABI and hence need the 'fixup' in kernel?

Otherwise this is fine, but I'd like to wait for Doug to have another
look if he wants to (and ideally give a reviewed-by)

Anyone else's input also welcome of course.

Jonathan

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..e8a4d78659c8 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  		}
>  		state->type = state->resp->info.type;
>  		state->loc = state->resp->info.location;
> +
> +		/* Set sign vector, only used for backward compatibility. */
> +		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
>  	}
>  
>  	return 0;
> @@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> +		*data *= st->sign[i];
>  		data++;
>  	}
>  
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index ce16445411ac..a1c85ad4df91 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
>  	enum motionsensor_location loc;
>  
>  	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
> +	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
>  
>  	u8 samples[CROS_EC_SAMPLE_SIZE];
>  

