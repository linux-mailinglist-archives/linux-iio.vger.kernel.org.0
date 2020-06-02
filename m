Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F101EC169
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFBRwr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 13:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBRwq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 13:52:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D32EC05BD1E;
        Tue,  2 Jun 2020 10:52:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so1775788pjb.0;
        Tue, 02 Jun 2020 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DsDlTAN5nXx2eXeaYpyOizF6rp89+ZyQuZEoODyhpKQ=;
        b=lOt5bDJGsfK9IyNxz3BNa4rLKdk08R28EoDJrT2TUNMLbDyn8CzBBmFfkFe6atRsGn
         NQUzHizY/xR0tIwR/Fv6cLBvYq4vV4+Q1oNNa578UCAQkfJUbXwU0XvgRE6TIZ4K0ZVL
         +IilnKMWHrYZbepwRYHoTr0hmJk9tLHnDUs3xNl11dsFboIB3dq7c9tD088BsqY9MbHi
         +SPZDl667YmxpVexTZNqnhx5Pgecw0OPK+asacMRjWAHfk4LuN6hUAN5lYYRVMImMTkJ
         rkLXt/cXLA5dp+fg8J/cStQdFtFGauWWiBHCKiftRfNn+KL8xQifFcVN5QzSVxpMF7pD
         M3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DsDlTAN5nXx2eXeaYpyOizF6rp89+ZyQuZEoODyhpKQ=;
        b=U00ouh3hVq2L2Jg3vGDxYcJ3zFR8t1gZ/1wcxlxJMosennXQF06KuA8aV2GDal0kKw
         PI8zuYGCq+38jHEPqoduIcAIzNv7ZgSWT0JiPQaNqd8IE3yCSuof5R3MOKsWZrXnFUcb
         +BuSwa2SBstAAiEQX4fOx+c6kPuBC6YlYEVtlP7gkwrfDwuq6Iy9oszydufX5UFX2Wib
         QDXxU2aG7tGj5t9yPFQJOyYKHy/eevoG/AV2CkZZJKZEOOOnrR2FC0Y/Vegt4/xzQQ39
         TBJqc2eK+RaElAbOlbkt/Uy7Kg6nq0p8fSAY9cDg6oCc+F2fqxKZcG860AbZjVmFW94T
         58rQ==
X-Gm-Message-State: AOAM532E0h2YggFJI1IZzECHCLAvpM+tTerk7c5eG+fLDMmgZLtWdJkb
        kjFsDHsW/uac2yU45Xqn18s=
X-Google-Smtp-Source: ABdhPJw4j3qAh/n1rbRzh5j+Qh1ZpRvg/yNd1He12Pkb+W7uWkt4zY60I9IIhaoAP1YKs8H+3eduzw==
X-Received: by 2002:a17:902:c411:: with SMTP id k17mr22524187plk.165.1591120365656;
        Tue, 02 Jun 2020 10:52:45 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id m9sm2909107pfo.200.2020.06.02.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 10:52:44 -0700 (PDT)
Date:   Tue, 2 Jun 2020 10:52:41 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20200602175241.GO89269@dtor-ws>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <e6030957-97dc-5b04-7855-bc14a78164c8@collabora.com>
 <6d9921fc-5c2f-beda-4dcd-66d6970a22fe@redhat.com>
 <09679de4-75d3-1f29-ec5f-8d42c84273dd@collabora.com>
 <f674ba4f-bd83-0877-c730-5dc6ea09ae4b@redhat.com>
 <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
 <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
 <20200527063430.GJ89269@dtor-ws>
 <88f939cd-1518-d516-59f2-8f627a6a70d2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88f939cd-1518-d516-59f2-8f627a6a70d2@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andrzej,

On Tue, Jun 02, 2020 at 06:56:40PM +0200, Andrzej Pietrasiewicz wrote:
> Hi Dmitry,
> 
> W dniu 27.05.2020 o 08:34, Dmitry Torokhov pisze:
> > That said, I think the way we should handle inhibit/uninhibit, is that
> > if we have the callback defined, then we call it, and only call open and
> > close if uninhibit or inhibit are _not_ defined.
> > 
> 
> If I understand you correctly you suggest to call either inhibit,
> if provided or close, if inhibit is not provided, but not both,
> that is, if both are provided then on the inhibit path only
> inhibit is called. And, consequently, you suggest to call either
> uninhibit or open, but not both. The rest of my mail makes this
> assumption, so kindly confirm if I understand you correctly.

Yes, that is correct. If a driver wants really fine-grained control, it
will provide inhibit (or both inhibit and close), otherwise it will rely
on close in place of inhibit.

> 
> In my opinion this idea will not work.
> 
> The first question is should we be able to inhibit a device
> which is not opened? In my opinion we should, in order to be
> able to inhibit a device in anticipation without needing to
> open it first.

I agree.

> 
> Then what does opening (with input_open_device()) an inhibited
> device mean? Should it succeed or should it fail?

It should succeed.

> If it is not
> the first opening then effectively it boils down to increasing
> device's and handle's counters, so we can allow it to succeed.
> If, however, the device is being opened for the first time,
> the ->open() method wants to be called, but that somehow
> contradicts the device's inhibited state. So a logical thing
> to do is to either fail input_open_device() or postpone ->open()
> invocation to the moment of uninhibiting - and the latter is
> what the patches in this series currently do.
> 
> Failing input_open_device() because of the inhibited state is
> not the right thing to do. Let me explain. Suppose that a device
> is already inhibited and then a new matching handler appears
> in the system. Most handlers (apm-power.c, evbug.c, input-leds.c,
> mac_hid.c, sysrq.c, vt/keyboard.c and rfkill/input.c) don't create
> any character devices (only evdev.c, joydev.c and mousedev.c do),
> so for them it makes no sense to delay calling input_open_device()
> and it is called in handler's ->connect(). If input_open_device()
> now fails, we have lost the only chance for this ->connect() to
> succeed.
> 
> Summarizing, IMO the uninhibit path should be calling both
> ->open() and ->uninhibit() (if provided), and conversely, the inhibit
> path should be calling both ->inhibit() and ->close() (if provided).

So what you are trying to say is that you see inhibit as something that
is done in addition to what happens in close. But what exactly do you
want to do in inhibit, in addition to what close is doing?

In my view, if we want to have a dedicated inhibit callback, then it
will do everything that close does, they both are aware of each other
and can sort out the state transitions between them. For drivers that do
not have dedicated inhibit/uninhibit, we can use open and close
handlers, and have input core sort out when each should be called. That
means that we should not call dev->open() in input_open_device() when
device is inhibited (and same for dev->close() in input_close_device).
And when uninhibiting, we should not call dev->open() when there are no
users for the device, and no dev->close() when inhibiting with no users.

Do you see any problems with this approach?

Thanks.

-- 
Dmitry
