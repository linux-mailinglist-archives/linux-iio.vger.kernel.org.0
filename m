Return-Path: <linux-iio+bounces-5974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3228FFE6E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0841C21E16
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E9815B14B;
	Fri,  7 Jun 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D774fQyl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE7647A6B;
	Fri,  7 Jun 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750320; cv=none; b=OLvHCzevI+nfQfrDlsxtYmtjrlKfRk6qCyTAxdghvHvj6g4snYdpKkCLgzUzl5fxjJNYmUCdl0zPMqW3tRF4eTevO3Qj2PIj/3Y5rteiRxA0Ld5OVN1yke647iEGlabBA9Z0YF7oZ/Ko70M/BdatcgMSaCuY9hLrQg5IfzTdqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750320; c=relaxed/simple;
	bh=g2XJhYP/BhrqpNm1t9IQIHdIlQAxxcALbbw+tPunz/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojwCgD2/6AWsOqRsKTX+bPtzrT0fD4+QmYzHCJkojPG4lsBjwVRsKynYlprT2eckeRWT8DKuO3/m3Z5N9or49MSiiPNDQMbcCDXbqKEz3vW16VYtS284WCsWioQlstca9Tv3LMm2xINNciy87KDGdE6mRp8HaRdly8CrbShaicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D774fQyl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68bf84d747so174622466b.3;
        Fri, 07 Jun 2024 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717750317; x=1718355117; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g2XJhYP/BhrqpNm1t9IQIHdIlQAxxcALbbw+tPunz/c=;
        b=D774fQylL+W8IppUEowKWNKwE7I7dKJC2uZ9vWnmUDytS6VeAwq6qtonSDwi/ooKgS
         GNzG1zBl7CXS+sZEl6ff1pgXd0RJO88s2UDRusSUnYxAd4v/26bFMbWt0iwDw3k9Rcbx
         Tb4hvqbC270PqKRaemniRISKPae1ebo1UWFtnDbcvuyxqeunhEflXvHLcA441+nMWTMq
         DTRAPJG9NOKjmr5ivMdlB8mxYtmdBXrPxX54FhakXZR3JxKkHbHXHQBLDvhvym8Yk/Kw
         mGthm0TkCyH/cka7wABpw4BonHoDklDwdeuPlkDY+FjQoMyo1ISUYpFk62AzjEYyp8gf
         J33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717750317; x=1718355117;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2XJhYP/BhrqpNm1t9IQIHdIlQAxxcALbbw+tPunz/c=;
        b=CpYzqZokDwXZZxbaT8uB/2T3ICB0TmOtt49Kc4uZXvo2rkbJxdkymEna6JIpFnrUr0
         nKAXZbzZqIfwT7IWukcPxHZq1RDewl6INJO1jcxCoXFPGPG1WY4SPwEpVA6qrN8/WpST
         LnmioWV+jZDQgtODz+v7AoOWgerzVBFXktMtisxkKI1nMvQekw3D8RJ67zcFwuF18O2t
         kwi6TVwrfhML3h+mxUrTIesHPf0N3nat3/3fR4u20Ni1G1tNHPRftkK9Cb0fK4Ei2R4W
         US4bfaonQZ4KScqvEewBeofFpKazrDXTSeCLNoACnNc4tI3e+jMySYg3N6IFzvKiZNum
         0M+A==
X-Forwarded-Encrypted: i=1; AJvYcCWWPTMhJeCToZ/qTbYOhLtOFczqe+T5W8tsu8WH4WXDKVAeHArWTpBy8UIAvD2UeDlzV3eogz/PWX3JcK9Ju31XOMNKPrXhwQgIAOmB
X-Gm-Message-State: AOJu0Yw4KaulsgAHT5THo3P8DBuzK0trl7BZG/ALqBeWrlGHnphXhdln
	RBJrsYCtYYftr7pgGc/5DwWGsbhe+DdEgk6fvKz8zoFhrlpT83Nb0J4FWuniqr+pyw==
X-Google-Smtp-Source: AGHT+IGIbTyaGYUok3BdXJZPibjwU4JWMyIf7Na75CKDwsGx7YyKC32/n8C5cTIow4xgBFjiivbNLA==
X-Received: by 2002:a17:906:2c16:b0:a68:a800:5f7e with SMTP id a640c23a62f3a-a6cd561f12cmr129787266b.10.1717750316932;
        Fri, 07 Jun 2024 01:51:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8072ad35sm213377666b.213.2024.06.07.01.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:51:56 -0700 (PDT)
Message-ID: <f7196ddf96551114204f7e8ba17b409fd3493202.camel@gmail.com>
Subject: Re: [PATCH 0/8] iio: simplify with spi_get_device_match_data()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lucas Stankus
 <lucas.p.stankus@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Ramona Bolboaca
 <ramona.bolboaca@analog.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de, Cosmin Tanislav <cosmin.tanislav@analog.com>, Marius
 Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 10:55:44 +0200
In-Reply-To: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
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
> Not tested on hardware, but code looks equivalent and should not have
> functional effect.
>=20
> Best regards,
> Krzysztof
>=20
> ---
> Krzysztof Kozlowski (8):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: adxl313: simplify with spi_get=
_device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: adxl355: simplify with spi_get=
_device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: max11205: simplify with spi_get_=
device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-ads131e08: simplify with spi_=
get_device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-tsc2046: simplify with spi_ge=
t_device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74413r: simplify with spi_ge=
t_device_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: max5522: simplify with spi_get_d=
evice_match_data()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: mcp3564: drop redundant open-cod=
ed spi_get_device_match_data()
>=20
> =C2=A0drivers/iio/accel/adxl313_spi.c |=C2=A0 8 +-------
> =C2=A0drivers/iio/accel/adxl355_spi.c | 10 +++-------
> =C2=A0drivers/iio/adc/max11205.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 =
+----
> =C2=A0drivers/iio/adc/mcp3564.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 ------
> =C2=A0drivers/iio/adc/ti-ads131e08.c=C2=A0 |=C2=A0 4 +---
> =C2=A0drivers/iio/adc/ti-tsc2046.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +------
> =C2=A0drivers/iio/addac/ad74413r.c=C2=A0=C2=A0=C2=A0 | 13 +++----------
> =C2=A0drivers/iio/dac/max5522.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 =
+++--------
> =C2=A08 files changed, 13 insertions(+), 51 deletions(-)
> ---

LGTM, just some minor comments/asks that don't really stop me from:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



