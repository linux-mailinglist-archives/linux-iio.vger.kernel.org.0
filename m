Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6114F1F527E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFJKip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 06:38:45 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:46008 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgFJKio (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 06:38:44 -0400
Received: by mail-oo1-f66.google.com with SMTP id k7so381743ooo.12;
        Wed, 10 Jun 2020 03:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhj0O7kXqY+B3Lbx8zL7czuREuKE1xDVmkNkh9W0Ff8=;
        b=BU24NqxValo/t5E9HveQinLgNcLH0DDjrUCw6bXH35NoScXxOArJddEDrkUVanE2C2
         YIB4UolTJuFCOidWQiDYNt1XjkN5+irEaOgq48VJ8uYKTavD6rFj2lBUEQ2I/60MwuUP
         iMeOWFUU9obrB9VMSGBJrqA7DBiySjzOpJ/FmydghJCgbR+TB1LCT7FuBTcwtCoB0EA5
         r+MIVTZL9srq4vvf7ixA8EHDbg7q5tmD6C+3B3nPzTTHfiQ9ZGKibEyxdjOUlNr33qlt
         vNLab4NGYFfyeTNOxIb60a1H91DHQ9l7eDn9KCk39wpVQOh6fDJDwzoxL+5BjD1PZqvg
         BrmQ==
X-Gm-Message-State: AOAM531LMKx73UliXLrvY1IcCp3QlcqAW7Y50nJobpXhlT/tZn8wmWaA
        vfukiz74WrK4XVqr4wnZBkq3ZRnGg0DxFUvC9C3H5Q==
X-Google-Smtp-Source: ABdhPJxAdTpO7LhYnf0dQcSTZJQHhIdlLN/4PFslP7TgkSlriS32Yc+I7+BmEpE6ZYiAWqbF26joucvNTE5ZFDcQo+M=
X-Received: by 2002:a4a:3c1a:: with SMTP id d26mr1875366ooa.38.1591785522478;
 Wed, 10 Jun 2020 03:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com> <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
In-Reply-To: <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Jun 2020 12:38:30 +0200
Message-ID: <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi All,
>
> On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
> > This is a quick respin of v3, with just two small changes, please see
> > the changelog below.
> >
> > Userspace might want to implement a policy to temporarily disregard input
> > from certain devices.
> >
> > An example use case is a convertible laptop, whose keyboard can be folded
> > under the screen to create tablet-like experience. The user then must hold
> > the laptop in such a way that it is difficult to avoid pressing the keyboard
> > keys. It is therefore desirable to temporarily disregard input from the
> > keyboard, until it is folded back. This obviously is a policy which should
> > be kept out of the kernel, but the kernel must provide suitable means to
> > implement such a policy.
>
> First of all sorry to start a somewhat new discussion about this
> while this patch set is also somewhat far along in the review process,
> but I believe what I discuss below needs to be taken into account.
>
> Yesterday I have been looking into why an Asus T101HA would not stay
> suspended when the LID is closed. The cause is that the USB HID multi-touch
> touchpad in the base of the device starts sending events when the screen
> gets close to the touchpad (so when the LID is fully closed) and these
> events are causing a wakeup from suspend. HID multi-touch devices
> do have a way to tell them to fully stop sending events, also disabling
> the USB remote wakeup the device is doing. The question is when to tell
> it to not send events though ...
>
> So now I've been thinking about how to fix this and I believe that there
> is some interaction between this problem and this patch-set.
>
> The problem I'm seeing on the T101HA is about wakeups, so the question
> which I want to discuss is:
>
> 1. How does inhibiting interact with enabling /
> disabling the device as a wakeup source ?
>
> 2. Since we have now made inhibiting equal open/close how does open/close
> interact with a device being a wakeup source ?
>
> And my own initial (to be discussed) answers to these questions:
>
> 1. It seems to me that when a device is inhibited it should not be a
> wakeup source, so where possible a input-device-driver should disable
> a device's wakeup capabilities on suspend if inhibited

If "inhibit" means "do not generate any events going forward", then
this must also cover wakeup events, so I agree.

> 2. This one is trickier I don't think we have really clearly specified
> any behavior here. The default behavior of most drivers seems to be
> using something like this in their suspend callback:
>
>          if (device_may_wakeup(dev))
>                  enable_irq_wake(data->irq);
>          else if (input->users)
>                  foo_stop_receiving_events(data);
>
> Since this is what most drivers seem to do I believe we should keep
> this as is and that we should just clearly document that if the
> input_device has users (has been opened) or not does not matter
> for its wakeup behavior.
>
> Combining these 2 answers leads to this new pseudo code template
> for an input-device's suspend method:
>
>         /*
>          * If inhibited we have already disabled events and
>          * we do NOT want to setup the device as wake source.
>          */
>         if (input->inhibited)
>                 return 0;
>
>          if (device_may_wakeup(dev))
>                  enable_irq_wake(data->irq);
>          else if (input->users)
>                  foo_stop_receiving_events(data);
>
> ###

Sounds reasonable to me.

> A different, but related issue is how to make devices actually use the
> new inhibit support on the builtin keyboard + touchpad when say the lid
> is closed.   Arguably this is an userspace problem, but it is a tricky
> one. Currently on most modern Linux distributions suspend-on-lid-close
> is handled by systemd-logind and most modern desktop-environments are
> happy to have logind handle this for them.
>
> But most knowledge about input devices and e.g. heurisitics to decide
> if a touchpad is internal or external are part of libinput. Now we could
> have libinput use the new inhibit support (1), but then when the lid
> closes we get race between whatever process is using libinput trying
> to inhibit the touchpad (which must be done before to suspend to disable
> it as wakeup source) and logind trying to suspend the system.
>
> One solution here would be to move the setting of the inhibit sysfs
> attr into logind, but that requires adding a whole bunch of extra
> knowledge to logind which does not really belong there IMHO.
>
> I've been thinking a bit about this and to me it seems that the kernel
> is in the ideal position to automatically inhibit some devices when
> some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
> issue here is to chose on which devices to enable this. I believe
> that the auto inhibit on some switches mechanism is best done inside
> the kernel (disabled by default) and then we can have a sysfs
> attr called auto_inhibit_ev_sw_mask which can be set to e.g.
> (1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
> the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
> inhibit both when the lid is closed or when switched to tablet mode.

I agree that the kernel is the right place to handle this, but it
requires some extra knowledge about dependencies between devices.

It'd be kind of like power resources in ACPI, so for each state of a
"master" device (in principle, there may be more states of it than
just two) there would be a list of "dependent" intput devices that
need to be inhibited when the "master" device goes into that state.

> This could then be combined with a userspace utility run from an
> udev rule which makes the actual decision what auto_inhibit_ev_sw_mask
> should be set for a given input device.
>
> This will put the mechanism for what we want inside the kernel and
> leaves the policy on which switches we want this for out of the
> kernel.
>
> Note adding this new auto_inhibit_ev_sw_mask sysfs attr falls
> somewhat outside the context of this patchset and could be done
> as a follow up to this patch-set. But I do believe that we need to
> figure out how (non ChromeOS) userspace can / will use the new inhibit
> interface before merging it.
