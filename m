Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27CB474B0
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFPN1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 09:27:12 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:40688 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfFPN1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jun 2019 09:27:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1B2349E8B25;
        Sun, 16 Jun 2019 14:27:09 +0100 (BST)
Date:   Sun, 16 Jun 2019 14:27:08 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: Re: [RFC PATCH 0/3] io: imu: st_lsm6dsx: wake on acc event
Message-ID: <20190616142708.42e7c6f0@archlinux>
In-Reply-To: <20190616142431.111e6280@archlinux>
References: <20190614122604.52935-1-sean@geanix.com>
        <20190616142431.111e6280@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jun 2019 14:24:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 14 Jun 2019 14:26:01 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > Hi,
> > 
> > The first patch enables the wake event creation in the suspend function,
> > it hardcodes the accelerometer to low power mode and the gyro is powered down.
> > 
> > The second and third patch is where I have some questions.
> > Is it okay to create an sysfs entry that can enable and disable the wake
> > events from the accelerometer?  
> 
> On that I'm not sure - is there a standard way of configuring wake up events
> outside of IIO?
> 
> > 
> > The third patch is enabling us to set the threshold value.
> > Obviously this will need to be changed to represent a real value instead
> > of the raw register value.
> > Maybe I need to add a threshold avaliable sysfs entry?
> > Do I set it to a raw value calculated from the scale value or is some have
> > a better idea?  
> Yes, if a device is providing a _raw channel reading then threshold
> values should also be raw.
> 
> Available sysfs attribute makes sense if it helps a user, or userspace
> program to set the value.
> 
> > 
> > Finally is this the right approach to enable wake on accelerometer
> > events?
> > Please provide some idea's to how we could do it in the best and most
> > generic way.  
> 
> It's not something I've come across before, so hopefully someone else
> can provide guidance on this!
> 
> My only immediate thought is that perhaps this should be a device tree
> thing rather than userspace controlled?
doh. Should have read the patches first rather than just replying to the
cover letter ;) Ignore this bit!

> There also seems to be some existing infrastructure to control this
> in the power directory for a device.
> 
> Documentation/ABI/testing/sysfs-devices-power
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > /Sean
> > 
> > Sean Nyekjaer (3):
> >   iio: imu: st_lsm6dsx: add wake on accelerometer threshold
> >   iio: imu: st_lsm6dsx: add wake on accelerometer enable hook in sysfs
> >   iio: imu: st_lsm6dsx: add wake on accelerometer threshold hook in
> >     sysfs
> > 
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 135 +++++++++++++++++++
> >  2 files changed, 137 insertions(+)
> >   
> 

