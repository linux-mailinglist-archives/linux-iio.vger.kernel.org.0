Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68DF2C36C0
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 03:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKYC0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 21:26:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:52342 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKYC0Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Nov 2020 21:26:24 -0500
IronPort-SDR: +zFRXqYtVH7atd/yIOztsurauA93+fjEUvOAv3LIuAkElDFu/tFu48W3DhRT8uIwMNtShyWoO9
 sOpTZ2Mho5LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151310112"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="151310112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 18:26:24 -0800
IronPort-SDR: HgEEiza3ofR+6oEn/jr/T0qXmXGyfHHDmohyDPoGz2R1FNIXq4Bar8l6t1Fcsymt1yPdOJBvcb
 kT83pYsGbprw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="370664952"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Nov 2020 18:26:22 -0800
Date:   Wed, 25 Nov 2020 10:27:21 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] HID: hid-sensor-custom: Add custom sensor iio
 support
Message-ID: <20201125022721.GA4958@host>
References: <20201119100331.2594-1-xiang.ye@intel.com>
 <20201119100331.2594-2-xiang.ye@intel.com>
 <20201121172127.18bdd4bb@archlinux>
 <20201124102905.GA29864@host>
 <20201124113211.00003141@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124113211.00003141@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 24, 2020 at 11:32:11AM +0000, Jonathan Cameron wrote:
> Hi
> ...
> > > >  	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> > > > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> > > > index 530c09f3e64a..46db3056f04b 100644
> > > > --- a/include/linux/hid-sensor-ids.h
> > > > +++ b/include/linux/hid-sensor-ids.h
> > > > @@ -128,6 +128,10 @@
> > > >  #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
> > > >  
> > > >  /* Common selectors */
> > > > +#define HID_USAGE_SENSOR_PROP_DESC				0x200300
> > > > +#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
> > > > +#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
> > > > +#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
> > > >  #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
> > > >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
> > > >  #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
> > > > @@ -159,4 +163,39 @@
> > > >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
> > > >  #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
> > > >  
> > > > +/* Custom Sensor (2000e1) */
> > > > +#define HID_USAGE_SENSOR_HINGE				        0x20020B
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
> > > > +#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE		0x200543  
> > > Given these are all defined in a block could we use a macro?
> > > HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                     0x200543 + (x)
> > > 
> > > perhaps?
> > > 
> > > I'm not sure what the preferred convention is in this file.  
> > If using HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x), we should give a range to x, like (1<x<28).
> > How to ensure the x is in the range? It can be an issue when someone using x out of the range.
> 
> It can be done via build time checking.
> https://elixir.bootlin.com/linux/latest/source/include/linux/build_bug.h#L49
> Normally we wouldn't bother and would rely on review to pick up on this but
> I'd have no problem with a paranoid check in the macro. Particularly as 28 isn't
> exactly and obvious number to support!
Because HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE is used as case condition, we cannot use
Build_BUG_ON in the macro like below.
#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
       ({                                                                     \
               BUILD_BUG_ON(x > 28);                                          \
               BUILD_BUG_ON(x < 0);                                           \
               (HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x));         \
       })

I can use the define with a comments to declear the range of x.
#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE           0x200543
/* Custom Sensor data 28=>x>=0 */
#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
	(HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x)) 

Thanks
Ye, Xiang
> 
> > 
> > Thanks
> > Xiang
> > >   
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_1		0x200544
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_2		0x200545
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_3		0x200546
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_4		0x200547
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_5		0x200548
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_6		0x200549
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_7		0x20054A
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_8		0x20054B
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_9		0x20054C
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_10		0x20054D
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_11		0x20054E
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_12		0x20054F
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_13		0x200550
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_14		0x200551
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_15		0x200552
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_16		0x200553
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_17		0x200554
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_18		0x200555
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_19		0x200556
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_20		0x200557
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_21		0x200558
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_22		0x200559
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_23		0x20055A
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_24		0x20055B
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_25		0x20055C
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_26		0x20055D
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_27		0x20055E
> > > > +#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_28		0x20055F
> > > > +
> > > >  #endif  
> > >   
> 
