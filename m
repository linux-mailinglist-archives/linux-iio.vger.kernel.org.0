Return-Path: <linux-iio+bounces-17767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82457A7E604
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64C71890999
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50AC2066C0;
	Mon,  7 Apr 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KekW6HQi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9530206F08;
	Mon,  7 Apr 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042312; cv=none; b=KaOYV8EyjON0imnvkpq5tczAWYDJIR+MegsN+KuKMvpzoNltTVTH8u9w+UnvHawWDD2jsUbIQakgCCMsGfHX0MuoiBb5egJtTA/tnstVBBRVroEWkNHU9xWKQBHJYmikcnmDQYy5gVy8fPUo2QhuTM1UszZF06IiFoCeNzdhYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042312; c=relaxed/simple;
	bh=j6nAIWlPJ2Mt579/3BWBdiFLSeRha6tEMlrjWFO9+gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rdVZ17pTtcY54xfWwe4A083zPfiBXdafstFabHmWFASI65JtVZieNYRD1VN69ELPu3C0S9tq4t/byafeedLGD+/8Oa/Gp5KO1UYAoJ2kbBYLKwE5KopL1GKddO+UOVq3H1mYioQrHJxrxtgsoLWJBUI8OGa0VKteRUxOVO/SvpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KekW6HQi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2762084f8f.2;
        Mon, 07 Apr 2025 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744042309; x=1744647109; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMbSu/2JJxQebSVT3u4zIwPRBWNoxQ1ZlJ2/sPaBDaU=;
        b=KekW6HQiS+MKmIDOzPeL/WLC6iYgHz5jyg54zN1VWvozblKkLp08w9KmPXYVQuWgDD
         79KPvO/ni9VlDCbW4D/DLVafytgRItpisNfx49+QJBTP/hOTY/zIidKj56JJyoc7D7Qk
         whLEO0WF1LOv2hbypgXvKDzrq+ccgUVb/Ida6gOeRHbRClQx8JpJwW7k3wugeYHUAVQf
         gkshsvtLzqUUj91WrRRURqPOqdoxMisAS2/ObpvbFRuYl0drK4lb2zkwnaPV5TU75K56
         mOcHaWorUhQHg4Qd4Yb1XsTd4gYMeq1xxXua8hpbUIH3vLNt+1RUcSCJH2Dr8CC1DsFB
         kG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042309; x=1744647109;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMbSu/2JJxQebSVT3u4zIwPRBWNoxQ1ZlJ2/sPaBDaU=;
        b=q17Lscf6SL2cTSOQhxP6tNT+CrMoOvEW93wNxcztMaOUQkNFXt9TWEnRjviEJYzxir
         S37bpobm1tk4yzBAII5KAii7jMP9qRFzClKh57HBOeNCaB8qjXDDs8z8Lr5t/WXkVXvQ
         oARZu/cCDnAd+soHctv9ZtCxTkepTx8fC1TkET4LxaaXNIH3xrSHv600l+XwwKdHbAGS
         kgYXoB0RGpRnMgrqPMWo1PU68Op7Zv786WIdiH2FJPcl2WpcTqoKiYd3yhuv+1C8eJ61
         yTZZ2JJHrQ7V1pctPUWHyB0+0uTxdTgTNq3Pk9U+IKVxT83RDP/QGZGU8/BLZMo1GZDI
         CpPg==
X-Forwarded-Encrypted: i=1; AJvYcCUnCUPQH7ItJLHrgE4eHxKXKpb55Ma+t48Fq6B9ysoEISCnS5i8aVcRSFQ8qHOCoRUx7672NGZAEkasjgQ8@vger.kernel.org, AJvYcCUuATEWdqvfu7pi3gJBdFzGEbuW3FvkWaLK/tFfbA8KCdPYAiWbyAFky/rd2ViDq2FJpy1vvT2xdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBHxDaaBXwmxTp17Oko6Creg4uAoAKAofLDEWxP0vkOHCZoMa
	DjP/+2QVmDiabEGYrJBZeEcimPKq6qnYlM+HrGbNfFYoWFSMxI/d3W1JGG+wshm3pQ==
X-Gm-Gg: ASbGnctIJj2ZAZsatx4LAeYdWx/cmbrcTauzuOmpHpusJqiXAxdyK/1XecXPk7mcYXs
	iD2YWTrZWj+yugBgVer5Uvh528ksXI/JDdZiHpAW+1wBu6g9UqOZAAcFWM8scqdhw2HolX8PCJY
	Oh2JeLM/EnmckswF1zJpIar0y3nT8mkSSqQ7wtTiufpdlQ5fBEMN37daqiLrgKZsHrFhwcNuMI8
	3wVRzvV3apGlKtq0nT4lU8VY4MfkEfg3JQqD8Aj888z1VcCkk3bdSEXqahUkgUJrkmshIGkFZEs
	xFdcsGyVzbzVo0H7m5usGgKSnsZKDWdXQAwsA6Y3mAFy+PHikbMJxwkRXp45bbNXjuKmYUt5AvS
	tHBzQVYfj+Ewkeinp
