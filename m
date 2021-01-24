Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D88301D75
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 17:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXQV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 11:21:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:35494 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbhAXQV7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 11:21:59 -0500
IronPort-SDR: 79VYAaieHYj/tZ2DEWVb9EG0zcz+tSN0tVhs4joTyE1Qtyvr1/92OKrsSAr5TLIGFqXwNSdbCS
 nrBEY8333eMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176113157"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="176113157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 08:20:13 -0800
IronPort-SDR: tY/Y8C2BotmsCPjIOAK3po8IS3tkIYksifeGgDc53H21I0VQ4GHvzgulRKaK8l0foEtRd2k9sL
 P7lbJofDp/IQ==
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="405754353"
Received: from skalidos-mobl.amr.corp.intel.com ([10.212.110.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 08:20:13 -0800
Message-ID: <7e136ebb914f71da3fcb90b8048f9f7dd8cdf0bf.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] hid-sensor-common: Add relative sensitivity check
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 24 Jan 2021 08:20:12 -0800
In-Reply-To: <20210124131442.0fc2577e@archlinux>
References: <20210120074706.23199-1-xiang.ye@intel.com>
         <20210120074706.23199-3-xiang.ye@intel.com>
         <20210124131442.0fc2577e@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-01-24 at 13:14 +0000, Jonathan Cameron wrote:
> On Wed, 20 Jan 2021 15:47:05 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > Some hid sensors may use relative sensitivity such as als sensor.
> > This patch add relative sensitivity check for all hid-sensors.
> > 
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> > ---
> >  .../iio/common/hid-sensors/hid-sensor-attributes.c    | 11
> > ++++++++++-
> >  include/linux/hid-sensor-ids.h                        |  1 +
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c 
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index d349ace2e33f..b685c292a179 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -480,7 +480,7 @@ int hid_sensor_parse_common_attributes(struct
> > hid_sensor_hub_device *hsdev,
> >  
> >  	/*
> >  	 * Set Sensitivity field ids, when there is no individual
> > modifier, will
> > -	 * check absolute sensitivity of data field
> > +	 * check absolute sensitivity and relative sensitivity of data
> > field
> >  	 */
> >  	for (i = 0; i < sensitivity_addresses_len && st-
> > >sensitivity.index < 0; i++) {
> >  		sensor_hub_input_get_attribute_info(hsdev,
> > @@ -488,6 +488,15 @@ int hid_sensor_parse_common_attributes(struct
> > hid_sensor_hub_device *hsdev,
> >  				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > IVITY_ABS |
> >  					sensitivity_addresses[i],
> >  				&st->sensitivity);
> > +
> > +		if (st->sensitivity.index >= 0)
> > +			break;
> > +
> > +		sensor_hub_input_get_attribute_info(hsdev,
> > +				HID_FEATURE_REPORT, usage_id,
> > +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > IVITY_REL_PCT |
> > +					sensitivity_addresses[i],
> > +				&st->sensitivity);
> 
> We can't provide the value to userspace without reflecting the
> difference between
> the two ways of expressing it.
> 
> It seems there are 3 ways sensitivity is expressed.
> 1. Raw value in same units as the measurement (easy one and what is
> currently reported)
> 2. Percentage of range - also relatively easy to transform into the
> same as 1.
> 3. Percentage of prior reading..  This one doesn't fit in any
> existing ABI, so
>    unfortunately we'll have to invent something new along the lines
> of
>    *_hysteresis_relative 

This is why it was not added before when I developed.  But later few
years back there was a patch to add this by one of our developer. There
was some discussion, I thought it was decided it is OK to add.

But I agree, we should add new ABI as you suggested. Now almost every
laptop has HID sensors, better to address this. 

Thanks,
Srinivas

 


> Jonathan
> 
> 
> 
> >  	}
> >  
> >  	st->raw_hystersis = -1;
> > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > sensor-ids.h
> > index 3bbdbccc5805..ac631159403a 100644
> > --- a/include/linux/hid-sensor-ids.h
> > +++ b/include/linux/hid-sensor-ids.h
> > @@ -149,6 +149,7 @@
> >  /* Per data field properties */
> >  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
> > 	0x00
> >  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
> > 0x1000
> > +#define
> > HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE
> > 000
> >  
> >  /* Power state enumerations */
> >  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20085
> > 0

