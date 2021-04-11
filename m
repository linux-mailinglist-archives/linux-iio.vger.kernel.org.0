Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85AE35B57F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhDKN4g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 11 Apr 2021 09:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235338AbhDKN4c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 09:56:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED73611AD;
        Sun, 11 Apr 2021 13:56:13 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:56:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: remove useless variable
Message-ID: <20210411145635.3c6b48d1@jic23-huawei>
In-Reply-To: <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
References: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
        <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 09 Apr 2021 11:19:12 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Fri, 2021-04-09 at 15:15 +0800, Jiapeng Chong wrote:
> > Fix the following gcc warning:
> > 
> > drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’ set
> > but
> > not used [-Wunused-but-set-variable].
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>  
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com

Perhaps better to return ret if it is non zero?
I can't immediately figure out if there is a reason we know that can't
happen.

Jonathan

> 
> > ---
> >  drivers/hid/hid-sensor-custom.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > sensor-custom.c
> > index 2628bc5..e430673 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -397,15 +397,14 @@ static ssize_t store_value(struct device *dev,
> > struct device_attribute *attr,
> >  
> >  	if (!strncmp(name, "value", strlen("value"))) {
> >  		u32 report_id;
> > -		int ret;
> >  
> >  		if (kstrtoint(buf, 0, &value) != 0)
> >  			return -EINVAL;
> >  
> >  		report_id = sensor_inst->fields[field_index].attribute.
> >  								report_
> > id;
> > -		ret = sensor_hub_set_feature(sensor_inst->hsdev,
> > report_id,
> > -					     index, sizeof(value),
> > &value);
> > +		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> > index,
> > +				       sizeof(value), &value);
> >  	} else
> >  		return -EINVAL;
> >    
> 

