Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9821A6879
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgDMPHh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 11:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgDMPHg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 11:07:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4312072D;
        Mon, 13 Apr 2020 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586790455;
        bh=1Ff0qvhKzLVN35p+9nKpuxugrChtmfncBlbEEuhqmZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CLwbwCUIbj4/MLOfqFzJvH3Ls47AA7QJh/40WjmEEb2QE/4SdapwvvLvfqkemEb1+
         JVGed0xBEIChLe8cP4NFyi/yWcfmy2HdZq6gyKdvZPPHze8wTCiBsrOgD8XX05Mf5c
         voympuMn2na+sB08K70V9+V0QyOmqv+ZFJj6dUZ4=
Date:   Mon, 13 Apr 2020 16:07:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/6] IIO: Tidy up parameters to regmap_bulk_* calls
Message-ID: <20200413160728.6d3fc867@archlinux>
In-Reply-To: <6f82392031e95a39a63d9fed87f94961cd8ae12c.camel@analog.com>
References: <20200405180321.1737310-1-jic23@kernel.org>
        <20200412144812.1c65e88a@archlinux>
        <CAHp75Vc87TNTx-jVS-YmFcxVe3Y0FfxWZsFT2SpuMM8dsfdxMA@mail.gmail.com>
        <6f82392031e95a39a63d9fed87f94961cd8ae12c.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 04:34:50 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-04-12 at 23:59 +0300, Andy Shevchenko wrote:
> > On Sun, Apr 12, 2020 at 4:48 PM Jonathan Cameron
> > <jic23@jic23.retrosnub.co.uk> wrote:  
> > > If anyone is bored and fancies sanity checking the ones in this series
> > > that have had no eyes on them yet, it would be much appreciated!  
> > 
> > The series makes sense to me. Feel free to add my Rb tag to it if you like.
> >   
> 
> Same from my side.
> I added my tag on the patches.
> I waited a bit until some driver authors replied back.
Thanks to both of you!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> 
> > > On Sun,  5 Apr 2020 19:03:15 +0100
> > > jic23@kernel.org wrote:
> > >   
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > One of Andy Shevchenko's recent patches tidied a case of this up
> > > > and a quick grep showed we had some more.
> > > > 
> > > > The main focus of this set is calls to regmap_bulk_read /
> > > > regmap_bulk_write.  Both are used with buffers of many and varied type,
> > > > but as they take a void * there is never any need to cast a pointer
> > > > to said buffers to anything explicitly.
> > > > 
> > > > Whilst I was here I used sizeof(buf) in various places to reduce
> > > > the use of explicit values when we could derive it from the source
> > > > / destination buffer.
> > > > 
> > > > This isn't remotely urgent, but I'd like to clean these out to avoid
> > > > replication in future.  Not I didn't go after any other unnecessary
> > > > casts in the files because that would have take thought and its Sunday
> > > > evening and about time for a beer.
> > > > 
> > > > Jonathan Cameron (6):
> > > >   iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read
> > > >     calls
> > > >   iio:chemical:atlas-sensor: Drop unnecessary explicit casts in
> > > >     regmap_bulk_read calls
> > > >   iio:chemical:bme680: Tidy up parameters to regmap_bulk_read
> > > >   iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
> > > >   iio:magn:mmc35240: Drop unnecessary casts of val parameter in
> > > >     regmap_bulk*
> > > >   iio:light:ltr501: Drop unnecessary cast of parameter in
> > > >     regmap_bulk_read
> > > > 
> > > >  drivers/iio/accel/mxc4005.c                |  4 +--
> > > >  drivers/iio/chemical/atlas-sensor.c        |  7 ++---
> > > >  drivers/iio/chemical/bme680_core.c         | 36 +++++++++++++---------
> > > >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  4 +--
> > > >  drivers/iio/light/ltr501.c                 |  2 +-
> > > >  drivers/iio/magnetometer/mmc35240.c        |  4 +--
> > > >  6 files changed, 32 insertions(+), 25 deletions(-)
> > > >   
> > 
> >   

