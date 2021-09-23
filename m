Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872A6415A19
	for <lists+linux-iio@lfdr.de>; Thu, 23 Sep 2021 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhIWIhb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 23 Sep 2021 04:37:31 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:55285 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbhIWIhb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 04:37:31 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3395424000C;
        Thu, 23 Sep 2021 08:35:57 +0000 (UTC)
Date:   Thu, 23 Sep 2021 10:35:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20210923103556.75b820b7@xps13>
In-Reply-To: <YUtTeIWKnalzJS7S@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <YUtTeIWKnalzJS7S@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Wed, 22 Sep 2021 17:02:00 +0100:

> On Wed, 15 Sep 2021, Miquel Raynal wrote:
> 
> > Hello,
> > 
> > This is a (fairly big) series bringing support of AM437X ADC1.
> > On TI AM33XX SoCs family there is an ADC that can also be connected to a
> > touchscreen. This hardware has been extended and is present on certain
> > SoCs from the AM437X family. In particular, the touchscreen has been
> > replaced by a magnetic card reader. In both cases, the representation is
> > an MFD device with two children:
> > * on AM33XX: the touchscreen controller and the ADC
> > * on AM437X: the magnetic card reader and the ADC
> > 
> > This series really targets small and atomic changes so that the overall
> > review is eased, even though it leads to a lot of rather small patches.
> > Here are the steps:
> > * Supporting the missing clock
> > * Translating a single text file containing the description for the
> >   MFD, the touchscreen and the ADC into three independent yaml files.
> > * Cleaning/preparing the MFD driver.
> > * Supporting ADC1 in the MFD driver.
> > * Cleaning/preparing of the ADC driver.
> > * Supporting ADC1 in the ADC driver.
> > * Updating various device trees.
> > 
> > Here is the full series again, almost reviewed and acked entirely, but
> > rebased on the last -rc1. The clock patch has been acked, the ADC
> > patches as well, so we expect the series to go through the MFD
> > tree if hte maintainers agree with it.
> > 
> > Thanks,
> > Miquèl
> > 
> > Changes in v3:
> > * Rebased on top of v5.15-rc1.
> > * R-by/A-by tags added.
> > * Light reordering to let the of_put_node() fix to be applied more easily
> > * Dropped a patch made useless because of the previous reordering
> > * Explained how the tscadc->ctrl variable was used.
> > * Fixed a couple of typos.
> > * Included the change for the HZ macro.
> > * Went further in the BIT()/FIELD_PREP() cleanup.
> > * Added maximum definitions for sample delay/open delay.
> > * Removed useless definitions.
> > * Fixed a couple of rebase conflicts (the series was not bisectable).
> > 
> > Changes in v2:
> > * Added various R-by/A-by tags.
> > * Various typos & style fixes.
> > [Bindings]
> > * Included the missing ti,am654-tscadc compatible.
> > * Reworded the compatible lines as requested by Jonathan.
> > * Reworded the bindings content a little bit as advised by Rob (subnodes
> >   being objects, MFD descriptions provided once, status and unused
> >   labels removed).
> > [SPDX changes]
> > * Mentioned that the license macro and the license text matched.
> > * Also added an SPDX tag in the MFD header.
> > [MFD header]
> > * Used the BIT(), GENMASK() and PREP_FIELD() macros when relevant.
> > [MFD driver]
> > * Did not reordered the variables declared on the probe stack as advised
> >   by Jonathan.
> > * Added missing of_node_put() calls.
> > * Moved the patch changing the place where the main structure is
> >   allocated to directly precede the patch using this change.
> > * Fixed the driver data wiring (bug happening between ex patches 16 and
> >   28).
> > * Added a commit just to explain the reordering of the register writes
> >   during initialization/resume.
> > * Explained the check about 'use_tsc' in the commit message.
> > * Added a link to the TRM in a commit message referencing it.
> > * Removed the use of the ti,tracks property, used a constant value
> >   instead.
> > * Dropped the error check when retrieving the "wrong" DT property
> >   (coordiante-readouts) which is unused.
> > 
> > 
> > Miquel Raynal (47):
> >   clk: ti: am43xx: Add clkctrl data for am43xx ADC1
> >   dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this
> >     MFD
> >   dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
> >   dt-bindings: iio: adc: ti,am3359-adc: New yaml description
> >   dt-bindings: touchscreen: ti,am3359-tsc: Remove deprecated text file
> >   dt-bindings: mfd: ti,am3359-tscadc: Describe am4372 MFD compatible
> >   dt-bindings: iio: adc: ti,am3359-adc: Describe am4372 ADC compatible
> >   mfd: ti_am335x_tscadc: Ensure a balanced number of node get/put
> >   mfd: ti_am335x_tscadc: Replace license text with SPDX tag
> >   mfd: ti_am335x_tscadc: Fix style
> >   mfd: ti_am335x_tscadc: Drop extra spacing when declaring stack
> >     variables
> >   mfd: ti_am335x_tscadc: Get rid of useless gotos
> >   mfd: ti_am335x_tscadc: Reword the comment explaining the dividers
> >   mfd: ti_am335x_tscadc: Don't search the tree for our clock
> >   mfd: ti_am335x_tscadc: Simplify divisor calculation
> >   mfd: ti_am335x_tscadc: Move the driver structure allocation earlier
> >   mfd: ti_am335x_tscadc: Use driver data
> >   mfd: ti_am335x_tscadc: Mimic the probe from resume()
> >   mfd: ti_am335x_tscadc: Drop useless variables from the driver
> >     structure
> >   mfd: ti_am335x_tscadc: Always provide an idle configuration
> >   mfd: ti_am335x_tscadc: Reorder the initialization steps
> >   mfd: ti_am335x_tscadc: Gather the ctrl register logic in one place
> >   mfd: ti_am335x_tscadc: Replace the header license text with SPDX tag
> >   mfd: ti_am335x_tscadc: Fix header spacing
> >   mfd: ti_am335x_tscadc: Use the new HZ_PER_MHZ macro
> >   mfd: ti_am335x_tscadc: Use BIT(), GENMASK() and FIELD_PREP() when
> >     relevant
> >   mfd: ti_am335x_tscadc: Clarify the maximum values for DT entries
> >   mfd: ti_am335x_tscadc: Drop useless definitions from the header
> >   mfd: ti_am335x_tscadc: Rename the subsystem enable macro
> >   mfd: ti_am335x_tscadc: Add TSC prefix in certain macros
> >   mfd: ti_am335x_tscadc: Rename a variable
> >   mfd: ti_am335x_tscadc: Fix an error message
> >   mfd: ti_am335x_tscadc: Add a boolean to clarify the presence of a
> >     touchscreen
> >   mfd: ti_am335x_tscadc: Introduce has_tsc
> >   mfd: ti_am335x_tscadc: Add ADC1/magnetic reader support
> >   mfd: ti_am335x_tscadc: Support the correctly spelled DT property  
> 
> The MFD patches I haven't reviewed/replied to seem fine.

Great!

I'll address all your comments, bring-in the latest
Reviewed-by/Acked-by that I received on the other patches and send a
v4. Thanks for the feedback.

Cheers,
Miquèl
