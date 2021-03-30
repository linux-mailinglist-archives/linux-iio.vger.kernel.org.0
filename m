Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1634E432
	for <lists+linux-iio@lfdr.de>; Tue, 30 Mar 2021 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhC3JWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhC3JWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Mar 2021 05:22:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF78C061762;
        Tue, 30 Mar 2021 02:22:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u2so13631275ilk.1;
        Tue, 30 Mar 2021 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVl6dx7e0oWpG+IolS4wAAwf1DWhXCYxl3+7BE4Yhzw=;
        b=FwbX1h28kR45mojqnBesa55JLZzdeBdBI9HVBxDCBEPHooYF/sv2J7ZM61+yZtTERp
         2N9A85IU04ASBmgdWDlHSkXj3ovORSV0wbGjPSYevDRGBmSgySJLvNyd4HJ252KG/ZpH
         RN1/iXx9yNg9LCj6h+oZCIzRXKWr2aWa6HY5mlRzSQVvtldGBHrdhQc01w/wU/vcLe5H
         kHbXNS1Zd4ri7LQlZUO7rI8Ar3PvbJ8ATbNLFzbuCdz5miSxnSNao2qhXo/X7apo7Vyg
         xmwcOq7+xi3ajJyjEkvDHTNBYWaDiiqYEsscuaZKygCKvmKl7DUsZ4dFBxiVWVxU3UBC
         mbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVl6dx7e0oWpG+IolS4wAAwf1DWhXCYxl3+7BE4Yhzw=;
        b=fRfLQiHW/bJD/Kt9yKFX8QubQc6YsQND4se4XJjhbsjWVfNt5LMJpkkhOY/z7Eb+Pu
         TmnYR61PcfMl3bGlIhQ8kkysmTNiqvDr9XtmHNYb+h7ClSFFp6yJ7LPYrtTGMYZxtQ0X
         W0i3WdpskLRJUqobxKfNSYzw40c7bp3EdXve9ssE7Gx0sD7tJ306EKJDR7i+sr9ItA20
         xrwHjOuJW4f9JneqArfl7wscS3FvQc/dVDAKk7XQx+CZLEU4QFqQqzitME/tEN4RnRr6
         uN0O0G5nkDJTDsWEhnRT/vUKI69LvChWBRSRDzcchnXcb/52LqFzWRMR2AoLTjfu7y6x
         fXLQ==
X-Gm-Message-State: AOAM531ryVc4/fgS6l5Lqq3lblV/gkVaE5PnHgOS9a5Hp59z4vwu8KEI
        nx77Z4eNfCNO7fPn1t0DbrMWc4XxGbPhDmTPBDDAmtWglV0U9Q==
X-Google-Smtp-Source: ABdhPJzejqWOcg/kAUltYAckQtYAfVQeRtSS4Y2xiICNZ+H2doCXqxZh5LnQSKXwPCIm9q5XiM4PxHHaB9HnqmxlyV4=
X-Received: by 2002:a92:c244:: with SMTP id k4mr6816668ilo.303.1617096135961;
 Tue, 30 Mar 2021 02:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210324125548.45983-1-aardelean@deviqon.com> <0fba6355-aaec-b214-cf12-1add08cfca38@redhat.com>
In-Reply-To: <0fba6355-aaec-b214-cf12-1add08cfca38@redhat.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 30 Mar 2021 12:22:04 +0300
Message-ID: <CA+U=Dsq-YDBzSEsRBsTOkzf=1yyfB4esTJMvc6rKWTPff=i1TQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] platform/x86: toshiba_acpi: move acpi add/remove to
 device-managed routines
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>, coproscefalo@gmail.com,
        mgross@linux.intel.com, Jonathan Cameron <jic23@kernel.org>,
        linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 30, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Alexadru, Jonathan,
