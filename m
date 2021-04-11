Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7365B35B607
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhDKQGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 12:06:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:63433 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236336AbhDKQGx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 12:06:53 -0400
IronPort-SDR: f9upS+UTTlOInoyyfcuCvJeGYCU+CHF/OxnYQt9UWhjQiNfdqPdUlUxb7YvTSC1A643H7CM3yo
 OZB0xCu8Ilgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="279339599"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="279339599"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 09:06:36 -0700
IronPort-SDR: muuYQBEec/nm4lJTFq5kEdfvwsFQ3Xli2/vfZ5JI0OkN+3BmshVlST9fseMmIbl4DNYzId3+wj
 +1EMe0+Mmk+A==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="417033834"
Received: from eunsohlk-mobl1.amr.corp.intel.com ([10.212.186.19])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 09:06:36 -0700
Message-ID: <ceb25b0000013f1c3e89d772c62b5e967a032446.camel@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-custom: remove useless variable
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 11 Apr 2021 09:06:35 -0700
In-Reply-To: <20210411145635.3c6b48d1@jic23-huawei>
References: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
         <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
         <20210411145635.3c6b48d1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-04-11 at 14:56 +0100, Jonathan Cameron wrote:
> On Fri, 09 Apr 2021 11:19:12 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > On Fri, 2021-04-09 at 15:15 +0800, Jiapeng Chong wrote:
> > > Fix the following gcc warning:
> > > 
> > > drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’
> > > set
> > > but
> > > not used [-Wunused-but-set-variable].
> > > 
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>  
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com
> 
> Perhaps better to return ret if it is non zero?
> I can't immediately figure out if there is a reason we know that
> can't
> happen.
Only time it can fail when there is no report descriptor or the field
index is >= report->maxfield.
But since the attribute is registered from the report descriptor and
index, this can't happen.
But we can enhance sensor_hub_set_feature() to fail when
 hid_set_field() fails. There is one case where field->logical_minimum
< 0  and value is out of range.

Thanks,
Srinivas


> 
> Jonathan
> 
> > > ---
> > >  drivers/hid/hid-sensor-custom.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > > sensor-custom.c
> > > index 2628bc5..e430673 100644
> > > --- a/drivers/hid/hid-sensor-custom.c
> > > +++ b/drivers/hid/hid-sensor-custom.c
> > > @@ -397,15 +397,14 @@ static ssize_t store_value(struct device
> > > *dev,
> > > struct device_attribute *attr,
> > >  
> > >  	if (!strncmp(name, "value", strlen("value"))) {
> > >  		u32 report_id;
> > > -		int ret;
> > >  
> > >  		if (kstrtoint(buf, 0, &value) != 0)
> > >  			return -EINVAL;
> > >  
> > >  		report_id = sensor_inst->fields[field_index].attribute.
> > >  								report_
> > > id;
> > > -		ret = sensor_hub_set_feature(sensor_inst->hsdev,
> > > report_id,
> > > -					     index, sizeof(value),
> > > &value);
> > > +		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> > > index,
> > > +				       sizeof(value), &value);
> > >  	} else
> > >  		return -EINVAL;
> > >    

