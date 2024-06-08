Return-Path: <linux-iio+bounces-6073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20612901306
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DEC1C20E7B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711B168BD;
	Sat,  8 Jun 2024 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiKL6VyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F212B95;
	Sat,  8 Jun 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867537; cv=none; b=C8TMwC/BR8XNLuC1k9bgzowUcGMdczh5TYMhq1sES0iWgeICFKHg+ZGKq5CUyzYbJ1YlWlQivkO4JJH2TUj86YEgKbxYiinnMGFJTLKaLMXso+GjoxCa9vARftiJ1CF2oBkyxf+xAMh5p05jKBlFzUtShTKnWaeLuaYyO6DD3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867537; c=relaxed/simple;
	bh=4BGebkcG/0moFKH00E5Mvmq2k1UBfOAWFppbpal6zFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo3XH91VS8GsUXpDZ4lJASTxt5L5ZB0G81ykGHCXxV3oCRq/VwXQZ0Qh/prJ4MWHL7VOB2OUEJNUN5SlpHkRjB6vQUYkRMOReNCAaeWdQWt5zV409y+2zjBgw2FsIEqGG2eAP+74f3DsCp/AY+OhLKWIb4dYFE8my2+p62PqjU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiKL6VyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E259C2BD11;
	Sat,  8 Jun 2024 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867537;
	bh=4BGebkcG/0moFKH00E5Mvmq2k1UBfOAWFppbpal6zFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiKL6VyZvjTKUoVKHqo133WqRXWS45YMly0SP98LPAsmZpBJG6oUUWM+CnqzqzlSC
	 Ly+WOvFPcZTKowGVa5x+J1g186xIIiQ+dhXtA0GRP9ah4QHNAqXUTJ6RmdfubYs2s5
	 vm2OOC286DYMtv3tccYgQlHX/h/jOZObXRXF29LUaUJakChrAbA2FKTysIBJl4yOGI
	 +XrhQlaXhUofZbg+H6FuT7DHH57r/GxWTbKJqlhXDWVFWR7d3sZqyg+mt8bM43sL22
	 Hla99sOlLAfN2SDppDtuo5euw8DA1e8gWK3ZPPqxQfLFuSfsOUrcZDYJC68mExuxrk
	 +Cht3rVpfkYbg==
Date: Sat, 8 Jun 2024 18:25:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lucas Stankus
 <lucas.p.stankus@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Ramona Bolboaca <ramona.bolboaca@analog.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Marius Cristea
 <marius.cristea@microchip.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] iio: simplify with spi_get_device_match_data()
Message-ID: <20240608182529.3fc8f30e@jic23-huawei>
In-Reply-To: <f7196ddf96551114204f7e8ba17b409fd3493202.camel@gmail.com>
References: <20240606-spi-match-data-v1-0-320b291ee1fe@linaro.org>
	<f7196ddf96551114204f7e8ba17b409fd3493202.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 07 Jun 2024 10:55:44 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-06-06 at 16:26 +0200, Krzysztof Kozlowski wrote:
> > Not tested on hardware, but code looks equivalent and should not have
> > functional effect.
> >=20
> > Best regards,
> > Krzysztof
> >=20
> > ---
> > Krzysztof Kozlowski (8):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: adxl313: simplify with spi_g=
et_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: accel: adxl355: simplify with spi_g=
et_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: max11205: simplify with spi_ge=
t_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-ads131e08: simplify with sp=
i_get_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-tsc2046: simplify with spi_=
get_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: addac: ad74413r: simplify with spi_=
get_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: max5522: simplify with spi_get=
_device_match_data()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: mcp3564: drop redundant open-c=
oded spi_get_device_match_data()
> >=20
> > =C2=A0drivers/iio/accel/adxl313_spi.c |=C2=A0 8 +-------
> > =C2=A0drivers/iio/accel/adxl355_spi.c | 10 +++-------
> > =C2=A0drivers/iio/adc/max11205.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
5 +----
> > =C2=A0drivers/iio/adc/mcp3564.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ------
> > =C2=A0drivers/iio/adc/ti-ads131e08.c=C2=A0 |=C2=A0 4 +---
> > =C2=A0drivers/iio/adc/ti-tsc2046.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +------
> > =C2=A0drivers/iio/addac/ad74413r.c=C2=A0=C2=A0=C2=A0 | 13 +++----------
> > =C2=A0drivers/iio/dac/max5522.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
1 +++--------
> > =C2=A08 files changed, 13 insertions(+), 51 deletions(-)
> > --- =20
>=20
> LGTM, just some minor comments/asks that don't really stop me from:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
>=20

Applied.

Thanks for tidying these up.

Jonathan

