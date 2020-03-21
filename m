Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9918DFA4
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 11:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgCUKsa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 06:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgCUKsa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 06:48:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88201206F9;
        Sat, 21 Mar 2020 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584787709;
        bh=G9TQJhuKk9QTxhifNhsvZL3BXJunCj0M8xqSAZqlYJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b4E8lQ1V2L9jJ8Zja0K4eVYe5qinxxtLitE0pUk2vayOmR8831U5SJrxtUKbqYTJs
         3wzqFDFTxaT+LtzndqvE/lo9mEvRXVvJcHd4wN67OlJb1ReJJk906GhW3B7YseFSm9
         QRC7yDqp3Qoh/fN2RGZcqfK6oRJUVjC2HLckUOoU=
Date:   Sat, 21 Mar 2020 10:48:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v9 0/8] iio: adi-axi-adc,ad9647: Add support for AD9467
 ADC
Message-ID: <20200321104829.040661d9@archlinux>
In-Reply-To: <227c4c793044ca9a4e50f5d68d3de204c53d26e6.camel@analog.com>
References: <20200312083511.28832-1-alexandru.ardelean@analog.com>
        <20200315130625.705548ce@archlinux>
        <227c4c793044ca9a4e50f5d68d3de204c53d26e6.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 08:47:27 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-03-15 at 13:06 +0000, Jonathan Cameron wrote:
> > On Thu, 12 Mar 2020 10:35:03 +0200
> > Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
> >   
> > > This changeset adds support for the AD9467 LVDS High-Speed ADC.
> > > In order to support it, support for an FPGA ADI AXI ADC is added in this
> > > set.
> > > This uses the current support for IIO buffer DMAEngine.  
> > 
> > I took a look through this series and I'm think I'm now happy with it.
> > However, I'd like to leave a bit of time for Rob, the DT binding
> > Maintainer to take a look at the bindings.
> > 
> > Long term I sort of wonder if we might get some alternative for the
> > ADI-AXI interface, either because Analog decide to rewrite it, or
> > because someone else puts together similar IP. At that point we may
> > want a more sophisticated registration framework etc.  I guess we
> > can wait and see if anyone ever does that though.  
> 
> This registration mechanism is a bit of a rewrite of an older mechanism that's
> been in-use for 7+ years.
> https://github.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/cf_axi_adc_core.c#L832
> Essentially, the old one searches on the SPI bus for a device, while this one
> makes the coupling to the AXI-ADC driver a bit tighter, by requiring it to
> explicitly register with the AXI-ADC driver.
> No idea which is better; since both implementations require knowledge about the
> AXI-ADC driver.
> In the DT, the main difference is a rename of the property 'spibus-connected' to
> 'adi,adc-dev'.

The approach here seems reasonable to me.  We can be more flexible
if we ever need to.

> 
> I agree that a more sophisticated/generalized interface between the 2 would be a
> better idea, but [given how long this has been as-is], I don't feel it happening
> really soon.
> 
> I'm also preparing now an AXI-DAC driver, similar to this one.
> The idea would be to also prepare upstreaming the AD9361, which is an RF
> transceiver. I'm not sure whether that would classify as an MFD device [ADC &
> DAC], or whether as an IIO device, with a drivers/iio/transceiver sub-type.

We did have the slightly silly naming of addac in staging for a while.

Anyhow, I'd say a single driver (not mfd), in a new directory as appropriate.

> 
> Related, what would be interesting, is a generic multi-chip-sync mechanism.
> For many complicated devices [typically high-speed ADCs/DACs/transceivers], this
> seems to be a more common use-case.
> I've been wondering about a way to do it; if you have any input, or a subsystem
> that does that well, I'm open to inputs.
> MFD doesn't seem to be quite be that. Doing it with clocks has been tried and is
> not very easy.
> Another idea would be to try to implement some device-group mechanism. The idea
> would be to have state-transition tables, and each driver defines it's own
> callbacks for each state/state-transition. Whenever a device-group needs to jump
> a certain state, all callbacks are called to put each device in it's own sub-
> state.
> Still not sure how good this approach is, but it sounds the closest to something
> that would work.

