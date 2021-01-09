Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD92F02E3
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbhAISmN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 13:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbhAISmN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 13:42:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131C923A04;
        Sat,  9 Jan 2021 18:41:30 +0000 (UTC)
Date:   Sat, 9 Jan 2021 18:41:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ye, Xiang" <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] add custom hinge sensor support
Message-ID: <20210109184127.48ac58c3@archlinux>
In-Reply-To: <20201231024640.GA5718@host>
References: <20201215054444.9324-1-xiang.ye@intel.com>
        <20201230120517.622d3351@archlinux>
        <20201231024640.GA5718@host>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Dec 2020 10:46:40 +0800
"Ye, Xiang" <xiang.ye@intel.com> wrote:

> On Wed, Dec 30, 2020 at 12:05:17PM +0000, Jonathan Cameron wrote:
> > On Tue, 15 Dec 2020 13:44:41 +0800
> > Ye Xiang <xiang.ye@intel.com> wrote:
> >   
> > > Here we register one iio device with three channels which present angle for
> > > hinge, keyboard and screen.
> > > 
> > > This driver works on devices with Intel integrated sensor hub, where
> > > hinge sensor is presented using a custom sensor usage id.
> > > 
> > > Here the angle is presented in degrees, which is converted to radians.  
> > 
> > Other than those minor bits I'm happy to fix up in patch 2, this looks
> > good to me.  However, I'll need a Jiri Ack for the hid parts before
> > I apply it.  We are are early in this cycle, so no great rush given
> > the usual xmas slow down!  
> 
> Ok, let's wait Jiri to review the hid parts. Thanks for the help.
Series applied with the changes mentioned in review of patch 2.

Applied to the togreg branch of iio.git and pushed out as testing for
the various autobuilders to poke at it at and see if they can find
anything I missed.

Thanks,

Jonathan

> 
> Thanks
> Ye Xiang
> >   
> > > 
> > > Changes since v3:
> > >   - hid-sensor-custom: remove sensor_inst::custom_pdev_exposed.
> > >   - hid-sensor-custom: use static buf, w_buf to avoid using goto in 
> > >     get_known_custom_sensor_index.
> > >   - hid-sensor-custom-intel-hinge: use devm_ prefix function instead.
> > >   - sysfs-bus-iio: put in_anglY_raw together with in_angl_raw.
> > > 
> > > Changes since v2:
> > >   - use 1 iio device instead of 3 for hinge sensor.
> > >   - use indexed channel instead of modified channel and added channel
> > >     labels.
> > >   - remove 2,3 patch in last version, add a document patch to describe the
> > >     hinge channels.
> > >   - hid-sensor-custom: use meaningful return value in 
> > >     get_known_custom_sensor_index and checked in call side.
> > >   - hid-sensor-ids.h: use HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x) to 
> > >     define custom sensor value.
> > > 
> > > Changes since v1:
> > >   - fixed errors reported by lkp
> > > 
> > > Ye Xiang (3):
> > >   HID: hid-sensor-custom: Add custom sensor iio support
> > >   iio: hid-sensors: Add hinge sensor driver
> > >   iio:Documentation: Add documentation for hinge sensor channels
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-iio       |  11 +
> > >  drivers/hid/hid-sensor-custom.c               | 143 +++++++
> > >  .../hid-sensors/hid-sensor-attributes.c       |   2 +
> > >  drivers/iio/position/Kconfig                  |  16 +
> > >  drivers/iio/position/Makefile                 |   1 +
> > >  .../position/hid-sensor-custom-intel-hinge.c  | 391 ++++++++++++++++++
> > >  include/linux/hid-sensor-ids.h                |  14 +
> > >  7 files changed, 578 insertions(+)
> > >  create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > >   
> >   

