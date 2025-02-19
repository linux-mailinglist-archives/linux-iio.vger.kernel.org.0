Return-Path: <linux-iio+bounces-15798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6790A3C433
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4ED57A77BB
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7691F8BCC;
	Wed, 19 Feb 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W6qIqLHU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4891FCCF5
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980449; cv=none; b=S9iyuK975TEEJgy+jNRqrq+r1EPTcvw9p/iQZRRBqiJViIJpr9CyQvkbEeJKbUUrnpxzNEV+nJItjFoe0bEIxu8bl1IczBapOVZNwhaHS4W1NwqSQLxBrKGJsFJn+BEy3/zZ1e4wa/cGpp48BSqxfg9UGil0YBzukSYQxpLpPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980449; c=relaxed/simple;
	bh=s5MzxyKvsyEYBYrvNz6+0ntDjzoYrdjXYLL8YqFlP6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGsyXrZ6wIfK5kZDYIWwColYX5ccYStqCHN6I2DOAVimK/nLgxe8DLuxLEV7u+ekCqIGxXUhYGU6AOrxn7icb9Sulhg4N7ilO+M5FzggKpbQ3DpCbW306Ta3T5OGOmjDZP6Y6VpD5LehofI05pt8EByuT+tIhgby5TNe/yoGq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W6qIqLHU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f22fe889aso5478597f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 07:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739980444; x=1740585244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJmRSUKL8F6ABuVjT69RlXhEUGlr4KIwTwqYJpsm44o=;
        b=W6qIqLHUCLqNKAxID9EF9zpmA5C8pWmn6raQeJT2isuJY2cbqfNDI5wPwntSNva4Ej
         Qd7nO9tB4RvoIlnyFDOYtYX52if3kr1YwQEXhE0/PS7JyBVRmk+yZH4GTPzbv6asBAbS
         jXwWHDtBpUhp7qoj2QieGhHq/5LENETH/xmv500hebUF+Y6GSiGbsFenh6zoIKIb2R8a
         Mn3nO3UntUj+G9Aud9SPfm5fjpmov5U1DhhCDmt160NStq8ccQ/vFvwBg32yZ4NdsL8m
         VjQmzo5+5N+zKlgORldpm9uC/XBP217DOwv84fL3Kf8iLeuRaCHkAceemH4STlJOcb9H
         B9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739980444; x=1740585244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJmRSUKL8F6ABuVjT69RlXhEUGlr4KIwTwqYJpsm44o=;
        b=DsVdghpEbMoKkcZqvpNzvtQEV0Qe0XEXveMl00XfJMLuPJ9/bEXxM+j56LScE9iOY4
         voN08sPOqPXq9P+xfHOL7DE6NOUTKB3XncAyhFvHWljxhYvj/RMqxlJV3JZK6VfKFfFf
         4lZwsJsI9MJrEL78RRZ2LLwN+rTWFka00NCNEqfJyaySgJnU2ClTyTp6PUJ3hp9xCMRr
         Dz+y3uTLcaTQ/jyYJL+Ilg/W41dzVi1JLUvCnGj3kcmXdG7CshqhLzpWBFjh3bX0nkqh
         b4lOsgM/RGqUEo4si7njUSWvVY/dXdm/b1+NEHYe0s/IvWJyV6+wCfdbIkGvJQmVmBMQ
         K4lw==
X-Forwarded-Encrypted: i=1; AJvYcCWg/S9Gm33qQQUiaGJLPCWXZO/hdNjbpvii4n1Ys4lxsapeMERqzeKs5cx7o0rXepb5LTxWHaRDH+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKk651FsjB0kKgL8N6qxmGfWZMY0IX1qTBFi4CRRYpqLJW9+q
	7aGjzgwzkcg6ZHJyfM8Dr6I056oQotozEgHjlYdjDIy3+5ZwSpHWM61dcsCnDms=
X-Gm-Gg: ASbGncuy4VFjjnyrh6CLqoV1Ja3+ai8UNlJ8l8E86W/TXPZK5xZfbAgEsqEtr1xSX/j
	LUsTdoC2u2TenJzaYGehiMbrSLhOubhBrwLCbki3JTU7tVf6iTkM4IwJhAfFH0lIBszc6NTsRzX
	nyVpHq25ikKhOzG9eAGZFvxDJP1FfrVzxdnaCULF2m+slt6WLXdG+iH/ka7YAQSsmzYUN1VEA7r
	k496J+dyv4mcVmmS9JBoD0ISxloYrjxTGJu8Q+jW/IUGOIChDUvz1GqyUnBOcLh5mtjTW10ZfP9
	FHljQrmAabABTn8NE4wPrcIyPHBkB62gSRCuAI0FTIDd5l5PakBNSMScaA==
X-Google-Smtp-Source: AGHT+IEtqiGBsSY128uo+BoAGh9P0Wn+u6ZdCoc9mwYUfBpVWXs+LwP1cHGsV0roi4ZxBlwN3qK3Iw==
X-Received: by 2002:a5d:47c3:0:b0:38f:3c6c:28ff with SMTP id ffacd0b85a97d-38f3c6c2ce0mr15508564f8f.23.1739980443959;
        Wed, 19 Feb 2025 07:54:03 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm18402851f8f.67.2025.02.19.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:54:03 -0800 (PST)
