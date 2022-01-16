Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4948148FE1C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiAPRIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:08:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40080 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbiAPRIn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:08:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7871860F95;
        Sun, 16 Jan 2022 17:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DEBC36AE9;
        Sun, 16 Jan 2022 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642352922;
        bh=EGJj9MGUz5qPCHcApejkyqzWPNkmtAFfFImbO0oIhqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjttfEkteQj9uW+9/TlkT73nNzxr3JbQ7FQ+RL2o9j4GeoDD7Y1UE5dG2BSBc7s8O
         Zo7Zm0vBTioKq0/y0fA3SpIoUF4/UQOC65zGKZGzyDs7gOz+2HmuoDbOcBWz3Iux59
         Pq0pwYI5QXMsOIDOvaEvCiEThKgtY5DfB1HKYI2sHj9T8r8fGSF9SFTNyjKhS9LXG/
         D9TWlApB7KkQ6UyRNlYscb69wggOgGawb81GpjuAHzeEquVe5ZcJQMrJitSFrCASY7
         hzj3Ty8Fwjjd9kRcA3YPr5ROOcgAhWezyqfzKDMwoP+aYKNquW7J9UlZOKErSImmxD
         JRKmyDGKstDxQ==
Date:   Sun, 16 Jan 2022 17:14:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v2 1/3] iio: dac: add support for ltc2688
Message-ID: <20220116171443.76adbf23@jic23-huawei>
In-Reply-To: <PH0PR03MB6786CCDDE287E814FE5BB32299569@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220115092705.491-1-nuno.sa@analog.com>
        <20220115092705.491-2-nuno.sa@analog.com>
        <20220116124424.5360296f@jic23-huawei>
        <PH0PR03MB6786CCDDE287E814FE5BB32299569@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Jan 2022 16:28:08 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, January 16, 2022 1:44 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; Rob
> > Herring <robh+dt@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>
> > Subject: Re: [PATCH v2 1/3] iio: dac: add support for ltc2688
> >=20
> > [External]
> >=20
> > On Sat, 15 Jan 2022 10:27:03 +0100
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
> > > precision reference. It is guaranteed monotonic and has built in
> > > rail-to-rail output buffers that can source or sink up to 20 mA.
> > >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> >=20
> > A few minor additions inline.
> >=20
> > In particular I think we can work around that lack of
> > device_for_each_available_child_node() issue and use generic fw
> > propreties.
> > rather than of ones.  That way we can separate things from the
> > question of
> > how to 'fix' that issue.
> >=20
> > One thing I'm not sure on is the phase units. Right now I think you are
> > exposing just the raw register value whereas I think that needs
> > converting
> > to radians. =20
>=20
> It's returning degrees which I think is fairly ok. But I know that in gen=
eral
> we report radians, so I'm more than fine in changing this if you prefer i=
t.

Radians for consistency is a must as users reading the docs may see the main
_phase descriptions and have no reason to think this one might be different.
=20

>=20
> > Jonathan
> >=20
> >=20
> >=20
> > ...
> >  =20
> > > +static int ltc2688_channel_config(struct ltc2688_state *st)
> > > +{
> > > +	struct device *dev =3D &st->spi->dev;
> > > +	struct device_node *child;
> > > +	u32 reg, clk_input, val, tmp[2];
> > > +	int ret, span;
> > > +
> > > +	for_each_available_child_of_node(dev->of_node, child) { =20
> >=20
> > Gah. This still going on with there not being a generic _available_
> > specific form.  We need to kick that again because I'm not keen to
> > merge another driver we'll need to tidy up later to use generic
> > properties.
> >=20
> > Best bet is probably to just define
> > device_for_each_available_child_node() and see if anyone shoots
> > it down (even if it does the same as device_for_each_child_node()
> > in at least some cases).
> >=20
> > Or thinking about it.. Here you could use
> > device_for_each_child_node()
> > and then call fwnode_device_is_available() on the result and continue
> > if not true.
> >=20
> > Will always return true (I think) but will make the intent clear.
> >=20
> > We can tidy up to a new for_* if / when it becomes available.
> >  =20
>=20
> Hmm, not sure I'm following you... I mean, I understand what you're
> saying here but there is a reason for why I changed the whole thing to
> use OF. Please take a look at the cover... I explain why I've done it.

Hohum. Reading the cover letter? :)  Next you'll be suggesting
I read manuals of new hardware!  I'll take a look.

Jonathan
