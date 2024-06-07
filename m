Return-Path: <linux-iio+bounces-5978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF38FFE9E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3581F222EF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3B615B57C;
	Fri,  7 Jun 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3dzJLte"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4315B553;
	Fri,  7 Jun 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750970; cv=none; b=DWb7myDJtnbc94f7zihCTSxhYKOoGkb/osMtFykfbzh42QvE6TWmD/hsjIIhUTJH+ITfHbTCEUWhYYwPDRXY9S2VeZT8iM3IDKVklagkQ+4grU9h480c1yvf/zdDgW8hAmSBgqirKdcVlxJ7j6p71xxcUobUwX0hu1lfV46+q5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750970; c=relaxed/simple;
	bh=gph2vTnyaKmegcHhIalKFsjOJL8aWTh9ZxQdX5E6tgY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Plt0qf1EoDIj+wvvf/y2a8VHiZaojVZzRYSTTb5OTccazx8GFWjEkGb3uW0Hylp/58Bc3xX+MlCvvZCsxTxS9kB60RAYwXVrSrTjh0K3ZpK2wUtf6LjAW7dC/zZtDfH/7ZPVAkHv5wMyGSMMBnh+WnYmFjeBrhBkf2CP3pDZ4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3dzJLte; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57aa64c6bbfso1931623a12.3;
        Fri, 07 Jun 2024 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750967; x=1718355767; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3OXk47KN1vRbsGCOqgQ0IPGonivWWX75uqXRl216dY=;
        b=g3dzJLteszWWi4BGCeVGirG8NKtsZL5W7noINYv2M7kmYXoSueiqUM5S6jd6uwlLmi
         5wCgm0qybEmksQXtXi7emzHk2NABnrJ0QS1ICR6AuvKBf3XJTT+B1MmEHsCRhyKBMZrk
         Ejul6nkZo+xJu+Ehn18Wf2TwoyCxP0umt0R8GXOSA/pgicj6Y10sKSDc5T34rQ4G/mCW
         KVJgmMJnlzm9H5zinVGhFi+JPVqK9zZPlUm3Dl2jQfht+QGZaDB5T9J50Pzt2i8yo8vq
         YrFo56YFlbl1DL1xDY61l0C2yzAI/u2qtjMw/aZpt2ddcKZyPrTpMiYZ3662dBfIYuWj
         ZZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750967; x=1718355767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3OXk47KN1vRbsGCOqgQ0IPGonivWWX75uqXRl216dY=;
        b=Z9IVrfBVUgXsMMf9LWq2UeJ91PbSbUbaZ9xzBWolkP5u0Me14rIusY7pXwdViLdvgr
         9ovIWTaSIJo9Ir8dzs5fX97u4YTHJ1BBkqjSvJfyH7R56tQa+3q+1Vf00XIKc0eXVWsM
         Jz++x+4erWSv4zwB3uCncg+SH3mhm9u/p9ub8qbeW1Sf1bAitFQteQunM2QOmj2mzLTt
         bh2iS5OCFCRVqAT57E8b1zEjk1ABEEnGZhFGVk4EiMwBaVNaCxSuMrlbjyxDV6lMtAHD
         yNKFnm2qKBDOrMwJK9cH1cE9/uPZVgz6KpO+Z95Dr8PsfhqPgTHXB9Dh1FlhOHQGB01Y
         xi8w==
X-Forwarded-Encrypted: i=1; AJvYcCUzen7B+Ayi+enuZzj3l9uSWXtIJ6L6A0oFLwmYpDTAd73tPb+f3BHgSZH7cq8/z20L5TfCo5ytSyWFPHMsKxNGy50enAVU0fIL2UXH9cEfEjERGJCSthvC5Apx8MIGEXRqS2Iyfnwss7XtKnf+S5NWHIGjH3YZTSiYiugcBtj61l/Rww==
X-Gm-Message-State: AOJu0YwBWW4qMfbFtEsTCo3K8ngvgrKXVdHQSRM9snCUFaGYYjYlJAKN
	kD1A0zsEcnv9BEyLvdnVUZwp7fbYdJYzqqwmLxcB0eoXnYeRPJzd
X-Google-Smtp-Source: AGHT+IGR1LaE6jacB8mFU7IYxmRZC0Sme4xtJm192W3JIo7nEukO7iZOkSUi/z11sXt7W3y77dOAKg==
X-Received: by 2002:a17:906:2e82:b0:a68:379d:d623 with SMTP id a640c23a62f3a-a6cd7a84203mr124427866b.36.1717750967417;
        Fri, 07 Jun 2024 02:02:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072a101sm214435266b.201.2024.06.07.02.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:02:47 -0700 (PDT)
Message-ID: <822eec36a530f659e4924886ad8d2bf272accd59.camel@gmail.com>
Subject: Re: [PATCH v6 6/9] iio: adc: ad7173: add support for special inputs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Fri, 07 Jun 2024 11:06:34 +0200
In-Reply-To: <20240606-ad4111-v6-6-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
	 <20240606-ad4111-v6-6-573981fb3e2e@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 19:07 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> =C2=A0Add support for selecting REF+ and REF- inputs on all models.
> =C2=A0Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
> =C2=A0 on supported models.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 29 +++++++++++++++++++++++++++--
> =C2=A01 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 4040edbd1c32..d16fa081a285 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -66,6 +66,13 @@
> =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> =C2=A0#define AD7173_AIN_TEMP_POS	17
> =C2=A0#define AD7173_AIN_TEMP_NEG	18
> +#define AD7173_AIN_POW_MON_POS	19
> +#define AD7173_AIN_POW_MON_NEG	20
> +#define AD7173_AIN_REF_POS	21
> +#define AD7173_AIN_REF_NEG	22
> +
> +#define AD7173_IS_REF_INPUT(x)		((x) =3D=3D AD7173_AIN_REF_POS || \
> +					(x) =3D=3D AD7173_AIN_REF_NEG)
> =C2=A0
> =C2=A0#define AD7172_2_ID			0x00d0
> =C2=A0#define AD7175_ID			0x0cd0
> @@ -146,6 +153,8 @@ struct ad7173_device_info {
> =C2=A0	unsigned int id;
> =C2=A0	char *name;
> =C2=A0	bool has_temp;
> +	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> +	bool has_pow_supply_monitoring;
> =C2=A0	bool has_input_buf;
> =C2=A0	bool has_int_ref;
> =C2=A0	bool has_ref2;
> @@ -216,6 +225,7 @@ static const struct ad7173_device_info
> ad7173_device_info[] =3D {
> =C2=A0		.has_temp =3D true,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> +		.has_pow_supply_monitoring =3D true,
> =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -230,6 +240,7 @@ static const struct ad7173_device_info
> ad7173_device_info[] =3D {
> =C2=A0		.has_temp =3D false,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_ref2 =3D true,
> +		.has_pow_supply_monitoring =3D true,
> =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -245,6 +256,7 @@ static const struct ad7173_device_info
> ad7173_device_info[] =3D {
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> =C2=A0		.has_ref2 =3D true,
> +		.has_pow_supply_monitoring =3D false,

No need to set the 'false' cases...


- Nuno S=C3=A1

