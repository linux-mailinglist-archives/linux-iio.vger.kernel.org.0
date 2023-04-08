Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4347A6DBA0C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Apr 2023 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDHKXS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Apr 2023 06:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDHKXR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2023 06:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3D10247
        for <linux-iio@vger.kernel.org>; Sat,  8 Apr 2023 03:22:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A84C60C22
        for <linux-iio@vger.kernel.org>; Sat,  8 Apr 2023 10:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AE8C433D2;
        Sat,  8 Apr 2023 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680949359;
        bh=DSjfaXijsz6/eFu1zbNPHnC8ntXwC8ddEBaFGA5PKgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sBNAaBxYUAiHkqxcJUvMX3ir6eUL2rQ9fp3MpceDRX4WhFHpjZSte7OiAKTe0zZcv
         l7Mnv4W7OBscU5TKUEga5vqqvk1FNMBYNGgsnCfZnNtepXgIe4xsnoO+fj3PVw1qPv
         6T0RrDGoqxIA2ULF8xbhMsItRm+zTLhBIA6+pkRqMRFUJYwwrAjvfjL2NVHzlPrVGH
         26Eo/9dLMAlCeGvpJsSr4cUKtu/7le8LMssH9KRrpTx0CZUZBYckxnoEtI3lOB6Q+4
         +l8athp4NQBFKQePmXz2f3WFO9aMlkSXZajJb3brM4cTcG7rUJOwU3BXQripNn3tq2
         SxOe9bY8zevdA==
Date:   Sat, 8 Apr 2023 11:37:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
Message-ID: <20230408113754.6ab8df1b@jic23-huawei>
In-Reply-To: <CAPJMGm6JNBwU46_uxtn0t+WWUcEFiPXrgmfhSO2YiwGYrkAvow@mail.gmail.com>
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
        <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
        <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
        <11450376865596c3c1ef6cf54a71fc63924e7d90.camel@gmail.com>
        <20230401153702.17cb95dd@jic23-huawei>
        <CAPJMGm6JNBwU46_uxtn0t+WWUcEFiPXrgmfhSO2YiwGYrkAvow@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Apr 2023 09:20:24 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> On Sat, Apr 1, 2023 at 4:21=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu, 30 Mar 2023 09:53:29 +0200
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > =20
> > > On Wed, 2023-03-29 at 23:23 +0200, Fabrizio Lamarque wrote: =20
> > > > On Wed, Mar 29, 2023 at 5:15=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com>
> > > > wrote: =20
> > > > >
> > > > > On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote: =20
> > > > > > Allow the use of external clock when mclk clock is defined.
> > > > > > When defining a mclk clock source in device tree with adi,clock-
> > > > > > xtal
> > > > > > property, the external crystal oscillator is not turned on.
> > > > > > Without the change, the driver always uses the internal clock
> > > > > > even
> > > > > > when mclk clock is defined.
> > > > > >
> > > > > > Current implementation seems to contain a typo, since it expect=
ed
> > > > > > st->mclk to be NULL within ad7192_of_clock_select() in order to
> > > > > > select
> > > > > > the external clock, but, if null, external clock cannot loaded
> > > > > > correctly (out of bounds due to invalid mclk) in ad7192_probe().
> > > > > >
> > > > > > I believe this patch follows the author's intended behavior.
> > > > > >  After applying this patch, the external oscillator is started =
as
> > > > > > expected.
> > > > > > =20
> > > > >
> > > > > Yes, looks like a valid fix... Just missing a Fixes tag. =20
> > > >
> > > > Thank you for having this patch reviewed.
> > > > Here is a backwards compatibility note I believe you should be aware
> > > > of.
> > > >
> > > > Without this patch, the DT node shall contain (any) clock property
> > > > for the driver to be loaded properly.
> > > > The clock frequency is ignored, as it is ignored adi,clock-xtal
> > > > property.
> > > > In case clock property is not set, the initialization always fails.
> > > > There is no way to use an external clock source.
> > > > As you already verified from source code, this was not intentional.
> > > >
> > > > While the proposed patch should make the DT config load as intended,
> > > > there is a possible side effect on existing implementations relying
> > > > on
> > > > internal clock source only, that would be deactivated when clock
> > > > property
> > > > is defined in DT. =20
> > >
> > > Hmm, I see. I would argue anyone relying on that should have just
> > > stepped forward and fix the real issue as you did :). So, maybe there=
's
> > > no one actually relying on this but that's a big __maybe__... Not
> > > really sure how to handle this. I'm not sure we want to keep
> > > compatibility with something that's clearly wrong but often we need to
> > > "live" with past messes.
> > >
> > > Jonathan I guess your input will be valuable here :)? =20
> >
> > Rather odd if they have bindings that say there is a clock but 'rely'
> > on the internal clock as opposed to the current bug meaning they aren't
> > using the external clock (but everything would work fine if they were).
> >
> > So I'd expect that we will only see a problem if someone has another
> > bug somewhere else that means that clock isn't working correctly.
> > At that point they will almost certainly want to fix that bug. =20
>=20
> The bug was introduced in June 2021 from c9ec2cb328e3 iio: adc:
> ad7192: use devm_clk_get_optional() for mclk, where there is a clearly
> mistaken logic inversion.
>=20
> Link: https://lore.kernel.org/all/20210513120752.90074-10-aardelean@deviq=
on.com/#r
>=20
> If you agree, I can send a revised patch set (perhaps within a new thread=
),
> with the additional clarifications on clock usage in bindings documentati=
on,
> and one third patch for undocumented bindings.

Sounds good to me.

>=20
> There is one last issue we are investigating, we have a work-around but
> we have not found the root cause yet. I will post about it later, in
> the hope the
> patch set would include all the changes needed to have the driver operati=
ng
> as expected.

Sounds interesting :(

>=20
> Thank you once again for this review.

NP.

Thanks for sending your fixes upstream.

Jonathan

>=20
> Fabrizio Lamarque
>=20
> > =20
> > > =20
> > > > In addition, bindings documentation states clock
> > > > property is mandatory.
> > > > =20
> > >
> > > This looks at least suspicious to me given the fact we have an intern=
al
> > > alternative. Clearly looks wrong to me... =20
> >
> > Agreed. I don't think it should be mandatory in the binding doc.
> >
> > Thanks,
> >
> > Jonathan
> >
> > =20
> > >
> > > - Nuno S=C3=A1 =20
> > > > =20
> > =20

