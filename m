Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F4522EFD
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiEKJIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiEKJIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 05:08:51 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26AA2CC88;
        Wed, 11 May 2022 02:08:50 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id m1so1800844qkn.10;
        Wed, 11 May 2022 02:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhYQv27JmheN+IIAmT/S+0BaIl0u3hjG9Yztl7Q3bYI=;
        b=TZuPmOW70TUB+sleb5ZQWdRJQPFjoLL1L76Pr20kFnVei9sysu9k2O/m96cm+ckz2q
         DupDFQRI2E1ZRtMrQgIWmpuTasgbcYgfothSwi8dTqF/9ASeXV5zB183uVm7KymqEgUX
         bBDbEEWsgn+JUsF+smryPSN0D0It+/3Z4eGwtu3FJkz8+Ljk+vm3ICWho44fXPvfZ2a7
         P3oTbV7uMEEyM8aV7aZ3LDBFYcqhzpvQjVb0QRbo8DUggq/Vv9jdlMNKzR019gUCaqqW
         php8NQQcuIrhQxiI/0o269ppFwoW2JKGd2E5HsMf3l/RoKjqKmPmV5u57jisqzXiqtHj
         5RXQ==
X-Gm-Message-State: AOAM530GwRAIZsdYyHPWabd/N2gPjpB63x3CeBw1Gc6bwL1/2z09c5/W
        LJQDYQ47bOdgt8sbFp6mrpgSFClpH3Idog==
X-Google-Smtp-Source: ABdhPJxg1WI5OjXgKAjZqUrH7ZuN7HnyAf6ZevH92l8Hj5iZ3vCB+TFgdvEUzMVOaRMav2ryCEgAsQ==
X-Received: by 2002:a05:620a:4449:b0:6a0:3f3c:c29d with SMTP id w9-20020a05620a444900b006a03f3cc29dmr18117946qkp.25.1652260129575;
        Wed, 11 May 2022 02:08:49 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id v3-20020ac85783000000b002f39b99f6b8sm873292qta.82.2022.05.11.02.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:08:48 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id w187so2780962ybe.2;
        Wed, 11 May 2022 02:08:48 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr22009190ybb.202.1652260128075; Wed, 11
 May 2022 02:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220511082325.36185-1-biju.das.jz@bp.renesas.com> <20220511082325.36185-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220511082325.36185-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 May 2022 11:08:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpfV-u6Yk+J_fhh1pYd4+uPdJRhv2C4Zr7ajaQdzzDxQ@mail.gmail.com>
Message-ID: <CAMuHMdXpfV-u6Yk+J_fhh1pYd4+uPdJRhv2C4Zr7ajaQdzzDxQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 11, 2022 at 10:23 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
> to RZ/G2L, but it has 2 analog input channels compared to 8 channels
> on the RZ/G2L.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Removed unnecessary SoC specific reg description as it is
>    equivalent to the logic used in reg.
>  * Removed Items from reg.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
