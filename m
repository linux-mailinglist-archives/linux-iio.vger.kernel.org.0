Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE91E982B
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgEaOkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOkW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:40:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E2D206B6;
        Sun, 31 May 2020 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590936021;
        bh=6yQVUf6eZyFT6lMD1GCa340xEGAioytVxc9js4MHTtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q63VwJGZvgs9AhjZpY0fXN9BcBIiEyov3MRaTZDQsiX6saVwTUWz9tE5t4z6k3hYQ
         3cedlqnJ/TFbmsemKkxou43DrugEmzfxiOMj+GNpI0Y1Tr54qjOucpsFqRaisdyxVz
         23RCq+ADdezYf+qglashef+UdCmMv5gMQZuANppc=
Date:   Sun, 31 May 2020 15:40:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] iio: Kconfig: at91_adc: add COMPILE_TEST dependency to
 driver
Message-ID: <20200531154017.04fc727f@archlinux>
In-Reply-To: <20200525102744.131672-1-alexandru.ardelean@analog.com>
References: <20200525102744.131672-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 13:27:44 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since changes can come from all sort of places, it may make sense to have
> this symbol as a dependency to make sure that the 'make allmodconfig' &&
> 'make allyesconfig' build rules cover this driver as well for a
> compile-build/test.
> 
> It seemed useful [recently] when trying to apply a change for this.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Makes sense.   Given this sort of change can expose weird an wonderful
dependencies that were previously hidden, I'll be wanting an
ack from at91 people.

Jonathan

> ---
>  drivers/iio/adc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index c48c00077775..c1f4c0aec265 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -294,7 +294,7 @@ config ASPEED_ADC
>  
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
> -	depends on ARCH_AT91
> +	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on INPUT && SYSFS
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

