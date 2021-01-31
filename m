Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE24309C42
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhAaM7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 07:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhAaLaP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 06:30:15 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2772E64E2A;
        Sun, 31 Jan 2021 11:26:51 +0000 (UTC)
Date:   Sun, 31 Jan 2021 11:26:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ye, Xiang" <xiang.ye@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hid-sensor-common: Add relative sensitivity check
Message-ID: <20210131112648.3299b2a0@archlinux>
In-Reply-To: <20210128163549.GA12432@host>
References: <20210120074706.23199-1-xiang.ye@intel.com>
        <20210120074706.23199-3-xiang.ye@intel.com>
        <20210124131442.0fc2577e@archlinux>
        <7e136ebb914f71da3fcb90b8048f9f7dd8cdf0bf.camel@linux.intel.com>
        <20210128163549.GA12432@host>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Jan 2021 00:35:49 +0800
"Ye, Xiang" <xiang.ye@intel.com> wrote:

> Hi Srinivas andd Jonathan
> 
> Thanks for the review.
> 
> On Sun, Jan 24, 2021 at 08:20:12AM -0800, Srinivas Pandruvada wrote:
> > On Sun, 2021-01-24 at 13:14 +0000, Jonathan Cameron wrote:  
> > > On Wed, 20 Jan 2021 15:47:05 +0800
> > > Ye Xiang <xiang.ye@intel.com> wrote:
> > >   
> > > > Some hid sensors may use relative sensitivity such as als sensor.
> > > > This patch add relative sensitivity check for all hid-sensors.
> > > > 
> > > > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > > > ---
> > > >  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11
> > > > ++++++++++-
> > > >  include/linux/hid-sensor-ids.h                        |  1 +
> > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c 
> > > > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > index d349ace2e33f..b685c292a179 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > @@ -480,7 +480,7 @@ int hid_sensor_parse_common_attributes(struct
> > > > hid_sensor_hub_device *hsdev,
> > > >  
> > > >  	/*
> > > >  	 * Set Sensitivity field ids, when there is no individual
> > > > modifier, will
> > > > -	 * check absolute sensitivity of data field
> > > > +	 * check absolute sensitivity and relative sensitivity of data
> > > > field
> > > >  	 */
> > > >  	for (i = 0; i < sensitivity_addresses_len && st-  
> > > > >sensitivity.index < 0; i++) {  
> > > >  		sensor_hub_input_get_attribute_info(hsdev,
> > > > @@ -488,6 +488,15 @@ int hid_sensor_parse_common_attributes(struct
> > > > hid_sensor_hub_device *hsdev,
> > > >  				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > > > IVITY_ABS |
> > > >  					sensitivity_addresses[i],
> > > >  				&st->sensitivity);
> > > > +
> > > > +		if (st->sensitivity.index >= 0)
> > > > +			break;
> > > > +
> > > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > > +				HID_FEATURE_REPORT, usage_id,
> > > > +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > > > IVITY_REL_PCT |
> > > > +					sensitivity_addresses[i],
> > > > +				&st->sensitivity);  
> > > 
> > > We can't provide the value to userspace without reflecting the
> > > difference between
> > > the two ways of expressing it.
> > > 
> > > It seems there are 3 ways sensitivity is expressed.
> > > 1. Raw value in same units as the measurement (easy one and what is
> > > currently reported)
> > > 2. Percentage of range - also relatively easy to transform into the
> > > same as 1.
> > > 3. Percentage of prior reading..  This one doesn't fit in any
> > > existing ABI, so
> > >    unfortunately we'll have to invent something new along the lines
> > > of
> > >    *_hysteresis_relative   
> 
> yes, the 3th version sensitivity (Percentage of prior reading) is what we 
> are using for als sensor now. the 1th version sensitivity is common used 
> by other hid sensors. Do you have suggestion or reference about 
> how to add *_hysteresis_relative field to iio model?

Follow through how elements of iio_chan_info_enum in
include/linux/iio/types.h are used and you should see how to add a new
one (basically add an entry to that and also the string to the
right array in industrialio-core.c + document it in
Documentation/ABI/testing/sysfs-bus-iio.

The issue with putting this in is we are going to be 'fixing' the ABI for
that ALS sensor which is going to cause problems for any userspace users
of that interface... I have no idea how commonly this is used, but it is
possible we'll have to leave that one as incorrect :(

> 
> > 
> > This is why it was not added before when I developed.  But later few
> > years back there was a patch to add this by one of our developer. There
> > was some discussion, I thought it was decided it is OK to add.
> > 
> > But I agree, we should add new ABI as you suggested. Now almost every
> > laptop has HID sensors, better to address this. 
> >   
> 
> I think the add relative hystersis patch should be separated into a independent
> patch series, for it's a independent function and need more effort for coding and 
> testing. And I can submit the other two patch in this patch series first.

Sure, if they are independent that should be fine.

Thanks,

Jonathan

> 
> > > 
> > > 
> > >   
> > > >  	}
> > > >  
> > > >  	st->raw_hystersis = -1;
> > > > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > > > sensor-ids.h
> > > > index 3bbdbccc5805..ac631159403a 100644
> > > > --- a/include/linux/hid-sensor-ids.h
> > > > +++ b/include/linux/hid-sensor-ids.h
> > > > @@ -149,6 +149,7 @@
> > > >  /* Per data field properties */
> > > >  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
> > > > 	0x00
> > > >  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
> > > > 0x1000
> > > > +#define
> > > > HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE
> > > > 000
> > > >  
> > > >  /* Power state enumerations */
> > > >  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20085
> > > > 0  
> >   

