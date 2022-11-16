Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9062B124
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 03:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKPCM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Nov 2022 21:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiKPCM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2022 21:12:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70E63A4
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 18:12:56 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w4so9970484qts.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Nov 2022 18:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cOobYcMYk9FTA7EumIRgq+thL2M1fNH70u4jW3pzyy0=;
        b=tyiVgeq54dtqnrnp+lMOBCeLVfhniA+8ZKS7BmaDhWzLG15ADr6DDp1YsbNvHs7cQk
         tDFa/hmJnQE3jgWKAel5/Tr9hZjDiXJ4rBPJyihcFDRVoeBPq4kri+36aeotVAZfUzfY
         e9NG5kVjsEr5AApj2ojQtjyl3CMUz3XE9gwQ/Y2Rbb+xKtC8kyL1eKlow7nCeT1J5kiP
         0pULANDuhEUFXT75VxnDKnldhWAeKQ9M4fVff6XggYiT0xES49LIKoTYnds8SVeNU/dA
         DzcHrfa0yh7iikboNaUZUW/l6P9qiBU0UCkrC+h/V/pBrh7LFZ4dPIywsr3m7i0JZcHt
         m/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOobYcMYk9FTA7EumIRgq+thL2M1fNH70u4jW3pzyy0=;
        b=1l05XVwqGk2zQuIiOcYEIv4s+DXQmCPfQ4IjKHR5752sBwClT68ANLACZ2O/rEaZmJ
         wlhmpbGVrP6MCfqoDBR40DFnr8wXIlrhSrUUzyfJCZH/EhfnspGvtnDzBTAzP7xxLZss
         urQEIP+iMf4pX89x6u2BA3om0DkaAPunOBRiauFhkGIALA25Gu1OoZK2IliqP/HKMK1U
         74BUcwcHiuwdfWGJqE8kjC2uQG01y5k3gaopqh0A5tegIrQiil/8PUlBKPJ/LmQER3d/
         YnBwValn3ElNqewzB89Ia7pamp0v4OJqMSB8Kb0k2gKSaJzf42K23gS3kn7GgUSJzHWO
         F/7g==
X-Gm-Message-State: ANoB5pl88dzF998L88d/0khE5S+B2VWH0HLVCUUI4kAv997BPWcjMDDO
        0zWUK7RAYlkFMxKTyotplMThQQ==
X-Google-Smtp-Source: AA0mqf7PmhlJIY9QecfgRIt+qagF9bYA06MGBmVqf0e08ccoaSXNVmRAMH56MVIXgM6GeTiNVgAkLA==
X-Received: by 2002:a05:622a:1e0a:b0:398:2457:e8f8 with SMTP id br10-20020a05622a1e0a00b003982457e8f8mr19254033qtb.210.1668564775086;
        Tue, 15 Nov 2022 18:12:55 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l20-20020ac84a94000000b003a56796a764sm7948306qtq.25.2022.11.15.18.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:12:54 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:12:51 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y3RHI/Ed1xHpzmCW@fedora>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
 <Y3G6Qe0KMdo2PgaG@fedora>
 <OS0PR01MB5922B01D5E579426608BBA9386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59337BB8E20273468F38560E86059@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <Y3MbM0RtaAKUIyWM@fedora>
 <OS0PR01MB59228EEA7D3ECFCA83B0679386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bDXZKtppW0L952fW"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59228EEA7D3ECFCA83B0679386049@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bDXZKtppW0L952fW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 10:38:32AM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: William Breathitt Gray <william.gray@linaro.org>
> > Sent: 15 November 2022 04:53
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: linux-iio@vger.kernel.org; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-
> > soc@vger.kernel.org
> > Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter
> > driver
> >=20
> > On Mon, Nov 14, 2022 at 05:52:11PM +0000, Biju Das wrote:
> > > > > > +static int rz_mtu3_initialize_counter(struct counter_device
> > > > > > +*counter, int id) {
> > > > > > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > > > > > +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> > > > > > +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> > > > >
> > > > > No need to complicate this, just use priv->ch[0], priv->ch[1],
> > and
> > > > > priv->ch[id]. Same advice applies to the other functions as
> > well.
> > > >
> > > > I get below error when I use array susbscripts. "*ch1 =3D priv-
> > >ch[0];"
> > >
> > > > drivers/counter/rz-mtu3-cnt.c:291:32: error: incompatible types
> > when
> > > > initialising type 'struct rz_mtu3_channel *' using type 'struct
> > > > rz_mtu3_channel'
> > > >   291 |  struct rz_mtu3_channel *ch1 =3D priv->ch[0];
> > > >
> > >
> > > I could use "*ch1 =3D &priv->ch[0];" please let me know is it ok?
> > >
> > > Cheers,
> > > Biju
> >=20
> > Hi Biju,
> >=20
> > I meant to use the array subscripts inline (e.g. priv-
> > >ch[id].function).
> > However, I can see the benefit of using the ch1 and ch2 local
> > variables, so perhaps something like this would be clearer to read:
> >=20
> >     struct rz_mtu3_chanel *const ch =3D priv->ch;
> >     struct rz_mtu3_chanel *const ch1 =3D &ch[0];
> >     struct rz_mtu3_chanel *const ch2 =3D &ch[1];
> >     ...
> >     case RZ_MTU3_16_BIT_MTU1_CH:
> >     case RZ_MTU3_16_BIT_MTU2_CH:
> >             if (ch[id].function !=3D RZ_MTU3_NORMAL) {
> >     ...
>=20
>=20
> OK, I have added below inline function which simplifies the code
> in each function. Is it ok?
>=20
> For eg:
>=20
> +static inline struct rz_mtu3_channel *
> +rz_mtu3_get_ch(struct counter_device *counter, int id)
> +{
> +       struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +       const size_t ch_id =3D RZ_MTU3_GET_HW_CH(id);
> +
> +       return &priv->ch[ch_id];
> +}
>=20
>=20
> @@ -154,11 +163,10 @@ static int rz_mtu3_count_function_read(struct count=
er_device *counter,
>                                        struct counter_count *count,
>                                        enum counter_function *function)
>  {
> -       struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> -       const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +       struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, coun=
t->id);
>=20
>=20
> Cheers,
> Biju

Sure, I think that function will be okay to use.

William Breathitt Gray

--bDXZKtppW0L952fW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3RHIwAKCRC1SFbKvhIj
K0E+AQC1M7fytmAkvb+ADn8XlQfnX4TgXK0M7XGBDYv5tFgGawD/Q22AnY2IKFXS
Sn3K189shnPVrHv9+uQZf5H1E9p5ZQw=
=m4uN
-----END PGP SIGNATURE-----

--bDXZKtppW0L952fW--
