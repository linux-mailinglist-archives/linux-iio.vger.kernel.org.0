Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08FD1F5B24
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 20:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgFJS2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFJS2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 14:28:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F5C03E96B;
        Wed, 10 Jun 2020 11:28:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so1274143plt.5;
        Wed, 10 Jun 2020 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+iXoivd5hMScfZeurzIUNXkcUnOic8qwUzMxWu7w2U=;
        b=sEaIbR0Cr/eLOEYio7dXQ3e1guSp15xzUraPzd/jVesFJu3tCzIxvK3j0E7MlBsbOM
         gksSkRr+OiiIw0iV3EKo1XZSAEAOSSV9+2SCCntOC0FVA7TEVgYcmbK46vFjQa3Q7wx3
         KlatPS4xMyQiY0JyqxLGuQZI2ImWfgKQKmQDQlrizcfyloEDllejT/biAdoa6kQf43nV
         q6FnxNCxQzJ+XGQdfWV2IyDlbGrKisqeh+U8RW6vO/rDIKOoaeVosl0oXuZTRwKKdKQi
         kRF8mevg8ekryOts47CMXkpzt0CbaxOq2UT9Ck23WREqf7/oUqh8DuBziQRysxuzdy8N
         qEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+iXoivd5hMScfZeurzIUNXkcUnOic8qwUzMxWu7w2U=;
        b=AFsYoqmoUVCPR5lgXPscECYmAqFmdxhFAHOVpvbDliaVEFva50RoXzLlbV838mIOnI
         vsRQz23/mziiz8kSAsm3LJAoa0IC3l4BhxGRFDGFnjK9oc1SNzLyf2CcdCMk+U2VxTu3
         gl762OUaWv5uyFFFrnkEosTNkmjRJlbAxtdSoLWWD1e5/4VCUVaiA98oqy4N44SkhvUy
         3G0B6DlUALfiXs3zyiRFgUF5j8cRQtjnpWSY2DxU14tCQNQpTEW6CYTJ8xKWhW1bi6+x
         Lrd927D8LLBpGYpzWfhX+VnhrFPm6Gfvfkn80Zwb6k8gfuay8mknjhDSbryeva/gnrPb
         4RxQ==
X-Gm-Message-State: AOAM533CNR+dXKLCLS8kNIAbPzg4rIzh5dIjBE5upAN3f9bNv8rGWSTK
        JSu9VusL5xTY9cBbsQv+nHM=
X-Google-Smtp-Source: ABdhPJwATkO2n20nNol3mvOSQmdAsq5ulJM1g+IU9cvr25sSyGY/QmEogkwppaZy8z1xiGbG5iD6og==
X-Received: by 2002:a17:90a:6047:: with SMTP id h7mr4173081pjm.145.1591813720143;
        Wed, 10 Jun 2020 11:28:40 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id f14sm463546pgj.62.2020.06.10.11.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:28:39 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:28:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
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
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
Message-ID: <20200610182836.GA248110@dtor-ws>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
 <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 10, 2020 at 12:38:30PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi All,
> >
> > On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
> > > This is a quick respin of v3, with just two small changes, please see
> > > the changelog below.
> > >
> > > Userspace might want to implement a policy to temporarily disregard input
> > > from certain devices.
> > >
> > > An example use case is a convertible laptop, whose keyboard can be folded
> > > under the screen to create tablet-like experience. The user then must hold
> > > the laptop in such a way that it is difficult to avoid pressing the keyboard
> > > keys. It is therefore desirable to temporarily disregard input from the
> > > keyboard, until it is folded back. This obviously is a policy which should
> > > be kept out of the kernel, but the kernel must provide suitable means to
> > > implement such a policy.
> >
> > First of all sorry to start a somewhat new discussion about this
> > while this patch set is also somewhat far along in the review process,
> > but I believe what I discuss below needs to be taken into account.
> >
> > Yesterday I have been looking into why an Asus T101HA would not stay
> > suspended when the LID is closed. The cause is that the USB HID multi-touch
> > touchpad in the base of the device starts sending events when the screen
> > gets close to the touchpad (so when the LID is fully closed) and these
> > events are causing a wakeup from suspend. HID multi-touch devices
> > do have a way to tell them to fully stop sending events, also disabling
> > the USB remote wakeup the device is doing. The question is when to tell
> > it to not send events though ...
> >
> > So now I've been thinking about how to fix this and I believe that there
> > is some interaction between this problem and this patch-set.
> >
> > The problem I'm seeing on the T101HA is about wakeups, so the question
> > which I want to discuss is:
> >
> > 1. How does inhibiting interact with enabling /
> > disabling the device as a wakeup source ?

