Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C0780EE5
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378043AbjHRPPs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Aug 2023 11:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378093AbjHRPPU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:15:20 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE43A4215;
        Fri, 18 Aug 2023 08:14:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58fa51a0d97so523887b3.3;
        Fri, 18 Aug 2023 08:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371692; x=1692976492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kFRmkOh3XuMA2gWBBRIRaAERRIZ+1fGvWjwZ6Mr+RA=;
        b=d92uu+H8mcVvEd0LMdT3elhtK/VaybTRi/T97jfDOgmtewbp98OJsTHkVE+grjHeIQ
         I/yZKgXXWrVwM0AwZFpMnEEZvKffQ0FyBInVqg+j26pSQN/O2eHc/MqJmnDJ8hwHUEhY
         K4vTZoyBSi6jKAG6mTLTik+Dt3qwqALz8bTG/VBvDWCEctMm3YXIGBiCMqZxOaAcgUGj
         T5baMfZHiEhgIeGs0a/f1g79/KKYNJxUT7S+EkstqicjSc2icKPqP5pMc3cACRXIjLQS
         cCoFgPn5VcxOGFLG+n0cHs1KlidamCSxNxkBno4Tgqyv7vme5VBZ5pbh+VvCyEclD7K3
         c5Yw==
X-Gm-Message-State: AOJu0Yx6vAYtMb67EHNXpfSVrx7XFrHueIW5uBrVBvMmjrRyPTdw9V4H
        +Unh0QQHKenNQG8CUGo9KGlXNYF3dvVbFzOY
X-Google-Smtp-Source: AGHT+IHGIxaNZYH94t6VLkphLLB/TjYpWIizpfEfVI4HRNpCpat/Z3psadibj6yBYz0xfhn21va97g==
X-Received: by 2002:a81:77d6:0:b0:576:8a5a:87e5 with SMTP id s205-20020a8177d6000000b005768a5a87e5mr2916934ywc.26.1692371691817;
        Fri, 18 Aug 2023 08:14:51 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id h6-20020a816c06000000b005707f542f62sm547522ywc.25.2023.08.18.08.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:14:51 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so990841276.0;
        Fri, 18 Aug 2023 08:14:51 -0700 (PDT)
X-Received: by 2002:a25:86cd:0:b0:c1a:5904:fe8e with SMTP id
 y13-20020a2586cd000000b00c1a5904fe8emr2927238ybm.34.1692371691436; Fri, 18
 Aug 2023 08:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com> <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230818075600.24277-4-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 17:14:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU26kSUJYb_=hyTZ3DoUYHQ3tZmv7cxKw2n672zRYzVxA@mail.gmail.com>
Message-ID: <CAMuHMdU26kSUJYb_=hyTZ3DoUYHQ3tZmv7cxKw2n672zRYzVxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: magnetometer:
 asahi-kasei,ak8975: Drop deprecated enums
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thanks for your patch!

On Fri, Aug 18, 2023 at 9:56 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Drop deprecated enums from bindings as it is been here for a long time.

The single user ever in the upstream kernel was fixed in commit
9846210b1ec9bbaa ("ARM: tegra: seaboard: add missing DT vendor
prefixes") in v3.8 back in 2012.
And it had to be fixed again 9 years later in commit fa0fdb78cb5d4cde
("ARM: dts: am335x: Use correct vendor prefix for Asahi Kasei Corp.").

>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> @@ -18,13 +18,6 @@ properties:
>            - asahi-kasei,ak09911
>            - asahi-kasei,ak09912
>            - asahi-kasei,ak09916
> -      - enum:
> -          - ak8975
> -          - ak8963
> -          - ak09911
> -          - ak09912
> -          - ak09916
> -        deprecated: true
>
>    reg:
>      maxItems: 1

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
