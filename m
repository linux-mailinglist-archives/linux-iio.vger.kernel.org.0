Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B825EE81
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgIFPUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgIFPUO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 11:20:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E7920714;
        Sun,  6 Sep 2020 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405614;
        bh=lENSTT8zhvx+mn9kptc0V4UJ7LSxhvNqQW6A/G5G6xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hSEZ2PLOZEp+XnmHEDtxrqCjCPbvYSLy0e4dKzEHogM1ihso0Bl2oJy8fcSukd9Fx
         LiAmbxD3VMuPgHAC8lQBCQDmZg5NEh2mQrA2OH/ybddgbNq09zNEJE/f2V0+FT8Tpo
         yZmd7AFL8e7KIHxAbkh2p4VIDMgwlWn/ndmfQpx4=
Date:   Sun, 6 Sep 2020 16:20:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
        linux-iio@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] IIO: rockchip: add missing dependencies for saradc
Message-ID: <20200906162010.30094d61@archlinux>
In-Reply-To: <20200901204054.5334-1-vicencb@gmail.com>
References: <20200901204054.5334-1-vicencb@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  1 Sep 2020 22:40:54 +0200
Vicente Bergas <vicencb@gmail.com> wrote:

> This driver uses the triggered buffer functionality
> but was not requiring it.
> 
> Signed-off-by: Vicente Bergas <vicencb@gmail.com>

Fix should now be in tree. I don't think the IIO_TRIGGER select
is necessary (and isn't in current fixed version) but if I'm wrong
on that please shout!  Logically it shouldn't be required as the
driver doesn't provide a trigger, but we may have something missing
a stub somewhere.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 66d9cc073157..cd90f60cdfd9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -865,6 +865,9 @@ config ROCKCHIP_SARADC
>  	tristate "Rockchip SARADC driver"
>  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
>  	depends on RESET_CONTROLLER
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for the SARADC found in SoCs from
>  	  Rockchip.

