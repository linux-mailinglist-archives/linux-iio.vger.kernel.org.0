Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46DF1D6F0E
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgERCkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgERCki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 22:40:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CCC061A0C;
        Sun, 17 May 2020 19:40:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f15so3616848plr.3;
        Sun, 17 May 2020 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BSi1j3B+LKlZ+pND+2uv+E9eGj8LmHGTLONT1ZbFAyQ=;
        b=ZsX2V0MmYF50na3aWBoR7eEKTHYC85N+iEUm9lY7ZV2vIPvM4qWwRf72zMRcVvvsRh
         6FZFoXlSmY2r/n9X2BPIIwfLai6WxwMqr1OTVRNfAemUrnsa37Ybe/vhnmPCoaQBQzTF
         a8Urn+gvx4DtjuIDJ3qdIKQUzBrMQmUhk1KoD/DEIqbij9VU0XuKgoxtLfhptHBgejsN
         VltvFqKeFPpM4dsoexRUH7OCeEUyXPEJyh3/264sXr7MGmGARRE7BhQ8+dkbTZC82gOY
         V70cYtMgKVHywicpO1khfY8YK+4DAG+HcqiCgEbQKrwloC6qalMginFFw9T53WbDXm/W
         cuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BSi1j3B+LKlZ+pND+2uv+E9eGj8LmHGTLONT1ZbFAyQ=;
        b=fI+MxXNDtsM2rF3VYnEU34nrbwe52zc9xNLnfmhW7nIjJaJ7YHuyLLOKFr3Y1Fz6/z
         n/g93SRhHs2igqMgKB1E7zJQZ2Pe/OkhgzI3I7ia7fpDaYlRJ1cMZP7p4PRSSg8foNnF
         3f+lwNWXLMeAOKV5Va/8e1kkaRGKn8hcsmKItIIotbi+q2GHvvtHfVyk2oVkWAOk7eUz
         iKXQ6VYt+BM9ZoMGnOTe5wceLIG6+/DlfOrjmwlbPR71SHDCXVbFXAZgciv9g/N33loi
         nbac1MXfwEeZXiNFr7PPpeRyDDmMmevfaP9YbwNfJdifujCHflLFaZh0Wr4XgER9fwOm
         3ziw==
X-Gm-Message-State: AOAM530oD16JKJglyO42VoMw5EXX7nqZQ4+YDsqlWs75DXN+KbCgtmY7
        3Ddx3/Fbhf31KnxYYUJkUM0=
X-Google-Smtp-Source: ABdhPJw6+D0pVLHENKQEm5RucsG1mrNeCZaFYuYqbZFDLGhDKldJppMOzBpLcQebfqpE8BGs2bUiSg==
X-Received: by 2002:a17:90b:3d4:: with SMTP id go20mr10710415pjb.208.1589769637579;
        Sun, 17 May 2020 19:40:37 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id a2sm7218540pfl.28.2020.05.17.19.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 19:40:36 -0700 (PDT)
Date:   Sun, 17 May 2020 19:40:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
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
Message-ID: <20200518024034.GL89269@dtor-ws>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <20200517225510.GA205823@koala>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200517225510.GA205823@koala>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Hans, Peter,

