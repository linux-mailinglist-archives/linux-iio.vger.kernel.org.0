Return-Path: <linux-iio+bounces-18506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21115A967FC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7E03AFA2E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04827BF76;
	Tue, 22 Apr 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9xli2O7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24461F130B;
	Tue, 22 Apr 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322106; cv=none; b=tbH5/Ph2CH/LW5OMpSTUDC3lRHCTOnBm330AiSoj6ZARjrmY/ejzqm6GutpR3BEgGEElWLNimZaB0LdRW3cjJQY87nspkGI354k124C2A4JcfUoHSnjMxjVuy62znc741XPcdo0/78N98ydSyybPFUbka7OXSs4jN2AEsm7LkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322106; c=relaxed/simple;
	bh=6IOm0GI+w2cJIUM3Q4iTv/LtXZ6qVFV7EMQPid+JNLo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f8bnRJpEhyDK0aXmXmcmRTCqhCxJOay4rVtTZgRnkxU4oVfR0b0jF5VqpQYmk4epgeLu3GCLgjKPwcVu/ZWlSXgI8SqreEmvqI/YVYegQvgsb9WiKCF45odFtoMVuW57x90zWSQdTixDFoVmcSwdVBqLB/w3oUBF9k0M2geTij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9xli2O7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so37110465e9.1;
        Tue, 22 Apr 2025 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745322102; x=1745926902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtZe5MkVjequJl/v4wkcEgW5OwyMOzW+8kGSPcfrHu0=;
        b=c9xli2O7I0zAg5XpJAYJpLkkQEKu1nwX1wJOEDyc4lqhk3JDFgg1IEcuk7Wbd7p10C
         JKSponzh4UDqp5vHQyZ2+EeGlw/FjLRogICJscynwjwJ9fTx+qTVJbjL66qCPHsnE46X
         K0mUquQ6X+Iwn6qY8lZalRnw4Q1zgzqJ9wF9bZ00dIuRVtF5Jqz7kMNbQAxaMY3Hs/mF
         u8DviiqH1Dr24lKu8ytYklUHIwElF6T/+fF0vp3CORNLhEqZVbC+S11uJd3wKYOcgYmR
         i8ApzycOqobYB73xyZ6c+qs/QcNEYSdC+h00NYfHn7mxSrzHohurAS08EIG4LNCWZ8AK
         JtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322102; x=1745926902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZtZe5MkVjequJl/v4wkcEgW5OwyMOzW+8kGSPcfrHu0=;
        b=oceT97tMqWuQxK+fOCG10bhGDYVytL8hB6h2u36zRyg4WsaUx9qchwHQbO0VZyKkBA
         9Dqd0MMAC/2wl1PheRKsB4BxgCo26Oi8vrvQWBQ+qze4qCnX25Td/kVH9CDNYXRt+JNQ
         06VRUfdXo9PyefthykauoI+wfLIRM7KuASvLz7uECAEWAbRRT29mf0jBSRENQUFFwSwG
         lkAnNFQLN3eWLuKhd/iLUAXyrl8knxAfnISd4jinqHPUhFSdHWvotuXFwx/NvXqBUZoH
         s6PRZ2CEb3Z1fBCnCsNQozVq0JEywQwDsEsjwb1TBEMlFnwBxDsA8gCkaQOb+c+zuB2z
         BP3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfYgjyEPu4/Cb9FIoc+/rVTc61k1EW0YddocVTQkffogKnCGc5H7ZrijFJu4SPD0YpZt8+xhaVSatW@vger.kernel.org, AJvYcCUwID2/+IeGI3TQ+xnO3tWk01qB2vMLCMKMdI7DGggEMaf7HrDIZGanf+OZjznP5mhl9xwlxfX+7wb5@vger.kernel.org, AJvYcCUzs8fBQgbmQQqWHiPRNhSkp+/wLebVLhAw19weADnKqv0oVX67OOIXRWpdK8BFnTMqcEqNB961DUo8vn7H@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3gNJJUDcebxq5G3BiSgPua+pfLaKdMn+zMGZsXM5vqNwMaOW
	Yk8I7fKZwBV9gu6Faow6Fyb9nY9fTir3yUCKG2xh/J8zZ+J75k9Yob4bEBIj
