Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38312C7476
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbgK1Vta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733211AbgK1TGu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:06:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57E924671;
        Sat, 28 Nov 2020 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606570176;
        bh=ISe7j/OX5cdcWTRh8YAAybJtMJKopbyofLwO0nzAGLA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WFxnkD+3JHVa9hvCSw2Kf0esY6f+cdvXt4BrDxxqAB9g+Hy1bHnkl2ZcljeyZcnyq
         7hWD3sQ9wiEWpVh7xjHxd0idxdVrkHD6G+igqOp5tVruqe75qDkGO/TYTky0Q76Xq4
         YTMUqagwcFM8N1Bt6f1hQ8WZTGwRFZM4f2eXVog8=
Date:   Sat, 28 Nov 2020 13:29:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ye, Xiang" <xiang.ye@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, jikos@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: hid-sensor-custom: Add custom sensor iio
 support
Message-ID: <20201128132931.4844ceb5@archlinux>
In-Reply-To: <20201125022721.GA4958@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
        <20201119100331.2594-2-xiang.ye@intel.com>
        <20201121172127.18bdd4bb@archlinux>
        <20201124102905.GA29864@host>
        <20201124113211.00003141@Huawei.com>
        <20201125022721.GA4958@host>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Nov 2020 10:27:21 +0800
"Ye, Xiang" <xiang.ye@intel.com> wrote:

> On Tue, Nov 24, 2020 at 11:32:11AM +0000, Jonathan Cameron wrote:
> > Hi
> > ...  
> > > > >  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> > > > > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> > > > > index 530c09f3e64a..46db3056f04b 100644
> > > > > --- a/include/linux/hid-sensor-ids.h
> > > > > +++ b/include/linux/hid-sensor-ids.h
> > > > > @@ -128,6 +128,10 @@
> > > > >  #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
> > > > >  
> > > > >  /* Common selectors */
> > > > > +#define HID_USAGE_SENSOR_PROP_DESC				0x200300
> > > > > +#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
> > > > > +#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
> > > > > +#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
> > > > >  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
> > > > >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
> > > > >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> > > > > @@ -159,4 +163,39 @@
> > > > >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
> > > > >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
> > > > >  
> > > > > +/* Custom Sensor (2000e1) */
> > > > > +#define HID_USAGE_SENSOR_HINGE				        0x20020B
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE		0x200543    
> > > > Given these are all defined in a block could we use a macro?
> > > > HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                     0x200543 + (x)
> > > > 
> > > > perhaps?
> > > > 
> > > > I'm not sure what the preferred convention is in this file.    
> > > If using HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x), we should give a range to x, like (1<x<28).
> > > How to ensure the x is in the range? It can be an issue when someone using x out of the range.  
> > 
> > It can be done via build time checking.
> > https://elixir.bootlin.com/linux/latest/source/include/linux/build_bug.h#L49
> > Normally we wouldn't bother and would rely on review to pick up on this but
> > I'd have no problem with a paranoid check in the macro. Particularly as 28 isn't
> > exactly and obvious number to support!  
> Because HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE is used as case condition, we cannot use
> Build_BUG_ON in the macro like below.
> #define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
>        ({                                                                     \
>                BUILD_BUG_ON(x > 28);                                          \
>                BUILD_BUG_ON(x < 0);                                           \
>                (HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x));         \
>        })

Ah. I'd missed the case condition element.  Good point!


> 
> I can use the define with a comments to declear the range of x.
> #define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE           0x200543
> /* Custom Sensor data 28=>x>=0 */
> #define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
> 	(HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x)) 
> 
Sounds good to me.

Thanks,

Jonathan

> Thanks
> Ye, Xiang
> >   
> > > 
> > > Thanks
> > > Xiang  
> > > >     
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1		0x200544
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_2		0x200545
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_3		0x200546
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_4		0x200547
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_5		0x200548
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_6		0x200549
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_7		0x20054A
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_8		0x20054B
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_9		0x20054C
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_10		0x20054D
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_11		0x20054E
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_12		0x20054F
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_13		0x200550
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_14		0x200551
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_15		0x200552
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_16		0x200553
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_17		0x200554
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_18		0x200555
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_19		0x200556
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_20		0x200557
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_21		0x200558
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_22		0x200559
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_23		0x20055A
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_24		0x20055B
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_25		0x20055C
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_26		0x20055D
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_27		0x20055E
> > > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_28		0x20055F
> > > > > +
> > > > >  #endif    
> > > >     
> >   

