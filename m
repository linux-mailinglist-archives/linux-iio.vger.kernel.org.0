Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D232333A710
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 18:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCNRAm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 13:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNRAb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 13:00:31 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8528564E69;
        Sun, 14 Mar 2021 17:00:29 +0000 (UTC)
Date:   Sun, 14 Mar 2021 17:00:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH v2 6/9] iio/drivers/hid-sensor: Use HZ macros
Message-ID: <20210314170026.712d1760@archlinux>
In-Reply-To: <20210224144222.23762-6-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
        <20210224144222.23762-6-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Feb 2021 15:42:16 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> HZ unit conversion macros are available in units.h, use them and
> remove the duplicate definition.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 442ff787f7af..dda3b67e494f 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -11,13 +11,12 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/time.h>
> +#include <linux/units.h>
>  
>  #include <linux/hid-sensor-hub.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define HZ_PER_MHZ	1000000L
> -
>  static struct {
>  	u32 usage_id;
>  	int unit; /* 0 for default others from HID sensor spec */

