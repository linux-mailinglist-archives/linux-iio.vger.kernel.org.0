Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1E3D504C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfJLOIT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 10:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLOIT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 10:08:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447072087E;
        Sat, 12 Oct 2019 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570889298;
        bh=o4/2ZAsfbLYJuPmnf9BRAi8tSgnXFEFu+R3x2TAbZ94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EFTMxVqveIrjXYxRVBxn6JnnXGJceqGiblKDVcONEB3ruxORtxZ8FhvxMlfdgRKb2
         a6pf3jMleSLW5h68xgBASHIgSNVLHbZv4Py264nF0ZqgoE4t6FZPYdgvP5PTN6IFtu
         RBVWlAOFdp8UeyeYj3Yu8yT5Q05pubtvbWJ8BI3I=
Date:   Sat, 12 Oct 2019 15:08:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] add support to STM LSM6DS0 6-axis Mems sensor
Message-ID: <20191012150814.19664daa@archlinux>
In-Reply-To: <CAJ0CqmVt5+QMYZoFAOr9pnQDHwvEfu=asPxWP25jTqh7pXM7jg@mail.gmail.com>
References: <cover.1570441034.git.lorenzo@kernel.org>
        <20191012134023.1b0238ce@archlinux>
        <CAJ0CqmVt5+QMYZoFAOr9pnQDHwvEfu=asPxWP25jTqh7pXM7jg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 15:27:08 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> >
> > On Mon,  7 Oct 2019 11:43:36 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >  
> > > Add support to STM LSM6DS0 6-axis sensor. Just compiled, but LSM6DS0 relies on
> > > the same register map used by LSM9DS1  
> > I'm feeling paranoid. Is this definitely different form the
> > LSM6DSO which is already supported?
> >
> > If so ST loose for stupid part naming.  
> 
> Yes, it is very different..AFAIK LSM6DSO is last IMU sensor from ST
> while LSM6DS0 is very old (it has the same register map used in
> LSM9DS1 imu).
No way anything could possibly go wrong ;)

*dramatic sigh*

> 
> Regards,
> Lorenzo
> 
> >
> > Jonathan
> >  
> > >
> > > Lorenzo Bianconi (2):
> > >   iio: imu: st_lsm6dsx: add support to LSM6DS0
> > >   dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings
> > >
> > >  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
> > >  drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
> > >  6 files changed, 18 insertions(+), 2 deletions(-)
> > >  
> >  
> 

