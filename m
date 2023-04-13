Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87F6E13F7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMSTe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMSTd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 14:19:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5D4680
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 11:19:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k22-20020a9d7016000000b006a43382e5b9so1033917otj.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681409972; x=1684001972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+Z6nFZPsB0zo4zM2zHB4bgfIb3i2QgoapALkcGQH40=;
        b=I1qzQO9vrCAMRORkWk6cotlgviVjbsWak1AriNnppj8CDi31XNDIJCdmbOA4m+QEdb
         8LSNO/OF6yKvOzwZB+8yj9pFvRpMzpeQvG0sQbca8b6Faks0vH1PLTjUcSS2VSxvCvef
         4bi4Nq1ZOd+lIcpCYtWsmVqy0L6+2KDcQDf/Gbe3EgfSA1vnF36V6ifACI5p2oT4AR7i
         DxZCS0hzGCXsJXiLJiXrtUbS3MJ+vUNRamx7VEVXb/JLNjwwV6FE1vnz5KudsTIjBmXg
         UDeDBayvhjVPg+v20JCMDBoK51qZACdKGXiXs4+0UuCTFXf+I/KFIT/3bOOldKEFNOOX
         29Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681409972; x=1684001972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+Z6nFZPsB0zo4zM2zHB4bgfIb3i2QgoapALkcGQH40=;
        b=X06BPcskHI9lBUUfIEVtsZrr2p2Y5+NyPD08vWKpJbxXe74J5J8yIuKQigKIDfL9OH
         0eZvbTqEYyn3QPHfWdqXra+05iCvKD9Fq7LTItE9sKH1anKRfHU5JHBvD7lEeETsP6l9
         nmi6l5C35bS98Kb2dMZpXntERaMir/NFWwtjWvHgU4kqae0A+KOvP9PHbX4hx4X81Ot8
         mmFGhuSqZhAatEEuX+lLX6QbdtiIxTXsjujMW/OVJuCieqW+FU2LbXtIJUh2+pJQdFHL
         h8hy4EWT5IS4FwtXNd1IvmcnwfeU7M7zSAo+/Iqo/tzIa/cPFRWZ4YwCw/vb8qHPqZxo
         q0Uw==
X-Gm-Message-State: AAQBX9cJhJeGwHLjfBbtJEEETf5acgwfwVBoTNRgWzTlNTokcvo3ebV+
        ih28j2Ofti5yVsopdshbWMNBPKp1utK/4dm8GFuvrPsNJCI=
X-Google-Smtp-Source: AKy350bXOm3A1CbulhfMUqiR2ARRNrNWfTTXGsoftTZp1NnHKASe7TFaLrJLGHvsz5OnZQIQ3vN52ZbLiyrC6bMxxMI=
X-Received: by 2002:a05:6830:22ce:b0:6a3:dfc9:12db with SMTP id
 q14-20020a05683022ce00b006a3dfc912dbmr834423otc.3.1681409971783; Thu, 13 Apr
 2023 11:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
 <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org> <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
 <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org>
In-Reply-To: <d3c93e92-605a-c486-201d-6c31f55e64b1@kernel.org>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 20:19:20 +0200
Message-ID: <CAPJMGm6JNu8wP2pa1Gr02AoECMesonKzK_OY8TyFvXG1SLxdvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 13, 2023 at 6:35=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/04/2023 18:07, Fabrizio Lamarque wrote:
> > On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
> >
> > Current documentation does not follow existing source code implementati=
on.
>
> Bindings describe hardware, not current implementation.

OK, I'll keep in mind the perspective while describing the change.
The bug corrected by 2/2 was found because the external crystal
oscillator did not work and the internal, fixed clock was always used.
Before the correction, the  driver did not load correctly without the
clocks property. At the same time, the specified frequency was ignored
and the fixed, internal frequency was used instead.
After the correction, I found the documentation telling that clock
property is mandatory, while omitting it is the way to use the
internal, fixed frequency, clock.
The documentation did not explain how to choose between the internal
and external oscillator, but the driver was already designed to
implement the choice.

> > The driver has been originally designed to operate with the internal
> > clock when clocks property is omitted.
>
> Not really a reason to do it. Reason could be - hardware does not always
> need clock input.

I hope the change in perspective will be enough. The external clock is
mandatory for some applications.
The internal clock might be required for others.

>
> >
> > I thought the reason is clear from patch 2, but, as Nuno S=C3=A1 alread=
y
> > suggested, I will describe the reasons in full again, each time I post
> > a revised patch set, even if it is quite verbose.
>
> Your commit must answer to why you are doing it. What you are doing is
> easily visible from the diff. Rephrase commit msg to explain it and add
> proper rationale (hardware related, not driver).

I am really just suggesting to align the documentation with the
driver, since the driver operates the hardware as expected (after the
two regressions fixes).
Without this change, one should read the source code to understand
which clock is used and when, which bindings have to be applied, and
find that documentation mandates an (already) optional property.

>
> >
> >>
> >>> Renamed avdd-supply to vreg-supply, while keeping backward compatibil=
ity
> >>> (deprecated avdd-supply).
> >>
> >> Why?
> >
> > From AD7192 datasheet, you may see AVDD pin/voltage has no
> > relationship with VREF pin/voltage.
> > avdd-supply name is misleading, since it is treated in code as AVDD
> > pin and iio reference voltage instead.
>
> Then why removing AVDD? It is a supply, as you said, thus bindings
> should describe it. I don't understand why AVDD is being deprecated.

Please ignore the deprecation and the additional avdd-supply property.
It will be removed from the next patch version.

I won't be able to provide any patch here without breaking compatibility.
BTW, avdd-supply has nothing to do with vref on the hardware.
In the driver avdd-supply voltage is used as if it were the reference
voltage (VREF pin).
This change will be removed from this patch set, maybe the driver
author could provide something acceptable.
The idea to deprecate it has been suggested in the thread related to
the previous patch version.

> >
> > I kindly ask you whether the entire (corrected) change on the
> > documentation file only (without any change on the driver source code)
> > could be accepted as a single patch.
>
> I don't understand the question. Each change should be one logical
> change, but bindings are not related to the driver.

The question came after this:

On Thu, Apr 13, 2023 at 1:21=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
> > I kindly ask you to confirm if, as per your suggestion, I should send
> > a v3 patch series with the proper "fixes" tag and this last one
> > changed as follows:
> >
> >  - No changes on driver side (keep avdd-supply instead of vref-supply)
> >  - Indicate in bindings documentation that avdd-supply is vref instead
> > (with the "Phandle to reference voltage regulator")
> >  - Add dependencies to yaml bindings
> >
> Yeps, but note that for the bindings patch you are making distinct change=
s (
> adding missing properties and changing one) so someone might complain. Bu=
t for
> me, personally, they are simple enough that can go in one patch. Just pro=
perly
> document it in the commit description.

I really need to send a proper, complete and acceptable v3 patch set,
or drop patch 3/3 from the set.

Would you accept the change to adi,ad7192.yaml file alone with both
the change in description of avdd-supply and the additional missing
properties?
Is "Phandle to reference voltage regulator" as a description for
avdd-supply acceptable on your side?

In case you feel the proposed adjustments are not enough or changes in
documentation are unworthy, I feel it would be better to leave them to
the driver maintainers.
Otherwise, I'll do my best (according to my limited expertise, to the
available time and the acceptable costs for the company I work for) to
provide something acceptable.

Thank you again.

Best regards,
Fabrizio Lamarque
