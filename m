Return-Path: <linux-iio+bounces-17607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F69A7B009
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F2A17F6E8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 20:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E6267F67;
	Thu,  3 Apr 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2HMpOFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F8254877;
	Thu,  3 Apr 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710218; cv=none; b=BBoZiN4dXpC0RAy+V5U++Mj1pJ9dRmGwwx4dfO6KPPhC7knCUO/euH7566B5w724moBEVQFs35FFdCMNhAFdphB4I3MCpjYD6ELqnfc0DjwA9mTu5QXFMcyUrQRcrlZ4ntLgz10pFT/aU7GGJBnSi+ppzN9o9wCVApipV6kHpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710218; c=relaxed/simple;
	bh=PID3d4y9f57Y22TvvV6kIqY3Te0gLn3y0baDNVs4nkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdXTf3qzhZ0zzqCk1+rOhsqHbYLI6TSkxadpbd8OSt6DSSK+10KHCe2CgyKtRb+3QwNSOple45FVvFaVfIOJpUY21Kng+s9d6S3OsOa5tnm6ixrhsH2Ny1qu6pU2imqN5agoNl1bHo5PSZT71tELtKynf2HgtcdeqmAM1FMS2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2HMpOFR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso6425485e9.3;
        Thu, 03 Apr 2025 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743710214; x=1744315014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJb/2QaqcIYtpNBOB7gB82icRcHj50AQYqYnKr/nk4M=;
        b=a2HMpOFRa/yWUfBOwCInZ9FKNXxg3Il7+VJ3u4+waW+9IYcfOUJHYnwxCbxZx0UHCP
         VFUerko5pXJ52KahWhbINnJ24TMtf97zbXMuTemQWt/UX9WjvG2MOacJTs3KvusNK0e2
         xjXpEPTrTk+P6qL8Xx7UA3VxqYaboY0m91sSXbt3tsH/WLJ//oCs7jJ1C2CIEFf1YMeH
         bxgfeO9JR3YqFajS92XjH+QnFeQgf4TO6ZJBb7Kr9421cs6eSqRVNsW8aLxHI/on4DUS
         dCxp15J4Ounr9E79cmQdiKPexKdCVemqLTiMbWJzjKrrKyQP3n1xPZ8K7+DFC3KtPcKJ
         HQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743710214; x=1744315014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJb/2QaqcIYtpNBOB7gB82icRcHj50AQYqYnKr/nk4M=;
        b=D4mp7owxYHUJBK9u+ZgaOBM7AfQZ5P5/Iw5p8YP68BnpzjI+z1FrBjLzyRR6Y+rB5m
         xY5CsQNmO9CHCPU3Unr5C4dhijtaw3ZFve8eVw0Wf/H16N7cgGNIH9u2SFrYLLe0AlfT
         SAIZc7tZKPMoBAcFBnhU9jB4QcVJdsu9WgK+rkiZIGb/RG1vFLWU6ze+EONKqqpoGuZB
         CmBeQF6xOoQDKZI2nnvTAJmA2jkD5vaWkurkuDmglI1VOo0WiUVJeVNgPSb6EQQSMN2k
         euNs9Ri9AfGkOABUOBKVQ6dVbdo8EDDr/GT6eQy8j0ZHUSRWw+E/3++4v2S3Gpe72nkx
         nEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUrJCmh+IAiurBesrTRXvxXu0tW4SxjDGZV95Yk4akPlGqrOVYhk3Ow7q+d6/qkrnYLfjF2pUUCnNzQ@vger.kernel.org, AJvYcCVCFfPhx6QQPvXVznaWkZMSGomgUw2hj0qtlvuLYiXdHjBxdAwBY99wCJCxDANP5V2ziT5jPrTuGn/8Sz4F@vger.kernel.org, AJvYcCVEa2fPofYXD80uSQUlAENbzr4sBrKGg0YiMZpWvwpDfbm04UiNeX5U75YuFD6nu93zZm3xxuFaQbWy@vger.kernel.org, AJvYcCVVt8pj/fJNVyPQAp0OO7EeMo3GXX5VIRxD9edzbXHuwoXglB8VEyrt4s5twBcIo1nCDHxpx4iXfPdR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0WVG+IwUshnOycznmVuBuClF+G/xVNUjuQAv3pPuI7CPCqhmK
	sTJHniUOzt65PWokRqB1X8Jq0rtD30Rcp9A43QgGAeyZuDW8OKM1QD/g+Ngq5XM=
X-Gm-Gg: ASbGnctK/S6O52jWzhiSzf2lASPWsi7BuZcVet5C8A7Hnn4EloSxmQn8j9x6aZdSEh0
	WgB6NfXNqOHnUc9/l9mvsschH98kKcn0P4nCMGz6bvybBsxtq9YN70b08uCTdOiIVHnKfF2ZqSp
	hybGAS2IgXgbFvN00ykPawxvq0Rkxlfzg0kxadVXlC11iyf2aNR+rqdAVMepGKVUxg4trftCoWj
	KFePsPCh1haVXyEGuHrURZy8E/7y8jPGcH5paqsSxHdL4uVvK2jYRoszGWub/QIBgBLzTFcxF3R
	fwpnVR2uKy8T7p/+P2InpnGxx4vypKKc6cVhq3dMWn0fHecwHpeu+hTT3MbkbQaYhVGlfvthdOE
	hMLNA0OoSIAifAue2G1s=
