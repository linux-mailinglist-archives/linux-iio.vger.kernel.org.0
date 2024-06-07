Return-Path: <linux-iio+bounces-5975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 978FD8FFE77
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339A31F2A16D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19115B131;
	Fri,  7 Jun 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIrYytqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDD18030;
	Fri,  7 Jun 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750424; cv=none; b=RGd5o64APa3ANvrAoEjXRP3BXeBonW6u4OvW4kgSaS9xjLdTnUtWkQ1DYBRqk+7YCr+8nd9l2wStfLUKcxeq7yRlRQhF6sEI59JKcRNKM1eAnIb18s5puiucXqmn44wZuayr33E8xBtHVZflbJh75jkVrIvK7ATj8SZvYww9SPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750424; c=relaxed/simple;
	bh=fTlaz4YzoIgFrsTHKkk4onrpRqCKI0V6DGDA8huFHEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seW1MoBkxo6xcA04Za4QC4ksHoA5fYFFApPwKH4a+woJ7JQn2/aQrMU8622ImoDryjW9KD0RvApvKeMeZmcNCOEY5q7jIDnWtpYwBDn9EkuYxgQ0t9U27U0JdwqoRgxocJCI7G4VHtckJRWBlNmVwfgkvLdb5SFejlyLUpcXSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIrYytqz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaa80cb550so21400761fa.0;
        Fri, 07 Jun 2024 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750421; x=1718355221; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJpntV1yf55hZRhCo04UHW16Iuj7l3TUdMsrXfsJkv0=;
        b=IIrYytqzmChHx+jfuSoMWt1JArXH3DBj8fnkh5L0NNZHZJ7IsJMYARnNVnR88ZYB3n
         s2hkM948wK0VkWMOxjoh12nR/2EIU40MXdVQ7+dIO41XQqhGkvnBmeYkGb95UMg5UR/v
         dszVbrIVMDbUzGCpxOCfJd1x8myj9hUFiu5wO77hklF/1BqKvQs0K/vUc3Io7Mxa3CdE
         EePV7o6bRt5Js1pewGB7N5TqiRhbB6irChKMaUEqQ2U7m6Au2AXlUZWfqhWJYWY5PL0v
         uPC/p3LgNFOvf8icXHlC1KOMkf17Q9VlAhKC+DrmaH7u5+FpHN5mmHMbRRZ+2Cs1A96b
         j9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750421; x=1718355221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJpntV1yf55hZRhCo04UHW16Iuj7l3TUdMsrXfsJkv0=;
        b=m6hADEtAz332elUTdUEE96pn5M3hY8LWDvp3/VlEmnLOpvR4WMJtvFe/ms80mA3Tfl
         Ql2nATGc+XG0Y4hhmEDyw1M/ivOfYC+rOewqn0cpHRiRJKK49Wp3x5ff0Db8jG4bAQXv
         ZtckEXetBAvWuarHStZuTozyEJ2Hp8sw8M4qr779mBnO4WsmDNGbJRrYSKMmG4tD3BIG
         pgr5SCbG8zahjWlTkaqM+sn4EpZPlk7VlsAUmhmfjj5kRWDGHYs1LZbYN3IHALUhNBnA
         SVFzri0Xm9ppbqoqgGXgFihpNwfKIfWjGLRUggZBhW7rMSWKeJesPUZ0gPHGuO95QFAU
         63uA==
X-Forwarded-Encrypted: i=1; AJvYcCUdYaWgDnhI4tVa91cHM55/lBVG6J/fLjwKRywEAUvKtQFa/w79mvxwe1yZC4N2f01AP9OXpws1vHAkDG+gG2siARQfUFB7ywBi+lwL
X-Gm-Message-State: AOJu0Yxgz1POKDILAtBF7npOasp3h+8uvZYvPEQhsmVphnvRkS8ZfZaF
	IzwJrNxjHiKkzFMCPGsjTiA5gSYSOG3Bj3obFrRMcvtWVh0Woyfd
X-Google-Smtp-Source: AGHT+IE2i5pJiSYLy45PDFEkAAGtOAVP+pyOPT0wzmAzfEWH5FKKs8VVfmrjkN057G89C0PXQt6Zqw==
X-Received: by 2002:a05:651c:4d1:b0:2e0:752c:1f2e with SMTP id 38308e7fff4ca-2eadce1bd83mr15264851fa.1.1717750421112;
        Fri, 07 Jun 2024 01:53:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9ea35sm2393208a12.15.2024.06.07.01.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:53:40 -0700 (PDT)
Message-ID: <7ecabb8e342b9bd4fc2552bce29dc8c7a98971ee.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: accel: adxl313: simplify with
 spi_get_device_match_data()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lucas Stankus
 <lucas.p.stankus@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Ramona Bolboaca
 <ramona.bolboaca@analog.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de, Cosmin Tanislav <cosmin.tanislav@analog.com>, Marius
 Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 10:57:28 +0200
In-Reply-To: <20240606-spi-match-data-v1-1-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
	 <20240606-spi-match-data-v1-1-320b291ee1fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-06 at 16:26 +0200, Krzysztof Kozlowski wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0drivers/iio/accel/adxl313_spi.c | 8 +-------
> =C2=A01 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_=
spi.c
> index b7cc15678a2b..6f8d73f6e5a9 100644
> --- a/drivers/iio/accel/adxl313_spi.c
> +++ b/drivers/iio/accel/adxl313_spi.c
> @@ -72,13 +72,7 @@ static int adxl313_spi_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/*
> -	 * Retrieves device specific data as a pointer to a
> -	 * adxl313_chip_info structure
> -	 */
> -	chip_data =3D device_get_match_data(&spi->dev);
> -	if (!chip_data)
> -		chip_data =3D (const struct adxl313_chip_info
> *)spi_get_device_id(spi)->driver_data;
> +	chip_data =3D spi_get_device_match_data(spi);
> =C2=A0

I understand you're sticking with the original code but since you're doing =
this,
could we maybe add proper error checking for the call? Maybe Jonathan can e=
ven
tweak that while applying...

(same comment for patch 3)

- Nuno S=C3=A1


