Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAE52D0CD3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Dec 2020 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLGJRy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Dec 2020 04:17:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:46647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgLGJRx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Dec 2020 04:17:53 -0500
IronPort-SDR: vMfIdAdxiMG5efIEpiiBUkNMVazLmcfdNhIi9QC6zgt/JuBplUMGwVk1kd6LsczAHXOvx9V2ZY
 VWZO+SlLiwfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="173778411"
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="173778411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 01:17:15 -0800
IronPort-SDR: TjpiBIKrylNnjVtgm1EAK6M4FiEAvC48pRag6nyWqm/Kn3+nOkUFjvZVacfRES/olOe4juyInf
 KQKiQgF2epwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="317046397"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2020 01:17:14 -0800
Date:   Mon, 7 Dec 2020 17:18:18 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge
 sensor channels
Message-ID: <20201207091818.GA23419@host>
References: <20201203035352.13918-1-xiang.ye@intel.com>
 <20201203035352.13918-4-xiang.ye@intel.com>
 <20201205160540.22d2b8d5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205160540.22d2b8d5@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan

Thanks for review and comments.

On Sat, Dec 05, 2020 at 04:05:40PM +0000, Jonathan Cameron wrote:
> On Thu,  3 Dec 2020 11:53:52 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > Add channel description for hinge sensor, including channel label
> > attribute and raw data description.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index df42bed09f25..82303b1bdff0 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
> >  		Units after application of scale are nano nanowatts per square meter.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
> > +KernelVersion:	5.12
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Angle of rotation for channel Y. Units after application of scale
> > +		and offset are radians.
> 
> This entry is already mostly in the doc around line 200, just without the index.
> Please just add the What: line to that block to reduce repetition.
> If you want to add... "Where present, Y indexes the channel." or something like
> that feel free.
When adding in_anglY_raw to in_angl_raw block, Should I update the KernelVersion form
4.17 to 5.12? Like blow:

What:		/sys/bus/iio/devices/iio:deviceX/in_angl_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
KernelVersion:	5.12
Contact:	linux-iio@vger.kernel.org
Description:
		Angle of rotation. Units after application of scale and offset
		are radians. Where present, Y indexes the channel.

> 
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> > +KernelVersion:	5.12
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Optional symbolic label for channel Y.
> > +		For Intel hid hinge sensor, the label values are:
> > +		hinge, keyboard, screen. It means the three channels
> > +		each correspond respectively to hinge angle, keyboard angle,
> > +		and screen angle.
> 
> Makes sense to keep this block separate given the additional info provided.
> Alternative would be to add it to the one with in_voltageY_label which would
> be odd given what follows!
Ok, Then I will keep the in_anglY_label block here. BTW, I didnot see in_voltageY_label
in sysfs-bus-iio in current kernel master branch.

> 
> Thanks,
> 
> Jonathan
> 
Thanks
Ye, Xiang
> 
