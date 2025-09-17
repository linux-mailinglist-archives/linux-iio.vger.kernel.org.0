Return-Path: <linux-iio+bounces-24217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66644B80577
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB11A16414F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E304335937;
	Wed, 17 Sep 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rcgaLz0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EF333AB7
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121078; cv=none; b=qO2pI+PcPLVVHqb16R6nVYzlam5cUchs3RWRf/XYLANDcELnZwRdnIOcE9E3oefoHR7coL3uTi8t54zJQnqJbvG4KltCUXCPNtq+r+kUXCL9gQjY0ArP5NBYMWPpqdNRCgQou6R2TIAHcHw/3BiUATH2xrofc/wMLUD8Pip/y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121078; c=relaxed/simple;
	bh=0lm6it3QlZzl73ho+O20bHsFQIQ20Ploay6fb04E/yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwXYzW+IPrOxefRx+ELS7iVh4hhw9siyqYnmDRXjHa6pwgsjBBGXc18ofOyAPyi9RrBPi3JTcpVEWyuoTOdzHHiqCfGPvOFkqeg8IjEF2zcXHtse8rIxpGcRsc19hu7mAapBslQj2NMmRpRt0clnPhbopB+lK+XjFyuIStBoLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rcgaLz0B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so9804765e9.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758121074; x=1758725874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNJiPyXScWAskCoPGIAYsTwf0lJxfeavCsADGNiPscs=;
        b=rcgaLz0BHQKyc7WirFsDkS0I9eFiWcE8R3p9tGxUZssQa23U++uWvHGBwe+9aK1Gd+
         KbjTzolnBBfjOmknuthuVHMKhAoQr9blURtBJGfXrxeVx3qfRSCQqUVTyZ0n8yGeWnmo
         BNNMd/bg06wV8GQO7lgfHo4qIEgy5MjHWO+3fLtpbcFKGxO+LfMQ6RSY0AtXod85IIhY
         NhgZdbd7v2PJZSyQFFE4SlJyB4xtaHRAKi7YyTlNT3JifO9V9uIuOgGX3pDhyWNTz7xz
         NAAUrOHghLsRT5yDbw13IL+A4pFunU9hvpWX+ANE395o4Ak5ugY4ciw1b8iigs5K0dKV
         H1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121074; x=1758725874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNJiPyXScWAskCoPGIAYsTwf0lJxfeavCsADGNiPscs=;
        b=oA/ACJearQDHqJ/ybZBQ0Aovc2u1k4jdng4NH9IN99HusNELAMC2OXz2FMULnb9owY
         egasVm7PtE09Tgz4hDKV3bUwVgwtFoetf/WdxktzL92yKjVoynBXVVgtuUGw+6Aed0yS
         3u9vd4JWukXXpc6P1pTqeoD879Euq/Npwe8BNw4BCuvG0uJ7Yr2yYxSECDubmH33F5VJ
         mj1J0Ve4J+XOsoxAObNCEr5JgQiyRDsqUg5/avGX+WVYgcICdDT8o4ZEJ1P7DwTX09dV
         wIjG2yqG8jNRPXjv1S+4BYNzrPn7qf6IaApancamKZo6qdThtItocVb2f3ndbdxSnO/E
         l0GA==
X-Forwarded-Encrypted: i=1; AJvYcCX/uyizlWSSabLIEd9CiBI1KE8AxZkm/taaYKIDMFbV4+BUeqxUr/uY2fvPOM43aARiq+NxGtjOA20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvkY7XZtWFGc57PrNZPfJ+756qvZwDDRthEdAtFRue0C/+lBYL
	F+RV8xWkJLpDWQ9SN89YWEUyMYCZgy68J3lCNKkaXblkBmmBnWTQ+ftoRx/s9ebR9Rs=
X-Gm-Gg: ASbGncv1yJb1rD37zgCVpxuEH/nhKBjNOToyz8DNMQZyJezKaqFX2NCqhfXLT5y7Ymu
	RYLFZ1b/ZjbtcmXrSQXha9o1HyrQDVGNoQ6HrRpRGlN79WUJN7A9MW1mKGm3m1kB08uxH4fQS5p
	nfOdico1QklP79dqrUaOGZdygA6qaiNxFKift2MsjxjU/DiWyTKzewWVxroniyP17CPbWeRzIBX
	X9kZhP9Z27raY5i7PxifEeS7KBfZmhMIpCP4FpNafMfDLDLpd9yopIRyktbP9E41B763YPyGDNw
	X2J3rYNLEozNM87s2e9jweG+VC23r7O8MXprgg4q54oTfoBOtP+/CosUPoioEb444d2nzUZ0TpN
	Qyf3+3GlwBrFoDT/LoVd7JVr7yA9173GwHw1ncq9t8y+iNrgzU+TEYqoJsf01ebnQ