X-Gm-Gg: ASbGncsUiAYyNrEoGPZGS2X5IcDjpYxWNT3mwmkNyeK3lUE8qIdpby4tKUv9I+i1CEj
	IK7MA7Kp38GaWyTOdqj/0Xw5/UdDfmxK93qubkZcWNSyrXCI/mdtWPcQDDIZE1Tr9Z3qk9RgcAd
	Y+ILf6IzyOoFbEQ7tZ774Jv5qJ39Qr50eyV2Vl0isn9q+L0yydJFTNg7C/K3lgQjpCRROdTi0l6
	e4d7rOPEZYHJtdUu7pIyF24n8xQMXguIcGh4ZB/6tvLqDXvVpWFZMW0MikomWj6knUmG1iq6Qz5
	5yosH9zNNVGaW6mVHmoZXLhh0GANyrAm3TlwIt+ib325+2Rj/FlzR07itqnevJHCsATw68s9umx
	OAMWJDGUW4ajTNqFKpW8Yi0g=
X-Google-Smtp-Source: AGHT+IGPGWhYJLYhscw5CnJUTDwYkVxOBQadnF+fTJQ6W/mQbI7fGiZwUihxjmQMtGMJPEvXJYT8VA==
X-Received: by 2002:a05:600c:3d19:b0:440:68db:a045 with SMTP id 5b1f17b1804b1-4406abff89emr124135945e9.26.1745322101709;
        Tue, 22 Apr 2025 04:41:41 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcaasm173681615e9.21.2025.04.22.04.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:41:41 -0700 (PDT)
Message-ID: <d7e6660e0263f167e881bcb32d8d241450a21a66.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: ad7293: add adc reference configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Apr 2025 12:41:44 +0100
In-Reply-To: <20250422085529.4407-2-antoniu.miclaus@analog.com>
References: <20250422085529.4407-1-antoniu.miclaus@analog.com>
	 <20250422085529.4407-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-22 at 11:55 +0300, Antoniu Miclaus wrote:
> Add support for configurating the ADC reference (internal/external).
>=20
> According to the datasheet, the external reference is enabled by
> default.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

LGTM:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad7293.c | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
> index 99fa2d1f8299..c3797e40cdd9 100644
> --- a/drivers/iio/dac/ad7293.c
> +++ b/drivers/iio/dac/ad7293.c
> @@ -114,6 +114,7 @@
> =C2=A0#define AD7293_REG_DATA_RAW_MSK			GENMASK(15, 4)
> =C2=A0#define AD7293_REG_VINX_RANGE_GET_CH_MSK(x, ch)	(((x) >> (ch)) & 0x=
1)
> =C2=A0#define AD7293_REG_VINX_RANGE_SET_CH_MSK(x, ch)	(((x) & 0x1) << (ch=
))
> +#define AD7293_GENERAL_ADC_REF_MSK			BIT(7)
> =C2=A0#define AD7293_CHIP_ID				0x18
> =C2=A0
> =C2=A0enum ad7293_ch_type {
> @@ -141,6 +142,7 @@ struct ad7293_state {
> =C2=A0	/* Protect against concurrent accesses to the device, page selecti=
on
> and data content */
> =C2=A0	struct mutex lock;
> =C2=A0	struct gpio_desc *gpio_reset;
> +	bool vrefin_en;
> =C2=A0	u8 page_select;
> =C2=A0	u8 data[3] __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> @@ -785,6 +787,12 @@ static int ad7293_properties_parse(struct ad7293_sta=
te
> *st)
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(&spi->dev, ret, "failed to enable
> VDRIVE\n");
> =C2=A0
> +	ret =3D devm_regulator_get_enable_optional(&spi->dev, "vrefin");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to enable
> VREFIN\n");
> +
> +	st->vrefin_en =3D ret !=3D -ENODEV;
> +
> =C2=A0	st->gpio_reset =3D devm_gpiod_get_optional(&st->spi->dev, "reset",
> =C2=A0						 GPIOD_OUT_HIGH);
> =C2=A0	if (IS_ERR(st->gpio_reset))
> @@ -818,6 +826,11 @@ static int ad7293_init(struct ad7293_state *st)
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	if (!st->vrefin_en)
> +		return __ad7293_spi_update_bits(st, AD7293_REG_GENERAL,
> +						AD7293_GENERAL_ADC_REF_MSK,
> +						AD7293_GENERAL_ADC_REF_MSK);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

