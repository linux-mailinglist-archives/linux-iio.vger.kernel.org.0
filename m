Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDC32E72D0
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgL2Rwr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2Rwr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:52:47 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF977221F8;
        Tue, 29 Dec 2020 17:52:05 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:52:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: acpi_als: Add trigger support
Message-ID: <20201229175202.76682fcc@archlinux>
In-Reply-To: <CAHp75VdQF7truiuWshYbvCAan2Qc0TomTesLwv2dDFhF5qkxqg@mail.gmail.com>
References: <20201216214107.774969-1-gwendal@chromium.org>
        <20201216214107.774969-4-gwendal@chromium.org>
        <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com>
        <20201229172439.2a65580f@archlinux>
        <CAHp75VdQF7truiuWshYbvCAan2Qc0TomTesLwv2dDFhF5qkxqg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Dec 2020 19:33:39 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 29, 2020 at 7:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 17 Dec 2020 00:38:06 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> > > On Wed, Dec 16, 2020 at 11:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:  
> > > >
> > > > As some firmware does not notify on illuminance changes, add a
> > > > trigger to be able to query light via software (sysfs-trigger or
> > > > hrtrigger).
> > > > Add a hardware trigger set as the default trigger to maintain backward
> > > > compatibility.
> > > >
> > > > Check iio_info reports the sensor as buffer capable:
> > > >   iio:device0: acpi-als (buffer capable)
> > > >
> > > > To test, check we can get data on demand on an Intel based chromebook:
> > > >
> > > >   IIO_DEV="iio:device0"
> > > >   echo 1 > iio_sysfs_trigger/add_trigger
> > > >   cat trigger2/name > ${IIO_DEV}/trigger/current_trigger
> > > >   for i in ${IIO_DEV}/scan_elements/*_en ${IIO_DEV}/buffer/enable ; do
> > > >     echo 1 > $i
> > > >   done
> > > >   od -x /dev/${IIO_DEV} &
> > > >   echo 1 > trigger2/trigger_now  
> > >
> > > Few nitpicks below. After addressing, take my
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > assuming that backward compatibility has been tested as well.  
> 
> ...
> 
> > > > +       if (!iio_buffer_enabled(indio_dev) ||
> > > > +           !iio_trigger_using_own(indio_dev))  
> > >
> > > I guess it can be located on one line.
> > >
> > > I hope those functions have no side effects. In that case you may
> > > invert logic (save 2 characters)
> > >
> > >        if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))  
> >
> > You can but at cost of indenting the whole following block on level further.
> > I'm not that fussed, but in general that doesn't seem like a good idea to
> > save two characters here.  
> 
> I didn't get it. The proposed change, in case of no side effect, is an
> equivalent to the existing one, just 2 characters less.
> How does it affect code block indentation?

It's not the same. As stated it's the inverse condition.  Could add some brackets
and a ! or, flip the logic of the whole if condition and not return early.


Jonathan


> 

