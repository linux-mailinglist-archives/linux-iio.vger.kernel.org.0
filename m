Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766311F5668
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jun 2020 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgFJOB6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jun 2020 10:01:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40605 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgFJOB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jun 2020 10:01:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id t25so2125349oij.7;
        Wed, 10 Jun 2020 07:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl62HWLkcdUncszr4NfDCSNaITirf4yc7zsH9ph91Mg=;
        b=Qjbj7mjG42s8fdutEj5DgbH6byB8n5MLqHfiKyUWonA4a4y0blxWJtnDLzm61eXgvX
         mLI6wOslj9O2hMC9K3JJiF2g1JilrdLbDmQyY/lXExZR2rGaXg8UCmpo7pByP+0nolyy
         61PhVJQqEjkADfxN9cB9UJwHd0JL2u5XmF4yjVg93zdP6y6L0rjns0serLkbaJ/5SRM0
         wk22BBjC5FcF1MCmISFrUPflEJzRFmZupj5i5P+d/0AfvqLqua0w8+It2T3T7qcCkC9T
         mkvvvAfwSmpqTRmqEEvuQPkPc6SGvKLfymN2zZvaCkhROeBHdRAC8lKWNjxsj00LlFJZ
         GpgQ==
X-Gm-Message-State: AOAM532vpbd+wgSf2RJM31KV9qcPmfPSI4tGBtoqTlHzlWjz8mmSpFSJ
        7PMWSoJ8vX5sohvV7pQOH3bNRXyc7L127yKHnzM=
X-Google-Smtp-Source: ABdhPJzorUjsiFcKJqkTkUHEOkzCM8G8rZoea2g27dOAzap4gGLrBRRziPbedIOP6/JlYUlFFWbvc+8f9RAYMPdl7zE=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr2656825oie.103.1591797717254;
 Wed, 10 Jun 2020 07:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com> <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
 <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
 <6136f26c-e090-e025-af55-4c5f3a6aec92@collabora.com> <3e61c9c1-b211-da9f-c55b-b44eb6522f2a@redhat.com>
In-Reply-To: <3e61c9c1-b211-da9f-c55b-b44eb6522f2a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Jun 2020 16:01:45 +0200
Message-ID: <CAJZ5v0gVBzLpQqNrV-kzV84mLB86Gd6Ws63RwBKT=r1WgbeDSQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Jun 10, 2020 at 3:21 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/10/20 3:12 PM, Andrzej Pietrasiewicz wrote:
> > Hi All,
> >

[cut]

> > What would it mean to become a wakeup source if there are no users,
> > or nobody has ever opened the device? There are no interested
> > input handlers (users) so what's the point of becoming a wakeup
> > source? Why would the system need to wake up?
>
> Well this is what we have been doing so far, so arguably we
> need to keep doing it to avoid regressions / breaking our ABI.
>
> Lets for example take a laptop, where when suspended the
> power-button is the only valid wakeup-source and this is
> running good old slackware with fvwm2 or windowmaker as
> "desktop environment", then likely no process will have
> the power-button input evdev node open.  Still we should
> wakeup the laptop on the power-button press, otherwise
> it will never wakeup.
>
> Note I agree with you that the way this works is not
> ideal, I just do not think that we can change it.

Please note that "no users" merely means that user space is not
interested in receiving and processing the events from that device.

If it is configured for system wakeup, it doesn't matter whether or
not user space will consume the related events.

Thanks!
