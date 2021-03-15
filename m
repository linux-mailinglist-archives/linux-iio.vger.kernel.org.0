Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5333B00F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Mar 2021 11:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCOKgP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Mar 2021 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCOKfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Mar 2021 06:35:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A85C061574
        for <linux-iio@vger.kernel.org>; Mon, 15 Mar 2021 03:35:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ADAC71F45C8A
Subject: Re: [PATCH] iio:cros_ec_sensors: Fix a wrong function name in kernel
 doc.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20210313145341.116088-1-jic23@kernel.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e0d1caa8-785b-6789-3f8c-08ae5eafca4b@collabora.com>
Date:   Mon, 15 Mar 2021 11:35:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313145341.116088-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for fix this.

On 13/3/21 15:53, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> cros_ec_sensors_read_data_unsafe() had wrong function name in kernel-doc
> This shows up with W=1 builds.
> 
> No fixes tag because I don't want to waste time on this being
> backported.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index f8824afe595e..ed9dd0ad5c03 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -559,7 +559,7 @@ static int cros_ec_sensors_read_until_not_busy(
>  }
>  
>  /**
> - * read_ec_sensors_data_unsafe() - read acceleration data from EC shared memory
> + * cros_ec_sensors_read_data_unsafe() - read acc data from EC shared memory


nit: Wouldn't be better to maintain the word 'acceleration' instead of replacing
for 'acc'. It is less than 100 characters in total so should be fine.

In any case:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>   * @indio_dev:	pointer to IIO device
>   * @scan_mask:	bitmap of the sensor indices to scan
>   * @data:	location to store data
> 
