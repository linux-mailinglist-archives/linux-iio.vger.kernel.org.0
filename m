Return-Path: <linux-iio+bounces-5879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754828FDF16
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 08:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6BB28E601
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5512AAE2;
	Thu,  6 Jun 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR1HQFdc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8319D898;
	Thu,  6 Jun 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656466; cv=none; b=PXLbGHOS8NkScYe79zJdPVdY6HkMRX+8C6JSrdlghvNgTAHct9Sfat8kzcn+yL7K1YcA7OQQb1c8kJ+DYnqLltlS58it2TOH8jUQxePlCM3RWPcNQfrrLOb3FTybz+2d5pagEpbGlpehqzT1EsPO9i1NuJr2lwFXv+1TQ8CUPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656466; c=relaxed/simple;
	bh=k5s7YOLQTUatjXw1nfSPcz2NVGXMNK1aE7DYjJ86gfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXjGvhoju6Mj0Q0+7w8uBd5dWI4lPoD+Gt5po9xiRb9Ghe1tax/Vu8Tq2bf4ptidz5PdjRLqoKRcOn4F0NMrfiyVyq1yFIcUpjR8b7JPIOA+ZzKIBfzjWbHLpYMdX1TGXn0PaS5ulnez00p85JIuRvirWgrv1PalPb0PMvGMnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR1HQFdc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42108856c33so9823295e9.1;
        Wed, 05 Jun 2024 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717656463; x=1718261263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lb426LLnUih8K2YvE1gaXIGP1CqxxrBM8f63wiNLErg=;
        b=AR1HQFdc4pNbEsyuZbviskoQAcI6alssR9O87H+rPm2rHF1D2rzGLBRa2Uw1tvzppM
         sZmw5VkdVS+VSvNPH4DDIbihAXNkTbi/q+2KDZaC7f8Eg1j/hX/Roh3Pszbocleu4W34
         KrHR9YOyQyH+ioKqvzp5LCPiX4Q4B1F2WX833psXhmsCl+MuEJa+XuK4bq1T91BfrODo
         PH+OuwdLAItM04tcrPIedt1jbKYkNWrjWPRwB0fkOWHFSmajOvcxxgd7VEhBGj1rFxDg
         hj8hN5mG4N/NpettbMZzgCgJTqgVES4TbkHalfrpnp99yU7rqHuFAHXL9iiO0jLHXGwP
         cTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717656463; x=1718261263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lb426LLnUih8K2YvE1gaXIGP1CqxxrBM8f63wiNLErg=;
        b=I2z+9cxmSo/+b6SjtCeRJGOm4ILT0btXvNk/nE6GgyqAZ8MsG8EWO4M8YpPwZluc9C
         NlT/jqJILwnHkBczIolEn0cp0HjOHdT79dxoxPWFGrjGPgBjEIZgHQcWu9XTZe/3v2Ho
         x5rPo7y4tOVvUKXe3zrdEW3hRmmfW1KbDqYqT0EJOvhm0YM9BG5zCeqThTxFu4c/1ZJ9
         rYtt1ZWx3lp/0YWoj713yemD3dCNM+6nldLkH3BEnIP6D5FqzjfmUMI6Ff/8TKpAZGTA
         dKdodSTlV6yhplGJRU4EfF6k8+eRKvGJHaJ+07em+/RJg6pPRrER+0ffp/7/jMXI0zPI
         giMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfyjafyD9ddjdNf5hl/omc8jCtJoNRTiYRSZkVZ78BsaRpkdGlmDXxjfRKsHCqt3j9EtQvbwdVVaf7t5XcQ1VWfL0Pw4kXgRs0ZBtfH2mni4p+hu3P6AoS+Anu796AlBLQtiuxwFx31cSYtuUc72EAxvkRQaExO7KMDk4qvS0Kke+qkg==
