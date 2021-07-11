Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435813C3D6C
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhGKOv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 10:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233440AbhGKOv0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 10:51:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31961611AC;
        Sun, 11 Jul 2021 14:48:35 +0000 (UTC)
Date:   Sun, 11 Jul 2021 15:50:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        <linux-iio@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <20210711155051.713c1207@jic23-huawei>
In-Reply-To: <20210623093741.00007d1d@Huawei.com>
References: <20210614113507.897732-1-jic23@kernel.org>
        <YNIfkaRZtWIXPbAj@marsc.168.1.7>
        <20210623093741.00007d1d@Huawei.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Jun 2021 09:37:41 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 22 Jun 2021 14:36:17 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Hey Jonathan,
> > 
> > On 06/14, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Hi All,
> > > 
> > > This one proved an interesting diversion.
> > > 
> > > Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
> > > ad7280a devices (18 channels).  Note that the emulation isn't complete
> > > but does do chaining, CRC, and readout of channels etc in a fashion that
> > > worked with the original driver (up to the bug in patch 1) and continues
> > > to work with the updated version. I've not intention to upstream the
> > > emulation (as would need to make it more completed and flexible), but
> > > happy to share it with anyone who is interested.    
> > 
> > I'm interested in seeing your device emulation with QEMU.
> > I was looking at the ad7150 emulation you shared earlier this year but had
> > some trouble getting the i2c slave created.  
> 
> Sure.  Let me do a bit of tidying up they I'll push a suitable branch out.
> (probably will still have lots of stuff missing!)
> 
> Might take a little while to get to this though.

I pretended to myself for a few weeks that I'd get around to tidying this up in
a remotely meaningful way.  That's clearly not happening so I pushed out the
untidy version with appropriate eats babies messages:

https://github.com/jic23/qemu/commits/ad7280a-hacks

Note there is loads of stuff that isn't implemented as it was developed alongside
this patch series to verify individual patches rather than with the intent of
actually emulating the device.

It's hard coded to 2 a chain of 3 ad7280a devices because that seemed to hit most possible
corner cases.

The top commit has the launch string I'm using.  You'll need a filesystem, but
you can probably use one of the convenient ones debian posts as nocloud cloud
images. 

There is some info on that on people.kernel.org/jic23 as I wrote up how to test
CXL stuff on ARM recently and gave guidance on easy ways to get a filesystem.
http://cdimage.debian.org/cdimage/cloud/sid/daily/20210702-691/debian-sid-nocloud-arm64-daily-20210702-691.qcow2
will probably work and is more recent than the one linked from that blog post. 

Give me a shout if you need more specific guidance than this very very rough guide!

I mentioned this thread in the diversion the rust on linux thread took into
use of QEMU to emulate devices which motivated me to stop being lazy and at least
post this hideous version.  Probably the most useful bit is how to get a working
spi device emulated on the arm virt machine as that is very handy for all manner
of testing.  One day someone might implement a large set of IIO device emulation
and bolt it into a CI...

Jonathan

> 
> > 
> > Being able to see it running, I may feel more confident to provide a review
> > for this set :)  
> 
> :)
> 
> > 
> > Regards,
> > 
> > Marcelo  
> > > 
> > > I briefly flirted with posting a patch to just drop the driver entirely,
> > > but the part is still available and it looked like fun + isn't going
> > > to greatly impact maintainability of the subsystem long term so is low
> > > cost even if it goes obsolete sometime soonish.
> > > 
> > > There are lots of things we could do after this set to improved the driver
> > > and make things more flexible, but it should basically 'just work'
> > > 
> > > Anyhow, as normal for staging graduations, last patch has rename detection
> > > turned off so that people can easily see what I am proposing we move
> > > out of staging.
> > > 
> > > Jonathan Cameron (17):
> > >   staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
> > >   staging:iio:adc:ad7280a: Register define cleanup.
> > >   staging:iio:adc:ad7280a: rename _read() to _read_reg()
> > >   staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
> > >   staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
> > >     transfers.
> > >   staging:iio:adc:ad7280a: Switch to standard event control
> > >   staging:iio:adc:ad7280a: Standardize extended ABI naming
> > >   staging:iio:adc:ad7280a: Drop unused timestamp channel.
> > >   staging:iio:adc:ad7280a: Trivial comment formatting cleanup
> > >   staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
> > >   staging:iio:adc:ad7280a: Cleanup includes
> > >   staging:iio:ad7280a: Reflect optionality of irq in ABI
> > >   staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
> > >   staging:iio:adc:ad7280a: Use device properties to replace platform
> > >     data.
> > >   dt-bindings:iio:adc:ad7280a: Add binding
> > >   iio:adc:ad7280a: Document ABI for cell balance switches
> > >   iio:adc:ad7280a: Move out of staging
> > > 
> > >  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   14 +
> > >  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
> > >  drivers/iio/adc/Kconfig                       |   11 +
> > >  drivers/iio/adc/Makefile                      |    1 +
> > >  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
> > >  drivers/staging/iio/adc/Kconfig               |   11 -
> > >  drivers/staging/iio/adc/Makefile              |    1 -
> > >  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
> > >  drivers/staging/iio/adc/ad7280a.h             |   37 -
> > >  9 files changed, 1229 insertions(+), 1093 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> > >  create mode 100644 drivers/iio/adc/ad7280a.c
> > >  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
> > >  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> > > 
> > > -- 
> > > 2.32.0
> > >     
> 

