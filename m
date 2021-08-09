Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4068A3E4608
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHINFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhHINFV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 09:05:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C361C061796;
        Mon,  9 Aug 2021 06:05:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id j77so29337135ybj.3;
        Mon, 09 Aug 2021 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hc21s6jA+fO3+n9I28OBHKaMgXfmcXARaC/ezel7U0=;
        b=J1BqMh+wbNjwpR/syWDWFESR9pwlu3Os0JaBxi70t0BuUsU1bOuf0my9Z9tUA+sIHb
         MotXFSzBF1Rw2OY7yvyPa43y0x3InFh/yiTcnN9ccYWKr1cRVTgldoEaZEsY/lE39xWr
         Zvp6NJaW+3XrSu0oO/jOw6BfDcxDIgDy6+HRbVNq50h2Qet8JimxDSDQ0hwY4Yk7vflt
         RyV9y7VwKAC89CLsEsn5Avgs2g6kfWn+BvdOedNii7GKoUJXby02wPMm7dk7JvAKL72m
         0qQ2jMnGUDW9Q3XMUlmgUe80kDLLrrR0+IdvlLTaRPLWOfV4KJINpM0MXJ4QIYONLCiy
         d+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hc21s6jA+fO3+n9I28OBHKaMgXfmcXARaC/ezel7U0=;
        b=nm4EJ24EDmALbu2rK9VmYbHWSLFQ8a+2MAnNxEP+19GiuL+T5vQC679ed7oa7uCSrC
         mdblrzCAGNW7/l2n/dQGNOSB8HONjbmldMSvPWUw6aMQiVsHhygHb1v4CDMjKwwkFMwu
         eptu3NuNvwWLwdFV3MheFNeaw/hc68YPKcVq7Za3yRdaXM2wDxChiiPw1I1n0jtVSi01
         C5sEIlyEQIdjcHGEvcB8WDWP5QWCfi9MGn3W+9z1vWb5ycPsUQ1bTwp0CZXjR8YdPlPU
         l6A39KVju24jFH8rmSpKFNXDMusSL5IWfAS0e0TrvyaM2I+TMfKFel+VjqewBcZtShF+
         ZWIw==
X-Gm-Message-State: AOAM531SDibcQJhnfplcRJy5E+i80ynXuJ0Ani8k1XfAFfeIh+jLuQda
        gVvkzmilAQHEuj8KL4sfozPsRddNQZbo44VQQ+w=
X-Google-Smtp-Source: ABdhPJwyXKyZS3tNvTA2B27dDqszt7alD3bvW8pIxu61Mple5XW1ExfZwH38ixLJlslu7lPnDGL56Ihq3Sy3LnFfzyE=
X-Received: by 2002:a25:ba44:: with SMTP id z4mr30401399ybj.476.1628514299333;
 Mon, 09 Aug 2021 06:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20210808180143.6b3dc882@jic23-huawei>
In-Reply-To: <20210808180143.6b3dc882@jic23-huawei>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 Aug 2021 14:04:33 +0100
Message-ID: <CA+V-a8v0P-Xds51o9yDq0W67rfpAmCt=y=8S8BRWz=mkXLvtHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Renesas RZ/G2L ADC driver support
To:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Aug 8, 2021 at 5:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed,  4 Aug 2021 21:21:15 +0100
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> > Hi All,
> >
> > This patch series adds ADC support for Renesas RZ/G2L family.
> >
> > Patches apply on top of v5.14-rc2.
> Hi Lad, I'm fine with this, but need to pull my tree forwards
> to include the header that is only in rc2.
>
> I'll probably do that later in the week then pick up patches 1 and 2.
>
Thanks.

Geert could you please pick patch 3/3.

Cheers,
Prabhakar

> Thanks,
>
> Jonathan
> >
> > Cheers,
> > Prabhakar
> >
> > Changes for v4:
> > * Fixed registering action to assert resets on failure/remove
> >   as reported by Philip.
> > * Fixed review comments suggested by Jonathan.
> > * Included RB tag from Rob for patch 1/3
> > * Note DTS patch applies on top of https://git.kernel.org/pub/scm/
> >   linux/kernel/git/geert/renesas-devel.git/log/
> >   ?h=renesas-arm-dt-for-v5.15
> >
> > Changes for v3 (as requested by Jonathan):
> > * Made use of FIELD_PREP()
> > * Renamed _CLEAR to _MASK and inverted inline as required
> > * Moved |= pair's on same lines
> > * Made use of sysfs_emit() while reading the labels
> > * Used for_each_bit_set() in rzg2l_adc_isr()
> > * Renamed rzg2l_adc_parse_of() -> rzg2l_adc_parse_properties()
> > * Used devm_add_action_or_reset() for asserting the reset signals and
> >   disabling pm_runtime and eventually removing remove() callback
> > * Added comments in isr handler for channel select interrupt
> > * Moved enabling/disabling of pclk during hw init in rzg2l_adc_hw_init()
> > * Dropped clock patch 3/4 (https://lore.kernel.org/patchwork/patch/1462152/)
> >   from previous series as its queued up in renesas-clk-for-v5.15
> >
> > Changes for v2:
> > * Update binding doc, dropped gpios/renesas-rzg2l,adc-trigger-mode
> >   properties included channel property to represent each wired channel.
> > * Fixed review comments pointed by Alexandru, implemented pm runtime
> >   support, dropped mlock usage
> > * Fixed review comments pointed by Jonathan, renamed the macros,
> >   simplified the code.
> > * Included clock and DT patches
> >
> > v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> >     20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Lad Prabhakar (3):
> >   dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L
> >     A/D converter
> >   iio: adc: Add driver for Renesas RZ/G2L A/D converter
> >   arm64: dts: renesas: r9a07g044: Add ADC node
> >
> >  .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++
> >  MAINTAINERS                                   |   8 +
> >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  42 ++
> >  drivers/iio/adc/Kconfig                       |  10 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/rzg2l_adc.c                   | 600 ++++++++++++++++++
> >  6 files changed, 795 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
> >  create mode 100644 drivers/iio/adc/rzg2l_adc.c
> >
>
