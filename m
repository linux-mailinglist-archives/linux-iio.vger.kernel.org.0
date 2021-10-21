Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6B5436127
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJUMQQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 Oct 2021 08:16:16 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49739 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhJUMQP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 08:16:15 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 1D5F120003;
        Thu, 21 Oct 2021 12:13:58 +0000 (UTC)
Date:   Thu, 21 Oct 2021 14:13:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, IIO, Input
 (Touchscreen) and Clk due for the v5.16 merge window
Message-ID: <20211021141357.2f08898c@xps13>
In-Reply-To: <YXFW5R8zK/g9Rqei@google.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
        <YXFW5R8zK/g9Rqei@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Thu, 21 Oct 2021 13:02:45 +0100:

> Enjoy!
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-touchscreen-clk-v5.16
> 
> for you to fetch changes up to e7c8a5fe82ff8ee100c65598187674eef4748bf2:
> 
>   iio: adc: ti_am335x_adc: Add the am437x compatible (2021-10-21 10:02:48 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, IIO, Input (Touchscreen) and Clk due for the v5.16 merge window

Thanks! Just to be sure, you will send a merge request to Linus
including this branch, right? Or do you expect someone else to do it?

Thanks,
Miquèl

> ----------------------------------------------------------------
> Miquel Raynal (45):
>       clk: ti: am43xx: Add clkctrl data for am43xx ADC1
>       dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this MFD
>       dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
>       dt-bindings: iio: adc: ti,am3359-adc: New yaml description
>       dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
>       dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
>       dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
>       mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
>       mfd: ti_am335x_tscadc: Replace license text with SPDX tag
>       mfd: ti_am335x_tscadc: Fix style
>       mfd: ti_am335x_tscadc: Get rid of useless gotos
>       mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
>       mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
>       mfd: ti_am335x_tscadc: Don't search the tree for our clock
>       mfd: ti_am335x_tscadc: Simplify divisor calculation
>       mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
>       mfd: ti_am335x_tscadc: Use driver data
>       mfd: ti_am335x_tscadc: Mimic the probe from resume()
>       mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
>       mfd: ti_am335x_tscadc: Always provide an idle configuration
>       mfd: ti_am335x_tscadc: Reorder the initialization steps
>       mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
>       mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
>       mfd: ti_am335x_tscadc: Fix header spacing
>       mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
>       mfd: ti_am335x_tscadc: Drop unused definitions from the header
>       mfd: ti_am335x_tscadc: Use BIT(), GENMASK() and FIELD_PREP() when relevant
>       mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
>       mfd: ti_am335x_tscadc: Drop useless definitions from the header
>       mfd: ti_am335x_tscadc: Rename the subsystem enable macro
>       mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
>       mfd: ti_am335x_tscadc: Rename a variable
>       mfd: ti_am335x_tscadc: Fix an error message
>       mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
>       mfd: ti_am335x_tscadc: Introduce a helper to deal with the type of hardware
>       mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
>       mfd: ti_am335x_tscadc: Support the correctly spelled DT property
>       iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
>       iio: adc: ti_am335x_adc: Replace license text with SPDX tag
>       iio: adc: ti_am335x_adc: Fix style
>       iio: adc: ti_am335x_adc: Get rid of useless gotos
>       iio: adc: ti_am335x_adc: Gather the checks on the delays
>       iio: adc: ti_am335x_adc: Add a unit to the timeout delay
>       iio: adc: ti_am335x_adc: Add the scale information
>       iio: adc: ti_am335x_adc: Add the am437x compatible
> 
>  Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml           |  70 ++++++++++
>  Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml |  76 +++++++++++
>  Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt     |  91 -------------
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml            |  84 ++++++++++++
>  drivers/clk/ti/clk-43xx.c                                              |   1 +
>  drivers/iio/adc/ti_am335x_adc.c                                        | 220 ++++++++++++++++++-------------
>  drivers/mfd/ti_am335x_tscadc.c                                         | 235 +++++++++++++++++++---------------
>  include/dt-bindings/clock/am4.h                                        |   1 +
>  include/linux/mfd/ti_am335x_tscadc.h                                   | 119 +++++++++--------
>  9 files changed, 549 insertions(+), 348 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> 


Thanks,
Miquèl
