Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36219EA52
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDEKNr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEKNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 06:13:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB813206B8;
        Sun,  5 Apr 2020 10:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586081626;
        bh=ghf9W49fa0GIdxDuV5JE4eaa5z4UtJDAY5lmSbNPgTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+F8IVPjv9LTZbW6sBkR1pmYL1qgQjV7eq90RekpAAoIJIlRuYVR2aLiNzXjZ8WTb
         dA5NOmRpdAV5sGblfE1Zr0uMw9o78KgXd22Z/6CpbLTM1XfrPanEOH5o+zcrFP7p9z
         IkX425+un73fhQnStMGbk4VfWqPmOK+jgaTXbSy8=
Date:   Sun, 5 Apr 2020 11:13:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
Message-ID: <20200405111341.0912468d@archlinux>
In-Reply-To: <CAHp75VdaM_pumyWyeHJxCQXrKUAW=ktJme1uYxH0w4e9an0X2A@mail.gmail.com>
References: <20200401162416.24474-1-i.mikhaylov@yadro.com>
        <20200401162416.24474-3-i.mikhaylov@yadro.com>
        <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com>
        <1e2c9b590a3626abee330a28cca86cbae7affb39.camel@yadro.com>
        <CAHp75VdaM_pumyWyeHJxCQXrKUAW=ktJme1uYxH0w4e9an0X2A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Apr 2020 15:42:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Apr 2, 2020 at 11:24 AM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> >
> > On Wed, 2020-04-01 at 19:35 +0300, Andy Shevchenko wrote:  
> > > On Wed, Apr 1, 2020 at 7:24 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:  
> > > > Proximity sensor driver based on light/vcnl4000.c code.
> > > > For now supports only the single on-demand measurement.
> > > >
> > > > The VCNL3020 is a fully integrated proximity sensor. Fully
> > > > integrated means that the infrared emitter is included in the
> > > > package. It has 16-bit resolution. It includes a signal
> > > > processing IC and features standard I2C communication
> > > > interface. It features an interrupt function.  
> > >
> > > Thank you for an update, my comments below.
> > >
> > > ...
> > >  
> > > > +static int get_and_apply_property(struct vcnl3020_data *data, const char
> > > > *prop,
> > > > +                                 u32 reg)
> > > > +{
> > > > +       int rc;
> > > > +       u32 val;
> > > > +
> > > > +       rc = device_property_read_u32(data->dev, prop, &val);
> > > > +       if (rc)
> > > > +               return 0;
> > > > +
> > > > +       rc = regmap_write(data->regmap, reg, val);
> > > > +       if (rc)
> > > > +               dev_err(data->dev, "Error (%d) setting property (%s)",
> > > > +                       rc, prop);  
> > >
> > > This requires {} according to the coding style  
> >
> > checkpatch.pl doesn't say anything bad on this spot. Do you mean to make
> > something like this?
> >
> > rc = regmap_write(data->regmap, reg, val);
> > if (rc) {
> >         dev_err(data->dev, "Error (%d) setting property (%s)",
> >                 rc, prop);
> > }  
> 
> Yes. Checkpatch is neither strict nor fully comprehensive tool.
> 
> > In previous notes you said to remove them.  
> 
> When it's one line, it fine, otherwise you need {} surround.
> 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
> 
> > > > +       return rc;
> > > > +}  
> > >
> > > ...
> > >  
> > > > +static int vcnl3020_probe(struct i2c_client *client)
> > > > +{
> > > > +       indio_dev->name = VCNL_DRV_NAME;  
> > >
> > > It's definitely not a driver name. You have to put part number here.  
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/tsl4531.c?h=v5.6#n199
That one is actually fine (if not very pretty) because the driver only supports one part and it happens
to also be the name of the driver.

> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/max44009.c?h=v5.6#n507
Also only one part supported, so fine if liable to accidentally get broken if we support more parts.

> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iio/light/vl6180.c?h=v5.6#n515  

Again, one part supported and the driver has the same name.

> 
> Let's Jonathan speak up.

So, the real point here is not the value being assigned but the fact it's
explicitly linked to the name of the driver.  I'd argue that you could use
VCNL_NAME as the define and that link is clearly broken. Or just put the string
inline in both places and don't worry about the tiny bit of replication!

Jonathan





> 

