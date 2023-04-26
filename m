Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12F56EF28D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Apr 2023 12:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbjDZKrF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Apr 2023 06:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjDZKqb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2023 06:46:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367F0BF
        for <linux-iio@vger.kernel.org>; Wed, 26 Apr 2023 03:45:43 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-38e3a1a07c8so4065213b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Apr 2023 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682505942; x=1685097942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI1rjMjugLRLgQsqMH6ohWMULQadjvWpk2HM1o3/hpI=;
        b=Jf9i7wXqp5F0hIH4Bt48ubf1YGRyZ6tAPoI3w0XZ0iCmYnq85d1Xovk26jvH88KSE6
         HC+yusfxHq3/mXLqPvyNRBvZ+HB+R+biNT7WkjLtEC/fDoOl2JmxdcE2hLiV4IpWoimH
         vpuZTsjkA846L4tfy248TuJksOhH90B201JfnzfHv5R90F1rlU+yKUMv1pOffcADXyZU
         U0H+VzMTE9YxA6lGAvd6L+i8iUz/nB5iOYo+YJGomZgEm6TUylWS73EsE5XnUYEyFOlm
         rn73ubNI1HBQi+ReuMEukE9+qb4OIzX5A7nQMawHtZz5GR0WhU7hq4xo/P/vKXYEdpuZ
         pU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682505942; x=1685097942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI1rjMjugLRLgQsqMH6ohWMULQadjvWpk2HM1o3/hpI=;
        b=DL2CHJSvjOOVwN64M7Vv5VhyfszPiOAF0CxnR1LzsGBSN6w1YgQp2jrwUPAII4NAZB
         zPeFmjD2HmVKlZrOOEec0gBiOXF84uj/lFeE6fqJqzi86rvkZimYO3xrK74yY1RnWuUB
         vcdKxw+hL7USmK0R++oJlylDd9NihnIMSPRktgt1pHG4EhhFnahD9EP0GB1CEP8QMyL5
         IlDR0xhhj6XEOgypB4xE94C/PjAKmGoFJ2cqszQuKMN/t8RFj3OVd7fqiIA+8cv8f1e8
         CXlYQTnBYUnVDAyIGOVA0Y5KM4xBSD0PdY65D34GIrPbMAs3pccUDuV60WBCQTFNS+AA
         TkZQ==
X-Gm-Message-State: AAQBX9f6RQE8gvJ8Z+sJ0OgddU3okMYPQKgHCcchUskXZLGzgl5sEADS
        79DAF30Ge+4ojtQUOLoZ0iggP8FRd7ujA+RQyQM=
X-Google-Smtp-Source: AKy350ZxO8tZNR/Mo1xe29XqryYuBhR65aKxZ0GIwrMuIea2EdZiFkGDpGG9xKZuOvpqRJTROsLvbYgGCXQD6mXvlBQ=
X-Received: by 2002:a05:6808:651:b0:384:67e1:c9f7 with SMTP id
 z17-20020a056808065100b0038467e1c9f7mr10197527oih.45.1682505942194; Wed, 26
 Apr 2023 03:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
 <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org> <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
 <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org> <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
 <8f14a0b8-8f02-b2a4-725d-0f70c39af9b6@kernel.org> <CAPJMGm6FY-iivtNSavLkwyHY=pgUir-ctT4+hyrAoV+g41e8yg@mail.gmail.com>
 <20230415173808.208690ff@jic23-huawei>
In-Reply-To: <20230415173808.208690ff@jic23-huawei>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Wed, 26 Apr 2023 12:45:31 +0200
Message-ID: <CAPJMGm7+oYDJHt6SPAhJ8cHuE3VXWxx6XYF1T_8oKwQGo+iarA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
        =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
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

