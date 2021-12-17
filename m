Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7264786AF
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhLQJE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 04:04:57 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48003 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhLQJE5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 04:04:57 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 30CEB1C000E;
        Fri, 17 Dec 2021 09:04:50 +0000 (UTC)
Date:   Fri, 17 Dec 2021 10:05:43 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/13] iio: max9611: Use sysfs_emit()
Message-ID: <20211217090543.4w3n6nfxxbemqnhb@uno.localdomain>
References: <20211216185217.1054495-1-lars@metafoo.de>
 <20211216185217.1054495-11-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216185217.1054495-11-lars@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lars-Peter,

On Thu, Dec 16, 2021 at 07:52:14PM +0100, Lars-Peter Clausen wrote:
> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in checks for
> size and alignment.
>
> Use sysfs_emit() to format the custom `in_power_shunt_resistor` and
> `in_current_shunt_resistor` device attributes of the max9611 driver.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Looks good, I just wonder if a dependency on the CONFIG_SYSFS symbol
should now be added...

Thanks
   j

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 01a4275e9c46..f982f00303dc 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -429,7 +429,7 @@ static ssize_t max9611_shunt_resistor_show(struct device *dev,
>  	i = max9611->shunt_resistor_uohm / 1000000;
>  	r = max9611->shunt_resistor_uohm % 1000000;
>
> -	return sprintf(buf, "%u.%06u\n", i, r);
> +	return sysfs_emit(buf, "%u.%06u\n", i, r);
>  }
>
>  static IIO_DEVICE_ATTR(in_power_shunt_resistor, 0444,
> --
> 2.30.2
>
