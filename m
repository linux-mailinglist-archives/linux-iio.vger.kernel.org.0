Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8C3ECA20
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhHOQCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhHOQCR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:02:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C686761221;
        Sun, 15 Aug 2021 16:01:39 +0000 (UTC)
Date:   Sun, 15 Aug 2021 17:04:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4 0/3] Renesas RZ/G2L ADC driver support
Message-ID: <20210815170437.32be4ac1@jic23-huawei>
In-Reply-To: <CA+V-a8v0P-Xds51o9yDq0W67rfpAmCt=y=8S8BRWz=mkXLvtHw@mail.gmail.com>
References: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20210808180143.6b3dc882@jic23-huawei>
        <CA+V-a8v0P-Xds51o9yDq0W67rfpAmCt=y=8S8BRWz=mkXLvtHw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Aug 2021 14:04:33 +0100
"Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sun, Aug 8, 2021 at 5:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Wed,  4 Aug 2021 21:21:15 +0100
> > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >  
> > > Hi All,
> > >
> > > This patch series adds ADC support for Renesas RZ/G2L family.
> > >
> > > Patches apply on top of v5.14-rc2.  
> > Hi Lad, I'm fine with this, but need to pull my tree forwards
> > to include the header that is only in rc2.
> >
> > I'll probably do that later in the week then pick up patches 1 and 2.
> >  
> Thanks.
> 
> Geert could you please pick patch 3/3.
1 and 2 now applied to the togreg branch of iio.git and pushed out
as testing to see if 0-day can break them.

Thanks,

Jonathan
> 
> Cheers,
> Prabhakar
> 
> > Thanks,
> >
> > Jonathan  
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Changes for v4:
> > > * Fixed registering action to assert resets on failure/remove
> > >   as reported by Philip.
> > > * Fixed review comments suggested by Jonathan.
> > > * Included RB tag from Rob for patch 1/3
> > > * Note DTS patch applies on top of https://git.kernel.org/pub/scm/
> > >   linux/kernel/git/geert/renesas-devel.git/log/
> > >   ?h=renesas-arm-dt-for-v5.15
> > >
> > > Changes for v3 (as requested by Jonathan):
> > > * Made use of FIELD_PREP()
> > > * Renamed _CLEAR to _MASK and inverted inline as required
> > > * Moved |= pair's on same lines
> > > * Made use of sysfs_emit() while reading the labels
> > > * Used for_each_bit_set() in rzg2l_adc_isr()
> > > * Renamed rzg2l_adc_parse_of() -> rzg2l_adc_parse_properties()
> > > * Used devm_add_action_or_reset() for asserting the reset signals and
> > >   disabling pm_runtime and eventually removing remove() callback
> > > * Added comments in isr handler for channel select interrupt
> > > * Moved enabling/disabling of pclk during hw init in rzg2l_adc_hw_init()
> > > * Dropped clock patch 3/4 (https://lore.kernel.org/patchwork/patch/1462152/)
> > >   from previous series as its queued up in renesas-clk-for-v5.15
> > >
> > > Changes for v2:
> > > * Update binding doc, dropped gpios/renesas-rzg2l,adc-trigger-mode
> > >   properties included channel property to represent each wired channel.
> > > * Fixed review comments pointed by Alexandru, implemented pm runtime
> > >   support, dropped mlock usage
> > > * Fixed review comments pointed by Jonathan, renamed the macros,
> > >   simplified the code.
> > > * Included clock and DT patches
> > >
> > > v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> > >     20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > >
> > > Lad Prabhakar (3):
> > >   dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
> > >     A/D converter
> > >   iio: adc: Add driver for Renesas RZ/G2L A/D converter
> > >   arm64: dts: renesas: r9a07g044: Add ADC node
> > >
> > >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++
> > >  MAINTAINERS                                   |   8 +
> > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
> > >  drivers/iio/adc/Kconfig                       |  10 +
> > >  drivers/iio/adc/Makefile                      |   1 +
> > >  drivers/iio/adc/rzg2l_adc.c                   | 600 ++++++++++++++++++
> > >  6 files changed, 795 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> > >  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> > >  
> >  

