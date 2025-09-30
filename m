Return-Path: <linux-iio+bounces-24580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54462BACDEA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A131924543
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606572FC031;
	Tue, 30 Sep 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIuJDBGy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4ED282E1
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235846; cv=none; b=umdxqQRMGd9/nCJ9jVY5A8XZ7an/f/voQy69ZU9rvznTiZfqeG2r66+mYASQIbudoieMxVIF/0NyRfsiu52C/bM/LAuu/foGZx8LEx/MA02/BcCdiRtoTm4y8NpWKsEwbSpmk1EWUvS/XsbC8ov2BJE+wjvX2oCCS8PsXQhEfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235846; c=relaxed/simple;
	bh=hU/KzLVkEmlUuRTcag5YTyK28/UdejOheaoxAd30pqg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNUy7579cEUsGfYyrxAxDdtcS2GDKthGjtBEoRhQp51odBCCuwgOFyPXIVnmgHpM/g4U3Juod2+78Lyi/5ISYsLSMSJk7bo3jzmIT8VLcvrUQVUztZDlnFllUnpDQys5wPgMDfc1hw8bnlHg+ArRb0br418VCgYF7y9syMpMhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIuJDBGy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7f7835f4478so36319776d6.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759235842; x=1759840642; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqpa9GlvBUx0ux5OfJqrlwK23CiJE3UVGxxZzcBLZIk=;
        b=LIuJDBGyysP96YjMyImAD40n0QC6nnNPTwueJjydjP3hSraXg7U7kZg40OBicjitCa
         w2fOKKh90VpgTZhIrYAqwfb15F+2owhfi8nHKP6K+dTcV7VTtbTIheP8YDqsw8SIAQLT
         UZYEER+e7GcKFqUEcDHYU91167pXRcu5nBlkqTFbZlhvBOLiWeUMxTfWcL/lIQgw14xu
         3zO40majQ7yMO4jCoLZLp4scsSSTybX6sKu39Sm6LpJmtWlS9t8/I4gHHkBba7CwjJyr
         kTk1R/8RhyiYNlZUaWb+mkXajWHS2U1JsJAHpvpj45ll7U4VOILdxZ4pJ/rP3iVhvY4I
         HY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235842; x=1759840642;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sqpa9GlvBUx0ux5OfJqrlwK23CiJE3UVGxxZzcBLZIk=;
        b=F4j4q3+JRGC6LY4HDwIWPff42W3ItBn+iSbIYfHO1kciBuZB2YYwR1/5u62RJdTNYN
         WEfbyBmaIN9pIpcEgzZ8k0a/ZRIx/igI7NFZTTnYlWRgLRW4Z+D1lD7lVHoM9RAREOhK
         vdTC4hdtxIHgmvdYZL4laBAIVOodPdI6FT3z71f+IYk08QrLSWF/lPd8zG52L41CES1B
         4d4q4cUf6SKWGjNCVKRYNDi22vxLQdbmLPJoA7UyiODPDG9a/1zLLL6TJwRHYzLQUs73
         yBicaa17wZRj31H5n7iXSi2fL6xmvjyH1JjJFUXovmEKb5aYeNpWpxLdWXzMHBKI/LBS
         8jVw==
X-Forwarded-Encrypted: i=1; AJvYcCVpEn0uNXLaOgtuih8XqU6ElJ+6qh2zldh3uLnRs0W57YH7sGIBd01Zo2MMFgSTlkqA9qWVC/+5iw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDkSU5tHzRx1UwMvZ0p5K8qdmR6UKFjFqpEPyLsP8tJNVMq6f
	ahXlGGBdS3s1nY9vr11kIc2Pea/Bzf/Nh4OCJaSA8K58tENeJXFiXbw9
X-Gm-Gg: ASbGncv+YaDY/npaSAOYrToQXYlw3cj7GOtutDfA3OUm9+5f28TdratqAxiap/lQDVs
	JcZoTOsgAXe12w9TK+dkxYQkzDBWE42fRVKN6mma/ZEw94yRMEMOuh7GqWW081Oem7n6deHf5xS
	h3+UyHiMFz+g3UAIkPFLkugTo6fOyLYbyFTHiB2b3VloU1GbcXW1bwPp8+5QKr8VmWFTB+nAAKQ
	W5sGCvrahmgXEJMAExe8bVjfpPH4uAdUcTJiVrQATdURQ6abzdXCrycsIvbL01HhL6AFvcIaWZj
	PUmliAUF3E5ARpnfeL/p08nnmJblUhaGf4k+aS9efVY8vbcdp3sgZIhLGrvT5N6vzcj1rXwDXqo
	NQHkb++4Ek1+zQVpJSK9wavtNK2Xc8PlKZyjCp14EtBEpipvwB2wAiEcSjwl9w6ZdAA==
X-Google-Smtp-Source: AGHT+IFf8Ujmddz9wnW3knoT77L/BwOAbC4cJJ4thEw7Ws2bZ/MuIegRBffbh8umm4/lPsVvwVM8Dw==
X-Received: by 2002:a05:6214:2aaa:b0:784:4f84:22f8 with SMTP id 6a1803df08f44-7fc2d330151mr308896346d6.21.1759235842055;
        Tue, 30 Sep 2025 05:37:22 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80136c84338sm93345146d6.10.2025.09.30.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:37:21 -0700 (PDT)
Message-ID: <22eb04cd1337f155c8c373db81d4e1a03380f395.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad4080: add support for AD4084
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 30 Sep 2025 13:37:48 +0100
In-Reply-To: <20250930103229.28696-4-antoniu.miclaus@analog.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	 <20250930103229.28696-4-antoniu.miclaus@analog.com>
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
> Add support for AD4084 16-bit SAR ADC. The AD4084 differs from
> AD4080 in resolution (16-bit vs 20-bit) and LVDS CNV clock count
> maximum (2 vs 7).
>=20
> Changes:
> - Add AD4084_CHIP_ID definition (0x0054)
> - Create ad4084_channel with 16-bit resolution and storage
> - Add ad4084_chip_info with appropriate configuration
> - Register AD4084 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v2.
> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index fa15b8f63b8a..a68d7fa9f977 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -126,6 +126,7 @@
> =C2=A0/* Miscellaneous Definitions */
> =C2=A0#define
> AD4080_SPI_READ						BIT(7)
> =C2=A0#define AD4080_CHIP_ID						0x0050
> +#define AD4084_CHIP_ID						0x0054
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> =C2=A0
> @@ -435,6 +436,8 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[=
] =3D {
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4080_channel =3D AD4080_CHANNEL=
_DEFINE(20,
> 32);
> =C2=A0
> +static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL_DEFI=
NE(16,
> 16);
> +
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> =C2=A0	.product_id =3D AD4080_CHIP_ID,
> @@ -445,6 +448,16 @@ static const struct ad4080_chip_info ad4080_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D AD4080_LVDS_CNV_CLK_CNT_MAX,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4084_chip_info =3D {
> +	.name =3D "ad4084",
> +	.product_id =3D AD4084_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4084_channel,
> +	.lvds_cnv_clk_cnt_max =3D 2,
> +};
> +
> =C2=A0static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(indio_dev);
> @@ -598,12 +611,14 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> +	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ad4080_id);
> =C2=A0
> =C2=A0static const struct of_device_id ad4080_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> +	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ad4080_of_match);

