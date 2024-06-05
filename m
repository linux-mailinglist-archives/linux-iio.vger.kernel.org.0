Return-Path: <linux-iio+bounces-5818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41828FC7BE
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 11:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFFA1C23461
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDBD18FC62;
	Wed,  5 Jun 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPSSQDl5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D5200CD;
	Wed,  5 Jun 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579613; cv=none; b=cWaJ4qhkaHEP9VWM7c3Va+KhjprwgFUbJTOcOIL0Dc2Cy1g5JQoKJ7dU+lhpGrUCp/fYJQ0uU8W5c+K9+gMZZWmICqEdU78n4stNuvEqbHhvItOV3P/KBTP5oGujI5N5hRbQ+pHJsUdn9r9L3qMqIEBkv1MhNYc3+duJUoxcKmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579613; c=relaxed/simple;
	bh=Y7dorVYxePR9VWygFujvcqMnB0Us5J/pvoyDgyJ/vhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gps3AOWJWNdOj56ndAbjsyQyNcu0nv5JxrDbOuayWefHLRFZ4ANLgqjH/Ha0RdODFHheYxR33dENIv42B2z++x3dCMSso6aPi9Gf1v37BherzCxdvlAw8026tFhvkZEtHcUlU4IqCYMlEL38XQwBq5g2jtGjzIFJMedfV65P31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPSSQDl5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42139c66027so19066805e9.3;
        Wed, 05 Jun 2024 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717579610; x=1718184410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1UmSXewXk4xoFkR0JLkcRp552PFqHFEUhSIEEN2KqQc=;
        b=fPSSQDl5gHxGN6DQi99Som9P/HOASwgUOkZeE1bJJ1RRVAtqtpycintEu8UXXOA/8e
         pGXK4BNJlXcHUno7jwBJxCKF5QXOdcUpjlQMVC3FwziRbfLEIHwFKYmjnxUCx5eca59s
         8cxA09RQnEGB1aUMxrzYjX2DiSNI6JjnBIn/55NIArTvtjG0WPoPNUU3sYWpjbr7V3le
         tFVguuLc+bQ4tRaXSSpOd+39drjLEGz7Fqh5Hj3V3ZNQN6jgkGiXe2SuM2PUJgDqaTSv
         wr14iV4uIR98zEIEy47Fwa17i2cv6p7AOs9/MMpARKzlndWEfNs5oSZzALDCZZ/7j3xa
         nreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579610; x=1718184410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UmSXewXk4xoFkR0JLkcRp552PFqHFEUhSIEEN2KqQc=;
        b=t8BYVZUBGKIqSViUaX0GEBYuiAh1LSN8/4AF1c1xPrLKKOwqNiS4Z2Az/YDoADXtBv
         7ZN17y0X6CmNwbVMPw/srvddi9EM3SQPAXJNyT2N3e4a21CGXLkSeNrDxKoIwsuQuHSg
         uyw0oNfBH4kaJNHtd/UqlpZwtauIOr9aYRgHhAthVzCJmAO2FLBpjTy0fxudCrphYmcA
         ncqjOzM/H3tY3MlRAvMQruna72o2MivdFYErb6QM4sx8XDzuU0kbiJ3E1ob9my1TX2Di
         P8E6uyOGGXw5DjAe5aQrPTIHMMndUD4TchsfEJsaJHsacrvr43XSVcSTnBIjGN6joEFR
         vyRg==
X-Forwarded-Encrypted: i=1; AJvYcCUrFdjIWOS72wmrT/UAVNX5bg3r7BdVXoOMal2f5YDgoq37Zjd0My9ickDx2RrEAHObREtW35qpv5Rc9LGfHyRsy2BmUMmwYi+N8DfMKgPaHHiLaJD5CiunM4y2v715NWjzOiotkA6Hsv7JaV5nmJ9PDFCxTq0BYDEPcez5BMPfyc/3KQ==
X-Gm-Message-State: AOJu0YyDlN6c6UhnJFnamGbQpnFBbrpwO3HkRJ+3wWXD3PQWQR/7gryD
	F5EgqfTKRk3KiPjFj0PbeHcoIX+nwcBnwH6c5JgqIryKcBwwusxV
