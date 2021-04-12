Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98CD35C3B5
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbhDLKW2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 12 Apr 2021 06:22:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2834 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbhDLKW0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 06:22:26 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJl3M1h5sz688RF;
        Mon, 12 Apr 2021 18:14:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 12:22:06 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 11:22:05 +0100
Date:   Mon, 12 Apr 2021 11:20:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-custom: remove useless variable
Message-ID: <20210412112039.00006821@Huawei.com>
In-Reply-To: <ceb25b0000013f1c3e89d772c62b5e967a032446.camel@linux.intel.com>
References: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
        <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
        <20210411145635.3c6b48d1@jic23-huawei>
        <ceb25b0000013f1c3e89d772c62b5e967a032446.camel@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Apr 2021 09:06:35 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sun, 2021-04-11 at 14:56 +0100, Jonathan Cameron wrote:
> > On Fri, 09 Apr 2021 11:19:12 -0700
> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >   
> > > On Fri, 2021-04-09 at 15:15 +0800, Jiapeng Chong wrote:  
> > > > Fix the following gcc warning:
> > > > 
> > > > drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’
> > > > set
> > > > but
> > > > not used [-Wunused-but-set-variable].
> > > > 
> > > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>    
> > > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com  
> > 
> > Perhaps better to return ret if it is non zero?
> > I can't immediately figure out if there is a reason we know that
> > can't
> > happen.  
> Only time it can fail when there is no report descriptor or the field
> index is >= report->maxfield.
> But since the attribute is registered from the report descriptor and
> index, this can't happen.
> But we can enhance sensor_hub_set_feature() to fail when
>  hid_set_field() fails. There is one case where field->logical_minimum
> < 0  and value is out of range.

I'll go with what you think.  Apply as is, or handle the
return value because we might at some later date return an error that
can actually happen from here?

Jonathan

> 
> Thanks,
> Srinivas
> 
> 
> > 
> > Jonathan
> >   
> > > > ---
> > > >  drivers/hid/hid-sensor-custom.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > > > sensor-custom.c
> > > > index 2628bc5..e430673 100644
> > > > --- a/drivers/hid/hid-sensor-custom.c
> > > > +++ b/drivers/hid/hid-sensor-custom.c
> > > > @@ -397,15 +397,14 @@ static ssize_t store_value(struct device
> > > > *dev,
> > > > struct device_attribute *attr,
> > > >  
> > > >  	if (!strncmp(name, "value", strlen("value"))) {
> > > >  		u32 report_id;
> > > > -		int ret;
> > > >  
> > > >  		if (kstrtoint(buf, 0, &value) != 0)
> > > >  			return -EINVAL;
> > > >  
> > > >  		report_id = sensor_inst->fields[field_index].attribute.
> > > >  								report_
> > > > id;
> > > > -		ret = sensor_hub_set_feature(sensor_inst->hsdev,
> > > > report_id,
> > > > -					     index, sizeof(value),
> > > > &value);
> > > > +		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> > > > index,
> > > > +				       sizeof(value), &value);
> > > >  	} else
> > > >  		return -EINVAL;
> > > >      
> 

