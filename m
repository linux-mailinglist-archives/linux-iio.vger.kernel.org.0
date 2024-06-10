Return-Path: <linux-iio+bounces-6136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C27901BC5
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 09:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABBAB219E9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2E3611E;
	Mon, 10 Jun 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASlAvt3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C11E876;
	Mon, 10 Jun 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004005; cv=none; b=XqdtP/yuBPU7B6XPOeORrPtsxKjGuWOqGUfxEUFsMnTza8n9ZUV/VApM5l+aotN6jZ3kC6Y5/O9ZUXF7FmiQwwZPDOgdoRWs8viDAA1Qg1UoXeipJ475ZIz0sLHcwsERdwJcviPRbSIyCsND1JNsVF1ysuLo45tfaylV1mAraBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004005; c=relaxed/simple;
	bh=oAVCVXognril8jpexVwnonepoZrKBZQWMdcL/6NiZ0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stlHLTw3dXsWMcc3Qy5PSUgD1O86E3IsDdCdQnP0YdTsXGhXsc6SqGpJlZvAKX4Yy460q8yfiw8V+Pww+uxoRcFPMns76fIo6UMu0Gbt2CdI6f84KJStxNMD5whs5uEa6QDxQgM5yHOjLk1n4yzZofpHZt/sVFq+TyPBRHqFvQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASlAvt3B; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f1dc06298so68213266b.1;
        Mon, 10 Jun 2024 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718004002; x=1718608802; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fCsIgVGqp39qHChwBUvEw1r7syp/IBpICGYn5cHvzwQ=;
        b=ASlAvt3BcYQVKDeqhyKRQDDgVRLuYfS1s02WsYpxBnQKI5XPcgU1N4Zo4fm1Yxu36o
         J8AhvOkzPX7kHBSYHJUSyo3gGdTPgeqjvcSWYoxQdWq55XDD1ttsbyx0qXyDc/r1129E
         YVJTqDXO8lKJglx5QhWD4CpAWSKPSoQq/G2sFMBLhuxtnOH9vKiERjbfkkriBMcLb57j
         BlathpocZ0dkYy5oQJ+93j38/OrY+ZOoeMiYDooF73aSW3weTMcci5dZlsyzQfXVDnAe
         l6o/vuYoHxhoSsoVVQ050m5APWaqfP+30QnYd0JF9pmojs0BbCulBbAadL1vnlEpoK2B
         szUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718004002; x=1718608802;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fCsIgVGqp39qHChwBUvEw1r7syp/IBpICGYn5cHvzwQ=;
        b=Dh3cBnmn8PsAbqC3hJlrKxDbabQrKCP9Jvk/wK5nRJb4KCBSqD0J8obl0II6ceM/2X
         +3NgH1aZdyfMWg0UnM5tpW0WG8GV4m7fjaHYg3e8E50sN0fZr9f2mGZ1aWYzNU2vozux
         UJ59auGkt8se5pC1PYCQ9vXfYwJRdhYmcKnDFlVDZa3ChxvLYxbLUiDZrxAH0VTXd2zg
         fmwpsdkPVbpBCAVRmShVATjuMKs/ow14oWQn4LS3bR098+KFC5qsE2nSXedevYSJ/FgG
         zP5olKcMdNWXh7c6POw/yDhbqhsLAjs8YrTcS10izScEch5b6n+Z+YlIQqmrTX1+RdfN
         votw==
X-Forwarded-Encrypted: i=1; AJvYcCXhOHrZLymL65Sgkb9pf2/ua/BtP+yOfwE3ihl+Wi7nNeAlpNDGHJWMjo1lhaKdDOslFi40Jrn7djyKJmPKvREgBeda1FwsYq0gjkejeOX0fUGSrWnNCaHrVnj3Qrvg4tW1u0NyK1TUJrctjueQkHu5lmtK6h5x47SZ3Q/CSJ8h26fC5A==
X-Gm-Message-State: AOJu0YzUf6Zfodlq/JcdMvWozz40+HVZs4e+ZOf3oNZ1p4S6XVx6qbZc
	Hx2UsxSkVVRkZwyuAss0wuXY0/aTcatFlXtYkcSyn8c8wG9e9y4E
X-Google-Smtp-Source: AGHT+IEIZxBLbiNtV1BROpv0Z+m27tmupskdMFx1Bbbmvo8YeTMKP8L2bAybvWGBiw2TJCkVfPb47w==
X-Received: by 2002:a17:906:6b01:b0:a6f:260d:134b with SMTP id a640c23a62f3a-a6f260d13b9mr42649666b.4.1718004001929;
        Mon, 10 Jun 2024 00:20:01 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1245ff6esm218538066b.58.2024.06.10.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 00:20:01 -0700 (PDT)
Message-ID: <8cb3752a46f83fbadbc6d33105004f2986a470f5.camel@gmail.com>
Subject: Re: [PATCH v7 5/9] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Mon, 10 Jun 2024 09:23:49 +0200
In-Reply-To: <20240607-ad4111-v7-5-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	 <20240607-ad4111-v7-5-97e3855900a0@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 17:53 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Move validation of analog inputs and reference voltage selection to
> separate functions to reduce the size of the channel config parsing
> function and improve readability.
> Add defines for the number of analog inputs in a channel.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

One minor nit that maybe can be tweaked while applying. Anyways, no need fo=
r v8
just because of it:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 62 +++++++++++++++++++++++++++++++++----=
----------
> -
> =C2=A01 file changed, 43 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 8631f218b69e..1257303b0cf6 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -60,6 +60,7 @@
> =C2=A0#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
> =C2=A0#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
> =C2=A0
> +#define AD7173_NO_AINS_PER_CHANNEL	2
> =C2=A0#define AD7173_CH_ADDRESS(pos, neg) \
> =C2=A0	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
> =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> @@ -906,13 +907,48 @@ static int ad7173_register_clk_provider(struct iio_=
dev
> *indio_dev)
> =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> =C2=A0}
> =C2=A0
> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain0, unsigned int
> ain1)
> +{
> +	struct device *dev =3D &st->sd.spi->dev;
> +
> +	if (ain0 >=3D st->info->num_inputs ||
> +	=C2=A0=C2=A0=C2=A0 ain1 >=3D st->info->num_inputs)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Input pin number out of range for pair
> (%d %d).\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 ain0, ain1);
> +
> +	return 0;
> +}
> +
> +static int ad7173_validate_reference(struct ad7173_state *st, int ref_se=
l)
> +{
> +	struct device *dev =3D &st->sd.spi->dev;
> +	int ret;
> +
> +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF && !st->info-
> >has_int_ref)
> +		return dev_err_probe(dev, -EINVAL,
> +			"Internal reference is not available on current
> model.\n");
> +
> +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2=
)
> +		return dev_err_probe(dev, -EINVAL,
> +			"External reference 2 is not available on current
> model.\n");
> +
> +	ret =3D ad7173_get_ref_voltage_milli(st, ref_sel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 ref_sel);
> +
> +	return 0;

could be return ad7173_get_ref_voltage_milli()...

- Nuno S=C3=A1



