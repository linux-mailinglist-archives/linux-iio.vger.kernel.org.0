Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117132EA73F
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 10:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbhAEJZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 04:25:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:26725 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbhAEJZy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 5 Jan 2021 04:25:54 -0500
IronPort-SDR: fOgkqVBOZNXNQ67FDUc7BISUPmotuTAogBqYlezBfPDnCNRxsUJKsHXovhsXQSQafYv63Dh1rK
 WGBd8iPIDYaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176297281"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="176297281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:25:14 -0800
IronPort-SDR: Fh7bq6tBIpZO7aRIGMCH1ryd2Zj6cuEChynm/pjKWhQljgtnYCQ16fXYLhm90Vnher3u7Gm4+m
 lOalPhKCp+iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="350298422"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jan 2021 01:25:12 -0800
Date:   Tue, 5 Jan 2021 17:26:33 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     jikos@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] add timestamp channel for hid-sensors
Message-ID: <20210105092632.GA15865@host>
References: <20210105072203.5701-1-xiang.ye@intel.com>
 <ed6a6de1c0b2339d467a3ffd341130342b41c3bc.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed6a6de1c0b2339d467a3ffd341130342b41c3bc.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 05, 2021 at 12:53:44AM -0800, Srinivas Pandruvada wrote:
> On Tue, 2021-01-05 at 15:21 +0800, Ye Xiang wrote:
> > This patch series add a timestamp channel for hid sensors,
> > including gravity sensor, gyro sensor, magnetometer sensor,
> > ambient light sensor, inclinometer sensor, and rotation sensor.
> > 
> > With this patch series, user can get the time when sensor yield
> > a sample.
> > 
> I think this series is v1 for upstream not v3.
Sorry, it's v1 for upstream. will resent it as v1. v3 is our internal review version.

Thanks
Ye Xiang
> 
> 
> > ---
> > v3:
> >   - hid-sensor-magn-3d: fix iio_val buffer len issue.
> >   - hid-sensor-accel-3d: refine commit message
> > 
> > v2:
> >   - remove unrelated changes.
> > 
> > Ye Xiang (6):
> >   iio: hid-sensor-accel-3d: Add timestamp channel for gravity sensor
> >   iio: hid-sensor-gyro-3d: Add timestamp channel
> >   iio: hid-sensor-als: Add timestamp channel
> >   iio: hid-sensor-magn-3d: Add timestamp channel
> >   iio: hid-sensor-incl-3d: Add timestamp channel
> >   iio: hid-sensor-rotation: Add timestamp channel
> > 
> >  drivers/iio/accel/hid-sensor-accel-3d.c       |  6 ++-
> >  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 40 +++++++++-------
> >  drivers/iio/light/hid-sensor-als.c            | 39 ++++++++-------
> >  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 48 ++++++++++++-----
> > --
> >  drivers/iio/orientation/hid-sensor-incl-3d.c  | 43 ++++++++++-------
> >  drivers/iio/orientation/hid-sensor-rotation.c | 46 ++++++++++-------
> > -
> >  6 files changed, 134 insertions(+), 88 deletions(-)
> > 
> 
> 
