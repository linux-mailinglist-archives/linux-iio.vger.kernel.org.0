Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BA975FAC3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 17:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGXP1M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 24 Jul 2023 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjGXP1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 11:27:10 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B6E54;
        Mon, 24 Jul 2023 08:27:05 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5127432276.2;
        Mon, 24 Jul 2023 08:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212424; x=1690817224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgT/sZBWMw7isGeHL7F4RHbJ7NKzRh0uL4XoGCp4yU4=;
        b=R15q75v0uWFontoLj6VPrEudwTJN1z3y90qMGhp+Z/X+VfL3n39Pp2x/DD5YG57EO5
         VOhF9dbvmPa1KM/71Z7G+hriF8z4N7R+lomF4kCt8KNJDs9WOpcapupKbJci9Di1X7wN
         xoZAtQ0Ionre30JqUnAeBMIgJGiuxlAFQzFX9eawYbc8aTKJGYtSw3MAopYLfEdO5ZxE
         M1+9Lbb2VwOiO+RtVv1Kk3EflzQ7DP/Fkh4a8QzycQsgKAeaHAaVkBNx2QyHixowO8o0
         Xi6fAlxK7wz3NW04DgyFZPEb83HVxx+AVA/5APdrfze4+E+UWsANyJzXsBnr4dW5O3UK
         fcSg==
X-Gm-Message-State: ABy/qLbzLDjmNCfF1yak1KqPsum1sdEOkgOFPtkgglSjmB35kb5vx0ou
        QTUM7SvJX52D2o38HUTvfxrRSLCOkaxYOg==
X-Google-Smtp-Source: APBJJlFqeTGK+cOHF7tbtiawbQnUbsAOigBhQ7FNN0IfwZ91dnWFPHr7/CpXVRUY8XCMwVfKMBTIHQ==
X-Received: by 2002:a25:6a87:0:b0:cfd:58aa:b36e with SMTP id f129-20020a256a87000000b00cfd58aab36emr9013627ybc.9.1690212424293;
        Mon, 24 Jul 2023 08:27:04 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id c13-20020a25c00d000000b00c64533e4e20sm2379830ybf.33.2023.07.24.08.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:27:03 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ccc462deca6so5135303276.0;
        Mon, 24 Jul 2023 08:27:03 -0700 (PDT)
X-Received: by 2002:a25:48c7:0:b0:c12:29ac:1d3c with SMTP id
 v190-20020a2548c7000000b00c1229ac1d3cmr8528599yba.6.1690212423317; Mon, 24
 Jul 2023 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com> <20230724091927.123847-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230724091927.123847-4-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 17:26:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW9XynFaOrvWZ50FYthQYQFYtyFMOTwPX_tzXK2bB=4HQ@mail.gmail.com>
Message-ID: <CAMuHMdW9XynFaOrvWZ50FYthQYQFYtyFMOTwPX_tzXK2bB=4HQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: timer: renesas,rz-mtu3: Document
 RZ/G2UL SoC
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

Hi Biju,

On Mon, Jul 24, 2023 at 11:19 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add MTU3a binding documentation for Renesas RZ/G2UL SoC.
>
> MTU3a block is identical to one found on RZ/G2L, so no driver changes are
> required. The fallback compatible string "renesas,rz-mtu3" will be used
> on RZ/G2UL.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> @@ -109,6 +109,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043-mtu3  # RZ/G2UL
>            - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
>            - renesas,r9a07g054-mtu3  # RZ/V2L
>        - const: renesas,rz-mtu3

As patch 5/6 applies to both RZ/G2UL and RZ/Five, I think you should
add "and RZ/Five", too.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