I'm not sure I follow in enough detail what you mean to offer detailed opinions.
Are we talking pipeling type setups similar to the media framework does?

It would certainly be possible to have a notification system that multiple driver
can register to but I'm not sure I follow the usecase.  Perhaps some in depth
examples would help me understand?

Thanks,

Jonathan

> 
> Thanks
> Alex
> 
> > 
> > Jonathan
> >   
> > > Changelog v8 -> v9:
> > > * adding more Analog people to the list; predominantly HDL people; this
> > >   should help me sync people about the details of regs/reg-names
> > > * added 'Acked-by: Moritz Fischer <mdf@kernel.org>' tag to fpga patches
> > >   - we can always re-update these patches if something else is decided about
> > >     the location of the 'adi-axi-common.h' header; I'm not insisting about
> > >     where to put it; I'm open to other proposals
> > > * patch 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
> > >   - prefixed regs ADI_AXI_ ; I tried ADI_AXI_ADC_, but that seemed to make
> > >     them too long
> > >   - dropped unused regs; will add them as stuff gets added in the upstream
> > >     driver; in the meantime, reg-names can be reworked
> > >   - dropped generic LOWERXY_SET/GET macros
> > >   - update reg-names a bit; will update them in the docs and HDL
> > >   - order in adi_axi_adc_conv_unregister() should now be symmetrically
> > >     oppposite now to the register function
> > >   - implemented 'is_visible()' callback to adi_axi_adc_attributes[] so that
> > >     attrs can be made invisible to userspace if needed;
> > >   - 'indio_dev->name = "adi-axi-adc";'
> > >   - added kernel doc-string for @reg_access
> > > * patch 'iio: adc: ad9467: add support AD9467 ADC'
> > >   - ad9467_spi_read() split in 2 buffers; tbuf & rbuf
> > >   - removed 'if (chan->extend_name)' test ; left-over from initial driver
> > >   - removed 'if (!st->clk)' check; driver will fail probe without a clock
> > >   - removed 'if (!spi->dev.of_node)' in probe; shouldn't be needed
> > >   - using 'of_device_get_match_data()' in probe to get data; moved chip
> > >     info table entry as data on the of_device_id table
> > > 
> > > Changelog v7 -> v8:
> > > * in 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
> > >   - updated register definitions and bits to newer format/docs; the ref
> > > driver wasn't really up-to-date
> > >     -- prefixed bit names with reg-name to avoid bit definition colisions;
> > > that makes some macros longer, but at least the format is consistent
> > >   - using dev_name(&pdev->dev) for indio_dev->name
> > >   - moved reset to own axi_adc_reset() function; may be re-used later
> > >   - some re-formatting/alignment changes
> > >   - address ENOSYS checkpatch complaint; changed with EOPNOTSUPP
> > > 
> > > Changelog v6 -> v7:
> > > * Fixed dt-schema build for adi,axi-adc.yaml based on Rob's suggestion
> > >   - added '$ref: /schemas/types.yaml#/definitions/phandle' to 'adi,adc-dev'
> > >   - dropped 'maxItems' from 'adi,adc-dev'
> > > 
> > > Changelog v5 -> v6
> > > * fix URLs; got changed during rename
> > >    https://wiki.analog.com/resources/fpga/docs/adi_axi_adc_ip ->
> > >    https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> > >   - noticed while working on the AXI DAC driver
> > > 
> > > Changelog v4 -> v5:
> > > * update drivers/iio/adc/Kconfig note about module name; omitted during
> > > first rename
> > >    - 'module will be called axi-adc.' -> 'module will be called adi-axi-
> > > adc.'
> > > 
> > > Changelog v3 -> v4:
> > > * addressed Rob's dt-remarks
> > >    - change 'adi-axi-adc-client' prop to 'adi,adc-dev'
> > > 
> > > Changelog v2 -> v3:
> > > * addressed compiler warning
> > > 
> > > Changelog v1 -> v2:
> > > * first series was added a bit hastily
> > > * addressed  'make dt_binding_check' complaints; seems I missed a few when
> > > running the check; 
> > > * added missing patches to include/linux/fpga/adi-axi-common.h
> > >    - 'include: fpga: adi-axi-common.h: fixup whitespace tab -> space'
> > >    - 'include: fpga: adi-axi-common.h: add version helper macros'
> > > * patch 'iio: buffer-dmaengine: add dev-managed calls for buffer alloc/free'
> > >    - remove copy+pasted comment for 'devm_iio_dmaengine_buffer_alloc()'
> > >    - removed devm_iio_dmaengine_buffer_free() ; hopefully it might never be
> > > needed
> > >    - fix-up alignment for devm_iio_dmaengine_buffer_alloc() in header
> > > * patch 'iio: adc: adi-axi-adc: add support for AXI ADC IP core'
> > >    - renamed axi-adc.c -> adi-axi-adc.c & Kconfig symbol
> > >    - prefix all axi_adc -> adi_axi_adc
> > >    - removed switch statement in axi_adc_read_raw() & axi_adc_write_raw()
> > >    - remove axi_adc_chan_spec ; replaced with iio_chan_spec directly ; will
> > > think of a simpler solution for extra chan params
> > >    - removed left-over 'struct axi_adc_cleanup_data'
> > >    - moved 'devm_add_action_or_reset()' call right after
> > > 'adi_axi_adc_attach_client()'
> > >    - switched to using 'devm_platform_ioremap_resource()'
> > > * patch 'iio: adc: ad9467: add support AD9467 ADC'
> > >   - renamed ADI_ADC reg prefixes to AN877_ADC
> > >   - dropped 'info_mask_separate' field in AD9467_CHAN - will be re-added
> > > later when driver gets more features; was left-over from the initial ref
> > > driver
> > >   - remove .shift = 0,  in AD9467_CHAN
> > >   - renamed 'sample-clock' -> 'adc-clock'
> > >   - direct returns in ad9467_read_raw() & ad9467_write_raw() &
> > > ad9467_setup() switch statements
> > >   - removed blank line after devm_axi_adc_conv_register()
> > >   - removed ad9467_id & reworked to use ad9467_of_match
> > > 
> > > Alexandru Ardelean (6):
> > >   include: fpga: adi-axi-common.h: fixup whitespace tab -> space
> > >   include: fpga: adi-axi-common.h: add version helper macros
> > >   iio: buffer-dmaengine: use %zu specifier for sprintf(align)
> > >   iio: buffer-dmaengine: add dev-managed calls for buffer alloc
> > >   dt-bindings: iio: adc: add bindings doc for AXI ADC driver
> > >   dt-bindings: iio: adc: add bindings doc for AD9467 ADC
> > > 
> > > Michael Hennerich (2):
> > >   iio: adc: adi-axi-adc: add support for AXI ADC IP core
> > >   iio: adc: ad9467: add support AD9467 ADC
> > > 
> > >  .../bindings/iio/adc/adi,ad9467.yaml          |  65 +++
> > >  .../bindings/iio/adc/adi,axi-adc.yaml         |  63 +++
> > >  drivers/iio/adc/Kconfig                       |  35 ++
> > >  drivers/iio/adc/Makefile                      |   2 +
> > >  drivers/iio/adc/ad9467.c                      | 420 ++++++++++++++
> > >  drivers/iio/adc/adi-axi-adc.c                 | 518 ++++++++++++++++++
> > >  .../buffer/industrialio-buffer-dmaengine.c    |  41 +-
> > >  include/linux/fpga/adi-axi-common.h           |   6 +-
> > >  include/linux/iio/adc/adi-axi-adc.h           |  64 +++
> > >  include/linux/iio/buffer-dmaengine.h          |   3 +
> > >  10 files changed, 1215 insertions(+), 2 deletions(-)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-
> > > adc.yaml
> > >  create mode 100644 drivers/iio/adc/ad9467.c
> > >  create mode 100644 drivers/iio/adc/adi-axi-adc.c
> > >  create mode 100644 include/linux/iio/adc/adi-axi-adc.h
> > >   

