Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6D2B2ED4
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKNRRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgKNRRP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:17:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D30D20B80;
        Sat, 14 Nov 2020 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605374234;
        bh=9fXdm0/jlVB/JoIYN6WFDDi7fbDGGhlQON/dw5QBnKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSfJDB4i5mQGxl3rc2sTDIThpu6ID/aJ0O/Y/hXif9bxyul8vQC+kth9ly0cBOtI1
         nRWQDBwGrL/jtY9JQ5i93bN/AMG5sWSBsawq2l+F78pxNZ5+0st/sB6jqZcdzDSBZM
         L1PFI3Ns8lR6JRv+f/DcDQTOcwUGGeAOtBdyBdlw=
Date:   Sat, 14 Nov 2020 17:17:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] iio: adc: at91_adc: cleanup DT bindings
Message-ID: <20201114171709.638e8200@archlinux>
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 22:26:41 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> This series cleans up the at91_adc devicetree bindings. This mainly
> moves back the resolution options and names and the triggers description
> back in the driver.
> 
> There are also other cleanups, like removing platform data support, this
> was pending for a while.

I'm fine with everything up to patch 7.  Given it touches DT I'll leave
a bit of time for Rob to take a quick look (can't see him objecting to the
removal of sections of the binding though!)

If you don't mind me dropping 7 I can pick 1-6 up in a week or two.
Thanks,

Jonathan

> 
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

