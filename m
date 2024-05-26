Return-Path: <linux-iio+bounces-5314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D848CF454
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07E1281605
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108BDF71;
	Sun, 26 May 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AalhAbx2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E6DF60;
	Sun, 26 May 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716727790; cv=none; b=DethIk9Bm4h7Hu6Xffv5j7jicpCBM099BiTnt5gsOeMsjNn+kZYOjbDEOMBkAZDjO98rO5LM9sNnzfO9PTPOprwib/e3qvONqpQuTOxx7yR9PKvl9gdEvho0ciygsVdZrQrxklQ+bs+EHXzurX3CSH1jLZ0uUCXS+/WNFkniFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716727790; c=relaxed/simple;
	bh=mRfq0TFYrIwU/YNjg/1gxs3DAKBxoubVD2/h3CYP9is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUrq89NdE6DbcavMWaS7go7wyS3llhDYdeAutXaE0YCSbOyCinVKCikJYRY+UTsvYwbm+eGO+rSaDZ3WV+0y+GSpadI+QWlkO2YhkkBhCIEoKa/5gNjSV4fZdSxNgwG/xo42+BGiYHd3b5eleJRcKYb75qFjbpX9Fz0WehPZk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AalhAbx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AC7C2BD10;
	Sun, 26 May 2024 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716727789;
	bh=mRfq0TFYrIwU/YNjg/1gxs3DAKBxoubVD2/h3CYP9is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AalhAbx2ZcTiAzrA5IXdrKWE1cxH5oMw53Axo95u5hSQn0PuLWR24BSeAzjVeuAZe
	 5NsDqbglZYFjQtvG04xa6W4pe6yGp5lS8rEauGnlXSh8uiXvQANOolPbdBErtTTBxn
	 /JFJ5cUIbB7ZVrMw8FzWHmuNyvVkKLyonoGP/gmpL8x9DOpegAyccQ9WtTOPTiYXpj
	 uO0/0dWe0vKcrzfWF14iVbH1x//5BEWt6VKMVAj4TsChujxzlMaWSc0dcEl1VPxtMy
	 IBznp/UOefU9buH+udd+aeprbOmcAF1i+PnWbHuHc9LRx3RlH4aqMYJMuBStsizfuK
	 vgCLPR5v9n8Vw==
Date: Sun, 26 May 2024 13:48:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v4 10/10] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240526134858.636d2c8f@jic23-huawei>
In-Reply-To: <bdc88590fe3e54326c1edbe6f2b4ac2d8f453df4.camel@gmail.com>
References: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
	<bdc88590fe3e54326c1edbe6f2b4ac2d8f453df4.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > @@ -1500,7 +1973,10 @@ static int adis16475_probe(struct spi_device *sp=
i)
> > =C2=A0	indio_dev->name =3D st->info->name;
> > =C2=A0	indio_dev->channels =3D st->info->channels;
> > =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> > -	indio_dev->info =3D &adis16475_info;
> > +	if (st->adis.data->has_fifo)
> > +		indio_dev->info =3D &adis16575_info;
> > +	else
> > +		indio_dev->info =3D &adis16475_info;
> > =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >=20
> > =C2=A0	ret =3D __adis_initial_startup(&st->adis);
> > @@ -1515,10 +1991,25 @@ static int adis16475_probe(struct spi_device *s=
pi)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> >=20
> > -	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> > -						 adis16475_trigger_handler);
> > -	if (ret)
> > -		return ret;
> > +	if (st->adis.data->has_fifo) {
> > +		ret =3D devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis,
> > indio_dev,
> > +								=C2=A0=C2=A0=C2=A0
> > adis16475_trigger_handler_with_fifo,
> > +								=C2=A0=C2=A0=C2=A0
> > &adis16475_buffer_ops,
> > +								=C2=A0=C2=A0=C2=A0
> > adis16475_fifo_attributes);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Update overflow behavior to always overwrite the oldest sample.
> > */
> > +		ret =3D adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16575_OVERFLOW_MASK,
> > (u16)ADIS16575_OVERWRITE_OLDEST); =20
>=20
> Slight preference for local variable to avoid the cast.

Hmm. This is a symptom of adis_update_bits() being 'too clever'.
I'd be tempted to just split that into 16 bit and 32 bit versions but
that is a much larger patch so a local variable is ok if ugly.


>=20
> - Nuno S=C3=A1
>=20
>=20


