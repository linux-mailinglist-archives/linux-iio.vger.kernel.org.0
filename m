Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F4613BB4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 17:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJaQtC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiJaQsp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 12:48:45 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBCEFEA;
        Mon, 31 Oct 2022 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1667234924;
  x=1698770924;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=fqAuzMv7BYV2NYcrW650i4UQZ4xn2jmosBSKroajJtQ=;
  b=CT5gFYJ6A8gHYerbXMOGuphOyjxp2Ltbz4/mPebXRYsZVpfHVlgxwuDn
   hUALdGYumG8785vu1AbSZRSvgRtX6/gkJ0IvIIXcOkxXdWZ56lY1aM/mR
   KQwKYMEszzt5NS4pJY7ZOp8xvrzwFZ+TJMbh+Df9lZ+XWRPsA8XKzwaiA
   vQ/WlV1wvpTID/Rxk9xkGs8HohSGNh9VpQr1xFHlY9BbvFyjgE5jJp49M
   wBVvy+WZTIJoTTEBB/kmfDAQOqImYup9i8uRTLtE2RdVdOSLJLXXrqSQw
   AGx1NXZQF/xVDCWzBtr6XYiCVbTMem/ohB4LEm5IWfvIuW3O4zyFR1TEf
   w==;
Date:   Mon, 31 Oct 2022 17:48:39 +0100
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state
 with parent
Message-ID: <Y1/8Z/Ibqc3B21Tg@axis.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
 <20220929144618.1086985-2-marten.lindahl@axis.com>
 <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
From:   Marten Lindahl <martenli@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 25, 2022 at 06:20:10PM +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 29, 2022 at 4:46 PM Mårten Lindahl <marten.lindahl@axis.com> wrote:

Hi! Thanks for your feedback!

> >
> > A device that creates a child character device with cdev_device_add by
> > default create a PM sysfs group with power attributes for userspace
> > control. This means that the power attributes monitors the child device
> > only and thus does not reflect the parent device PM runtime behavior.
> 
> It looks like device_set_pm_not_required() should be used on the child then.
> 
> > But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
> > only on a single device that has been enabled for runtime PM, but also
> > on its parent, it should be possible to synchronize the child and the
> > parent so that the power attribute monitoring reflects the child and the
> > parent as one.
> >
> > As an example, if an i2c_client device registers an iio_device, the
> > iio_device will create sysfs power/attribute nodes for userspace
> > control. But if the dev_pm_ops with resume/suspend callbacks is attached
> > to the struct i2c_driver.driver.pm, the PM runtime needs to be enabled
> > for the i2c_client device and not for the child iio_device.
> >
> > In this case PM runtime can be enabled for the i2c_client device and
> > suspend/resume callbacks will be triggered, but the child sysfs power
> > attributes will be visible but marked as 'unsupported' and can not be
> > used for control or monitoring. This can be confusing as the sysfs
> > device node presents the i2c_client and the iio_device as one device.
> 
> I don't quite understand the last sentence.
> 
> They are separate struct device objects and so they each have a
> directory in sysfs, right?
> 

Yes, they do have separate directories and if using device_set_pm_not_required
on the child it will make it clearer which device is PM runtime regulated, so
I guess that is what should be done.

I think it all depends on where in sysfs the user accesses the device from. My
point with these patches is that the iio_device may be perceived to be an
iio device that should be possible to manually power control, as the power
directory is visble. If looking at it from here:

~# ls /sys/bus/iio/devices/iio:device0/
in_illuminance_raw      in_proximity_raw        power
in_illuminance_scale    name                    subsystem
in_proximity_nearlevel  of_node                 uevent

my idea is to let this power directory inherity the parent power control. But
as you say, it is probably better to not create it at all, as the actual manual
power control can be done here:

~# ls /sys/devices/platform/soc/.../i2c-2/2-0060/
driver       modalias     of_node      subsystem
iio:device1  name         power        uevent

where it is more clear which device (the i2c parent) that can be power
controlled.

> > Add a function to synchronize the runtime PM enable state of a device
> > with its parent. As there already exists a link from the child to its
> > parent and both are enabled, all sysfs control/monitoring can reflect
> > both devices, which from a userspace perspective makes more sense.
> 
> Except that user space will be able to change "control" to "on" for
> the parent alone AFAICS which still will be confusing.

Yes, that is true.
> 
> For devices that are pure software constructs it only makes sense to
> expose the PM-runtime interface for them if the plan is to indirectly
> control the parent's runtime PM through them.

I will abandon this patchset and send a single patch for the iio device.

Kind regards
Mårten
> 
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> > ---
> >  drivers/base/power/runtime.c | 18 ++++++++++++++++++
> >  include/linux/pm_runtime.h   |  2 ++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 997be3ac20a7..b202d513684a 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1499,6 +1499,24 @@ void pm_runtime_enable(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_enable);
> >
> > +/**
> > + * pm_runtime_sync_parent_enable - Synchronize enable state.
> > + * @dev: Device to handle.
> > + *
> > + * Synchronize the device enable state with its parent.
> > + * NOTE: This function should only be used if the parent will never disable
> > + * PM runtime (i.e. calling __pm_runtime_disable()) without telling its child.
> > + */
> > +void pm_runtime_sync_parent_enable(struct device *dev)
> > +{
> > +       struct device *parent = dev->parent;
> > +
> > +       if (parent && !parent->power.ignore_children
> > +           && pm_runtime_enabled(parent))
> > +               pm_runtime_enable(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(pm_runtime_sync_parent_enable);
> > +
> >  static void pm_runtime_disable_action(void *data)
> >  {
> >         pm_runtime_dont_use_autosuspend(data);
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index 0a41b2dcccad..5054427adbd1 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -89,6 +89,7 @@ extern void pm_runtime_put_suppliers(struct device *dev);
> >  extern void pm_runtime_new_link(struct device *dev);
> >  extern void pm_runtime_drop_link(struct device_link *link);
> >  extern void pm_runtime_release_supplier(struct device_link *link);
> > +extern void pm_runtime_sync_parent_enable(struct device *dev);
> >
> >  extern int devm_pm_runtime_enable(struct device *dev);
> >
> > @@ -315,6 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
> >  static inline void pm_runtime_new_link(struct device *dev) {}
> >  static inline void pm_runtime_drop_link(struct device_link *link) {}
> >  static inline void pm_runtime_release_supplier(struct device_link *link) {}
> > +static inline void pm_runtime_sync_parent_enable(struct device *dev) {}
> >
> >  #endif /* !CONFIG_PM */
> >
> > --
> > 2.30.2
> >
