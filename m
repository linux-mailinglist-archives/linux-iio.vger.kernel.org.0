Return-Path: <linux-iio+bounces-19003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F271AA75F7
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B614A5A35
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C6257AD8;
	Fri,  2 May 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byYYer/u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952319004A;
	Fri,  2 May 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199634; cv=none; b=Kwnu7dEzaw8B/Df0jwmqBZcTKFQ4OaGAqegdUautJVC8P3r+YJhOQPBEDdCtARdH5aFqpOfII2trLCC2PVoNzsT27WKSvh5IVgwBwh7pSvOGPaMjrxxWzcUQsKGkF+ao3sw78of+5fwsUb8Cyvb9UQ7cpNqLt9Ov9HZIChnk7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199634; c=relaxed/simple;
	bh=nBs8+tflj6uEg2ZUTWkh+I/OmCKtIGvAa5QJaHdIwRs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOxsSr15s33HinzcbhUqWyI4od/8HSA+set7SJ5ggaiLwxIpFMGd3/ibIapKdbNe6auTcyw7/xi2MPt/rgw67qrMIepDSQmSckqrtZJqE78m3+k/82Ph2KB2jKjoZLOuUMsz7LRfDUv+rKzG6yKOqBt5yhT0+gm5vszHhyTNA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byYYer/u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1328591f8f.0;
        Fri, 02 May 2025 08:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746199631; x=1746804431; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTobgBX0IVp/r/O+wf//iQfEXeg53/OfvLV273Y+dD4=;
        b=byYYer/uGHXhEsb5juPUX4gZBhSgW93ShbqrQ4vjxrQEUC9owpGQc4agn1hVmBGkyb
         h54soJcHioCfFPaoygzN22u0be0U5igyvlESVIMQJi+r63xIRvK4uXYtewtonAnuHm9g
         LDgZLTBNJE6a38vqyQRzV9ga5IJMYhocgzGDcDIDW95ahcKmG6Y/NML6YGod0XttH1xF
         O9OshbYakGIBdYbNcTV2OTjSgbj2hMdMedRjaHb4LHSL3CtY8X8dI/lzYV+GPzddmP3z
         DzEjfJIC+8dpynP5Bl4hCthb4KVrZ5cktgyP68H3pMTWG2Rdn26TiUcXbLSyXgvdFGaw
         +yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746199631; x=1746804431;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTobgBX0IVp/r/O+wf//iQfEXeg53/OfvLV273Y+dD4=;
        b=hO/2pe2u+oEw1eYC4612eaj3H7FuiNeN2ls6/YFKbPnVmQ9ksyUGLrtUlQM8YHmIr1
         9LprG5q+U9vX1VCzUmDloqDHzswWRvOf0NGbHYPy3vbrdA6571xNtKrLeuN93ULOl/nD
         yXWDVJxE1YtOZqAiq0k7pEH4kKLutixqpFM0wLagViXVRkK7UHeOxmuSeonSlVFhZBDd
         Lh2XzI3sSxTsKJpJh4IXHdXkSIyQWbjoXmhnMxl7ucYAJLCTlhYZeh82JmXRVFAsOCey
         yNyS7dZb+v2XtpBFnnABrhWc1MzBGnCRMruRNJQIh9oJMyZ79AZh1UDijGfTyATiVz5C
         K2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBjJLDEGN6W2Cs+VO/OiHCoM+BTgbr0gEP74f+4vOopJ29Zu9S7Vv4kMZtEcFgW61omzPNxtlTHP6ZmAUA@vger.kernel.org, AJvYcCW8iXymAcJvKHfuM07IA8iQhWp+fXYDhT7F6B/gtc9zGHnkhkrONF4Y+OZRC+gD5dC9PbVOifPMhGGL@vger.kernel.org, AJvYcCWEV7+dzptF8JnrFnI1ktYwEzJJ3DKqfQ5zYXk5SDh4whbvZ5wdF9+T1+JGcx4cxlweoRzZME/qqA8P@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8sm8om8cNyXHgEZwwWp/mSOUd8xEX981waDEPg1DY00Tu+xz
	6ouniKWcO5o/NlxEGcuIXSfJ0Z0zF+HekEKtA9gdVpMx8caFD+EU1RtE9FCg
