Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF175FA26
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGXOsH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 24 Jul 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGXOsG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 10:48:06 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA3010D1;
        Mon, 24 Jul 2023 07:48:05 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-583f036d50bso15354277b3.3;
        Mon, 24 Jul 2023 07:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210085; x=1690814885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIjA4L8NiFXUPA17fZobqu05oUAZ5QDo9YRT9rAXmPM=;
        b=fvTIgqbT3cePK/pTI16460BB1ps8VPJkbrczqNFoWYythbVA7YtxZMSXaB9FlsKmCL
         0fDqRVgsw0+15mBYeeeLjAfCvVWkbsp6+n9PZSIfqiyKZ9CPH/Avg0ihsIgJ/hokgBnz
         HWy0KeS74KzZixFTDM1Pghkh3OqdlTJqO2qwb81BGtIJUSfgiYcp9gZCXO2h8/AhQiV4
         yj3bleBv9aT1jXE6pCn5HsBrTY6LV0JlXQjU0IKVCr+OJxPoMvwqwPadWYuYybCcSX+z
         Y/UaNXBtoGoxIwlf4FtPZZsTsKSTdz5QHjxkIaJR1AMkNJjQj9WS6ZMGE7A9y3jKUSYm
         XVCA==
X-Gm-Message-State: ABy/qLbfo+6EL/8hlICg0T9836bb5RAvBPut/OrKTDCUj+CQrKnGJK8P
        u0T28CP9R7GDYwJrKXg+7k0BRAyRMCbXOw==
X-Google-Smtp-Source: APBJJlFhcv2A5gjEUzedGQE7ZzRYClGJtWTYePfF1BCLLLZIELwvQISUXmPya7Goi8e50C00H/qIYg==
X-Received: by 2002:a81:918b:0:b0:580:bd0d:809f with SMTP id i133-20020a81918b000000b00580bd0d809fmr9107170ywg.18.1690210084737;
        Mon, 24 Jul 2023 07:48:04 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id x76-20020a0dd54f000000b00583fdbfa001sm429548ywd.98.2023.07.24.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 07:48:04 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5083542276.2;
        Mon, 24 Jul 2023 07:48:04 -0700 (PDT)
X-Received: by 2002:a25:c794:0:b0:d06:2494:ef77 with SMTP id
 w142-20020a25c794000000b00d062494ef77mr8609557ybe.16.1690210084004; Mon, 24
 Jul 2023 07:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230721153933.332108-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230721153933.332108-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 16:47:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU6PFqF-NLB7LdA4LLAN7VfSTwDg2iHFtc5GR+riQp4eg@mail.gmail.com>
Message-ID: <CAMuHMdU6PFqF-NLB7LdA4LLAN7VfSTwDg2iHFtc5GR+riQp4eg@mail.gmail.com>
Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: Reorder locking sequence for consistency
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thanks for your patch!

On Fri, Jul 21, 2023 at 5:39 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> All functions except rz_mtu3_count_enable_write(), calls

call

> pm_runtime_{get,put} inside the lock. For consistency do the same here.
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-6-biju.das.jz@bp.renesas.com/

This is not a direct link to Pavel's report, but to the bread started
by your patch.  Why not a link to lore?

Closes: https://lore.kernel.org/r/ZH8Fmom8vZ4DwxqA@duo.ucw.cz

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit header to make it clear this is not addressing a bug,
>    rather it's just cleanup.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
