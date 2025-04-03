Return-Path: <linux-iio+bounces-17605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0FA7AFDC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EB41884405
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3D25A327;
	Thu,  3 Apr 2025 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9x4/MEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41325A2DE;
	Thu,  3 Apr 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710001; cv=none; b=SIJTUhPVll2EXbOGYe69UDrKYTFMuiIo6OPHEISZGliQ1Ads04DTiuz9FcqV5V/DfeKdClaryvVwUPksVMFYElCqqgC2ljghn5XQMLM2Io/SSANqWNGjUajhGVQlY7MZVvy/oOUsILwEOzAzjWeIq/d8g7arXGfWzdNqUFYlSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710001; c=relaxed/simple;
	bh=+rx0GW1KDDOvxeHXkvPeapZddDRpOPK/Xtq4t67G4LI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DURZZxYQRqTCTq0zodnBR04Wi2PMGoDNDpl/gsOmO4KOaoi/pzfJrN73UYZpoo2E3mvCMRExH3Agm5QT5XQs7vavZgu8a62zIeTZheTRS7IrdW8lCPkuD3i9MTxhAieF+z+2PkOaxWUvG590WgPVCFlByStytc1rtec7fHwUd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9x4/MEx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c266c1389so903093f8f.1;
        Thu, 03 Apr 2025 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743709996; x=1744314796; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UCx9U48sN7s82eXli9pfvSHJhA15swjvCSV5I/aKGUE=;
        b=V9x4/MEx/l6YGUvUPcnlNrr5NaKcetHWkbFYZMmxDpNswlIwXSSODZ+zdl5eaVImZs
         /FzeUgR9ky92/Fuxdc2K5N0H0unhZubXP3bNA0O1i37nPIvVytKx9Kb1dSHU4sfwSjB/
         DuoKBFqMg/c1YHIr+KwNSy0jwl2BvaSp8odhiGOsm3bqbCL73KT7Ei2dXHlMc33NLZgc
         euPUBLzNTyUJVmeNtF26XYETa1mj5uj8g26etJ42FY5oM4DGYDKeLFHHUqQdOp0fz/eo
         j6fI0mybyLYPKQgiugGpkPBZP9Zuzp2QdeQIWXxAh8MDrZBIiAwxuqEbPeaTDFVoXdlB
         lK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709996; x=1744314796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCx9U48sN7s82eXli9pfvSHJhA15swjvCSV5I/aKGUE=;
        b=s15QsJAFPlyKrW0aa7bXJV9TSPsmYbqea8BdobGlHLvddAfJie6XS+RxedRpZ9qkxg
         g55YA310+2pT/e9kstB4iz6pBbVtMqtEDt5GQccL+YyfwsEI8DdMwqthWkxBEoXwOdyA
         9tm3keDFsGZWAwESyPZh/cRTzJ9VTEE+L6O3cGgvC/yJzobrJjROGCZ4yo7FU6+vYIPd
         zlUa6Su6ZX0IufIfsIopDqNtxzbKU5Ll9fgy2e4tNn7CLfbkPkGl3prLx7rvQYnvbQGF
         vqLr+wb3+NBQ4YLWROUikNgAA5uqx4i3EZu1J6v0vGJVv9fEylonykiURQ42BHeD9F59
         VF4g==
X-Forwarded-Encrypted: i=1; AJvYcCUElBq+19pRPD0FTeYaL4nrz45Q6h8YcyxvJ5tKMYuP8N2jybEc/1p+TWmtlGVwIQGrBHBzavnNsvB6@vger.kernel.org, AJvYcCUxarqPS7fCG8XMy6GaGROqcxwswwt3oHwPk1IPNvOHCp3a+vHayXlwqZxj5/SR/T01TB+sUhoVPBfi8mSX@vger.kernel.org, AJvYcCVbYeccZBMn03/grHT6snS0+G1rEAudKf+pYzxlHg8QP/tpfx4E8+aw43S8LvU4B9I/TadecfMomyz8@vger.kernel.org, AJvYcCX0deaZnlp8ggM96KHaRA5nJ1dbQi3uaxDUHQfveAqfSrdYb6hgW17/nDE7KPBX1ffIPH+txb9sTCCS@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXvkZjfLc0pV9ClRK/XULWqJj67UTXUGfas6HaDa7huSbCCbP
	fJYf+Q2C+GPyE0EgVDY+EQmd7jyxU7wCJUheJtJO5rnHSXWyEEBJ
