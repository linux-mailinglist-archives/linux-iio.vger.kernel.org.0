Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A602C7944
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgK2NBu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgK2NBt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:01:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6934207FF;
        Sun, 29 Nov 2020 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606654869;
        bh=YnoZnoBKK1Cao/C3DYbfai6083EuHlqcF3OyCuh5BT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IdFNKentfqtDOkxF9RXv9XqnZi2bNMlzqsNEvlT+pjtNTWLVFvx6b07pGi4vwTy8O
         dag85qj4vttdsK+xMy28Q5DCAu1waoq+Syx81CdZhZM9ajS3LA8aC2hYnrDuGe/2/+
         inJbee6n1tMS2E14HIdJtOn/tfJaHj+lljv1h1DE=
Date:   Sun, 29 Nov 2020 13:01:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: adc: at91_adc: cleanup DT bindings
Message-ID: <20201129130104.5a8aee50@archlinux>
In-Reply-To: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
References: <20201128222818.1910764-1-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 23:28:08 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Hello,
> 
> This series cleans up the at91_adc devicetree bindings. This mainly
> moves back the resolution options and names and the triggers description
> back in the driver.
> 

Applied 1-7 to the togreg branch of iio.git and pushed out as testing
for the autobuilders to do their magic.

Thanks,

Jonathan

> Changes in v3:
>  - rebased on the togreg branch of iio.git
>  - dropped "iio: adc: at91_adc: remove forward declaration" as it was already
>    done in tree
>  - Reworked patch 1 from "iio: adc: at91_adc: remove platform data" to "iio:
>    adc: at91_adc: remove at91_adc_ids"
> 
> Changes in v2:
>  - separated out the dt-binding change to give a chance to Rob to actually
>    review them.
>  - Dropped "iio: adc: at91_adc: use devm_input_allocate_device"
>  - Collected tags
>  - use of_device_get_match_data instead of device_get_match_data
>  - include backportable sam9rl trigger fix
> 
> 
> Alexandre Belloni (9):
>   iio: adc: at91_adc: remove at91_adc_ids
>   iio: adc: at91_adc: rework resolution selection
>   dt-bindings:iio:adc:remove atmel,adc-res and atmel,adc-res-names
>   iio: adc: at91_adc: rework trigger definition
>   dt-bindings:iio:adc:remove triggers
>   iio: adc: at91_adc: merge at91_adc_probe_dt back in at91_adc_probe
>   ARM: dts: at91: sama5d3: use proper ADC compatible
>   ARM: dts: at91: at91sam9rl: fix ADC triggers
>   ARM: dts: at91: remove deprecated ADC properties
> 
> Jonathan Cameron (1):
>   dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from
>     at91_adc.txt
> 
>  .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 -----
>  .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 121 +++++++
>  arch/arm/boot/dts/at91sam9260.dtsi            |  25 --
>  arch/arm/boot/dts/at91sam9g45.dtsi            |  27 --
>  arch/arm/boot/dts/at91sam9rl.dtsi             |  25 --
>  arch/arm/boot/dts/at91sam9x5.dtsi             |  28 --
>  arch/arm/boot/dts/sama5d3.dtsi                |  26 +-
>  arch/arm/boot/dts/sama5d4.dtsi                |  22 --
>  drivers/iio/adc/at91_adc.c                    | 294 +++++++-----------
>  9 files changed, 237 insertions(+), 414 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/at91_adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
> 

