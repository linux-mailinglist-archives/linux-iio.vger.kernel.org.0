Return-Path: <linux-iio+bounces-5440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2328D3667
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2202C1F233C8
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AA181332;
	Wed, 29 May 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPaETowN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3B180A9F;
	Wed, 29 May 2024 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985762; cv=none; b=jL/HEl1EcI+Xh0DX9ht32a0l3g9+BM0TSBaF2YvsOH/ZTxHbwcQ+pCXTHLvDZH3TvcGLIJOYl1ntoHhH+oqwQuqu5j5Im7MAiBCJ5/ORK024VGXfy1HokBG6ViwZacJhue9L0/q7tSiP7BgeBWf578v05bmAFMjiqNht1FYNvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985762; c=relaxed/simple;
	bh=HRqavWZ3zR2Tc6Bkv7cWD2VuSHXu9dJmhx0/DgQVzyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCaubsIJSas+X0y1+VKqR8q6xNks3HuWhTVqk7RDw5avarvMNs/SL0yNUPnz2EXtxj2tBFUU/EvPqEyCe5YlFOc1WT9OJCQ0fm6Fz4VET/aBNmboY+zsOIG1MUJS635SdB4/sVTpR7FFIuPu+UmPvMlOxXGvrxIPfaKNPNvh62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPaETowN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a609dd3fso159407966b.0;
        Wed, 29 May 2024 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985759; x=1717590559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=axvBrTvxidCklr547uTso4Zf62YA6/gKt7fukdGTu0w=;
        b=dPaETowNenmnmXPK8ZrhVlpxY7Mx6L5ViM0XrcZG6nWMy6qOYCEsLd5T+E78hqVQJ3
         VEvOQ0LnB6aHrpTiNTeRvNTTjPoXnZxOkkgAn06djJcx83oYTvvLllACpagS53AiW8lQ
         0Beh3rXRQLJ0LuHrC7N2OmLX1iLbCo3FqaeiY7MmnOWHUlnieTjWpkcVMIDHWHIrIqkb
         vBIN8i6g1Q8juKlWKF0Gh1pNnmnB/8CLRjsYrREBHKs3xP/KwCCJTGxnfdAe2jsudBXa
         zA/4RZA37+tVDRaEKQHkHzBpmyI1Ymx9ZHqtxTJ2KEdXNUPkCVlQyU7liQZ5y80WT23y
         c8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985759; x=1717590559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axvBrTvxidCklr547uTso4Zf62YA6/gKt7fukdGTu0w=;
        b=vhPDgOlHr9Ndry+mwjOSxey5WALTP3/ZNYJ/Etz70DuQRjcT2Ib1ci5C1Zj4rqIiHE
         Qrno2362DNN7WHJfXZ5TDMCZWViZhMB74E6jHIOaOTMcqZ/nxhB+a2/rJ1BkFMHqfYLK
         +xmxfKEA+5/1tYM1DjV2AZNApL/jMjVrBVB0WC01Har6z2g5K8B0OY3y/qaGxh/eq6Dr
         MbUoHVSJ5iLKbxbF3xVtUX3oBb/d5o6FcF/xctAqOlLEU5I0/8s605jK4HlKLekw3dXT
         Hqd7o13fJR6Yjj69y550Q07Q4gX6FFkji9xXE2Z72bluHfqFDG7NrmAIg11URFf+LkH1
         Eruw==
X-Forwarded-Encrypted: i=1; AJvYcCWM2Dr21h8Ehv5UOIQz1uQlgqJLciPGn7qrXVBvO2RaBh3+A3HDeo4zGY+PuWzJbSVmAAwMd78LV1DZyI2I7FldJKwREC0unZOVxlstHzIS5bNZ4HqjPWTfFRR4TvrdU+AQBCju86z2xvE56FUcv6wBTSpSwt/CwBDZ64/7KfM7VRB0lQ==
X-Gm-Message-State: AOJu0YyllcgoJfXYPvbBbBWOFYS5MDIOslWoM+Xbk7EKsX+wX7kpHjqi
	s/ktDG2fuBQjikiNH5sYubBimLHeqyqqYlgBDn47MNlb6x6TsT5SgEHbFSLIlFc=