X-Google-Smtp-Source: AGHT+IF8q2wsRDs9EK9QgkrSSYAya2EpadIHuWOY9qIlSuuLS1IUrku/c2feNaS+5g5z/qj0zNJDag==
X-Received: by 2002:a05:6000:420f:b0:39c:1f04:a367 with SMTP id ffacd0b85a97d-39d07ad8a36mr9390279f8f.4.1744042308893;
        Mon, 07 Apr 2025 09:11:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342babfsm135689475e9.1.2025.04.07.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:11:48 -0700 (PDT)
Message-ID: <55fea555e7fc756d26220b6c9a06053f8ae5dc56.camel@gmail.com>
Subject: Re: [PATCH v3 1/5] iio: dac: adi-axi-dac: add cntrl chan check
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen	 <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier
 Moysan	 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2025 17:11:48 +0100
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-1-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
	 <20250407-wip-bl-ad3552r-fixes-v3-1-61874065b60f@baylibre.com>
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
> Add validity check on CNTRL_X channels (valid as 0 to 15).
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/adi-axi-dac.c | 24 ++++++++++++++++++++++++
> =C2=A01 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index
> 892d770aec69c4259de777058801c9ab33c79923..f86acb98b0cffb09bf4d4626f932bf1=
edc91
> 1e2b 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -84,6 +84,7 @@
> =C2=A0#define AXI_DAC_CHAN_CNTRL_7_REG(c)		(0x0418 + (c) * 0x40)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CHAN_CNTRL_7_DATA_SEL		GENMASK(3, 0)
> =C2=A0
> +#define AXI_DAC_CHAN_CNTRL_MAX			15
> =C2=A0#define AXI_DAC_RD_ADDR(x)			(BIT(7) | (x))
> =C2=A0
> =C2=A0/* 360 degrees in rad */
> @@ -186,6 +187,9 @@ static int __axi_dac_frequency_get(struct axi_dac_sta=
te
> *st, unsigned int chan,
> =C2=A0	u32 reg, raw;
> =C2=A0	int ret;
> =C2=A0
> +	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	if (!st->dac_clk) {
> =C2=A0		dev_err(st->dev, "Sampling rate is 0...\n");
> =C2=A0		return -EINVAL;
> @@ -230,6 +234,9 @@ static int axi_dac_scale_get(struct axi_dac_state *st=
,
> =C2=A0	int ret, vals[2];
> =C2=A0	u32 reg, raw;
> =C2=A0
> +	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	if (tone_2)
> =C2=A0		reg =3D AXI_DAC_CHAN_CNTRL_3_REG(chan->channel);
> =C2=A0	else
> @@ -264,6 +271,9 @@ static int axi_dac_phase_get(struct axi_dac_state *st=
,
> =C2=A0	u32 reg, raw, phase;
> =C2=A0	int ret, vals[2];
> =C2=A0
> +	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	if (tone_2)
> =C2=A0		reg =3D AXI_DAC_CHAN_CNTRL_4_REG(chan->channel);
> =C2=A0	else
> @@ -291,6 +301,9 @@ static int __axi_dac_frequency_set(struct axi_dac_sta=
te
> *st, unsigned int chan,
> =C2=A0	u16 raw;
> =C2=A0	int ret;
> =C2=A0
> +	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	if (!sample_rate || freq > sample_rate / 2) {
> =C2=A0		dev_err(st->dev, "Invalid frequency(%u) dac_clk(%llu)\n",
> =C2=A0			freq, sample_rate);
> @@ -342,6 +355,9 @@ static int axi_dac_scale_set(struct axi_dac_state *st=
,
> =C2=A0	u32 raw =3D 0, reg;
> =C2=A0	int ret;
> =C2=A0
> +	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	ret =3D iio_str_to_fixpoint(buf, 100000, &integer, &frac);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -385,6 +401,9 @@ static int axi_dac_phase_set(struct axi_dac_state *st=
,
> =C2=A0	u32 raw, reg;
> =C2=A0	int ret;
> =C2=A0
> +	if (chan->channel > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	ret =3D iio_str_to_fixpoint(buf, 100000, &integer, &frac);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -493,6 +512,9 @@ static int axi_dac_data_source_set(struct iio_backend
> *back, unsigned int chan,
> =C2=A0{
> =C2=A0	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> =C2=A0
> +	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> +
> =C2=A0	switch (data) {
> =C2=A0	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
> =C2=A0		return regmap_update_bits(st->regmap,
> @@ -521,6 +543,8 @@ static int axi_dac_set_sample_rate(struct iio_backend
> *back, unsigned int chan,
> =C2=A0	unsigned int freq;
> =C2=A0	int ret, tone;
> =C2=A0
> +	if (chan > AXI_DAC_CHAN_CNTRL_MAX)
> +		return -EINVAL;
> =C2=A0	if (!sample_rate)
> =C2=A0		return -EINVAL;
> =C2=A0	if (st->reg_config & AXI_DAC_CONFIG_DDS_DISABLE)

