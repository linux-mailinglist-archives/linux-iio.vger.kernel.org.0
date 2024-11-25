Return-Path: <linux-iio+bounces-12645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FA9D8881
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CF716744F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B001B218B;
	Mon, 25 Nov 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EgbsIIUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B31B0F30
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546333; cv=none; b=D4IZ0BplMVi33MBJHSelVvU62znxGWtlpQ491WxsWFq98iWnehlK6ROCnuB82q9FTBiPspsdHQQ0+ZU3Z7BSyn0VkJJfrSx4gaeei9xcNKfhYrbZRN2lrD+b+c4R1+bfiMDZbe/b3mulLsJfh/5VgUOa87TOaJ3iHwFnObxJhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546333; c=relaxed/simple;
	bh=mcaXyxMdWZLn3MXtKNNPp4INKgCVqab5N062XJCig+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgCBg0WxwZWgD7iMjJwVxuOMdacFr5EN0wzzqwMRoU4JFReM9oSuV0ekt4jBQsc5GkhdOtk3FmjlbIMzkBcb96mZg6ESibckfpflg/p0ksqUeMFqZXv11YhK13wJrF7oRQKqQaAJ4rnfrdaxCzAL9u6p+sYAfUfleshYSyEhKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EgbsIIUp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a45f05feso792395e9.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732546330; x=1733151130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zj0ySm1eVLom/XQBUYIyIHTjpZPsoK3zD44zXCBV3zk=;
        b=EgbsIIUpJ0MXeXVuWiABfmUcwtGNkma/tQZruP43PZ8L16rm9QrrEr7rSUcC2b6vAH
         mbKzMy4osO4Q7CD7OPwp4BD6GFs2I2LILujKidQ74voK4PTpypyAnRCa2BhRD/dFuqTo
         NXoEopwvYoxLwIo/9NcTz8Lhctc/YXKRoqJOFhZ1DWoKLbPEJhlTKsY/Qak/mNp1Afbk
         Z7S3NGyKdG2rOJQcsRoZAoyC7Be+hTD7u6Syphz5obgteY38wKdXG03UXAfHsKPJUgRN
         xx8hYZQEUZczqnIHNZbtkJRX89cGdKKUjqX30Dk1LUsGwdkYfa3RbTbH+Yn75bMiaRCF
         eTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546330; x=1733151130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj0ySm1eVLom/XQBUYIyIHTjpZPsoK3zD44zXCBV3zk=;
        b=uGlq8SOBEH7kM6Rw7I15+8pWu++09N9TBZ+aiaJ5EA4sJTTBSlIMLxySa+JM9mIw0v
         6dN9W/8AltcaaVJ+4XJJyt9S04VXHjkM2NYmbSaBnKcEGjkhBwc1QhY4oUXR/64R3SEQ
         N2NdCYdCzHET6Ovop3JUaa90GSxp9BfEhO3pu+ctmtPhWfVWaevQb6QJHrkSR/MEAsjY
         fU3Uw7emvEOwyJ95HYtJT/mAX7p4tXjZx6mBrGP9zBuFDivW1F10ABCeBFen0X7kaIMQ
         E8iZzTuu9JMyQPwAKa8PH4OnSBTC5ivPgFupxdZie+pcvx11eaUtoFmv5unot/4S5HG3
         cXxw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4U0rFz5u7WuX69ec/HRswmYG8rKBRvEtutoVfFz4eiz6eKNxm7puCwPEYfvdoEOaJfsPyklGTT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGRM/llBU5aUiBq2BiZz12whTXtbxNqE+k303tAj3g1XSZTjT
	OwldwYisBBciFBmEfU8j7pLfU3/OH+8Y7wUAB58ygJDSNnqJtQVs3Oaz4kCkjJs=
X-Gm-Gg: ASbGncuoqfTS1P9qP6bYlUffSgo5KVywBTSs8fR3EZvI4rqt+TQLzde47ixgpfVHJ7n
	gLdP7GQmkLxVa/Q9BJFXD800Gx0fMUWGk9oYGm8BwrdaPdghCUvG7/yVt1PqorvYs+B243t0fn1
	GY3BUsBrfYjEhuGRStA1i3u4GiyUv5m9iPLZqQowffljGyKflIb55TESGvLUF1+NJ0ZSlWtlDfc
	U46awNz2RkyYjWOUBHMQXrR1PgEyxikSTdAkqCngkwKHzgXFoj5WRWF+oU7MDoApQg970OG5Kx1
	mlOy
X-Google-Smtp-Source: AGHT+IFSUthIKS8ekfmSJA1KfGblZ57MugAXfoVqvzP0IxiMc+MhSwJOH6AB1E6cvI+PV+YXRsqYUg==
X-Received: by 2002:a05:600c:1d19:b0:431:b264:bad9 with SMTP id 5b1f17b1804b1-433ce420ae5mr140205095e9.14.1732546329928;
        Mon, 25 Nov 2024 06:52:09 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4288sm194703205e9.23.2024.11.25.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 06:52:09 -0800 (PST)
Date: Mon, 25 Nov 2024 15:52:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
Message-ID: <2tsxyxmfh3ozolsziu3bps7liagzl4gmvy4oykvyeapziagvy4@tfa2lcxmdsmf>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
 <CAHp75Ve_sD-a-m4pYmKrT=LhajO=F7TG7KM7AsM47J0=ksVgNw@mail.gmail.com>
 <eghe47rkwxmcfkamayemvwfksonrwbysaadakbdm4lvzcsy4ee@7gftiif7ka6i>
 <CAHp75Ve3hBhCMFkjA4-hiLfGQLeeGt_74e=PwTH_nF1NCYiyOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2um65a2ynonrj3ko"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve3hBhCMFkjA4-hiLfGQLeeGt_74e=PwTH_nF1NCYiyOA@mail.gmail.com>


--2um65a2ynonrj3ko
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature
 measurement
MIME-Version: 1.0

On Mon, Nov 25, 2024 at 03:47:25PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 25, 2024 at 1:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Fri, Nov 22, 2024 at 10:31:07PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > > +       /* Add one for temperature */
> > > > +       st->num_channels =3D min(num_channels + 1, AD7124_MAX_CHANN=
ELS);
> > >
> > > Is the type of both arguments the same?
> >
> > Hmm, my compiler is happy with it at least. I don't understand why
> > though. I'll do a few more tests ...
>=20
> If num_channels is signed int or shorter than (independently on the
> sign) int, then it's obvious why. + 1 makes it int.

Ah indeed, I should have understood that without that explanation.
Thanks!

Uwe

--2um65a2ynonrj3ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEjxUACgkQj4D7WH0S
/k6osAf/ci1W6Mpo35uI0PIBP0mTcGjj1mx3bdQKXn06SADIusdM/uWfhOqa4LoK
AR+eHureevn3btm5UYBrMGlofjy68IErMTOoPZkehmAyAnD0RQiHfuhCp92ahJsF
1B8msKQeFvRuzbkNtXt+Xs802BMgMdFuiXYAHvj8KSia9lZpqbgcsZcK0z9n7+In
dpha9HPxOl513Eo02hy8gAiJ8YFd5ijN4zALUwg/TiKG4oEWjBC2mA403CefRam2
v8lIx3rh7EDGMDYVG1sVuo8VtKJi8y2VH3e7YF4BNpd7DuTJiMawdNuz8NiO/V6p
kt6g89+aVrOKswY3/zdvF/Bd2bUCHg==
=F7pA
-----END PGP SIGNATURE-----

--2um65a2ynonrj3ko--