X-Google-Smtp-Source: AGHT+IGxGtkOBP0TP0AVocUIIyXTGUgLcRbXXGYkZdGl4Thl45yxjpsRJSY3RA3caFfGAS7LhLQIyw==
X-Received: by 2002:a05:600c:b94:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43ed0c562b3mr925465e9.18.1743710214401;
        Thu, 03 Apr 2025 12:56:54 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm26568655e9.9.2025.04.03.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:56:53 -0700 (PDT)
Message-ID: <0965e96453e96748c96b052d1658d7e1042c3b0b.camel@gmail.com>
Subject: Re: [PATCH 4/5] iio: adc: ad7380: add ad7389-4
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Thu, 03 Apr 2025 19:57:11 +0100
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-4-23d2568aa24f@baylibre.com>
References: 
	<20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
	 <20250401-iio-ad7380-add-ad7389-4-v1-4-23d2568aa24f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-01 at 17:50 -0500, David Lechner wrote:
> Add chip info for AD7389-4 to the ad7380 driver.
>=20
> This is essentially the same as ad7380-4 except that it is internal-
> reference-only instead of external-reference-only.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 18 ++++++++++++++++++
> =C2=A01 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> e5cd11fd7b1083af2082985f2c0226b1a97d600f..190ab411739feea32e189cb3ede9250=
56ba4a87e
> 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -13,6 +13,7 @@
> =C2=A0 * ad7381-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad738=
1-4.pdf
> =C2=A0 * ad7383/4-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad738=
3-4-ad7384-4.pdf
> =C2=A0 * ad7386/7/8-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad738=
6-4-7387-4-7388-4.pdf
> + * ad7389-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad738=
9-4.pdf
> =C2=A0 * adaq4370-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4=
370-4.pdf
> =C2=A0 * adaq4380-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4=
380-4.pdf
> =C2=A0 * adaq4381-4 :
> https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4=
381-4.pdf
> @@ -812,6 +813,21 @@ static const struct ad7380_chip_info ad7388_4_chip_i=
nfo =3D {
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> =C2=A0};
> =C2=A0
> +static const struct ad7380_chip_info ad7389_4_chip_info =3D {
> +	.name =3D "ad7389-4",
> +	.channels =3D ad7380_4_channels,
> +	.offload_channels =3D ad7380_4_offload_channels,
> +	.num_channels =3D ARRAY_SIZE(ad7380_4_channels),
> +	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_only =3D true,
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> +	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> +	.timing_specs =3D &ad7380_4_timing,
> +	.max_conversion_rate_hz =3D 4 * MEGA,
> +};
> +
> =C2=A0static const struct ad7380_chip_info adaq4370_4_chip_info =3D {
> =C2=A0	.name =3D "adaq4370-4",
> =C2=A0	.channels =3D adaq4380_4_channels,
> @@ -2051,6 +2067,7 @@ static const struct of_device_id ad7380_of_match_ta=
ble[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad7386-4", .data =3D &ad7386_4_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad7387-4", .data =3D &ad7387_4_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad7388-4", .data =3D &ad7388_4_chip_info },
> +	{ .compatible =3D "adi,ad7389-4", .data =3D &ad7389_4_chip_info },
> =C2=A0	{ .compatible =3D "adi,adaq4370-4", .data =3D &adaq4370_4_chip_inf=
o },
> =C2=A0	{ .compatible =3D "adi,adaq4380-4", .data =3D &adaq4380_4_chip_inf=
o },
> =C2=A0	{ .compatible =3D "adi,adaq4381-4", .data =3D &adaq4381_4_chip_inf=
o },
> @@ -2072,6 +2089,7 @@ static const struct spi_device_id ad7380_id_table[]=
 =3D {
> =C2=A0	{ "ad7386-4", (kernel_ulong_t)&ad7386_4_chip_info },
> =C2=A0	{ "ad7387-4", (kernel_ulong_t)&ad7387_4_chip_info },
> =C2=A0	{ "ad7388-4", (kernel_ulong_t)&ad7388_4_chip_info },
> +	{ "ad7389-4", (kernel_ulong_t)&ad7389_4_chip_info },
> =C2=A0	{ "adaq4370-4", (kernel_ulong_t)&adaq4370_4_chip_info },
> =C2=A0	{ "adaq4380-4", (kernel_ulong_t)&adaq4380_4_chip_info },
> =C2=A0	{ "adaq4381-4", (kernel_ulong_t)&adaq4381_4_chip_info },
>=20


