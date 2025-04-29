Return-Path: <linux-iio+bounces-18817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E7AA05C4
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052393A6860
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFE277808;
	Tue, 29 Apr 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEx+asdR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA92676FE;
	Tue, 29 Apr 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915194; cv=none; b=DVGl7ccAOvtZsfUeMIdqVuei97PfyZm4MwVzjsfreqPZH7WfJn297FH4SaTqsefCh7nZJWAT8cqu3eDHiXHZu4++3ZWB4kXvIY/L88JQAdc9jSKM1NU37IGP1SciaaSsMB55dCfwdAhTtWjH3Gee8dDySBrsCerq2sdkPeZCN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915194; c=relaxed/simple;
	bh=MgTCbs5cTEEDoiK1neJ0UWfJc9MPsWB0Ca3qjvVgPXU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGYR/Wx0tdSgxhfvrTDw3cjgeptcDXXuER/6j4+LmmHDIWFcOKaioKMzbVjWWFURVRKkQpe2i4yrsOucZFZ+XGjHf/hhBfn+Ul26Ir3DfVmZOcYugE9ciWP4pWZGy6YDzJPERu6S5Z5EjiIhZvCPD3Zvrg6MLmkBwMPvID+eiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEx+asdR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so58344595e9.2;
        Tue, 29 Apr 2025 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745915190; x=1746519990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZtza8LqfiPrcZDi4cBp1dqLq5EDO64dUlBzh5jaboQ=;
        b=TEx+asdRZZsUCg9/AhCgqrmUF4lbs01aFk3SdDsaSMaoH3CHWm/IdIEFTJ11K3zV4d
         JR3pX9STgkWh2HI555+IG293L1yX+lcl5RMk77qKpD7Qe3GZDyD9Ui6fEsOwT8oVrr7W
         G9/Pgba/0B24GBF7Q4X8XjjIE+nkxufLfuJTq7X7BAKECuGDRf+elF/8afjfGfIieZwB
         X6C10IRw5Dly1TummaO9F0qVoiOkYZNsmnsFP2e7gCJfv7H2hzsNTy7yLn2DOxk2zgSa
         NkA2sO0SjbAVbaKa/RugPflEmExm7Gl0OcNCKEy6Wq7oPaBlmBk9Jy80pgoHpaRnrwNd
         RmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915190; x=1746519990;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZtza8LqfiPrcZDi4cBp1dqLq5EDO64dUlBzh5jaboQ=;
        b=uTX40863wC1OyIqwAhExSlvSxgsRealwIVHbB9D2cYxdkUdqh/HDH8EjfVEjCaR69l
         lXwmf845zWy5ZIEm0aH+pHmJqESpfFIT4rgVkvT4T+zq1IgX215a/06lbY0aCr1Fg16L
         cQw/rxKv48cPKSXivFlhRnaUvMA9nXlt5Q3vEB0tyxplHUidAczY8pFbBX0CmxALan3o
         Wz9xH5IULszyyrnZSphuf6MTwoG856gamosBxe0z6mndjxDjMJLRi/VtHSGpGqflYq0z
         rA1KGqxPwSYXvoYhJhvZgajUVehC34GcG7weolFF9ZxcBqJDNmCgVb+MZMh1X8AQe9ZE
         HsNg==
X-Forwarded-Encrypted: i=1; AJvYcCUM58ui49T+I2PeeM/reNgBfHqshx18gYa9CMOv+MTK/kv7/Ncv1370ZAcO2zlOqnYGoOdn2LIfWS/A7ed/@vger.kernel.org, AJvYcCX09B0EEBn1W/kwfKqYfOf1IVuuk1gDwHgjBrIq0OKgd9nOZzjFh+4oIr0J31JBnUAy7p9Xs6vGChLK@vger.kernel.org, AJvYcCXZa65UYWw9l7Nw8HkYEUR8giPzmf/nYKwCQ009GCthcCKjG3eW0sYvi6KhwP33Z5/eNTLeDnVEuZxS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2AqsVhUoyLSUbwDeqxxQHG9Ct0eK6VcEIKnfdY9o5gj0LEEP0
	vD3JGm4sZvD+9BaamK9nXI+yELU3YkJ5v85ernP3weF5jet34ne1LMN0SQoG+qE=
