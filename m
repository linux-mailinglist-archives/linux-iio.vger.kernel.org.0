Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F026D3143
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDAOV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDAOV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:21:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE87EC3
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 07:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C1D1B80B6E
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 14:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AB1C433EF;
        Sat,  1 Apr 2023 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680358913;
        bh=nlJKAv/mGLah+I3nDD56BsZCO4gI2+0VqDYPDI7IJ1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oa/VNJa+4cEm4+BQOI89VvH/FQuvoI9MdOlImCUOmilYjwRutZ77H8Vpskj4+gJZG
         h31StdrFbXcHG3YmOCSsWk6HPoQl3ZCn3rh4pB4zXZOIgyk6+xswnPvxzIC+URGdYW
         gqftIS2jCrlpaL8qLgOL8GutCzs3UDrhcmfuoXEgU/hnz1eFyeFTLiX5tLWudof+Mt
         N8KOLMMAFJBi35Y7e+z3Se/HLSzj3/qTUi9fNt2sZlcvYTsG0sGHu/QS8yaidZmTyr
         zWSwo+cTdHMu8woXsH3yAArJsWrTPGUx0dkEohhjLGlR0bdOPMsCGMVEIhFCSfExxt
         STJesOKHNGlhQ==
Date:   Sat, 1 Apr 2023 15:37:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] ad7192 driver: fixed unexpected internal clock
 fallback when no mclk clock is defined.
Message-ID: <20230401153702.17cb95dd@jic23-huawei>
In-Reply-To: <11450376865596c3c1ef6cf54a71fc63924e7d90.camel@gmail.com>
References: <CAPJMGm4StRvJ4zTyrOb7ebo47LrR9bBuZ46p7VOxkDfwWSG=PA@mail.gmail.com>
        <4ef51234de8e496791bcb7cd190a7ccf31626c1e.camel@gmail.com>
        <CAPJMGm7qQ-TgnG9ocXDDQX+Fhc9ridHyS1Ztxuq9mX+Q+DL=sA@mail.gmail.com>
        <11450376865596c3c1ef6cf54a71fc63924e7d90.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Mar 2023 09:53:29 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-03-29 at 23:23 +0200, Fabrizio Lamarque wrote:
> > On Wed, Mar 29, 2023 at 5:15=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com>
> > wrote: =20
> > >=20
> > > On Mon, 2023-03-27 at 22:21 +0200, Fabrizio Lamarque wrote: =20
> > > > Allow the use of external clock when mclk clock is defined.
> > > > When defining a mclk clock source in device tree with adi,clock-
> > > > xtal
> > > > property, the external crystal oscillator is not turned on.
> > > > Without the change, the driver always uses the internal clock
> > > > even
> > > > when mclk clock is defined.
> > > >=20
> > > > Current implementation seems to contain a typo, since it expected
> > > > st->mclk to be NULL within ad7192_of_clock_select() in order to
> > > > select
> > > > the external clock, but, if null, external clock cannot loaded
> > > > correctly (out of bounds due to invalid mclk) in ad7192_probe().
> > > >=20
> > > > I believe this patch follows the author's intended behavior.
> > > > =C2=A0After applying this patch, the external oscillator is started=
 as
> > > > expected.
> > > >  =20
> > >=20
> > > Yes, looks like a valid fix... Just missing a Fixes tag. =20
> >=20
> > Thank you for having this patch reviewed.
> > Here is a backwards compatibility note I believe you should be aware
> > of.
> >=20
> > Without this patch, the DT node shall contain (any) clock property
> > for the driver to be loaded properly.
> > The clock frequency is ignored, as it is ignored adi,clock-xtal
> > property.
> > In case clock property is not set, the initialization always fails.
> > There is no way to use an external clock source.
> > As you already verified from source code, this was not intentional.
> >=20
> > While the proposed patch should make the DT config load as intended,
> > there is a possible side effect on existing implementations relying
> > on
> > internal clock source only, that would be deactivated when clock
> > property
> > is defined in DT.=C2=A0 =20
>=20
> Hmm, I see. I would argue anyone relying on that should have just
> stepped forward and fix the real issue as you did :). So, maybe there's
> no one actually relying on this but that's a big __maybe__... Not
> really sure how to handle this. I'm not sure we want to keep
> compatibility with something that's clearly wrong but often we need to
> "live" with past messes.
>=20
> Jonathan I guess your input will be valuable here :)?

Rather odd if they have bindings that say there is a clock but 'rely'
on the internal clock as opposed to the current bug meaning they aren't
using the external clock (but everything would work fine if they were).

So I'd expect that we will only see a problem if someone has another
bug somewhere else that means that clock isn't working correctly.
At that point they will almost certainly want to fix that bug.

>=20
> > In addition, bindings documentation states clock
> > property is mandatory.
> >  =20
>=20
> This looks at least suspicious to me given the fact we have an internal
> alternative. Clearly looks wrong to me...

Agreed. I don't think it should be mandatory in the binding doc.

Thanks,

Jonathan


>=20
> - Nuno S=C3=A1
> >  =20