X-Gm-Gg: ASbGncv1t8ZwDpE3jBP966hSBv/R0vGKR/mn3QZlRv3gff7ZOIIjl0EYdHWkkIFQygi
	yniNKlh+uF85rcM4nq7LgVP/Up4SAhoIkf8QxY2davD0i0nn3jmqfAwNPBazpTPy7fcCsCl2BTh
	vJEIYyjGpUrkpYww1Uq+zOGd3Zf2yehNWtWr+oljXLHSnXuJ6Gwlr07J3uXWpzRM2mmSyYwtAKx
	aPv6QuYGVpKaJMnzmMFV4okyGtbHTDrSp5K/pollYEVtowuixCdUIolTPL++J3waoodCTS/lUhe
	K2SvITt42iV95ioffBUAuaMzwnc51FWI53Qj7kFkIMgmJT0wpNjYCoyBk1qfpihgj9UiLPUrZgC
	k6r3DfLo/g8fe/+bUy+8=
X-Google-Smtp-Source: AGHT+IEMN6NZ7m6VJxF1SCzwC8Wi2Ppth78oaT27iCTvthOsqvOJuk7AmvwLv91+IX2CRdmI4OAH3g==
X-Received: by 2002:adf:b644:0:b0:39c:c64e:cf58 with SMTP id ffacd0b85a97d-39d146625c5mr68053f8f.55.1743709995392;
        Thu, 03 Apr 2025 12:53:15 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b8ae1sm2638150f8f.51.2025.04.03.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:53:14 -0700 (PDT)
Message-ID: <ccf7767e4c447aa5febad9c6139c1e76dbfd19f6.camel@gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: ad7380: rename internal_ref_only
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
Date: Thu, 03 Apr 2025 19:53:32 +0100
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-2-23d2568aa24f@baylibre.com>
References: 
	<20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
	 <20250401-iio-ad7380-add-ad7389-4-v1-2-23d2568aa24f@baylibre.com>
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
> Rename adaq_internal_ref_only to internal_ref_only_adaq. There are non-
> ADAQ chips in the family that are also internal reference only, so the
> adaq_ prefix is misleading.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 10 +++++-----
> =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..18ed07275be8e031e54f3595f70afe4=
7514084cd
> 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -119,7 +119,7 @@ struct ad7380_chip_info {
> =C2=A0	const char * const *supplies;
> =C2=A0	unsigned int num_supplies;
> =C2=A0	bool external_ref_only;
> -	bool adaq_internal_ref_only;
> +	bool internal_ref_only;
> =C2=A0	const char * const *vcm_supplies;
> =C2=A0	unsigned int num_vcm_supplies;
> =C2=A0	const unsigned long *available_scan_masks;
> @@ -806,7 +806,7 @@ static const struct ad7380_chip_info adaq4370_4_chip_=
info =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> -	.adaq_internal_ref_only =3D true,
> +	.internal_ref_only =3D true,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -821,7 +821,7 @@ static const struct ad7380_chip_info adaq4380_4_chip_=
info =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> -	.adaq_internal_ref_only =3D true,
> +	.internal_ref_only =3D true,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -836,7 +836,7 @@ static const struct ad7380_chip_info adaq4381_4_chip_=
info =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> -	.adaq_internal_ref_only =3D true,
> +	.internal_ref_only =3D true,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -1847,7 +1847,7 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable power supplies\n");
> =C2=A0	fsleep(T_POWERUP_US);
> =C2=A0
> -	if (st->chip_info->adaq_internal_ref_only) {
> +	if (st->chip_info->internal_ref_only) {
> =C2=A0		/*
> =C2=A0		 * ADAQ chips use fixed internal reference but still
> =C2=A0		 * require a specific reference supply to power it.
>=20


