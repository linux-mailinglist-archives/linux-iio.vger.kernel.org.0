Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D3755EC9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjGQIxD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 17 Jul 2023 04:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQIxC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 04:53:02 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDAE4B;
        Mon, 17 Jul 2023 01:53:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-577ddda6ab1so60517547b3.0;
        Mon, 17 Jul 2023 01:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689583980; x=1692175980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESokity3SjM9JRRMG/QaRj+skICfRvp6MwvJNIUhFH4=;
        b=Ovn3BB2LPl4m875AqX0uqIA7V6V/7QLRG1RWu/l7FQD79xJ0cs7aES7nlM94WlBOmo
         0VjUe+YoLW5DoYlT0vpyh8ta4H66+wwKJ9DqAizk+iFYwJ52Y+2p+BaJpWfDh4uw4E0Q
         jntM2hkxGh6kersBXeOPsSgE9SjjyV1OxmVoyESSrLHQmvu48kXftpvwuTTKDUMU86uk
         rQIM7w49fueeCMzLTJBzBR2QdNiY1oEIBs5WIc8fFvIc1m0WzF4jPY0wCta+EhmPypGB
         gmm8Y1l/TBmCNmScOEyI4oXhZrBxxx/88ApLK3+sV5oI+jM08ut2kiOUdc++SImbdFhy
         5Ceg==
X-Gm-Message-State: ABy/qLarGjQC0JoR6i3ZWdKWm8PEFQFPudqXlRcY30rEi7AWc2TEk6jd
        y6bjQ1UBzhTzVgGeWD8vGAtK2FW+wzoaow==
X-Google-Smtp-Source: APBJJlFOBLk7RmpXcUFPNPnAUKR0l0E3APRtnwBttK5/AIwQtSBqYOT3osLFDlnUmEpgoscA25ceuA==
X-Received: by 2002:a81:4915:0:b0:577:186c:2a3c with SMTP id w21-20020a814915000000b00577186c2a3cmr9993078ywa.19.1689583980162;
        Mon, 17 Jul 2023 01:53:00 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id r186-20020a0dcfc3000000b005772b76cb18sm3744731ywd.4.2023.07.17.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:52:59 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so6052856276.1;
        Mon, 17 Jul 2023 01:52:59 -0700 (PDT)
X-Received: by 2002:a25:df0c:0:b0:cb2:7e6:191c with SMTP id
 w12-20020a25df0c000000b00cb207e6191cmr11645536ybg.20.1689583979097; Mon, 17
 Jul 2023 01:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230716175218.130557-1-biju.das.jz@bp.renesas.com> <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230716175218.130557-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 10:52:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdhm_XZU8ShNCmHUGz0fbk5gfTA2yznR_15NvfEUFuNw@mail.gmail.com>
Message-ID: <CAMuHMdUdhm_XZU8ShNCmHUGz0fbk5gfTA2yznR_15NvfEUFuNw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: accel: adxl313: Use i2c_get_match_data
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        linux-iio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 16, 2023 at 7:52 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() as we have similar I2C and DT-based matching table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
