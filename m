Return-Path: <linux-iio+bounces-11462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CE29B3187
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8498282BB1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3221DBB2C;
	Mon, 28 Oct 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRds89C5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BD18A921;
	Mon, 28 Oct 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121630; cv=none; b=Ceag1DYJUnRDCZDfxSZIJ40k5LINURP6wrTGVA5BpuydPdP/kZBH7jB3hAjJvtUndderhHjO2KasYIfb2XEx9L8IPKe5YarcQxsr/2qDyPmKwPpqh3JuJ/3RGb2kDtID3Pn72MugjaydtEhoWO58QLpEE7cZJidV8DAcgCMuVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121630; c=relaxed/simple;
	bh=5vTWdXkFAFJXuOpfjWd/sBDvYteH/Lk+r86USHZo73E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pbrC1BmRNo9q/OyB80WYuyN33264ld8ynlgtZiWppBYQKtg04+dwCoLVzQ1ltKITozS+HjAzVrToPxNHGRthUcndGiMMXtS7W619CiauoPmFHrynKoHDFj737dhGYNXFvZGkDorxj/Y57KbEhXnUX+mp9fPsGXe5aVXdqic/TDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRds89C5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314b316495so40163485e9.2;
        Mon, 28 Oct 2024 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730121624; x=1730726424; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r+1U9XCKxv3c9TJtgNKZ57QqTtYuIGktFC2ML/OSMqc=;
        b=WRds89C5lwRBPmw7kBICvKU8TKFreaiyYpdjcY+E01kvGT3DOyn9RATLlO5HyA7HLn
         +FZeZiv2v6j5YN/qgwPWq/o9Q1HeJA0d6upIZh3hq2A3UiWBpT4MX2QWREDuRxM0efkp
         A3e/QJSh1GoVaFiQoIaC4UCXHUzBf6xkV/im161LxpQPNO1lsPlIllQ6YnmXRsQwF1k1
         1CcpL7GjVVsD++tNUbIsgz7deoSHRQvdovgIPRETTdzlJ9KAQ5E2d2S9uENzgXIUogkd
         ZQ/TOJg0amiZu0AVGMMY/3SuwluxrTaV1WumYIv/Ii+uCtWYT7ugPI5MtJ6vDaRIj0rB
         ka+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121624; x=1730726424;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+1U9XCKxv3c9TJtgNKZ57QqTtYuIGktFC2ML/OSMqc=;
        b=azfMdX/xVzGakBtbkpzrWLTVLhioyXJUogMAvjCt6jShNS7n9oZzoyLVfUF34D+woG
         qMxU3C1Ml+UokXFju6l+INkKWX3TMr5xfhZ2eR4TxQ10DodUoHBxEUpJGjjUWZ3wLup6
         GPRebQq2wBjoAmRm+P+uF3OJGhuqdouH4FghPKA/45C7cQlMFFZYgfoJyFDMGwjtUS9W
         IdVYfEecDtzycWjR7akTRFt/ZlpNooWWxltFpEBQANz3S55o5NkvWhFc8a8XIdCgc668
         FkkjfUFZ7d8AK/j5bfQy0GbbDsSek4ALwk6T8xvOpLiWH5srmeaYGUkoRi7qTxrmSSwB
         q2tg==
X-Forwarded-Encrypted: i=1; AJvYcCVYwfIUJ7HPGM97nPDB+ErnJWJsZk+cwLTXGpUUJjzTggctODAy7QDRaJfyawa/QEboLsy4fj7sqKbfGI4B@vger.kernel.org, AJvYcCX+Gpo8k3NosgmXzPknu469cnozhNSoOJW0Ka4ZkNkHm2lcvQtrQGT8hZuT0I8OmJJMVEKQ8U9P/S57@vger.kernel.org
X-Gm-Message-State: AOJu0YwSC+x1p6qfK1OY+Dql2eLfPgPAFEnF18yg1WgJIUiH0qR/LW8V
	9tdTlwl8uvvqGkTAytYPgcQ3h8WeXBVnAc8MdtvOWKePip+3wpuJ
X-Google-Smtp-Source: AGHT+IGt6ZwqtTltYNjjced99Ih2ZKZpE+sPRBXodcOjqgLwI56gzvPIpNCyWukoA9+KflTJ9Uv7Bw==
X-Received: by 2002:a5d:6206:0:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-380610f4bf3mr6285163f8f.10.1730121624253;
        Mon, 28 Oct 2024 06:20:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56facasm139014615e9.33.2024.10.28.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:20:23 -0700 (PDT)
Message-ID: <ec00354792bf076d72875a57898a55ac648bd1b5.camel@gmail.com>
Subject: Re: [PATCH v8 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	dlechner@baylibre.com
Date: Mon, 28 Oct 2024 14:20:23 +0100
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-4-74ca7dd60567@baylibre.com>
References: 
	<20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
	 <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-4-74ca7dd60567@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 11:49 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend AXI-DAC backend with new features required to interface
> to the ad3552r DAC. Mainly, a new compatible string is added to
> support the ad3552r-axi DAC IP, very similar to the generic DAC
> IP but with some customizations to work with the ad3552r.
>=20
> Then, a series of generic functions has been added to match with
> ad3552r needs. Function names has been kept generic as much as
> possible, to allow re-utilization from other frontend drivers.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 244 +++++++++++++++++++++++++++++++=
++++++++---
> =C2=A01 file changed, 230 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index 04193a98616e..148e40a8ab2a 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -46,9 +46,28 @@
> =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> +#define AXI_DAC_STATUS_1_REG			0x0054
> +#define AXI_DAC_STATUS_2_REG			0x0058
> =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> +#define AXI_DAC_UI_STATUS_REG			0x0088
> +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)

...

>=20
> +
> +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u32 =
val,
> +				 size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 ival;
> +
> +	/*
> +	 * Both AXI_DAC_CNTRL_2_REG and AXI_DAC_CUSTOM_WR_REG need to know
> +	 * the data size. So keeping data size control here only,
> +	 * since data size is mandatory for the current transfer.
> +	 * DDR state handled separately by specific backend calls,
> +	 * generally all raw register writes are SDR.
> +	 */
> +	if (data_size =3D=3D sizeof(u16))
> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> +	else
> +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> +
> +	ret =3D regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> +	if (ret)
> +		return ret;
> +
> +	if (data_size =3D=3D sizeof(u8))
> +		ret =3D regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B);
> +	else
> +		ret =3D regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> +					AXI_DAC_CNTRL_2_SYMB_8B);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS, reg));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read_poll_timeout(st->regmap,
> +				AXI_DAC_UI_STATUS_REG, ival,
> +				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) =3D=3D 0,
> +				10, 100 * KILO);
> +	if (ret =3D=3D -ETIMEDOUT)
> +		dev_err(st->dev, "AXI read timeout\n");
> +
> +	/* Cleaning always AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA */
> +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> +}
> +
> +static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *=
val,
> +				size_t data_size)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +
> +	/*
> +	 * SPI, we write with read flag, then we read just at the AXI
> +	 * io address space to get data read.
> +	 */
> +	ret =3D axi_dac_bus_reg_write(back, AXI_DAC_RD_ADDR(reg), 0, data_size)=
;
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> +}

Just noticed now that both reg_read() and reg_write() should use the lock. =
That meas
having an unlocked helper of reg_write. Other than that, LGTM.

- Nuno S=C3=A1



