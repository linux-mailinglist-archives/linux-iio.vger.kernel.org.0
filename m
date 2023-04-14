Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B76E2125
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjDNKm2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNKm1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 06:42:27 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395C1B0
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 03:42:24 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-18782426c4bso8244352fac.9
        for <linux-iio@vger.kernel.org>; Fri, 14 Apr 2023 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681468944; x=1684060944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDYOj58D6gj69+fekH9+uSt/1inXQTOaNhfJMN9zMvU=;
        b=nK42orJRLhxpv7PiNYtUEVu8WSqSBkbuVK1EAWT4S1fRph6JUe8IWg/qw39Yp1in52
         4i0tzja8XT8bmq7CY8liQKfgiUDCBOTvy1g9C0NPD3hjldb+O0XxZeD+VffoIBxGQyui
         cKfNCzAxMzzsEhaSpJYqDf0J3uOGP0LsLwBMP5QALEJd0kJvraoRUil3//PebTxmh2Fh
         Ye8SK9qqaLCTrDrIqBLVrRMi+aR9ziT7Rb8U6MK2Hui7/NL18sdbi6lfoMS14/R/PpfQ
         5dVTniUoQibRsMQChJY1kr1w05sAb93V1/wgUFK6IMjk1vvdb0fwC+rDR5dkH2bLl/Rf
         vnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468944; x=1684060944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDYOj58D6gj69+fekH9+uSt/1inXQTOaNhfJMN9zMvU=;
        b=NMrrCHskWlxcVGwEQ8dX6DuJaDIkELzNaUQvOYz2Cv3jlHRakp1L8UKkjPX45whvtX
         vUt+M9Hyt7m0HX+mz/JBJilAWRjP5GVCZVJIMbYPiy5w3aZF+Nap8hV2tcVeocfrPlvm
         pPBy7dkn1V7Ix9m8FGrxlCW2vC3zotLslepm6qjAGz/3PXuC3qI0gDNActkd40Dyf6yh
         +LHMmvDhTKdBYSCVEHtLaG5rILO3QUMdDwwA3MXYu1LHQ1lbCEFoeIfzUV9Y2t3mA/ez
         2bQS5j1Sd9oXzY3B5eRJarNlyHPKwAahzNvTwKDsQ6W5w0/RIqFOSEh+KYl9kkODZzQR
         5EtQ==
X-Gm-Message-State: AAQBX9cAfU1rzEZLCJjbHsINNB8IleF1PAgDGp+Cox9Qog5uflTR0xOW
        cGphTaeQdaC4iGLqckVY9r33F5SNZmGSR/50qqs=
X-Google-Smtp-Source: AKy350aG4+7T9U6lHvcACSLfPkAdB2FGgbVFPdMLMetYZisau2qA2cS1FMUy/TbiOz9l/2NIWAVqPjfV4JQgal0r+4c=
X-Received: by 2002:a05:6870:5627:b0:184:5cd2:9f9c with SMTP id
 m39-20020a056870562700b001845cd29f9cmr2571244oao.8.1681468939270; Fri, 14 Apr
 2023 03:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
 <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org> <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
 <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org> <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
 <8f14a0b8-8f02-b2a4-725d-0f70c39af9b6@kernel.org>
In-Reply-To: <8f14a0b8-8f02-b2a4-725d-0f70c39af9b6@kernel.org>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Fri, 14 Apr 2023 12:42:08 +0200
Message-ID: <CAPJMGm6FY-iivtNSavLkwyHY=pgUir-ctT4+hyrAoV+g41e8yg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 14, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 13/04/2023 20:19, Fabrizio Lamarque wrote:
> > On Thu, Apr 13, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 13/04/2023 18:07, Fabrizio Lamarque wrote:
> >>> On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@ker=
nel.org> wrote:
> >>>>
> >>>> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
> >>>
> >>> Current documentation does not follow existing source code implementa=
tion.
> >>
> >> Bindings describe hardware, not current implementation.
> >
> >>> The driver has been originally designed to operate with the internal
> >>> clock when clocks property is omitted.
> >>
> >> Not really a reason to do it. Reason could be - hardware does not alwa=
ys
> >> need clock input.
> >
> > I hope the change in perspective will be enough. The external clock is
> > mandatory for some applications.
> > The internal clock might be required for others.
>
> I told you that reason you wrote is not enough and you answer "in
> perspective will be enough". Wait, what? I don't understand it at all. I
> gave you example reason. If you do not like it, find other reasons which
> refer to the actual device, not to the specific implementation.
>
> >>>
> >>> I thought the reason is clear from patch 2, but, as Nuno S=C3=A1 alre=
ady
> >>> suggested, I will describe the reasons in full again, each time I pos=
t
> >>> a revised patch set, even if it is quite verbose.
> >>
> >> Your commit must answer to why you are doing it. What you are doing is
> >> easily visible from the diff. Rephrase commit msg to explain it and ad=
d
> >> proper rationale (hardware related, not driver).
> >
> > I am really just suggesting to align the documentation with the
> > driver, since the driver operates the hardware as expected (after the
> > two regressions fixes).
>
> Does it mean you are not going to answer to "why?"? I cannot accept such
> commits. That's the basics of software development and versioning. It's
> not even Linux kernel related...
>

