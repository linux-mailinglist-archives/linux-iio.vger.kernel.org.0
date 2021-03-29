Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379034D206
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhC2OBd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhC2OBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Mar 2021 10:01:30 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04130C061762
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 07:01:24 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e1so3986501uaa.4
        for <linux-iio@vger.kernel.org>; Mon, 29 Mar 2021 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AT9yXdVTy28rDSzvDHRuhQBbOkcZIrA+Kd92T2dBm9Q=;
        b=Rwqz31L8M2HDUkrxCK94yIhL9Ix7dJC2s6RZlqX3QNwdDcGEZ5t7hu8Ux9KFXIDBW+
         vFuHya7yW+Z3tNAyWLJYg4h3cMJKRCj3cLk58blME6VKVTZZrfGVDsZZZN6bXNyQB/wm
         bk5srKwZ0P4uvMwoRb/5cS3cfMTpCnFhT7N2r/+8e8qNJL5mrr4Nx9djveT7Tbp10WPu
         vQt8uMWwpxkCaKueS1AD4VHw4/xsRSw+qDVlFX1mCM+2Qe3FWhvleSEhDBES+kS0wIeA
         sK5hruS/7s1BcepWMuoS5SuIThhYTRZ4lgJ5uEwGqdRrYQxnPOffKwcXfLAOMv6xW4Bb
         fasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AT9yXdVTy28rDSzvDHRuhQBbOkcZIrA+Kd92T2dBm9Q=;
        b=hSnLIpfWmVxkmKCsL9FJaHE5yo/9tVY7OWWch5lQkt4KHNVyHZklErTBRdR4bohhXj
         Z433SSJj8kyldmmIlkBrf4m/BgMyBA37cNXwG2d2ANVoXJXFCXHpD894cq48t/n5nD08
         GI0s7JmO1ceecrD3yfWSxSRGUykvlpuVWpAofov7dkJeoxViEH+k+QVWUuvuSOqhRs1f
         TwFtuddLGmakfxnmWPE4iSAbf2H2tvs0UNqQ8hCVntwNSlUnfhOGzmFtrxJJUbfU8fUv
         ypHcL1FFanNUX4H8ghRmocIktUn+QJ4lhIJEk7NMHXnftmgmCMPjTeolxaobO6bU+rgS
         CW2A==
X-Gm-Message-State: AOAM5312LrdlUnxV1Ype02enZGercA55RDp2ZOju0eNvo7G5pHf9QJM/
        COWXM9ByVf5hLyYQVGi6AItbty500XxgT1iI3UgT/YNSnhFONMiJ
X-Google-Smtp-Source: ABdhPJwuZmO9s3YPrE9jz/xRCpn8Lj87m/i7xfqnaQuJTJ2GL+3UQ11JKwtfs8fMT1K/zc/K1F7/GGp7WE5NorsVh38=
X-Received: by 2002:ab0:596f:: with SMTP id o44mr14416273uad.8.1617026483993;
 Mon, 29 Mar 2021 07:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210324125548.45983-1-aardelean@deviqon.com> <20210329133824.1a1fad6f@jic23-huawei>
In-Reply-To: <20210329133824.1a1fad6f@jic23-huawei>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 29 Mar 2021 17:01:13 +0300
Message-ID: <CAASAkoYnMW0quqZsxLf8yOzS-nPjBv4jxu_kbk5nKfXpq3w+6A@mail.gmail.com>
Subject: Re: [PATCH 00/10] platform/x86: toshiba_acpi: move acpi add/remove to
 device-managed routines
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, coproscefalo@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, linux@deviqon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Mar 2021 at 15:38, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 24 Mar 2021 14:55:38 +0200
> Alexandru Ardelean <aardelean@deviqon.com> wrote:
>
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
> hmm. I am dubious about 'removing' the support for non devm_ in the long
> run because it can lead to requiring fiddly changes in existing drivers
> (like this one :) and I don't want to put that barrier in front of anyone
> using IIO.

Yeah.
I also feel that the current driver is a bit fiddly.
I was undecided [when doing the series], whether to send it as a
whole, or start with sending just a few patches that make sense on
their own.

I might go via the second route and send these individually.

>
> However, I'm more than happy to see them used in very few drivers and
> nice warning text added to suggest people might want to look at whether
> then can move to a device managed probe flow
>
> Jonathan
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
