Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20E6E3279
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDOQiK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQiJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 12:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D2421B
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 09:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5D560B38
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 16:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACB6C433D2;
        Sat, 15 Apr 2023 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681576687;
        bh=15McZRlFUMJwqEhsskdnylrC3NGcv6Hoh0GQE5CY5r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HpJCr2zfP7Ve3qZPx+PooejBsrIwsqHkmhjDViAMF94DKuSPjO60PtKr9grkHfoNk
         /h8Zp0bMgU8R0L8Om4Dy/1l2jQ25JO2IZ9B9HGAt9MJnOURfwwxmOCSYQ8fLpZ2Cpa
         Ijg+bpvnBDnNFZjyVE6j816muKzOtcO7uXbc7C+JAJr1Zn2J5t1y+AMgWoRpjkZbhJ
         w5CzWk1yBzMo4kR8Asjvg5k8phKwoLjMA5GeDBQyHjqUBOhCvuXGpqhfjwbsk8fvOS
         +cejybX+9PRNuE6e/ywLZwZP+ckCAqN1dwVHaexWHyuX5v5gamDZkcljJbuJyMseBB
         Vd8/rpbZ/piaA==
Date:   Sat, 15 Apr 2023 17:38:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
Message-ID: <20230415173808.208690ff@jic23-huawei>
In-Reply-To: <CAPJMGm6FY-iivtNSavLkwyHY=pgUir-ctT4+hyrAoV+g41e8yg@mail.gmail.com>
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
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Apr 2023 12:42:08 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> On Fri, Apr 14, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >
> > On 13/04/2023 20:19, Fabrizio Lamarque wrote: =20
> > > On Thu, Apr 13, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote: =20
> > >>
> > >> On 13/04/2023 18:07, Fabrizio Lamarque wrote: =20
> > >>> On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@k=
ernel.org> wrote: =20
> > >>>>
> > >>>> On 13/04/2023 10:36, Fabrizio Lamarque wrote: =20
> > >>>
> > >>> Current documentation does not follow existing source code implemen=
tation. =20
> > >>
> > >> Bindings describe hardware, not current implementation. =20
> > > =20
> > >>> The driver has been originally designed to operate with the internal
> > >>> clock when clocks property is omitted. =20
> > >>
> > >> Not really a reason to do it. Reason could be - hardware does not al=
ways
> > >> need clock input. =20
> > >
> > > I hope the change in perspective will be enough. The external clock is
> > > mandatory for some applications.
> > > The internal clock might be required for others. =20
> >
> > I told you that reason you wrote is not enough and you answer "in
> > perspective will be enough". Wait, what? I don't understand it at all. I
> > gave you example reason. If you do not like it, find other reasons which
> > refer to the actual device, not to the specific implementation.

Just leave it vague - we don't need to talk about specific apps. If someone
wired a clock, they probably want that clock an will describe it in their
DTS.

An internal clock is available and may be used if no external clock is prov=
ided.

> > =20
> > >>>
> > >>> I thought the reason is clear from patch 2, but, as Nuno S=C3=A1 al=
ready
> > >>> suggested, I will describe the reasons in full again, each time I p=
ost
> > >>> a revised patch set, even if it is quite verbose. =20
> > >>
> > >> Your commit must answer to why you are doing it. What you are doing =
is
> > >> easily visible from the diff. Rephrase commit msg to explain it and =
add
> > >> proper rationale (hardware related, not driver). =20
> > >
> > > I am really just suggesting to align the documentation with the
> > > driver, since the driver operates the hardware as expected (after the
> > > two regressions fixes). =20
> >
> > Does it mean you are not going to answer to "why?"? I cannot accept such
> > commits. That's the basics of software development and versioning. It's
> > not even Linux kernel related...
> > =20
>=20
> I already wrote that the hardware clock might be generated internally
> and hence not required, but also that an external crystal/oscillator
> is suggested in the datasheet for better performance.
> There shall be a method to choose between the crystal, the external
> oscillator and the internal oscillator.
> This is what I was expecting to write on revised commit information,
> and this was the hopefully accepted "perspective change".
>=20
> I am really sorry but I do not understand what more I should say here.
> I appreciate your explanations and the fact you are taking your time
> to give directions to an obviously inexperienced developer, but my
> lack of understanding is perhaps related to what I called
> "perspective" on which comes first.
> If the above sentence is not enough, I will drop this last patch.
> I did not change the driver at all. The documentation is wrong (where
> it states the clocks property is mandatory) and it was missing
> information on how to choose between the clocks from the beginning.

A simple statement that there is an internal clock that may be used if
no external clock is wired up should be sufficient.  I don't think we
need to talk about precision of clocks etc vs cost of board built and
now that drives a design choice.

