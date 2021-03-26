Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48B34A683
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCZLix (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhCZLi0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Mar 2021 07:38:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C11C61A33;
        Fri, 26 Mar 2021 11:38:24 +0000 (UTC)
Date:   Fri, 26 Mar 2021 11:38:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: Re: [PULL] 1st set of IIO and counter new device support and core
 changes for the 5.13 cycle.
Message-ID: <20210326113828.7b125221@jic23-huawei>
In-Reply-To: <YF3BVjBTwP9ZOMuY@kroah.com>
References: <20210326104656.5d7689cb@jic23-huawei>
        <20210326105436.44e9d3de@jic23-huawei>
        <YF3BVjBTwP9ZOMuY@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 12:11:18 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 26, 2021 at 10:54:36AM +0000, Jonathan Cameron wrote:
> > On Fri, 26 Mar 2021 10:46:56 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > The following changes since commit c972c2d821ca3eda001a20dbe2ca0b4718838caf:
> > > 
> > >   staging: unisys: visornic: Fix repeated words in comments (2021-03-10 09:25:33 +0100)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.13a
> > > 
> > > for you to fetch changes up to 1b33dfa5d5f165782a1cb18ba1350a42d5d7a579:
> > > 
> > >   Merge remote-tracking branch 'local/ib-iio-scmi-5.12-rc2-take3' into togreg (2021-03-26 10:23:46 +0000)  
> > 
> > Hi Greg,
> > 
> > There is a conflict merging this into staging/staging-next that needs
> > manual resolution.  It is is in hid-sensor-prox.c and resolution I would
> > recommend is to drop the block that is in staging-next.
> > 
> > @@ -220,29 +225,6 @@ static int prox_parse_report(struct platform_device *pdev,
> >         dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
> >                         st->prox_attr.report_id);
> >  
> > -       /* Set Sensitivity field ids, when there is no individual modifier */
> > -       if (st->common_attributes.sensitivity.index < 0) {
> > -               sensor_hub_input_get_attribute_info(hsdev,
> > -                       HID_FEATURE_REPORT, usage_id,
> > -                       HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> > -                       HID_USAGE_SENSOR_DATA_PRESENCE,
> > -                       &st->common_attributes.sensitivity);
> > -               dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> > -                       st->common_attributes.sensitivity.index,
> > -                       st->common_attributes.sensitivity.report_id);
> > -       }
> > -       if (st->common_attributes.sensitivity.index < 0)
> > -               sensor_hub_input_get_attribute_info(hsdev,
> > -                       HID_FEATURE_REPORT, usage_id,
> > -                       HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> > -                       HID_USAGE_SENSOR_HUMAN_PRESENCE,
> > -                       &st->common_attributes.sensitivity);
> > -
> > -       st->scale_precision = hid_sensor_format_scale(
> > -                               hsdev->usage,
> > -                               &st->prox_attr,
> > -                               &st->scale_pre_decml, &st->scale_post_decml);
> > -
> >         return ret;
> >  }
> > 
> > Ye Xiang, if that looks wrong to you let us know.  
> 
> That worked for me.
> 
> Note, I get the following "warning" from my scripts when trying to merge
> this:
> 
>  Commit: 0463e60f0870 ("iio: adis16480: fix pps mode sampling frequency math")
> 	Fixes tag: Fixes: 326e2357553d3 ("iio: imu: adis16480: Add support for external clock")
> 	Has these problem(s):
> 	        - empty lines surround the Fixes tag
> 
> I'm going to ignore this, but expect a message from the linux-next
> maintainer about this :(

Doh, seems I need to upgrade my checking scripts (or eyes)

Thanks,

Jonathan

> 
> thanks,
> 
> greg k-h

