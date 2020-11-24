Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6F2C24CF
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732956AbgKXLkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 06:40:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2143 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgKXLkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2020 06:40:09 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CgMSv0bd0z67GX4;
        Tue, 24 Nov 2020 19:37:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 24 Nov 2020 12:40:07 +0100
Received: from localhost (10.47.66.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 24 Nov
 2020 11:40:07 +0000
Date:   Tue, 24 Nov 2020 11:39:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ye, Xiang" <xiang.ye@intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <jikos@kernel.org>,
        <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: hid-sensors: Add hinge sensor driver
Message-ID: <20201124113951.000009ea@Huawei.com>
In-Reply-To: <20201124064332.GA21403@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
        <20201119100331.2594-5-xiang.ye@intel.com>
        <20201121175629.057031af@archlinux>
        <20201124064332.GA21403@host>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.66.130]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> >   
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called hid-sensor-custom-hinge.
> > > +
> > >  endmenu
> > > diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> > > index 3cbe7a734352..7a6225977a01 100644
> > > --- a/drivers/iio/position/Makefile
> > > +++ b/drivers/iio/position/Makefile
> > > @@ -5,3 +5,6 @@
> > >  # When adding new entries keep the list in alphabetical order
> > >  
> > >  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> > > +
> > > +obj-$(CONFIG_HID_SENSOR_CUSTOM_HINGE) += hid-sensor-custom-hinge.o  
> > 
> > Alphabetical order preferred.
> >   
> > > +ccflags-y	+= -I$(srctree)/drivers/iio/common/hid-sensors  
> > 
> > Why?  
> hinge driver need to include #include "hid-sensor-trigger.h", if not using this cflag-y
> it should be #include "../common/hid-sensors/hid-sensor-trigger.h"

Even though that looks a bit ugly, I'd prefer that rather than having to realize we
were doing something not entirely obvious in the Makefile.

Thanks,

Jonathan
