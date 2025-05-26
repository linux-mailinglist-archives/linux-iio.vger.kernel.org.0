Return-Path: <linux-iio+bounces-19928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38B6AC3D6B
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6503B926E
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 09:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D621F4180;
	Mon, 26 May 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8JNiJE4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFB1F2BAD;
	Mon, 26 May 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253299; cv=none; b=ByinpH3tWAtHvh5Z6RvrZRFNFsXpO96GeAG66d8WEnnQocMpV+V6RDawCc7cTJdkP5aLbH7hv2fIjfrT8fCUYMViFLtM0yyg/Re4YOxZHZtW8j31ZdcKtFF6EEHWGl/oLKgLleyd/wUZWCVWcMj+jyCx4awSLtrbxCfTafqX2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253299; c=relaxed/simple;
	bh=DV9fo1QJ9o33llm3oByD0eUmB5t1QypzmzxMjT0n0Js=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5chc4yGftu68JLkKbyVu7ndrWEokKdwvqir6w0HJzKEbrtujvHJEio2rt4XplMZTaRzpB2aPPMFklj0HLUnu1kKkdLYK09JfR6Yz7EnpEHCrxJ4hUFxizeVGUPWpqem6woklG0crbUnf4C78fUwVV9lY/Ynk97JWkkkh6UMYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8JNiJE4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ede096d73so15379745e9.2;
        Mon, 26 May 2025 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253295; x=1748858095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWMuQTPChwmI/mYhfF8vcBlbQcUCmHW+2VunyDtpFLI=;
        b=g8JNiJE4FbymuJ/cYxQErkG2CKZQsek4OOHlmCP+ykGHK8VOOs4auxtQfzYZW5/pxK
         gFRP5xw51n3PqgJMUIP5ROjuL1ze8UuXz5iGeZyqFpXGGl2S7HcpZjK41RY3GDSv5VCX
         uyQqddOaCv7pZXzLoqneScocMtKJULcTMFt0qeL07jxLCwmNgF+24YTi1YH0EottRemO
         y4JaROrYevbVYMvmnf58KSadtNfenfOareuKsMoCbSrr0aXoHlCv/HFn3bzKdX+dh6m5
         P6UUL8Z57pGMiyo4VIf5vwGfLO3/FL6v1tmpFdrkg2OJf6ZrDewaAOlqWgYAmJDN2Jjj
         tnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253295; x=1748858095;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWMuQTPChwmI/mYhfF8vcBlbQcUCmHW+2VunyDtpFLI=;
        b=KfV9urHBNX3zhJmNOVG2O3FgCxetmkB644/Z9+2M6lDflRvZta+5/kz1RzCRVZGfCx
         3qc4FGKlhy3gF7gAgjFzXuCW3tWM/a0WQ+5S+9hQZDOcCwZZGZDHyi2E76hzCS/+ho7O
         E7FUShsiOymNkByf6bUY9pc/7emBE1hoqUUFPW8LSeLzujJvZSMUP9SKfQlW2jslB66P
         hDY0KnAoEq2fD8AGPJ1APNFMhMeMzoEys5shErc8tlkXnu5rPqW3dMZXsFqzgeMnqxWu
         CUstv1evTvoAjJnVaSm8BLqVveyO3WmWbPQZdCFi6Efs3Y5ixttW6bJ3nLjYrMEXWQ9e
         242g==
X-Forwarded-Encrypted: i=1; AJvYcCUqZL7WiC3VnUaCUKCar5w2oNowQMtIL35dUcVDQxL0SDjQL9isk+c30s8keUhfayWkQeOqk2eVBEsz@vger.kernel.org, AJvYcCUu2CpAhg0WVMa8MWogWA4PMT3geHOJzbm2hvaV7hq+JHMpmfRZYfAoB10kUjaQJGN1u8zFmFE9BfWoDMI9@vger.kernel.org, AJvYcCXJm/g4zJ8oeKeZKE8TaNakqG3cRVLmjOT5g2M8158WD0ajrGmFiZtxUz3ZI0ssSgA5FzBMFvLiVZv1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7qHtKiaIbA3ExO0iN/X9T7ZWAzBfAHYif7YB3M0hvdHuwhHp
	3uY6VemZ1k5C62UqUjNCs4Zf3oDJfG/UWZ0/lmdcGIY3flPOlHcLlBfE
