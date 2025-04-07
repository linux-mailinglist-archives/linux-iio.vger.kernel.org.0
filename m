Return-Path: <linux-iio+bounces-17769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF6A7E646
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FD34231E4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E1208990;
	Mon,  7 Apr 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azkGcDLR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA91B3934;
	Mon,  7 Apr 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042428; cv=none; b=d/d9BHSZJZ57Fbf4G9UoByD6Faulx7e7FPmeN8VMejCRMN5sxSKprop10fM+aYSITgubqrw246aeI0wps8k9fBjoHbMNLI9pX5HBus6svx1u/wqGkzxfayEgaTc//RWtLlgn/J9YjDgwU0ArNQ6MJEKgWr6f4iK0kpMIeSif7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042428; c=relaxed/simple;
	bh=p2zobvi7rWLFeSuUW0t9mkfYAvLLJwM3P3t01NCBP3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EDgut0uWS+6HFEtpBu7fUiylq60DyMXPF5VXKFs7848YADk9m60dyEXBU6+ydCr0GVqjZOgN+b8+p3TwbbKMWpeq3BH9KLkJcdVHCRvbxXmoeF0p9T+rwppcsXlrOw5PdCWqqHOMENLUHTsMB3wQLDFEnTxA/BveaVWRFi8NOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azkGcDLR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso42627165e9.2;
        Mon, 07 Apr 2025 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744042424; x=1744647224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70LGfavtABLJLsgIq6Bm88SDdFJG1TJDo/u2Aa0VN/w=;
        b=azkGcDLRakHzIGjEPd5CePOJ2tSA1cESxCWZNsZ5zdu/2I/Vu6+4+oy1ErssUVWg5A
         27t97hhkKtfB+Wxpkw9F9AcVmYYwXCj/4l7be1e0L8jht2KHy0In+1dopcpt8V30OFt9
         AdJczDb17ZyMXSPnsVsFxVZcMrcoR5lRkYpLGvFkvKCX7UfE87p0PTj45sIZwGiKu0Hl
         uzbyvtm4AZ9ybx7NozMGXfLs6yqe0zj2O0k9iQKL/FZBOPfvYv29Z9xIBE87x3edUoL+
         D6wcoCrsGvcVPju9iKOtb92IrglvsjXxkrCEP6aGTkhd1WQtL3HPTIZVAtg6aeoFdFaK
         xy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042424; x=1744647224;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70LGfavtABLJLsgIq6Bm88SDdFJG1TJDo/u2Aa0VN/w=;
        b=D1mpjjAFbpWs8B+oqkdFJRkJX8y1dJk9Q9d3MTZRsoPDCHU4IlYoNfH4OBCd82IyqU
         K7Jgk5Jod3TPRgBkaireXGTpM0O55S8HM82bKVRefRkwv/MpRidMWJbM04PYyFuOBcIF
         PbPd9NsBQYzC9a9VN6RQUYiVmSVC70vUOo06D5Aks0WmJx5QuTKWCrRFon6iwFKra4iv
         CghmREdEDtCM5hoWjyF+A0BIY8HZpVaJ6jN5FajCAjugM+zfvmUxF5OVCyUlDvHHdkGU
         a/VvZQiKh1RVq0EatsoPnai7uadKDbKDjgnGeWH3fmTgKGezBO1+qH4QlWHyvz1zJ/OQ
         64Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVNP5YgI73SGWvGaNxxOd71vzxPbCjhr+OEq/pO0/hLqFCytdb/0i7Fii0EgtzEqDcrsaPQ/uRzAwFP+V2g@vger.kernel.org, AJvYcCVvRcCQZe7oE611jpRaz/7XY4Eo3RZEg2if54LZ6qlvG9B4rNicu+VsEYBtwYYFyCUOSg5O/8ycCBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QgQdEoylfkYrCpNzxU+7ns+1sfjXpaiiDvi7+VwbcQ+/m9oH
	dIz9M7PcW66P5ypV3EpvtoLs0Cb0cAojATq84NgQH9u8/nmQzYo6
