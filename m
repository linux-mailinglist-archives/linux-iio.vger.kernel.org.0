Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA372C36DC
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 03:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKYCiD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 21:38:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:5535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgKYCiD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Nov 2020 21:38:03 -0500
IronPort-SDR: oMkXBEV6BPd3otyzMVqMqckpjZ8w6sAeMHgaSmEDogNewx81VVht3kc/faZ5q0/lJROAcQTOds
 f7y0hbP28zlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="256761956"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="256761956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 18:38:02 -0800
IronPort-SDR: wy5G5y0Lgp/bDGnStObfoSCHHMJMAz51c+bkMx8e0iguqsyW5Rlj5WrxTdg5t/dIZvs3moOsbq
 VNYziQGci8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="535120906"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2020 18:38:01 -0800
Date:   Wed, 25 Nov 2020 10:39:00 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: hid-sensors: Add hinge sensor driver
Message-ID: <20201125023900.GA10254@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
 <20201119100331.2594-5-xiang.ye@intel.com>
 <20201121175629.057031af@archlinux>
 <20201124064332.GA21403@host>
 <20201124113951.000009ea@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124113951.000009ea@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Tue, Nov 24, 2020 at 11:39:51AM +0000, Jonathan Cameron wrote:
> 
> > >   
> > > > +
> > > > +	  To compile this driver as a module, choose M here: the
> > > > +	  module will be called hid-sensor-custom-hinge.
> > > > +
> > > >  endmenu
> > > > diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> > > > index 3cbe7a734352..7a6225977a01 100644
> > > > --- a/drivers/iio/position/Makefile
> > > > +++ b/drivers/iio/position/Makefile
> > > > @@ -5,3 +5,6 @@
> > > >  # When adding new entries keep the list in alphabetical order
> > > >  
> > > >  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> > > > +
> > > > +obj-$(CONFIG_HID_SENSOR_CUSTOM_HINGE) += hid-sensor-custom-hinge.o  
> > > 
> > > Alphabetical order preferred.
> > >   
> > > > +ccflags-y	+= -I$(srctree)/drivers/iio/common/hid-sensors  
> > > 
> > > Why?  
> > hinge driver need to include #include "hid-sensor-trigger.h", if not using this cflag-y
> > it should be #include "../common/hid-sensors/hid-sensor-trigger.h"
> 
> Even though that looks a bit ugly, I'd prefer that rather than having to realize we
> were doing something not entirely obvious in the Makefile.
Okay, will remove ccflags-y in the makefile

Thanks
Ye, Xiang
> 
> Thanks,
> 
> Jonathan
