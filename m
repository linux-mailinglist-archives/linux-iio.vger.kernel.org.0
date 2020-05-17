Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAF1D6DEB
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 00:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgEQWza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 18:55:30 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51479 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbgEQWza (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 18:55:30 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC413580135;
        Sun, 17 May 2020 18:55:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 17 May 2020 18:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=Y
        +ufOws1a8u4D45GLH8cH2b31BsgtOeXytbtlxDEocM=; b=aPVWima/CN66WHQAx
        47LyH7yzmfyS/tYoEugzowuOejurfEf25wMuCGi6JZkDr2t44zPE036AZNeuwG0J
        FEQGMVL2y94x1VNUOxsYkeucRKO/RwVF3u5w+B63dA/XmjolvLrEMvBRAH63598X
        o7OZ6VhWVp8mdiBADj+/sipkcIgQRZGwvoZd2vWfazAvq8qFoI8NZ+5aa7LwHI5P
        cc1ps8eBFCtIH/BliSyQU2QQCAqj/uFU+kQlegb97VLuQvHJ+o0kFfUvoNygurl2
        Y47hnCZFEvy3DR32+E/yGESNhmI0wt/lPAWbkSP9e2HVOImbORZR5SEvdS4bvYiJ
        5gQHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Y+ufOws1a8u4D45GLH8cH2b31BsgtOeXytbtlxDEo
        cM=; b=ZR5j8MZ589WoZH8nR/THxh86gHJSfZA+ze9OIaMEyi+OLO45glLz67cLJ
        jjTjkeY85XmC7WsMkCBiAUAaRse7aSuEDXqfrxsfUDvSqX0BgRO8ordnEczKMgMx
        xmT88P4Le9zx96m2WJDyG20L3XSLxs7IuE0UHR9B3Cw2EDjwrZfE2jCUiH7wahSe
        0zi+By0KB2tia5/d/oV2LrHWQWYOldmid9h75SVJhd5rZwGaMBkZ3FoH/S5fc1Oh
        FtPKfptHAa57rS+Kik2ADBfC+Xb8Ogn/qd7Vy4WVzsXOUjHsi7xEQu+qjnEzmjrE
        ToICGnKu94IAXS077azAzvtuFi2Bg==
X-ME-Sender: <xms:3cDBXjtZRBKleY1vDtazOehQUmWjyppvULxnyhzYK_WMUS0yBMoUzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtgedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpefhgeevfefhkefgudekffegfeekveeuleeuieeutdfg
    jeeiieegkeejudfggfdtkeenucfkphepuddujedrvddtrdejuddruddtleenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghrrdhhuhht
    thgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:3cDBXkccn-PNipkl64wwUbHDk5rDibutmBWNyFiU-2cHnX9gK4nfAg>
    <xmx:3cDBXmws-3jvJV16csSKRSO4K_zD82Ot6irFlUTdpseVs6WPWWZoIw>
    <xmx:3cDBXiNeTg1Zpp6ZrSfytXuMu3q169TdbKy0eVbt1rBZybs3K-op-w>
    <xmx:4MDBXpxeXAoX8iisBna-URpxZMHuVswcVTvIMVC9KWFH54_Mfr9_1Q>
Received: from koala (117-20-71-109.751447.bne.nbn.aussiebb.net [117.20.71.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 050AE328005A;
        Sun, 17 May 2020 18:55:14 -0400 (EDT)
Date:   Mon, 18 May 2020 08:55:10 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
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
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
Message-ID: <20200517225510.GA205823@koala>
References: <20200506002746.GB89269@dtor-ws>
 <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 15, 2020 at 08:19:10PM +0200, Hans de Goede wrote:
> Hi Andrezj,
> 
> On 5/15/20 6:49 PM, Andrzej Pietrasiewicz wrote:
> > Userspace might want to implement a policy to temporarily disregard input
> > from certain devices, including not treating them as wakeup sources.
> > 
> > An example use case is a laptop, whose keyboard can be folded under the
> > screen to create tablet-like experience. The user then must hold the laptop
> > in such a way that it is difficult to avoid pressing the keyboard keys. It
> > is therefore desirable to temporarily disregard input from the keyboard,
> > until it is folded back. This obviously is a policy which should be kept
> > out of the kernel, but the kernel must provide suitable means to implement
> > such a policy.
> 
> Actually libinput already binds together (inside libinput) SW_TABLET_MODE
> generating evdev nodes and e.g. internal keyboards on devices with 360°
> hinges for this reason. libinput simply closes the /dev/input/event#
> node when folded and re-opens it when the keyboard should become active
> again. Thus not only suppresses events but allows e.g. touchpads to
> enter runtime suspend mode which saves power. Typically closing the
> /dev/input/event# node will also disable the device as wakeup source.
> 
> So I wonder what this series actually adds for functionality for
> userspace which can not already be achieved this way?

Thanks Hans. To expand on this:
libinput has heuristics to guess which input devices (keyboards, touchpads)
are built-in ones. When the tablet mode switch is on, we disable these
devices internally (this is not visible to callers), and re-enable it again
later when the tablet mode switch is off again.

This is done for keyboards and touchpads atm (and I think pointing sticks)
and where the heuristics fail we have extra quirks in place. For example
the Lenovo Yogas tend to disable the keyboard mechanically in tablet mode
but buttons (e.g. volume keys) around the screen send events through the
same event node. So on those devices we don't disable the keyboard.

We've had this code for a few years now and the only changes to it have been
the various device quirks for devices that must not suspend the keyboard,
it's otherwise working as expected.

If we ever have a device where we need to disable parts of the keyboard
only, we could address this with EVIOCSMASK but so far that hasn't been
necessary.

I agree with Hans, right now I don't see the usefulness of this new sysfs
toggle. For it to be really useful you'd have to guarantee that it's
available for 100% of the devices and that's IMO unlikely to happen.

Cheers,
   Peter

> I also noticed that you keep the device open (do not call the
> input_device's close callback) when inhibited and just throw away
> any events generated. This seems inefficient and may lead to
> the internal state getting out of sync. What if a key is pressed
> while inhibited and then the device is uninhibited while the key
> is still pressed?  Now the press event is lost and userspace
> querying the current state will see the pressed key as being
> released.
> 
> On top of this you add special inhibit and uninhibit callbacks
> and implement those for just a few devices. How do these differ
> from just closing the device and later opening it again ?
> 
> Also using a sysfs property for this is very weird given that the
> rest of the evdev interface is using ioctls for everything...
> 
> So all in all I see a lot of question marks here and I think we
> need to have a detailed discussion about what use-cases this
> series tries to enable before moving forward with this.
> 
> Regards,
> 
> Hans
> 
