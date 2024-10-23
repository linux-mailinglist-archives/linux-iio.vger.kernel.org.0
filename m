Return-Path: <linux-iio+bounces-10980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F69AC78E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 12:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B669BB2267F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C600719E99E;
	Wed, 23 Oct 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtPkbRih"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8977159209;
	Wed, 23 Oct 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678416; cv=none; b=ZFOBk3muTv9nCdxt78hXsU6KI2y+YSJZQpmAu0uU1EmAOBIHj2MZsyfG/3KU1ImJUyfqCIQX3lU4CNDwBZiB3esgn9d3Qy0Kz3lNy4ofe53luVcqbsbl9WbrmLiKZ8d/N52NAIFaYQADcpS22wS0bGULsxscPqFj+sjde91dAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678416; c=relaxed/simple;
	bh=jiFWTr1yK0c5qNSVHMLoMxrTZ5Q7ClvphQUAgHgsaQA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bfIexfJjXoywyzNaxB9dxQyWdxpwunzcFh1L5u56brQSLIIMfqMNima5xO/4f8KNvhcWXAE5mtr7t8jGw0cF9Ej7d/cpVyc1ouT2n1uyuZVbLwkDMwiUtZ7wpuDyBn9zxnhddhnkZY/1thg2wKXZXYzuuEaD4so5uTuCMUFeDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtPkbRih; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so67982905e9.1;
        Wed, 23 Oct 2024 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729678412; x=1730283212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D0rjMh1Id9nhsW30frAC0nQPf7+TS+o8M3NpIefQEM=;
        b=JtPkbRihtfrVY3jo0u23x86hZp7Zhu5wU+bitSSvZ+4U4P8QZY6Hwtz7I63Es0GjKb
         iBGcaLPCEw3jI/ILLuRhdopY7ekcSF/GLFdTu3EzJHrt7PVO+pkYCoxwLPtGEEizNOCr
         wfO7Ro2NfmWtVuebZvn95snAj/Zl+43jpiR9YdIWh1LS4RO4jdZMkMCrZlQnrUhpGASM
         5wT4SztbPnhJe/ghIy/jA3IuFWrYm6IFCy8sWZAWbnhu3CJuKnPLy8Tt7ZREyn47D8Vr
         sGj9LjZQBzfZWHt2GQiijyth38pgJaONflMiPwwo3mnyG48HQ2ddcYKs8yKjhL4kSWc3
         2SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678412; x=1730283212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0D0rjMh1Id9nhsW30frAC0nQPf7+TS+o8M3NpIefQEM=;
        b=ZraGnbEbGvRJT3euNX3Y0H9bkTNNxzu4DqfYFeCs+522wm1jOMS0HgmL3y1QqIA8CX
         fUbWB73h0jS59LMrkGWuPmk4Zh/jHBVOA0Dr05P7nMfeYuAJbEsjpRjVVC51d3VDCNlW
         mLVtbAwCGa8dYhi+jQhAWYZc7TwAZxO3VMoNb8ibRkoJAD1WEaZ4zTIJ0RkJuQmjfE41
         d2wY1I8nzYbX9KSDTsALyi9DzAP8JgOYIG/8998ZzIlsis11cwPtCS5xBRkKwJSCBGP1
         0JS/QNgkkTYQPbYpMHD14OEmP+fK5lIbYhm0DKtGQBQROsRw55AScHFTS3je/+uvI4f0
         eLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP5Zpq28sMS96eIJoYftdYeWgtqRskWSCWNHdnGR0UPbSr7fHjCueIA99VUpFRpYAUe+2uPifz4os=@vger.kernel.org, AJvYcCWbnt3oVvogEkvLwgCZM1DxIX6PhS4V1Nf2uZFvJG12edvuST/14KwXB/XKRv7jVlN/AlTQHrtcWKf/TLUD@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0eBQunKjlxmbDC/sT1Dczlzs35gFKJOVVLaUoorZhiB1ePlv
	0ZoOfo5+YaCYGw2ueNejihsWbvf+lB7iTkaL6erYCc0k7+gDoTeD
X-Google-Smtp-Source: AGHT+IEywc8szkUMHQDOljEex/6r3uy4FmMPF2bR5Hx5t6Pyhx6U8tx6rVawlFy2QLilLK8nOu8VOw==
X-Received: by 2002:a05:600c:3b16:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4318415b482mr15586585e9.18.1729678411627;
        Wed, 23 Oct 2024 03:13:31 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a3805esm8648459f8f.9.2024.10.23.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:13:31 -0700 (PDT)
Message-ID: <f81545a095136cd64b1991bae4027ad1dfe9597f.camel@gmail.com>
Subject: Re: [PATCH] iio: Fix build error for ltc2664
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Jinjie Ruan	
 <ruanjinjie@huawei.com>, jic23@kernel.org, lars@metafoo.de, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	nuno.sa@analog.com, conor.dooley@microchip.com,
 michael.hennerich@analog.com, 	anshulusr@gmail.com, sunke@kylinos.cn,
 kimseer.paller@analog.com, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-riscv@lists.infradead.org
Date: Wed, 23 Oct 2024 12:17:49 +0200
In-Reply-To: <ae939f90-c23f-483b-b4bc-70891d0de167@gmail.com>
References: <20241023082309.1002917-1-ruanjinjie@huawei.com>
	 <ae939f90-c23f-483b-b4bc-70891d0de167@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 10:41 +0200, Javier Carrasco wrote:
> On 23/10/2024 10:23, Jinjie Ruan wrote:
> > If REGMAP_SPI is n and LTC2664 is y, the following build error occurs:
> >=20
> > 	riscv64-unknown-linux-gnu-ld: drivers/iio/dac/ltc2664.o: in
> > function `ltc2664_probe':
> > 	ltc2664.c:(.text+0x714): undefined reference to
> > `__devm_regmap_init_spi'
> >=20
> > Select REGMAP_SPI for LTC2664 to fix it.
> >=20
> > Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and
> > LTC2672")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> > =C2=A0drivers/iio/dac/Kconfig | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 45e337c6d256..ae6d04c758d1 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -381,6 +381,7 @@ config LTC2664
> > =C2=A0	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
> > =C2=A0	depends on SPI
> > =C2=A0	select REGMAP
> > +	select REGMAP_SPI
>=20
> Should you not replace REGMAP with REGMAP_SPI instead?

Yes, I think so...=C2=A0The commit title could also be improved

"iio: dac: kconfig: ..."

With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
>=20
> > =C2=A0	help
> > =C2=A0	=C2=A0 Say yes here to build support for Analog Devices
> > =C2=A0	=C2=A0 LTC2664 and LTC2672 converters (DAC).
>=20
>=20
> Best regards,
> Javier Carrasco