On Sat, Apr 15, 2023 at 6:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 14 Apr 2023 12:42:08 +0200
> Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:
>
> > On Fri, Apr 14, 2023 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> > >
> > > On 13/04/2023 20:19, Fabrizio Lamarque wrote:
> > > > On Thu, Apr 13, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski <krzk@k=
ernel.org> wrote:
> > > >>
> > > >> On 13/04/2023 18:07, Fabrizio Lamarque wrote:
> > > >>> On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk=
@kernel.org> wrote:
> > > >>>>
> > > >>>> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
> > > >>>
> > > >>> Current documentation does not follow existing source code implem=
entation.
> > > >>
> > > >> Bindings describe hardware, not current implementation.
> > > >
> > > >>> The driver has been originally designed to operate with the inter=
nal
> > > >>> clock when clocks property is omitted.
> > > >>
> > > >> Not really a reason to do it. Reason could be - hardware does not =
always
> > > >> need clock input.
> > > >
> > > > I hope the change in perspective will be enough. The external clock=
 is
> > > > mandatory for some applications.
> > > > The internal clock might be required for others.
> > >
> > > I told you that reason you wrote is not enough and you answer "in
> > > perspective will be enough". Wait, what? I don't understand it at all=
. I
> > > gave you example reason. If you do not like it, find other reasons wh=
ich
> > > refer to the actual device, not to the specific implementation.
>
> Just leave it vague - we don't need to talk about specific apps. If someo=
ne
> wired a clock, they probably want that clock an will describe it in their
> DTS.
>
> An internal clock is available and may be used if no external clock is pr=
ovided.
>
> > >
> > > >>>
> > > >>> I thought the reason is clear from patch 2, but, as Nuno S=C3=A1 =
already
> > > >>> suggested, I will describe the reasons in full again, each time I=
 post
> > > >>> a revised patch set, even if it is quite verbose.
> > > >>
> > > >> Your commit must answer to why you are doing it. What you are doin=
g is
> > > >> easily visible from the diff. Rephrase commit msg to explain it an=
d add
> > > >> proper rationale (hardware related, not driver).
> > > >
> > > > I am really just suggesting to align the documentation with the
> > > > driver, since the driver operates the hardware as expected (after t=
he
> > > > two regressions fixes).
> > >
> > > Does it mean you are not going to answer to "why?"? I cannot accept s=
uch
> > > commits. That's the basics of software development and versioning. It=
's
> > > not even Linux kernel related...
> > >
> >
> > I already wrote that the hardware clock might be generated internally
> > and hence not required, but also that an external crystal/oscillator
> > is suggested in the datasheet for better performance.
> > There shall be a method to choose between the crystal, the external
> > oscillator and the internal oscillator.
> > This is what I was expecting to write on revised commit information,
> > and this was the hopefully accepted "perspective change".
> >
> > I am really sorry but I do not understand what more I should say here.
> > I appreciate your explanations and the fact you are taking your time
> > to give directions to an obviously inexperienced developer, but my
> > lack of understanding is perhaps related to what I called
> > "perspective" on which comes first.
> > If the above sentence is not enough, I will drop this last patch.
> > I did not change the driver at all. The documentation is wrong (where
> > it states the clocks property is mandatory) and it was missing
> > information on how to choose between the clocks from the beginning.
>
> A simple statement that there is an internal clock that may be used if
> no external clock is wired up should be sufficient.  I don't think we
> need to talk about precision of clocks etc vs cost of board built and
> now that drives a design choice.
>
> >
> > >
> > > > Without this change, one should read the source code to understand
> > > > which clock is used and when, which bindings have to be applied, an=
d
> > > > find that documentation mandates an (already) optional property.
> > >
> > > How is it related? I did not refer whether change is reasonable itsel=
f
> > > or not. I said you commit msg is very poor and you must answer to "wh=
y".
> > > Not to "what".
> > >
> > > (...)
> > >
> > > >
> > > >>>
> > > >>> I kindly ask you whether the entire (corrected) change on the
> > > >>> documentation file only (without any change on the driver source =
code)
> > > >>> could be accepted as a single patch.
> > > >>
> > > >> I don't understand the question. Each change should be one logical
> > > >> change, but bindings are not related to the driver.
> > > >
> > > > The question came after this:
> > > >
> > > > On Thu, Apr 13, 2023 at 1:21=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@g=
mail.com> wrote:
> > > >>> I kindly ask you to confirm if, as per your suggestion, I should =
send
> > > >>> a v3 patch series with the proper "fixes" tag and this last one
> > > >>> changed as follows:
> > > >>>
> > > >>>  - No changes on driver side (keep avdd-supply instead of vref-su=
pply)
> > > >>>  - Indicate in bindings documentation that avdd-supply is vref in=
stead
> > > >>> (with the "Phandle to reference voltage regulator")
> > > >>>  - Add dependencies to yaml bindings
> > > >>>
> > > >> Yeps, but note that for the bindings patch you are making distinct=
 changes (
> > > >> adding missing properties and changing one) so someone might compl=
ain. But for
> > > >> me, personally, they are simple enough that can go in one patch. J=
ust properly
> > > >> document it in the commit description.
> > > >
> > > > I really need to send a proper, complete and acceptable v3 patch se=
t,
> > > > or drop patch 3/3 from the set.
> > > >
> > > > Would you accept the change to adi,ad7192.yaml file alone with both
> > > > the change in description of avdd-supply and the additional missing
> > > > properties?
> > >
> > > Do you mean by this changing bindings without changing driver? Then
> > > depends on the context. The driver must implement bindings, so you
> > > should not send patches which break the implementation of interface.
> > >
> >
> > Perhaps I failed to explain it from the beginning.
> > I said "the documentation does not follow the driver" but I understand
> > I should have seen it the other way round.
>
> No need to mention the driver at all for the DT binding patch.
> You are documenting what could be wired.  We shouldn't care for DT about
> what he driver happens to implement today.