X-Gm-Gg: ASbGncurFRQLXQ+qS4RJpNBRcZjC1D+fvlM4YZEWtXr3xT06IUFqaclEBqksCUjeE0P
	yXuGF75dqy5LJ7zIaDWOJHB611R5Mc4nCh81b4OacZsDoA8tjZsw8k/HWG5lP/emgh4kPlANoSV
	iAi5SIFumeLh2Mgc60D5jwCd6WQhKbQL8HNUdfxuZAxJCkFXnUN/KTyctCIGMhRRJr5V61EamXz
	Vz7EEAYqEdLahB6uwHrmlMWYaXuNS2tMGlkVRjNP3Jm4pKJG1H74qymwozZXxr67Ev6TBtDOMB0
	Ra2m8A1yJhwHutQr22Vm+CL8CCdEeoI3ZrVX45H6zlRmsDk6OYq/gapEw7eUiW5RVCQg7A/AQjx
	oJHqQ86zPe3Me
X-Google-Smtp-Source: AGHT+IG+jKrI+ngj4ffv+VF0LWzLOPcORFzjGQ0uVNMC4uSce7tVH3neQYe4uoLz6A6MMSC6nQ+iMg==
X-Received: by 2002:a05:600c:3c86:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-441ac8915ebmr15333785e9.32.1745915190269;
        Tue, 29 Apr 2025 01:26:30 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2aab65sm179544845e9.17.2025.04.29.01.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:26:29 -0700 (PDT)
Message-ID: <e2e7d110d8228bb59e43242c1c36b010cef64c07.camel@gmail.com>
Subject: Re: [PATCH v3 09/11] iio: adc: adi-axi-adc: add num lanes support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:26:34 +0100
In-Reply-To: <20250425112538.59792-10-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-10-antoniu.miclaus@analog.com>
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
> Add support for setting the number of lanes enabled.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Just one small comment below... With that addressed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v3.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 16 ++++++++++++++++
> =C2=A01 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index bf0155830d87..8ff781ab5ec3 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -44,6 +44,7 @@
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
> =C2=A0
> =C2=A0#define ADI_AXI_ADC_REG_CTRL			0x0044
> +#define=C2=A0=C2=A0=C2=A0 AXI_AD408X_CTRL_NUM_LANES_MSK	GENMASK(12, 8)
> =C2=A0#define=C2=A0=C2=A0=C2=A0 AXI_AD408X_CTRL_SYNC_MSK		BIT(3)
> =C2=A0#define=C2=A0=C2=A0=C2=A0 ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
> =C2=A0
> @@ -451,6 +452,19 @@ static int axi_adc_sync_status_get(struct iio_backen=
d
> *back, bool *sync_en)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int axi_adc_num_lanes_set(struct iio_backend *back,
> +				 unsigned int num_lanes)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	if (!num_lanes)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CTRL,
> +				=C2=A0 AXI_AD408X_CTRL_NUM_LANES_MSK,
> +				=C2=A0 FIELD_PREP(AXI_AD408X_CTRL_NUM_LANES_MSK,
> num_lanes));
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -601,6 +615,7 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0	.chan_status =3D axi_adc_chan_status,
> =C2=A0	.interface_type_get =3D axi_adc_interface_type_get,
> =C2=A0	.sync_status_get =3D axi_adc_sync_status_get,
> +	.num_lanes_set =3D axi_adc_num_lanes_set,

Not sure if we should set this. Although it might be in the regular/default
register map, I suppose that this not a generic feature all axi-adc backend=
s
inherit from the base design... So, if wrongly used, I guess it would resul=
t in
a no-op on the backend side.

> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};
> @@ -646,6 +661,7 @@ static const struct iio_backend_ops adi_ad408x_ops =
=3D {
> =C2=A0	.data_alignment_enable =3D axi_adc_sync_enable,
> =C2=A0	.data_alignment_disable =3D axi_adc_sync_disable,
> =C2=A0	.sync_status_get =3D axi_adc_sync_status_get,
> +	.num_lanes_set =3D axi_adc_num_lanes_set,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};

