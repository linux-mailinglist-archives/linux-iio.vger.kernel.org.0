Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1022994C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGVNjH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 09:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGVNjH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 09:39:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43DE2071A;
        Wed, 22 Jul 2020 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425146;
        bh=eDiZyEkIDW8Ek1aco3KIqulU2kly4R3HKbvQQ1+gLe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L99qtUc3+fRMlY+nlumYh6vYyQCjgFnE52IKIZsEy8/wQQ88n9Q8waheGIWekX0HO
         /PW1k+vqYf8nvrx/Kxf0AztLN9fWIhhr8CqyKN5jM8IAUw4zMUb1zlMNilkG6DDYJL
         rbMHu0WHR6zjcyjUjgYQQB8H2mLe0PFzlSJZQWE0=
Date:   Wed, 22 Jul 2020 14:39:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: chemical: atlas-ezo-sensor: add support for
 O2 sensor
Message-ID: <20200722143902.3d00f01b@archlinux>
In-Reply-To: <CAJCx=g=+zunxptnoLva7VGXqkU0Kwn9xxkTjKeO0F1VeXwSTTw@mail.gmail.com>
References: <20200720070330.259954-1-matt.ranostay@konsulko.com>
        <20200720070330.259954-4-matt.ranostay@konsulko.com>
        <CAHp75VcuwLoX5Xxb-BGPKE6BWnDJq=O5knV6u8wWXYsLHfGL9Q@mail.gmail.com>
        <CAJCx=g=+zunxptnoLva7VGXqkU0Kwn9xxkTjKeO0F1VeXwSTTw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 21:38:11 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Tue, Jul 21, 2020 at 11:46 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jul 20, 2020 at 10:05 AM Matt Ranostay
> > <matt.ranostay@konsulko.com> wrote:  
> > >
> > > Add support for the Atlas EZO O2 chemical sensor which required
> > > some refactoring of the driver and parsing of i2c transfer.
> > >
> > > Sensor data is converted by the scaling value from percent to
> > > IIO_CONCENTRATION.  
> >
> > ...
> >  
> > > +static void atlas_ezo_sanitize(char *buf)
> > > +{
> > > +       char *ptr = strchr(buf, '.');
> > > +
> > > +       if (!ptr)
> > > +               return;
> > > +
> > > +       for (; *ptr; ptr++)
> > > +               *ptr = *(ptr + 1);
> > > +}  
> >
> > NIH of memmove()? Why?  
> 
> Mainly since I forgot that POSIX function. I'll fix it up when possible
> 
> - Matt

I've dropped the series for now.  Lets just have a v3 with these
bits tidied up. It will have to wait for the next cycle however as I'll
be doing what is probably the last pull for this cycle in a few minutes.

Thanks,

Jonathan

> 
> >
> > And actually to avoid strlen() you may do it other way around, i.e
> > shift integer part one character right and return new buffer pointer.
> >
> >
> > if (!ptr)
> >   return buf;
> >
> > memmove(buf + 1, buf, ptr - buf);
> > return buf + 1;
> >
> > --
> > With Best Regards,
> > Andy Shevchenko  

