Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B24360FF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhJUMFI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhJUMFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 08:05:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568EDC061753
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:02:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r18so704390wrg.6
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+66ztlp2S24vDRQ1MInENOk33hsXduQT+x2D2y0sLew=;
        b=ecqoSHJYObNAVAuyjdiByagc4VdDj5FyN3U2UHy9QEPyn/wPQwmgpim5Ej/vyZNTt4
         3wcrfvK+cBPaEf4DnL18712D5IUSmDi6IQEeG00/cAaZ94gFbTvvBqGF9E0HhbiMfnBe
         UNOH6dQVZXx/jc2dd8o5t5LR2JSClpWtR/gmg+UPOULlzrFyZqHhhG1YWneIQC4I4d3T
         NVSJyxAUh7WV9CJoniZW9YbtZebIfhlBIt93Hm74FJBfgB0/yut7BRlmtOfKBwdIogtJ
         F6XayrXR9ht8PW83lefWHCmEdT+ux+iAgMCBl7QZgbtLibVhdyv5YcdnZZziWhl0Wz+v
         Wi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+66ztlp2S24vDRQ1MInENOk33hsXduQT+x2D2y0sLew=;
        b=4b0d/BCrUMYi5dhLsh0HPfviD8XCx39+wxfoauCm2J+j5vg8xts/17CHmGnH3ceiX6
         FksVuACvmFvq0LUk+3cU3Uf+l1d/x5HlyS3DFhTsNtYllxtyV0Idd34fIvn3vJmA0uoe
         k30UbMkFYJ+MEYqE2HN+LN4DPB+Lx3x8mkycMuYFQuW9+Tn9R7/QpNWifC9BK62Q+ynA
         ut0/SD6VA2pvNyMbou+6LyKFOYiyBgl2R+9eKw22jJddsMKY5OA6g0f03yKdGQEgQWA6
         Ezu6hJunr2I9yiOyLnLhSzRuAfqsWntCkfZ7TJPBexwC2MDASUABlD2j3AkD+bbEJiOd
         wCDg==
X-Gm-Message-State: AOAM532ainYz2B77gJ+2GiqD/2ebDV3knrDZmHpResQlxAAecXs5hyR2
        1u7H4ACH785OYJDLqeaWl5WRJg==
X-Google-Smtp-Source: ABdhPJwFfs/5sKCa/AM6W5aPkoxzFP02nlu9qRn1TINKXqXb+lVY15e+3uRLbz462hFU6Vd2S0n4yA==
X-Received: by 2002:adf:bbc8:: with SMTP id z8mr6690188wrg.281.1634817767865;
        Thu, 21 Oct 2021 05:02:47 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id k40sm1209825wms.21.2021.10.21.05.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:02:47 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:02:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, IIO, Input (Touchscreen)
 and Clk due for the v5.16 merge window
Message-ID: <YXFW5R8zK/g9Rqei@google.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-touchscreen-clk-v5.16

for you to fetch changes up to e7c8a5fe82ff8ee100c65598187674eef4748bf2:

  iio: adc: ti_am335x_adc: Add the am437x compatible (2021-10-21 10:02:48 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO, Input (Touchscreen) and Clk due for the v5.16 merge window

----------------------------------------------------------------
Miquel Raynal (45):
      clk: ti: am43xx: Add clkctrl data for am43xx ADC1
      dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this MFD
      dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
      dt-bindings: iio: adc: ti,am3359-adc: New yaml description
      dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
      dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
      dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
      mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
      mfd: ti_am335x_tscadc: Replace license text with SPDX tag
      mfd: ti_am335x_tscadc: Fix style
      mfd: ti_am335x_tscadc: Get rid of useless gotos
      mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack variables
      mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
      mfd: ti_am335x_tscadc: Don't search the tree for our clock
      mfd: ti_am335x_tscadc: Simplify divisor calculation
      mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
      mfd: ti_am335x_tscadc: Use driver data
      mfd: ti_am335x_tscadc: Mimic the probe from resume()
      mfd: ti_am335x_tscadc: Drop useless variables from the driver structure
      mfd: ti_am335x_tscadc: Always provide an idle configuration
      mfd: ti_am335x_tscadc: Reorder the initialization steps
      mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
      mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
      mfd: ti_am335x_tscadc: Fix header spacing
      mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
      mfd: ti_am335x_tscadc: Drop unused definitions from the header
      mfd: ti_am335x_tscadc: Use BIT(), GENMASK() and FIELD_PREP() when relevant
      mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
      mfd: ti_am335x_tscadc: Drop useless definitions from the header
      mfd: ti_am335x_tscadc: Rename the subsystem enable macro
      mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
      mfd: ti_am335x_tscadc: Rename a variable
      mfd: ti_am335x_tscadc: Fix an error message
      mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a touchscreen
      mfd: ti_am335x_tscadc: Introduce a helper to deal with the type of hardware
      mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
      mfd: ti_am335x_tscadc: Support the correctly spelled DT property
      iio: adc: ti_am335x_adc: Wait the idle state to avoid stalls
      iio: adc: ti_am335x_adc: Replace license text with SPDX tag
      iio: adc: ti_am335x_adc: Fix style
      iio: adc: ti_am335x_adc: Get rid of useless gotos
      iio: adc: ti_am335x_adc: Gather the checks on the delays
      iio: adc: ti_am335x_adc: Add a unit to the timeout delay
      iio: adc: ti_am335x_adc: Add the scale information
      iio: adc: ti_am335x_adc: Add the am437x compatible

 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml           |  70 ++++++++++
 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml |  76 +++++++++++
 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt     |  91 -------------
 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml            |  84 ++++++++++++
 drivers/clk/ti/clk-43xx.c                                              |   1 +
 drivers/iio/adc/ti_am335x_adc.c                                        | 220 ++++++++++++++++++-------------
 drivers/mfd/ti_am335x_tscadc.c                                         | 235 +++++++++++++++++++---------------
 include/dt-bindings/clock/am4.h                                        |   1 +
 include/linux/mfd/ti_am335x_tscadc.h                                   | 119 +++++++++--------
 9 files changed, 549 insertions(+), 348 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
