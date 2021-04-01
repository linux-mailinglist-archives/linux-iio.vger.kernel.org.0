Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AF35131C
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhDAKPn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 1 Apr 2021 06:15:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2755 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhDAKPc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 06:15:32 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F9zTJ6JCmz685qK;
        Thu,  1 Apr 2021 18:10:28 +0800 (CST)
Received: from lhreml719-chm.china.huawei.com (10.201.108.70) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 12:15:25 +0200
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 11:15:24 +0100
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Thu, 1 Apr 2021 18:15:22 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Robh+dt@kernel.org" <Robh+dt@kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup /
 graduate
Thread-Topic: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup /
 graduate
Thread-Index: AQHXJLCHuIN4NEiakEib4Q2/+Ou+W6qakvSAgAJttxCAAH5agIAB9Szg
Date:   Thu, 1 Apr 2021 10:15:22 +0000
Message-ID: <e6dd33f25592499988a11b4e4aa142a6@hisilicon.com>
References: <20210314181511.531414-1-jic23@kernel.org>
        <20210329163021.20d9c9b7@jic23-huawei>  <20210329163601.3e3a88ac@jic23-huawei>
        <9218f13e32e642a19cb7df6e7c8c358f@hisilicon.com>
 <20210331131327.5f938957@jic23-huawei>
In-Reply-To: <20210331131327.5f938957@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@jic23.retrosnub.co.uk]
> Sent: Thursday, April 1, 2021 1:13 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-iio@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Michael
> Hennerich <Michael.Hennerich@analog.com>; Alexandru Ardelean
> <aardelean@deviqon.com>; Robh+dt@kernel.org; Alexandru Ardelean
> <ardeleanalex@gmail.com>; Jonathan Cameron <jonathan.cameron@huawei.com>
> Subject: Re: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup / graduate
> 
> On Tue, 30 Mar 2021 21:23:59 +0000
> "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
> 
> > > -----Original Message-----
> > > From: Jonathan Cameron [mailto:jic23@jic23.retrosnub.co.uk]
> > > Sent: Tuesday, March 30, 2021 4:36 AM
> > > To: linux-iio@vger.kernel.org; Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> > > <Michael.Hennerich@analog.com>; Alexandru Ardelean
> <aardelean@deviqon.com>;
> > > Robh+dt@kernel.org; Alexandru Ardelean <ardeleanalex@gmail.com>; Jonathan
> > > Cameron <jonathan.cameron@huawei.com>
> > > Subject: Re: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup /
> graduate
> > >
> > > On Mon, 29 Mar 2021 16:30:21 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > > Hi All,
> > > >
> > > > Whilst I'll give up at some point and just apply this without additional
> > > > tags I really don't like doing that as I've made too many idiot mistakes
> > > > in the past.
> > > >
> > > > Some of these are fairly trivial so please can people take a look if
> > > > they have a chance. Rob did the DT one (thanks!) so we are down to...
> > > >
> > > > >
> > > > > 12 - The big irq rework patch. Alex wasn't quite happy to give a tag
> > > > >      on that last time, but didn't mention anything specific. It's a
> bit
> > > > >      fiddly so fair enough!
> > > >
> > > > (it's not that bad!)
> > > >
> > >
> > > 20 had an ack that I think was accidentally sent off list and hence burried
> > > in my junk. And then there were two...
> > >
> > > > >
> > > > > 21 - ABI patch.  I don't think there is anything controversial in here
> > > > >      but it's not gained any tags yet.
> > > > >
> > > >
> > > > Perhaps didn't help that I accidentally didn't cc Barry on v2.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >
> > > >
> > > >
> > > > > v1 description:
> > > > >
> > > > > This is an 'old' driver in IIO that has been in staging a while.
> > > > > First submitted in October 2010.
> > > > >
> > > > > I wanted to try and experiment and picked this driver to try it with.
> > > > >
> > > > > The cleanup etc here was all tested against some basic emulation
> > > > > added to QEMU rather than real hardware.  Once I've cleaned that up
> > > > > a tiny bit I'll push it up to https://github.com/jic23/qemu
> > > > > Note that for now I'm not proposing to upstream this to QEMU but
> > > > > would be interested in hearing if people thing it is a good idea to
> > > > > do so.
> > > > >
> > > > > Whilst it's obviously hard to be absolutely sure that the emulation
> is
> > > > > correct, the fact that the original driver worked as expected and the
> > > > > cleaned up version still does is certainly encouraging.
> > > > >
> > > > > Note however, that there were a few more significant changes in here
> than
> > > > > basic cleanup.
> > > > > 1. Interrupts / events were handled in a rather esoteric fashion.
> > > > >    (Always on, window modes represented as magnitudes).
> > > > >    Note that for two channel devices there are separate lines. The original
> > > > >    driver was not supporting this at all.
> > > > >    They now look more like a standard IIO driver and reflect experience
> > > > >    that we've gained over the years in dealing with devices where these
> > > > >    aren't interrupt lines as such, but rather reporters of current status.
> > > > > 2. Timeouts were handled in a fashion that clearly wouldn't work.
> > > > >
> > > > > Note that this moving out of staging makes a few bits of ABI 'official'
> > > > > and so those are added to the main IIO ABI Docs.
> > > > >
> > > > > Thanks in advance to anyone who has time to take a look.
> > > > >
> > > > > Jonathan Cameron (24):
> > > > >   staging:iio:cdc:ad7150: use swapped reads for i2c rather than open
> > > > >     coding.
> >
> > Using i2c_smbus_read_word_swapper and i2c_smbus_write_word_swapped
> > looks good to me. The only thing is that your changelog didn't
> > mention you also used swapper write as you said "use swapped
> > reads". Otherwise,
> >
> > Reviewed-by: Barry Song <song.bao.hua@hisilicon>
> >
> > > > >   staging:iio:cdc:ad7150: Remove magnitude adaptive events
> > > > >   staging:iio:cdc:ad7150: Refactor event parameter update
> > > > >   staging:iio:cdc:ad7150: Timeout register covers both directions so
> > > > >     both need updating
> > > > >   staging:iio:cdc:ad7150: Drop platform data support
> > > > >   staging:iio:cdc:ad7150: Handle variation in chan_spec across device
> > > > >     and irq present or not
> > > > >   staging:iio:cdc:ad7150: Simplify event handling by only using rising
> > > > >     direction.
> > > > >   staging:iio:cdc:ad7150: Drop noisy print in probe
> > > > >   staging:iio:cdc:ad7150: Add sampling_frequency support
> > > > >   iio:event: Add timeout event info type
> > > > >   staging:iio:cdc:ad7150: Change timeout units to seconds and use core
> > > > >     support
> > > > >   staging:iio:cdc:ad7150: Rework interrupt handling.
> >
> > +	/*
> > +	 * There are race conditions around enabling and disabling that
> > +	 * could easily land us here with a spurious interrupt.
> > +	 * Just eat it if so.
> > +	 */
> > +	if (!(int_status & status_mask))
> > +		return IRQ_HANDLED;
> > +
> >
> > I am not sure what kind of race conditions we have since disable_irq()
> > will synchronize with the irq handler.
> >
> > If we are in an interrupt, the user who calls disable_irq will wait
> > for the completion of irq handler.
> > If an interrupt comes in the gap of disable_irq and enable_irq, we should
> > have a valid int_status after we re-enable the interrupt?
> >
> > Maybe it is because of the weird behavior of the hardware?
> 
> I think you are right and I was being overly paranoid on that one. I'll drop
> the comment, though I'll leave the paranoid check.
> 

Yes. Make sense.

> >
> > > > >   staging:iio:cdc:ad7150: More consistent register and field naming
> > > > >   staging:iio:cdc:ad7150: Reorganize headers.
> > > > >   staging:iio:cdc:ad7150: Tidy up local variable positioning.
> > > > >   staging:iio:cdc:ad7150: Drop unnecessary block comments.
> > > > >   staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
> > > > >   staging:iio:cdc:ad7150: Add scale and offset to
> > > > >     info_mask_shared_by_type
> > > > >   staging:iio:cdc:ad7150: Really basic regulator support.
> > > > >   staging:iio:cdc:ad7150: Add of_match_table
> >
> > Reviewed-by: Barry Song <song.bao.hua@hisilicon>
> >
> > > > >   iio:Documentation:ABI Add missing elements as used by the adi,ad7150
> >
> > +What:		/sys/.../events/in_capacitanceY_adaptive_thresh_rising_en
> > +What:		/sys/.../events/in_capacitanceY_adaptive_thresh_falling_en
> > +KernelVersion:	5.11
> >
> > Is kernel 5.11 the right version? Guess not :-)
> Oops Can tell this took a while.  I'll tidy that up whilst applying.
> >
> > > > >   staging:iio:cdc:ad7150: Add copyright notice given substantial
> > > > >     changes.
> > > > >   dt-bindings:iio:cdc:adi,ad7150 binding doc
> >
> > Reviewed-by: Barry Song <song.bao.hua@hisilicon>
> >
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,ad7150
> > +              - adi,ad7156
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 2
> > +          maxItems: 2
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,ad7151
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          minItems: 1
> > +          maxItems: 1
> >
> > A further follow-up might be:
> > we can move to read two irq number for adi7150/7156
> > and one irq number for adi7151 in driver?
> 
> Unless I'm miss understanding you I think we already do.
> There is a check against the driver_data being AD7150 which is set for
> the two parts that have 2 interrupts.  If we don't get that we don't
> query the second irq number.

