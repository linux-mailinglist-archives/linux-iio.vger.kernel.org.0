Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847243804F5
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhENIS3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 04:18:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3758 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhENIS1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 04:18:27 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhLrt2vd4zqTrp;
        Fri, 14 May 2021 16:13:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 16:17:14 +0800
Received: from localhost (10.52.120.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 14 May
 2021 09:17:07 +0100
Date:   Fri, 14 May 2021 09:15:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        "Robin van der Gracht" <robin@protonic.nl>,
        <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 0/3] mainline ti tsc2046 adc driver
Message-ID: <20210514091520.00004930@Huawei.com>
In-Reply-To: <20210514075731.ipxq2o4cdxd3piu3@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
        <20210503122818.59f50e45@jic23-huawei>
        <20210514075731.ipxq2o4cdxd3piu3@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.239]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 May 2021 09:57:31 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Jonathan,
> 
> On Mon, May 03, 2021 at 12:28:18PM +0100, Jonathan Cameron wrote:
> > On Wed, 28 Apr 2021 09:32:05 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > Hi Oleksij,
> > 
> > Series applied with the tweaks as per review to patch 3.  Please
> > check I didn't mess those up though.
> > 
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to poke at it.  
> 
> It works. Thx!
> 
> Now i need to make configurable iio buffer layout
> 
> for the drivers/input/touchscreen/resistive-adc-touch.c
> 
> Do you have ideas what is the proper way to make it?

So IIRC the issue here was making the ordering of the channels
more flexible?  

We should be able to do that using the names in DT.

Right now the touch screen driver just grabs them all an assumes
a particular order, but if you look at the binding it requires naming

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt

That naming should associate 'which channel' is which when
we then do the get_all() in the driver.  If it matches the existing
layout, nothing to do, but if we have something more complex then
we can do data shuffling etc in the touchscreen driver to compensate
for that.

A useful starting point is probably to do a yaml conversion of
that binding doc.  Then follow that up by making the doc more flexible
so that it copes with what you want to do. 

That should give us a good basis on which to then implement the
handling in driver (which is often easier than defining the binding!)

Jonathan

> 
> Regards,
> Oleksij
> 
> > 
> > Jonathan
> >   
> > > changes v6:
> > > - get blessing from Dmitry Torokhov
> > > - rebase against latest iio/testing
> > > - use simple name for iio_dev->name
> > > - use Jonathan's version for oversampling-ratio description 
> > > 
> > > changes v5:
> > > - remove type for the settling-time-us property
> > > 
> > > changes v4:
> > > - spell fixes
> > > - add more comments
> > > - make code more readable
> > > - move scan_buf to the priv
> > > - use FIELD_GET to extract ADC data
> > > - make some multi line code as one line
> > > - do not use atomic API for trig_more_count
> > > - fix build warning on 64bit system
> > > - add NULL check for the devm_kasprintf()
> > > - use return devm_iio_device_register(), without additional error
> > >   printing.
> > > 
> > > changes v3:
> > > - different spell fixes
> > > - add some notes about driver structure
> > > - rename the trigger to point on the touchscreen nature of it
> > > - rename DT binding to oversampling-ratio
> > > - make sure we have some defaults in case no DT property is set
> > > 
> > > changes v2:
> > > - rework and extend DT binding properties
> > > - remove touchscreen related code from the IIO ADC driver
> > > - make trigger be active longer then IRQ is requesting. This is needed
> > >   to get "inactive" samples
> > > - make oversampling and settle time configurable
> > > 
> > > TI TSC2046 is a touchscreen controller based on 8 channel ADC. Since most of
> > > this ADC based touchscreen controller share same set of challenges, it
> > > is better keep then as simple IIO ADC devices attached to a generic
> > > resistive-adc-touch driver.
> > > 
> > > This driver can replace drivers/input/touchscreen/ads7846.c and has
> > > following advantages over it:
> > > - less code to maintain
> > > - shared code paths (resistive-adc-touch, iio-hwmon, etc)
> > > - can be used as plain IIO ADC to investigate signaling issues or test
> > >   real capacity of the plates and attached low-pass filters
> > >   (or use the touchscreen as a microphone if you like ;) )
> > > 
> > > Oleksij Rempel (3):
> > >   dt-bindings:iio:adc: add generic settling-time-us and
> > >     oversampling-ratio channel properties
> > >   dt-bindings:iio:adc: add documentation for TI TSC2046 controller
> > >   iio: adc: add ADC driver for the TI TSC2046 controller
> > > 
> > >  .../devicetree/bindings/iio/adc/adc.yaml      |  12 +
> > >  .../bindings/iio/adc/ti,tsc2046.yaml          | 115 +++
> > >  MAINTAINERS                                   |   8 +
> > >  drivers/iio/adc/Kconfig                       |  12 +
> > >  drivers/iio/adc/Makefile                      |   1 +
> > >  drivers/iio/adc/ti-tsc2046.c                  | 720 ++++++++++++++++++
> > >  6 files changed, 868 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> > >  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> > >   
> > 
> >   
> 