Thank you once again for your corrections, suggestions and patience.
I hope to be able to provide a formally corrected patch set. Before
sending v3, would you please have a look at this and check if it
correctly responds to your expectations or if there is still something
to adjust?
(in case it would be cleaner to send a v3 patch and wait for feedback
instead, feel free to ask)

The patch set will be then split in 5 total commits.
 - iio: adc: ad7192: Fix null ad7192_state pointer access
 - iio: adc: ad7192: Fix internal/external clock selection
 - iio: adc: ad7192: Use VRef instead of AVdd as reference voltage source
 - dt-bindings: iio: ad7192: Add mandatory reference voltage source
 - dt-bindings: iio: ad7192: Allow selection of clock modes

Patches "iio: adc: ad7192: Use VRef instead of AVdd as reference
voltage source" and "iio: adc: ad7192: Use VRef instead of AVdd as
reference voltage source" and will be a fix against b581f748cce0
("staging: iio: adc: ad7192: move out of staging").

First commit message on bindings will be:

Add required reference voltage (VRef) supply regulator.
AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
(on REFINx pin pairs).

Some questions:
 - Is the FIxes tag referenced commit acceptable, or should it be
explained? If so, what should I write?
 - Is the commit message acceptable?

>
> >
> > Actual documentation does not allow the use of the internal oscillator
> > or the external crystal.
> > By strictly following the documentation I could only use the external
> > oscillator option (neither internal nor external crystal oscillator).
> > The implementation already had in place more binding options than the
> > documented ones, so I am not suggesting to break anything.
> >
> > >
> > > > Is "Phandle to reference voltage regulator" as a description for
> > > > avdd-supply acceptable on your side?
> > >
> > > Sorry, how is this related to our topic? Anyway, drop "phandle to",
> > > because you should describe hardware, not syntax of DTS.
> >
> > Ok.
> >  - Is it acceptable to change the description of property
> > "avdd-supply" from "AVdd voltage supply" to "VRef voltage supply"?
> No.
>
> We have a slightly complex case of not wanting to break old drivers, but
> the binding should be correct none the less.
>
> Binding wise:
> * Leave avdd-supply alone.
> * Add a new vref-supply entry and list it as required. This is the Bindin=
g
>   'bug fix' and there should be an appropriate fixes tag.
>
> No need at all for the binding to describe some old buggy driver behaviou=
r.
>
> Driver wise. - with comments on why we are doing this as we are papering
> over a bug that will be seen if someone has a DT that worked with the old
> code.  That's fine as long as we document that we are doing it.
>
> * Always get vadd-supply (not optional) - we may get a dummy regulator.
>   That is fine here.
> * Try to use vref-supply first as an optional supply.
> * If that fails, then 'use' avdd as if it it were vref. with nice obvious
>   comment that this is happening an perhaps even a warning print
>   "Warning: Using avdd in place of vref. Likely an old DTS".

