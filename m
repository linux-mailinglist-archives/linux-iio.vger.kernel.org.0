Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A13415AB5
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhIWJS2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbhIWJS1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 05:18:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0891C061574;
        Thu, 23 Sep 2021 02:16:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B67B81F44019
Subject: Re: [PATCH 6/9] iio: common: cros_ec_sensors: simplify getting
 .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
 <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <716533b5-380d-be72-b45e-d9909f09286b@collabora.com>
Date:   Thu, 23 Sep 2021 11:16:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Wolfram,

On 20/9/21 11:05, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I'm fine to pick this patch through chrome-platform tree if Jonathan is fine, or
can go through his tree.

I plan also to pick patch  "[PATCH 8/9] platform: chrome: cros_ec_sensorhub:
simplify getting .driver_data"

Thanks,
  Enric

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 28bde13003b7..b2725c6adc7f 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -831,8 +831,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
>  
>  static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	int ret = 0;
>  
> 
