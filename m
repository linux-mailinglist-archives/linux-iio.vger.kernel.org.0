Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031D55523A0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbiFTSNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiFTSNP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B38018B31
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B621F6158D
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A295C341C0;
        Mon, 20 Jun 2022 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655748792;
        bh=rTVi+CZnfXIIaf1Tml2S8hS6rE1h2GFg9RZggGDbPJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FliM5GVQZT0hpjYRAVSohOO+orrPRL+xV3lF/066FX5ejOw1GIEwC7DhKXV8YhdwV
         3xEvpTz0KnGeFO67pj54h0c9BKQu7Mi+DEE4wIYmEsGAr/4676lCNmZoe2lPKh7Mvz
         jblXVylhcTE71mIdzc4942ke8AcP9vmGp+yDD1heNNUsJaQUH7HwcLEWG80qQwS+Lr
         b0iYlHciGcicFzZEgQtshrLb6/mJQIB6zfD5b6yP1aqTrsKbo7o6fplGjT2jcIZjNz
         uQ9NUYMa4HHLz+wul9T5IHg56ccVtT1bqyu9HmVb/GZSrs0y88gLzznuzfVwhaeQhn
         pzEHCZ3r0U6hg==
Date:   Mon, 20 Jun 2022 19:13:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/17] iio: core: Introduce _inputoffset for
 differential channels
Message-ID: <20220620191307.7f8fefa7@jic23-huawei>
In-Reply-To: <CAHp75Vdf3aWaeT17cxsm=a7LUSpc1LnoMGkRQS8O_3ftufprLg@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-12-jic23@kernel.org>
        <CAHp75Vdf3aWaeT17cxsm=a7LUSpc1LnoMGkRQS8O_3ftufprLg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jun 2022 01:20:08 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 19, 2022 at 8:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Address an ABI gap for device where the offset of both lines in a
> > differential pair may be controlled so as to allow a wider range of
> > inputs, but without having any direct effect of the differential
> > measurement.
> >
> > _offset cannot be used as to remain in line with existing usage,
> > userspace would be expected to apply it as (_raw + _offset) * scale
> > whereas _inputoffset is not.
> > Similarly calibbias is expected to tweak the measurement seen, not
> > the adjust the two lines of the differential pair.
> >
> > Needed for in_capacitanceX-capacitanceY_inputoffset for the
> > AD7746 CDC driver.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > ---
> > I''m not entirely happy with the naming on this one, so if anyone
> > has a better idea I'm definitely open to it! =20
>=20
> I'm not sure I got the idea behind this, but would be "tare" /
> "tarepoint" / alike suitable here?
>

Hmm I don't think tare maps well as I've never seen it applied to a
differential channel like this.  Not really seen it much used outside
of checkweighing (the mention brought back some horrible memories
of debugging software for high speed check weighers :)

So to try and explain what this is doing in more depth.

This is basically applying a negative offset X to both the P(ostitive) and
N(egative) lines. Hence

measured capacitance =3D (P - X) - (N - X)
                     =3D P - N

the aim of X being to keep the signal hitting some internal point on
the device within a range that is measurable.

The relevant text on the datasheet is:

"The CAPDAC can be understood as a negative capacitance
connected internally to the CIN pin."

"Each of the two input capacitances CX and CY between the EXC
and CIN pins must be less than 4 pF (without using the
CAPDACs) or must be less than 21 pF and balanced by the
CAPDACs. Balancing by the CAPDACs means that both
CX=E2=80=93CAPDAC(+) and CY=E2=80=93CAPDAC(=E2=80=93) are less than 4 pF."

So basically if you have both sides of the differential pair
that are too large (>4 pF) then you can drag them together
down to that range by adding negative capacitance.

Ouch that's confusing :)

Jonathan




