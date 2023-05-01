Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145C46F3325
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 17:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEAPrb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjEAPra (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 11:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24900129
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 08:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884636144D
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 15:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03352C433EF;
        Mon,  1 May 2023 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682956038;
        bh=A91dcN7E/CbOTIaLbZpDux8dLJquqYvVyFdci+YEqU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EJLzNtoVALe49IZLrlHzTdZ39VcqYF0+XKUumqDe1sjfBiVqRA4ErysiprI/FKAfg
         KrE5G4k/dW38pjTgbL/gXPSyvZRTdbUrvJ7Ai5xHC4PGGmt/h/KUXvHshE44svu+Nu
         SWaZ8QMiVoB1wYoI3PAwwO+CdoSDew7DtAG0aDbqUogHzwBMMT1AaH12mNYIfbjVlE
         vyJBnLQB36uQiNKGhjYU3aAC60kFmLpHrRSqx8bmif/eOA6HL4OJ3HOL7yX1CJp3Hb
         iL25CKJNz+YJD0k6EvWpbBDYb8f/6SscRptviqLwiLHVnap37CmONAOl0/y7AlvyYe
         b2APhaxu2B7FQ==
Date:   Mon, 1 May 2023 17:03:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
Message-ID: <20230501170303.41a70477@jic23-huawei>
In-Reply-To: <CAPJMGm7+oYDJHt6SPAhJ8cHuE3VXWxx6XYF1T_8oKwQGo+iarA@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
        <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
        <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
        <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
        <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org>
        <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
        <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org>
        <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
        <8f14a0b8-8f02-b2a4-725d-0f70c39af9b6@kernel.org>
        <CAPJMGm6FY-iivtNSavLkwyHY=pgUir-ctT4+hyrAoV+g41e8yg@mail.gmail.com>
        <20230415173808.208690ff@jic23-huawei>
        <CAPJMGm7+oYDJHt6SPAhJ8cHuE3VXWxx6XYF1T_8oKwQGo+iarA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Apr 2023 12:45:31 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> On Sat, Apr 15, 2023 at 6:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 14 Apr 2023 12:42:08 +0200
> > Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:
> > =20
> > > On Fri, Apr 14, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@ke=
rnel.org> wrote: =20
> > > >
> > > > On 13/04/2023 20:19, Fabrizio Lamarque wrote: =20
> > > > > On Thu, Apr 13, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski <krzk=
@kernel.org> wrote: =20
> > > > >>
> > > > >> On 13/04/2023 18:07, Fabrizio Lamarque wrote: =20
> > > > >>> On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <kr=
zk@kernel.org> wrote: =20
> > > > >>>>
> > > > >>>> On 13/04/2023 10:36, Fabrizio Lamarque wrote: =20
> > > > >>>
> > > > >>> Current documentation does not follow existing source code impl=
ementation. =20
> > > > >>
> > > > >> Bindings describe hardware, not current implementation. =20
> > > > > =20
> > > > >>> The driver has been originally designed to operate with the int=
ernal
> > > > >>> clock when clocks property is omitted. =20
> > > > >>
> > > > >> Not really a reason to do it. Reason could be - hardware does no=
t always
> > > > >> need clock input. =20
> > > > >
> > > > > I hope the change in perspective will be enough. The external clo=
ck is
> > > > > mandatory for some applications.
> > > > > The internal clock might be required for others. =20
> > > >
> > > > I told you that reason you wrote is not enough and you answer "in
> > > > perspective will be enough". Wait, what? I don't understand it at a=
ll. I
> > > > gave you example reason. If you do not like it, find other reasons =
which
> > > > refer to the actual device, not to the specific implementation. =20
> >
> > Just leave it vague - we don't need to talk about specific apps. If som=
eone
> > wired a clock, they probably want that clock an will describe it in the=
ir
> > DTS.
> >
> > An internal clock is available and may be used if no external clock is =
provided.
> > =20
> > > > =20
> > > > >>>
> > > > >>> I thought the reason is clear from patch 2, but, as Nuno S=C3=
=A1 already
> > > > >>> suggested, I will describe the reasons in full again, each time=
 I post
> > > > >>> a revised patch set, even if it is quite verbose. =20
> > > > >>
> > > > >> Your commit must answer to why you are doing it. What you are do=
ing is
> > > > >> easily visible from the diff. Rephrase commit msg to explain it =
and add
> > > > >> proper rationale (hardware related, not driver). =20
> > > > >
> > > > > I am really just suggesting to align the documentation with the
> > > > > driver, since the driver operates the hardware as expected (after=
 the
> > > > > two regressions fixes). =20
> > > >
> > > > Does it mean you are not going to answer to "why?"? I cannot accept=
 such
> > > > commits. That's the basics of software development and versioning. =
It's
> > > > not even Linux kernel related...
> > > > =20
> > >
> > > I already wrote that the hardware clock might be generated internally
> > > and hence not required, but also that an external crystal/oscillator
> > > is suggested in the datasheet for better performance.
> > > There shall be a method to choose between the crystal, the external
> > > oscillator and the internal oscillator.
> > > This is what I was expecting to write on revised commit information,
> > > and this was the hopefully accepted "perspective change".
> > >
> > > I am really sorry but I do not understand what more I should say here.
> > > I appreciate your explanations and the fact you are taking your time
> > > to give directions to an obviously inexperienced developer, but my
> > > lack of understanding is perhaps related to what I called
> > > "perspective" on which comes first.
> > > If the above sentence is not enough, I will drop this last patch.
> > > I did not change the driver at all. The documentation is wrong (where
> > > it states the clocks property is mandatory) and it was missing
> > > information on how to choose between the clocks from the beginning. =
=20
> >
> > A simple statement that there is an internal clock that may be used if
> > no external clock is wired up should be sufficient.  I don't think we
> > need to talk about precision of clocks etc vs cost of board built and
> > now that drives a design choice.
> > =20
> > > =20
> > > > =20
> > > > > Without this change, one should read the source code to understand
> > > > > which clock is used and when, which bindings have to be applied, =
and
> > > > > find that documentation mandates an (already) optional property. =
=20
> > > >
> > > > How is it related? I did not refer whether change is reasonable its=
elf
> > > > or not. I said you commit msg is very poor and you must answer to "=
why".
> > > > Not to "what".
> > > >
> > > > (...)
> > > > =20
> > > > > =20
> > > > >>>
> > > > >>> I kindly ask you whether the entire (corrected) change on the
> > > > >>> documentation file only (without any change on the driver sourc=
e code)
> > > > >>> could be accepted as a single patch. =20
> > > > >>
> > > > >> I don't understand the question. Each change should be one logic=
al
> > > > >> change, but bindings are not related to the driver. =20
> > > > >
> > > > > The question came after this:
> > > > >
> > > > > On Thu, Apr 13, 2023 at 1:21=E2=80=AFPM Nuno S=C3=A1 <noname.nuno=
@gmail.com> wrote: =20
> > > > >>> I kindly ask you to confirm if, as per your suggestion, I shoul=
d send
> > > > >>> a v3 patch series with the proper "fixes" tag and this last one
> > > > >>> changed as follows:
> > > > >>>
> > > > >>>  - No changes on driver side (keep avdd-supply instead of vref-=
supply)
> > > > >>>  - Indicate in bindings documentation that avdd-supply is vref =
instead
> > > > >>> (with the "Phandle to reference voltage regulator")
> > > > >>>  - Add dependencies to yaml bindings
> > > > >>> =20
> > > > >> Yeps, but note that for the bindings patch you are making distin=
ct changes (
> > > > >> adding missing properties and changing one) so someone might com=
plain. But for
> > > > >> me, personally, they are simple enough that can go in one patch.=
 Just properly
> > > > >> document it in the commit description. =20
> > > > >
> > > > > I really need to send a proper, complete and acceptable v3 patch =
set,
> > > > > or drop patch 3/3 from the set.
> > > > >
> > > > > Would you accept the change to adi,ad7192.yaml file alone with bo=
th
> > > > > the change in description of avdd-supply and the additional missi=
ng
> > > > > properties? =20
> > > >
> > > > Do you mean by this changing bindings without changing driver? Then
> > > > depends on the context. The driver must implement bindings, so you
> > > > should not send patches which break the implementation of interface.
> > > > =20
> > >
> > > Perhaps I failed to explain it from the beginning.
> > > I said "the documentation does not follow the driver" but I understand
> > > I should have seen it the other way round. =20
> >
> > No need to mention the driver at all for the DT binding patch.
> > You are documenting what could be wired.  We shouldn't care for DT about
> > what he driver happens to implement today. =20
>=20
> Thank you once again for your corrections, suggestions and patience.
> I hope to be able to provide a formally corrected patch set. Before
> sending v3, would you please have a look at this and check if it
> correctly responds to your expectations or if there is still something
> to adjust?
> (in case it would be cleaner to send a v3 patch and wait for feedback
> instead, feel free to ask)

I tend to only get back to IIO discussions about once a week (this week
was particularly crazy as was at a conference all week) so if you are
fairly sure what I mean and want to move quickly I'd suggest just
sending a new version based on 'best guess'.

>=20
> The patch set will be then split in 5 total commits.
>  - iio: adc: ad7192: Fix null ad7192_state pointer access
>  - iio: adc: ad7192: Fix internal/external clock selection
>  - iio: adc: ad7192: Use VRef instead of AVdd as reference voltage source
>  - dt-bindings: iio: ad7192: Add mandatory reference voltage source
>  - dt-bindings: iio: ad7192: Allow selection of clock modes
>=20
> Patches "iio: adc: ad7192: Use VRef instead of AVdd as reference
> voltage source" and "iio: adc: ad7192: Use VRef instead of AVdd as
> reference voltage source" and will be a fix against b581f748cce0
> ("staging: iio: adc: ad7192: move out of staging").
>=20
> First commit message on bindings will be:
>=20
> Add required reference voltage (VRef) supply regulator.
> AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
> (on REFINx pin pairs).
>=20
> Some questions:
>  - Is the FIxes tag referenced commit acceptable, or should it be
> explained? If so, what should I write?

Given commit says they are 'required' I think ti's obvious that adding them
is what you are fixing wrt to the earlier patch that didn't have them.
So I don't think you need to state more.

>  - Is the commit message acceptable?

Looks good to me.

>=20
> > =20
> > >
> > > Actual documentation does not allow the use of the internal oscillator
> > > or the external crystal.
> > > By strictly following the documentation I could only use the external
> > > oscillator option (neither internal nor external crystal oscillator).
> > > The implementation already had in place more binding options than the
> > > documented ones, so I am not suggesting to break anything.
> > > =20
> > > > =20
> > > > > Is "Phandle to reference voltage regulator" as a description for
> > > > > avdd-supply acceptable on your side? =20
> > > >
> > > > Sorry, how is this related to our topic? Anyway, drop "phandle to",
> > > > because you should describe hardware, not syntax of DTS. =20
> > >
> > > Ok.
> > >  - Is it acceptable to change the description of property
> > > "avdd-supply" from "AVdd voltage supply" to "VRef voltage supply"? =20
> > No.
> >
> > We have a slightly complex case of not wanting to break old drivers, but
> > the binding should be correct none the less.
> >
> > Binding wise:
> > * Leave avdd-supply alone.
> > * Add a new vref-supply entry and list it as required. This is the Bind=
ing
> >   'bug fix' and there should be an appropriate fixes tag.
> >
> > No need at all for the binding to describe some old buggy driver behavi=
our.
> >
> > Driver wise. - with comments on why we are doing this as we are papering
> > over a bug that will be seen if someone has a DT that worked with the o=
ld
> > code.  That's fine as long as we document that we are doing it.
> >
> > * Always get vadd-supply (not optional) - we may get a dummy regulator.
> >   That is fine here.
> > * Try to use vref-supply first as an optional supply.
> > * If that fails, then 'use' avdd as if it it were vref. with nice obvio=
us
> >   comment that this is happening an perhaps even a warning print
> >   "Warning: Using avdd in place of vref. Likely an old DTS". =20
>=20
> Here is the change I am backporting and testing on my platform:
>=20
> Subject: [PATCH v3 3/5] iio: adc: ad7192: Use VRef instead of AVdd as
>  reference voltage source
>=20
> Add missing vref-supply and fix avdd-supply used as if it were vref.
>=20
> AD7192 requires three independent voltage sources, digital supply (on
> pin DVdd), analog supply (on AVdd) and reference voltage (VRef on
> alternate pin pair REFIN1 or REFIN2).
>=20
> Emit a warning message when AVdd is used in place of VRef for backwards
> compatibility.
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---
>  drivers/iio/adc/ad7192.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 5a9c8898f8af..4ac6843b7c23 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -177,6 +177,7 @@ struct ad7192_chip_info {
>  struct ad7192_state {
>      const struct ad7192_chip_info    *chip_info;
>      struct regulator        *avdd;
> +    struct regulator        *vref;
>      struct clk            *mclk;
>      u16                int_vref_mv;
>      u32                fclk;
> @@ -1014,11 +1015,30 @@ static int ad7192_probe(struct spi_device *spi)
>      if (ret)
>          return ret;
>=20
> +    st->vref =3D devm_regulator_get_optional(&spi->dev, "vref");
> +    if (!IS_ERR(st->vref)) {

You need to specifically handle only -ENODEV (I think - check what is
returned if get_optional doesn't get it because it's not supplied).

You might get a deferral that needs to be treated as an error (so we go
around again once the supply driver is bound).  So add an

	} else if (PTR_ERR(st->vref) !=3D -ENODEV) {
		return PTR_ERR(st->vref);
	}

> +        ret =3D regulator_enable(st->vref);
> +        if (ret) {
> +            dev_err(&spi->dev, "Failed to enable specified VRef supply\n=
");

return dev_err_probe() is fine for all calls in probe() as it's neater
and means we don't need to think if something could defer or not.

> +            return ret;
> +        }
> +
> +        ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable,
> st->vref);
> +        if (ret)
> +            return ret;
> +    }
> +
>      ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
>      if (ret)
>          return dev_err_probe(&spi->dev, ret, "Failed to enable
> specified DVdd supply\n");
>=20
> -    ret =3D regulator_get_voltage(st->avdd);
> +
> +    if (!IS_ERR(st->vref)) {
> +        ret =3D regulator_get_voltage(st->vref);
> +    } else {
> +        dev_warn(&spi->dev, "Using AVdd in place of VRef. Likely an
> old DTS\n");
> +        ret =3D regulator_get_voltage(st->avdd);
> +    }

This bit is good.

>      if (ret < 0) {
>          dev_err(&spi->dev, "Device tree error, reference voltage undefin=
ed\n");
>          return ret;

