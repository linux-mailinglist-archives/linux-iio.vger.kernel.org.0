Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18C27E924
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgI3NC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 09:02:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40825 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgI3NC5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 09:02:57 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 167E01C000B;
        Wed, 30 Sep 2020 13:02:54 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:02:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH v3 3/4] iio: adc: at91_adc: add Kconfig dep on the OF
 symbol and remove of_match_ptr()
Message-ID: <20200930130254.GG2804081@piout.net>
References: <20200930125216.90424-1-alexandru.ardelean@analog.com>
 <20200930125216.90424-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930125216.90424-4-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/09/2020 15:52:15+0300, Alexandru Ardelean wrote:
> This tries to solve a warning reported by the lkp bot:
> 
> >> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
> >> 'at91_adc_dt_ids' [-Wunused-const-variable]
>    static const struct of_device_id at91_adc_dt_ids[] = {
>                                     ^
>    1 warning generated.
> 
> This warning has appeared after the AT91_ADC driver compilation has been
> enabled via the COMPILE_TEST symbol dependency.
> 
> The warning is caused by the 'of_match_ptr()' helper which returns NULL if
> OF is undefined. This driver should build only for device-tree context, so
> a dependency on the OF Kconfig symbol has been added.
> Also, the usage of of_match_ptr() helper has been removed since it
> shouldn't ever return NULL (because the driver should not be built for the
> non-OF context).
> 
> Fixes: 4027860dcc4c ("iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/iio/adc/Kconfig    | 2 +-
>  drivers/iio/adc/at91_adc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 91ae90514aff..17e9ceb9c6c4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -295,7 +295,7 @@ config ASPEED_ADC
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
>  	depends on ARCH_AT91 || COMPILE_TEST
> -	depends on INPUT && SYSFS
> +	depends on INPUT && SYSFS && OF
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 7d846a2852a5..473bffe84fbd 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1466,7 +1466,7 @@ static struct platform_driver at91_adc_driver = {
>  	.id_table = at91_adc_ids,
>  	.driver = {
>  		   .name = DRIVER_NAME,
> -		   .of_match_table = of_match_ptr(at91_adc_dt_ids),
> +		   .of_match_table = at91_adc_dt_ids,
>  		   .pm = &at91_adc_pm_ops,
>  	},
>  };
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
