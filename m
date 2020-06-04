Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0071EDE15
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jun 2020 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFDH3A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Jun 2020 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDH27 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jun 2020 03:28:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E1C05BD1E;
        Thu,  4 Jun 2020 00:28:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so778289pjb.0;
        Thu, 04 Jun 2020 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cO/oadY0dSYawTqKBBOtZELNdMv+BYwXLtOmaeKt1Sg=;
        b=mSZGbtpdbn+bP4nMMb1tDxin4WAkP+gyVx0KGCmSbOIb2Zuo48tqPsbaZgZkX7wjUx
         jV+dC6iU4rAWGaNMNS123cBBjbN3uCcsrVVNLRo+nMZIeV/9ANOLn8Ke6L7XFZ5kaBM/
         z8qkBvmD7DtoCtFyd6eh/3t6LFAQMwqMnWpTRo/c+x8mTusmYLExEpR0cYqPGVBYDjLe
         dSjkiPZtf8kQKjMPN8q+Q9BZFBcgrom4XSu9FrzdtDSMlsvZqEwG94OArztfsA7ZQ7Ni
         mS+TfnhlkryWeFj1wtdJoqqqxt4uvNd9O1RqEh2uaT0skrLWcurMXwr1noiuEYqDlDJH
         c1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cO/oadY0dSYawTqKBBOtZELNdMv+BYwXLtOmaeKt1Sg=;
        b=Zxs8EULPc1sQeXrNqIgvj97KoivmvMXPdDtn+jvafkfpR76zcusYguenPcZjP6s/8U
         6Ji0ej3OxPLuKm0ulWfc0FimWjZOwR7T1F05upmyS5FsWirt2z6RO2Tf9FU0Clltgoza
         5DltB8S4qyN0VpAwPBL7L3zdFtNyrXITiHjwweVslwfH4I9yjYxpQOiS5kbGdcQfCRPI
         Kn6DWPFMYF+haEmsxDyAVirc10Bpbm4CCbIZYVompa/a/GtTbgO9Wltt8It7mxZbaA7l
         xJo/n2oMgEioVtoQhvrDQ4G8Lar7VbKZRmhaP0EjLHuVjGcY29l8pA9oNjX2CS+TAptW
         znHw==
X-Gm-Message-State: AOAM533Qkc0HY7Srj1pRqTTBS63+o5ehgX41hcESZ3wC9ap2GDevC0GO
        mf5YCVzbbZ25zhO2XJMenqA=
X-Google-Smtp-Source: ABdhPJyqLLuYWne+m1xT0qat0v5Dz3JeDQ3IB/DdPJdnnpMfQKwnq1lCSPXxs5qp986I3SUYNwXRtg==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr4307120pjb.56.1591255738475;
        Thu, 04 Jun 2020 00:28:58 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id n189sm1657259pfn.108.2020.06.04.00.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:28:57 -0700 (PDT)
Date:   Thu, 4 Jun 2020 00:28:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
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
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
Message-ID: <20200604072853.GP89269@dtor-ws>
References: <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
 <20200527063430.GJ89269@dtor-ws>
 <88f939cd-1518-d516-59f2-8f627a6a70d2@collabora.com>
 <20200602175241.GO89269@dtor-ws>
 <82e9f2ab-a16e-51ee-1413-bedf0122026a@collabora.com>
 <8f97d2e1-497a-495d-bc82-f46dbeba440c@redhat.com>
 <fb5bee72-6a75-88aa-8157-75f07c491eeb@collabora.com>
 <681abc14-ef0f-ff15-68ed-944b2f96bdaf@redhat.com>
 <025361f4-5b1b-6669-ffa0-a6e8ad43940c@collabora.com>
 <01b902dd-8841-e697-5ba7-96fa6b73c1cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01b902dd-8841-e697-5ba7-96fa6b73c1cd@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans, Andrzej,

