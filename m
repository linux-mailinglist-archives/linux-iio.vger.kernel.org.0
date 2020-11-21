Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D694C2BC062
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgKUP4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgKUP4u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:56:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7751221FE;
        Sat, 21 Nov 2020 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605974210;
        bh=THoqA4cIiwmA6F7wmpGWZrZVf/+hBXB9MlK9uvTnToU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BuVVAjLyXwBrmUnkT1yCC2txLt0+9vZnQGrX6e+/eCMrMtckbXV2d6BQ1Dfi++TeM
         DSox7nvV8IcrFwiMH3QSQd63KaIY4lkMamXYqh1ho7xPVl4XBUU0Ca4VM4TS6ThTs0
         Ure/RZG+lj+5z1wl0VZiZ1HJke432Dk/Gi45kdjo=
Date:   Sat, 21 Nov 2020 15:56:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] iio: adc: at91_adc: cleanup DT bindings
Message-ID: <20201121155645.291c331d@archlinux>
In-Reply-To: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
References: <20201117140656.1235055-1-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Nov 2020 15:06:45 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> This series cleans up the at91_adc devicetree bindings. This mainly
> moves back the resolution options and names and the triggers description
> back in the driver.
> 
> There are also other cleanups, like removing platform data support, this
> was pending for a while.

LGTM.  I'll let it sit for a little while longer to give Rob H (and anyone
else who fancies it) time to take a look. 

Give me a poke if I seem to have lost it (happens all too often :(

Thanks,

Jonathan

> 
> Changes in v2:
>  - separated out the dt-binding change to give a chance to Rob to actually
>    review them.
>  - Dropped "iio: adc: at91_adc: use devm_input_allocate_device"
>  - Collected tags
>  - use of_device_get_match_data instead of device_get_match_data
>  - include backportable sam9rl trigger fix
> 
> Alexandre Belloni (10):
>   iio: adc: at91_adc: remove platform data
>   iio: adc: at91_adc: rework resolution selection
>   dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
>   iio: adc: at91_adc: rework trigger definition
>   dt-bindings:iio:adc:remove triggers
>   iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
>   iio: adc: at91_adc: remove forward declaration
>   ARM: dts: at91: sama5d3: use proper ADC compatible
>   ARM: dts: at91: at91sam9rl: fix ADC triggers
>   ARM: dts: at91: remove deprecated ADC properties
> 
> Jonathan Cameron (1):
>   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
>     at91_adc.txt
> 
>  .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 -----
>  .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 ++++++
>  arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
>  arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
>  arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
>  arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
>  arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
>  arch/arm/boot/dts/sama5d4.dtsi                |  22 --
>  drivers/iio/adc/at91_adc.c                    | 351 +++++++-----------
>  include/linux/platform_data/at91_adc.h        |  49 ---
>  10 files changed, 256 insertions(+), 501 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
>  delete mode 100644 include/linux/platform_data/at91_adc.h
> 

