Return-Path: <linux-iio+bounces-19001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA4AA75DD
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645B29E0187
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4732571C7;
	Fri,  2 May 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBiPbK5e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFF2DC77E;
	Fri,  2 May 2025 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199251; cv=none; b=M7Udiy3xDSuvHnOyd9ZZM/ddcqgHcSPaVB+CQrZ1hk1M5JoxcE92N8CEWNap80g9ugvCh9qwVrvKJB8x21t5dpf1Y6kfhxbgfmsYaSEcvCpCITvo6rjdgY6yPy/XVy1JxPSHeDgcponVN11BOdhOt9q2EBTK5PwrlG/fKCzbD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199251; c=relaxed/simple;
	bh=gWTxBs0F9UqXJIG0qtujTiPxAtr3572MEERKWgr50PA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e1ZIL2ZjNx2SdwokJ2eve5M2GM2kuq7PmALEv/8y8yihOHH7ZCpJJYXs4OxOCtzfYZooIwSN0Ix7d7PZNMfs0RTkjBE0gRS/f83U9fXA5OyQrKHRLzUHsvq6iT1SrikAFUrYWLBWWo6iAPy8m5K3wjGtIC7xECSOmHneI5DVmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBiPbK5e; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso19808995e9.1;
        Fri, 02 May 2025 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746199248; x=1746804048; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkApf9OF2vt2m7wQ3AVnCZaRmP1pVhUuWGCy8xr055s=;
        b=NBiPbK5eDnA54YGCh/PXmvdfpZGjAforM0JqGe2MFBIKq3FZmuEAXw3H6Y9i/x5y0S
         qYyO+XlNzDZDiK7WZtIzVEUgyEpm2e31Ib8rF4sFDcyZ15r1QoZLjunHEc1aJ+77Ihiz
         R0JcE0zkuWElxrPe48Qq7y7iapT/1ofhPWW9N4j4NNSdkVmCvPKVKjls+s0Of6AYuvtQ
         w3iD1GKefp3p21h0xjyfrXFNn8NwLwICTyhy9yqAmZKlY6vxJwGMKeNYStjVhtMSVc0D
         Ph3RC/TEyhkzg4OCfvhsauE5oddi+ngRGGd3BcBolgf25Ta0LlsoylB4iel5JzjPBQXG
         +dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199248; x=1746804048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkApf9OF2vt2m7wQ3AVnCZaRmP1pVhUuWGCy8xr055s=;
        b=DTzO84PQrsvSMDddxlKyjWijcTfnxo167p5m7/z85XW+tPdUuAOl1To8QMSXqF5ccW
         +WZ9wGyR4LeuqU98LdvKgMQe+XG+X0BoYfRgb5pMMYFoM+hOuBUHTSi79gtjfSyOD1Lq
         kcWBIIsQqTue+0XZAp3tFId2T/uzMb5dMmE97sy8lcglC0QC9ll9DoEx8iyiUcTjfwyl
         LuqD9zIaSF4+YcR2G99VFcbT4K0U7Yyr9AS7+DfRLvcmPRNqhsK8Uyw0qG8SVwc324YE
         5SPBO9xz0ZOPNNBfp6QXkOb+1FoSaZ2oM0wi0B3I9Y2OMNDf6tgcAlZ4dhoMVY6bQvhP
         w7pw==
X-Forwarded-Encrypted: i=1; AJvYcCWvxs+ykt1ywnCEo2cABWJ5MXI5FG0XpRHj1Y6GwccMemPysUG7YdQOS+C+Vct8iWKnCReMODX4H0QR@vger.kernel.org, AJvYcCWyszZs7tDS5N9tLf/eyMdgAkOfebb/t2gsf/ERxkLkCUQ9eJzYgZZYcYZfq2QbEPYQk9I7D/4Eufbaf5cy@vger.kernel.org, AJvYcCXnU0Ti9nqtGmB/cz7D6GXl0QF+Zay3z7Swbl0E61dvoVFT94uKS5jyrfkx70u0OJ3V9WJpv3PMPve7@vger.kernel.org
X-Gm-Message-State: AOJu0YzRF8yzimcewUAIdK1U9mrXCP1ROiuRaPqdCrWkLvWIlcU1WIKG
	QOBiRoU91ygHkNpj9HbZ75Icc+Hks+4s73AbacqVwmEYGJb494gC07A1gcXt
X-Gm-Gg: ASbGnctFPtGQxUOI7pLk6lkmqAMnFyfwE7MveBGU5pSqsjs3SDZZY8rfye7UcpmAyI5
	qhrGPMLIFwa6u9KV1AnIEdfzBnVqUwPrY2dLdHbmHIcYXreJQkWy4k1pBJ4lXTc4dnqg9dHIRbR
	A8xWaN5zEPd7jO/KZCQGJRnz8lfcxNuBLtQt5gO/72PC4wwCLxrRPwJLGHkJJR4x7ZUhkU/kPBw
	pPAwrNe0LvUTkYOnT511jLKxVfhpZTT8IDUQowWhTmpX+SkSFn/v6OYYKWyDDpRapnMmQWa1607
	LR9hQ8CqBp4CyPHbbKn95A45tWaoZBMGmEfQVs/i2hl37DUDxxtMAB2gJHdpE9k+QlAX6Q3mLlw
	S6eE9j8L7sScD
