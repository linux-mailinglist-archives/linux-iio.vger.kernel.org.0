Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A900435D30E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Apr 2021 00:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbhDLW1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 18:27:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:4362 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343698AbhDLW1d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 18:27:33 -0400
IronPort-SDR: dmr2gpNcziaft2lAtz8FzrUGWi4O82ilPK5nZYf+B3rfmHAC8uK/Vo9e9f7OqpMnY1fdxB56fL
 cQurdDduRUMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194403242"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194403242"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 15:27:11 -0700
IronPort-SDR: Ry9iw0SKTQ0K3efJJcq7X3P3Ky2VuQ7yAyv8p8I6gieNe4zJ4V7W9s7qIrfo03Dgk2m5JqQiaM
 FpVmZdmxVT2g==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="451668279"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 15:27:10 -0700
Message-ID: <56550dd3c63b062efca5fc7d41c2a251e8fc55ba.camel@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-custom: remove useless variable
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Apr 2021 15:27:03 -0700
In-Reply-To: <20210412112039.00006821@Huawei.com>
References: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
         <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
         <20210411145635.3c6b48d1@jic23-huawei>
         <ceb25b0000013f1c3e89d772c62b5e967a032446.camel@linux.intel.com>
         <20210412112039.00006821@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2021-04-12 at 11:20 +0100, Jonathan Cameron wrote:
> On Sun, 11 Apr 2021 09:06:35 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > On Sun, 2021-04-11 at 14:56 +0100, Jonathan Cameron wrote:
> > > On Fri, 09 Apr 2021 11:19:12 -0700
> > > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> > >   
> > > > On Fri, 2021-04-09 at 15:15 +0800, Jiapeng Chong wrote:  
> > > > > Fix the following gcc warning:
> > > > > 
> > > > > drivers/hid/hid-sensor-custom.c:400:7: warning: variable
> > > > > ‘ret’
> > > > > set
> > > > > but
> > > > > not used [-Wunused-but-set-variable].
> > > > > 
> > > > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com
> > > > > >    
> > > > Acked-by: Srinivas Pandruvada <
> > > > srinivas.pandruvada@linux.intel.com  
> > > 
> > > Perhaps better to return ret if it is non zero?
> > > I can't immediately figure out if there is a reason we know that
> > > can't
> > > happen.  
> > Only time it can fail when there is no report descriptor or the
> > field
> > index is >= report->maxfield.
> > But since the attribute is registered from the report descriptor
> > and
> > index, this can't happen.
> > But we can enhance sensor_hub_set_feature() to fail when
> >  hid_set_field() fails. There is one case where field-
> > >logical_minimum
> > < 0  and value is out of range.
> 
> I'll go with what you think.  Apply as is, or handle the
> return value because we might at some later date return an error that
> can actually happen from here?
> 
I will send you a patch this week to handle error condition.

Thanks,
Srinivas

> Jonathan
> 
> > Thanks,
> > Srinivas
> > 
> > 
> > > Jonathan
> > >   
> > > > > ---
> > > > >  drivers/hid/hid-sensor-custom.c | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/hid/hid-sensor-custom.c
> > > > > b/drivers/hid/hid-
> > > > > sensor-custom.c
> > > > > index 2628bc5..e430673 100644
> > > > > --- a/drivers/hid/hid-sensor-custom.c
> > > > > +++ b/drivers/hid/hid-sensor-custom.c
> > > > > @@ -397,15 +397,14 @@ static ssize_t store_value(struct
> > > > > device
> > > > > *dev,
> > > > > struct device_attribute *attr,
> > > > >  
> > > > >  	if (!strncmp(name, "value", strlen("value"))) {
> > > > >  		u32 report_id;
> > > > > -		int ret;
> > > > >  
> > > > >  		if (kstrtoint(buf, 0, &value) != 0)
> > > > >  			return -EINVAL;
> > > > >  
> > > > >  		report_id = sensor_inst-
> > > > > >fields[field_index].attribute.
> > > > >  								
> > > > > report_
> > > > > id;
> > > > > -		ret = sensor_hub_set_feature(sensor_inst-
> > > > > >hsdev,
> > > > > report_id,
> > > > > -					     index,
> > > > > sizeof(value),
> > > > > &value);
> > > > > +		sensor_hub_set_feature(sensor_inst->hsdev,
> > > > > report_id,
> > > > > index,
> > > > > +				       sizeof(value), &value);
> > > > >  	} else
> > > > >  		return -EINVAL;
> > > > >      

