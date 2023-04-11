Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606EA6DDEA2
	for <lists+linux-iio@lfdr.de>; Tue, 11 Apr 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDKO6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDKO6v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 10:58:51 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EED272B
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 07:58:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f21cdfadbso111941997b3.7
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681225129; x=1683817129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+7EgUv9jkdXjRA3gr33Ow73zM+WORow955dG/OXSYw=;
        b=NKdxbJj6+++Qx1RBTul/EYsy4fNEind+c3hExeZZwsD7j+gmZKprlQYNhKojLhIus1
         DREKHOD1m+OzPV4UxWZDrRPhO7uIfWrWnKZODRMnpzxPuxQKeVtsNmL+rHl6VRCIHkmD
         5X0GzwBzv92GOdaNAiaHYjxK43i+iR0UBWj1yku5kRAFFa6ycmbkun1fuBAyz3ByyGSS
         7Os+zcGa9FfpR62qubpr3mQqUzVNbKGJdvt3Y/AgnFNf6EqbwLvcVQXNzbPr2a5frThD
         etowCochjiGdgsB+6zENMWVTUGP7r3FTmy14bWSUYwZ5xxF5eJgjxJDMBxn/RZIIYJdq
         SEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225129; x=1683817129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+7EgUv9jkdXjRA3gr33Ow73zM+WORow955dG/OXSYw=;
        b=4IPR9nbH7pm2TMkg6OEtBRGRpfpMaUe85mwaSHuNJioybdt4AyECII4vLHP9S169q9
         W7enOcH/Pxk9BRQHazRS1/rSmzL96Glm/wYEfZFkXVgAS1IWctS9D0d6R5e+ISWyrvme
         qa+yW5LzRhgkgIS5UeXkBmvqnNNFo5RaE0JySgU0ZnKVnj1D0Gkw08jKG5TWoT2QAScg
         wiltq+SPZEEeXb1+NPJsptz8Kvyvim9CENx4RsPjg7aj4XN8Cd4W4eNCjgJMxKCWxlfS
         35U2qLc79mIDFVmE+JoBd4a/qiTQhMD1cTDT3YZppxz9leZmq4GAIRLqkNpIo0D+naAg
         jYkQ==
X-Gm-Message-State: AAQBX9f3fF1FRAipR76vErwaoBwrIDvLE70DzYvZmnZB/LHI509hWUpH
        jUV35NVloIBom6KmV1udqj1OIg==
X-Google-Smtp-Source: AKy350YvZguoMVEb7BuU+tYn6ewpqtHQt5QTsTvaOUQEe1YtJ88UHklti1wxR2udoKfXJ8YROcf6nQ==
X-Received: by 2002:a81:6607:0:b0:545:62d7:6fac with SMTP id a7-20020a816607000000b0054562d76facmr7401983ywc.10.1681225129441;
        Tue, 11 Apr 2023 07:58:49 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05690c0a8a00b0054f666f32b3sm493469ywb.40.2023.04.11.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:58:48 -0700 (PDT)
Date:   Tue, 11 Apr 2023 10:58:47 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 3/3] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZDV1p36N3wCav/vF@fedora>
References: <cover.1681134558.git.william.gray@linaro.org>
 <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
 <ZDVli05x7u/bg7Zc@smile.fi.intel.com>
 <ZDVpJb9DyIU+5eJf@fedora>
 <ZDVyJV8TfC31TYP2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gFuETjZ/k9bxpdFT"
Content-Disposition: inline
In-Reply-To: <ZDVyJV8TfC31TYP2@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gFuETjZ/k9bxpdFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 05:43:49PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 11, 2023 at 10:05:25AM -0400, William Breathitt Gray wrote:
> > On Tue, Apr 11, 2023 at 04:50:03PM +0300, Andy Shevchenko wrote:
> > > On Mon, Apr 10, 2023 at 10:03:13AM -0400, William Breathitt Gray wrot=
e:
> > > > The Preset Register (PR), Flag Register (FLAG), and Filter Clock
> > > > Prescaler (PSC) have common usage patterns. Wrap up such usage into
> > > > dedicated functions to improve code clarity.
>=20
> ...
>=20
> > > >  	*val =3D 0;
> > >=20
> > > Is not needed now as always being initialized by below call.
> >=20
> > The regmap_noinc_read() call only reads the number of bytes requested.
> > Since we request 3 bytes, the upper bytes of the u64 val remain
> > uninitialized, so that is why we need to set *val =3D 0. This isn't
> > immediately clear in the code, so I can add a comment to make it
> > explicit.
>=20
> Hmm...
> Since we are using byte array for the value, can we actually use
> memset() to show that explicitly? Perhaps in that way it will be more vis=
ible?
>=20
> > > >  	spin_lock_irqsave(&priv->lock, irqflags);
> > > > =20
> > > >  	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->cont=
rol);
> > > > -
> > > > -	for (i =3D 0; i < 3; i++)
> > > > -		*val |=3D (unsigned long)ioread8(&chan->data) << (8 * i);
> > > > +	ioread8_rep(&chan->data, val, 3);
>=20
> But hold on, wouldn't this have an endianess issue? The call fills in LE,
> while here you use the CPU order.
>=20
> > > >  	spin_unlock_irqrestore(&priv->lock, irqflags);
>=20
> That said, I think you should have something like
>=20
> 	u8 value[3];
>=20
> 	ioread8_rep(..., value, sizeof(value));
>=20
> 	*val =3D get_unaligned_le24(value);
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Yes, I think you're right, that solves both problems at once so I'll use
get_aligned_le24() to set *val.

William Breathitt Gray

--gFuETjZ/k9bxpdFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZDV1pwAKCRC1SFbKvhIj
K2kMAQDrWJPvMhPcHbdWvH5AkY0ad7jOK/SX/wZ3onxHUaOz7gD/YS6aHONzpLYQ
A2jVwk6XOn1NF2BILQcKRTPvWCls9gQ=
=VkrK
-----END PGP SIGNATURE-----

--gFuETjZ/k9bxpdFT--
