Return-Path: <linux-iio+bounces-24581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A2BACDFC
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5191926EE7
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AB2FC031;
	Tue, 30 Sep 2025 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQtAKHSU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B3282E1
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235872; cv=none; b=Xu7yIfd9+0raFmel3Xb9DfaNKcgc6LFZbuL2toPWjx+XtO3kGceb3EyghEMKoCpwtGxWXdfOjqy8X6oqzRkQwEWwTsdQgzoE0uFRGXpamstei6i7M3ao3MH+A6UUXmtchnMsiSWGuyOHmHW58DiPuPDhHy4KQNaQ7kvksOY+a+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235872; c=relaxed/simple;
	bh=uURFXlGNdUF+Jg1TXYTFrqJ+6twXM+PGQp5QmOEoIKk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4Zow7Tw76HmAct9CkGoeXx3m0PoWj7GxFZ3rC9DltRBTy/obhAN5VpGv/5x0lPqw9E7Mo2tL7iDfabIDvLU3EMn32NqQnQ1PxwZ0rjWFIBRBCs2S4XhfucIR+S19yZgLwCPNIBA5hHPpfcCUbSDR4FQN8fQbop2IKA2nt/Sx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQtAKHSU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso39831025e9.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235869; x=1759840669; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLjriQ23LoYJBTD+XC8CsUOd9ht1tU8OnhQ3XQhiqo4=;
        b=EQtAKHSU83Tpa4t/QoGuC/4RvX4LFsXFTfVU1gmm7h87Nn5pURf+DhwMs6ITfvN9TH
         wkYM845aM8nJHD8srMu0EbffXkMlLXm943mXv3b3S15AR9re8DTIDhbtYCLIOXEQNpyp
         nHrDoocd2sTH5Rkk3dmZsdqtgMxS1eOcwYqRYog7wXMNYHM4i3/yS7j0qu2JHqIOVepI
         JliBgHK/3zmopGrHxxvYz+9NI2Vv4393wDhHL09EUKtHDfRV6qiKhS1TjmTbEDR8bwAg
         yo3VRxo6nVOPmCSRdTCNW3oTVqA9UwWmTfjPt/fd+vSwXVLtZABVFJHaXdUYra6mbhCB
         bNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235869; x=1759840669;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLjriQ23LoYJBTD+XC8CsUOd9ht1tU8OnhQ3XQhiqo4=;
        b=bOettIFFrXcKRiX9U1rVg/Enf1B26T9vchEpkneckmMbC0bmFoeOpfOu7J0gnAhdB8
         4pn/c/n8cs3R91Yf8Wl6dIx+nuPpW7mjH5Gt73kPPHvtKQSzsbNXxNFw/18bkRw0SUgN
         XhbUqQMYEKJjUUQFyWdNJDSVrz9vIAzeCnBxjt55000E1buSQ83FTkg19AwTIqIhvREH
         s9Dxk0UiVQtbxI8JTIWo41W6U8RM1Ww2IC9rfLLyEE7Hz7iYBO8lqQyeu3PXrb+wvl0P
         9QlIsHGa2yMftnkkiE67CQeIoFdmDb8j+AV4i4RjCZaoLTgcF6hT3Z+tFuOCaRdRIrVB
         AiQg==
X-Forwarded-Encrypted: i=1; AJvYcCX8EL6rQh4sec9ft4bjYpGUWVop8JxLPXiM+jpay462KfcgXACONnVL/CZpBPQhAjEl2H6H6scgmMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9L0cqbqxSaSRXurh0rjomSDoyWBHDEfcsZTgS/UiKHu4zEUMu
	3IOM0JYC+Dpsu6FsIVL2iRxkWU8BlJ4CdEnhos0IKAne1279GaI6D/I0sXQz5+Zf
X-Gm-Gg: ASbGncvxaLFWTXKS7IQ+2Kcoq9NedO8HwCq3H1EXuJefKlsDwZYqqOKdcUIwFb3FgS7
	ko2vTJV65IqG/VQLZC/+6eNKR6CAPA9oOzZ7+e155tr1mTgpr2SrnnDGgmaYPEroPzEV3Lyp2Eg
	C6Cc1g/o4UfSJ0hsoVMbwjqLOKlR9LLbVY9aU8FGdSkqe/yyvWnVFtkICJqecTcySHpKSjWzog2
	NLao3n1fSnTLW/qO61eQ1Mob+0VRGsPL6oXrwModJamhtTfY05FPGSxaXZEZgHKoxcc41PwO1Oz
	6i9axm4SVfYYfeQ8LRt50KWwxccyi1Al0cFcCJ9xDwhsOLLI45kAsTY8IDIEPsuVub6uBTM3sue
	r91OHkE2Wh5wUXhaqWHMeulm824yDKWxwy18ZYI6IIZemgyDvrFq7NoJ8IgzNYHl+tA==
X-Google-Smtp-Source: AGHT+IECObCjBC1Gx71Ul7SlexRt8RMp9HMCWyDMZeAgaOWRLxuItpHqqG0Vs1EwsrRrQaMmFsEAvg==
X-Received: by 2002:a05:600c:1c93:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-46e329bd24amr173160135e9.13.1759235868804;
        Tue, 30 Sep 2025 05:37:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm22459235f8f.18.2025.09.30.05.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:37:48 -0700 (PDT)
Message-ID: <325bcbb1f36ffa68c48423a623ca2815ad0ab3d3.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] iio: adc: ad4080: add support for AD4081
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:38:17 +0100
In-Reply-To: <20250930103229.28696-6-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
> Add support for AD4081 20-bit SAR ADC. The AD4081 has the same
> resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
> maximum (2 vs 7).
>=20
> Changes:
> - Add AD4081_CHIP_ID definition (0x0051)
> - Create ad4081_channel with 20-bit resolution and 32-bit storage
> - Add ad4081_chip_info with lvds_cnv_clk_cnt_max =3D 2
> - Register AD4081 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v2.
> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index a68d7fa9f977..0dcbf175523c 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -126,6 +126,7 @@
> =C2=A0/* Miscellaneous Definitions */
> =C2=A0#define
> AD4080_SPI_READ						BIT(7)
> =C2=A0#define AD4080_CHIP_ID						0x0050
> +#define AD4081_CHIP_ID						0x0051
> =C2=A0#define AD4084_CHIP_ID						0x0054
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> @@ -436,6 +437,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[=
] =3D {
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL=
_DEFINE(20,
> 32);
> =C2=A0
> +static const struct iio_chan_spec ad4081_channel =3D AD4080_CHANNEL_DEFI=
NE(20,
> 32);
> +
> =C2=A0static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL=
_DEFINE(16,
> 16);
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> @@ -448,6 +451,16 @@ static const struct ad4080_chip_info ad4080_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4081_chip_info =3D {
> +	.name =3D "ad4081",
> +	.product_id =3D AD4081_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4081_channel,
> +	.lvds_cnv_clk_cnt_max =3D 2,
> +};
> +
> =C2=A0static const struct ad4080_chip_info ad4084_chip_info =3D {
> =C2=A0	.name =3D "ad4084",
> =C2=A0	.product_id =3D AD4084_CHIP_ID,
> @@ -611,6 +624,7 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> +	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
> =C2=A0	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> @@ -618,6 +632,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
> =C2=A0
> =C2=A0static const struct of_device_id ad4080_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> +	{ .compatible =3D "adi,ad4081", &ad4081_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};

