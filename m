Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C232F05D0
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jan 2021 08:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbhAJHLD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Jan 2021 02:11:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:58862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbhAJHLD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jan 2021 02:11:03 -0500
IronPort-SDR: Ph3gmX39Z+M3eU1GInaUgH7qg2EU5toJgsAu035xhaVEGFwxR0t803muADXpFxZAD5JqwnrcEP
 RirL4PbRGKWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9859"; a="176969633"
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="176969633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 23:10:22 -0800
IronPort-SDR: +MCerczLGg7YRrtxAzgk8uRlie0mkdf52XqN8aI0DvMe2mNG1Tw9T6+kdS648jPrD9uJUZCy22
 2z2GD7V0hRug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,336,1602572400"; 
   d="scan'208";a="423418525"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2021 23:10:20 -0800
Date:   Sun, 10 Jan 2021 15:11:40 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] add timestamp channel for hid-sensors
Message-ID: <20210110071140.GA32641@host>
References: <20210105072203.5701-1-xiang.ye@intel.com>
 <ed6a6de1c0b2339d467a3ffd341130342b41c3bc.camel@linux.intel.com>
 <20210105092632.GA15865@host>
 <20210109192805.138fed41@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210109192805.138fed41@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 09, 2021 at 07:28:05PM +0000, Jonathan Cameron wrote:
> On Tue, 5 Jan 2021 17:26:33 +0800
> "Ye, Xiang" <xiang.ye@intel.com> wrote:
> 
> > On Tue, Jan 05, 2021 at 12:53:44AM -0800, Srinivas Pandruvada wrote:
> > > On Tue, 2021-01-05 at 15:21 +0800, Ye Xiang wrote:  
> > > > This patch series add a timestamp channel for hid sensors,
> > > > including gravity sensor, gyro sensor, magnetometer sensor,
> > > > ambient light sensor, inclinometer sensor, and rotation sensor.
> > > > 
> > > > With this patch series, user can get the time when sensor yield
> > > > a sample.
> > > >   
> > > I think this series is v1 for upstream not v3.  
> > Sorry, it's v1 for upstream. will resent it as v1. v3 is our internal review version.
> > 
> Future notice, if you make a mistake of this particular type - don't resend and
> carry on with future version numbers.  Otherwise it gets really confusing
> if we get to a public v3 version!   Monotonic version numbers only :)
> 
> Not a bit problem though but if that does happen check I don't grab the wrong
> version.

Got it. you grabed the right version v1 for test. thanks.

Thanks
Ye Xiang

> 
> > > 
> > >   
> > > > ---
> > > > v3:
> > > >   - hid-sensor-magn-3d: fix iio_val buffer len issue.
> > > >   - hid-sensor-accel-3d: refine commit message
> > > > 
> > > > v2:
> > > >   - remove unrelated changes.
> > > > 
> > > > Ye Xiang (6):
> > > >   iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
> > > >   iio: hid-sensor-gyro-3d: Add timestamp channel
> > > >   iio: hid-sensor-als: Add timestamp channel
> > > >   iio: hid-sensor-magn-3d: Add timestamp channel
> > > >   iio: hid-sensor-incl-3d: Add timestamp channel
> > > >   iio: hid-sensor-rotation: Add timestamp channel
> > > > 
> > > >  drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
> > > >  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
> > > >  drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
> > > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-----
> > > > --
> > > >  drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
> > > >  drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++-------
> > > > -
> > > >  6 files changed, 134 insertions(+), 88 deletions(-)
> > > >   
> > > 
> > >   
> 
