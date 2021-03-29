Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BE634D406
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhC2PgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhC2Pf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 11:35:59 -0400
Received: from saturn.retrosnub.co.uk (saturn.retrosnub.co.uk [IPv6:2a00:1098:86::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178FC061574
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 08:35:59 -0700 (PDT)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 992CF9E0190;
        Mon, 29 Mar 2021 16:35:55 +0100 (BST)
Date:   Mon, 29 Mar 2021 16:36:01 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/24] staging:iio:cdc:ad7150: cleanup / fixup /
 graduate
Message-ID: <20210329163601.3e3a88ac@jic23-huawei>
In-Reply-To: <20210329163021.20d9c9b7@jic23-huawei>
References: <20210314181511.531414-1-jic23@kernel.org>
        <20210329163021.20d9c9b7@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 16:30:21 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Hi All,
> 
> Whilst I'll give up at some point and just apply this without additional
> tags I really don't like doing that as I've made too many idiot mistakes
> in the past. 
> 
> Some of these are fairly trivial so please can people take a look if
> they have a chance. Rob did the DT one (thanks!) so we are down to...
> 
> > 
> > 12 - The big irq rework patch. Alex wasn't quite happy to give a tag
> >      on that last time, but didn't mention anything specific. It's a bit
> >      fiddly so fair enough!  
> 
> (it's not that bad!)
> 

20 had an ack that I think was accidentally sent off list and hence burried
in my junk. And then there were two...

> > 
> > 21 - ABI patch.  I don't think there is anything controversial in here
> >      but it's not gained any tags yet.
> >        
> 
> Perhaps didn't help that I accidentally didn't cc Barry on v2.
> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > v1 description:
> > 
> > This is an 'old' driver in IIO that has been in staging a while.
> > First submitted in October 2010.
> > 
> > I wanted to try and experiment and picked this driver to try it with.
> > 
> > The cleanup etc here was all tested against some basic emulation
> > added to QEMU rather than real hardware.  Once I've cleaned that up
> > a tiny bit I'll push it up to https://github.com/jic23/qemu
> > Note that for now I'm not proposing to upstream this to QEMU but
> > would be interested in hearing if people thing it is a good idea to
> > do so.
> > 
> > Whilst it's obviously hard to be absolutely sure that the emulation is
> > correct, the fact that the original driver worked as expected and the
> > cleaned up version still does is certainly encouraging.
> > 
> > Note however, that there were a few more significant changes in here than
> > basic cleanup.
> > 1. Interrupts / events were handled in a rather esoteric fashion.
> >    (Always on, window modes represented as magnitudes).
> >    Note that for two channel devices there are separate lines. The original
> >    driver was not supporting this at all.
> >    They now look more like a standard IIO driver and reflect experience
> >    that we've gained over the years in dealing with devices where these
> >    aren't interrupt lines as such, but rather reporters of current status.
> > 2. Timeouts were handled in a fashion that clearly wouldn't work.
> > 
> > Note that this moving out of staging makes a few bits of ABI 'official'
> > and so those are added to the main IIO ABI Docs.
> > 
> > Thanks in advance to anyone who has time to take a look.
> > 
> > Jonathan Cameron (24):
> >   staging:iio:cdc:ad7150: use swapped reads for i2c rather than open
> >     coding.
> >   staging:iio:cdc:ad7150: Remove magnitude adaptive events
> >   staging:iio:cdc:ad7150: Refactor event parameter update
> >   staging:iio:cdc:ad7150: Timeout register covers both directions so
> >     both need updating
> >   staging:iio:cdc:ad7150: Drop platform data support
> >   staging:iio:cdc:ad7150: Handle variation in chan_spec across device
> >     and irq present or not
> >   staging:iio:cdc:ad7150: Simplify event handling by only using rising
> >     direction.
> >   staging:iio:cdc:ad7150: Drop noisy print in probe
> >   staging:iio:cdc:ad7150: Add sampling_frequency support
> >   iio:event: Add timeout event info type
> >   staging:iio:cdc:ad7150: Change timeout units to seconds and use core
> >     support
> >   staging:iio:cdc:ad7150: Rework interrupt handling.
> >   staging:iio:cdc:ad7150: More consistent register and field naming
> >   staging:iio:cdc:ad7150: Reorganize headers.
> >   staging:iio:cdc:ad7150: Tidy up local variable positioning.
> >   staging:iio:cdc:ad7150: Drop unnecessary block comments.
> >   staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
> >   staging:iio:cdc:ad7150: Add scale and offset to
> >     info_mask_shared_by_type
> >   staging:iio:cdc:ad7150: Really basic regulator support.
> >   staging:iio:cdc:ad7150: Add of_match_table
> >   iio:Documentation:ABI Add missing elements as used by the adi,ad7150
> >   staging:iio:cdc:ad7150: Add copyright notice given substantial
> >     changes.
> >   dt-bindings:iio:cdc:adi,ad7150 binding doc
> >   iio:cdc:ad7150: Move driver out of staging.
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio       |  33 +
> >  .../bindings/iio/cdc/adi,ad7150.yaml          |  69 ++
> >  drivers/iio/Kconfig                           |   1 +
> >  drivers/iio/Makefile                          |   1 +
> >  drivers/iio/cdc/Kconfig                       |  17 +
> >  drivers/iio/cdc/Makefile                      |   6 +
> >  drivers/iio/cdc/ad7150.c                      | 678 ++++++++++++++++++
> >  drivers/iio/industrialio-event.c              |   1 +
> >  drivers/staging/iio/cdc/Kconfig               |  10 -
> >  drivers/staging/iio/cdc/Makefile              |   3 +-
> >  drivers/staging/iio/cdc/ad7150.c              | 655 -----------------
> >  include/linux/iio/types.h                     |   1 +
> >  12 files changed, 808 insertions(+), 667 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
> >  create mode 100644 drivers/iio/cdc/Kconfig
> >  create mode 100644 drivers/iio/cdc/Makefile
> >  create mode 100644 drivers/iio/cdc/ad7150.c
> >  delete mode 100644 drivers/staging/iio/cdc/ad7150.c
> >   
> 