X-Gm-Gg: ASbGnctE3vPd7Rc0HctVowANubgbPlSY+JhprXi7nwy2QE5QhGyr20AcD4CjICuLtTb
	jrUG24wFujgOrncQJ1k+bLVDZYKIkLao2G2wJFXFAB03dYSiExYpdmn5fwNGaP0t+QtPFZMfaJ1
	JPDpqNXrHj30lAWSx5XyhRaKUVu7+bsr9IsD45a1K6UgAu/R4qBFYPKDQvTW8iQksbVAYkU7vbm
	PrMRSxYPQP+CAvuBLXH8KJSb3vEjweBHMm1USvzm/QpH0KjTEhLXYjjDgYrjWZLmbWK1k1DB+AT
	uV2HjWRnYRjoAJrjVx29xM75pcMkpYS4O3wZtJva31/VVn24CT0m/rdmvuA4+71A9oPOAJqj+lq
	Ipd4hcOReUGIF
X-Google-Smtp-Source: AGHT+IFhCMd9SFEFUqLVHVXOo/0kYJbXZPh0CEnNNck3T6/fo+RqYVt1MsobTADOrcGOPIBQr2X3AQ==
X-Received: by 2002:a5d:5846:0:b0:3a0:7c88:8f02 with SMTP id ffacd0b85a97d-3a09402cac0mr6347089f8f.1.1746199631032;
        Fri, 02 May 2025 08:27:11 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17074sm2434820f8f.95.2025.05.02.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:27:10 -0700 (PDT)
Message-ID: <6e451bd8d1dec22560162df6003ef067e087c236.camel@gmail.com>
Subject: Re: [PATCH v4 06/10] iio: adc: adi-axi-adc: add data align process
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 May 2025 16:27:14 +0100
In-Reply-To: <20250502085905.24926-7-antoniu.miclaus@analog.com>
References: <20250502085905.24926-1-antoniu.miclaus@analog.com>
	 <20250502085905.24926-7-antoniu.miclaus@analog.com>
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
> Add support for starting the sync process used for data
> capture alignment.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
> =C2=A0- rework data_align function.
> =C2=A0- rename bit definitions/functions.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 37 ++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 37 insertions(+)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 2a3a6c3f5e59..2a79c043c0de 100644
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
> @@ -416,6 +420,38 @@ static int axi_adc_ad408x_filter_type_set(struct
> iio_backend *back,
> =C2=A0				 AXI_AD408X_CNTRL_3_FILTER_EN_MSK);
> =C2=A0}
> =C2=A0
> +static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 timeout)
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
> +	do {
> +		ret =3D regmap_read(st->regmap, ADI_AXI_ADC_REG_SYNC_STATUS,
> &val);
> +		if (ret)
> +			return ret;
> +
> +		sync_en =3D FIELD_GET(ADI_AXI_ADC_SYNC_STATUS_ADC_SYNC_MSK,
> val);
> +
> +		if (!sync_en)
> +			dev_dbg(st->dev, "Not Locked: Running Bit Slip\n");
> +
> +		fsleep(500);
> +	} while (--timeout && !sync_en);

Why not regmap_read_poll_timeout()?

- Nuno S=C3=A1
> +
> +	if (!timeout)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> =C2=A0static struct iio_buffer *axi_adc_request_buffer(struct iio_backend=
 *back,
> =C2=A0						 struct iio_dev *indio_dev)
> =C2=A0{
> @@ -605,6 +641,7 @@ static const struct iio_backend_ops adi_ad408x_ops =
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

