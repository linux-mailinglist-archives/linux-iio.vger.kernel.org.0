Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBA25E0DD
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIDRcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 13:32:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56054 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDRcl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Sep 2020 13:32:41 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kEFZa-0007FR-A3; Fri, 04 Sep 2020 19:32:26 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Allow compile-testing with !ARM
Date:   Fri, 04 Sep 2020 19:32:22 +0200
Message-ID: <1602652.ZmzXO7uU3z@diego>
In-Reply-To: <20200904170416.16061-1-alex.dewar90@gmail.com>
References: <20200904170416.16061-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Freitag, 4. September 2020, 19:04:16 CEST schrieb Alex Dewar:
> There seems no reason to allow for compile-testing on ARM only, so
> remove this restriction.
> 
> Build-tested with allyesconfig on x86.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d94dc800b842..03929606bb01 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -863,7 +863,7 @@ config RN5T618_ADC
>  
>  config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
> -	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> +	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	depends on RESET_CONTROLLER
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> 




