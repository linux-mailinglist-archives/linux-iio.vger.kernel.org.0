Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD35A307B1A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 17:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhA1Qgj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 11:36:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:12672 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232593AbhA1Qff (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Jan 2021 11:35:35 -0500
IronPort-SDR: RJD7fxS39npS7iEX/ZdeFA+Q9vbj9zCWQ7No69yM1D+C9dv4jacO6TP10LB3Z9pNZiKcn3magP
 E9dzgoYbMrgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="265096989"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="265096989"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 08:34:47 -0800
IronPort-SDR: y9pYDtN/Q58nS8laohgvzdHcatF0IUU4lKAXlan7AJNEfQMW4xksU2HSEnmXh8GqZISdaCqNs7
 If5a2VkfWYlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="430577314"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2021 08:34:44 -0800
Date:   Fri, 29 Jan 2021 00:35:49 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hid-sensor-common: Add relative sensitivity check
Message-ID: <20210128163549.GA12432@host>
References: <20210120074706.23199-1-xiang.ye@intel.com>
 <20210120074706.23199-3-xiang.ye@intel.com>
 <20210124131442.0fc2577e@archlinux>
 <7e136ebb914f71da3fcb90b8048f9f7dd8cdf0bf.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e136ebb914f71da3fcb90b8048f9f7dd8cdf0bf.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Srinivas andd Jonathan

Thanks for the review.

On Sun, Jan 24, 2021 at 08:20:12AM -0800, Srinivas Pandruvada wrote:
> On Sun, 2021-01-24 at 13:14 +0000, Jonathan Cameron wrote:
> > On Wed, 20 Jan 2021 15:47:05 +0800
> > Ye Xiang <xiang.ye@intel.com> wrote:
> > 
> > > Some hid sensors may use relative sensitivity such as als sensor.
> > > This patch add relative sensitivity check for all hid-sensors.
> > > 
> > > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > > ---
> > >  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11
> > > ++++++++++-
> > >  include/linux/hid-sensor-ids.h                        |  1 +
> > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c 
> > > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > index d349ace2e33f..b685c292a179 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -480,7 +480,7 @@ int hid_sensor_parse_common_attributes(struct
> > > hid_sensor_hub_device *hsdev,
> > >  
> > >  	/*
> > >  	 * Set Sensitivity field ids, when there is no individual
> > > modifier, will
> > > -	 * check absolute sensitivity of data field
> > > +	 * check absolute sensitivity and relative sensitivity of data
> > > field
> > >  	 */
> > >  	for (i = 0; i < sensitivity_addresses_len && st-
> > > >sensitivity.index < 0; i++) {
> > >  		sensor_hub_input_get_attribute_info(hsdev,
> > > @@ -488,6 +488,15 @@ int hid_sensor_parse_common_attributes(struct
> > > hid_sensor_hub_device *hsdev,
> > >  				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > > IVITY_ABS |
> > >  					sensitivity_addresses[i],
> > >  				&st->sensitivity);
> > > +
> > > +		if (st->sensitivity.index >= 0)
> > > +			break;
> > > +
> > > +		sensor_hub_input_get_attribute_info(hsdev,
> > > +				HID_FEATURE_REPORT, usage_id,
> > > +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > > IVITY_REL_PCT |
> > > +					sensitivity_addresses[i],
> > > +				&st->sensitivity);
> > 
> > We can't provide the value to userspace without reflecting the
> > difference between
> > the two ways of expressing it.
> > 
> > It seems there are 3 ways sensitivity is expressed.
> > 1. Raw value in same units as the measurement (easy one and what is
> > currently reported)
> > 2. Percentage of range - also relatively easy to transform into the
> > same as 1.
> > 3. Percentage of prior reading..  This one doesn't fit in any
> > existing ABI, so
> >    unfortunately we'll have to invent something new along the lines
> > of
> >    *_hysteresis_relative 

yes, the 3th version sensitivity (Percentage of prior reading) is what we 
are using for als sensor now. the 1th version sensitivity is common used 
by other hid sensors. Do you have suggestion or reference about 
how to add *_hysteresis_relative field to iio model?

> 
> This is why it was not added before when I developed.  But later few
> years back there was a patch to add this by one of our developer. There
> was some discussion, I thought it was decided it is OK to add.
> 
> But I agree, we should add new ABI as you suggested. Now almost every
> laptop has HID sensors, better to address this. 
> 

I think the add relative hystersis patch should be separated into a independent
patch series, for it's a independent function and need more effort for coding and 
testing. And I can submit the other two patch in this patch series first.

> > 
> > 
> > 
> > >  	}
> > >  
> > >  	st->raw_hystersis = -1;
> > > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > > sensor-ids.h
> > > index 3bbdbccc5805..ac631159403a 100644
> > > --- a/include/linux/hid-sensor-ids.h
> > > +++ b/include/linux/hid-sensor-ids.h
> > > @@ -149,6 +149,7 @@
> > >  /* Per data field properties */
> > >  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
> > > 	0x00
> > >  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
> > > 0x1000
> > > +#define
> > > HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE
> > > 000
> > >  
> > >  /* Power state enumerations */
> > >  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20085
> > > 0
> 