X-Google-Smtp-Source: AGHT+IHaJ8RLGRWJjGkWj3mOlv4MrMyQtredyYklN46lH/3oMjKK5GoSCinEm44gnypkzxXye6/JJg==
X-Received: by 2002:a05:600c:608b:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-45f32d002bamr73775275e9.1.1758121074054;
        Wed, 17 Sep 2025 07:57:54 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46137930274sm39496035e9.6.2025.09.17.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:57:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:57:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <hsemgg5s3nptxeh3jyim6ahgb37yb3h3hcbdtwixiisyf7ehqk@r7zlg23yz5cv>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
 <mr7gqhvom5soofn2oujzxtsuczsnx2yizkushar64cojwnvhd6@dt64ojgjqdxw>
 <a16cafd4-4d6c-45be-b241-45d2d6479bb1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vd4q4xt757pbxzqi"
Content-Disposition: inline
In-Reply-To: <a16cafd4-4d6c-45be-b241-45d2d6479bb1@collabora.com>


--vd4q4xt757pbxzqi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
MIME-Version: 1.0

Hello AngeloGioacchino,

On Wed, Sep 17, 2025 at 01:41:40PM +0200, AngeloGioacchino Del Regno wrote:
> Il 16/09/25 15:25, Uwe Kleine-K=F6nig ha scritto:
> > Hello AngeloGioacchino,
> >=20
> > On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > +/**
> > > + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-d=
evice
> > > + * @sparent:	SPMI parent device with previously registered SPMI cont=
roller
> > > + *
> > > + * Returns:
> > > + * Pointer to newly allocated SPMI sub-device for success or negativ=
e ERR_PTR.
> > > + */
> > > +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_devi=
ce *sparent)
> > > +{
> > > +	struct spmi_subdevice *sub_sdev;
> > > +	struct spmi_device *sdev;
> > > +	int ret;
> > > +
> > > +	sub_sdev =3D kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> > > +	if (!sub_sdev)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	ret =3D ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> > > +	if (ret < 0) {
> > > +		kfree(sub_sdev);
> > > +		return ERR_PTR(ret);
> > > +	}
> > > +
> > > +	sdev =3D &sub_sdev->sdev;
> > > +	sdev->ctrl =3D sparent->ctrl;
> > > +	device_initialize(&sdev->dev);
> > > +	sdev->dev.parent =3D &sparent->dev;
> > > +	sdev->dev.bus =3D &spmi_bus_type;
> > > +	sdev->dev.type =3D &spmi_subdev_type;
> > > +
> > > +	sub_sdev->devid =3D ret;
> > > +	sdev->usid =3D sparent->usid;
> > > +
> > > +	ret =3D dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> > > +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> >=20
> > If I understand correctly sub_sdev->devid is globally unique. I wonder
> > if a namespace that is specific to the parent spmi device would be more
> > sensible?!
>=20
> Only in the context of the children of sdev. I'm not sure of what you're =
proposing
> here, looks like it would complicate the code for no big reason - unless =
I am
> misunderstanding something here.

The thing that I wondered about is: Why use sdev->usid if
sub_sdev->devid is already a unique description of the subdevice? And
for other device types (platform devices, mfd) the device identifiers
are not globally unique. So I just wondered why spmi is different here.

> > > +	if (ret)
> > > +		goto err_put_dev;
> > > +
> > > +	ret =3D device_add(&sdev->dev);
> > > +	if (ret) {
> > > +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
> >=20
> > I'd use %pe instead of %d here.
> >=20
>=20
> The only reason why I am using %d is for consistency with the rest of the=
 code that
> is in SPMI - there is another device_add() call in spmi_device_add() whic=
h prints
> the same error in the very same way as I'm doing here.
>=20
> I agree that using %pe makes error prints more readable, but perhaps that=
 should be
> done as a later cleanup to keep prints consistent (and perhaps that shoul=
d not be
> done only in SPMI anyway).
>=20
> If you have really strong opinions about doing that right now I can do it=
, but I
> anyway prefer seeing that as a later commit doing that in the entire SPMI=
 codebase.

My approach would be to first convert the driver to use %pe and then
add the new code. But I don't feel strong.

Best regards
Uwe

--vd4q4xt757pbxzqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjKzG0ACgkQj4D7WH0S
/k6QAwgAjFK8Yjwpa5jj8yoQmTljLuhXr3CuLMG/fOZmijXiT4J5ufD4aliJbr4c
zkNE7I3gWE8MV1guDtw7WULdaj7y1RnKRvOVADynBNQpXb6TuHwp8Gwf9IEZNbtJ
Vi+wPP46epW94GY1SGjJHd6SJzg3ZqIO5LAAuEQwlXcrm4Y513Kv9pflqChHkr2D
rNpkyVdzDbrIjBpnmqbpYsi/bMShr0GL0/PIzE0wd/0cFYjLRc+PsjvTtXmnJ6SW
NC4IDWqztRVrsKZJNYc4mI8oD/ysZDjKGs62xmrcNrJxnYuZO0bzIZXGctuailWF
faHHEN/aOhC5FVoar9BuOkvPukStTQ==
=HAfP
-----END PGP SIGNATURE-----

--vd4q4xt757pbxzqi--