X-Gm-Gg: ASbGncuKU/W3woBdINKbQIfb9mEz0+sp1oXEu45PaNorfD7KHWj2nzK8RZmrH4uNuBs
	3Wi8TrhaauM6wHsY3H0NHhyV0pmhixw9ywsjktvh0VMyupv5rME7XmMnXL6vD/8KEeb4wpUr0nG
	3Q4aaFENMS1NiP46Zppr0tiGY85sQGXkFcOIZiBWjbESKPJWgGtvbDCklHC7fcl4F1pNpAT2mKt
	6njvzUki/qB1r/q1YipKEjxCKE0GFbfZ0B6LtQsi7gV3mYxXHDfWwj1VdRhQSMLR+TDQLgwW/ph
	0CEJk8wuFogvynpyjtE0HClvb7fWBjrOJPZwj90HNxLoFXFrUnRSWGPk
X-Google-Smtp-Source: AGHT+IEz9Oz21A6/KvF3Gmrl5xw1wFfxKUNmyQaL804hL3PhzG0FCyAC+Ql4cLHPzQh1wJU+UescOQ==
X-Received: by 2002:a05:600c:648a:b0:43c:fa3f:8e5d with SMTP id 5b1f17b1804b1-44c9141ab42mr80019605e9.2.1748253295521;
        Mon, 26 May 2025 02:54:55 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0ac6sm233626755e9.15.2025.05.26.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:54:55 -0700 (PDT)
Message-ID: <745b3b220a8c8aec47b54fa5931a5c6334554ed5.camel@gmail.com>
Subject: Re: [PATCH v4 3/6] iio: adc: adi-axi-adc: add
 axi_adc_oversampling_ratio_set
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,  Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman	 <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>,  =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?=	 <joao.goncalves@toradex.com>, Thomas
 Bonnefille <thomas.bonnefille@bootlin.com>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 26 May 2025 10:54:58 +0100
In-Reply-To: <20250519140220.81489-4-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
	 <20250519140220.81489-4-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 17:02 +0300, Pop Ioan Daniel wrote:
> Add support for setting decimation rate.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

And with the requested change:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v4.
> =C2=A0drivers/iio/adc/adi-axi-adc.c | 20 +++++++++++++++++++-
> =C2=A01 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 4116c44197b8..0b8673668745 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -80,6 +80,9 @@
> =C2=A0#define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
> =C2=A0#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
> =C2=A0
> +#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(c)	(0x0424 + (c) * 0x40)
> +#define=C2=A0=C2=A0 ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK		GENMASK=
(15,
> 0)
> +
> =C2=A0/* IO Delays */
> =C2=A0#define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
> =C2=A0#define=C2=A0=C2=A0 AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
> @@ -242,6 +245,19 @@ static int axi_adc_test_pattern_set(struct iio_backe=
nd
> *back,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
> +					=C2=A0 unsigned int chan,
> +					=C2=A0 unsigned int rate)
> +{
> +	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> +
> +	return regmap_update_bits(st->regmap,
> +				=C2=A0 ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(chan),
> +				=C2=A0
> ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
> +				=C2=A0
> FIELD_PREP(ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 rate));
> +}
> +
> =C2=A0static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, u=
nsigned
> int chan,
> =C2=A0				=C2=A0=C2=A0=C2=A0 unsigned int *status)
> =C2=A0{
> @@ -381,7 +397,8 @@ static int axi_adc_ad485x_data_size_set(struct iio_ba=
ckend
> *back,
> =C2=A0}
> =C2=A0
> =C2=A0static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend=
 *back,
> -					=C2=A0 unsigned int ratio)
> +						 unsigned int chan,
> +						 unsigned int ratio)
> =C2=A0{
> =C2=A0	struct adi_axi_adc_state *st =3D iio_backend_get_priv(back);
> =C2=A0
> @@ -549,6 +566,7 @@ static const struct iio_backend_ops adi_axi_adc_ops =
=3D {
> =C2=A0	.test_pattern_set =3D axi_adc_test_pattern_set,
> =C2=A0	.chan_status =3D axi_adc_chan_status,
> =C2=A0	.interface_type_get =3D axi_adc_interface_type_get,
> +	.oversampling_ratio_set =3D axi_adc_oversampling_ratio_set,
> =C2=A0	.debugfs_reg_access =3D iio_backend_debugfs_ptr(axi_adc_reg_access=
),
> =C2=A0	.debugfs_print_chan_status =3D
> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
> =C2=A0};

