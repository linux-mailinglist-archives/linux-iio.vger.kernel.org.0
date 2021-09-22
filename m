Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF417414DA5
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhIVQDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbhIVQDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 12:03:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6869C061757
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 09:02:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d6so8240478wrc.11
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iywqcfKnSfK1xFL5MWklUeXqGta7Ukjc/LlffiG0h2k=;
        b=hLZx0do2FdsxiECPgdhvXsoH9JJvHH/9FYu90HppewSIc0SWxeu39lGIKjLVQIZm5i
         ohCgSCHzYNpGdODuENEwP8fw7lBoq4nPOlFMUnLsnZusIxs9VRwDcKPrEJxDKEC94Jdz
         oHJ92Ri/zE9WJ5eUH3ZRWiI6F0hJvXqi9wnQ4CTAuJM21y1Cj/H0xlZJUrBW3sMgD+UD
         EWbSQTbQYVdaBGzUvPwyPADCp/Mf3sg7U1N6jAwo8O7oL9WJi+zDmdYYeg8CMjqT3eM0
         k+3wTlOAmQWCwkjcmInRNFMinQSwMJBp2qaryhHwV5HxMFpPgG8/UWUnu3ldUFGAVq5w
         dgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iywqcfKnSfK1xFL5MWklUeXqGta7Ukjc/LlffiG0h2k=;
        b=kgRVhGbZlHU/aXASiVtu5e7kBcZv3BG+ZDm/8+9REZN+TPhZ+q6xcYqCEolaQBIki0
         xnQzDic75tYmRO5HVX6tN53HsuQqNEM+TggHdUG+7nNIOSOc6uz2jt+VvEkAUQuHhjkL
         9LbVXVXG8buSzQrltSQywN3buIvo6aMacFmv+LuFw+mhaTjyfJwCIfReF0Wb0HnKaS0E
         SgN2lHeLScycvZcei0beZEpOMwbvSZjFl9RKjcq7OKK4ZrWdmj7QVppOBXnODKril8+p
         HXz15qsmaiCXCaBmrlb1ntKurjZMIx2LEkplbwpBRvL6ZtRtmkDbUTmfNO3eNNFpFT3L
         8y8w==
X-Gm-Message-State: AOAM531B0je8IbB6dIkzdfzg0JKPqA3TkCk5CkeFoP8T7omKq+V2KZHG
        CVQlqncuipQOCuLhEcs4TXqGmw==
X-Google-Smtp-Source: ABdhPJx3iX+TWpTbuYpo7370R/7fS0xIDjJmre/baJjdPsaQC9Ho8SBJMrfkGtnz8MVikefEo6/NTA==
X-Received: by 2002:a5d:6d01:: with SMTP id e1mr405700wrq.256.1632326523379;
        Wed, 22 Sep 2021 09:02:03 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id i187sm2623391wma.0.2021.09.22.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 09:02:02 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:02:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v3 00/47] TI AM437X ADC1
Message-ID: <YUtTeIWKnalzJS7S@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021, Miquel Raynal wrote:

