Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB615270F89
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgISQbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 12:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgISQbi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 12:31:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3423C208DB;
        Sat, 19 Sep 2020 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600533098;
        bh=WeQjZAHuxdFFoVu0jumWiYYyxrfJF/A+Appa4HFdAEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bLn6eG5uzostdnz9NDDfMGgxdpLH7n3SgpXpwxB5ukigoQ0j1ZCbtP8XG7cA7sDvJ
         O7btLIhLSuvw7faH6IZqJzk6BajOyBlYKqK1R4fmXina/4i3ytMcGZg/63U1rTCSPt
         iO5MCmxyVLK/IqY43Ghdc4iGutcJdMgXPr6IBy+A=
Date:   Sat, 19 Sep 2020 17:31:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald" <pmeerw@pmeerw.net>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: Re: [PATCH v3 10/27] iio:light:rpr0521 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200919173133.4fe75a35@archlinux>
In-Reply-To: <20200723122939.000003f0@Huawei.com>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-11-jic23@kernel.org>
        <CAHp75VcGDccaUwuyCBGhATTnFUEbXMw+=gq8Oe7jbYRcoArDyQ@mail.gmail.com>
        <20200723122939.000003f0@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 12:29:39 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 22 Jul 2020 22:47:46 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > One of a class of bugs pointed out by Lars in a recent review.
> > > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > > this driver which uses an array of smaller elements on the stack.
> > > As Lars also noted this anti pattern can involve a leak of data to
> > > userspace and that indeed can happen here.  We close both issues by
> > > moving to a suitable structure in the iio_priv().    
> >   
> > > This data is allocated with kzalloc so no data can leak appart    
> > 
> > apart
> >   
> > > from previous readings and in this case the status byte from the device.
> > >
> > > The forced alignment of ts is not necessary in this case but it
> > > potentially makes the code less fragile.    
> > 
> > ...
> >   
> > > +        * Note that the read will put garbage data into
> > > +        * the padding but this should not be a problem    
> >   
> > > +               u8 garbage;    
> >   
> > >         err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
> > > -               &buffer,
> > > +               data->scan.channels,
> > >                 (3 * 2) + 1);   /* 3 * 16-bit + (discarded) int clear reg. */    
> > 
> > But can't we read the interrupt clear register separately?
> >   
> 
> Potentially though I have no idea if there is an odd quirk there. I'm not
> immediately seeing anything on the datasheet about it.
> Would need a tested-by from someone with hardware to confirm it is fine to
> do it as two reads though.
> 
> Would be nice to get rid of the non standard handling so well worth
> pursuing in v4 of this set.

Mikko, came back to me off list on this (was stuck with an evil email client)
The cost would be significant of doing an extra read.  20 I2C clock cycles.
As such, I'd rather keep the unusual handling in here.

Will fix the typo and carry this one forwards to v4.

thanks,

Jonathan

> 
> Jonathan
> 
> 

