Return-Path: <linux-iio+bounces-6273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9C908E83
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214231C2271E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D3181CEA;
	Fri, 14 Jun 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMVpz6ze"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854915FCF5;
	Fri, 14 Jun 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378219; cv=none; b=TjoBqzjzHSZO2tAueHwgEPRRmbQm+0oNtHA/QON1lJEaL5nuh3xIEAnCgheIr5DNerc5OD9+hM9+EBkCDQ6bJUkH+D4VBsUdT3a8jkZAsbYCgWMUt4jqZuG4XzyUpeM65y9ioEnyXmlAUeqi2Ic3uMR3M8ZtpYJ548umZJ8iN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378219; c=relaxed/simple;
	bh=wfF3eyJb5WVxp0pdUbvydfRYm3OMUH23BOWLH9SrP20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfoybNDjjXtLnxg/lYEhSE9GKL5Gp6q93h6r4/a6byoCrqpv/p0HfNGiZLnxxt5EFEd9ds0FovmZIgv8B8slZWMfyQYLHmeHGJEG48rjPj9HKa70g5z6M2XS+KFscKUt3p00LCz/ipT/QTjXleDQU9LBe1m4aQebBeOKJdXmLwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMVpz6ze; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6267778b3aso239217966b.3;
        Fri, 14 Jun 2024 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718378216; x=1718983016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C7S7pt9HLWWUbZf3EN93FAMsSGCaHaMxwShIY3NqFV8=;
        b=bMVpz6ze4dDnoujeqBpPRCTZhcXY6/+cVKaB6U6ZfC271YUuNlGwHf/K+pER0iooSE
         IqfkxVMYz1vGFuKO++ohdAxb0mVU//e1HpmLNxSkGWt3AxdfLUvKZze2Iehqiv7qBbeW
         7j3gPGdRQOQekNWn3WH7Ux+ZZe9Ax1jzcJ3z1HnivQboVPfQ3UgjObtguXC5ExtWRbgl
         lJRKjaeuFsbeyxzoz0LpmsI3RaDvCgH8FrL6u1qXhncKcusFg+1Cc6K/qbjo3DopXA0N
         KIMCigHlKGIXCcAYP9phxbn9gcuA6TapswoGvdnAmKfL57m0nZTNrLBza88F/tHqE6qU
         iKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378216; x=1718983016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7S7pt9HLWWUbZf3EN93FAMsSGCaHaMxwShIY3NqFV8=;
        b=Tbyl7LE15NyI8Qyl2f2lx7AH4f7WF1mj0GK9KiJ8+w7AcQwEM8tfi8KGRSNN6RJOXn
         vQfE2PstTW2+kgKKJU0dCeAl3hEPpSCyKdpsGNHuoATEqXx6hWXDH+fgG4Oc1SbVycrL
         l3C3a2TEWlXngrodMXXR9I8FXN6objFJUmsLLo2YXVMCGeJrxu0X4CgW0ghvnG2N5lZW
         TweRMAc1x5g5Nano/fnXYAz2exwz0V7g1nKy+Lj90XGk4LfHCx7UXVH2oKtzuWRC7vrE
         N6I2FQpeV2G1IWdx+PR0sT9W1W6XqGZEt0MDefRzFvDrookdIdmhQzef1Y+5qZQ0VfW/
         i/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVXUbGnB0KJyAZm1psudey5xv44FmY8pnGts/H5kR9w93lwo+b7HVX0TTT2oXPUVAFnHjYX3kpjyM2IfwwygZrBPWpW6V3qpbdzXj7ZcD/643lNXiWs0KayKeXSF7G/gbwa92lPxl68
X-Gm-Message-State: AOJu0YxbNYbqG3ITNwvQ1hmC5ncBfvngefV5JYzBY1U5Y2bJ7cWUl0R9
	/Nr/rTAslN6HxofJ288n7+glSrJ76YNRsg9+Tyi3SQAmo+KzAYIJ
X-Google-Smtp-Source: AGHT+IGTtChzPwQH9JRX8tAUlDyLltu2dFUtHVDHqw/X3rkDaMWDF0d5Ea96XyV4HmSs2CNLZzLStg==
X-Received: by 2002:a17:906:528a:b0:a6f:4c39:8aea with SMTP id a640c23a62f3a-a6f60ced3efmr197255966b.15.1718378215493;
        Fri, 14 Jun 2024 08:16:55 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6182sm194949566b.51.2024.06.14.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:16:55 -0700 (PDT)
Message-ID: <6f607e60a781f74b3cde2405c8c6659d0e304c96.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: adc: ad7944: use
 devm_regulator_get_enable_read_voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 17:16:54 +0200
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-5-fa622e7354e9@baylibre.com>
References: 
	<20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	 <20240612-iio-adc-ref-supply-refactor-v2-5-fa622e7354e9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote:
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
> - don't read voltage from refin regulator
> - avoid else in return value checks
> ---
> =C2=A0drivers/iio/adc/ad7944.c | 54 +++++++++++--------------------------=
-----------
> =C2=A01 file changed, 12 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index e2cb64cef476..f8bf03feba07 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -464,23 +464,17 @@ static const char * const ad7944_power_supplies[] =
=3D {
> =C2=A0	"avdd",	"dvdd",	"bvdd", "vio"
> =C2=A0};
> =C2=A0
> -static void ad7944_ref_disable(void *ref)
> -{
> -	regulator_disable(ref);
> -}
> -
> =C2=A0static int ad7944_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	const struct ad7944_chip_info *chip_info;
> =C2=A0	struct device *dev =3D &spi->dev;
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct ad7944_adc *adc;
> -	bool have_refin =3D false;
> -	struct regulator *ref;
> +	bool have_refin;
> =C2=A0	struct iio_chan_spec *chain_chan;
> =C2=A0	unsigned long *chain_scan_masks;
> =C2=A0	u32 n_chain_dev;
> -	int ret;
> +	int ret, ref_mv;
> =C2=A0
> =C2=A0	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> =C2=A0	if (!indio_dev)
> @@ -531,47 +525,23 @@ static int ad7944_probe(struct spi_device *spi)
> =C2=A0	 * - external reference: REF is connected, REFIN is not connected
> =C2=A0	 */
> =C2=A0
> -	ref =3D devm_regulator_get_optional(dev, "ref");
> -	if (IS_ERR(ref)) {
> -		if (PTR_ERR(ref) !=3D -ENODEV)
> -			return dev_err_probe(dev, PTR_ERR(ref),
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get REF supply\n");
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> =C2=A0
> -		ref =3D NULL;
> -	}
> +	ref_mv =3D ret =3D=3D -ENODEV ? 0 : ret / 1000;
> =C2=A0
> =C2=A0	ret =3D devm_regulator_get_enable_optional(dev, "refin");
> -	if (ret =3D=3D 0)
> -		have_refin =3D true;
> -	else if (ret !=3D -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable REFIN supply\n");
> +	if (ret < 0 && ret =3D=3D -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
> +

ret !=3D -ENODEV right?

- Nuno S=C3=A1