X-Gm-Message-State: AOJu0YyYYFf98bgTYxzJy78FSZyIgrk9zHz924yROpsnRgmL1Bk+yXVf
	7CF3UFtORZBIy/FCgy1PKiTNTQQIBYs4/jw1RlCroWAQrqgQlnpK
X-Google-Smtp-Source: AGHT+IHgIM6GzVD3SkjPmL595htx1HpX163bpnbtHN6d9yNTYrl3KyPXaMvMUNTmUbrcl7cCljvHOA==
X-Received: by 2002:a05:600c:46cf:b0:41b:f4e1:381b with SMTP id 5b1f17b1804b1-4215acbf8bdmr13792865e9.2.1717656463069;
        Wed, 05 Jun 2024 23:47:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158116e41sm43625595e9.21.2024.06.05.23.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:47:42 -0700 (PDT)
Message-ID: <0e18b3aa83a62103b0f06ee516193c03f80abae9.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] spi: spi-axi-spi-engine: Add support for MOSI
 idle configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, broonie@kernel.org, lars@metafoo.de, 
 Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
  marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Jun 2024 08:51:29 +0200
In-Reply-To: <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <a6b00e84325bbe44919cc49509e837f2555367d0.1717539384.git.marcelo.schmitt@analog.com>
	 <ed4fe3de-726b-4eba-a12a-d2f7b1da26d1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 12:03 -0500, David Lechner wrote:
> On 6/4/24 5:43 PM, Marcelo Schmitt wrote:
> > Implement MOSI idle low and MOSI idle high to better support peripheral=
s
> > that request specific MOSI behavior.
> >=20
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > =C2=A0drivers/spi/spi-axi-spi-engine.c | 8 +++++++-
> > =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi=
-
> > engine.c
> > index 0aa31d745734..549f03069d0e 100644
> > --- a/drivers/spi/spi-axi-spi-engine.c
> > +++ b/drivers/spi/spi-axi-spi-engine.c
> > @@ -41,6 +41,7 @@
> > =C2=A0#define SPI_ENGINE_CONFIG_CPHA			BIT(0)
> > =C2=A0#define SPI_ENGINE_CONFIG_CPOL			BIT(1)
> > =C2=A0#define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> > +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)
> > =C2=A0
> > =C2=A0#define SPI_ENGINE_INST_TRANSFER		0x0
> > =C2=A0#define SPI_ENGINE_INST_ASSERT			0x1
> > @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct
> > spi_device *spi)
> > =C2=A0		config |=3D SPI_ENGINE_CONFIG_CPHA;
> > =C2=A0	if (spi->mode & SPI_3WIRE)
> > =C2=A0		config |=3D SPI_ENGINE_CONFIG_3WIRE;
> > +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> > +		config |=3D SPI_ENGINE_CONFIG_SDO_IDLE;
> > +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> > +		config &=3D ~SPI_ENGINE_CONFIG_SDO_IDLE;
> > =C2=A0
> > =C2=A0	return config;
> > =C2=A0}
> > @@ -645,7 +650,8 @@ static int spi_engine_probe(struct platform_device
> > *pdev)
> > =C2=A0		return ret;
> > =C2=A0
> > =C2=A0	host->dev.of_node =3D pdev->dev.of_node;
> > -	host->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> > +	host->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_3WIRE |
> > SPI_MOSI_IDLE_LOW
> > +			=C2=A0 | SPI_MOSI_IDLE_HIGH;
> > =C2=A0	host->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(1, 32);
> > =C2=A0	host->max_speed_hz =3D clk_get_rate(spi_engine->ref_clk) / 2;
> > =C2=A0	host->transfer_one_message =3D spi_engine_transfer_one_message;
>=20
> I think we need a version check instead of setting the flags unconditiona=
lly
> here since older versions of the AXI SPI Engine won't support this featur=
e.

Oh, was not aware of that... Then, we definitely need to do that. Marcelo, =
only
add my r-b tag with the version change in place.

- Nuno S=C3=A1

