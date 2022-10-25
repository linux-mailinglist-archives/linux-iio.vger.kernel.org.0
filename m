Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3060CDE7
	for <lists+linux-iio@lfdr.de>; Tue, 25 Oct 2022 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiJYNug (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Oct 2022 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJYNuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2022 09:50:35 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5A81123;
        Tue, 25 Oct 2022 06:50:33 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id g16so7521630qtu.2;
        Tue, 25 Oct 2022 06:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7T24Kfnz7eBUqb6vj0PiOGMiel3Iuuouv39UbUuao6A=;
        b=NyBteCpeyzZSiuAMNYrlsuIv4hnm4ohqjG6ZJcG70U5fXqe1FsK295yJujiWYlCzOx
         hXstflu/gPrSBc67/tHPV1w9c7FgVThfrBBfl6HmOfaBrHsEWjThJLvmnH74ChTR4wXb
         nEv1UHW20IhjEH4gF287r7yehx+2GIdO5kQMje0+mcV0QKsZskHE9e023QLfuDF9M3dA
         WMcuI5fI48v4+7/kL8rnODztmY3T4hR8ZwgqxdgCqTOEZSEau0RMEZQqzSPY+gzYsQsA
         trcwcAxqYdA1Q8tbc3/Jyvcp9PvvLnPUX6Qd4Nb978X2bB533pFp12JFTtA0XWTy2YQM
         mLAQ==
X-Gm-Message-State: ACrzQf0VsEdOLk7Lx9D2OYuNNSiRiC3O1AGZF9F9TF4mK/gpfrOlv9HY
        hZ1w2qGZmEqskvXPLcCu7MXU95fYQCZDWQ==
X-Google-Smtp-Source: AMsMyM5QJKbCgnxOeHZkYO+bVQM45mCh6wtyQBKKrxhIOTmhL9IQ42LuXx6mwI5U+DFblIk6fNNEhA==
X-Received: by 2002:ac8:5981:0:b0:39c:e03e:86ed with SMTP id e1-20020ac85981000000b0039ce03e86edmr32365215qte.503.1666705832659;
        Tue, 25 Oct 2022 06:50:32 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id b6-20020ac812c6000000b0039ccbf75f92sm1649064qtj.11.2022.10.25.06.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:50:32 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id j7so14619038ybb.8;
        Tue, 25 Oct 2022 06:50:31 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr32050471ybb.604.1666705831645; Tue, 25
 Oct 2022 06:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com> <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Oct 2022 15:50:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyTzJVCnTTT1XKzXjLCETFEEeyc6PVLLtvNRcmQuxOpg@mail.gmail.com>
Message-ID: <CAMuHMdVyTzJVCnTTT1XKzXjLCETFEEeyc6PVLLtvNRcmQuxOpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Mon, Oct 10, 2022 at 4:53 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add RZ/G2L MTU3 counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
>
> This patch adds 3 counters by creating 3 logical channels
>         counter0: 16-bit phase counter on MTU1 channel
>         counter1: 16-bit phase counter on MTU2 channel
>         counter2: 32-bit phase counter by cascading MTU1 and MTU2
>                   channels.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1986,6 +1986,14 @@ config MFD_RZ_MTU3
>           To compile this driver as a module, choose M here: the
>           module will be called rz-mtu3.
>
> +config MFD_RZ_MTU3_CNT
> +       tristate "RZ/G2L MTU3 counter driver"

"depends on COUNTER", else it fails to link.

> +       depends on MFD_RZ_MTU3 || COMPILE_TEST
> +       help
> +         Enable support for MTU3 counter driver found on Renesas RZ/G2L alike
> +         SoCs. This IP supports both 16-bit and 32-bit phase counting mode
> +         support.
> +
>  config MFD_STM32_LPTIMER
>         tristate "Support for STM32 Low-Power Timer"
>         depends on (ARCH_STM32 && OF) || COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
