Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC0D1E97F8
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEaNws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 09:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaNwr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 09:52:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BA7206F0;
        Sun, 31 May 2020 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933167;
        bh=MP0bby8ApBLP5qC3WQDDp0KLz0RVbo6emdeY3WwLhFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cJg24hu5/IbOSkPlOQPNSfj+3S/Hog6Fi2lGn8Fy2Adrpr7sMjHBZU40uNBJHBOK7
         3f2uxf60CreEOXK6iEw70fukj7U3mvb4G0ClCBHsXkV0QEZxFIaJ0UoqghvgOVoDLG
         72JnYDnRpib2Twqx9O4P6bfIxY+em9/kUWxkC/pA=
Date:   Sun, 31 May 2020 14:52:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Oder <me@myself5.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mxc4005: add support for mxc6655
Message-ID: <20200531145242.1dbf35d2@archlinux>
In-Reply-To: <CAO6HPN1OfyJBxGO-8-jL6BNqxRfZzDkOkytNLpqAJam=2MPJ8w@mail.gmail.com>
References: <20200529200550.357118-1-me@myself5.de>
        <20200531112951.085507de@archlinux>
        <CAO6HPN1OfyJBxGO-8-jL6BNqxRfZzDkOkytNLpqAJam=2MPJ8w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 May 2020 15:16:00 +0200
Christian Oder <me@myself5.de> wrote:

> Hi Jonathan,
> 
> I tested the sensor on a Chuwi Hi10 X and only went by what I've seen in other
> commits before[1].
> 
> I just ran another test to see what entry is necessary and it appears the sensor
> still works when removing the i2c entry, but is not working anymore when
> removing the ACPI match. I got the ACPI IDs from udevadm info -e[2].
> Would that mean, that I should remove the i2c entry given it's working fine
> with ACPI on its own then, or am I missing something?
The i2c entry is fine.
> 
> I'm also successfully using the ACPI ID for the touchscreen orientation quirk
> in systemd[3].
Great.  That means it is out there so is a defacto binding even if
there isn't an official Doc.  Sadly a lot of device manufacturers
don't do this stuff the way they are supposed to!

> 
> > Adding an explicit DT binding table would also be
> > good if that is method you are using to probe this (or PRP0001
> > from acpi which uses the dt bindings table)  
> 
> Frankly, I have no idea how to do that or if that would still be required when
> using ACPI. Can you point me in a rough direction in case it's still needed?

It's all good given you've confirmed the ID is out there in the wild.

Applied to the togreg branch of iio.git and pushed out as testing for
autobuilders to poke at.

Note we've missed the merge window now so this will take a while to get
into the mainline kernel - should be in linux-next in a few weeks though.

Thanks,

Jonathan

> 
> Regards,
> Christian
> 
> ---
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/iio/accel/mxc6255.c?h=v5.6.15&id=06777c562a50a09c4a2becfb2bf63c762a45df17
> 
> [2]
> P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/MXC6655:00
> L: 0
> E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:22/MXC6655:00
> E: SUBSYSTEM=acpi
> E: MODALIAS=acpi:MXC6655:MXC6655:
> E: USEC_INITIALIZED=5319671
> E: ID_VENDOR_FROM_DATABASE=The Linux Foundation
> 
> P: /devices/pci0000:00/0000:00:16.0/i2c_designware.0/i2c-0/i2c-MXC6655:00
> L: 0
> E: DEVPATH=/devices/pci0000:00/0000:00:16.0/i2c_designware.0/i2c-0/i2c-MXC6655:00
> E: SUBSYSTEM=i2c
> E: MODALIAS=acpi:MXC6655:MXC6655:
> 
> [3]
> https://github.com/systemd/systemd/commit/5e0676c2cad60b1ea029b9bfb9737e1967abb93a
> 
> On Sun, May 31, 2020 at 12:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 29 May 2020 22:05:49 +0200
> > Christian Oder <me@myself5.de> wrote:
> >  
> > > The mxc6655 is fully working with the existing mxc4005 driver.
> > > Add support for it.
> > >
> > > Signed-off-by: Christian Oder <me@myself5.de>  
> >
> > One query on ACPI bindings.  What is there already may
> > be missleading :(
> >
> >  
> > > ---
> > >  drivers/iio/accel/mxc4005.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> > > index 3d5bea651923..3b8614352cb4 100644
> > > --- a/drivers/iio/accel/mxc4005.c
> > > +++ b/drivers/iio/accel/mxc4005.c
> > > @@ -474,12 +474,14 @@ static int mxc4005_probe(struct i2c_client *client,
> > >
> > >  static const struct acpi_device_id mxc4005_acpi_match[] = {
> > >       {"MXC4005",     0},
> > > +     {"MXC6655",     0},  
> >
> > Do we have a reference for these ACPI bindings?  While they may seem
> > obvious, memsic don't have a registered PNP or ACPI ID that I can
> > find.  If these are in the wild (i.e. in shipping firmware) then we
> > can take them as defacto bindings, otherwise we should avoid making
> > them so by putting them in the driver.
> >
> > Quite a few similar bindings got in a while back that I should have
> > noticed, but I wasn't so familiar with ACPI back then.  Some
> > scrubbing of these has gone on recently, but there are lots still
> > left in IIO.
> >
> > If we aren't sure, then drop the ACPI addition and just leave the
> > i2c one below.  Adding an explicit DT binding table would also be
> > good if that is method you are using to probe this (or PRP0001
> > from acpi which uses the dt bindings table)
> >
> > Thanks,
> >
> > Jonathan
> >
> >  
> > >       { },
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> > >
> > >  static const struct i2c_device_id mxc4005_id[] = {
> > >       {"mxc4005",     0},
> > > +     {"mxc6655",     0},
> > >       { },
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, mxc4005_id);  
> >  

