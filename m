Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C2C27CAAC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgI2MUj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbgI2MUO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:14 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14A621D7F;
        Tue, 29 Sep 2020 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382012;
        bh=ov1elNoAqvpAgkFdDCEUFjYQTLHr/ttO0TQvEJAVa9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jvmD222GUH8GXZXMqLgvR5A2+dOAEZWZqu4PegoCrdYQdzBlMInSen1U/TUqJEq8O
         ceT34IkdoHIcZvgHpI88n6jirXc5UQcpO8Qz6F77lDrlzzwk0iFCge1wnf1OTx3Elx
         zfbRYdhsjG0Yv1fzcUprrD5yQS1C84H7eKuBhHBY=
Received: by mail-oi1-f176.google.com with SMTP id a3so5198773oib.4;
        Tue, 29 Sep 2020 05:20:12 -0700 (PDT)
X-Gm-Message-State: AOAM532QKK1BHU4WxK1BJVspA7x+C1SlGo5/J3No/cuXOfmtLVklTk/K
        7Dv8Oy6tO8uo+LlkeIclcQ3DhS0edShwRiXt+ZY=
X-Google-Smtp-Source: ABdhPJxHjqLRU0igLQr7uKep0t1UD6JefrmIRI4HIWmkx+yCU9/FWYtVU2YD0jwBcbkAVEkIIOoN6IXn5rWs3UBmGUQ=
X-Received: by 2002:a54:4517:: with SMTP id l23mr2509374oil.174.1601382011805;
 Tue, 29 Sep 2020 05:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Sep 2020 14:20:00 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
Message-ID: <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate statements
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     linux-iio@vger.kernel.org, drbd-dev@lists.linbit.com,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Lechner <david@lechnology.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 27 Sep 2020 at 21:56, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> These patches replace commas by semicolons.


Why?


> This was done using the
> Coccinelle semantic patch (http://coccinelle.lip6.fr/) shown below.
>
> This semantic patch ensures that commas inside for loop headers will not be
> transformed.  It also doesn't touch macro definitions.
>
> Coccinelle ensures that braces are added as needed when a single-statement
> branch turns into a multi-statement one.
>
> This semantic patch has a few false positives, for variable delcarations
> such as:
>
> LIST_HEAD(x), *y;
>
> The semantic patch could be improved to avoid these, but for the moment
> they have been removed manually (2 occurrences).
>
> // <smpl>
> @initialize:ocaml@
> @@
>
> let infunction p =
>   (* avoid macros *)
>   (List.hd p).current_element <> "something_else"
>
> let combined p1 p2 =
>   (List.hd p1).line_end = (List.hd p2).line ||
>   (((List.hd p1).line_end < (List.hd p2).line) &&
>    ((List.hd p1).col < (List.hd p2).col))
>
> @bad@
> statement S;
> declaration d;
> position p;
> @@
>
> S@p
> d
>
> // special cases where newlines are needed (hope for no more than 5)
> @@
> expression e1,e2;
> statement S;
> position p != bad.p;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> @@
>
> - e1@p1,@S@p e2@p2;
> + e1; e2;
>
> @@
> expression e1,e2;
> statement S;
> position p != bad.p;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> @@
>
> - e1@p1,@S@p e2@p2;
> + e1; e2;
>
> @@
> expression e1,e2;
> statement S;
> position p != bad.p;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> @@
>
> - e1@p1,@S@p e2@p2;
> + e1; e2;
>
> @@
> expression e1,e2;
> statement S;
> position p != bad.p;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> @@
>
> - e1@p1,@S@p e2@p2;
> + e1; e2;
>
> @@
> expression e1,e2;
> statement S;
> position p != bad.p;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> @@
>
> - e1@p1,@S@p e2@p2;
> + e1; e2;
>
> @r@
> expression e1,e2;
> statement S;
> position p != bad.p;
> @@
>
> e1 ,@S@p e2;
>
> @@
> expression e1,e2;
> position p1;
> position p2 :
>     script:ocaml(p1) { infunction p1 && not(combined p1 p2) };
> statement S;
> position r.p;
> @@
>
> e1@p1
> -,@S@p
> +;
> e2@p2
> ... when any
> // </smpl>
>
> ---
>
>  drivers/acpi/processor_idle.c               |    4 +++-
>  drivers/ata/pata_icside.c                   |   21 +++++++++++++--------
>  drivers/base/regmap/regmap-debugfs.c        |    2 +-
>  drivers/bcma/driver_pci_host.c              |    4 ++--
>  drivers/block/drbd/drbd_receiver.c          |    6 ++++--
>  drivers/char/agp/amd-k7-agp.c               |    2 +-
>  drivers/char/agp/nvidia-agp.c               |    2 +-
>  drivers/char/agp/sworks-agp.c               |    2 +-
>  drivers/char/hw_random/iproc-rng200.c       |    8 ++++----
>  drivers/char/hw_random/mxc-rnga.c           |    6 +++---
>  drivers/char/hw_random/stm32-rng.c          |    8 ++++----
>  drivers/char/ipmi/bt-bmc.c                  |    6 +++---
>  drivers/clk/meson/meson-aoclk.c             |    2 +-
>  drivers/clk/mvebu/ap-cpu-clk.c              |    2 +-
>  drivers/clk/uniphier/clk-uniphier-cpugear.c |    2 +-
>  drivers/clk/uniphier/clk-uniphier-mux.c     |    2 +-
>  drivers/clocksource/mps2-timer.c            |    6 +++---
>  drivers/clocksource/timer-armada-370-xp.c   |    8 ++++----
>  drivers/counter/ti-eqep.c                   |    2 +-
>  drivers/crypto/amcc/crypto4xx_alg.c         |    2 +-
>  drivers/crypto/atmel-tdes.c                 |    2 +-
>  drivers/crypto/hifn_795x.c                  |    4 ++--
>  drivers/crypto/talitos.c                    |    8 ++++----
>  23 files changed, 60 insertions(+), 51 deletions(-)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