One should not affect the other.

> >
> > 2. Since we have now made inhibiting equal open/close how does open/close
> > interact with a device being a wakeup source ?

One did not affect another, and it should not.

> >
> > And my own initial (to be discussed) answers to these questions:
> >
> > 1. It seems to me that when a device is inhibited it should not be a
> > wakeup source, so where possible a input-device-driver should disable
> > a device's wakeup capabilities on suspend if inhibited
> 
> If "inhibit" means "do not generate any events going forward", then
> this must also cover wakeup events, so I agree.

Why? These are separate concepts. Do we disable wake on lan when
bringing network interface down? Do we update power/wakeup when device
is inhibited? Do we restore it afterwards? Do we un-inhibit if we
reenable wakeup after device is inhibited? Do we return error? How?

Inhibit works on logical level, i.e. if I have several input interfaces
on the same hardware device, I cam inhibit one leaving others intact.
This does not mean that the device should stop generating wakeup events.
We can't even guarantee this for composite devices.

> 
> > 2. This one is trickier I don't think we have really clearly specified
> > any behavior here. The default behavior of most drivers seems to be
> > using something like this in their suspend callback:
> >
> >          if (device_may_wakeup(dev))
> >                  enable_irq_wake(data->irq);
> >          else if (input->users)
> >                  foo_stop_receiving_events(data);
> >
> > Since this is what most drivers seem to do I believe we should keep
> > this as is and that we should just clearly document that if the
> > input_device has users (has been opened) or not does not matter
> > for its wakeup behavior.
> >
> > Combining these 2 answers leads to this new pseudo code template
> > for an input-device's suspend method:
> >
> >         /*
> >          * If inhibited we have already disabled events and
> >          * we do NOT want to setup the device as wake source.
> >          */
> >         if (input->inhibited)
> >                 return 0;
> >
> >          if (device_may_wakeup(dev))
> >                  enable_irq_wake(data->irq);
> >          else if (input->users)
> >                  foo_stop_receiving_events(data);
> >
> > ###
> 
> Sounds reasonable to me.

However it will not work. For many input devices connected to i2c we
declare interrupt as wakeup interrupt, and the driver does not need to
issue enable_irq_wake() and disable_irq_wake(). The wakeup handling is
happening in driver core, which is not aware of input-specific inhibit
(nor should it be).

I need to ping Mark about the patch adding the similar handling to SPI.

> 
> > A different, but related issue is how to make devices actually use the
> > new inhibit support on the builtin keyboard + touchpad when say the lid
> > is closed.   Arguably this is an userspace problem, but it is a tricky
> > one. Currently on most modern Linux distributions suspend-on-lid-close
> > is handled by systemd-logind and most modern desktop-environments are
> > happy to have logind handle this for them.
> >
> > But most knowledge about input devices and e.g. heurisitics to decide
> > if a touchpad is internal or external are part of libinput. Now we could
> > have libinput use the new inhibit support (1), but then when the lid
> > closes we get race between whatever process is using libinput trying
> > to inhibit the touchpad (which must be done before to suspend to disable
> > it as wakeup source) and logind trying to suspend the system.
> >
> > One solution here would be to move the setting of the inhibit sysfs
> > attr into logind, but that requires adding a whole bunch of extra
> > knowledge to logind which does not really belong there IMHO.

You do not need to push the knowledge into logind, you just need to
communicate to logind what devices can be wakeup sources and which ones
should not. Chrome OS uses udev tags/properties for that.

> >
> > I've been thinking a bit about this and to me it seems that the kernel
> > is in the ideal position to automatically inhibit some devices when
> > some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
> > issue here is to chose on which devices to enable this. I believe
> > that the auto inhibit on some switches mechanism is best done inside
> > the kernel (disabled by default) and then we can have a sysfs
> > attr called auto_inhibit_ev_sw_mask which can be set to e.g.
> > (1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
> > the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
> > inhibit both when the lid is closed or when switched to tablet mode.

This is a policy and should be kept out of the kernel. Yes, we had it
implemented with rfkill input handler, but it caused quite a few issues.
As far as I know it is not being used anymore and we should not try with
SW_LID->inhibit either.

I know it is faster to patch the kernel than to roll out proper
userspace because everyone updates kernel regularly, but it does not
mean it is the right solution.

Thanks.

-- 
Dmitry