Sorry for missing that part.

> 
> >
> > > > >   iio:cdc:ad7150: Move driver out of staging.
> > > > >
> > > > >  Documentation/ABI/testing/sysfs-bus-iio       |  33 +
> > > > >  .../bindings/iio/cdc/adi,ad7150.yaml          |  69 ++
> > > > >  drivers/iio/Kconfig                           |   1 +
> > > > >  drivers/iio/Makefile                          |   1 +
> > > > >  drivers/iio/cdc/Kconfig                       |  17 +
> > > > >  drivers/iio/cdc/Makefile                      |   6 +
> > > > >  drivers/iio/cdc/ad7150.c                      | 678 ++++++++++++++++++
> > > > >  drivers/iio/industrialio-event.c              |   1 +
> > > > >  drivers/staging/iio/cdc/Kconfig               |  10 -
> > > > >  drivers/staging/iio/cdc/Makefile              |   3 +-
> > > > >  drivers/staging/iio/cdc/ad7150.c              | 655 -----------------
> > > > >  include/linux/iio/types.h                     |   1 +
> > > > >  12 files changed, 808 insertions(+), 667 deletions(-)
> > > > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
> > > > >  create mode 100644 drivers/iio/cdc/Kconfig
> > > > >  create mode 100644 drivers/iio/cdc/Makefile
> > > > >  create mode 100644 drivers/iio/cdc/ad7150.c
> > > > >  delete mode 100644 drivers/staging/iio/cdc/ad7150.c
> > > > >
> > > >
> >
> >
Thanks
Barry

