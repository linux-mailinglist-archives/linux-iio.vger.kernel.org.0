Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5B626A2D
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiKLPWi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiKLPWT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 10:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7612614;
        Sat, 12 Nov 2022 07:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC78E60BC3;
        Sat, 12 Nov 2022 15:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8924AC433C1;
        Sat, 12 Nov 2022 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668266505;
        bh=xo3EHRec9A1GmMJgPnOWDksPDnPRnfB44FykxN/VlR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pze6t6n8v/OJPAaHhPKGb2711j3B2YV8n+w+QBr9I+pGZv/rocfHsluWajAXay7Ev
         VNoqyLQ99yNrwZDf1HT2JJ95j6GkYSiqkdULk1shrxP+yTP/95gst8FA3wnHaO6rkV
         pJgaty22k5bxwDxfE+yG8dmzqGokfwTNnDJKZh4OipndmK/XFvRO3r/h+2pU/QxQOi
         qp7b38HhunR4kFm61RnyvVHrIaJ6YO7HHs3B+nrvLrI3npVuu7+Ccr3x+9/3mB3beA
         XU5Qw7zzXVYHXjVeUxiNJ8kmRVkztC/TzcMXMw0Xw9mz+tov+LViX+DUVx/m11Yoor
         1wvoNy+TNx2SA==
Date:   Sat, 12 Nov 2022 15:33:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marten Lindahl <martenli@axis.com>,
        =?UTF-8?B?TcOlcnRlbg==?= Lindahl <Marten.Lindahl@axis.com>,
        Pavel Machek <pavel@ucw.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH 1/2] PM: runtime: Synchronize PM runtime enable state
 with parent
Message-ID: <20221112153358.52939022@jic23-huawei>
In-Reply-To: <CAJZ5v0hdAkk_GNA5xhaTA0UGb8keJQK9i3UaVgfnc7233nbm8g@mail.gmail.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
        <20220929144618.1086985-2-marten.lindahl@axis.com>
        <CAJZ5v0jhk8tGw9iak+BKr=3AUG5iPdn+0_KnmToDLji1ttV7hA@mail.gmail.com>
        <Y1/8Z/Ibqc3B21Tg@axis.com>
        <20221106153315.64952dd3@jic23-huawei>
        <CAJZ5v0hdAkk_GNA5xhaTA0UGb8keJQK9i3UaVgfnc7233nbm8g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 6 Nov 2022 18:16:10 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Sun, Nov 6, 2022 at 4:33 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 31 Oct 2022 17:48:39 +0100
> > Marten Lindahl <martenli@axis.com> wrote:
> > =20
> > > On Tue, Oct 25, 2022 at 06:20:10PM +0200, Rafael J. Wysocki wrote: =20
> > > > On Thu, Sep 29, 2022 at 4:46 PM M=C3=A5rten Lindahl <marten.lindahl=
@axis.com> wrote: =20
> > >
> > > Hi! Thanks for your feedback!
> > > =20
> > > > >
> > > > > A device that creates a child character device with cdev_device_a=
dd by
> > > > > default create a PM sysfs group with power attributes for userspa=
ce
> > > > > control. This means that the power attributes monitors the child =
device
> > > > > only and thus does not reflect the parent device PM runtime behav=
ior. =20
> > > >
> > > > It looks like device_set_pm_not_required() should be used on the ch=
ild then.
> > > > =20
> > > > > But as the PM runtime framework (rpm_suspend/rpm_resume) operates=
 not
> > > > > only on a single device that has been enabled for runtime PM, but=
 also
> > > > > on its parent, it should be possible to synchronize the child and=
 the
> > > > > parent so that the power attribute monitoring reflects the child =
and the
> > > > > parent as one.
> > > > >
> > > > > As an example, if an i2c_client device registers an iio_device, t=
he
> > > > > iio_device will create sysfs power/attribute nodes for userspace
> > > > > control. But if the dev_pm_ops with resume/suspend callbacks is a=
ttached
> > > > > to the struct i2c_driver.driver.pm, the PM runtime needs to be en=
abled
> > > > > for the i2c_client device and not for the child iio_device.
> > > > >
> > > > > In this case PM runtime can be enabled for the i2c_client device =
and
> > > > > suspend/resume callbacks will be triggered, but the child sysfs p=
ower
> > > > > attributes will be visible but marked as 'unsupported' and can no=
t be
> > > > > used for control or monitoring. This can be confusing as the sysfs
> > > > > device node presents the i2c_client and the iio_device as one dev=
ice. =20
> > > >
> > > > I don't quite understand the last sentence.
> > > >
> > > > They are separate struct device objects and so they each have a
> > > > directory in sysfs, right?
> > > > =20
> > >
> > > Yes, they do have separate directories and if using device_set_pm_not=
_required
> > > on the child it will make it clearer which device is PM runtime regul=
ated, so
> > > I guess that is what should be done.
> > >
> > > I think it all depends on where in sysfs the user accesses the device=
 from. My
> > > point with these patches is that the iio_device may be perceived to b=
e an
> > > iio device that should be possible to manually power control, as the =
power
> > > directory is visble. If looking at it from here:
> > >
> > > ~# ls /sys/bus/iio/devices/iio:device0/
> > > in_illuminance_raw      in_proximity_raw        power
> > > in_illuminance_scale    name                    subsystem
> > > in_proximity_nearlevel  of_node                 uevent
> > >
> > > my idea is to let this power directory inherity the parent power cont=
rol. But
> > > as you say, it is probably better to not create it at all, as the act=
ual manual
> > > power control can be done here:
> > >
> > > ~# ls /sys/devices/platform/soc/.../i2c-2/2-0060/
> > > driver       modalias     of_node      subsystem
> > > iio:device1  name         power        uevent
> > >
> > > where it is more clear which device (the i2c parent) that can be power
> > > controlled.
> > > =20
> > > > > Add a function to synchronize the runtime PM enable state of a de=
vice
> > > > > with its parent. As there already exists a link from the child to=
 its
> > > > > parent and both are enabled, all sysfs control/monitoring can ref=
lect
> > > > > both devices, which from a userspace perspective makes more sense=
. =20
> > > >
> > > > Except that user space will be able to change "control" to "on" for
> > > > the parent alone AFAICS which still will be confusing. =20
> > >
> > > Yes, that is true. =20
> > > >
> > > > For devices that are pure software constructs it only makes sense to
> > > > expose the PM-runtime interface for them if the plan is to indirect=
ly
> > > > control the parent's runtime PM through them. =20
> > >
> > > I will abandon this patchset and send a single patch for the iio devi=
ce. =20
> >
> > I entirely agree with the statement that these are pointless and should=
 not
> > be exposed.  However I don't want to see a per device tweak.  If we get
> > rid of these, we get rid of them for all of the iio:device0/
> > devices (and the various other types of device IIO uses).
> >
> > The risk here is that, although pointless, some userspace is relying on=
 the
> > ABI in sysfs.  Do people thing it's worth the gamble of getting rid
> > of this non functioning interface for the whole of IIO? =20
>=20
> I think so.
>=20
> It is better to avoid exposing garbage to user space even if the scope
> of it is limited IMV.

Marten, do you want to spin a patch doing this in the iio core?

If not I'll do so sometime soon.  Given where we are in the cycle,
and the need to keep such a patch up for review for at least a few weeks,
we can look to get it into next early next cycle and hopefully any issues
will become apparent.

Jonathan

>=20
> > So far I think this is only been done for a few similar cases
> > and for new subsystems. =20

