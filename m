Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D09760D9F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jul 2023 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGYIxl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 25 Jul 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjGYIxE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2023 04:53:04 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE071BFF;
        Tue, 25 Jul 2023 01:52:39 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-583c48a9aa1so29279497b3.1;
        Tue, 25 Jul 2023 01:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275159; x=1690879959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDr9hS6khTUlmm2vbG4nmWvTWrQEOKQO3wf8w3RM/ow=;
        b=hHIvUiipTxKyWhY4nevZK/WBRWPlFAWYmPhUvCJGtJLtzP01oJiTNdx/KSlT/9MfTH
         iAa2d6PcjDX/gttiLilLVUKDrCuEiLBquyiZ0jLSYGo+LzXHqlpPAcniDGIGkT9POTXi
         PRoOwCsYkpbghijMV4asBH3rN1TpuFNIG7C6zQr7tC1o79Xe2a8sgdJ9m//n0fhYUu9H
         mDdGE4ScRF9vWZ+fM0S4YXh5vg95UtDFhecMGQKHuNo6xD7rhZRauOglJNoknne8Rcrw
         NTgGKnsyFdun3pNKunnXzK1WdjvOkWk+QD4RJIyrgQzwU004buWDvZKwpeFrjPotvac1
         jhIA==
X-Gm-Message-State: ABy/qLbxXMD3JiMcI8haVD5TB4/zW3bWy9B0mP6vqwM9YQPcIrKeKKW+
        bK+/CIk0oIgeT522lVlUsCgn1Plut1Es20Bc
X-Google-Smtp-Source: APBJJlF85U+dLq3Q63S8ocHlNvelLsEfTzI1+DFdV5dA/ukduiTbGmMt1b73Yk5Fh4+PD7v6xXVGyw==
X-Received: by 2002:a0d:d757:0:b0:576:bfc7:1e43 with SMTP id z84-20020a0dd757000000b00576bfc71e43mr7937492ywd.25.1690275158704;
        Tue, 25 Jul 2023 01:52:38 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id q128-20020a818086000000b0055a07c7be39sm3425386ywf.31.2023.07.25.01.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:52:37 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so4474426276.0;
        Tue, 25 Jul 2023 01:52:37 -0700 (PDT)
X-Received: by 2002:a25:b327:0:b0:d07:d88b:4843 with SMTP id
 l39-20020a25b327000000b00d07d88b4843mr6854583ybj.20.1690275157049; Tue, 25
 Jul 2023 01:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com> <20230724091927.123847-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230724091927.123847-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 10:52:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWXN2GWeSoG-5Ht66zaR8Y0EzUUh7_5+4Hmtf_YOGpVNQ@mail.gmail.com>
Message-ID: <CAMuHMdWXN2GWeSoG-5Ht66zaR8Y0EzUUh7_5+4Hmtf_YOGpVNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        stable@kernel.org, Conor Dooley <conor.dooley@microchip.com>
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
> As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> interrupt names starts with 'tci' instead of 'tgi'.
>
> Fix this documentation issue by replacing below overflow/underflow
> interrupt names:
>  - tgiv0->tciv0
>  - tgiv1->tciv1
>  - tgiu1->tciu1
>  - tgiv2->tciv2
>  - tgiu2->tciu2
>  - tgiv3->tciv3
>  - tgiv4->tciv4
>  - tgiv6->tciv6
>  - tgiv7->tciv7
>  - tgiv8->tciv8
>  - tgiu8->tciu8
>
> Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a bindings")
> Cc: stable@kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v1->v2:
>  * Added Ack from Conor Dooley.

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml

> @@ -197,18 +197,18 @@ properties:
>        - const: tgib6
>        - const: tgic6
>        - const: tgid6
> -      - const: tgiv6
> +      - const: tciv6
>        - const: tgia7
>        - const: tgib7
>        - const: tgic7
>        - const: tgid7
> -      - const: tgiv7
> +      - const: tciv7
>        - const: tgia8
>        - const: tgib8
>        - const: tgic8
>        - const: tgid8
> -      - const: tgiv8
> -      - const: tgiu8
> +      - const: tciv8
> +      - const: tciu8

According to the documentation, there is no underflow interrupt for
channel 8?

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
