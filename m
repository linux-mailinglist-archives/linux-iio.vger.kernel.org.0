Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6327A63B4F7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Nov 2022 23:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiK1WuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Nov 2022 17:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiK1WuS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2022 17:50:18 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F72A713;
        Mon, 28 Nov 2022 14:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669675817;
  x=1701211817;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=HpUGHmlE/btZ3Zl69nhWBa1kePei32FkpAbSL6yAY/A=;
  b=OafzhmidsYF0rXd6eLRFSZpjR/BA0qm777qMtFxl18+9/+lnuXLJjg2l
   wXAk1DjpviT7D5QB/YTsquOb7VlKVZD+8WN41wtsi7xN+ebVHWIKjbTE8
   Z+cH85rcfbIwK0oW7CTzIlwNz5itBMIekFgwvrlWSxlQeMOP9D/F89XRb
   HIozNdeoKTi467p6MZFfoGwQgBbnIawIl4zjKctNQiQnACPhS+Xv97x3u
   tIVVmo8fxtPwslhMwZm1hDFXIe5nShf4nh34l6uFIO9ppZ3jhNblRgqEy
   TFHrcxSV5vA5DwS+A5kk14kIx89ekD56ik3idwKGXrtVXfJ3FOXaO1NrC
   A==;
Date:   Mon, 28 Nov 2022 23:50:14 +0100
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Pavel Machek <pavel@ucw.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state
 with parent
Message-ID: <Y4U7Jp+wu1SfGkYW@axis.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
 <20220929144618.1086985-2-marten.lindahl@axis.com>
 <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
 <Y1/8Z/Ibqc3B21Tg@axis.com>
 <20221106153315.64952dd3@jic23-huawei>
 <CAJZ5v0hdAkk_GNA5xhaTA0UGb8keJQK9i3UaVgfnc7233nbm8g@mail.gmail.com>
 <20221112153358.52939022@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112153358.52939022@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 12, 2022 at 04:33:58PM +0100, Jonathan Cameron wrote:
> On Sun, 6 Nov 2022 18:16:10 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Sun, Nov 6, 2022 at 4:33 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Mon, 31 Oct 2022 17:48:39 +0100
> > > Marten Lindahl <martenli@axis.com> wrote:
> > >  
> > > > On Tue, Oct 25, 2022 at 06:20:10PM +0200, Rafael J. Wysocki wrote:  
> > > > > On Thu, Sep 29, 2022 at 4:46 PM Mårten Lindahl <marten.lindahl@axis.com> wrote:  
> > > >
> > > > Hi! Thanks for your feedback!
> > > >  
> > > > > >
> > > > > > A device that creates a child character device with cdev_device_add by
> > > > > > default create a PM sysfs group with power attributes for userspace
> > > > > > control. This means that the power attributes monitors the child device
> > > > > > only and thus does not reflect the parent device PM runtime behavior.  
> > > > >
> > > > > It looks like device_set_pm_not_required() should be used on the child then.
> > > > >  
> > > > > > But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
> > > > > > only on a single device that has been enabled for runtime PM, but also
> > > > > > on its parent, it should be possible to synchronize the child and the
> > > > > > parent so that the power attribute monitoring reflects the child and the
> > > > > > parent as one.
> > > > > >
> > > > > > As an example, if an i2c_client device registers an iio_device, the
> > > > > > iio_device will create sysfs power/attribute nodes for userspace
> > > > > > control. But if the dev_pm_ops with resume/suspend callbacks is attached
> > > > > > to the struct i2c_driver.driver.pm, the PM runtime needs to be enabled
> > > > > > for the i2c_client device and not for the child iio_device.
> > > > > >
> > > > > > In this case PM runtime can be enabled for the i2c_client device and
> > > > > > suspend/resume callbacks will be triggered, but the child sysfs power
> > > > > > attributes will be visible but marked as 'unsupported' and can not be
> > > > > > used for control or monitoring. This can be confusing as the sysfs
> > > > > > device node presents the i2c_client and the iio_device as one device.  
> > > > >
> > > > > I don't quite understand the last sentence.
> > > > >
> > > > > They are separate struct device objects and so they each have a
> > > > > directory in sysfs, right?
> > > > >  
> > > >
> > > > Yes, they do have separate directories and if using device_set_pm_not_required
> > > > on the child it will make it clearer which device is PM runtime regulated, so
> > > > I guess that is what should be done.
> > > >
> > > > I think it all depends on where in sysfs the user accesses the device from. My
> > > > point with these patches is that the iio_device may be perceived to be an
> > > > iio device that should be possible to manually power control, as the power
> > > > directory is visble. If looking at it from here:
> > > >
> > > > ~# ls /sys/bus/iio/devices/iio:device0/
> > > > in_illuminance_raw      in_proximity_raw        power
> > > > in_illuminance_scale    name                    subsystem
> > > > in_proximity_nearlevel  of_node                 uevent
> > > >
> > > > my idea is to let this power directory inherity the parent power control. But
> > > > as you say, it is probably better to not create it at all, as the actual manual
> > > > power control can be done here:
> > > >
> > > > ~# ls /sys/devices/platform/soc/.../i2c-2/2-0060/
> > > > driver       modalias     of_node      subsystem
> > > > iio:device1  name         power        uevent
> > > >
> > > > where it is more clear which device (the i2c parent) that can be power
> > > > controlled.
> > > >  
> > > > > > Add a function to synchronize the runtime PM enable state of a device
> > > > > > with its parent. As there already exists a link from the child to its
> > > > > > parent and both are enabled, all sysfs control/monitoring can reflect
> > > > > > both devices, which from a userspace perspective makes more sense.  
> > > > >
> > > > > Except that user space will be able to change "control" to "on" for
> > > > > the parent alone AFAICS which still will be confusing.  
> > > >
> > > > Yes, that is true.  
> > > > >
> > > > > For devices that are pure software constructs it only makes sense to
> > > > > expose the PM-runtime interface for them if the plan is to indirectly
> > > > > control the parent's runtime PM through them.  
> > > >
> > > > I will abandon this patchset and send a single patch for the iio device.  
> > >
> > > I entirely agree with the statement that these are pointless and should not
> > > be exposed.  However I don't want to see a per device tweak.  If we get
> > > rid of these, we get rid of them for all of the iio:device0/
> > > devices (and the various other types of device IIO uses).
> > >
> > > The risk here is that, although pointless, some userspace is relying on the
> > > ABI in sysfs.  Do people thing it's worth the gamble of getting rid
> > > of this non functioning interface for the whole of IIO?  
> > 
> > I think so.
> > 
> > It is better to avoid exposing garbage to user space even if the scope
> > of it is limited IMV.
> 
> Marten, do you want to spin a patch doing this in the iio core?
> 
> If not I'll do so sometime soon.  Given where we are in the cycle,
> and the need to keep such a patch up for review for at least a few weeks,
> we can look to get it into next early next cycle and hopefully any issues
> will become apparent.

Please excuse me Jonathan, I missed this mail. I really do apologize.

Considering a patch for the discussed issue. I think I need to dig into
the core a bit more before I can do it. I only had the vcnl4000 driver
in focus, so if you have an idea of how it should be done in the core,
then I think it's better if you do it.

If yo ask me to look into it I will try to do it, but I'm afraid it will
take some time before I can send anything.

Kind regards
Mårten

> 
> Jonathan
> 
> > 
> > > So far I think this is only been done for a few similar cases
> > > and for new subsystems.  
> 
