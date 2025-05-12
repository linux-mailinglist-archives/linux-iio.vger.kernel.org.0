Return-Path: <linux-iio+bounces-19449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C32AB30D3
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 09:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2669168970
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6E2571CC;
	Mon, 12 May 2025 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6ucNlne"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C01D8A10;
	Mon, 12 May 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036446; cv=none; b=lTlcbwYqzYkOEFRyQlMEeg5xYjrNAvP6DH7CQyP5CLAcLz3DU+95cVVTpGIgjNaW9hxo/srUWAbNrP1a0tkWFM4rQ48CxppgUxmwB/fbhm7+oKYKuYaBxE+JJMyTOpC0QwUuF0Quc3rAa6z8dIvRG9ZWb79EccOXSSoMAAN0tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036446; c=relaxed/simple;
	bh=9hRtQjM3Ar0+t8NaFtNU6223DSovsHzT3Gbal7PWyeM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZyIGWCRS0uwfhyTHz5ltzlNYd66UAHScET92JUaH+aUjFlivePk4tfjm/fCDuQWhyttvM+CiQ/XyXH7K+rnkh9AnqIAxVW6lAD3kqQeTEuTxzc7S/UjfgMR+TiI2t8pEsMyl1JbLG9nZbODBjStnueaJ7NngbgMztnbQd/ESv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6ucNlne; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441c99459e9so26503675e9.3;
        Mon, 12 May 2025 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747036442; x=1747641242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8eD6ibI0M6lASI+q48vwpEE1ZUnMeuu16Z2EjSEGtI=;
        b=a6ucNlneuGudEpx5t1RLUZ/iaRj7Cao79rwaZorXyUgccv2RHQMCl4NZoB85EYhTx7
         xY3tDILIg15aUE5AFuRKTW4IKJzQlfiHFoEg+w/buSh4+QBUbAqfvx13+Cli+MtXy4Hj
         HUnmjNLdCrF4l8oFRk1YYHCLKvqviICuaKNJ7Jmai/vXRbubfplcV/2zFKvigKQew6JC
         Mr9PSsznLRL2rUpO/hkTkfIwUhTa6Eq4Tzwp+kIhWYCULS9NNj1sczSFd4h2bCUC+j3S
         mrlgpeV4VkWdRr/YGlCbRS11oJaeL8FwjjNuwHoJoRz3m35K+fdyipr2Y79nWno5g31t
         TcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747036442; x=1747641242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8eD6ibI0M6lASI+q48vwpEE1ZUnMeuu16Z2EjSEGtI=;
        b=E2YF9yu8c8P46tRUXTBuVf8zdRU3gIf7PqvKaE3AW9kWWmvlESE63xb7cmsNOHtOVH
         DtfZOZSb1KZUQZrHEr6OrTik2C7x4hEpqHAC/QUxih2bONeL71kO0DOJEH2zhu8uYtIw
         JYz7EWyaw+LLTBtNdPG0kzT4Uhz/GMnaLwOY2FAZvyJbyn7LfMo9DwtrZ8ER7H6YFuV7
         FDbUmjiQrFV9avPovEsvyu/SNFXPI3fQxPmVyj5VYHdBI01zWfnTf3Y+BGyQhxdXBPKl
         5zbulloS6YY7oE/uSkcuNa/bYrLrOHI9Yy8AHXM30CClorsX2M2Pf5MiH+BzCqyyGm4+
         c/OA==
X-Forwarded-Encrypted: i=1; AJvYcCUx2TKeroG+HWTdYGGkF7ZfPqHNZIdHk1OnvGjLGpnPYBjMKk5XP1lqnc8XSMg8ul0/qrKSFfGiar+h@vger.kernel.org, AJvYcCW9QeDk/HA0D3p/AwYwFsETd/u96dfW+o0EIQoQjrHUT0gCEUtqFqW6tiul77+JWDQ81RHDXs9Q0Qjb6BMK@vger.kernel.org, AJvYcCXnFYNcIsXXodz1Px5iwmW4uBWSm9Wyj1CMrVx9R9LBunNdUDaEsOp9nX5DJmRnmBxN4P97xrbfYF8g@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6fsKwLoOxPqum1fXHCez9YW0MSutFucwXVw8/t6BXayYX4tv
	x0mDJz1KmxYqTp2BZC5vh8y2sX9sqBb+O7E3yC/aKXhKcIz+enwnPjFL0HEL
