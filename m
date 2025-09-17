Return-Path: <linux-iio+bounces-24209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B8B7E80D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18A8467ED2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44353323408;
	Wed, 17 Sep 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xl0pRa4B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20823309DDD
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113251; cv=none; b=ZwloJQjG200J/RUYedULhzZr1Qzul0X1G9Vvf0vw/2B2dK0+Ggcw/sJDW6W2jQKfMi/PEbl/F6nrB946D/KbAUBd6H5PvcbSTJDrDws45gAoRPfWX+OAKFUp+4yweTZSah4sttWX8OoGjQQlWp/VR4z1MRUZhxy1ZI7ySGSpmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113251; c=relaxed/simple;
	bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K28jvXqpd5R58ugRQcv+MNhZdWraaT1ZgVUf45ES5tYnstzyhg0M13wowPvkxdOFHGaHi/QSv3mAI4LZJt0ouLDU/fsBHiFuYWY1P9yx0XBa+7m2n9c1O2NUz7oDA8093szTxR796spNZ07/Iwa9sww3L4Ghv3DfLOpDH1BQlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xl0pRa4B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c28f390eso908770566b.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758113246; x=1758718046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=xl0pRa4BIirS0C0dFTJ/dW+xk8U5t6HlNa1G/ySOuv+k0h/p7O4dLGjFTF/MGExHAW
         TPzml1vDfNLBlCqwa/UBJwzmgP2Sdy83nOUA8zBHQtqIazy0D2PaM2A3RPhLlXcr/BKr
         DG2HJ6bFsq2b6395UWCEjRYKyqmw0xFNcBzKYnfxRYQbd0uyglQZ98AtCHVCL1qQm3gz
         tiTvJPReFqvyGJKGAOmnPEd4bnpdA+9+pFXcclg3XCyYKXe+SiAH4Jnl5J28WPE5DEUs
         n0IPqIvc4z9rDp835TH3OafrV66TqAtQBZeChXtqORbqLLoDXt4HWcy1vXkfPF6NX6fh
         lpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113246; x=1758718046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=f+abHTWx8c6hlruBqP4TjQxV3dV3/gVxft+bSiDMLbNyqTHgzqz4N4tHt1S2GYIfiH
         1cZvWQVLBT9z6RNvNpNq7lPtb+hySqvzzTeoD1w7BsTc6f6fyKo3aeypYgokaqtXJ8r5
         orelAapSQ4E8KHRITd1Oo/l9RYsD6o2gxRevYimNaCMAd3KndUsI+cZ5PwLbJ0Ba8v1y
         tTd33WzvfzkXb81ttXXKASIOtgTO2QYQb8sJaRh4FmkRiOme6zaQ7ytCvrVimBigPkfV
         LiZe3v4FQb48J4biGraKRaC6zFdjR85cA6K1ZjQKhXPkFo0mHoDyS7P5FoAxdkVCfcSS
         mEDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+7NFAOQu834N2ygEBjw8tevoCbqK52PKsmB8tVq7sUpgcKBQODqnKBeabPkGatiLht0MWGJ3AVAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ+8K+FHq54MEWqVbIbgSlKgAm96KQb/z+eRjTxSdvQYm6Br4
	XnPisBZh6Kap90lZdOjCl+oOCKQtmJmnCwI/cOfNZmW+K33mlp9qOgMJm9/XoD/i5V8=
X-Gm-Gg: ASbGncudoc0DuibznFcJ3GqjlY0sx3tCfWMR0aIRDUapijtJXk+aZRL9MpTgw9hgDlX
	xCjGOGKgpGQU2y36d110fINv4OrU1iM36oWxt8zlR+9TNLtUxyzZH5ENxZuMhp/BZ0cXFcpBcHV
	sYllisglh4PVzEzcuvYa443Y04n8R+7fqpo6Os6goWqL5LjEAeFPu+xI9VTcIzMxWNqA5m8aiL2
	7tG4DcV9Cj4DqyW369XyG8CPXJa2C9s+ZsT+AwjmYqSn5kQ9Tbs1u/kGoM0ZJZ0+JO3/hGWpgXb
	YhFfH10Qa7fzuiPEg/SKdVHEMyTi/llOj/imZrzyP2uDlMxX6Gqarh/47p4sxGWQ1J7Jc4TZoVK
	CM6qPWXt2GOAeOXNI3Mv3HL9LYc8=
