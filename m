Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596DE75FA70
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjGXPJw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 24 Jul 2023 11:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXPJv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:09:51 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4F5E47;
        Mon, 24 Jul 2023 08:09:50 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a5ad4477a7so1182378b6e.1;
        Mon, 24 Jul 2023 08:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211390; x=1690816190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0acs+4a5WYJPeRT1HjzD3q2LLHzyM9+GkJFO0guogs=;
        b=ko3De3SCCCdV/l3AabrWYjNNniYIPo/0b1pneId79VCpJ4ODInuP8zDNV81B5qJ1cp
         sj9T2itkAzUbXMMj5hSsKkP1SbPpGUbndOa52nY9s8pNqUcNRcnMSTXbcyJDJaqcAMET
         WKhNhdxiaonBTmlEUflLodj2s0Ud/h9k/vEU4yog35fKHf60aB6U0IhBJuazkkozg2lm
         w/Pb3WMf+D2jfXQeq1jSMAm6KZR4dPpzUiDJEYltNXnKqHYi8alFSqBiGQeA3dhS3D3W
         VZM/LF6REx1HhLZQQQdYX2f1krT0BxbgDmGcApzNbbFaM/fzrF89tMl18g6SwYzfhmNV
         QnXw==
X-Gm-Message-State: ABy/qLbzt1ZV6agE+5KDetZALOayfAakvvsm5b/IooVgi5aA31ukkneh
        5xE1t7DHmxGIQeDmYp5E0zTrUpQrQCNzuQ==
X-Google-Smtp-Source: APBJJlFLq4UcvSvJYy1Zm5jl32Gi4IzOLSheVZQOernfw3FDLCdFtk44hOT8QwvsuukBYB1SGtwZSw==
X-Received: by 2002:a05:6808:1148:b0:3a4:8e9b:e5e7 with SMTP id u8-20020a056808114800b003a48e9be5e7mr10533110oiu.46.1690211389602;
        Mon, 24 Jul 2023 08:09:49 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id 14-20020aca090e000000b003a414415693sm4138646oij.44.2023.07.24.08.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:09:48 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a44fae863fso3016895b6e.0;
        Mon, 24 Jul 2023 08:09:48 -0700 (PDT)
X-Received: by 2002:a54:410c:0:b0:3a2:f91a:cb08 with SMTP id
 l12-20020a54410c000000b003a2f91acb08mr8183204oic.42.1690211388576; Mon, 24
 Jul 2023 08:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230722200718.142366-1-biju.das.jz@bp.renesas.com> <20230722200718.142366-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230722200718.142366-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 17:09:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWJyHB8zop-JpvOo1-xAkqUyjFk02v5JkeNFDaM4LUUQ@mail.gmail.com>
Message-ID: <CAMuHMdVWJyHB8zop-JpvOo1-xAkqUyjFk02v5JkeNFDaM4LUUQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: adxl313: Fix adxl313_i2c_id[] table
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        George Mois <george.mois@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 22, 2023 at 10:07 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The .driver_data in adxl313_i2c_id[] for adxl312 and adxl314 is
> wrong. Fix this issue by adding corresponding adxl31x_chip_info
> data.
>
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://patchwork.kernel.org/project/linux-renesas-soc/patch/20230716175218.130557-3-biju.das.jz@bp.renesas.com/#25436658

Why not a link to lore?

    Closes: https://lore.kernel.org/all/20230722172832.04ad7738@jic23-huawei

> Fixes: a7a1c60bc4c9 ("drivers: iio: accel: adxl312 and adxl314 support")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
