Return-Path: <linux-iio+bounces-5815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269558FC74F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C711F2812D5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7318FC6C;
	Wed,  5 Jun 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzA0KhH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5418F2D6;
	Wed,  5 Jun 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578650; cv=none; b=i8c8PMO6bSiQwSka2BFiek17s4VRPRISO+JNdQtOQEpFRiTNxi6ggAGYRK80+RP6mt3xy+2nI05lGEDn6m7cD+v78bWbivjCQZzk4WKMIBhV/cQeIZQH4OAoJyJ/5MlaYyc3qaQz4otdiZms/klmMks3hw/OpUFFGxgX2re0i2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578650; c=relaxed/simple;
	bh=E9mlxVsAtpUB6nBVoigmMF3884x4F+KavP/gsSdjtCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8TmNeHue1r0f/K+HJX7kOLoD5O5nNmD6oqViRrUgG6bUOaMy3oFsfytIkWGepJDo0vUyktQjuZkuGGSJ1pSLjyIXqhXGDE8EUC9IejlsMqnl23+arHZdhwRWCn/X1Y/K76dnVJI1YxMLTj/kNO+8QO/I2DBp9If1+Tf03pe1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzA0KhH9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso2419938a12.2;
        Wed, 05 Jun 2024 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717578647; x=1718183447; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4lR+1WqnhXPwMU9kwsa4y1gv6xK1HO88u8DJnvuwCmw=;
        b=RzA0KhH9Sn/qhN8pZ+rk2lRp1OxR8XhwonmH+uznhWA7xh4EpFHUrQ4Bk+41lmlaA6
         ith7NoIbyT/xupAbuLGAhG3YKh4kH4tq+lGG1LDtk94+bFhSJKsmIY43ahq3G4BDQNdV
         nSOYe48g2C6/E6iiLGJODK2bVMexSh2OUauOJ+wfNK+DgEHDzn7joCG7Gi0QVadWx11r
         +vhz60jlw6RagfwnNN9WNNsiPRyYCBJ9g0sJFSdsAZILCe8EC7cCB+y8U2ymAp3sXkaJ
         61qhGtIyQflX11Cpe0EHjqlD9CLJxXXyIrPC3Fhcgy4UkmVqmq++/eubRwVvaaiY5zOa
         OxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578647; x=1718183447;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lR+1WqnhXPwMU9kwsa4y1gv6xK1HO88u8DJnvuwCmw=;
        b=mksHaR2VkQftCg9PueAaCoRlQuIl2TCaDEtYRc29KP5JehiOsAz+g6AuAWxZZd0fMd
         1iFaOxRlkV1jrXOTTHV6F+Pfd4Cu7pO+jJMXarX0rXNZ9oxevxVYoJl+nPw5unNjxRqM
         jof4SXJD9rZamfQ/he9PEnqfSv+hz5DYpFo8OCGcELINN+IhWY6r5krVClWAc2WA2ZTG
         kl9K24J8nge+zfeOpGRFR9EvEKpRC1Zz6NV69S4CJzxbx4CIMwjmCYr0LSskNuuoBGsT
         vDZsbA7ItZtvdaBis/ePo5eDQ/qr5JBGdj5I5fdtyUjtR0SrPFEx7tBpzGcpbgMcY19q
         3Gbg==
X-Forwarded-Encrypted: i=1; AJvYcCUP76OQqvbPqkj/35QbhSSrMhlbBUj1bx3mexJQxk1ExoA2a+N5KE7bJaonCAtVuZG0y7XpVyFX3Zs/sRwgCuly6sKjLVHw84qO/6ooFmikOMUd1wpYjcBWJMIrtRGbaVC/3k0Luf4KeEC+X9Vo0oyIGcI/bAyim5rH1gn6C+se3Nv27A==
X-Gm-Message-State: AOJu0YzxGz/56nDqFWIZglBJLt1fMbQZVZlfuvc9npK/vechHXSKuToo
	TKqSGxH5sxDi/22NZWrkTCjIleYFLpX5/LNzPTG2z/8PsX2I2WDH
X-Google-Smtp-Source: AGHT+IEb+qa5wkz90x6hesV6mbtTRlnjCiHuPlt5a2o9TbchPKLNYP/jjd0I2dqLYdG8x8YgIN12UQ==
X-Received: by 2002:a50:aa93:0:b0:57a:4ff8:2f11 with SMTP id 4fb4d7f45d1cf-57a8b674ac2mr1261245a12.5.1717578647241;
        Wed, 05 Jun 2024 02:10:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be52b5sm8981542a12.49.2024.06.05.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:10:46 -0700 (PDT)
Message-ID: <21d3314355b43ecd6acc42f9dfedec501418332d.camel@gmail.com>
Subject: Re: [PATCH v3 1/6] spi: Add SPI mode bit for MOSI idle state
 configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:14:33 +0200
In-Reply-To: <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <e1d5d57f7a7481c84f64a764f9898122e278739b.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 19:41 -0300, Marcelo Schmitt wrote:
> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> (Controller Output Peripheral Input) for disambiguation) is not specified
> when the controller is not clocking out data on SCLK edges. However, ther=
e
> exist SPI peripherals that require specific COPI line state when data is
> not being clocked out of the controller.
> Add SPI mode bit to allow pheripherals to request explicit COPI idle
> behavior when needed.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 6 ++++++
> =C2=A0include/uapi/linux/spi/spi.h | 3 ++-
> =C2=A02 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 289feccca376..6072b6e93bef 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -3921,6 +3921,12 @@ int spi_setup(struct spi_device *spi)
> =C2=A0		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> =C2=A0		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
> =C2=A0		return -EINVAL;
> +	/* Check against conflicting MOSI idle configuration */
> +	if ((spi->mode & SPI_MOSI_IDLE_LOW) && (spi->mode &
> SPI_MOSI_IDLE_HIGH)) {
> +		dev_warn(&spi->dev,
> +			 "setup: erratic MOSI idle configuration. Set to idle
> low\n");
> +		spi->mode &=3D ~SPI_MOSI_IDLE_HIGH;
> +	}

Should we assume such a thing? IOW, should this be treated as a warning or =
a
real error? I would assume this should be a configuration error and return =
-
EINVAL but...

- Nuno S=C3=A1


