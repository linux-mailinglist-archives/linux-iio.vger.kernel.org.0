Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861786D313C
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 16:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDAOJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 10:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAOJT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 10:09:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40E5244
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 07:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6D1E60D33
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 14:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAA0C433EF;
        Sat,  1 Apr 2023 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680358157;
        bh=/NP6u1OO/poncE3FQalvAEtaOieaxtHQ2eiWvr4zUKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJe8ltEE7aetWJhV4seD2A8rIhzDMza+K0uqR0J2xp+heAWyxrPXkM6l1jHETNJhq
         Fl4i+I1C9S4iV+i5E5EwtHg18Dt8zyPbQST+uDnpROmRqS6ZWFFc6KX4+s5KwaDqdY
         v5wABrY0FIkhNa6FvBKUm4wZ/agEQufL1iT1QzqYJzwj/xoA6p8TUkY/LATslrBikA
         obJvQ7LFidGZmj0eR/RraCyuCS15Epu59mRGMt3seQgrWT+5Cd+UsnJV1J8suDHVCZ
         52n1N0nT7+5fYdTqvOjasfO13Ose1QRP6zLrzViqL37kHOpYqtwJGwYah05PoLnvgR
         Z6+t+EJJsx3dg==
Date:   Sat, 1 Apr 2023 15:24:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-staging@lists.linux.dev>, <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: resolver: ads1210: fix config mode
Message-ID: <20230401152425.2dae5505@jic23-huawei>
In-Reply-To: <20230327145414.1505537-1-nuno.sa@analog.com>
References: <20230327145414.1505537-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Mar 2023 16:54:14 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> As stated in the device datasheet [1], bits a0 and a1 have to be set to
> 1 for the configuration mode.
>=20
> [1]: https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad2s1210.pdf
>=20
> Fixes: b19e9ad5e2cb9 ("staging:iio:resolver:ad2s1210 general driver clean=
up")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Oops. Younger more foolish me bug (back in 2011 so I'll cut myself some sla=
ck)

Applied to the togreg branch of iio.git (not rushing something in that is i=
n staging
and has been broken a while without anyone commenting!)

I don't suppose this means you are going to get this ready to move out of s=
taging?
*looks hopeful*

Thanks,

Jonathan
=20
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/ii=
o/resolver/ad2s1210.c
> index e4cf42438487..636c45b12843 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -101,7 +101,7 @@ struct ad2s1210_state {
>  static const int ad2s1210_mode_vals[4][2] =3D {
>  	[MOD_POS] =3D { 0, 0 },
>  	[MOD_VEL] =3D { 0, 1 },
> -	[MOD_CONFIG] =3D { 1, 0 },
> +	[MOD_CONFIG] =3D { 1, 1 },
>  };
> =20
>  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,

