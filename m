Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939CA1F5181
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFJJuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 05:50:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29979 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727903AbgFJJuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 05:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591782601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=botNO1nlLUjRUQbw+XWbs23AWcnqLx8AKm8BEyvzIAg=;
        b=J6TkzlAKX0uqZvZLa20b4n6FpITVlK9xz/mzxwOU5EVQ3uL3RgXZs80/1EwSHyIdN70tQn
        MpczlxzFE4aJSQRnZf2OVz7i60Ok9o1rOre08aVAfLhtxRy3c4lbMKxZ0z2yyjedOmZiyf
        6m8KvMXxUBvcAAThpTW/NJn5t/JieuA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-dVUMf8flNXy73vslVV2Y3w-1; Wed, 10 Jun 2020 05:49:58 -0400
X-MC-Unique: dVUMf8flNXy73vslVV2Y3w-1
Received: by mail-ej1-f72.google.com with SMTP id ca6so840185ejb.7
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2020 02:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=botNO1nlLUjRUQbw+XWbs23AWcnqLx8AKm8BEyvzIAg=;
        b=BJHWigfn82dZWMUR348Jix1dQFux2et0MHVBbi2FnFS23UYn0hn97MQUBQgzKPqE3a
         RccaYxEqde8LredYCo+mXwba3SeQFCttc690U07BuSKjNRLCHRcJNjZneZ+PIh9D3h9T
         kJn01Gq5HKLfxeK1CK99lWJ2ayoaE74N1VQoK98RoDjAAeO4DpfD07qJ3T7Uno0sKPmI
         J08wucIc2GLKX+pZ9GuI9x1PkptK2U+Rc+16OMIkn12wozpeF8/qfrM9+FDNPYcHyOlI
         w9XNv5ueageZM99Ch0sPuaiGIa6Uejdp21osM0mrWupRolo5pcKgelbnj2yR0onZUIq0
         MBRg==
X-Gm-Message-State: AOAM531WWuc33FBoa2NBCoHkCYLDbkv9To0+4oloyEugZHARiTn0Zo/b
        15gnDMGS/SIeFRVGx6HNeLepC+N41IK6UCzQBchZZxCDhP5zy5//6RONcRcPGBvHbyO19QuVUV4
        blk/uZx1bDAik3bDuwdig
X-Received: by 2002:a17:906:e247:: with SMTP id gq7mr2477425ejb.107.1591782597469;
        Wed, 10 Jun 2020 02:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLuKTyRnDOzIwu58NCqlAlNV6D3hehW65EK1iqNwj/QcEksd5YROS78o3t4aQe67v9IROeVQ==
X-Received: by 2002:a17:906:e247:: with SMTP id gq7mr2477395ejb.107.1591782597158;
        Wed, 10 Jun 2020 02:49:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f19sm16656165edq.14.2020.06.10.02.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:49:56 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        kernel@collabora.com
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
Date:   Wed, 10 Jun 2020 11:49:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608112211.12125-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

On 6/8/20 1:22 PM, Andrzej Pietrasiewicz wrote:
> This is a quick respin of v3, with just two small changes, please see
> the changelog below.
> 
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices.
> 
> An example use case is a convertible laptop, whose keyboard can be folded
> under the screen to create tablet-like experience. The user then must hold
> the laptop in such a way that it is difficult to avoid pressing the keyboard
> keys. It is therefore desirable to temporarily disregard input from the
> keyboard, until it is folded back. This obviously is a policy which should
> be kept out of the kernel, but the kernel must provide suitable means to
> implement such a policy.

First of all sorry to start a somewhat new discussion about this
while this patch set is also somewhat far along in the review process,
but I believe what I discuss below needs to be taken into account.

Yesterday I have been looking into why an Asus T101HA would not stay
suspended when the LID is closed. The cause is that the USB HID multi-touch
touchpad in the base of the device starts sending events when the screen
gets close to the touchpad (so when the LID is fully closed) and these
events are causing a wakeup from suspend. HID multi-touch devices
do have a way to tell them to fully stop sending events, also disabling
the USB remote wakeup the device is doing. The question is when to tell
it to not send events though ...

So now I've been thinking about how to fix this and I believe that there
is some interaction between this problem and this patch-set.

The problem I'm seeing on the T101HA is about wakeups, so the question
which I want to discuss is:

1. How does inhibiting interact with enabling /
disabling the device as a wakeup source ?

2. Since we have now made inhibiting equal open/close how does open/close
interact with a device being a wakeup source ?

And my own initial (to be discussed) answers to these questions:

1. It seems to me that when a device is inhibited it should not be a
wakeup source, so where possible a input-device-driver should disable
a device's wakeup capabilities on suspend if inhibited

2. This one is trickier I don't think we have really clearly specified
any behavior here. The default behavior of most drivers seems to be
using something like this in their suspend callback:

         if (device_may_wakeup(dev))
                 enable_irq_wake(data->irq);
         else if (input->users)
                 foo_stop_receiving_events(data);

Since this is what most drivers seem to do I believe we should keep
this as is and that we should just clearly document that if the
input_device has users (has been opened) or not does not matter
for its wakeup behavior.

Combining these 2 answers leads to this new pseudo code template
for an input-device's suspend method:

	/*
	 * If inhibited we have already disabled events and
	 * we do NOT want to setup the device as wake source.
	 */
	if (input->inhibited)
		return 0;

         if (device_may_wakeup(dev))
                 enable_irq_wake(data->irq);
         else if (input->users)
                 foo_stop_receiving_events(data);

###

A different, but related issue is how to make devices actually use the
new inhibit support on the builtin keyboard + touchpad when say the lid
is closed.   Arguably this is an userspace problem, but it is a tricky
one. Currently on most modern Linux distributions suspend-on-lid-close
is handled by systemd-logind and most modern desktop-environments are
happy to have logind handle this for them.

But most knowledge about input devices and e.g. heurisitics to decide
if a touchpad is internal or external are part of libinput. Now we could
have libinput use the new inhibit support (1), but then when the lid
closes we get race between whatever process is using libinput trying
to inhibit the touchpad (which must be done before to suspend to disable
it as wakeup source) and logind trying to suspend the system.

One solution here would be to move the setting of the inhibit sysfs
attr into logind, but that requires adding a whole bunch of extra
knowledge to logind which does not really belong there IMHO.

I've been thinking a bit about this and to me it seems that the kernel
is in the ideal position to automatically inhibit some devices when
some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
issue here is to chose on which devices to enable this. I believe
that the auto inhibit on some switches mechanism is best done inside
the kernel (disabled by default) and then we can have a sysfs
attr called auto_inhibit_ev_sw_mask which can be set to e.g.
(1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
inhibit both when the lid is closed or when switched to tablet mode.

This could then be combined with a userspace utility run from an
udev rule which makes the actual decision what auto_inhibit_ev_sw_mask
should be set for a given input device.

This will put the mechanism for what we want inside the kernel and
leaves the policy on which switches we want this for out of the
kernel.

Note adding this new auto_inhibit_ev_sw_mask sysfs attr falls
somewhat outside the context of this patchset and could be done
as a follow up to this patch-set. But I do believe that we need to
figure out how (non ChromeOS) userspace can / will use the new inhibit
interface before merging it.

Regards,

Hans




1) There are issues here with libinput not running as root and this
being a root only sysfs interface but lets ignore those for now,
note that the auto_inhibit_ev_sw_mask also neatly solves this
problem