Here is the change I am backporting and testing on my platform:

Subject: [PATCH v3 3/5] iio: adc: ad7192: Use VRef instead of AVdd as
 reference voltage source

Add missing vref-supply and fix avdd-supply used as if it were vref.

AD7192 requires three independent voltage sources, digital supply (on
pin DVdd), analog supply (on AVdd) and reference voltage (VRef on
alternate pin pair REFIN1 or REFIN2).

Emit a warning message when AVdd is used in place of VRef for backwards
compatibility.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 drivers/iio/adc/ad7192.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 5a9c8898f8af..4ac6843b7c23 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -177,6 +177,7 @@ struct ad7192_chip_info {
 struct ad7192_state {
     const struct ad7192_chip_info    *chip_info;
     struct regulator        *avdd;
+    struct regulator        *vref;
     struct clk            *mclk;
     u16                int_vref_mv;
     u32                fclk;
@@ -1014,11 +1015,30 @@ static int ad7192_probe(struct spi_device *spi)
     if (ret)
         return ret;

+    st->vref =3D devm_regulator_get_optional(&spi->dev, "vref");
+    if (!IS_ERR(st->vref)) {
+        ret =3D regulator_enable(st->vref);
+        if (ret) {
+            dev_err(&spi->dev, "Failed to enable specified VRef supply\n")=
;
+            return ret;
+        }
+
+        ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable,
st->vref);
+        if (ret)
+            return ret;
+    }
+
     ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
     if (ret)
         return dev_err_probe(&spi->dev, ret, "Failed to enable
specified DVdd supply\n");

-    ret =3D regulator_get_voltage(st->avdd);
+
+    if (!IS_ERR(st->vref)) {
+        ret =3D regulator_get_voltage(st->vref);
+    } else {
+        dev_warn(&spi->dev, "Using AVdd in place of VRef. Likely an
old DTS\n");
+        ret =3D regulator_get_voltage(st->avdd);
+    }
     if (ret < 0) {
         dev_err(&spi->dev, "Device tree error, reference voltage undefined=
\n");
         return ret;
--=20
2.34.1

I kindly ask you this advice:
 - when reference voltage is read from AVdd, should I set the vref
pointer to NULL, or is IS_ERR check acceptable as proposed in the
patch?

Best regards,
Fabrizio Lamarque

>
> Jonathan
>
>
> >  - It is clear that AVDD pin (almost always tied with DVDD pin with a
> > passive filter in the middle) on hardware is not VREF pin, but
> > property avdd-supply is treated by the implementation as if it were
> > VREF (it's just a matter of misleading name)? I am asking this because
> > any (perhaps) formally correct change would break compatibility with
> > existing implementations and, according to previous discussions with
> > driver maintainers, I am not going to suggest binding name changes any
> > more. In case of doubt, I will skip this change in description until a
> > better solution is found.
> >  - In the hope to submit a patch that does not require additional
> > corrections, is a single patch acceptable with both a change in
> > description and with the added missing properties (already existing in
> > implementation), or should it be split in two?
> >
> > Best regards,
> > Fabrizio Lamarque
>