Date: Wed, 19 Feb 2025 16:54:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ad4130: Fix comparison of channel setups
Message-ID: <vxwfhjbrrs6e3sk7xvrdtshvr3suna45qiluu3zxba3dg2cy3b@gqnvtmlnufdk>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
 <4d1ba8c9a890393fce38083b01db6ce03df8ac5b.1739902968.git.u.kleine-koenig@baylibre.com>
 <CAHp75VfmYVBpmq1_bChNrZ+pgcHN_eBOYTcnhcxqWvhKxx0G1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agroq5nuknnye377"
Content-Disposition: inline
In-Reply-To: <CAHp75VfmYVBpmq1_bChNrZ+pgcHN_eBOYTcnhcxqWvhKxx0G1g@mail.gmail.com>


--agroq5nuknnye377
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/6] iio: adc: ad4130: Fix comparison of channel setups
MIME-Version: 1.0

On Wed, Feb 19, 2025 at 10:53:54AM +0200, Andy Shevchenko wrote:
> On Tue, Feb 18, 2025 at 8:31=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Checking the binary representation of two structs (of the same type)
> > for equality doesn't have the same semantic as comparing all members for
> > equality. The former might find a difference where the latter doesn't in
> > the presence of padding or when ambiguous types like float or bool are
> > involved. (Floats typically have different representations for single
> > values, like -0.0 vs +0.0, or 0.5 * 2=C2=B2 vs 0.25 * 2=C2=B3. The type=
 bool has
> > at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
> > true, but memcmp finds a difference.)
> >
> > When searching for a channel that already has the configuration we need,
> > the comparison by member is the one that is needed.
> >
> > Convert the comparison accordingly to compare the members one after
> > another. Also add a BUILD_BUG guard to (somewhat) ensure that when
> > struct ad4130_setup_info is expanded, the comparison is adapted, too.
>=20
> ...
>=20
> > +/*
> > + * If you make adaptions in this struct, you most likely also have to =
adapt
>=20
> adaptations?

ack.

> > +static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
> > +                                struct ad4130_setup_info *b)
> > +{
> > +       /*
> > +        * This is just to make sure that the comparison is adapted aft=
er
> > +        * struct ad4130_setup_info was changed.
> > +        */
> > +       static_assert(sizeof(*a) =3D=3D
> > +                     sizeof(struct {
> > +                                    unsigned int iout0_val;
> > +                                    unsigned int iout1_val;
> > +                                    unsigned int burnout;
> > +                                    unsigned int pga;
> > +                                    unsigned int fs;
> > +                                    u32 ref_sel;
> > +                                    enum ad4130_filter_mode filter_mod=
e;
> > +                                    bool ref_bufp;
> > +                                    bool ref_bufm;
> > +                            }));
>=20
> This can be moved out of the function, but in any case it should not
> affect code generation I believe.

It can, but I like having it near its usage.
=20
> > +       if (a->iout0_val !=3D b->iout0_val ||
> > +           a->iout1_val !=3D b->iout1_val ||
> > +           a->burnout !=3D b->burnout ||
> > +           a->pga !=3D b->pga ||
> > +           a->fs !=3D b->fs ||
> > +           a->ref_sel !=3D b->ref_sel ||
> > +           a->filter_mode !=3D b->filter_mode ||
> > +           a->ref_bufp !=3D b->ref_bufp ||
> > +           a->ref_bufm !=3D b->ref_bufm)
> > +               return false;
> > +
> > +       return true;
> > +}
>=20
> ...
>=20
> >                 struct ad4130_slot_info *slot_info =3D &st->slots_info[=
i];
> >
> >                 /* Immediately accept a matching setup info. */
> > -               if (!memcmp(target_setup_info, &slot_info->setup,
> > -                           sizeof(*target_setup_info))) {
> > +               if (ad4130_setup_info_eq(target_setup_info, &slot_info-=
>setup)) {
>=20
> I don't remember if we discussed the idea of using crc32 to compare
> the data structures, like it's done for PLD data in USB Type-C cases.
> https://elixir.bootlin.com/linux/v6.14-rc3/C/ident/pld_crc

crc32 works on the binary representation again, right? That's what this
patch targets to remove.

Best regards
Uwe

--agroq5nuknnye377
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme1/pcACgkQj4D7WH0S
/k6hoQf+LzIltl6w+gHyQ04BbMe5z/LvKie9V0TS0Bw+T49OlzHW5RtzjcBIyZoI
ctI6D5FInLQAK2srYFjg676P4iIYv83sRK1UbyISlwMBGxi5QbCZgVhMNtC5tIJ/
I4HFL/IVu0Q25bFn/IwzS/A35zIFdmUWg/i/echeA3w69h8mXLUzDj84IkZxAfrO
Dd1D2p4hVNGvlBNCLWT636411dDbApPE1GumrguP614wGhGJPUA9cxrHMhzxWU5W
Md72k39OblHkcSAJNPOx0Gi+knmUACu1WJh2s2yOjCkFTDhNQggLWUMXRlIOGggV
Qwgk19Eyy7bd8cCjM1Fc6N73UQE86A==
=2cd3
-----END PGP SIGNATURE-----

--agroq5nuknnye377--

