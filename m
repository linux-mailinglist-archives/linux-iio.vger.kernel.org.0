Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A0186A74
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgCPL4M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 07:56:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730882AbgCPL4M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 07:56:12 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0AE0F9E51C01A518A474;
        Mon, 16 Mar 2020 11:56:11 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 11:56:10 +0000
Received: from localhost (10.47.94.88) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 11:56:10 +0000
Date:   Mon, 16 Mar 2020 11:56:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH] iio: health: max30100: use generic property handler
Message-ID: <20200316115608.00003b34@Huawei.com>
In-Reply-To: <CAJCx=gk-oycno_NPtNFAvuX8ibsLEGLq0FrLvfXeaJwuvuTjcg@mail.gmail.com>
References: <5e6afe0d.1c69fb81.25912.f2eb@mx.google.com>
        <20200315124955.207d515c@archlinux>
        <CAJCx=gk-oycno_NPtNFAvuX8ibsLEGLq0FrLvfXeaJwuvuTjcg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.88]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 01:08:20 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Mar 15, 2020 at 5:50 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 13 Mar 2020 08:59:13 +0530
> > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >  
> > > Instead of of_property_read_xxx use device_property_read_xxx as it is
> > > compatible with ACPI too as opposed to only device tree.
> > >
> > > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>  
> >
> > Look at how this driver is probing from DT.  There is another thing you need
> > to do to make it possible to use PRP001 ACPI based bindings.
> >
> > (check what Andy Shevchenko did in a similar patch)
> >
> > I'm being deliberately vague as useful for you to understand what is going
> > on here for yourself :)
> >
> > Also, make sure to check you have cc'd everyone relevant.  Here you are missing
> > the driver author. +cc Matt
> > Jonathan
> >  
> 
> Highly doubt anyone is using this in an ACPI setting. Am I missing
> something though?

The 'new' wonder that is the ACPI ID PRP001.  It lets you instantiate
a device with a DT binding but using a chunk of DSDT.

Where it comes in handy is if you happen to have an X86 machine that you
are using to test and do it by overriding the DSDT (easy to do) to add
whatever controller you are using and the device.  Basically it is the
ACPI equivalent of hacking the dt file for a board.

Very convenient for testing device drivers.

Jonathan

> 
> - Matt
> 
> > > ---
> > >  drivers/iio/health/max30100.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > > index 84010501762d..8249c6b36818 100644
> > > --- a/drivers/iio/health/max30100.c
> > > +++ b/drivers/iio/health/max30100.c
> > > @@ -16,7 +16,7 @@
> > >  #include <linux/irq.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/mutex.h>
> > > -#include <linux/of.h>
> > > +#include <linux/property.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/buffer.h>
> > > @@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
> > >  static int max30100_led_init(struct max30100_data *data)
> > >  {
> > >       struct device *dev = &data->client->dev;
> > > -     struct device_node *np = dev->of_node;
> > >       unsigned int val[2];
> > >       int reg, ret;
> > >
> > > -     ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
> > > +     ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> > >                                       (unsigned int *) &val, 2);
> > >       if (ret) {
> > >               /* Default to 24 mA RED LED, 50 mA IR LED */  
> >  


