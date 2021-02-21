Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932AB320BA5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUQJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhBUQJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:09:26 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8363C64EF2;
        Sun, 21 Feb 2021 16:08:42 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:08:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugene Zaikonnikov <ez@norphonic.com>
Subject: Re: [RFC PATCH 5/7] iio:ABI docs: Combine
 sysfs-bus-iio-humidity-hdc2010/hdc100x into one file
Message-ID: <20210221160838.2f8f05a9@archlinux>
In-Reply-To: <CAJCx=gkLbAnUsZ5cybxWRq8dbrdk8qvhVMje0FCs2NKPenW5Ug@mail.gmail.com>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-6-jic23@kernel.org>
        <CAJCx=gkLbAnUsZ5cybxWRq8dbrdk8qvhVMje0FCs2NKPenW5Ug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jan 2021 15:12:40 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Jan 17, 2021 at 7:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > These contain only one entry for out_current_heater_raw (_available).
> > Document this in a new sysfs-bus-iio-humidity file, and make it a little
> > more generic by allowing for non 0/1 values.
> >
> > Fixes:
> > $ scripts/get_abi.pl validate
> > Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
> > Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
> >
> > Cc: Eugene Zaikonnikov <ez@norphonic.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied, thanks

J
> 
> > ---
> >  ...s-bus-iio-humidity-hdc2010 => sysfs-bus-iio-humidity} | 3 ++-
> >  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x | 9 ---------
> >  2 files changed, 2 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 b/Documentation/ABI/testing/sysfs-bus-iio-humidity
> > similarity index 79%
> > rename from Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> > rename to Documentation/ABI/testing/sysfs-bus-iio-humidity
> > index 5b78af5f341d..cb0d7e75d297 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-humidity
> > @@ -6,4 +6,5 @@ Description:
> >                 Controls the heater device within the humidity sensor to get
> >                 rid of excess condensation.
> >
> > -               Valid control values are 0 = OFF, and 1 = ON.
> > +               In some devices, this is just a switch in which case 0 = OFF,
> > +               and 1 = ON.
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x b/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
> > deleted file mode 100644
> > index b72bb62552cf..000000000000
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
> > +++ /dev/null
> > @@ -1,9 +0,0 @@
> > -What:          /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> > -What:          /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> > -KernelVersion: 4.3
> > -Contact:       linux-iio@vger.kernel.org
> > -Description:
> > -               Controls the heater device within the humidity sensor to get
> > -               rid of excess condensation.
> > -
> > -               Valid control values are 0 = OFF, and 1 = ON.
> > --
> > 2.30.0
> >  