X-Google-Smtp-Source: AGHT+IFeQ5IkqLdaj8y0dWe3uTpBDyz2jlnuUZvXie29cskA3rNqzqhUsNwvdZ63M7av01RuCLAebg==
X-Received: by 2002:a05:600c:a08d:b0:43c:fc00:f94f with SMTP id 5b1f17b1804b1-441bbf2d127mr26405915e9.23.1746199247685;
        Fri, 02 May 2025 08:20:47 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ae3ee26fsm100635405e9.1.2025.05.02.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:20:46 -0700 (PDT)
Message-ID: <44a14b310695b725cdda35226c2e9bf6525b777e.camel@gmail.com>
Subject: Re: [PATCH v4 05/10] iio: adc: adi-axi-adc: add filter type config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 May 2025 16:20:50 +0100
In-Reply-To: <20250502085905.24926-6-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
	 <20250502085905.24926-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 11:59 +0300, Antoniu Miclaus wrote:
> Add support for enabling/disabling filter based on the filter type
> provided.
>=20
> This feature is specific to the axi ad408x IP core, therefore add new
> compatible string and corresponding iio_backend_ops.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v4:
> =C2=A0- update commit message to state that the new compatible is added.
> =C2=A0- checking for max value is done in the iio_backend function.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 38 ++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 61ab7dce43be..2a3a6c3f5e59 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -52,6 +52,7 @@
> =C2=A0#define=C2=A0=C2=A0 AXI_AD485X_PACKET_FORMAT_20BIT	0x0
> =C2=A0#define=C2=A0=C2=A0 AXI_AD485X_PACKET_FORMAT_24BIT	0x1
> =C2=A0#define=C2=A0=C2=A0 AXI_AD485X_PACKET_FORMAT_32BIT	0x2
> +#define=C2=A0=C2=A0 AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_DRP_LOCKED		BIT(17)
> @@ -402,6 +403,19 @@ static int axi_adc_ad485x_oversampling_ratio_set(str=
uct
> iio_backend *back,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int axi_adc_ad408x_filter_type_set(struct iio_backend *back,
> +					=C2=A0 enum iio_backend_filter_type type)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	if (type)
> +		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_AD408X_CNTRL_3_FILTER_EN_MS=
K);
> +
> +	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -582,6 +596,24 @@ static const struct iio_backend_info axi_ad485x =3D =
{
> =C2=A0	.ops =3D &adi_ad485x_ops,
> =C2=A0};
> =C2=A0
> +static const struct iio_backend_ops adi_ad408x_ops =3D {
> +	.enable =3D axi_adc_enable,
> +	.disable =3D axi_adc_disable,
> +	.chan_enable =3D axi_adc_chan_enable,
> +	.chan_disable =3D axi_adc_chan_disable,
> +	.request_buffer =3D axi_adc_request_buffer,
> +	.free_buffer =3D axi_adc_free_buffer,
> +	.data_sample_trigger =3D axi_adc_data_sample_trigger,
> +	.filter_type_set =3D axi_adc_ad408x_filter_type_set,
> +	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access),
> +	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> +};
> +
> +static const struct iio_backend_info axi_ad408x =3D {
> +	.name =3D "axi-ad408x",
> +	.ops =3D &adi_ad408x_ops,
> +};
> +
> =C2=A0static int adi_axi_adc_probe(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct adi_axi_adc_state *st;
> @@ -697,9 +729,15 @@ static const struct axi_adc_info adc_ad7606 =3D {
> =C2=A0	.has_child_nodes =3D true,
> =C2=A0};
> =C2=A0
> +static const struct axi_adc_info adi_axi_ad408x =3D {
> +	.version =3D ADI_AXI_PCORE_VER(10, 0, 'a'),
> +	.backend_info =3D &axi_ad408x,
> +};
> +
> =C2=A0/* Match table for of_platform binding */
> =C2=A0static const struct of_device_id adi_axi_adc_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,axi-adc-10.0.a", .data =3D &adc_generic },
> +	{ .compatible =3D "adi,axi-ad408x", .data =3D &adi_axi_ad408x },
> =C2=A0	{ .compatible =3D "adi,axi-ad485x", .data =3D &adi_axi_ad485x },
> =C2=A0	{ .compatible =3D "adi,axi-ad7606x", .data =3D &adc_ad7606 },
> =C2=A0	{ /* end of list */ }