X-Gm-Gg: ASbGncsgVF8icgLff52XR/FopZiTEwVV3vKCGlmcKr2+0SHB6lYvruK63a/V2Fc2ZRA
	GqyNcZbX003ov5Aoz/2aGfguwHlLEVJKxUbp/bGTE2gfF0Dzvk0abAwWy/ZMSiT+27Yz4biO34L
	q0NSfVd5MKvoKR1TZ7jWxfYrrwAoZdfDROB58j01aeBsivdwM10EBJN3O9SKDocXCnB8fbdUHGx
	2gNgPWyc/1hILYWdFd+brPHwF/T97VvyDhQBprWNXJ8DdtssQHYOL4zqEIqJRGKCs2DGDk7iM34
	2Sr6/7d3fzdFtx2XWyEvgxdY5E3w54kFWZvVmgLYmysAS431E6e/dnPgI63pQNezG4KjCw7efot
	Hv+Src1oG2rkK36st
X-Google-Smtp-Source: AGHT+IF+LRS5kJ8HAD2cz4rJeC67p0ChUWXfOfl/gjpqN8sIiWg6owJ812B5obdplJyggnWpsz9FxA==
X-Received: by 2002:a05:600c:5124:b0:43c:f3e4:d6f7 with SMTP id 5b1f17b1804b1-43ecfa18f8emr125832185e9.31.1744042423705;
        Mon, 07 Apr 2025 09:13:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b6321sm12278444f8f.44.2025.04.07.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:13:43 -0700 (PDT)
Message-ID: <b0c6eb83a052fe6e1656d47e118b1e70336e38d1.camel@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: dac: adi-axi-dac: add data source get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen	 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier
 Moysan	 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2025 17:13:43 +0100
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-4-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
	 <20250407-wip-bl-ad3552r-fixes-v3-4-61874065b60f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-07 at 10:52 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add data source getter.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 30 ++++++++++++++++++++++++++++++
> =C2=A01 file changed, 30 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index
> f86acb98b0cffb09bf4d4626f932bf1edc911e2b..8ed5ad1fa24cef649056bc5f4ca80ab=
bf28b
> 9323 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -536,6 +536,35 @@ static int axi_dac_data_source_set(struct iio_backen=
d
> *back, unsigned int chan,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int axi_dac_data_source_get(struct iio_backend *back, unsigned in=
t
> chan,
> +				=C2=A0=C2=A0 enum iio_backend_data_source *data)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 val;
> +
> +	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> +	ret =3D regmap_read(st->regmap, AXI_DAC_CHAN_CNTRL_7_REG(chan), &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (val) {
> +	case AXI_DAC_DATA_INTERNAL_TONE:
> +		*data =3D IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE;
> +		return 0;
> +	case AXI_DAC_DATA_DMA:
> +		*data =3D IIO_BACKEND_EXTERNAL;
> +		return 0;
> +	case AXI_DAC_DATA_INTERNAL_RAMP_16BIT:
> +		*data =3D IIO_BACKEND_INTERNAL_RAMP_16BIT;
> +		return 0;
> +	default:
> +		return -EIO;
> +	}
> +}
> +
> =C2=A0static int axi_dac_set_sample_rate(struct iio_backend *back, unsign=
ed int
> chan,
> =C2=A0				=C2=A0=C2=A0 u64 sample_rate)
> =C2=A0{
> @@ -818,6 +847,7 @@ static const struct iio_backend_ops axi_ad3552r_ops =
=3D {
> =C2=A0	.request_buffer =3D axi_dac_request_buffer,
> =C2=A0	.free_buffer =3D axi_dac_free_buffer,
> =C2=A0	.data_source_set =3D axi_dac_data_source_set,
> +	.data_source_get =3D axi_dac_data_source_get,
> =C2=A0	.ddr_enable =3D axi_dac_ddr_enable,
> =C2=A0	.ddr_disable =3D axi_dac_ddr_disable,
> =C2=A0	.data_stream_enable =3D axi_dac_data_stream_enable,

