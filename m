Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7062938D70A
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhEVSuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhEVSuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 14:50:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B1C60FDC;
        Sat, 22 May 2021 18:48:35 +0000 (UTC)
Date:   Sat, 22 May 2021 19:49:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 0/8] iio: accel: bmc150: Add support for yoga's with
 dual accelerometers with an ACPI HID of DUAL250E
Message-ID: <20210522194957.3002406c@jic23-huawei>
In-Reply-To: <CAHp75Vex3uvGz+g9rkuU3wMwFOui-fASxvcP7b3KNCQ2CrBH3A@mail.gmail.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
        <20210522190138.1715b095@jic23-huawei>
        <CAHp75Vex3uvGz+g9rkuU3wMwFOui-fASxvcP7b3KNCQ2CrBH3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 May 2021 21:03:02 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 22, 2021 at 9:00 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 21 May 2021 19:14:10 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:  
> 
> > > Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> > > to allow the OS to determine the angle between the display and the base
> > > of the device, so that the OS can determine if the 2-in-1 is in laptop
> > > or in tablet-mode.
> > >
> > > We already support this setup on devices using a single ACPI node
> > > with a HID of "BOSC0200" to describe both accelerometers. This patch
> > > set extends this support to also support the same setup but then
> > > using a HID of "DUAL250E".
> > >
> > > While testing this I found some crashes on rmmod, patches 1-2
> > > fix those patches, patch 3 does some refactoring and patch 4
> > > adds support for the "DUAL250E" HID.
> > >
> > > Unfortunately we need some more special handling though, which the
> > > rest of the patches are for.
> > >
> > > On Windows both accelerometers are read (polled) by a special service
> > > and this service calls a DSM (Device Specific Method), which in turn
> > > translates the angles to one of laptop/tablet/tent/stand mode and then
> > > notifies the EC about the new mode and the EC then enables or disables
> > > the builtin keyboard and touchpad based in the mode.
> > >
> > > When the 2-in-1 is powered-on or resumed folded in tablet mode the
> > > EC senses this independent of the DSM by using a HALL effect sensor
> > > which senses that the keyboard has been folded away behind the display.
> > >
> > > At power-on or resume the EC disables the keyboard based on this and
> > > the only way to get the keyboard to work after this is to call the
> > > DSM to re-enable it (similar to how we also need to call a special
> > > DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).
> > >
> > > Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
> > > 2 accelerometers specifying which one is which.  
> >
> > Given only thing I'm planning to do is tweak the line wrapping, I'm
> > happy to pick this series up.
> >
> > The two fixes will slow things down a bit though as we should probably
> > get those upstream this cycle.
> >
> > I'm going to leave this on list for a few days before I take anything
> > though, to give others time to take a look.  
> 
> You are, guys, too fast :-)

One day did seem a bit short for a series doing as much as this one :)


> 
> I have few (minor) comments on a few patches, in general they are okay!
> So, after settling on the comments,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for the entire series.
> 
> Thanks, Hans, for doing this!
> 
> > One side note, cc list includes a few random choices... Seems you've
> > accidentally included alsa people as well as IIO ones.  
> 
> 