On Mon, May 18, 2020 at 08:55:10AM +1000, Peter Hutterer wrote:
> On Fri, May 15, 2020 at 08:19:10PM +0200, Hans de Goede wrote:
> > Hi Andrezj,
> > 
> > On 5/15/20 6:49 PM, Andrzej Pietrasiewicz wrote:
> > > Userspace might want to implement a policy to temporarily disregard input
> > > from certain devices, including not treating them as wakeup sources.
> > > 
> > > An example use case is a laptop, whose keyboard can be folded under the
> > > screen to create tablet-like experience. The user then must hold the laptop
> > > in such a way that it is difficult to avoid pressing the keyboard keys. It
> > > is therefore desirable to temporarily disregard input from the keyboard,
> > > until it is folded back. This obviously is a policy which should be kept
> > > out of the kernel, but the kernel must provide suitable means to implement
> > > such a policy.
> > 
> > Actually libinput already binds together (inside libinput) SW_TABLET_MODE
> > generating evdev nodes and e.g. internal keyboards on devices with 360°
> > hinges for this reason. libinput simply closes the /dev/input/event#
> > node when folded and re-opens it when the keyboard should become active
> > again. Thus not only suppresses events but allows e.g. touchpads to
> > enter runtime suspend mode which saves power. Typically closing the
> > /dev/input/event# node will also disable the device as wakeup source.
> > 
> > So I wonder what this series actually adds for functionality for
> > userspace which can not already be achieved this way?
> 
> Thanks Hans. To expand on this:
> libinput has heuristics to guess which input devices (keyboards, touchpads)
> are built-in ones. When the tablet mode switch is on, we disable these
> devices internally (this is not visible to callers), and re-enable it again
> later when the tablet mode switch is off again.

I think that is great that libinput has tried solving this for the
tablet mode, but unfortunately libinput only works for users of
libinput, leaving cases such as:

1. In-kernel input handlers, such as SysRq, VT and others
2. Systems that do not rely on libinput for userspace handing (Android,
Chrome OS)
3. Systems with policies that are more complex than tablet mode only.

Because of libinput's inability to affect the kernel, and the presence
of "always on" input handlers (sysrq, VT keyboard, potentially others),
while libinput may control whether consumers receive events from certain
input devices, it will not allow power savings that an explicit
"inhibit" allows when coming from dedicated power policy manager.

I think pushing policy decisions into a library, and trying to have all
clients agree with it, is much harder and leaks unnecessary knowledge
into quite a few layers. A dedicated power policy manager, that is not
only responsible for input device, but power state of the system as a
whole, is a very viable architecture.

> 
> This is done for keyboards and touchpads atm (and I think pointing sticks)
> and where the heuristics fail we have extra quirks in place. For example
> the Lenovo Yogas tend to disable the keyboard mechanically in tablet mode
> but buttons (e.g. volume keys) around the screen send events through the
> same event node. So on those devices we don't disable the keyboard.
> 
> We've had this code for a few years now and the only changes to it have been
> the various device quirks for devices that must not suspend the keyboard,
> it's otherwise working as expected.
> 
> If we ever have a device where we need to disable parts of the keyboard
> only, we could address this with EVIOCSMASK but so far that hasn't been
> necessary.
> 
> I agree with Hans, right now I don't see the usefulness of this new sysfs
> toggle. For it to be really useful you'd have to guarantee that it's
> available for 100% of the devices and that's IMO unlikely to happen.

The inhibiting of the events works for 100% of input devices, the power
savings work for the ones that implement it. It is responsibility of
folds shipping the systems to make sure drivers they use support inhibit
if they believe it will help their battery life.

> 
> Cheers,
>    Peter
> 
> > I also noticed that you keep the device open (do not call the
> > input_device's close callback) when inhibited and just throw away
> > any events generated. This seems inefficient and may lead to
> > the internal state getting out of sync. What if a key is pressed
> > while inhibited and then the device is uninhibited while the key
> > is still pressed?  Now the press event is lost and userspace
> > querying the current state will see the pressed key as being
> > released.

This is a good point. We should look into signalling that some events
have been dropped (via EV_SYN/SYN_DROPPED) so that clients are aware of
it.

> > 
> > On top of this you add special inhibit and uninhibit callbacks
> > and implement those for just a few devices. How do these differ
> > from just closing the device and later opening it again ?

I believe majority will simply reuse open/close callbacks. In Chrome OS
we have dedicated inhibit/uninhibit, but I would like to allow using
open/close as alternatives.

> > 
> > Also using a sysfs property for this is very weird given that the
> > rest of the evdev interface is using ioctls for everything...

This is not evdev interface, it is at the level above evdev (so that it
can affect all handlers, not only evdev). As such it is not bound by
evdev interface.

Thanks.

-- 
Dmitry