X-Gm-Gg: ASbGncs1GONhGbgT21Miz77+z/xrjj1MyRpyQlT9VAvC3GMgSUsbt9l6tf/xGtIqalY
	3+4iPBk6GDPe3zgffMLqPwtbMJpyLXr9CGA7lKgJRCGLoz+sQfAD4UmsU5z6NlDmHfIKnt6oGgz
	OqrbVt1P2eN/FIaIsswuKhH1OTUFBO+ztkJILI4kjJmvIVI/FUVidgDL+fqoH1ik6feyBY8BJtm
	Zd3F7S19SIg+xlejXcKhwKFFSR09/59csQvkZwKUX8CQhbq1QxZuUoehoKolvh9ZButeeTcwjiq
	ZpoPw/N7QtwoTiZO/mME4z5unxINXa4flQJ4V9ioW3mTwvNUlk4xUUDSOEerJ279ZO05fF/4d+l
	pRZqbvMYBuNm+Ts4mPKslb/uxTw==
X-Google-Smtp-Source: AGHT+IEfHplh8cNwmPpaq0KlybZ2Fw7To90UFmiV4KRxwfuo/kp+SVmgodT0r4pMnBoRnX3v940I/w==
X-Received: by 2002:a05:600c:c0d2:20b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-442d9fc0872mr50362825e9.22.1747036442472;
        Mon, 12 May 2025 00:54:02 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecccbsm11699530f8f.32.2025.05.12.00.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:54:02 -0700 (PDT)
Message-ID: <4b2a5e563bcd867c0f85e4ac34630ec8161707fa.camel@gmail.com>
Subject: Re: [PATCH v5 06/10] iio: adc: adi-axi-adc: add data align process
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 May 2025 07:54:27 +0100
In-Reply-To: <20250509105019.8887-7-antoniu.miclaus@analog.com>
References: <20250509105019.8887-1-antoniu.miclaus@analog.com>
	 <20250509105019.8887-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 13:50 +0300, Antoniu Miclaus wrote:
> Add support for starting the sync process used for data
> capture alignment.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v5:
> =C2=A0- use regmap_read_poll_timeout
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
> =C2=A01 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 2a3a6c3f5e59..f9c4018e3b41 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -44,6 +44,7 @@
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_SYNC_MSK		BIT(3)
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> @@ -54,6 +55,9 @@
> =C2=A0#define=C2=A0=C2=A0 AXI_AD485X_PACKET_FORMAT_32BIT	0x2
> =C2=A0#define=C2=A0=C2=A0 AXI_AD408X_CNTRL_3_FILTER_EN_MSK	BIT(0)
> =C2=A0
> +#define ADI_AXI_ADC_REG_SYNC_STATUS		0x0068
> +#define=C2=A0=C2=A0 ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK	BIT(0)
> +
> =C2=A0#define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_DRP_LOCKED		BIT(17)
> =C2=A0
> @@ -416,6 +420,25 @@ static int axi_adc_ad408x_filter_type_set(struct iio=
_backend
> *back,
> =C2=A0				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
> =C2=A0}
> =C2=A0
> +static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 timeout_us)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +	bool sync_en;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_SYNC_MSK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS=
,
> +					val,
> +					FIELD_GET(ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC
> _MSK, val),
> +					1, timeout_us);
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -605,6 +628,7 @@ static const struct iio_backend_ops adi_ad408x_ops =
=3D {
> =C2=A0	.free_buffer =3D axi_adc_free_buffer,
> =C2=A0	.data_sample_trigger =3D axi_adc_data_sample_trigger,
> =C2=A0	.filter_type_set =3D axi_adc_ad408x_filter_type_set,
> +	.interface_data_align =3D axi_adc_ad408x_interface_data_align,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};


