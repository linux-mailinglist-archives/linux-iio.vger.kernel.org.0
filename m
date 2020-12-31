Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC12E7DBA
	for <lists+linux-iio@lfdr.de>; Thu, 31 Dec 2020 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLaCqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 21:46:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:59707 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgLaCqE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 21:46:04 -0500
IronPort-SDR: Ppqi4y5iiFW3Rg9qr0o9lYH5xVH4iq8SIDQ+OGiAFRCXHIf0CeB3lghcTCDNZO31xX8YLEHeRe
 OmKrB2PBHmnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="163725975"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="163725975"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 18:45:23 -0800
IronPort-SDR: LRoMqbE4Wmfn6dyeoD7Nvhl52/5s9XRZcjBpcUaD6UqAHe/pG3LY11uX3gZCieFjhTF2ONnc0t
 Yh9m7jLEao8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="348067911"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 30 Dec 2020 18:45:21 -0800
Date:   Thu, 31 Dec 2020 10:46:40 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] add custom hinge sensor support
Message-ID: <20201231024640.GA5718@host>
References: <20201215054444.9324-1-xiang.ye@intel.com>
 <20201230120517.622d3351@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230120517.622d3351@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 30, 2020 at 12:05:17PM +0000, Jonathan Cameron wrote:
> On Tue, 15 Dec 2020 13:44:41 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > Here we register one iio device with three channels which present angle for
> > hinge, keyboard and screen.
> > 
> > This driver works on devices with Intel integrated sensor hub, where
> > hinge sensor is presented using a custom sensor usage id.
> > 
> > Here the angle is presented in degrees, which is converted to radians.
> 
> Other than those minor bits I'm happy to fix up in patch 2, this looks
> good to me.  However, I'll need a Jiri Ack for the hid parts before
> I apply it.  We are are early in this cycle, so no great rush given
> the usual xmas slow down!

Ok, let's wait Jiri to review the hid parts. Thanks for the help.

Thanks
Ye Xiang
> 
> > 
> > Changes since v3:
> >   - hid-sensor-custom: remove sensor_inst::custom_pdev_exposed.
> >   - hid-sensor-custom: use static buf, w_buf to avoid using goto in 
> >     get_known_custom_sensor_index.
> >   - hid-sensor-custom-intel-hinge: use devm_ prefix function instead.
> >   - sysfs-bus-iio: put in_anglY_raw together with in_angl_raw.
> > 
> > Changes since v2:
> >   - use 1 iio device instead of 3 for hinge sensor.
> >   - use indexed channel instead of modified channel and added channel
> >     labels.
> >   - remove 2,3 patch in last version, add a document patch to describe the
> >     hinge channels.
> >   - hid-sensor-custom: use meaningful return value in 
> >     get_known_custom_sensor_index and checked in call side.
> >   - hid-sensor-ids.h: use HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x) to 
> >     define custom sensor value.
> > 
> > Changes since v1:
> >   - fixed errors reported by lkp
> > 
> > Ye Xiang (3):
> >   HID: hid-sensor-custom: Add custom sensor iio support
> >   iio: hid-sensors: Add hinge sensor driver
> >   iio:Documentation: Add documentation for hinge sensor channels
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio       |  11 +
> >  drivers/hid/hid-sensor-custom.c               | 143 +++++++
> >  .../hid-sensors/hid-sensor-attributes.c       |   2 +
> >  drivers/iio/position/Kconfig                  |  16 +
> >  drivers/iio/position/Makefile                 |   1 +
> >  .../position/hid-sensor-custom-intel-hinge.c  | 391 ++++++++++++++++++
> >  include/linux/hid-sensor-ids.h                |  14 +
> >  7 files changed, 578 insertions(+)
> >  create mode 100644 drivers/iio/position/hid-sensor-custom-intel-hinge.c
> > 
> 
