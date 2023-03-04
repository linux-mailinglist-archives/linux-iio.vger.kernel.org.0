Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F36AABE9
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCDShU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 13:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDShT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 13:37:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A96010A85
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 10:37:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 057AA604EF
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 18:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1F0C433D2;
        Sat,  4 Mar 2023 18:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677955037;
        bh=DR8uIlGnF82GAN84aJv/ynbYmSUNUp2flJj3sxj4xnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eerONQnp+/rC1OtvRrWgeATDvEa6LjWCWhyU3Q99/2OnSW309AqkiQ5maCBku588U
         JwfevQwnEdFo9/Ue7b/gllYDbVcd8QMQoIPF1nDOgOaskWU7zngX+KQhfZTD6dzOeT
         eCz0WjLiDrGFF3Oz8InEMHTeCIpKOJVoN+QLta6uBPz7+kzV09flDlwUfybkUhucLd
         7P6NCGTi0B3G/wazLISeYcEhsOp3HXpZ6FMNHs6DBYrCgxNajyxJHBu1YvVZlzywDM
         C1ps1Q/EIv1VUpVdIxN6vr09Q5aMyLlBq5vsneGap4J3w+ZZSVvGbguMW+wqjSK6LT
         AsmZyK67YXD3Q==
Date:   Sat, 4 Mar 2023 18:37:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230304183713.4cef5c88@jic23-huawei>
In-Reply-To: <c6224b43-b77a-2e7d-2273-f496a7e72e5f@gmail.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
        <20230202165714.0a1c37ac@jic23-huawei>
        <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
        <20230218172052.12c44aa5@jic23-huawei>
        <18a6709b-4d26-2672-b056-669750b4828c@gmail.com>
        <20230226172958.1b4a87f2@jic23-huawei>
        <c88c1672-badd-18ae-fcb7-bf2696319aba@gmail.com>
        <c6224b43-b77a-2e7d-2273-f496a7e72e5f@gmail.com>
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

On Mon, 27 Feb 2023 11:54:59 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 2/27/23 09:22, Matti Vaittinen wrote:
> > On 2/26/23 19:30, Jonathan Cameron wrote: =20
> >> On Sat, 18 Feb 2023 20:08:10 +0200
> >> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >> =20
> >>> Thanks a lot Jonathan,
> >>>
> >>> You have been super helpful :) Thanks!
> >>>
> >>> On 2/18/23 19:20, Jonathan Cameron wrote: =20
> >> Hmm. There is another approach that I'd not thought of in this case=20
> >> because
> >> in my head integration time is more continuous than it is for this=20
> >> part and
> >> that is to fiddle the _raw values (we do this for oversampling or SAR=
=20
> >> ADCs
> >> where things tend to be powers of 2).=C2=A0 The trick is to shift the =
raw=20
> >> value
> >> always so that the 'scale' due to (in this case) integration time rema=
ins
> >> constant.=C2=A0 That separates the two controls completely. =20
> >=20
> > Holy cow! That's a neat trick which I didn't think of!
> >=20
> > Basically, we could do >> 1 for the data when time is 100 mS, >> 2 when=
=20
> > 200 mS and >> 3 when 400 mS. We would want to use 19-bit channel values=
=20
> > then. =20
>=20
> Please ignore my previous mail. It seems I am once again not knowing=20
> what I am talking about. If we take this approach, we shift << 3 when=20
> int time is 55, << 2 for 100 and << 1 for 200. With 400 mS we would not=20
> shift.

Spot on.

>=20
> >> However, I'm not sure that makes sense here where the thing we typical=
ly
> >> want to change when scaling due to saturation is integration time. =20
> >=20
> > That's a bit problematic, yes. We could "fool" the user by doing the=20
> > saturation check in driver, and then just returning the max value of al=
l=20
> > 19-bits set if the saturation is detected. This, however, would yield=20
> > raw values that are slightly off. OTOH, with max sift of 3 bits that's=
=20
> > only 7 'raw ticks' - which I hope is acceptable. I hope the user will=20
> > then be switching to shorter integration time and start getting correct=
=20
> > readings.
> >=20
> > It's slightly sad to say "good bye" to the gain-time-scale helpers but =
I=20
> > guess you just helped me to solve this with a _really_ simple way. We=20
> > can keep those helpers in "back pocket" for the day when we need them ;)
> >=20
> > I will see what comes out of this idea - thanks for the help again!
> >  =20
>=20
> But as you surely knew from the start, the saturation problems kick in=20
> with the 'non maximum sifts' when the _highest_ bits never get set.

Yes, thats what we'd expect to see as we can only measure high light levels
if the integration time is short.

> There the 'saturation detection' would cause a huge jump by suddenly=20
> setting the high bits. So, yes - this does not seem like a feasible=20
> option here :/

Yes, there is no consistent value for saturation if you are changing
the integration time as the real light levels that cause saturation are
dependent on the integration time.

>=20
> /me feels stupid...
>=20
> Sorry for the noise!
No problem.  It's interesting to understand where the limitations on
some of these techniques lie and I hadn't thought about the issue
of saturation as previous times we've done this have typically been
on ADCs doing oversampling or similar where we don't get the same problem.

Jonathan

>=20
> --Matti
>=20