>=20
> > =20
> > > Without this change, one should read the source code to understand
> > > which clock is used and when, which bindings have to be applied, and
> > > find that documentation mandates an (already) optional property. =20
> >
> > How is it related? I did not refer whether change is reasonable itself
> > or not. I said you commit msg is very poor and you must answer to "why".
> > Not to "what".
> >
> > (...)
> > =20
> > > =20
> > >>>
> > >>> I kindly ask you whether the entire (corrected) change on the
> > >>> documentation file only (without any change on the driver source co=
de)
> > >>> could be accepted as a single patch. =20
> > >>
> > >> I don't understand the question. Each change should be one logical
> > >> change, but bindings are not related to the driver. =20
> > >
> > > The question came after this:
> > >
> > > On Thu, Apr 13, 2023 at 1:21=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gma=
il.com> wrote: =20
> > >>> I kindly ask you to confirm if, as per your suggestion, I should se=
nd
> > >>> a v3 patch series with the proper "fixes" tag and this last one
> > >>> changed as follows:
> > >>>
> > >>>  - No changes on driver side (keep avdd-supply instead of vref-supp=
ly)
> > >>>  - Indicate in bindings documentation that avdd-supply is vref inst=
ead
> > >>> (with the "Phandle to reference voltage regulator")
> > >>>  - Add dependencies to yaml bindings
> > >>> =20
> > >> Yeps, but note that for the bindings patch you are making distinct c=
hanges (
> > >> adding missing properties and changing one) so someone might complai=
n. But for
> > >> me, personally, they are simple enough that can go in one patch. Jus=
t properly
> > >> document it in the commit description. =20
> > >
> > > I really need to send a proper, complete and acceptable v3 patch set,
> > > or drop patch 3/3 from the set.
> > >
> > > Would you accept the change to adi,ad7192.yaml file alone with both
> > > the change in description of avdd-supply and the additional missing
> > > properties? =20
> >
> > Do you mean by this changing bindings without changing driver? Then
> > depends on the context. The driver must implement bindings, so you
> > should not send patches which break the implementation of interface.
> > =20
>=20
> Perhaps I failed to explain it from the beginning.
> I said "the documentation does not follow the driver" but I understand
> I should have seen it the other way round.

No need to mention the driver at all for the DT binding patch.
You are documenting what could be wired.  We shouldn't care for DT about
what he driver happens to implement today.

>=20
> Actual documentation does not allow the use of the internal oscillator
> or the external crystal.
> By strictly following the documentation I could only use the external
> oscillator option (neither internal nor external crystal oscillator).
> The implementation already had in place more binding options than the
> documented ones, so I am not suggesting to break anything.
>=20
> > =20
> > > Is "Phandle to reference voltage regulator" as a description for
> > > avdd-supply acceptable on your side? =20
> >
> > Sorry, how is this related to our topic? Anyway, drop "phandle to",
> > because you should describe hardware, not syntax of DTS. =20
>=20
> Ok.
>  - Is it acceptable to change the description of property
> "avdd-supply" from "AVdd voltage supply" to "VRef voltage supply"?
No.

We have a slightly complex case of not wanting to break old drivers, but
the binding should be correct none the less.

Binding wise:
* Leave avdd-supply alone.
* Add a new vref-supply entry and list it as required. This is the Binding
  'bug fix' and there should be an appropriate fixes tag.

No need at all for the binding to describe some old buggy driver behaviour.

Driver wise. - with comments on why we are doing this as we are papering
over a bug that will be seen if someone has a DT that worked with the old
code.  That's fine as long as we document that we are doing it.

* Always get vadd-supply (not optional) - we may get a dummy regulator.
  That is fine here.
* Try to use vref-supply first as an optional supply.
* If that fails, then 'use' avdd as if it it were vref. with nice obvious
  comment that this is happening an perhaps even a warning print
  "Warning: Using avdd in place of vref. Likely an old DTS".

Jonathan


>  - It is clear that AVDD pin (almost always tied with DVDD pin with a
> passive filter in the middle) on hardware is not VREF pin, but
> property avdd-supply is treated by the implementation as if it were
> VREF (it's just a matter of misleading name)? I am asking this because
> any (perhaps) formally correct change would break compatibility with
> existing implementations and, according to previous discussions with
> driver maintainers, I am not going to suggest binding name changes any
> more. In case of doubt, I will skip this change in description until a
> better solution is found.
>  - In the hope to submit a patch that does not require additional
> corrections, is a single patch acceptable with both a change in
> description and with the added missing properties (already existing in
> implementation), or should it be split in two?
>=20
> Best regards,
> Fabrizio Lamarque

