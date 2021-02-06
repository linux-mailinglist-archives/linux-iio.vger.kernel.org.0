Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B04311E98
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBFQR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 11:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBFQR5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 11:17:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7C564EAC;
        Sat,  6 Feb 2021 16:17:15 +0000 (UTC)
Date:   Sat, 6 Feb 2021 16:17:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v4 3/3] iio: proximity: Add a ChromeOS EC MKBP proximity
 driver
Message-ID: <20210206161711.6f555434@archlinux>
In-Reply-To: <20210202184434.42644-4-swboyd@chromium.org>
References: <20210202184434.42644-1-swboyd@chromium.org>
        <20210202184434.42644-4-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  2 Feb 2021 10:44:34 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> Add support for a ChromeOS EC proximity driver that exposes a "front"
> proximity sensor via the IIO subsystem. The EC decides when front
> proximity is near and sets an MKBP switch 'EC_MKBP_FRONT_PROXIMITY' to
> notify the kernel of proximity. Similarly, when proximity detects
> something far away it sets the switch bit to 0. For now this driver
> exposes a single sensor, but it could be expanded in the future via more
> MKBP bits if desired.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Just one thing noticed on a final read through.  I'm happy to fix up
whilst applying.  Otherwise all I'm waiting for now is to give
Rob time to look at the device tree binding if he wants to do so.

Jonathan

> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> new file mode 100644
> index 000000000000..23bed4562b34
> --- /dev/null
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -0,0 +1,242 @@
...

> +static struct platform_driver cros_ec_mkbp_proximity_driver = {
> +	.driver = {
> +		.name = "cros-ec-mkbp-proximity",
> +		.of_match_table = of_match_ptr(cros_ec_mkbp_proximity_of_match),
I'm going to assume we know no one is going to use this with
ACPI via PRP0001 given presumably the firmware on these devices
is tightly controlled.

However, we should should still drop the of_match_ptr
as it will lead to an unused warning for cros_ec_mkbp_proximity_of_match
if anyone builds this without CONFIG_OF + it sets a general bad
precedence that I'd rather wasn't around for people to copy.
Note that in general we are slowly ripping these out of IIO but
probably lots still there.

If this is all that is needed in this version I'll just do it
whilst applying unless anyone shouts.

Jonathan

> +	},
> +	.probe = cros_ec_mkbp_proximity_probe,
> +	.remove = cros_ec_mkbp_proximity_remove,
> +};
> +module_platform_driver(cros_ec_mkbp_proximity_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC MKBP proximity sensor driver");

