Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10E760F59
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jul 2023 11:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjGYJe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 25 Jul 2023 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjGYJee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jul 2023 05:34:34 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6B31FFF;
        Tue, 25 Jul 2023 02:33:09 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-583a8596e2aso38627587b3.1;
        Tue, 25 Jul 2023 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690277538; x=1690882338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxiEHcyRSdeO5cMoHU/dEJabT+bEe1KQ+YDB392Zv7Y=;
        b=b2UdOC59CIbKxvFxhNmNMFsqhh1htJ9fsbXgGkV75XoBf5E9vm1ZBWyT22duPvPYZL
         u/I+I0U6g27h7T9bgiiFZ4r8IKvPVX1Z9cIcqC0Bg3H+O7LalbVY6pQSW3kZci4ztZjR
         dIyR7qxKkbCrk6EcRkrvasU1SFTLcvjPeVV1OGUMwkwBZbVvoGrCVoLCW/m2c9EkP4Od
         k1gP3dfY31ewVswTHb0cws9jRyfmo5P8EC17+3lsXg/9VjJeD4CNiwKzDA5Gos+BoxsX
         reQ8QADJPb169jetHAblcR26cs+dUEiXMyblC/uUno36whAVGV4IJZbcN/CNxVoLfO48
         iJAQ==
X-Gm-Message-State: ABy/qLYmVJtWmKzrIGkMReIKgM9V30NUj2ftV7BWMFzIZ6aTnwa/b9N4
        UIuHamptcYf5hWI3HSqd3eJaNmp0VVoJGUdJ
X-Google-Smtp-Source: APBJJlH6YNej8fqCsvbYX8p9h6nATyTSIHw1y+Yf9XbqoH9UJnt8z5y2QA7/9s7i8v+UkaHyDjpAZw==
X-Received: by 2002:a0d:c8c7:0:b0:57d:24e9:e7f3 with SMTP id k190-20020a0dc8c7000000b0057d24e9e7f3mr7540370ywd.38.1690277538130;
        Tue, 25 Jul 2023 02:32:18 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id x186-20020a0dd5c3000000b00565cf40238csm2383532ywd.110.2023.07.25.02.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:32:17 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso4464694276.1;
        Tue, 25 Jul 2023 02:32:17 -0700 (PDT)
X-Received: by 2002:a25:5050:0:b0:d06:a4f3:4b04 with SMTP id
 e77-20020a255050000000b00d06a4f34b04mr7704105ybb.21.1690277537279; Tue, 25
 Jul 2023 02:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230724091927.123847-1-biju.das.jz@bp.renesas.com>
 <20230724091927.123847-3-biju.das.jz@bp.renesas.com> <CAMuHMdWXN2GWeSoG-5Ht66zaR8Y0EzUUh7_5+4Hmtf_YOGpVNQ@mail.gmail.com>
 <OS0PR01MB59225A1EFC3FDECEA8803B498603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59225A1EFC3FDECEA8803B498603A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 11:32:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKBuX_FN01LAdKkZi0qa2n+abeU3apHCYDT1W9KdG1cA@mail.gmail.com>
Message-ID: <CAMuHMdVKBuX_FN01LAdKkZi0qa2n+abeU3apHCYDT1W9KdG1cA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "stable@kernel.org" <stable@kernel.org>,
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

On Tue, Jul 25, 2023 at 11:11 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On Mon, Jul 24, 2023 at 11:19 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> > > interrupt names starts with 'tci' instead of 'tgi'.
> > >
> > > Fix this documentation issue by replacing below overflow/underflow
> > > interrupt names:
> > >  - tgiv0->tciv0
> > >  - tgiv1->tciv1
> > >  - tgiu1->tciu1
> > >  - tgiv2->tciv2
> > >  - tgiu2->tciu2
> > >  - tgiv3->tciv3
> > >  - tgiv4->tciv4
> > >  - tgiv6->tciv6
> > >  - tgiv7->tciv7
> > >  - tgiv8->tciv8
> > >  - tgiu8->tciu8
> > >
> > > Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a
> > > bindings")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > v1->v2:
> > >  * Added Ack from Conor Dooley.
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> >
> > > @@ -197,18 +197,18 @@ properties:
> > >        - const: tgib6
> > >        - const: tgic6
> > >        - const: tgid6
> > > -      - const: tgiv6
> > > +      - const: tciv6
> > >        - const: tgia7
> > >        - const: tgib7
> > >        - const: tgic7
> > >        - const: tgid7
> > > -      - const: tgiv7
> > > +      - const: tciv7
> > >        - const: tgia8
> > >        - const: tgib8
> > >        - const: tgic8
> > >        - const: tgid8
> > > -      - const: tgiv8
> > > -      - const: tgiu8
> > > +      - const: tciv8
> > > +      - const: tciu8
> >
> > According to the documentation, there is no underflow interrupt for
> > channel 8?
>
> I got confirmation from HW manual team.
>
> Table 8.2 in the HW manual is correct. ie, underflow interrupt is present
> for channel 8.

Thanks for checking!

> They are going to correct Table16.78 in Chapter 16 MTU3a.

+ Table 16.2 and Figure 16.1.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
