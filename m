Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971875FA85
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGXPQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 24 Jul 2023 11:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXPQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:16:10 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B012F;
        Mon, 24 Jul 2023 08:16:09 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a412653335so2675342b6e.1;
        Mon, 24 Jul 2023 08:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690211768; x=1690816568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpXuxaV34rBhicGHhtw7Bd3yzyZnGUUvA7xIa8CPKGQ=;
        b=LS52u55fINavuHdrFZuBW+fmedJwfDPMmlq0c9ePN3xDoWoEI71dQ7m8hfR0imQxYc
         btLvaXrWcogsO4AInXXBTy2z0nRDHbu8ZjOud8inc3mxDuxDMtNqbvyU6plLFmZta6Qh
         p4zZis36pAKnrzmajE0rXnajeJ2FS8H8nAtrWMse8FW0AoAoEBoMTOCuK3t1v6vG4zwH
         XFxnOpZjKlirTXxqbnCyspy08nqbvwHdeT8NJBT9F/cEcfLXfWndFVgArOsBzL6bUAEw
         QvzCFSEY6nkZ7iFPzh2tt3DV235nHkOig8XgIo9231hpB2IhXokE2yReWHMqBt7Q3tz7
         +HXQ==
X-Gm-Message-State: ABy/qLaa+DfmD1muBn0tC2oP2qrliTsUpK4AdCEuzP67hgU7aNAYLjFK
        rXhl4uloTeTxZkErmCz/5qz3yD5i06qTcg==
X-Google-Smtp-Source: APBJJlH1b2rPgbmALwEkZDFmqyJ0IO9a+0NOTNchjI1bhq/u/43WGrs/lm3RdoVQQELjyYhQ7ZrmZw==
X-Received: by 2002:a05:6808:5c5:b0:3a1:f36c:3fdb with SMTP id d5-20020a05680805c500b003a1f36c3fdbmr10627793oij.47.1690211768403;
        Mon, 24 Jul 2023 08:16:08 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id bp11-20020a056808238b00b0039ee0bd8a11sm4140167oib.42.2023.07.24.08.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:16:07 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a3fbfb616dso2670957b6e.3;
        Mon, 24 Jul 2023 08:16:07 -0700 (PDT)
X-Received: by 2002:a05:6808:178d:b0:39e:a606:544e with SMTP id
 bg13-20020a056808178d00b0039ea606544emr13545832oib.32.1690211767502; Mon, 24
 Jul 2023 08:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com> <20230724091927.123847-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230724091927.123847-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 17:15:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1MpE+m+=pBxMQifmScYHd+Z5RkjGXkbZB+peLLQNUcg@mail.gmail.com>
Message-ID: <CAMuHMdU1MpE+m+=pBxMQifmScYHd+Z5RkjGXkbZB+peLLQNUcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: timer: renesas,rz-mtu3: Improve documentation
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>
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

On Mon, Jul 24, 2023 at 11:19 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Fix the documentation issues pointed by Pavel while backporting
> it to 6.1.y-cip.
>  - Replace '32- bit'->'32-bit'
>  - Consistently remove '.' at the end of line for the specifications
>  - Replace '          (excluding MTU8)'-> '(excluding MTU8)'
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235.183132-3-biju.das.jz@bp.renesas.com/

Wrong link.

    Closes: https://lore.kernel.org/all/ZH79%2FUjgYg+0Ruiu@duo.ucw.cz

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
