Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56CA3E573B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHJJm6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 05:42:58 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:39912 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhHJJm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Aug 2021 05:42:58 -0400
Received: by mail-vs1-f48.google.com with SMTP id e9so4078356vst.6;
        Tue, 10 Aug 2021 02:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/tYYo2Z6spIhPtXgeWag3qiDL9Iy4IctEOMzGPqf4c=;
        b=Ivz9HqSU3EWvttlXeFk2QekAq8JxFJD4Qngchi5UbvMG/mpNoI73UxG8W0BzDVMhyl
         aUTXnMXsI+ZbrbBgN9yv+irILWWjwmYUZwlesFBkx40liC502v9gLt2aDRjAfYSCKrtT
         CHK1uat+lCSlJDYS9/h1u5J3arjUDEi2TLquv3pXD0hesT2eLZNvZcK7xdPF67AqgnAL
         Fu//BPdrvMWgV9zYS33IN5q5Wvj6HyRM7z8TNUzDPbkPNugLCNE4yh8vlJAKZ4oWCllr
         ENCerUX+kfXoEWkNzQP8syDuA4gA5LVODBtB3uYNQE9kAk14XVXXxlBPWWL/snBKBO3h
         jLvQ==
X-Gm-Message-State: AOAM533zyzihy3Vs87R0w2CvC/StuZ/5L2IjJ/RRW5OHAUPOJ5+K0MyH
        Nj0Zsvfbm2l1eFKwoz1aP95zKyUOCVh9SX4/yg0=
X-Google-Smtp-Source: ABdhPJzamjRgVDnBjllQxrIMeUoWJVZlIiNyYeI98AHv43IE8hW2VoO+jy2qQ/Hff2SjphwZImL4xtC+CPWOIgSTZg0=
X-Received: by 2002:a67:e2c7:: with SMTP id i7mr20089364vsm.3.1628588555703;
 Tue, 10 Aug 2021 02:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210804202118.25745-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210804202118.25745-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Aug 2021 11:42:23 +0200
Message-ID: <CAMuHMdU-gnyOCKaYKb2nVy41rdWzuixJ6j11t5FMwMMa85yHjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: renesas: r9a07g044: Add ADC node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Prabhakar,

On Wed, Aug 4, 2021 at 10:25 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add ADC node to R9A07G044 (RZ/G2L) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> @@ -169,6 +169,48 @@
>                         status = "disabled";
>                 };
>
> +               adc: adc@10059000 {
> +                       compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
> +                       reg = <0 0x10059000 0 0x400>;
> +                       interrupts = <GIC_SPI 347  IRQ_TYPE_EDGE_RISING>;

Double space after 347.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.15 with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
