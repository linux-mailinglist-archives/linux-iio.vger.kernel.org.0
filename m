Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573587BF662
	for <lists+linux-iio@lfdr.de>; Tue, 10 Oct 2023 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjJJIsm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Oct 2023 04:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJJIsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 04:48:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D269F;
        Tue, 10 Oct 2023 01:48:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EF8C433C7;
        Tue, 10 Oct 2023 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696927720;
        bh=Qshdf56p2PmgtMepW/YIwcuyGu3PnxXeQRi+mQdc19M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Av5JAAq+aX0+glsIlI3y2nB4vmBMX3mKRFSg/INBNb0zC5mf+vokPVXizghhdtEtz
         h2tmZtDPaMQH6tltozkSwBbReKygEodMRVsnSu9FsnMFv0RpDNLAlQagm+Ai5LhWUm
         vbq0okGFzV5iMx3set7wiTNKkB9iaoLv8TiqM7L3C8xOr6vGF5vVFpKB7wzJcuDSPn
         2rpmESqVcA0AYIJ7cbmdyR8XxN7EJ8Qmfd0jb+Cx0MWBq6FIXxQp/3RaW1kkq2FKIy
         lxtrfy+FBANqLYW+Rn8AFVCAefDezr6IBYNfgmW3+Zx633yLytzImitOvA2Tvi/gE4
         euKYABFO3cKpg==
Date:   Tue, 10 Oct 2023 09:48:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Message-ID: <20231010094851.3bde8530@jic23-huawei>
In-Reply-To: <CAL_Jsq+dcabJ14w793TBneipwZUFnXuA2vvPzEq9Kr98edakBA@mail.gmail.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
        <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
        <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
        <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
        <20230828152137.2db2668d@jic23-huawei>
        <CAL_Jsq+dcabJ14w793TBneipwZUFnXuA2vvPzEq9Kr98edakBA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Oct 2023 09:58:34 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Aug 28, 2023 at 9:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 18 Aug 2023 17:17:44 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > =20
> > > Hi Andy,
> > >
> > > CC devicetree
> > >
> > > On Fri, Aug 18, 2023 at 5:03=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote: =20
> > > > On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote: =20
> > > > > > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop dep=
recated
> > > > > > enums from OF table
> > > > > >
> > > > > > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote: =20
> > > > > > > Drop deprecated enums from OF table as corresponding entries =
are
> > > > > > > removed from bindings and it also saves memory. =20
> > > > > >
> > > > > > You can't do this.
> > > > > >
> > > > > > Only sorting by "prefixed first" criteria is possible. =20
> > > > >
> > > > > The rule applies only for fallback compatible. I checked bindings=
 and I don't
> > > > > find any fallback compatibles. All compatibles are just enums. Am=
 I missing
> > > > > anything here?? =20
> > > >
> > > > Yes. As per above patch. The _whole_ world is not under your / our =
control.
> > > > NAK to this change, sorry. =20
> > >
> > > The single user ever in the upstream kernel was fixed in commit
> > > 9846210b1ec9bbaa ("ARM: tegra: seaboard: add missing DT vendor
> > > prefixes") in v3.8 back in 2012.
> > > And it had to be fixed again 9 years later in commit fa0fdb78cb5d4cde
> > > ("ARM: dts: am335x: Use correct vendor prefix for Asahi Kasei Corp.").
> > >
> > > There may be other out-of-tree users, which would be broken by this
> > > change.  Typically we wait a few years between deprecating a compatib=
le
> > > value and removing support from the driver.
> > >
> > > As Biju is only deprecating these compatible values in PATCH 3/5 of
> > > his series, this may be a bit premature. =20
> > Absolutely.  I'd go a bit further.
> > Unless there is a maintenance reason to remove these (after a few years=
 from
> > removal in the binding doc) then we never remove them as it can only hu=
rt users. =20
>=20
> I'm tracking undocumented compatibles (with 'make
> dt_compatible_check') in the kernel tree. Dropping the binding makes
> these undocumented (and now showing up in my diff between Linus and
> next). So please apply both or none.
>=20
> Rob

Given I have some merges in the togreg tree and it's at least in theory
non rebasing, I'll revert patch 3 from this series rather than dropping it.

Thanks for letting me know.

Jonathan
