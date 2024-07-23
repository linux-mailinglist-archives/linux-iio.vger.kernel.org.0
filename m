Return-Path: <linux-iio+bounces-7816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33579939C11
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF08E282F98
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5314B96D;
	Tue, 23 Jul 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjh1oq2O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0414B94E;
	Tue, 23 Jul 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721458; cv=none; b=lrRNNtCfVKpSA01ND0OpW3r5jU5SGYnfNa3va0FG9p7Jdk2f1Fsz3VPQ/vbC5//SB+K9fqocJA27O18PZqctlzQFpW+Hl9ydMJrdgAXPyaUSbc+rxVEtiiMNS73kKQ2rl0z5tMENt8Ym/t65IDL/fq1XuhsUZ09xwXojFfQD3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721458; c=relaxed/simple;
	bh=4YQQEgM48beD0I89wvKaYdWQiViVNNnTYxUTvi/MvkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=faX4acdho1Wov1LwTRdvIWhQlY/IVXCGihecG2jfgksxJzx1/A/ilL4eKJLYdsAGEhrlV8EL/fw+grGq2ae0cYRtQpyGiWTiN3XE2h06yYvKFe5Z9FGY40fXq1WI8YPKXUDijY3St1C8+7rLGK+eZ6Qe3yrkCqj6qMTQ/5sAiV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjh1oq2O; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77d876273dso17422366b.0;
        Tue, 23 Jul 2024 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721721455; x=1722326255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aouVwhBJqE5k2WCDcGQ1Nex+dDn72kX8+hkE1LGZgE4=;
        b=Yjh1oq2OXgUC6r2bWkjmrjyCZmVpszC8Mt5iltzyf3xj6b082Zr3vJLa+pVxsQ4ddo
         rnZFiHDvUiselKURHpNr7Ceaz7uSTVIjSw8MewI8SuEvUzw8NcfNHNbkBXEXzt21DQhQ
         7D8Pt5+BSTZ5nbtIk1LF71lV/gePwbvvnwq6SQykdFfB/IQ80FKNQgm492gkTg16fon+
         kjqPe8woKm7AaqnCVTRRlTJvncLwf8m9NbTVfaBVfb1vmoOF+0JhVY5Q2BkkuSt6c1yE
         cpu3XsAUbQegbp02m2i4CrAZjLXFgdtQGkFHiAGqbgo8W1Kb9hP+rY+9bRc4w0vDCJqK
         RdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721455; x=1722326255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aouVwhBJqE5k2WCDcGQ1Nex+dDn72kX8+hkE1LGZgE4=;
        b=VwSG8yfJCfBG8GfFb6GogX7DW8LuLS/Phc/icaIMEnR8tGMPM1p9GLCvliNrFnk/I5
         kJoBoENluoRThcMDgC+PAVd1p9IQH9TSqcjK6gI3cPtamHc1mcUGaIrel7GtDcOT1AOU
         cWufr2m4cgx3+w7XF1h16c72RXxCqbLfwmo/Fb8ZODJU4z43zaDku1mEfz3cRxxg6af+
         PcBE0/5a52srpCcX3F+Z9kIU1PVcnEcEgw29qH9mlsfa6PVPqX0aaqiQma/fBZ6RMUIU
         IXZUPIZztXszmMtXHy3B/MK7xIdBg2r2D8DqU7RumNF8XlVuUxTZtxn86CTKT0eEymML
         am/w==
X-Forwarded-Encrypted: i=1; AJvYcCUlKlI7iADPL11KcIn0MToGlhk4Rfy+0HrB9dTi9Z30y9aEoT6xa4OfF611v4k5zMqYh7PlbT8BuPAZFK5fesLt5/jIDA4L0biXD3DW21WTvYw9gCqNdJDnTOWfDZQasXkhDv2IbQQLsGgqKBMjBBl/I25I9bU3UVHktTnslx0udybXjye8UlkaBT/U+yvM3qCGHAu1HAZgw17lryeaQg==
X-Gm-Message-State: AOJu0YyemtVkSRcbry3yYWB9yCC+AT5ks2y2D4Xw2ERbAb4kl4nQcgfm
	1WBKhWFAo73T3QASFuRrc3vpqIuhiKryeV2gjo0Y5Obbo2N1lOeW
X-Google-Smtp-Source: AGHT+IGum/IV02rbBZD2V9qbrwOtzlm9OVdy3vyufKB1tHH+HTCkGwSqQDGtZxeoukpglfPat3NlsA==
X-Received: by 2002:a05:6402:26cb:b0:5a1:71b2:e9bd with SMTP id 4fb4d7f45d1cf-5a47b7ab860mr9481593a12.34.1721721455293;
        Tue, 23 Jul 2024 00:57:35 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a3228723bcsm7059341a12.48.2024.07.23.00.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 00:57:35 -0700 (PDT)
Message-ID: <5b246e7628ea189be5f8430dac4cffde723b7907.camel@gmail.com>
Subject: Re: [PATCH RFC v3 6/9] spi: axi-spi-engine: implement offload
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 23 Jul 2024 10:01:32 +0200
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-6-7420e45df69b@baylibre.com>
References: 
	<20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	 <20240722-dlech-mainline-spi-engine-offload-2-v3-6-7420e45df69b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 16:57 -0500, David Lechner wrote:
> This implements SPI offload support for the AXI SPI Engine. Currently,
> the hardware only supports triggering offload transfers with a hardware
> trigger so attempting to use an offload message in the regular SPI
> message queue will fail. Also, only allows streaming rx data to an
> external sink, so attempts to use a rx_buf in the offload message will
> fail.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

...


I'm likely missing something but you already have:

priv =3D &spi_engine->offload_priv[args[0]];

which seems that from FW you already got the offload index you need. Can't =
we
just save that index in struct spi_device and use that directly in the othe=
r
operations? Saving the trouble to save the id string and having to always c=
all=20
spi_engine_get_offload()?

> +
>=20

...

> +}
> +
> +static void spi_engine_offload_unprepare(struct spi_device *spi, const c=
har
> *id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv)) {
> +		dev_warn(&spi->dev, "failed match offload in unprepare\n");
> +		return;
> +	}
> +
> +	writel_relaxed(1, spi_engine->base +
> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> +	writel_relaxed(0, spi_engine->base +
> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> +
> +	priv->prepared =3D false;
> +}
> +
> +static int spi_engine_hw_trigger_mode_enable(struct spi_device *spi,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const char *id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num, reg;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +	reg |=3D SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +
> +	return 0;
> +}
> +
> +static void spi_engine_hw_trigger_mode_disable(struct spi_device *spi,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num, reg;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv)) {
> +		dev_warn(&spi->dev, "failed match offload in disable\n");
> +		return;
> +	}
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +	reg &=3D ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +}
> +

I would expect for the enable/disable() operations to act on the trigger. I=
n
this case to enable/disable the clock...

- Nuno S=C3=A1


