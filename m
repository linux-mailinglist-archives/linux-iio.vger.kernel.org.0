Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4457707A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 19:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiGPRr2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGPRr1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 13:47:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660AE1EC53
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 10:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03DD2B80AB9
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2022 17:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D35C34115;
        Sat, 16 Jul 2022 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657993643;
        bh=c40U+9ZeE/J2NepvCHDhJ7I3dQJx5EYu7xEZzPhsHrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LTomlLtA7DTd61Wpa5MYzQtCrs/9kMPz8zqqElHBu1PX7KrSnAXN+ApJvP1Jm9WFP
         nDuhu0AhRaa5kBPpZpPIRUX85FGKD/1yHhOHZKpeopDP6H0R/Cbf0XXWN7vPb7H0da
         SVc5+T42RedfE7e3hMNlGvlxRpjSRfFdYAvz2BUMEWY3nVJ4fkC4hntS5TrCyGbh0Y
         ro1KK5/1KkQY0+r1jvenMoxAhg8+bROXY54GqLnV8uF8orhohgU1/Se3AYasWfoY9t
         N5w7CUXommksrBCFLSReqwT++QZaV7rlHp5d9RzGxcBygcryhAZg0CJNCGol+FGOe9
         QIA4N42T4neuA==
Date:   Sat, 16 Jul 2022 18:57:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de, Thorsten Scherer <t.scherer@eckelmann.de>
Subject: Re: ti-ads7950: selecting the adc input range
Message-ID: <20220716185717.59e7fb5c@jic23-huawei>
In-Reply-To: <496f7dec852e556c44c065cd6dbbfd9c3032dd47.camel@gmail.com>
References: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
        <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
        <496f7dec852e556c44c065cd6dbbfd9c3032dd47.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 08 Jul 2022 12:35:19 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-07-08 at 11:28 +0200, Lars-Peter Clausen wrote:
> > On 7/8/22 10:02, Uwe Kleine-K=C3=B6nig wrote: =20
> > > Hello,
> > >=20
> > > the ADS7950 has a register bit (called TI_ADS7950_CR_RANGE_5V in
> > > the
> > > driver) that selects the input range. Depending on that bit the
> > > input
> > > range is either [0 .. V_{REF}] or [0 .. 2 * V_{REF}].
> > >=20
> > > The driver currently defaults to setting that bit, so the range is
> > > the
> > > big one.
> > >=20
> > > On a machine here however I know the input is in the smaller range
> > > and
> > > I'd like to benefit from the higher resolution of the small range.
> > > I
> > > wonder how to make this tunable. Should that be done using a
> > > firmware
> > > property? ("single-input-range" vs. "double-input-range"? Or input-
> > > range
> > > =3D <1> vs. input-range =3D <2> which better matches the data sheet
> > > that
> > > calls the two modes "Range 1 (0 to V_{REF})" and "Range 2 (0 to
> > > 2xV_{REF})") Or should this be made tunable via sysfs? (E.g. by
> > > writing
> > > to the scale property? Or a separate property?) =20
> >=20
> > Hi,
> >=20
> > Its a bit of a tricky one. You can find arguments for and against=20
> > either. Like "devicetree is for hardware description and not
> > application=20
> > specific configuration data", or "I know which setting I want to use,
> > having the kernel apply it makes it a lot easier".
> >=20
> > What we've done in the past in the IIO framework is to make the scale
> > property writable for such devices. Together with a scale_available=20
> > property to list valid options. This is the most flexible option as
> > it=20
> > allows to change the setting at runtime for applications where it is=20
> > required.
> >  =20
>=20
> Yes, it's a tricky one and I have the feeling that thoughts about this
> are changing frequently :).
>=20
> Well, this feels identical to what I had in a DAC [1] I recently
> upstreamed. IIRC, on the first version of the series or during
> discussion on the RFC I also had in mind to make it configurable
> through sysfs but Jonathan advised me to go with a fw property.

DACs sometimes have a safety issue (you can fry boards if you set them wrong
and it's not unheard of for designers to make them safe for only a particul=
ar
range on a multirange DAC).
Assuming this ADC is sensible that shouldn't be the case here... (famous
last words ;)

Jonathan

>=20
> [1]:https://elixir.bootlin.com/linux/latest/source/drivers/iio/dac/ltc268=
8.c#L786
>=20
> - Nuno S=C3=A1

