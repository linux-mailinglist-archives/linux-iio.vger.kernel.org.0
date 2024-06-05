Return-Path: <linux-iio+bounces-5812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7333E8FC63F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0191F24E60
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01084192B84;
	Wed,  5 Jun 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJy9LTzo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75619006C;
	Wed,  5 Jun 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575757; cv=none; b=Svb7S9U1Gt0GDivA9qLNge/kNHCzKDReY4lkif58GllP2ziyoh+1An4Ky8IkfDkUJaSN57YVc0xvxdOjYH7Jv/pyaBJt45MOu3m6839gQ3eKkNqkujoE5b6gj4qePcf9apPXA0mt4EHr0rxIceaaALhyjvVioQAwEH6ST2AWCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575757; c=relaxed/simple;
	bh=b5n7KdQZMcBanjfHL40woh+5PQIBJq9kn+ZjlhARkK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmGhGUua3sZOZgK9KzWM07I/9YWGYFPRHduIokIsfvOvdGAX3bUpAJHubOv03F1s5BQg0/ItUgku5JzwxbhOQeDboCNoMiXbw+/hb0gPG7mpMXMQj1P7yONSelwy47D7/x1RWP4cZYgQQqYTjEKeinwgGWw5UMWUfWakRbdoa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJy9LTzo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a6985ab58so1666549a12.2;
        Wed, 05 Jun 2024 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717575754; x=1718180554; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b5n7KdQZMcBanjfHL40woh+5PQIBJq9kn+ZjlhARkK0=;
        b=mJy9LTzo9g+rT6pbwShOi7SocjIqNl4lwIH34i4lIxrogEHljefyTrkHatIw6bEe+f
         MNf+mUpRHtTmzIqb2O4TTrnZQxgdX1mNWJBVH5u3AimET7NXA3Nt6CqsxSvrHJxzhOBv
         WgiV7ZNpl3AM/SHrsSXL8vuf20gJjO1w18irfetRHarq6r/YZluNEEUfOxrvXQmJZmTy
         I05VQXBVTuAL+MpRTXr41pRFWAKXdwi5Iz2WgKcdw5QOte2mpQUxYYBGdT3sFvoIwW2S
         4+Gn0qaDGj7bb+Rf+WO0zQVQBSKwY4q5NOxWMVM7B9GT9aLt9GdGUD5eEB4eUL/yEghz
         3Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575754; x=1718180554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5n7KdQZMcBanjfHL40woh+5PQIBJq9kn+ZjlhARkK0=;
        b=FUl2oQNLv7mv10lkjRHrIuHxp38gRT8RtA4zynUkuewQS6O1R1YRGUZDQ9iGMPXa8y
         n4g2bhhKZd6Pbh2njG3vuAWwxJvavxa/7+EXYBkJ326z8BW9DTxLlt8gxXflNGfxcqZJ
         mxWUGtX62URrU3aq/sUuJEAWmlNO4eBby4zMO1CAVnrxF5N1eoxJV9uHah4yf7pX7kk6
         A+T9Ae5rdCH+xoj0bljdSYdAUjGDK6eJKrJGpRxZGICH12bVaC7fVEVQUKnRlo6N6pnH
         q4yD7YJKFXfqXzxFk/DDkLcq3Diwp2fV+iZUlYF4h/8nh0FOtM9IjLDrFtIaLt4fBNWt
         BZAw==
X-Forwarded-Encrypted: i=1; AJvYcCVrSMR2gc50whL5sr9D3gW4+JameV4qdgg4HzPRtwbzsPpIaHz757TPAS/cy+idICEH/6oD8mq/kfjOOPyiqJc3LFktr2ZJOCq2fQc4qYfdidHGDJfkfERpATsmitYPXbRjUUlCaEOBF6hXgqyOW8kiqDbyov1lL3Oa7BYOpnSyrMi3qQ==
X-Gm-Message-State: AOJu0YxjURRoviIqxNjY7CsHfBkX18NRljoQgehvVz8yQ+GLrMqC89Gs
	R1WMJs7ihG/Be4wNPlacUjQC+TpeW438xTNy4bStO7NcH9FvLQ6O
X-Google-Smtp-Source: AGHT+IGF9ZlwicG+VylkHEpngevqNQnxECBfr+6sO6YTiHWqFVMyOLXh48+ipvxpj7HpE+n5R6BrlQ==
X-Received: by 2002:a50:9ee2:0:b0:57a:2e6c:c089 with SMTP id 4fb4d7f45d1cf-57a8b6f23e0mr1661477a12.19.1717575754127;
        Wed, 05 Jun 2024 01:22:34 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a873a1aa0sm2038004a12.38.2024.06.05.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:22:33 -0700 (PDT)
Message-ID: <8dcac591e5dc9d4cc1a6cf89512d08ef12457474.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: ad7192: Fix clock config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Date: Wed, 05 Jun 2024 10:26:20 +0200
In-Reply-To: <20240605075154.625123-2-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
	 <20240605075154.625123-2-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 10:51 +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock, which can
> be made available on the MCLK2 pin.
>=20
> The presence of an external clock is optional, not required.
>=20
> Fixes: f7356e47032c ("dt-bindings: iio: adc: ad7192: Add binding document=
ation
> for AD7192")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
> =C2=A0.../bindings/iio/adc/adi,ad7192.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++++++---------
> =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index a03da9489ed9..c5a4219a9388 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -39,11 +39,16 @@ properties:
> =C2=A0
> =C2=A0=C2=A0 clocks:
> =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> -=C2=A0=C2=A0=C2=A0 description: phandle to the master clock (mclk)
> +=C2=A0=C2=A0=C2=A0 description: |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Optionally, either a crystal can be attac=
hed externally between MCLK1
> and
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCLK2 pins, or an external CMOS-compatibl=
e clock can drive the MCLK2
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pin. If absent, internal 4.92MHz clock is=
 used which can be made
> available
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on MCLK2.
> =C2=A0
> =C2=A0=C2=A0 clock-names:
> -=C2=A0=C2=A0=C2=A0 items:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: mclk
> +=C2=A0=C2=A0=C2=A0 enum:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - xtal
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - clk

Not sure about changing the name of the clock... Isn't this breaking ABI?

- Nuno S=C3=A1