On Wed, Jun 03, 2020 at 09:37:10PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/3/20 7:54 PM, Andrzej Pietrasiewicz wrote:
> > W dniu 03.06.2020 o 19:38, Hans de Goede pisze:
> > > Hi,
> > > 
> > > On 6/3/20 3:07 PM, Andrzej Pietrasiewicz wrote:
> > > > Hi Hans, hi Dmitry,
> > > 
> > > <snip>
> > > 
> > > > I'm taking one step back and looking at the ->open() and ->close()
> > > > driver callbacks. They are called from input_open_device() and
> > > > input_close_device(), respectively:
> > > > 
> > > > input_open_device():
> > > > "This function should be called by input handlers when they
> > > > want to start receive events from given input device."
> > > > 
> > > > ->open() callback:
> > > > "this method is called when the very first user calls
> > > > input_open_device(). The driver must prepare the device to start
> > > > generating events (start polling thread, request an IRQ, submit
> > > > URB, etc.)"
> > > > 
> > > > input_close_device():
> > > > "This function should be called by input handlers when they
> > > > want to stop receive events from given input device."
> > > > 
> > > > ->close() callback:
> > > > "this method is called when the very last user calls
> > > > input_close_device()"
> > > > 
> > > > It seems to me that the callback names do not reflect their
> > > > purpose: their meaning is not to "open" or to "close" but to
> > > > give drivers a chance to control when they start or stop
> > > > providing events to the input core.
> > > > 
> > > > What would you say about changing the callbacks' names?
> > > > I'd envsion: ->provide_events() instead of ->open() and
> > > > ->stop_events() instead of ->close(). Of course drivers can
> > > > exploit the fact of knowing that nobody wants any events
> > > > from them and do whatever they consider appropriate, for
> > > > example go into a low power mode - but the latter is beyond
> > > > the scope of the input subsystem and is driver-specific.
> > > 
> > > I don't have much of an opinion on changing the names,
> > > to me open/close have always means start/stop receiving
> > > events. This follows the everything is a file philosophy,
> > > e.g. you can also not really "open" a serial port,
> > > yet opening /dev/ttyS0 will activate the receive IRQ
> > > of the UART, etc. So maybe we just need to make the
> > > docs clearer rather then do the rename?  Doing the
> > > rename is certainly going to cause a lot of churn.
> > 
> > Right, I can see now that the suggestion to change names is
> > too far fetched. (I feel that release() would be better
> > than close(), though). But it exposes the message I wanted to
> > pass.

release() usually means that the object is destroyedm, i.e this action,
unlike close() is irrevocable.

Let's leave the names as is, and adjust kerneldoc comments as needed.

> > 
> > > 
> > > Anyways as said, I don't have much of an opinion,
> > > so I'll leave commenting (more) on this to Dmitry.
> > > 
> > > > With such a naming change in mind let's consider inhibiting.
> > > > We want to be able to control when to disregard events from
> > > > a given device. It makes sense to do it at device level, otherwise
> > > > such an operation would have to be invoked in all associated
> > > > handlers (those that have an open handle associating them with
> > > > the device in question). But of course we can do better than
> > > > merely ignoring the events received: we can tell the drivers
> > > > that we don't want any events from them, and later, at uninhibit
> > > > time, tell them to start providing the events again. Conceptually,
> > > > the two operations (provide or don't provide envents) are exactly
> > > > the same thing we want to be happening at input_open_device() and
> > > > input_close_device() time. To me, changing the names of
> > > > ->open() and ->close() exposes this fact very well.
> > > > 
> > > > Consequently, ->inhibit() and ->uninhibit() won't be needed,
> > > > and drivers which already implement ->provide_events() (formerly
> > > > ->open()) and ->stop_events() (formerly ->close()) will receive
> > > > full inhibit/uninhibit support for free (subject to how well they
> > > > implement ->provide_events()/->stop_events()). Unless we can come
> > > > up with what the drivers might be doing on top of ->stop_events()
> > > > and ->provide_events() when inhibiting/uninhibiting, but it seems
> > > > to me we can't. Can we?
> > > 
> > > Right. I'm happy that you've come to see that both on open/close
> > > and on inhibit/uninhibit we want to "start receiving events" and
> > > "stop receiving events", so that we only need one set of callbacks.
> > > 
> > 
> > Yeah, that's my conclusion - at least on a conceptual level.
> > 
> > That said, what I can imagine is an existing driver (e.g. elan_i2c)
> > which does not implement neither open() nor close(), but does have
> > suspend() and resume(). Then it is maybe a bit easier to add inhibit()
> > and uninhibit() /they would be similar to suspend and resume/ instead
> > of open() and close(): If only open() and close() are possible, then
> > the probe function needs to be extended to "close" the device before it
> > gets registered, because from the moment it is registered it might be
> > opened right away.
> 
> The probe only needs to "close" it if for some reason it
> starts directly sending events in most cases the driver
> must actively do something to get it to send events.
> 
> So in most cases this should be pretty straight forward,
> as for having to do some init / power-on during probe
> and then power-off at the end of the probe. Yes sometimes
> something like that might be necessary.
> 
> Looking at your suggested elan_i2c changes I think they
> look fine. I have the feeling that with some refactoring
> they can be made a bit cleaner (I did not look a the
> changes in too much detail) but overall I think they
> look ok.
> 
> Note you may also want to look at using the runtime
> suspend framework for this, doing a pm_runtime_get_sync()
> in open() and then letting (runtime) suspend do the power
> off if you set a reasonable timeout for autosuspend after
> the last user is gone then that will also avoid an
> unnecessary suspend / resume cycle between probe()
> exiting and the first open() call and this avoids the
> need to do a poweroff() at the end of probe(), the
> runtime-pm framework will autosuspend the device after
> the timeout expires.

Yes, plugging into runtime PM would be nice, as as it currently stands
the driver will be broken with regard to trying access sysfs for
firmware update/calibration/etc if device happens to be inhibited.

The version of the driver in Chrome OS tree is similarly broken, but
because we control both kernel and the rest of the stack we know that we
do not poke at sysfs when device is inhibited. It will not be acceptable
for mainline (and that is one of reasons why elan_i2c does not have
open/close methods at the moment).

Thanks.

-- 
Dmitry