> Hello,
> 
> This is a (fairly big) series bringing support of AM437X ADC1.
> On TI AM33XX SoCs family there is an ADC that can also be connected to a
> touchscreen. This hardware has been extended and is present on certain
> SoCs from the AM437X family. In particular, the touchscreen has been
> replaced by a magnetic card reader. In both cases, the representation is
> an MFD device with two children:
> * on AM33XX: the touchscreen controller and the ADC
> * on AM437X: the magnetic card reader and the ADC
> 
> This series really targets small and atomic changes so that the overall
> review is eased, even though it leads to a lot of rather small patches.
> Here are the steps:
> * Supporting the missing clock
> * Translating a single text file containing the description for the
>   MFD, the touchscreen and the ADC into three independent yaml files.
> * Cleaning/preparing the MFD driver.
> * Supporting ADC1 in the MFD driver.
> * Cleaning/preparing of the ADC driver.
> * Supporting ADC1 in the ADC driver.
> * Updating various device trees.
> 
> Here is the full series again, almost reviewed and acked entirely, but
> rebased on the last -rc1. The clock patch has been acked, the ADC
> patches as well, so we expect the series to go through the MFD
> tree if hte maintainers agree with it.
> 
> Thanks,
> Miquèl
> 
> Changes in v3:
> * Rebased on top of v5.15-rc1.
> * R-by/A-by tags added.
> * Light reordering to let the of_put_node() fix to be applied more easily
> * Dropped a patch made useless because of the previous reordering
> * Explained how the tscadc->ctrl variable was used.
> * Fixed a couple of typos.
> * Included the change for the HZ macro.
> * Went further in the BIT()/FIELD_PREP() cleanup.
> * Added maximum definitions for sample delay/open delay.
> * Removed useless definitions.
> * Fixed a couple of rebase conflicts (the series was not bisectable).
> 
> Changes in v2:
> * Added various R-by/A-by tags.
> * Various typos & style fixes.
> [Bindings]
> * Included the missing ti,am654-tscadc compatible.
> * Reworded the compatible lines as requested by Jonathan.
> * Reworded the bindings content a little bit as advised by Rob (subnodes
>   being objects, MFD descriptions provided once, status and unused
>   labels removed).
> [SPDX changes]
> * Mentioned that the license macro and the license text matched.
> * Also added an SPDX tag in the MFD header.
> [MFD header]
> * Used the BIT(), GENMASK() and PREP_FIELD() macros when relevant.
> [MFD driver]
> * Did not reordered the variables declared on the probe stack as advised
>   by Jonathan.
> * Added missing of_node_put() calls.
> * Moved the patch changing the place where the main structure is
>   allocated to directly precede the patch using this change.
> * Fixed the driver data wiring (bug happening between ex patches 16 and
>   28).
> * Added a commit just to explain the reordering of the register writes
>   during initialization/resume.
> * Explained the check about 'use_tsc' in the commit message.
> * Added a link to the TRM in a commit message referencing it.
> * Removed the use of the ti,tracks property, used a constant value
>   instead.
> * Dropped the error check when retrieving the "wrong" DT property
>   (coordiante-readouts) which is unused.
> 
> 
> Miquel Raynal (47):
>   clk: ti: am43xx: Add clkctrl data for am43xx ADC1
>   dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this
>     MFD
>   dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
>   dt-bindings: iio: adc: ti,am3359-adc: New yaml description
>   dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
>   dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
>   dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
>   mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
>   mfd: ti_am335x_tscadc: Replace license text with SPDX tag
>   mfd: ti_am335x_tscadc: Fix style
>   mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack
>     variables
>   mfd: ti_am335x_tscadc: Get rid of useless gotos
>   mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
>   mfd: ti_am335x_tscadc: Don't search the tree for our clock
>   mfd: ti_am335x_tscadc: Simplify divisor calculation
>   mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
>   mfd: ti_am335x_tscadc: Use driver data
>   mfd: ti_am335x_tscadc: Mimic the probe from resume()
>   mfd: ti_am335x_tscadc: Drop useless variables from the driver
>     structure
>   mfd: ti_am335x_tscadc: Always provide an idle configuration
>   mfd: ti_am335x_tscadc: Reorder the initialization steps
>   mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
>   mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
>   mfd: ti_am335x_tscadc: Fix header spacing
>   mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
>   mfd: ti_am335x_tscadc: Use BIT(), GENMASK() and FIELD_PREP() when
>     relevant
>   mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
>   mfd: ti_am335x_tscadc: Drop useless definitions from the header
>   mfd: ti_am335x_tscadc: Rename the subsystem enable macro
>   mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
>   mfd: ti_am335x_tscadc: Rename a variable
>   mfd: ti_am335x_tscadc: Fix an error message
>   mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a
>     touchscreen
>   mfd: ti_am335x_tscadc: Introduce has_tsc
>   mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
>   mfd: ti_am335x_tscadc: Support the correctly spelled DT property

The MFD patches I haven't reviewed/replied to seem fine.

>   iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
>   iio: adc: ti_am335x_adc: Replace license text with SPDX tag
>   iio: adc: ti_am335x_adc: Fix style
>   iio: adc: ti_am335x_adc: Get rid of useless gotos
>   iio: adc: ti_am335x_adc: Gather the checks on the delays
>   iio: adc: ti_am335x_adc: Add a unit to the timeout delay
>   iio: adc: ti_am335x_adc: Add the scale information
>   iio: adc: ti_am335x_adc: Add the am437x compatible
>   ARM: dts: am437x-cm-t43: Use a correctly spelled DT property
>   ARM: dts: am43xx: Describe the magnetic reader/ADC1 hardware module
>   ARM: dts: am437x-gp-evm: enable ADC1
> 
>  .../bindings/iio/adc/ti,am3359-adc.yaml       |  70 +++++
>  .../input/touchscreen/ti,am3359-tsc.yaml      |  76 ++++++
>  .../bindings/input/touchscreen/ti-tsc-adc.txt |  91 -------
>  .../bindings/mfd/ti,am3359-tscadc.yaml        |  84 ++++++
>  arch/arm/boot/dts/am437x-cm-t43.dts           |   2 +-
>  arch/arm/boot/dts/am437x-gp-evm.dts           |   8 +
>  arch/arm/boot/dts/am437x-l4.dtsi              |  31 ++-
>  arch/arm/boot/dts/am43xx-clocks.dtsi          |   7 +
>  drivers/clk/ti/clk-43xx.c                     |   1 +
>  drivers/iio/adc/ti_am335x_adc.c               | 220 +++++++++-------
>  drivers/mfd/ti_am335x_tscadc.c                | 243 ++++++++++--------
>  include/dt-bindings/clock/am4.h               |   1 +
>  include/linux/mfd/ti_am335x_tscadc.h          | 115 ++++-----
>  13 files changed, 599 insertions(+), 350 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
