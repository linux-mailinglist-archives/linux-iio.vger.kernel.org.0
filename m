Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2837F6E11CE
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDMQIL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDMQIK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 12:08:10 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4725B465
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 09:07:43 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187a1387021so881979fac.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681402061; x=1683994061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl+z9ZvGo3NkmkVU4doQJLUodL1Mn6geuAd/z8bA8PY=;
        b=oC6ku1M2DvzGVhux1BuI81qxhWLdNvd4A3a6PrW/nUgeilTIYyow3/cEh8Zx4XahgJ
         vU/Ky0chbb8EdSnbnIJ2uOztPIQSnLtRHAOcYhOkmgq8Ur+VWhkyHeJsUIyS12rCBna4
         gsQpOAg6ISE2sjNNRmOyimkTKKnJ8/QoNTjULH7ySzUaLn5FPKWH3+7P638qaHojctQC
         62pG5vT3EwdKJ7TyMxxNUOiQlk7OVcQzYtYkxKvHaNyyxfSAS/BltcTBM7XwcMEOpVts
         4D+tWM0xFRJNEmaTyUrv6ndZrdDg1Yi6JmJ9nmVGHaqbnWunAqIyiVpEaGFbRCWNa+HK
         aEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402061; x=1683994061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl+z9ZvGo3NkmkVU4doQJLUodL1Mn6geuAd/z8bA8PY=;
        b=g4AFY8PbGnposVeaZ7ii7t4CL+d5CrDWkDPvC2bS75vw3P/93K2Cf7DrTyu7Cj+0bJ
         +AzHO7lnSG94VZURMSG3dXaNsXm7uBrnG4u+zEw5ISKJVivOMYRRNiKXcNTo1n3c9Y9l
         jdmhPNSYcXQCXNRC+UALmhKXn94aZBXJBPWuPnYCCZVu+BAZ+DnkwddEBSbKXggtzJUv
         cpqOKKd2wGQwxVepKHAj2qybJa9NB9VDLt+etRKainBQTUu59u8frRR1KbtTcWd7gcpL
         fSeZokNvZP1N1v15BsxPWa2odEuoqUez46H81AxKlYC6Pnr2fuQFCstH49Rtb9BQjvZ0
         3XFA==
X-Gm-Message-State: AAQBX9ctW/bDbPmFzvdVVJlwnErx3mjVT41jP5bR9Zrjr873JUJeHFXq
        jgCM06vpF+X4Fb4n796cYB9Q5FSQ+Jwg2jVtXI5ZGJLo6r0=
X-Google-Smtp-Source: AKy350ZhVCacBuTTjtdKmql+u1ntNJ7hTxfLh5c0/LLNa1/Gww3Q3paTzVmU/b18GBiM1ZJIQM1N4bdpTtF91CVz/kA=
X-Received: by 2002:a05:6870:7029:b0:177:b258:5a06 with SMTP id
 u41-20020a056870702900b00177b2585a06mr1439451oae.8.1681402061008; Thu, 13 Apr
 2023 09:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com> <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org>
In-Reply-To: <0e86cb99-dfea-5a89-3301-894a90f0964a@kernel.org>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 18:07:30 +0200
Message-ID: <CAPJMGm58m8-Uo2AdABgJNuigtrLE2=_qh1eZnj=1mg+hVPV3EA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 13, 2023 at 4:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/04/2023 10:36, Fabrizio Lamarque wrote:
> > Added undocumented properties:
>
> Use imperative.
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/sub=
mitting-patches.rst#L95
>
> >
> > - adi,clock-xtal
> > - adi,int-clock-output-enable
> >
> > Removed clocks from required properties.
>
> Why?

Current documentation does not follow existing source code implementation.
Patch 2/3 fixes a commit that caused an unwanted logical inversion and
thus prevented the use of  external clock/crystal.
The driver has been originally designed to operate with the internal
clock when clocks property is omitted.

I thought the reason is clear from patch 2, but, as Nuno S=C3=A1 already
suggested, I will describe the reasons in full again, each time I post
a revised patch set, even if it is quite verbose.

>
> > Renamed avdd-supply to vreg-supply, while keeping backward compatibilit=
y
> > (deprecated avdd-supply).
>
> Why?

From AD7192 datasheet, you may see AVDD pin/voltage has no
relationship with VREF pin/voltage.
avdd-supply name is misleading, since it is treated in code as AVDD
pin and iio reference voltage instead.
The option to change the regulator name or add a third regulator would
have broken compatibility.
Other ADI drivers already have the vref-supply property in place.

Here again I partially left the reasons in the first thread, sorry.

In any case I will remove this change on a revised patch set.
I will leave the avdd-supply name but I'll change the description in
documentation.

>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>

The single change on documentation will be prepended by
dt-bindings: iio: ad7192:
The invalid change I suggested intended to change avdd to vref name in
the driver too.
I misinterpreted the meaning of a single "logical change", sorry.

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
>
> You decided to ignore quite a lot of entries, but most important - also
> lists, so it won't even be tested.

The patch is indeed based on the latest version; however the driver
maintainer does not work in ADI any more; the first time I sent a
message I got the email bounced back.
I see I omitted a necessary step though.

You are right in saying that I did not follow carefully the
instructions provided, but it was not deliberate. It's the first time
I am trying to send back the changes.
I appreciate the feedback and corrections; in the next patch set I
will try to remedy everything you indicated.

>
> > ---
> >  .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----
>
> Bindings are always separate patches.
>
> Corrupted patch.
>
> Run checkpatch, test your patches with dt_binding_check. This really
> needs a lot of work.

I kindly ask you whether the entire (corrected) change on the
documentation file only (without any change on the driver source code)
could be accepted as a single patch.

Unless I was wrong in doing copy/paste, the only feedback I got from
the tests is a warning message telling that the changes to
documentation should be isolated from source code changes.
I will make sure these tests pass without any warning.

Thank you and best regards,
Fabrizio Lamarque