I already wrote that the hardware clock might be generated internally
and hence not required, but also that an external crystal/oscillator
is suggested in the datasheet for better performance.
There shall be a method to choose between the crystal, the external
oscillator and the internal oscillator.
This is what I was expecting to write on revised commit information,
and this was the hopefully accepted "perspective change".

I am really sorry but I do not understand what more I should say here.
I appreciate your explanations and the fact you are taking your time
to give directions to an obviously inexperienced developer, but my
lack of understanding is perhaps related to what I called
"perspective" on which comes first.
If the above sentence is not enough, I will drop this last patch.
I did not change the driver at all. The documentation is wrong (where
it states the clocks property is mandatory) and it was missing
information on how to choose between the clocks from the beginning.

>
> > Without this change, one should read the source code to understand
> > which clock is used and when, which bindings have to be applied, and
> > find that documentation mandates an (already) optional property.
>
> How is it related? I did not refer whether change is reasonable itself
> or not. I said you commit msg is very poor and you must answer to "why".
> Not to "what".
>
> (...)
>
> >
> >>>
> >>> I kindly ask you whether the entire (corrected) change on the
> >>> documentation file only (without any change on the driver source code=
)
> >>> could be accepted as a single patch.
> >>
> >> I don't understand the question. Each change should be one logical
> >> change, but bindings are not related to the driver.
> >
> > The question came after this:
> >
> > On Thu, Apr 13, 2023 at 1:21=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> >>> I kindly ask you to confirm if, as per your suggestion, I should send
> >>> a v3 patch series with the proper "fixes" tag and this last one
> >>> changed as follows:
> >>>
> >>>  - No changes on driver side (keep avdd-supply instead of vref-supply=
)
> >>>  - Indicate in bindings documentation that avdd-supply is vref instea=
d
> >>> (with the "Phandle to reference voltage regulator")
> >>>  - Add dependencies to yaml bindings
> >>>
> >> Yeps, but note that for the bindings patch you are making distinct cha=
nges (
> >> adding missing properties and changing one) so someone might complain.=
 But for
> >> me, personally, they are simple enough that can go in one patch. Just =
properly
> >> document it in the commit description.
> >
> > I really need to send a proper, complete and acceptable v3 patch set,
> > or drop patch 3/3 from the set.
> >
> > Would you accept the change to adi,ad7192.yaml file alone with both
> > the change in description of avdd-supply and the additional missing
> > properties?
>
> Do you mean by this changing bindings without changing driver? Then
> depends on the context. The driver must implement bindings, so you
> should not send patches which break the implementation of interface.
>

Perhaps I failed to explain it from the beginning.
I said "the documentation does not follow the driver" but I understand
I should have seen it the other way round.

Actual documentation does not allow the use of the internal oscillator
or the external crystal.
By strictly following the documentation I could only use the external
oscillator option (neither internal nor external crystal oscillator).
The implementation already had in place more binding options than the
documented ones, so I am not suggesting to break anything.

>
> > Is "Phandle to reference voltage regulator" as a description for
> > avdd-supply acceptable on your side?
>
> Sorry, how is this related to our topic? Anyway, drop "phandle to",
> because you should describe hardware, not syntax of DTS.

Ok.
 - Is it acceptable to change the description of property
"avdd-supply" from "AVdd voltage supply" to "VRef voltage supply"?
 - It is clear that AVDD pin (almost always tied with DVDD pin with a
passive filter in the middle) on hardware is not VREF pin, but
property avdd-supply is treated by the implementation as if it were
VREF (it's just a matter of misleading name)? I am asking this because
any (perhaps) formally correct change would break compatibility with
existing implementations and, according to previous discussions with
driver maintainers, I am not going to suggest binding name changes any
more. In case of doubt, I will skip this change in description until a
better solution is found.
 - In the hope to submit a patch that does not require additional
corrections, is a single patch acceptable with both a change in
description and with the added missing properties (already existing in
implementation), or should it be split in two?

Best regards,
Fabrizio Lamarque