X-Google-Smtp-Source: AGHT+IHgG+feaLFS5lYK61xigE0As4f8SIEZukBQyUiZyyvMqVLGwJC7y1Bl5VWs3fMe9SZIDZZJTw==
X-Received: by 2002:a17:906:f591:b0:b07:c905:af33 with SMTP id a640c23a62f3a-b1bc02f669dmr228527266b.65.1758113246285;
        Wed, 17 Sep 2025 05:47:26 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da289sm1339567666b.17.2025.09.17.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:47:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:47:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ah6qgcyytq6i6rrs"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>


--ah6qgcyytq6i6rrs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hello Andy,

On Tue, Sep 16, 2025 at 07:20:20PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 6:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regn=
o wrote:
>=20
> ...
>=20
> > > > > +MODULE_IMPORT_NS("SPMI");
> > > >
> > > > If it's exactly the files that #include <linux/spmi.h> should have =
that
> > > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> > >
> > > Which makes anyone to import namespace even if they just want to use =
some types
> > > out of the header.
> >
> > Notice that I carefully formulated my suggestion to cope for this case.
>=20
> And I carefully answered.

I tend to disagree. If that anyone only wants some type from the header
but not the namespace, the if part of my statement isn't given any more.
Still your reply felt like objection while logically it's not.

> Your proposal won't prevent _other_ files to
> use the same header in the future without needing a namespace to be
> imported.

Oh yes. But that's true for every change: If you change it further you
have to cope for what is already there.

> > > This is not good solution generally speaking. Also this will
> > > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e.=
 make it
> > > invisible that some of the code may become an abuser of the API just =
by someone
> > > include the header (for a reason or by a mistake).
> >
> > Yeah, opinions differ. In my eyes it's quite elegant.
>=20
> It's not a pure opinion,

That's your opinion :-)

> it has a technical background that I
> explained. The explicit usage of MODULE_IMPORT_NS() is better than
> some header somewhere that might even be included by another and be
> proxied to the code that doesn't need / want to have this namespace to
> be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
> for the future.

Well, for a deliberate abuser the hurdle to have to add the explicit
MODULE_IMPORT_NS() isn't that big. And a mistaken abuser won't explode,
just generate a few bytes overhead that can be fixed when noticed.

In my opinion that is an ok cost for the added elegance.

Best regards
Uwe

--ah6qgcyytq6i6rrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjKrdcACgkQj4D7WH0S
/k5EEgf8CdFx6+6iEV1AE4GeSJAKaBL6T9A2o7N08nLq8lg9b0873yxBoHXcU5fC
aJjF55sEwR98xGntE7kk39pH49RCG8ugwvBfJUnq75LJiKU4gyhg9P3OPFnLShiJ
I6m5bqGNDlAwq3dSuYSiDSr/4wi/Rq4mPKqRZoCT0WHQz9CWes6CdQPuRMSKYeJF
5VvswQqZGx5s73s0oi9UinWZ1/t/tX8KTjVeEgkmosNDtXb8rSwQbmfIUqnuCv0m
ZjvuFwKtei8Q90Ro1LSW+QP0R1bN1ydWluw6cGH65qE7Yqpb/P49Yupan3C0YEsr
nJJjRh4HIIADYdzeEZWvvrOcN8LC8Q==
=NvWc
-----END PGP SIGNATURE-----

--ah6qgcyytq6i6rrs--

