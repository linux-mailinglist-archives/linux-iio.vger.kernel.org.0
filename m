Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0323861E4D6
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiKFRWo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 6 Nov 2022 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiKFRWX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 12:22:23 -0500
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E06F02D;
        Sun,  6 Nov 2022 09:16:22 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id o8so6717590qvw.5;
        Sun, 06 Nov 2022 09:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yRFsAjwUQIfQ4Fg55dNvKkTZgYP5zwoGBPW0w7s+iI=;
        b=mT9CUr4dLw6pxvrXZ5BVZnabbZMTg6DsgrbiexmQNrJZ6A5ECR2T+O3BcxTHvAwUsd
         AwVddFhvv9a9asNiBD7KsCHSWxb+PTvXUdvQUIXRkdLtfFihWP5KsrXhBQ6RpEfivXgB
         KT2K6L+4jVy7mCEAMlMHrbsJek1HNjYVilz5IZMeOvrY4W5qEQFKg7f4Shzt432w1+jA
         yy+aIu/RBefBtymzmQm4bpFrZbbAUO2aajVNCu+ZKOgxVwqiNRjQ0G3uRW8gC7xPs/5G
         PrBrygvN2GL63JfEfr34ygwxT6YNPAC39dvD+EkJ20wzCqkS67ZtpBsvHsd6y2G0gn5h
         tUvg==
X-Gm-Message-State: ACrzQf3CAYf8F0rR7tntbkwafomMGqK/I+lJfhwrcq6MiJei0pDMNdQ/
        zkyRY1YcMp+oChm0BwCCS7fR6Si+uhDixrT0BTh6QD0H
X-Google-Smtp-Source: AMsMyM5EXmTz+xFzPWNejXFA5RJVG7EMMmfcmgs74EQWjoljDgwwOE9KqNZ64dVDhpCCCFbBnybblZqOF65V3hWzj/o=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr32688902qvj.3.1667754982089; Sun, 06 Nov
 2022 09:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
 <20220929144618.1086985-2-marten.lindahl@axis.com> <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
 <Y1/8Z/Ibqc3B21Tg@axis.com> <20221106153315.64952dd3@jic23-huawei>
In-Reply-To: <20221106153315.64952dd3@jic23-huawei>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 6 Nov 2022 18:16:10 +0100
Message-ID: <CAJZ5v0hdAkk_GNA5xhaTA0UGb8keJQK9i3UaVgfnc7233nbm8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state with parent
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marten Lindahl <martenli@axis.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <Marten.Lindahl@axis.com>,
        Pavel Machek <pavel@ucw.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 6, 2022 at 4:33 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 31 Oct 2022 17:48:39 +0100
> Marten Lindahl <martenli@axis.com> wrote:
>
> > On Tue, Oct 25, 2022 at 06:20:10PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Sep 29, 2022 at 4:46 PM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > Hi! Thanks for your feedback!
> >
> > > >
> > > > A device that creates a child character device with cdev_device_add by
> > > > default create a PM sysfs group with power attributes for userspace
> > > > control. This means that the power attributes monitors the child device
> > > > only and thus does not reflect the parent device PM runtime behavior.
> > >
> > > It looks like device_set_pm_not_required() should be used on the child then.
> > >
> > > > But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
> > > > only on a single device that has been enabled for runtime PM, but also
> > > > on its parent, it should be possible to synchronize the child and the
> > > > parent so that the power attribute monitoring reflects the child and the
> > > > parent as one.
> > > >
> > > > As an example, if an i2c_client device registers an iio_device, the
> > > > iio_device will create sysfs power/attribute nodes for userspace
> > > > control. But if the dev_pm_ops with resume/suspend callbacks is attached
> > > > to the struct i2c_driver.driver.pm, the PM runtime needs to be enabled
> > > > for the i2c_client device and not for the child iio_device.
> > > >
> > > > In this case PM runtime can be enabled for the i2c_client device and
> > > > suspend/resume callbacks will be triggered, but the child sysfs power
> > > > attributes will be visible but marked as 'unsupported' and can not be
> > > > used for control or monitoring. This can be confusing as the sysfs
> > > > device node presents the i2c_client and the iio_device as one device.
> > >
> > > I don't quite understand the last sentence.
> > >
> > > They are separate struct device objects and so they each have a
> > > directory in sysfs, right?
> > >
> >
> > Yes, they do have separate directories and if using device_set_pm_not_required
> > on the child it will make it clearer which device is PM runtime regulated, so
> > I guess that is what should be done.
> >
> > I think it all depends on where in sysfs the user accesses the device from. My
> > point with these patches is that the iio_device may be perceived to be an
> > iio device that should be possible to manually power control, as the power
> > directory is visble. If looking at it from here:
> >
> > ~# ls /sys/bus/iio/devices/iio:device0/
> > in_illuminance_raw      in_proximity_raw        power
> > in_illuminance_scale    name                    subsystem
> > in_proximity_nearlevel  of_node                 uevent
> >
> > my idea is to let this power directory inherity the parent power control. But
> > as you say, it is probably better to not create it at all, as the actual manual
> > power control can be done here:
> >
> > ~# ls /sys/devices/platform/soc/.../i2c-2/2-0060/
> > driver       modalias     of_node      subsystem
> > iio:device1  name         power        uevent
> >
> > where it is more clear which device (the i2c parent) that can be power
> > controlled.
> >
> > > > Add a function to synchronize the runtime PM enable state of a device
> > > > with its parent. As there already exists a link from the child to its
> > > > parent and both are enabled, all sysfs control/monitoring can reflect
> > > > both devices, which from a userspace perspective makes more sense.
> > >
> > > Except that user space will be able to change "control" to "on" for
> > > the parent alone AFAICS which still will be confusing.
> >
> > Yes, that is true.
> > >
> > > For devices that are pure software constructs it only makes sense to
> > > expose the PM-runtime interface for them if the plan is to indirectly
> > > control the parent's runtime PM through them.
> >
> > I will abandon this patchset and send a single patch for the iio device.
>
> I entirely agree with the statement that these are pointless and should not
> be exposed.  However I don't want to see a per device tweak.  If we get
> rid of these, we get rid of them for all of the iio:device0/
> devices (and the various other types of device IIO uses).
>
> The risk here is that, although pointless, some userspace is relying on the
> ABI in sysfs.  Do people thing it's worth the gamble of getting rid
> of this non functioning interface for the whole of IIO?

I think so.

It is better to avoid exposing garbage to user space even if the scope
of it is limited IMV.

> So far I think this is only been done for a few similar cases
> and for new subsystems.
