Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58252F032B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 20:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhAIT2w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 9 Jan 2021 14:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbhAIT2w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 14:28:52 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0D523A31;
        Sat,  9 Jan 2021 19:28:09 +0000 (UTC)
Date:   Sat, 9 Jan 2021 19:28:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ye, Xiang" <xiang.ye@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] add timestamp channel for hid-sensors
Message-ID: <20210109192805.138fed41@archlinux>
In-Reply-To: <20210105092632.GA15865@host>
References: <20210105072203.5701-1-xiang.ye@intel.com>
        <ed6a6de1c0b2339d467a3ffd341130342b41c3bc.camel@linux.intel.com>
        <20210105092632.GA15865@host>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Jan 2021 17:26:33 +0800
"Ye, Xiang" <xiang.ye@intel.com> wrote:

> On Tue, Jan 05, 2021 at 12:53:44AM -0800, Srinivas Pandruvada wrote:
> > On Tue, 2021-01-05 at 15:21 +0800, Ye Xiang wrote:  
> > > This patch series add a timestamp channel for hid sensors,
> > > including gravity sensor, gyro sensor, magnetometer sensor,
> > > ambient light sensor, inclinometer sensor, and rotation sensor.
> > > 
> > > With this patch series, user can get the time when sensor yield
> > > a sample.
> > >   
> > I think this series is v1 for upstream not v3.  
> Sorry, it's v1 for upstream. will resent it as v1. v3 is our internal review version.
> 
Future notice, if you make a mistake of this particular type - don't resend and
carry on with future version numbers.  Otherwise it gets really confusing
if we get to a public v3 version!   Monotonic version numbers only :)

Not a bit problem though but if that does happen check I don't grab the wrong
version.

Jonathan

> Thanks
> Ye Xiang
> > 
> >   
> > > ---
> > > v3:
> > >   - hid-sensor-magn-3d: fix iio_val buffer len issue.
> > >   - hid-sensor-accel-3d: refine commit message
> > > 
> > > v2:
> > >   - remove unrelated changes.
> > > 
> > > Ye Xiang (6):
> > >   iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
> > >   iio: hid-sensor-gyro-3d: Add timestamp channel
> > >   iio: hid-sensor-als: Add timestamp channel
> > >   iio: hid-sensor-magn-3d: Add timestamp channel
> > >   iio: hid-sensor-incl-3d: Add timestamp channel
> > >   iio: hid-sensor-rotation: Add timestamp channel
> > > 
> > >  drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
> > >  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
> > >  drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
> > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-----
> > > --
> > >  drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
> > >  drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++-------
> > > -
> > >  6 files changed, 134 insertions(+), 88 deletions(-)
> > >   
> > 
> >   

