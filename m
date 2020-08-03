Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63A23A3FB
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 14:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHCMUF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 08:20:05 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:44123 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgHCMT5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 08:19:57 -0400
X-Greylist: delayed 1238 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 08:19:55 EDT
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74]:45892 helo=diego.localnet)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1k2Z7Z-0003jo-J6; Mon, 03 Aug 2020 13:59:13 +0200
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH] iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER
Date:   Mon, 03 Aug 2020 13:59:12 +0200
Message-ID: <2468442.jk0zRepj8P@diego>
Organization: Theobroma Systems
In-Reply-To: <20200803083001.6689-1-michael@walle.cc>
References: <20200803083001.6689-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Montag, 3. August 2020, 10:30:01 CEST schrieb Michael Walle:
> The kernel fails to compile due to undefined reference to
> devm_iio_triggered_buffer_setup() if IIO_TRIGGERED_BUFFER is not
> enabled. The original patch [1] had this dependency. But somehow it
> didn't make it into the kernel tree. Re-add it.
> 
> [1] https://lore.kernel.org/lkml/20200623233011.2319035-3-heiko@sntech.de/
> 
> Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

> ---
>  drivers/iio/adc/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc073157..d94dc800b842 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -865,6 +865,8 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.
> 




