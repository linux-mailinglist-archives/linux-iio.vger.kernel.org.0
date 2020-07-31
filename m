Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC0234473
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 13:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgGaLR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 07:17:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLR6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 07:17:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A8A4D298D56
Subject: Re: [PATCH v2] iio: cros_ec: Set Gyroscope default frequency to 25Hz
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        bleung@chromium.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org
References: <20200728204825.3312921-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e98794b4-3f70-ce27-dd64-6bfaff433b8d@collabora.com>
Date:   Fri, 31 Jul 2020 13:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728204825.3312921-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Thank you for your patch.

On 28/7/20 22:48, Gwendal Grignou wrote:
> BMI160 Minimium gyroscope frequency in normal mode is 25Hz.
> When older EC firmware do not report their sensors frequencies,
> use 25Hz as the minimum for gyroscope to be sure it works on BMI160.
> 
> Fixes: ae7b02ad2f32d ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
> frequency range via iio sysfs")
> 

I think your email broke this line, it should be a single line. Other than that ...

> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> Change since v1: Fix spelling.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 156848d27c473..213837c2ecee2 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -85,10 +85,13 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  
>  	switch (type) {
>  	case MOTIONSENSE_TYPE_ACCEL:
> -	case MOTIONSENSE_TYPE_GYRO:
>  		*min_freq = 12500;
>  		*max_freq = 100000;
>  		break;
> +	case MOTIONSENSE_TYPE_GYRO:
> +		*min_freq = 25000;
> +		*max_freq = 100000;
> +		break;
>  	case MOTIONSENSE_TYPE_MAG:
>  		*min_freq = 5000;
>  		*max_freq = 25000;
> 
