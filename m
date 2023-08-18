Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395B780EEE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378080AbjHRPSc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Aug 2023 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378048AbjHRPR6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:17:58 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832235A1;
        Fri, 18 Aug 2023 08:17:57 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-58439daf39fso10768307b3.1;
        Fri, 18 Aug 2023 08:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371876; x=1692976676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N194ARL0/KzZa8KoNgGxFPEhbq3PBex382jco3e17o=;
        b=TKSbOh9LBQsNM6P4teMjgm7YmrWazk6o0mVIxi9uiYCN0IcFazffFkru2S0sa8hCFr
         eHv3PwPr/MttwWQv/c5WFxj9GO1UZDZ3hrNPZTesjTSbM+jJ+WqeNG2oTkevk+5S7Ib+
         rGbw4WK2LupTgP0qLHmjmjMg4Lr0wPhGP7IWgOjKjcd0XV3N0hDaGLE9lLMKlYdaKGIr
         RFvc/uMqZWWr/OcB0gDM0E7nUC0acBvCBl2CRilNnXrsz1+rO1yJa7FLBAACWxFZW//y
         qSAJBFPqjJl667px/qFd0ZEXrNwnOW4EYD0XsMHHVbbIss4uaoua1qx6Ic59cHVOMMSD
         vjsw==
X-Gm-Message-State: AOJu0YxnM4oql/hpIyazxN2LQtX9uzJDyzBO8auPAXdkzuZNPv9eGppB
        V0kiXuwcFCzOe8WaBIbR0h2XgeXVWbohaqdX
X-Google-Smtp-Source: AGHT+IF9EkUXfYKWDpugr9PlIGEUUogtfEJyfqA/Xcd1WL53C62nM9twgktMS+ftnLsDOxBFn+fLsw==
X-Received: by 2002:a81:6241:0:b0:58c:9974:b660 with SMTP id w62-20020a816241000000b0058c9974b660mr3128915ywb.22.1692371876510;
        Fri, 18 Aug 2023 08:17:56 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id l4-20020a81d544000000b005839a780c29sm535202ywj.102.2023.08.18.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 08:17:56 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-58a24ac48eeso10868337b3.0;
        Fri, 18 Aug 2023 08:17:56 -0700 (PDT)
X-Received: by 2002:a25:250f:0:b0:d11:45d3:b25d with SMTP id
 l15-20020a25250f000000b00d1145d3b25dmr3091291ybl.46.1692371875925; Fri, 18
 Aug 2023 08:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com> <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
 <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
In-Reply-To: <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Aug 2023 17:17:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
Message-ID: <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Hi Andy,

CC devicetree

On Fri, Aug 18, 2023 at 5:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote:
> > > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated
> > > enums from OF table
> > >
> > > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> > > > Drop deprecated enums from OF table as corresponding entries are
> > > > removed from bindings and it also saves memory.
> > >
> > > You can't do this.
> > >
> > > Only sorting by "prefixed first" criteria is possible.
> >
> > The rule applies only for fallback compatible. I checked bindings and I don't
> > find any fallback compatibles. All compatibles are just enums. Am I missing
> > anything here??
>
> Yes. As per above patch. The _whole_ world is not under your / our control.
> NAK to this change, sorry.

The single user ever in the upstream kernel was fixed in commit
9846210b1ec9bbaa ("ARM: tegra: seaboard: add missing DT vendor
prefixes") in v3.8 back in 2012.
And it had to be fixed again 9 years later in commit fa0fdb78cb5d4cde
("ARM: dts: am335x: Use correct vendor prefix for Asahi Kasei Corp.").

There may be other out-of-tree users, which would be broken by this
change.  Typically we wait a few years between deprecating a compatible
value and removing support from the driver.

As Biju is only deprecating these compatible values in PATCH 3/5 of
his series, this may be a bit premature.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
