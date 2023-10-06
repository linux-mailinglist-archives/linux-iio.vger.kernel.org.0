Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C777BBB00
	for <lists+linux-iio@lfdr.de>; Fri,  6 Oct 2023 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjJFO6v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Oct 2023 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJFO6u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Oct 2023 10:58:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28215A6;
        Fri,  6 Oct 2023 07:58:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF7C116A3;
        Fri,  6 Oct 2023 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696604328;
        bh=AXCXHLWdA2qo6nB4YyX+uUf1c5v5SfVHTy0epxZzqcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPjyBcawx/D50X7FUVmVkh5x91DEYjZ8XyRo+bRJ01O1CK/hyb65bkXs2SyntcK12
         +7fb7tJqpo/SM8ixUNzr7JjLhcO7cW90QZkkiBLqOuVRH9vW8sc2WBVVgUsDrxhm9y
         q+Ew1wTrXghdLAU3sKfVihaSx5Ih+ZWve8Vany0T+HgE0JDgG0LTC16s2XjYgTM2Dn
         9czZXoefWHJgESQTRkQqSuurNcxsNIb/czhsdeVd6usBUuTZxuNJSJ1B/K79ZmKfor
         enocjOJjpuF4k5rIrdLe9vRkpbAUC8KlofTCsSSJyjxmW2BX1L4ufuI274znVZPCkW
         X5Gx6ocZ9Ay8w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5042bfb4fe9so2817476e87.1;
        Fri, 06 Oct 2023 07:58:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEi81WkSEpbNEzHwOYcFeHhyjHRn3XUxVTz3tONSMAQI8Wo/JW
        YJXopm6VcOq3VNeCjyfvgyDZEUKo/7C4rYXjyg==
X-Google-Smtp-Source: AGHT+IF9c4JksyddIA4XMnsHQLGMxKeD4RWiwFhSUZVPaOaFwkElhfNHrBreSbHfWZCSQs2x8pg5PBOf5Yj5IPxhp0g=
X-Received: by 2002:a05:6512:545:b0:503:58e:becb with SMTP id
 h5-20020a056512054500b00503058ebecbmr7860725lfl.9.1696604326925; Fri, 06 Oct
 2023 07:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com> <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
 <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZN+IDGfc0MJfqOV9@smile.fi.intel.com> <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
 <20230828152137.2db2668d@jic23-huawei>
In-Reply-To: <20230828152137.2db2668d@jic23-huawei>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Oct 2023 09:58:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dcabJ14w793TBneipwZUFnXuA2vvPzEq9Kr98edakBA@mail.gmail.com>
Message-ID: <CAL_Jsq+dcabJ14w793TBneipwZUFnXuA2vvPzEq9Kr98edakBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 9:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 18 Aug 2023 17:17:44 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Hi Andy,
> >
> > CC devicetree
> >
> > On Fri, Aug 18, 2023 at 5:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote:
> > > > > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop depre=
cated
> > > > > enums from OF table
> > > > >
> > > > > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> > > > > > Drop deprecated enums from OF table as corresponding entries ar=
e
> > > > > > removed from bindings and it also saves memory.
> > > > >
> > > > > You can't do this.
> > > > >
> > > > > Only sorting by "prefixed first" criteria is possible.
> > > >
> > > > The rule applies only for fallback compatible. I checked bindings a=
nd I don't
> > > > find any fallback compatibles. All compatibles are just enums. Am I=
 missing
> > > > anything here??
> > >
> > > Yes. As per above patch. The _whole_ world is not under your / our co=
ntrol.
> > > NAK to this change, sorry.
> >
> > The single user ever in the upstream kernel was fixed in commit
> > 9846210b1ec9bbaa ("ARM: tegra: seaboard: add missing DT vendor
> > prefixes") in v3.8 back in 2012.
> > And it had to be fixed again 9 years later in commit fa0fdb78cb5d4cde
> > ("ARM: dts: am335x: Use correct vendor prefix for Asahi Kasei Corp.").
> >
> > There may be other out-of-tree users, which would be broken by this
> > change.  Typically we wait a few years between deprecating a compatible
> > value and removing support from the driver.
> >
> > As Biju is only deprecating these compatible values in PATCH 3/5 of
> > his series, this may be a bit premature.
> Absolutely.  I'd go a bit further.
> Unless there is a maintenance reason to remove these (after a few years f=
rom
> removal in the binding doc) then we never remove them as it can only hurt=
 users.

I'm tracking undocumented compatibles (with 'make
dt_compatible_check') in the kernel tree. Dropping the binding makes
these undocumented (and now showing up in my diff between Linus and
next). So please apply both or none.

Rob
