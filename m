Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6F3A1DD8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFITym (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 15:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFITyl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 15:54:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8BC61178;
        Wed,  9 Jun 2021 19:52:44 +0000 (UTC)
Date:   Wed, 9 Jun 2021 20:54:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] iio: accel: bmc150: Add support for yoga's with
 dual accelerometers with an ACPI HID of DUAL250E
Message-ID: <20210609205438.35e22799@jic23-huawei>
In-Reply-To: <CAHp75Vc=3VH=Mj-jZAYWjgp-bRU46CGtqw90b_2QYfoLurEeQw@mail.gmail.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
        <CAHp75Vc=3VH=Mj-jZAYWjgp-bRU46CGtqw90b_2QYfoLurEeQw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 May 2021 22:08:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, May 23, 2021 at 8:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi all,
> >
> > Here is v2 of this series, addressing Andy's review remarks and
> > rewrap some comments at 80 chars limit.
> >
> > For more info here is the v1 cover-letter:
> >
> > Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
> > to allow the OS to determine the angle between the display and the base
> > of the device, so that the OS can determine if the 2-in-1 is in laptop
> > or in tablet-mode.
> >
> > We already support this setup on devices using a single ACPI node
> > with a HID of "BOSC0200" to describe both accelerometers. This patch
> > set extends this support to also support the same setup but then
> > using a HID of "DUAL250E".
> >
> > While testing this I found some crashes on rmmod, patches 1-2
> > fix those patches, patch 3 does some refactoring and patch 4
> > adds support for the "DUAL250E" HID.
> >
> > Unfortunately we need some more special handling though, which the
> > rest of the patches are for.
> >
> > On Windows both accelerometers are read (polled) by a special service
> > and this service calls a DSM (Device Specific Method), which in turn
> > translates the angles to one of laptop/tablet/tent/stand mode and then
> > notifies the EC about the new mode and the EC then enables or disables
> > the builtin keyboard and touchpad based in the mode.
> >
> > When the 2-in-1 is powered-on or resumed folded in tablet mode the
> > EC senses this independent of the DSM by using a HALL effect sensor
> > which senses that the keyboard has been folded away behind the display.
> >
> > At power-on or resume the EC disables the keyboard based on this and
> > the only way to get the keyboard to work after this is to call the
> > DSM to re-enable it (similar to how we also need to call a special
> > DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).
> >
> > Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
> > 2 accelerometers specifying which one is which.  
> 
> Thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Whole series now applied to the togreg branch of iio.git and pushed out
as testing to give 0-day a chance to pick on it.

Thanks,

Jonathan

> 
> > Regards,
> >
> > Hans
> >
> >
> > Hans de Goede (9):
> >   iio: accel: bmc150: Fix dereferencing the wrong pointer in
> >     bmc150_get/set_second_device
> >   iio: accel: bmc150: Don't make the remove function of the second
> >     accelerometer unregister itself
> >   iio: accel: bmc150: Move check for second ACPI device into a separate
> >     function
> >   iio: accel: bmc150: Add support for dual-accelerometers with a
> >     DUAL250E HID
> >   iio: accel: bmc150: Move struct bmc150_accel_data definition to
> >     bmc150-accel.h
> >   iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor
> >     functions
> >   iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the
> >     hinge angle
> >   iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
> >   iio: accel: bmc150: Set label based on accel-location for ACPI
> >     DUAL250E fwnodes
> >
> >  drivers/iio/accel/bmc150-accel-core.c | 110 +++++----------
> >  drivers/iio/accel/bmc150-accel-i2c.c  | 193 ++++++++++++++++++++++----
> >  drivers/iio/accel/bmc150-accel.h      |  66 ++++++++-
> >  3 files changed, 260 insertions(+), 109 deletions(-)
> >
> > --
> > 2.31.1
> >  
> 
> 

