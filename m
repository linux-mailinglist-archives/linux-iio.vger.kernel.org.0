Return-Path: <linux-iio+bounces-6271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3B6908E6B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CEA1F268A9
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6419D09C;
	Fri, 14 Jun 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPG2F2Yz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11D19DF5A;
	Fri, 14 Jun 2024 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377904; cv=none; b=P2gVxzrNZUmlAdccHEAgQGJxLO50tw9SU6XxvUUH8DlkGaImN3Pixg6v2p0BClf+DJ609Wq3/roYK0MgLoKklGF6RGzsSmt5SK5ggKz7hu1FokNaUuZ61ZeHbMGoak1AkBHFQP7u1hsZB7AklgAg9T/fIRMjIL6+axt1dPS1t+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377904; c=relaxed/simple;
	bh=cOE6iJFNODxlrDuTajtcvekCrcSNPS4TIQxNEGP3w5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2Z3U9GeSAhTz57VnMDoJ3TsB7GqAgH12Y0avfH6kd6tRmDTYcg1ID1iVv7ASo7uojU4feLGBK8F0GdmZSRXgkvI0YtMgd2+t2Y+VkxT480kQl6bg47ULL5SEYTBJSwO6wZP2+XaOQ9Pbu4+Tfhp1TaDGiTP7G1Z6mDSwSlRx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPG2F2Yz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso362597466b.0;
        Fri, 14 Jun 2024 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718377901; x=1718982701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2HQjdKFTtW1WwBgQqCoYjxg2qXySchNnEfQLfA+vDbQ=;
        b=RPG2F2YzqXrlvjl5EFft6Isejjb1W28BZrwj3ozobI+sPq0yAWbexrPp1n+L7wmUcS
         0qPJTPi6qi+BBM2zXLa6o8Zhnig6Sk2rdPeRi3XFVuzsA0hwt5Swff8TPnNo8p9U2kRf
         u3KBa802+oqQHCSlZTPCMlc+jeTb7llqXg/fgpFeDOE5dWb08UIS2+tUnaWip6nO2rpJ
         oRHHSamQtnphcDPkUOJ8itePnqKS7ZTAAXHudg4jTeDopUsMoMUVNRcL+6XxPDFG3Vet
         5IFz3GpNmPCT5cgT3OHo46LcATIQKSeIrUB3dKHfN0F9CUQZDAn4PBbqQXikBDDm9ll6
         PAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377901; x=1718982701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HQjdKFTtW1WwBgQqCoYjxg2qXySchNnEfQLfA+vDbQ=;
        b=NioarJbrK+5496ck4yyke6gMCFhbjy4cbk/c2h9z8Gy4U5OHKtgQ6t6DxBh8waV/qu
         TygLyYh1zZQyETR7xv3n5imWlOGwK2uZZJ8a9iBjvhU6GoBp4hnvCti5IfSLoQtiBrIH
         xQD4vI3F123W0b/kUZAPSEo/BJpFoLsEMLcYad4WzP0UFdL35z2Fti7th0HFJfU7LN4E
         9IH9N99wzq7Jxbn6mxop+okNHrl0u9Gs3cS2FfVPd+/j0JDRpAuVorAg/RXIUJwRpEjL
         jtSVXjW/8LDI4K9wkowJLzf8502kzM7ox4hie/YEJpkTZ50dSvqI5Dejyk65s76OLk5e
         Uw+g==
X-Forwarded-Encrypted: i=1; AJvYcCXdOixnjCtoqpIH73JWgar++zeeHNENAjMF2olZyu5+YZRAfNx9K1JsC5QIpp8OW1Yu7Xw7rdBzKf3aNJyWLFQZXpKrbRxePPKsFnDsmNoSA1RmaOGmoqz9l0f3fpHgc1t0P9bCLsTM
X-Gm-Message-State: AOJu0YxupvnFzBxEDuBFwCFRtcwJdnIcDzodSHLBHMSt+AY2NxXFA8EN
	89TmRrmcm9tqlYr6R88mutSghsXwhhr+ypG+uOprwQ8vQSx4uu//w2+TZiam
X-Google-Smtp-Source: AGHT+IGBkOT/ikMPTQJC3USZwyAqjz1QBjYY0kimH6HOS2m6u9y3q1OFEdL5/Dc40iqBgNAC2x357g==
X-Received: by 2002:a17:907:b9d5:b0:a68:b159:11ee with SMTP id a640c23a62f3a-a6f52403808mr404472266b.12.1718377901194;
        Fri, 14 Jun 2024 08:11:41 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecb2c9sm193919166b.114.2024.06.14.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:11:40 -0700 (PDT)
Message-ID: <f45d0cba3e3fc087d0a3b8c5af5401a5c38ec162.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: adc: ad7292: use
 devm_regulator_get_enable_read_voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 17:11:39 +0200
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
References: 
	<20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	 <20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
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
> v2 changes:
> * avoid else in return value check
> * use macro instead of comment to document internal reference voltage
> ---
> =C2=A0drivers/iio/adc/ad7292.c | 36 ++++++------------------------------
> =C2=A01 file changed, 6 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> index 6aadd14f459d..87ffe66058a1 100644
> --- a/drivers/iio/adc/ad7292.c
> +++ b/drivers/iio/adc/ad7292.c
> @@ -17,6 +17,8 @@
> =C2=A0
> =C2=A0#define ADI_VENDOR_ID 0x0018
> =C2=A0
> +#define AD7292_INTERNAL_REF_MV 1250
> +
> =C2=A0/* AD7292 registers definition */
> =C2=A0#define AD7292_REG_VENDOR_ID		0x00
> =C2=A0#define AD7292_REG_CONF_BANK		0x05
> @@ -79,7 +81,6 @@ static const struct iio_chan_spec ad7292_channels_diff[=
] =3D {
> =C2=A0
> =C2=A0struct ad7292_state {
> =C2=A0	struct spi_device *spi;
> -	struct regulator *reg;
> =C2=A0	unsigned short vref_mv;
> =C2=A0
> =C2=A0	__be16 d16 __aligned(IIO_DMA_MINALIGN);
> @@ -250,13 +251,6 @@ static const struct iio_info ad7292_info =3D {
> =C2=A0	.read_raw =3D ad7292_read_raw,
> =C2=A0};
> =C2=A0
> -static void ad7292_regulator_disable(void *data)
> -{
> -	struct ad7292_state *st =3D data;
> -
> -	regulator_disable(st->reg);
> -}
> -
> =C2=A0static int ad7292_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct ad7292_state *st;
> @@ -277,29 +271,11 @@ static int ad7292_probe(struct spi_device *spi)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	st->reg =3D devm_regulator_get_optional(&spi->dev, "vref");
> -	if (!IS_ERR(st->reg)) {
> -		ret =3D regulator_enable(st->reg);
> -		if (ret) {
> -			dev_err(&spi->dev,
> -				"Failed to enable external vref supply\n");
> -			return ret;
> -		}
> -
> -		ret =3D devm_add_action_or_reset(&spi->dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7292_regulator_disable, st);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D regulator_get_voltage(st->reg);
> -		if (ret < 0)
> -			return ret;
> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret < 0 && ret =3D=3D -ENODEV)

ret !=3D -ENODEV?

- Nuno S=C3=A1


