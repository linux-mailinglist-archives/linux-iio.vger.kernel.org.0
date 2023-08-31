Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632B078E7C6
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjHaIU0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Aug 2023 04:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHaIU0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 04:20:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56184EE
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 01:20:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1f6f3884so55459766b.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Aug 2023 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693470022; x=1694074822; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MW/iuIrJvKnjqdfYG2ZU4ao2i2VUqispYXVeWvw5eGQ=;
        b=llOtEfMBRGwzaik5benvH+2KJBa5Cuf8CIoOyBt4vjgJwrTtUcwJ7fsJi8W7jVdb2U
         iA8tG1jYRB4dQWEZUcBgpaHg8AHyzlQADaAJEpUt69XkJpJ79/hTwbJ5bDlUDyaONNUq
         iL/B3FtemQq3ty8sXQ9gwbgeZTZXoX+b550cY5o4cHAb/e01RANjhNrUBfASgKWmfoCt
         nC5jysZM+MzrcGPB6RkGlGuNvLsQumjnhHKxwJgHv16UYdelQb6HuO94D10YLLCp2YyX
         8BmWSomUovne5J7LfYqhhh5QftBpvOdux5+XX6VKDBpxsg7z99+r2coLr8MzFqakay7R
         x5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470022; x=1694074822;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MW/iuIrJvKnjqdfYG2ZU4ao2i2VUqispYXVeWvw5eGQ=;
        b=CZrq4kvSvg6TyfwvY+grFPmdV8v0mDSIf+WFFU9tnxS05Hoc3FoFlMOvX6AO51j6Qp
         A7FVS4Jfp1UdaIxmiyDb92EidMKOBqZpmoHSHaPjGVrjslMs4R3vATPJU8iuw97eX4XO
         HBn1hDwBVoyGuOj9VgQerI1wFxvL8jRECXvmSyaRGO13TCRBG+lNLp6POWtY6MGtpDCp
         DWt4OEYW6I/mcuMPttJpgG5++ICdQ03XpSjF4j15qY/fEYUMQ95pZ5Tdo5HaPQdym9GZ
         DM3vpfb4LIvVyBta1Rhf7M0h8oe6cHBKFYushHyzfprx1QHC0ym2tuuGyoTSm4nLy65O
         sGEA==
X-Gm-Message-State: AOJu0Yy9SX87CiqCVjYh77sqvLHNFbSlvZVHoThJOElwTWYTaWNct4bG
        eIPwGzpkoMeEDKSolRhewiI=
X-Google-Smtp-Source: AGHT+IGVGxyIxhu4UHNhQ1ADGIw40VjkSn1aCnvM7Jo5J3jOBn/qB2sJJ70Aleu0wQbrJiZUsTDk6Q==
X-Received: by 2002:a17:907:7717:b0:9a1:be5b:f4aa with SMTP id kw23-20020a170907771700b009a1be5bf4aamr3284718ejc.0.1693470021638;
        Thu, 31 Aug 2023 01:20:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:3488:8a01:c631:bde5:1eff:9b66? ([2001:a61:3488:8a01:c631:bde5:1eff:9b66])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906914800b0098951bb4dc3sm484637ejw.184.2023.08.31.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:20:21 -0700 (PDT)
Message-ID: <d4eead3eedb99e252f7c022ce5572a3a307b9b1e.camel@gmail.com>
Subject: Re: [RFC PATCH 0/3] Add converter framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 31 Aug 2023 10:20:20 +0200
In-Reply-To: <20230830172903.0000027f@Huawei.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
         <20230830172903.0000027f@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2023-08-30 at 17:29 +0100, Jonathan Cameron wrote:
> On Fri, 4 Aug 2023 16:53:38 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > This is the initial RFC following the discussion in [1]. I'm aware this=
 is
> > by no means ready for inclusion and it's not even compilable since in
> > the RFC I did not included the patch to add component_compare_fwnode()
> > and component_release_fwnode().=20
>=20
> Whilst I haven't read this through yet, I suspect Olivier will be able to
> offer some insight on some of this and likewise you may be able to
> point out pitfalls etc in his series (I see you did some review already :=
)
>=20
> https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan=
@foss.st.com/
>=20
> Both are about multiple interacting components of an overall datapath.
> Whether there is commonality isn't yet clear to me.
>=20

I made a very general comment in that series but I need to look better at i=
t. Not
sure if we can merge them together but let's see...

> >=20
> > The goal is to have a first feel on the
> > direction of the framework so that if I=C2=A0 need to drastically chang=
e it,
> > better do it now. The RFC also brings the ad9647 and the axi_adc core t=
o
> > the same functionality we have now upstream with one extra fundamental
> > feature that is calibrating the digital interface. This would be very
> > difficult to do with the current design. Note that I don't expect any
> > review on those drivers (rather than things related to the framework).=
=20
> >=20
> > I also want to bring up a couple of things that I've
> > been thinking that I'm yet not sure about (so some feedback might make
> > mind in one direction or another).
> >=20
> > 1) Im yet not sure if I should have different compatibles in the
> > axi-adc-core driver. Note this soft core is a generic core and for ever=
y
> > design (where the frontend device changes or has subtle changes like
> > different number of data paths) there are subtle changes. So, the numbe=
r
> > of channels might be different, the available test patterns might be
> > different, some ops might be available for some designs but not for
> > others, etc...=20
>=20
> I don't suppose there is any chance Analog can make at least some of this
> discoverable from the hardware?=C2=A0 Capability registers etc in the lon=
g
> run. Can't fix what is already out there.
>=20

Well, it is a soft core so my naive assumption is that it's doable if some =
HDL guy is
willing to implement it. But yes, it might get supported only for new desig=
ns.

> > With a different compatible we could fine tune
> > those differences (with a chip_info like structure) and pass some const
> > converter_config to the framework that would allow it to do more safety
> > checks and potentially reduce the number of converter_ops.
> > OTOH, starting to add all of these compatibles might become messy in th=
e
> > long run and will likely mean that we'll always have to change both
> > drivers in order to support a new frontend. And the frontend devices
> > should really be the ones having all the "knowledge" to configure the
> > soft core even if it means more converter_ops (though devicetree might
> > help as some features are really HW dependent). I more inclined to just
> > leave things as-is in the RFC.
>=20
> I'm fine with putting this stuff in DT where possible.
>=20
> >=20
> > 2) There are some IIO attributes (like scale, frequency, etc) that migh=
t
> > be implemented in the soft cores. I still didn't made my mind if I shou=
ld just
> > have a catch all read_raw() and write_raw() converter_ops or more fine
> > tuned ops. Having the catch all reduces the number of ops but also make=
s
> > it more easier to add stuff that ends up being not used anymore and the=
n
> > forgotten. There are also cases (eg: setting sampling frequency) where
> > we might need to apply settings in both the frontend and the backend
> > devices which means having the catch all write_raw() would be more
> > awkward in these case. I'm a bit more inclined to the more specific ops=
.=20
>=20
> It's the kernel - we can always change the internal API later as long as =
we
> don't touch the user space part.=C2=A0 Go with your gut feeling today and
> if it changes this sort of refactor usually isn't that bad.
>=20

Agreed...

>=20
- Nuno S=C3=A1
