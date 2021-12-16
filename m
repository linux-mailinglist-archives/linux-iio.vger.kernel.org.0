Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD9477070
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 12:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhLPLlG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 06:41:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46718 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhLPLlF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 06:41:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2DB861C3C
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 11:41:05 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 2C140C36AE6;
        Thu, 16 Dec 2021 11:41:02 +0000 (UTC)
Date:   Thu, 16 Dec 2021 11:46:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <20211216114627.59d2f21e@jic23-huawei>
In-Reply-To: <YbdBwDllp+BB/Pei@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <YbdBwDllp+BB/Pei@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Dec 2021 09:51:12 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > v2: Picked up Rob's tag for the binding
> >     Rebase and a trivial white space tidy up.
> > 
> > Marcelo expressed interest in reviewing this one, but given it's
> > been a while I'm resending in the hope that someone else will have
> > time to take a look. Obviously if anyone wants to try the emulation
> > that's great but fundamental thing I'm looking for here is review of
> > the final patch as that has the whole driver in it.
> >   
> I've been spending some time with this part's datasheet to provide a proper
> review of this series. This has been on my TODO list for a while now. For now
> I've got patches 1 and 2 only. The good news is that now I'm giving priority to
> this so will send the review for the rest along this week.

Thanks!  Much appreciated particularly as it's more than possible I read the
datasheet wrong in both driver and emulation :)

Jonathan

> 
> > Note we don't require perfection for staging graduations, so futher
> > cleanup can be delayed until it's out of staging.
> > The interesting stuff here is anything related to the ABI as that
> > is pretty much fixed once it's out of staging.  Obviously any
> > feedback welcome.
> > 
> > v1 cover letter.
> > 
> > Hi All,
> > 
> > This one proved an interesting diversion.
> > 
> > Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
> > ad7280a devices (18 channels).  Note that the emulation isn't complete
> > but does do chaining, CRC, and readout of channels etc in a fashion that
> > worked with the original driver (up to the bug in patch 1) and continues
> > to work with the updated version. I've not intention to upstream the
> > emulation (as would need to make it more completed and flexible), but
> > happy to share it with anyone who is interested.
> > 
> > I briefly flirted with posting a patch to just drop the driver entirely,
> > but the part is still available and it looked like fun + isn't going
> > to greatly impact maintainability of the subsystem long term so is low
> > cost even if it goes obsolete sometime soonish.
> > 
> > There are lots of things we could do after this set to improved the driver
> > and make things more flexible, but it should basically 'just work'
> > 
> > Anyhow, as normal for staging graduations, last patch has rename detection
> > turned off so that people can easily see what I am proposing we move
> > out of staging.
> > 
> > Jonathan Cameron (17):
> >   staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
> >   staging:iio:adc:ad7280a: Register define cleanup.
> >   staging:iio:adc:ad7280a: rename _read() to _read_reg()
> >   staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
> >   staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
> >     transfers.
> >   staging:iio:adc:ad7280a: Switch to standard event control
> >   staging:iio:adc:ad7280a: Standardize extended ABI naming
> >   staging:iio:adc:ad7280a: Drop unused timestamp channel.
> >   staging:iio:adc:ad7280a: Trivial comment formatting cleanup
> >   staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
> >   staging:iio:adc:ad7280a: Cleanup includes
> >   staging:iio:ad7280a: Reflect optionality of irq in ABI
> >   staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
> >   staging:iio:adc:ad7280a: Use device properties to replace platform
> >     data.
> >   dt-bindings:iio:adc:ad7280a: Add binding
> >   iio:adc:ad7280a: Document ABI for cell balance switches
> >   iio:adc:ad7280a: Move out of staging
> > 
> >  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   13 +
> >  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
> >  drivers/iio/adc/Kconfig                       |   11 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
> >  drivers/staging/iio/adc/Kconfig               |   11 -
> >  drivers/staging/iio/adc/Makefile              |    1 -
> >  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
> >  drivers/staging/iio/adc/ad7280a.h             |   37 -
> >  9 files changed, 1228 insertions(+), 1093 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> >  create mode 100644 drivers/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> > 
> > -- 
> > 2.34.1
> >   

