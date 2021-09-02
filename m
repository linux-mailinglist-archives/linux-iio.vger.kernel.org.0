Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1948B3FF5E1
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347613AbhIBVws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:52:48 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57211 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347600AbhIBVwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:52:47 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B96F2240006;
        Thu,  2 Sep 2021 21:51:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/46] TI AM437X ADC1
Date:   Thu,  2 Sep 2021 23:50:58 +0200
Message-Id: <20210902215144.507243-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This is a (fairly big) series bringing support of AM437X ADC1.
On TI AM33XX SoCs family there is an ADC that can also be connected to a
touchscreen. This hardware has been extended and is present on certain
SoCs from the AM437X family. In particular, the touchscreen has been
replaced by a magnetic card reader. In both cases, the representation is
an MFD device with two children:
- on AM33XX: the touchscreen controller and the ADC
- on AM437X: the magnetic card reader and the ADC

This series really targets small and atomic changes so that the overall
review is eased, even though it leads to a lot of rather small patches.
Here are the steps:
* Supporting the missing clock
* Translating a single text file containing the description for the
  MFD, the touchscreen and the ADC into three independent yaml files.
* Cleaning/preparing the MFD driver.
* Supporting ADC1 in the MFD driver.
* Cleaning/preparing of the ADC driver.
* Supporting ADC1 in the ADC driver.
* Updating various device trees.

Here is the full series again. I decided not to split it given the fact
that I moved things around a little bit and addressed several different
issues which impacted other patches, perhaps the next iteration if needed
will be focused on a subset of patches. The clock patch has been acked,
the ADC patches almost as well, so we expect the series to go through
the MFD tree now.

Thanks,
Miquèl

Changes in v2:
* Added various R-by/A-by tags.
* Various typos & style fixes.
[Bindings]
* Included the missing ti,am654-tscadc compatible.
* Reworded the compatible lines as requested by Jonathan.
* Reworded the bindings content a little bit as advised by Rob (subnodes
  being objects, MFD descriptions provided once, status and unused
  labels removed).
[SPDX changes]
* Mentioned that the license macro and the license text matched.
* Also added an SPDX tag in the MFD header.
[MFD header]
* Used the BIT(), GENMASK() and PREP_FIELD() macros when relevant.
[MFD driver]
* Did not reordered the variables declared on the probe stack as advised
  by Jonathan.
* Added missing of_node_put() calls.
* Moved the patch changing the place where the main structure is
  allocated to directly precede the patch using this change.
* Fixed the driver data wiring (bug happening between ex patches 16 and
  28).
* Added a commit just to explain the reordering of the register writes
  during initialization/resume.
* Explained the check about 'use_tsc' in the commit message.
* Added a link to the TRM in a commit message referencing it.
* Removed the use of the ti,tracks property, used a constant value
  instead.
* Dropped the error check when retrieving the "wrong" DT property
  (coordiante-readouts) which is unused.

Miquel Raynal (46):
  clk: ti: am43xx: Add clkctrl data for am43xx ADC1
  dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this
    MFD
  dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
  dt-bindings: iio: adc: ti,am3359-adc: New yaml description
  dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
  dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
  dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
  mfd: ti_am335x_tscadc: Replace license text with SPDX tag
  mfd: ti_am335x_tscadc: Fix style
  mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack
    variables
  mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
  mfd: ti_am335x_tscadc: Get rid of useless gotos
  mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
  mfd: ti_am335x_tscadc: Don't search the tree for our clock
  mfd: ti_am335x_tscadc: Simplify divisor calculation
  mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
  mfd: ti_am335x_tscadc: Use driver data
  mfd: ti_am335x_tscadc: Mimic the probe from resume()
  mfd: ti_am335x_tscadc: Drop useless variables from the driver
    structure
  mfd: ti_am335x_tscadc: Always provide an idle configuration
  mfd: ti_am335x_tscadc: Reorder the initialization steps
  mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
  mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
  mfd: ti_am335x_tscadc: Fix header spacing
  mfd: ti_am335x_tscadc: Use BIT() and GENMASK() when relevant in the
    header
  mfd: ti_am335x_tscadc: Use FIELD_PREP() when relevant in the header
  mfd: ti_am335x_tscadc: Rename the subsystem enable macro
  mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
  mfd: ti_am335x_tscadc: Rename a variable
  mfd: ti_am335x_tscadc: Fix an error message
  mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a
    touchscreen
  mfd: ti_am335x_tscadc: Introduce has_tsc
  mfd: ti_am335x_tscadc: Move control register configuration
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
  ARM: dts: am437x-cm-t43: Use a correctly spelled DT property
  ARM: dts: am43xx: Describe the magnetic reader/ADC1 hardware module
  ARM: dts: am437x-gp-evm: enable ADC1

 .../bindings/iio/adc/ti,am3359-adc.yaml       |  70 +++++
 .../input/touchscreen/ti,am3359-tsc.yaml      |  76 ++++++
 .../bindings/input/touchscreen/ti-tsc-adc.txt |  91 -------
 .../bindings/mfd/ti,am3359-tscadc.yaml        |  84 ++++++
 arch/arm/boot/dts/am437x-cm-t43.dts           |   2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts           |   8 +
 arch/arm/boot/dts/am437x-l4.dtsi              |  31 ++-
 arch/arm/boot/dts/am43xx-clocks.dtsi          |   7 +
 drivers/clk/ti/clk-43xx.c                     |   1 +
 drivers/iio/adc/ti_am335x_adc.c               | 217 +++++++++-------
 drivers/mfd/ti_am335x_tscadc.c                | 242 ++++++++++--------
 include/dt-bindings/clock/am4.h               |   1 +
 include/linux/mfd/ti_am335x_tscadc.h          | 127 ++++-----
 13 files changed, 609 insertions(+), 348 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml

-- 
2.27.0

