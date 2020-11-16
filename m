Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8B2B3D2E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKPGcd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 01:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgKPGcd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Nov 2020 01:32:33 -0500
Received: from sekiro (lfbn-mar-1-625-225.w90-118.abo.wanadoo.fr [90.118.2.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C0EE2222E;
        Mon, 16 Nov 2020 06:32:30 +0000 (UTC)
Date:   Mon, 16 Nov 2020 07:32:27 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: adc: at91_adc: cleanup DT bindings
Message-ID: <20201116063227.eqhqyocmgxe4khmj@sekiro>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 13, 2020 at 10:26:41PM +0100, Alexandre Belloni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello,
> 
> This series cleans up the at91_adc devicetree bindings. This mainly
> moves back the resolution options and names and the triggers description
> back in the driver.
> 
> There are also other cleanups, like removing platform data support, this
> was pending for a while.
>

Nice cleanup of this old and obscur binding.

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks.

> Alexandre Belloni (8):
>   iio: adc: at91_adc: remove platform data
>   iio: adc: at91_adc: rework resolution selection
>   iio: adc: at91_adc: rework trigger definition
>   iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
>   iio: adc: at91_adc: remove forward declaration
>   iio: adc: at91_adc: use devm_input_allocate_device
>   ARM: dts: at91: sama5d3: use proper ADC compatible
>   ARM: dts: at91: remove deprecated ADC properties
> 
> Jonathan Cameron (1):
>   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
>     at91_adc.txt
> 
>  .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 ----
>  .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 ++++++
>  arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
>  arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
>  arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
>  arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
>  arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
>  arch/arm/boot/dts/sama5d4.dtsi                |  22 -
>  drivers/iio/adc/at91_adc.c                    | 377 +++++++-----------
>  include/linux/platform_data/at91_adc.h        |  49 ---
>  10 files changed, 259 insertions(+), 524 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
>  delete mode 100644 include/linux/platform_data/at91_adc.h
> 
> --
> 2.28.0
