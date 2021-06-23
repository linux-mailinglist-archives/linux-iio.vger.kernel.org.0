Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC63B15FB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jun 2021 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWIkP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Jun 2021 04:40:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3302 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWIkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Jun 2021 04:40:11 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G8xGY0qJJz6H7Vw;
        Wed, 23 Jun 2021 16:27:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 10:37:51 +0200
Received: from localhost (10.47.69.138) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 23 Jun
 2021 09:37:50 +0100
Date:   Wed, 23 Jun 2021 09:37:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <20210623093741.00007d1d@Huawei.com>
In-Reply-To: <YNIfkaRZtWIXPbAj@marsc.168.1.7>
References: <20210614113507.897732-1-jic23@kernel.org>
        <YNIfkaRZtWIXPbAj@marsc.168.1.7>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.69.138]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Jun 2021 14:36:17 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hey Jonathan,
> 
> On 06/14, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> 
> I'm interested in seeing your device emulation with QEMU.
> I was looking at the ad7150 emulation you shared earlier this year but had
> some trouble getting the i2c slave created.

Sure.  Let me do a bit of tidying up they I'll push a suitable branch out.
(probably will still have lots of stuff missing!)

Might take a little while to get to this though.

> 
> Being able to see it running, I may feel more confident to provide a review
> for this set :)

:)

> 
> Regards,
> 
> Marcelo
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
> >  .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   14 +
> >  .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
> >  drivers/iio/adc/Kconfig                       |   11 +
> >  drivers/iio/adc/Makefile                      |    1 +
> >  drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
> >  drivers/staging/iio/adc/Kconfig               |   11 -
> >  drivers/staging/iio/adc/Makefile              |    1 -
> >  drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
> >  drivers/staging/iio/adc/ad7280a.h             |   37 -
> >  9 files changed, 1229 insertions(+), 1093 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
> >  create mode 100644 drivers/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.c
> >  delete mode 100644 drivers/staging/iio/adc/ad7280a.h
> > 
> > -- 
> > 2.32.0
> >   