>
> On 3/24/21 1:55 PM, Alexandru Ardelean wrote:
> > This changeset tries to do a conversion of the toshiba_acpi driver to use
> > only device-managed routines. The driver registers as a singleton, so no
> > more than one device can be registered at a time.
> >
> > My main intent here is to try to convert the iio_device_alloc() and
> > iio_device_register() to their devm_ variants.
> >
> > Usually, when converting a registration call to device-managed variant, the
> > init order must be preserved. And the deregistration order must be a mirror
> > of the registration (in reverse order).
> >
> > This change tries to do that, by using devm_ variants where available and
> > devm_add_action_or_reset() where this isn't possible.
> > Some deregistration ordering is changed, because it wasn't exactly
> > mirroring (in reverse) the init order.
> >
> > For the IIO subsystem, the toshiba_acpi driver is the only user of
> > iio_device_alloc(). If this changeset is accepted (after discussion), I
> > will propose to remove the iio_device_alloc() function.
> >
> > While I admit this may look like an overzealous effort to use devm_
> > everywhere (in IIO at least), for me it's a fun/interesting excercise.
>
> Alexadru, thank you for the patches.
>
> Jonathan, thank you for the reviews.
>
> To be honest I'm currently inclined to not accept / merge these patches,
> this is based on 2 assumptions from me, which might be wrong. let me explain.
>
> If I understand things correctly, the main reason for this rework of
> the toshiba_acpi code is to move iio_device_alloc() and iio_device_register()
> to their devm_ variants, converting the last users in the tree ?

yes
well, we still have plenty of users iio_device_alloc() /
iio_device_register() inside drivers/iio

but the toshipa_acpi driver is the more quirky user of these functions
[treewide]

i wanted to jump on those simpler IIO cases, but i thought i would
leave those to new contributors [for a while];
the complexity of those conversions is good enough to get some people
started to contribute changes that are a bit more useful than
checkpatch fixes, comment fixes [etc];

[personally] i feel that these devm_ conversions are complex enough to
maybe get people wanting to dig more into some kernel design stuff

>
> This would allow these 2 iio functions to then be e.g. marked as static /
> private helpers inside the iio core, so that all new users can only use
> the devm_ versions. But if I'm reading Jonathan's reaction correctly then
> Jonathan is not planning to do that because they might still be useful
> in some cases.
>
> Jonathan have I correctly understood that you don't plan to make any
> changes to the iio_device_alloc() and iio_device_register() functions
> even if this gets merged ?
>
> Which brings me to my next assumption, Alexandru, I don't read anything
> about testing anywhere. So I'm currently under the assumption that
> you don't have any hardware using the toshiba_acpi driver and that this
> is thus untested ?

yes, i don't have any hw to test this

>
> The not being tested state is my main reason for not wanting to merge
> this. The toshiba_acpi driver likely does not have a whole lot of users,
> so the chances of someone running release candidates or even just the
> latest kernels on hardware which uses it are small.  This means that if
> we accidentally introduce a bug with this series it might not get caught
> until say lots of people start upgrading to Ubuntu 22.04 which is
> the first Ubuntu kernel with your changes; and then at least one of the
> hit users needs to have the skills to find us and get in contact about that.
>
> TL;DR: we might break stuff and if we do it might be a long time until we
> find out we did and then we have been shipping broken code for ages...

ack
well, i don't insist in pushing this series;

another thought was to just send bits of this set, which are simple
enough to consider even on their own;

maybe i'll look for a toshiba laptop with support for this stuff;
i'll see

thanks :)
Alex

>
> Regards,
>
> Hans
>
>
>
>
>
> >
> > Alexandru Ardelean (10):
> >   platform/x86: toshiba_acpi: bind life-time of toshiba_acpi_dev to
> >     parent
> >   platform/x86: toshiba_acpi: use devm_add_action_or_reset() for
> >     singleton clear
> >   platform/x86: toshiba_acpi: bind registration of miscdev object to
> >     parent
> >   platform/x86: toshiba_acpi: use device-managed functions for input
> >     device
> >   platform/x86: toshiba_acpi: register backlight with device-managed
> >     variant
> >   platform/x86: toshiba_acpi: use devm_led_classdev_register() for LEDs
> >   platform/x86: toshiba_acpi: use device-managed functions for
> >     accelerometer
> >   platform/x86: toshiba_acpi: use device-managed for wwan_rfkill
> >     management
> >   platform/x86: toshiba_acpi: use device-managed for sysfs removal
> >   platform/x86: toshiba_acpi: bind proc entries creation to parent
> >
> >  drivers/platform/x86/toshiba_acpi.c | 249 +++++++++++++++++-----------
> >  1 file changed, 150 insertions(+), 99 deletions(-)
> >
>
