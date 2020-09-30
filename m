Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A808527E2BB
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgI3Hha (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:37:30 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:34595 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3Hha (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:37:30 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 03:37:29 EDT
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BA61B200013;
        Wed, 30 Sep 2020 07:37:27 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:37:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2 3/4] iio: adc: at91_adc: add Kconfig dependency on the
 OF symbol
Message-ID: <20200930073727.GC2804081@piout.net>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-4-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930060008.42134-4-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 30/09/2020 09:00:07+0300, Alexandru Ardelean wrote:
> This tries to solve a warning reported by the lkp bot:
> 
> >> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
> >> 'at91_adc_dt_ids' [-Wunused-const-variable]
>    static const struct of_device_id at91_adc_dt_ids[] = {
>                                     ^
>    1 warning generated.
> 
> This shows up with 'compiler: clang version 12.0.0' and W=1 (as the bot
> mentions).
> 
> Forward declarations for global variables can be a bit weird; forward
> function declarations are more common.
> 
> Maybe another fix for this would have been to prefix with 'extern' the
> 'at91_adc_dt_ids' variable, thus making it more friendly as a forward
> declaration. It would look weird, but it would work.
> 
> But, we can avoid that forward declaration altogether simply by obtaining
> the private data with of_device_get_match_data().
> 
> This appeared after commit 4027860dcc4c ("iio: Kconfig: at91_adc: add
> COMPILE_TEST dependency to driver"), which put this driver on the lkp's bot
> radar.
> 

Shouldn't all of that be part of the commit message for 1/4? This
doesn't explicitly explain why you add a dependency on OF.

> Fixes: 4027860dcc4c ("iio: Kconfig: at91_adc: add COMPILE_TEST dependency to driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