X-Google-Smtp-Source: AGHT+IEK3ELEy563spSH/XtJFJXgn/U+wUokN3QmoQc7/u2j4B2B4og7zug0R53Ga0bAk+PyiptfLw==
X-Received: by 2002:a17:907:39c:b0:a65:b36d:d6bb with SMTP id a640c23a62f3a-a65b36ddae2mr50888966b.32.1716985759259;
        Wed, 29 May 2024 05:29:19 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62bee266a1sm492778766b.159.2024.05.29.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:29:19 -0700 (PDT)
Message-ID: <3b2a1ce579251726a56bdad25bfdfe75bae91c2e.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] iio: adc: ad7173: add support for special inputs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Wed, 29 May 2024 14:29:18 +0200
In-Reply-To: <20240527-ad4111-v3-4-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-4-7e9eddbbd3eb@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> =C2=A0Add support for selecting REF+ and REF- inputs on all models.
> =C2=A0Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
> =C2=A0 on supported models.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 8a53821c8e58..106a50dbabd4 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -65,6 +65,10 @@
> =C2=A0	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
> =C2=A0#define AD7173_AIN_TEMP_POS	17
> =C2=A0#define AD7173_AIN_TEMP_NEG	18
> +#define AD7173_AIN_COM_IN_POS	19
> +#define AD7173_AIN_COM_IN_NEG	20
> +#define AD7173_AIN_REF_POS	21
> +#define AD7173_AIN_REF_NEG	22
> =C2=A0
> =C2=A0#define AD7172_2_ID			0x00d0
> =C2=A0#define AD7175_ID			0x0cd0
> @@ -145,6 +149,8 @@ struct ad7173_device_info {
> =C2=A0	unsigned int id;
> =C2=A0	char *name;
> =C2=A0	bool has_temp;
> +	/* ((AVDD1 =E2=88=92 AVSS)/5) */
> +	bool has_common_input;
> =C2=A0	bool has_input_buf;
> =C2=A0	bool has_int_ref;
> =C2=A0	bool has_ref2;
> @@ -215,6 +221,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_temp =3D true,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> +		.has_common_input =3D true,
> =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -229,6 +236,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_temp =3D false,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_ref2 =3D true,
> +		.has_common_input =3D true,
> =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -244,6 +252,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> =C2=A0		.has_ref2 =3D true,
> +		.has_common_input =3D false,
> =C2=A0		.clock =3D 2 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> @@ -258,6 +267,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_temp =3D true,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> +		.has_common_input =3D true,
> =C2=A0		.clock =3D 16 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> @@ -273,6 +283,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> =C2=A0		.has_ref2 =3D true,
> +		.has_common_input =3D true,
> =C2=A0		.clock =3D 16 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> @@ -287,6 +298,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_temp =3D false,
> =C2=A0		.has_input_buf =3D false,
> =C2=A0		.has_int_ref =3D true,
> +		.has_common_input =3D false,
> =C2=A0		.clock =3D 16 * HZ_PER_MHZ,
> =C2=A0		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> =C2=A0		.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> @@ -301,6 +313,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
> =C2=A0		.has_temp =3D true,
> =C2=A0		.has_input_buf =3D true,
> =C2=A0		.has_int_ref =3D true,
> +		.has_common_input =3D true,
> =C2=A0		.clock =3D 16 * HZ_PER_MHZ,
> =C2=A0		.odr_start_value =3D AD7177_ODR_START_VALUE,
> =C2=A0		.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> @@ -915,6 +928,14 @@ static int ad7173_validate_voltage_ain_inputs(struct
> ad7173_state *st,
> =C2=A0		if (ain[i] < st->info->num_inputs)
> =C2=A0			continue;
> =C2=A0
> +		if (ain[i] =3D=3D AD7173_AIN_REF_POS || ain[i] =3D=3D AD7173_AIN_REF_N=
EG)
> +			continue;
> +
> +		if ((ain[i] =3D=3D AD7173_AIN_COM_IN_POS ||
> +		=C2=A0=C2=A0=C2=A0=C2=A0 ain[i] =3D=3D AD7173_AIN_COM_IN_NEG) &&
> +		=C2=A0=C2=A0=C2=A0 st->info->has_common_input)
> +			continue;
> +
> =C2=A0		return dev_err_probe(dev, -EINVAL,
> =C2=A0			"Input pin number out of range for pair (%d %d).\n",
> =C2=A0			ain[0], ain[1]);
>=20


