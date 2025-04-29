Return-Path: <linux-iio+bounces-18815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C67AA055B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90266843499
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F1F27A934;
	Tue, 29 Apr 2025 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlq1sZt2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38C27604B;
	Tue, 29 Apr 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914686; cv=none; b=jS/qVr8TNP/oWa/aZ0I+gEnqDHa8aKzDHC651phSLklJFnu2sa5PBnACx7V6ud0jJw3bp9+aaLW853kYk3uXC9h0jmbvyGsSrml6JDrt1z3rBr+md+EELu09BwDznHpS6E3yk+vLeYzTGuesbEEFHI2DCPYZmoXmDcCBxq5szqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914686; c=relaxed/simple;
	bh=eESuEXwS0Xg83Oys04QHXmRAwjGpD1UZ9CXsC2XpAXs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCu71+Dux5KAusrm+FiFNNKTRPJqdktYLkXO0XLB6HoCtwTdQCV5jBN5eqZNFDGMlWVDzL9geZpVDQGPuLCiHZTYU9weAqZ8ZkGj7ycdK2aV8MVvmWDE8KiPLB0H9jQz7TdYMyA8XuRu88RCJ3I5NS1zl0ccw0OI8aCgER/0LbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlq1sZt2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913d129c1aso3726568f8f.0;
        Tue, 29 Apr 2025 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745914683; x=1746519483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2+3W2a7AkVYwexjr1GzqEPTtciWTnY4dLIb8fkHrQ8=;
        b=mlq1sZt2jiPE8NqgC7BiIFFrFrwRxzCyTPN6zSR++Hwy1Mo5W9BKGDVKJ4Nr0kKZKH
         +phZZiX3Al0OZlOvlZq3n4nZD5iJ8YpWI94e4iUKve+cuWMqjewsn87FnlSnr2ue3eKO
         Vx5bNuln7wvhoQ4MvVyYmnyWLhJW+4QUxybcRtYHaVFaurgRaeSx/l3ylWavZ+CXcVmF
         ic483W0+ItL0QfwI7Tdd0CpAGV0aaFzAMhstjSauf3Ii9i2VbrfrhfdPyOGYIWXmKrzI
         T1vtk67sQ8NAR3k+77r4/OJIx0FGSSi19dq66yl7qQlsFqK4XBRm/kyg01daZ/nYYFUE
         jcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914683; x=1746519483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2+3W2a7AkVYwexjr1GzqEPTtciWTnY4dLIb8fkHrQ8=;
        b=mbuYWnrPIvHouP0jacEukGUf6qXHx8cpBV6KtdUx0gIewrJAkXgzJe3pE/+SHjxaRE
         4/D6nqmUgZ3PkoaWjHWXxictlVk5u4FNTKrNhjGrMpFdxKZRek/BGHWCsKG/LvZCY721
         LdviW4OO+KgWbjB9r/ulMnFM3z14N1IVEB3gGiuwur3C7xvy4BTopnzYEz0maASMcM56
         dYfr24AUdMkYsIG3e4Eg9uoY98cTSq7Lrn1qhAhkIhglA7qY0B7pMP5yhQBSY7AZdQq2
         fUOAcdvCd6FJs/m/a5Md2tWdw0Bzr1EO7Nuld1IWJIRY82XnclyYRVATvz8cklTxh99C
         fWLg==
X-Forwarded-Encrypted: i=1; AJvYcCUfc5M8VPzA6YcArrb9KxmxSn2syWjsj1BvQGNtSYdfI8XldzqLf05qUiYNLrNT+iYNBf55h7zY4kTi@vger.kernel.org, AJvYcCUvJpKpRp8K3kofbydu2gMxMdb0JnlYpig6Ah9EUoVH7OosNP5YWrbJoJ5wSjSHedBmbH31HT2L3+VsiEil@vger.kernel.org, AJvYcCWlK5Vj3VaKSRtvE60jkVysQEuSIoRBj6L7ew16ucjicd8AToXx3+7iLa/CARkLuGSqtL2sqhfBpjXd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DHOlOibjz2F46amavY1CfyHHEKpiYNPIQVr9cMBEpb4qkBMC
	E969bkU/+B6liTj27+rmCaRJjNq6CrVPBKFz9tJ2NMwyCbOVh2l+hWJyEhkPn+I=
X-Gm-Gg: ASbGncta+QpytvY3dE62UeOgLarosT/i+nZ8p00zew4Ag2BMQB52PKR88PdiDb/s1Zr
	zckw2u2Z8zfJ3TZfEYbs5qSWoVnsg69sxzt72z7eaDhSLd9VEQFeEflmgmiUZqba3e1dgvXi3rk
	m3vKAsvUYon2NQziGVZ6cIxrK7HGuntAneYRXZ5Xh8oQM69LHTESKriDosVcqNtNGW0BJ7b5LfZ
	kTkrnQ7ySnoE3KQtSjle/QjG+l/VtlaCqj3oTZLodHyOOMwfJOX7gI831HcXdgRwyPqSCpVOdNV
	eqOBzpfSOCbTEGOq9j2JrcOJt7kppp9Rh6XeJv+Xm11Mm4z2yztmj9lw6Nf1W5Gu0g6qRb7H7UJ
	dGqolmTtzkOUd
X-Google-Smtp-Source: AGHT+IHyZz6Q7YY08XsLx4KNTlg9jPQnLF3lrgacy9YxzyoYLl6L2lHAno3dx2HVerE21VFlmwAHhQ==
X-Received: by 2002:a05:6000:4024:b0:3a0:830e:68fd with SMTP id ffacd0b85a97d-3a08a501c07mr1430036f8f.5.1745914682686;
        Tue, 29 Apr 2025 01:18:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a021sm147604465e9.29.2025.04.29.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:18:02 -0700 (PDT)
Message-ID: <bdf28693eeeebf93cfc6305679e154bdc515206c.camel@gmail.com>
Subject: Re: [PATCH v3 06/11] iio: adc: adi-axi-adc: add filter type config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:18:06 +0100
In-Reply-To: <20250425112538.59792-7-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 14:25 +0300, Antoniu Miclaus wrote:
> Add support for enabling/disabling filter based on the filter type
> provided.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

You should either mention in the commit message that a new compatible (and =
thus
iio_backend_ops) is being added or split this into two patches. This is sim=
ple
enough that I don't really mind being in the same patch but still...

With the above (and a nit below):

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v3:
> =C2=A0- update the function to adapt to the backend interface.
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

We could check for a max value and return -EINVAL...

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

