Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB75D3CD050
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhGSIef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:34:35 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:42554 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbhGSIee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:34:34 -0400
Received: by mail-ua1-f53.google.com with SMTP id z3so3115790uao.9;
        Mon, 19 Jul 2021 02:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbF3u8VOKIMWOyNH3C/YrjfY9jYpaj5M8r+Rgi/tb8s=;
        b=M+Zu4VoVAaWGSCtS4KG2G4OTtv7C5wy6wCiBav3wEv+Pbd2YqW3s21ijFdIUp5Ot7m
         0EWG71mA/6G9Vs/5J92VkYyedXnk14Xuv7YznUg93LkU3az4dKEFp1gxvCMiUIZOFG8p
         djScmxgYxhZjvkXDRgJCazY6/0aNdX85vy8MgRnZDXo+Z0m/fP/pIALeGWAtCygBd06E
         mHxccL2n1+zbapG207RZXasgi/yyx/IuavT4MJhnaM7TC8J3sT2ehryEKK1oJ5ycrxx0
         6WQoyDXbOPSLvXx3aeNpHcNfHn5uU+/CAxLKask+MDLwari5Lorp7brieYwJO7hZasWl
         Q+GQ==
X-Gm-Message-State: AOAM5337k4q3zRHvepoP3qhJWiobSp5xgebLpmfsxZcMYIY003DN1kLR
        WxC+Rqx1g8IIN+lfvNt8NgbN2oYRLlHLBmjSPRs=
X-Google-Smtp-Source: ABdhPJzJUZYQw1ZZguOMz+6slZH4/cZSax+cq37DZFKc6MU6SHmtRn7UuHySQFUoPVTNIcLJPZZN+iY9ivpPweI1cWQ=
X-Received: by 2002:a9f:3649:: with SMTP id s9mr24652061uad.2.1626686114123;
 Mon, 19 Jul 2021 02:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210719085840.21842-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210719085840.21842-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210719085840.21842-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jul 2021 11:15:03 +0200
Message-ID: <CAMuHMdW6vsJ_wg9JPn5jnmJ8q1LxD5s8ai-kdFmkc8joGFe6+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] clk: renesas: r9a07g044-cpg: Add clock and reset
 entries for ADC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 10:59 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add clock and reset entries for ADC block in CPG driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v5.15.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