X-Google-Smtp-Source: AGHT+IFH3qEuzhvOzWCxD89pSr5V0K6ubhue4nZnUzWyz+9pwcFpeOSdH2c41hWlgEUOrw3l/ZQVoQ==
X-Received: by 2002:a05:600c:4ed2:b0:421:565b:e71c with SMTP id 5b1f17b1804b1-421565be9ecmr14133675e9.14.1717579609319;
        Wed, 05 Jun 2024 02:26:49 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581490c2sm13780065e9.37.2024.06.05.02.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 02:26:49 -0700 (PDT)
Message-ID: <0c0d1b2030960cdc2840d84645538fe3a9c8b9a6.camel@gmail.com>
Subject: Re: [PATCH v3 2/6] spi: bitbang: Implement support for MOSI idle
 state configuration
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Jun 2024 11:30:35 +0200
In-Reply-To: <811a2771d93c16b48fb37286e648a03171c8d2bc.1717539384.git.marcelo.schmitt@analog.com>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
	 <811a2771d93c16b48fb37286e648a03171c8d2bc.1717539384.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 19:42 -0300, Marcelo Schmitt wrote:
> Some SPI peripherals may require strict MOSI line state when the controll=
er
> is not clocking out data.
> Implement support for MOSI idle state configuration (low or high) by
> setting the data output line level on controller setup and after transfer=
s.
> Bitbang operations now call controller specific set_mosi_idle() call back
> to set MOSI to its idle state.
> The MOSI line is kept at its idle state if no tx buffer is provided.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Some minor nit below in case a re-spin is needed. Anyways,

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/spi/spi-bitbang.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 =
++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi_bitbang.h |=C2=A0 1 +
> =C2=A02 files changed, 25 insertions(+)
>=20
> diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
> index ca5cc67555c5..3dee085d3570 100644
> --- a/drivers/spi/spi-bitbang.c
> +++ b/drivers/spi/spi-bitbang.c
> @@ -63,21 +63,28 @@ static unsigned bitbang_txrx_8(
> =C2=A0	unsigned flags
> =C2=A0)
> =C2=A0{
> +	struct spi_bitbang	*bitbang;
> =C2=A0	unsigned		bits =3D t->bits_per_word;
> =C2=A0	unsigned		count =3D t->len;
> =C2=A0	const u8		*tx =3D t->tx_buf;
> =C2=A0	u8			*rx =3D t->rx_buf;
> =C2=A0
> +	bitbang =3D spi_controller_get_devdata(spi->controller);
> =C2=A0	while (likely(count > 0)) {
> =C2=A0		u8		word =3D 0;
> =C2=A0
> =C2=A0		if (tx)
> =C2=A0			word =3D *tx++;
> +		else
> +			word =3D (spi->mode & SPI_MOSI_IDLE_HIGH) ? 0xFF : 0;

no need for ()

> =C2=A0		word =3D txrx_word(spi, ns, word, bits, flags);
> =C2=A0		if (rx)
> =C2=A0			*rx++ =3D word;
> =C2=A0		count -=3D 1;
> =C2=A0	}
> +	if (bitbang->set_mosi_idle)
> +		bitbang->set_mosi_idle(spi);
> +
> =C2=A0	return t->len - count;
> =C2=A0}
> =C2=A0
> @@ -92,21 +99,28 @@ static unsigned bitbang_txrx_16(
> =C2=A0	unsigned flags
> =C2=A0)
> =C2=A0{
> +	struct spi_bitbang	*bitbang;
> =C2=A0	unsigned		bits =3D t->bits_per_word;
> =C2=A0	unsigned		count =3D t->len;
> =C2=A0	const u16		*tx =3D t->tx_buf;
> =C2=A0	u16			*rx =3D t->rx_buf;
> =C2=A0
> +	bitbang =3D spi_controller_get_devdata(spi->controller);
> =C2=A0	while (likely(count > 1)) {
> =C2=A0		u16		word =3D 0;
> =C2=A0
> =C2=A0		if (tx)
> =C2=A0			word =3D *tx++;
> +		else
> +			word =3D (spi->mode & SPI_MOSI_IDLE_HIGH) ? 0xFFFF : 0;

ditto (and for the txrx8 function)


- Nuno S=C3=A1

