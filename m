Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE64D500E
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfJLN0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLN0j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:26:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA99F2087E;
        Sat, 12 Oct 2019 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570886798;
        bh=myoBeJNgQsjA19Q2j38acNQ3q6hFHppo2dmPzTjetvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FH7qxaGk2/qUrmLNcPPcwt+HBeIkkc8gK7YaHbj2u+62FolR+6J2v+enyXcoXOehI
         eAj03qQac3aw9g9JE9QNIVyvStDKP3RaGTrt5LYe0iiiGLuaAxmbWzI7WpsZ1/114p
         KeD+5SN/WuMucspP68HUwXE7y07FNy/0y6Z0+BNQ=
Date:   Sat, 12 Oct 2019 14:26:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        Sean Nyekjaer <sean@geanix.com>, martin@geanix.com,
        Bobby Jones <rjones@gateworks.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/13] various st_lsm6dsx fixes and missing bits
Message-ID: <20191012142633.162e832f@archlinux>
In-Reply-To: <CAA2SeNLEG9kMxW_XrGeyaORXdY5xjdxqqU9BPsdiWcr9J_ruYA@mail.gmail.com>
References: <cover.1570367532.git.lorenzo@kernel.org>
        <20191012132020.412e9595@archlinux>
        <CAA2SeNLEG9kMxW_XrGeyaORXdY5xjdxqqU9BPsdiWcr9J_ruYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 14:26:24 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> >
> > On Sun,  6 Oct 2019 15:21:54 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >  
> > > This series fixes some corner cases introduced with LSM9DS1 support and with
> > > the one that has added wake-up event support. In particular it fixes a crash
> > > due to missing HW FIFO support for LSM9DS1.
> > > Moreover I introduced the missing wake-up event support for LSM6DSO/LSM6DSOX
> > > sensor
> > > Add missing dts documentation for wake-up event and the capability to enable it
> > > through platformdata.
> > > Code cleanup.  
> >
> > Hmm. This is going to be very messy.  In theory quite a few of these apply
> > to stuff in 5.4 but I assume won't cleanly apply given other changes.  You
> > may want to think about doing backports of the important parts to 5.4.
> >
> > I'll apply the lot for 5.5.  
> 
> AFAIU just LSM9DS1 support will go in 5.4 (correct? Sean's series will
> go in 5.5) so I will backport just LSM9DS1 fixes to 5.4 (I guess 3-4
> patches).
> 
That is what I'd expect.

Thanks,

Jonathan

> Regards,
> Lorenzo
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >
> > > Lorenzo Bianconi (13):
> > >   iio: imu: st_lsm6dsx: use st_lsm6dsx_read_locked in
> > >     st_lsm6dsx_report_motion_event
> > >   iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
> > >   iio: imu: st_lsm6dsx: move irq related definitions in irq_config
> > >   iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not
> > >     supported
> > >   iio: imu: st_lsm6dsx: move bdu/boot and reset register info in
> > >     hw_settings
> > >   iio: imu: st_lsm6dsx: always check enable_reg in
> > >     st_lsm6dsx_event_setup
> > >   iio: imu: st_lsm6dsx: rely on st_lsm6dsx_update_bits_locked
> > >     configuring events
> > >   iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
> > >   iio: imu: st_lsm6dsx: fix checkpatch warning
> > >   iio: imu: st_lsm6dsx: add wakeup_source in st_sensors_platform_data
> > >   iio: imu: st_lsm6dsx: add missing kernel documenation
> > >   dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source
> > >     property
> > >   iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO
> > >
> > >  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  35 +-
> > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   3 +
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 588 ++++++++++++------
> > >  .../linux/platform_data/st_sensors_pdata.h    |   2 +
> > >  5 files changed, 440 insertions(+), 189 deletions(-)
> > >  
> >  
> 
> 

