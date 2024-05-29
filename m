Return-Path: <linux-iio+bounces-5439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D148D365D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C61C21C84
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA54181300;
	Wed, 29 May 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihyA1DZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF13B295;
	Wed, 29 May 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985670; cv=none; b=lxTQyuGhtJBoEVDCQrzq/f7GhePUia8N2L4nPbN6nZcLL+43oBMjxzQvGox5Q0P9d3xsGGXJZxV9/LAiq9cxGV5MqcXH9upS3YndUyqLGFaLJhzXYQIvq+EpBymMKqnSHl2IacZ8apEza1ced4FkZ9PJBUN5zbVeGRgad9tvIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985670; c=relaxed/simple;
	bh=2Tq8KNkDSL/r4RYS7ksyDoh99l2whRhNO3fn6pVmCAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQ2q60A9NnAKZieaL+2oYebvXGgN00MdPKSMcx3WV7RSyxs2qqSbfI+v1IhgAOYVArSTFuMBldcxkNm1iih7KMd2tKpAjv8zx9q7rSmvteqE1EMTrVHUSERxdQT4RQGd9W7HJBequtHQb66RDK3Zbxsy0J/SqYbxduCE26PTrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihyA1DZj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b79447c58so279521e87.1;
        Wed, 29 May 2024 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985667; x=1717590467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PeimGJvmfer6fOyUvMTNsas+IdsraV9cPm9aE+JTB+A=;
        b=ihyA1DZjmiY8u0Z8wxmTedmb71VFYXaRbp0Opvaxhs+LQVlf+JI62qx2Z0qT7GA0bY
         FJx7Y8HexdFx0Ia6dlkJupaWIdmOVQpJIkdVaGcRo9Gb6W42hc1N+2sSM7lWi+EuwCdX
         Oak8kd80VTtDYMwFxtM/Oun8Rw+CGeJBJ5HjLP/B4K4b7riVkAh28MeN5BkYV6AarJ/J
         C5UkdNjEdY7mPKuoLcIRhTuo69k7rmn6IQXAKH5yLQ7F6eDJjjvxsUjsgXu1VmzYcVQl
         XvzBZ8dVeCMpazyOgbacN28DTv3zPHJ0UDcilj67LHc4B5RIrgfpJF6vwHGKnlxZd3IX
         3rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985667; x=1717590467;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeimGJvmfer6fOyUvMTNsas+IdsraV9cPm9aE+JTB+A=;
        b=qMIJsQbDRg5GphlCfum/E9bqH3iW5T2a+sqF8Nmcp1TTNM7gG45YDmvpd328LpP3AL
         RPPt1ryH2OKLvruOzonFZl92X7QnF7tlK8T/rCr3sGBacreeyCJCwD5cIzvfwhxQ/WZT
         B2zvdK3zENUKJuXJtro79GPuIRwlWOYPpgfb8Z71SEPpSthw5YJq383/d9srT7Hqv2CU
         BtTefOwNLgbl0uUbhCwIz0gOroUMoAYCzlw8DUiALStXQbmmA7yeC1jd3JFQYUmGvbL0
         I3MusgNO/JCcgE70f1oBOT69Qztfp2MeDRR1sKPQsB6s+0QFVSqQUYCWUuE/3OWjx4a1
         mfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUG2q9WTE6iUYmpXooI1SIyTAFgbv4RJVCzRYQVMG/KbqFxbF6IPrPMWzID4hULnd1vT7C7DfhbdB/K7/eHnJ/gcWHe1YyeRFYWJvEkUUpefoQtuQl8ulyaD5KEHIzD0ADf+6z5g2LF9lNPEFwhJCIaM3pIU/uLKvgoyJXTyA00LTLUw==
X-Gm-Message-State: AOJu0YwAPqFAQ3fN+ccMr72A3qvPG+rZvba3U56iuohj8VPf/3LbdFLu
	JcJuuSXu4jwdbn/i8UdznP+hQlPFaAtlP7P8KSfnNOW0glRuj/fL
X-Google-Smtp-Source: AGHT+IG/SxXQZnV+jg9CyYE9LKyyC/PcXXF3petb+D2XGxuU27/7/M6yyQWFvHsbEy9LLJX4I3CKQg==
X-Received: by 2002:ac2:4c08:0:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-5296736bb7bmr11593905e87.55.1716985666782;
        Wed, 29 May 2024 05:27:46 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f969sm708931866b.101.2024.05.29.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:27:46 -0700 (PDT)
Message-ID: <71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Date: Wed, 29 May 2024 14:27:46 +0200
In-Reply-To: <20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
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
> Move validation of analog inputs and reference voltage selection to
> separate functions to reduce the size of the channel config parsing
> function and improve readability.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7173.c | 62 ++++++++++++++++++++++++++++++++++---=
-----------
> =C2=A01 file changed, 44 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 9e507e2c66f0..8a53821c8e58 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -906,6 +906,44 @@ static int ad7173_register_clk_provider(struct iio_d=
ev
> *indio_dev)
> =C2=A0					=C2=A0=C2=A0 &st->int_clk_hw);
> =C2=A0}
> =C2=A0
> +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain[2])
> +{
> +	struct device *dev =3D &st->sd.spi->dev;
> +
> +	for (int i =3D 0; i < 2; i++) {
> +		if (ain[i] < st->info->num_inputs)
> +			continue;
> +
> +		return dev_err_probe(dev, -EINVAL,
> +			"Input pin number out of range for pair (%d %d).\n",
> +			ain[0], ain[1]);
> +	}
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
> +	if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF && !st->info->has_int_r=
ef)
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

If you need a v4, I would just 'return ad7173_get_ref_voltage_milli(...)'. =
Any error
log needed should be done inside ad7173_get_ref_voltage_milli(). Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

- Nuno S=C3=A1



