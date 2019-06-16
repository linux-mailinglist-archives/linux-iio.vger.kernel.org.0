Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 223224757A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfFPPU1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 11:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfFPPU0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 11:20:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B4921873;
        Sun, 16 Jun 2019 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560698425;
        bh=MVRYMON/4UpZXBY5yXeRNPXp8sYqC7fm61hsEjobDy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S5vZr7PV7tcnCW6BbiR7PUIXHnbijMPoBq8GVlW141xS1tYj//t7Mw+SCtNvEKDrq
         iXaZGk8ftaTsyi0QRHd6jRGwM/CJq43LH46vUxmYN97+N6MY9miibOL2nRLIsjpw6V
         QTo9+fdrx3tHAyKUN/rr1Q461nfqntByLnw+urE8=
Date:   Sun, 16 Jun 2019 16:20:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-iio@vger.kernel.org, ardeleanalex@gmail.com,
        michal.simek@xilinx.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lars@metafoo.de
Subject: Re: [PATCH] iio: adc: xilinx: support all platforms
Message-ID: <20190616162021.49e60796@archlinux>
In-Reply-To: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
References: <1560183824-19061-1-git-send-email-hancock@sedsystems.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Jun 2019 10:23:44 -0600
Robert Hancock <hancock@sedsystems.ca> wrote:

> Since the XADC logic can be used with standalone Xilinx FPGAs, this
> driver can potentially be used with many different platforms, not just
> the Zynq and MicroBlaze platforms this driver was allowed to be built
> for. There should be no platform-specific code in this driver, so just
> delete the platform dependency.
> 
> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
Applied to the togreg branch of iio.git and pushed out as testing
to see if any of us missed anything.  Hopefully the many compiles 0-day
will do on this will highlight if there is anything hiding we haven't thought
of to make this a bad idea (more likely needing a little fix ;)

Jonathan

> ---
> 
> This is an updated version of an earlier patch "iio: adc: xilinx: support all
> ARM platforms", but this one just deletes the platform restriction entirely
> as it seems unnecessary.
> 
>  drivers/iio/adc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f96a770..7e32862 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1085,7 +1085,6 @@ config VIPERBOARD_ADC
>  
>  config XILINX_XADC
>  	tristate "Xilinx XADC driver"
> -	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER

