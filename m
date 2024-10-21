Return-Path: <linux-iio+bounces-10851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC909A6672
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 13:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C121B235B3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0980E1E6DFE;
	Mon, 21 Oct 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLaH7Jer"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EC1D221A;
	Mon, 21 Oct 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509487; cv=none; b=KOyWCfY6q5p5D+yFj3YU9S0Up09USOJFL+OCX8twzIwxnhlrGwmo/Kb32ZG6lRihOmzB3M5FVBNOBuN6IO4bdvX3VUzMRg8YlvJmU2eVQpzCYzlVdfV0jL1WmhyYOAkrR9pngY99AklCGlivHD8stt1kF9/6jSXE/96Qw6QHD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509487; c=relaxed/simple;
	bh=YLAvMjhW1HB7PsV5gBYZNiIntTf5JhMxPwr43QqPZCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccNT7Toy7txGtn1k2T6pj5V7CDFgNvhbI24ntgCZAK4XaJqxCXCF3pt37PSfRsno7xKYSsPbYN/Q21T/I7mE+j48k+LeUKV2eV7+zJ9z1lwTCbr/M8lF5LzMbJ0BC94Q89E6y9QST0AQIyiWSKOHOhvojVkZpnch/DLKacMCm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLaH7Jer; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539983beb19so4688718e87.3;
        Mon, 21 Oct 2024 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729509484; x=1730114284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xfj/EnKxXdQvjQtOfFijWCS2fwYORZ845i4D/RptAbo=;
        b=eLaH7Jer9y4J7SA7s2/0Akv5L6JPIaE/cjblGeitJRcGf4CCoidlMkG0qv+SU/BYxu
         jPRUhVEVoZaBNHSNIS3brnexGt1DSYrAzrQxFR/zFu5xrmV9hWpUqck/2JjtKBCpAH82
         92rrS0CgIsn3kMU81zcE7YCnQ9mFFY4FwxbOPGg6aILnqqlW2DE7LxmqWMkAmYSjNaHk
         jTPw9Kmn0aTsLgMGfBtDGvv1jt6ytelVtnBftiPJsh23ZKuozC2Lg+iX5SRvjKQFV977
         pCu5AqNzWRmQqN/jx383HGBUJtUk/9zmrI35gPKEoGHZogUss/4IqEey8Nj9VpCFWbo4
         H3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729509484; x=1730114284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xfj/EnKxXdQvjQtOfFijWCS2fwYORZ845i4D/RptAbo=;
        b=ZEEhVPGLCS/lsgJhFdFWdlCz6h3P38X6vUfz+xMMs+O2VLWD+gq+xGrnoOkN0gfgPu
         xbTuFPyKgICx4/QoW1hsBlSV6r0KuiQWscdvTHknSDsgsHSFqITMQpLCTLGm20UXT/cK
         I847btyKeEQah9CdCzenzg2k+ODjzIrvSFN73YlqFFsAOlvPFA3/uEAshEguNhLPJqHZ
         Ky26TIFC/PDAsIPSCaeydZmOGpss/jzhQoJ/Ztpw2Izs2pwMYJNrQJALqNlagGRUvcH9
         xH0ROuNoqNRDdgKgyylbzd40BRijZxpkkaryFIh4UJM1I0o1T4CrxBMT+WWyg5xPY1/Q
         VjCw==
X-Forwarded-Encrypted: i=1; AJvYcCVc9nTZArqop4FUPLfuzY6VK5cjYy+nmV/Jw2Wnu9PuHPM19X+aC/XAwAOy8z7kYzKkC8XnSxAbN70Gn5Qu@vger.kernel.org, AJvYcCVvzHVfswcg/IeqOeN/MJXMUr1D490Ael85KeSfItmCXhYnKA9KCZsVLUIqbkyo4hlZJO/jJfieLipM@vger.kernel.org, AJvYcCWHJxLWWbor5KvXg+QZudFJ4YE6mqVr0IwHXX/xarYGCUmby5pXJkmHe8YWBMz7oX6T7E+ILs4nO/oD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8+s7y5pPRxRf80TiXKDgN0sINjx3m3NxftUD5J9v028iJZsW
	pxoFJ3PXFS+8pCLPVIP3zCTbHMCuRchB17SMytpxTUo/wuHZLJaddOp0yK3L0NG9zi1C
X-Google-Smtp-Source: AGHT+IHDeK0DwiMkPDbC0HMtjNt1Y+661gRF6ZAnCpztH0AGj/ZblZ//B49e4j2AvMw4oSApJIsfNA==
X-Received: by 2002:a05:6512:23a0:b0:53a:40e:d55f with SMTP id 2adb3069b0e04-53a1545382cmr5067882e87.15.1729509483281;
        Mon, 21 Oct 2024 04:18:03 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91571e3asm191957666b.147.2024.10.21.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:18:02 -0700 (PDT)
Message-ID: <037d7ebb4d037edb32f9d717e456ab545621ea94.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: ad7380: fix supplies for ad7380-4
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, David Lechner	
 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Date: Mon, 21 Oct 2024 13:22:19 +0200
In-Reply-To: <20241021-ad7380-fix-supplies-v2-4-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
	 <20241021-ad7380-fix-supplies-v2-4-2ca551b3352a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 12:00 +0200, Julien Stephan wrote:
> ad7380-4 is the only device in the family that does not have an internal
> reference. It uses "refin" as a required external reference.
> All other devices in the family use "refio"" as an optional external
> reference.
>=20
> Fixes: 737413da8704 ("iio: adc: ad7380: add support for ad738x-4 4 channe=
ls
> variants")
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

Hi Julien,

Patch looks good. Sorry if this already came out in the previous version or=
 in
the other patchset you mention but shouldn't this fix come first in the ser=
ies?

Anyways, for the patch itself:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 36 ++++++++++++++++++++++++++----------
> =C2=A01 file changed, 26 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> e257f78d63edd7910fcb936ec5344922f8e70b99..65096717f0dd3ea6a4ff7020bc544d6=
2b84c
> b8fd 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -89,6 +89,7 @@ struct ad7380_chip_info {
> =C2=A0	bool has_mux;
> =C2=A0	const char * const *supplies;
> =C2=A0	unsigned int num_supplies;
> +	bool external_ref_only;
> =C2=A0	const char * const *vcm_supplies;
> =C2=A0	unsigned int num_vcm_supplies;
> =C2=A0	const unsigned long *available_scan_masks;
> @@ -431,6 +432,7 @@ static const struct ad7380_chip_info ad7380_4_chip_in=
fo =3D
> {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.external_ref_only =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> =C2=A0};
> @@ -1047,17 +1049,31 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable power supplies\n");
> =C2=A0	msleep(T_POWERUP_MS);
> =C2=A0
> -	/*
> -	 * If there is no REFIO supply, then it means that we are using
> -	 * the internal 2.5V reference, otherwise REFIO is reference voltage.
> -	 */
> -	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
> -	if (ret < 0 && ret !=3D -ENODEV)
> -		return dev_err_probe(&spi->dev, ret,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio regulator\n");
> +	if (st->chip_info->external_ref_only) {
> +		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 "refin");
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refin
> regulator\n");
> +
> +		st->vref_mv =3D ret / 1000;
> =C2=A0
> -	external_ref_en =3D ret !=3D -ENODEV;
> -	st->vref_mv =3D external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
> +		/* these chips don't have a register bit for this */
> +		external_ref_en =3D false;
> +	} else {
> +		/*
> +		 * If there is no REFIO supply, then it means that we are
> using
> +		 * the internal reference, otherwise REFIO is reference
> voltage.
> +		 */
> +		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 "refio");
> +		if (ret < 0 && ret !=3D -ENODEV)
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio
> regulator\n");
> +
> +		external_ref_en =3D ret !=3D -ENODEV;
> +		st->vref_mv =3D external_ref_en ? ret / 1000 :
> AD7380_INTERNAL_REF_MV;
> +	}
> =C2=A0
> =C2=A0	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
> =C2=A0		return dev_err_probe(&spi->dev, -EINVAL,
>=20


