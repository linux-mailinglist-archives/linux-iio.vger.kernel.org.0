Return-Path: <linux-iio+bounces-6935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707489178B2
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A13B21F0C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C814D29B;
	Wed, 26 Jun 2024 06:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oCsNrdPn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBA38D
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382458; cv=none; b=gAnltz+iAOMYd04wp4IeIgaGe8NSJ3SD9wrcBESZSh0yET+vUm1Iqz8QcJroQBxyi5PmRLtluIzSdrE0qZMI8+DJzxR8qdLSxe4drfzY6acj5a5SYCyT6qAf/ZxR90M2Axrga95WobHWHSDwgN/r1lARxfeIxRv62TNUOEgAxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382458; c=relaxed/simple;
	bh=WGd4AsHHHAKOzxnmtiUcoZvGsiI213HQOzoaaZf3ovs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIiQs4Cn8Fhm+DiVMWqW9MjFOhr9f3IFH8T6GVbSNIkg/x4jAXdYlxdB+Fg+65T5Z5QxaifknAw0Q+VQ+EbcUVsWzUWwJk8JWPyCoN0bkde4OT+7x1JNHMvzD5g1UWcwpkE8pMg24eI9G92dtUAgHV650IOYgaACv7aO61LtSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oCsNrdPn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6266de87cfso51902866b.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719382455; x=1719987255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P68vjv5P5fTQyUzXQMtlC4ydEFa3hgGxJKTbgujUek0=;
        b=oCsNrdPnj5hMVbLGKe8YlXJzzic3QC5VmOY+MtONc3smcr4KOba0rAsbzBHLU0InpM
         KW8P38YPaoAOCiYXhkxs6OvtpS4Lty5FyN2CmYEArYIbn1b+rvP09vAnUmB/EvSVGMtl
         xH5SEF7gWCb5iEqbMhlmtdf0qKlWvPN5qt9v25D2UEqIVPDMq8V8w+HVvWRvqmZqGCif
         I/pGSeHV5rdRULDumqKnnAdvNRFFSp6aeZnUG2pLIMST38nkJDAYAlVvUeU5E/wJ78RG
         8tZuAzhq1o4XmCsdIoX6ZyZpVaNZ4TcW1hHDB0ReoYDtoNMGg+FtcDbb03uDdP9F4wJ8
         XIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382455; x=1719987255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P68vjv5P5fTQyUzXQMtlC4ydEFa3hgGxJKTbgujUek0=;
        b=aLVdVfNsFTMHazKfX3i+U6J3sj7MSDP/kFR4Jq4qYJcZfaQSbUxBe0UyWuCo0+J1fn
         bb2pYGE1eFCO0YpfsVjlKOwZzWpstUAT5Sh7yTq/adw3SmRCGNPmKN28THJ95uXpI6F9
         bUXu6foZNiOi8W36qdy9qlZDv7G3EPftpzl2fdLq2KET0Llfi9oMHh0mO+Y3beStto97
         kYIt+6EzJaL1FtjpEK5wShWanfdcmIg+HHXqyVc8M8YozcU1RYutL5d1qSj2x+IUcjtw
         7pfWEl4JE7PXh1+lR3NQPNQYKJpntGY1anouwt56XGMxxStuuYXaER4zIiiGt6pqKAE7
         LBag==
X-Forwarded-Encrypted: i=1; AJvYcCXD9EZSThoYwf3+BeNSOEaOFNI//kBCMIKXq1AB+2cdVHW5DWRZDJBRuJySTqikJ6rSNaQkFIuFhktQts/rhNY68ZL0lCNXf5VM
X-Gm-Message-State: AOJu0YzAg5xDDh+eXllbCBz4pstCCYrLPHT1Jmsw5OFComRozdwr7/5e
	wRlCrdyDd4BVxJTqUW9+MKkGNvmgCXJ87t8vFFWhHFJqJMRbJs3ne72wg0BaYu18f2KyWb8Y9GU
	Zi+F8es+Okb3zw9n9YhDuap6LVzz2CvDJFqL2iA==
X-Google-Smtp-Source: AGHT+IHFrAZDhVdGptSc44l74KYpkoXPmWFwKAgqD9iIY1egI+hz1d/5rPoCQHY/mWyFFxrbbPr/3PvyyHvAFloZ1tM=
X-Received: by 2002:a17:906:8315:b0:a6f:e2a0:b5df with SMTP id
 a640c23a62f3a-a6fe2a0b6fbmr729513766b.7.1719382454861; Tue, 25 Jun 2024
 23:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719351923.git.marcelo.schmitt@analog.com> <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
In-Reply-To: <072d74af9fc624490b84a1d001039424e572e827.1719351923.git.marcelo.schmitt@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 26 Jun 2024 09:14:02 +0300
Message-ID: <CA+GgBR9S7q32i-1ehNAgLHim66-Ud=PajgTSczBSJ5LUZdA7cA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: broonie@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	corbet@lwn.net, marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:55=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
>

One minor nitpick.
Feel free to ignore, if there won't be a re-spin.

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-e=
ngine.c
> index 0aa31d745734..5a88d31ca758 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -41,6 +41,7 @@
>  #define SPI_ENGINE_CONFIG_CPHA                 BIT(0)
>  #define SPI_ENGINE_CONFIG_CPOL                 BIT(1)
>  #define SPI_ENGINE_CONFIG_3WIRE                        BIT(2)
> +#define SPI_ENGINE_CONFIG_SDO_IDLE_HIGH                BIT(3)
>
>  #define SPI_ENGINE_INST_TRANSFER               0x0
>  #define SPI_ENGINE_INST_ASSERT                 0x1
> @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi=
_device *spi)
>                 config |=3D SPI_ENGINE_CONFIG_CPHA;
>         if (spi->mode & SPI_3WIRE)
>                 config |=3D SPI_ENGINE_CONFIG_3WIRE;
> +       if (spi->mode & SPI_MOSI_IDLE_HIGH)
> +               config |=3D SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
> +       if (spi->mode & SPI_MOSI_IDLE_LOW)
> +               config &=3D ~SPI_ENGINE_CONFIG_SDO_IDLE_HIGH;
>
>         return config;
>  }
> @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *p=
dev)
>
>         host->dev.of_node =3D pdev->dev.of_node;
>         host->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> +       if (ADI_AXI_PCORE_VER_MAJOR(version) >=3D 1 &&
> +           ADI_AXI_PCORE_VER_MINOR(version) >=3D 3)
> +               host->mode_bits |=3D  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_H=
IGH;

There's a second space after the assignment.
               host->mode_bits |=3D<2 spaces here>SPI_MOSI_IDLE_LOW |
SPI_MOSI_IDLE_HIGH;


>         host->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(1, 32);
>         host->max_speed_hz =3D clk_get_rate(spi_engine->ref_clk) / 2;
>         host->transfer_one_message =3D spi_engine_transfer_one_message;
> --
> 2.43.0
>
>

