Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB427420226
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhJCPKu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhJCPKu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:10:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65671619E7;
        Sun,  3 Oct 2021 15:09:01 +0000 (UTC)
Date:   Sun, 3 Oct 2021 16:12:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/7] iio: accel: cros_ec_accel_legacy: Drop unused IIO
 includes
Message-ID: <20211003161259.2efc3384@jic23-huawei>
In-Reply-To: <20211003121711.279736-4-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
        <20211003121711.279736-4-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 Oct 2021 13:17:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Identified with the include-what-you-use tool.
> Note that to keep this patch simple and non controversial it only
> removes IIO headers that are clearly unused in this driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index b6f3471b62dc..f5abe993d38e 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -11,12 +11,9 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>

Oops, don't need kfifo_buf.h either.  I'll fix that in v2, or if people are
otherwise happy whilst applying.

> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>

