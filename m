Return-Path: <linux-iio+bounces-6079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1F901317
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2C81F21B8A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E91C6A1;
	Sat,  8 Jun 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efsnHbWp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24D1FC18;
	Sat,  8 Jun 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717868657; cv=none; b=grthrSlcRCxVncqVUV1yvgOLV/mntGfkm9kK4nqogsnYPq01dVuMup7EELJHXB+1Plg5ql2s0xXMIgMQV7L9kbq+wTOs5rK2xmyuZCLodiKfIHQaL6KPrCB9vSbMGjus3O80GEnzvypTY/uGZZPh5yubgo+oQgcKGfW8SbZbHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717868657; c=relaxed/simple;
	bh=hvWsrTbBgumYKTUSkkB2KU76v6GG4PeU+81uyBO0di8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boe5fQDdYVlqspYSFAbVeAdy8nE8u0161kd8Rc0zRrb+KcZEczeQNZddd7/lqcj6z34lwWqK3ycdlJzw8XvWwLCQ58A9a5qcBkmENI7XqylQz3FnfnYNpySuHO6+TqnUFi4f+hyROkifJw0nX/26meA6A/ZUl8ygI2Q99ZO3CJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efsnHbWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8DC2BD11;
	Sat,  8 Jun 2024 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717868656;
	bh=hvWsrTbBgumYKTUSkkB2KU76v6GG4PeU+81uyBO0di8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=efsnHbWpkZWap9PHnfl1TgcF9tP3Tc56Dle4LYSs7K0T5WMogbBkG+TskIVlfimpg
	 kVB5gmjGa2w21h8CgDPcJIGPXB9MxFYcclcP933F3glOoz5J908muGSLD3R3zl4b5P
	 Z6qB1TyYUyPOmUUYb42af+lXW2kIMYIg4WFfGQLws0SNygKfaG31PrKigDjC7gLXNY
	 bGqr70HMJbrCyMx+LHpi4pA3XKUiNULX7JJudt0JYYDsgwi3G9nttxv6L/46bzBVkV
	 obODCDfVV2Ou8UIau95ilhWeuNj0aKrRdUIaIh80+9SkbMKFrd8lJAApcz2oTB8f2Z
	 MGPl4tAIFhkDA==
Date: Sat, 8 Jun 2024 18:44:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com,
 marius.cristea@microchip.com, marcelo.schmitt@analog.com,
 fr0st61te@gmail.com, mitrutzceclan@gmail.com, mike.looijmans@topic.nl,
 marcus.folkesson@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 4/5] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
Message-ID: <20240608184404.5c34668f@jic23-huawei>
In-Reply-To: <575186dc-8a4a-4d93-98f0-d2271b0aa1fb@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
	<20240604123008.327424-5-angelogioacchino.delregno@collabora.com>
	<CAHp75Ve8qPLu+gS8o5Q5A20j_+AP_UVkOzdKqcnhUawA_sW+VA@mail.gmail.com>
	<575186dc-8a4a-4d93-98f0-d2271b0aa1fb@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jun 2024 15:24:31 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 04/06/24 15:22, Andy Shevchenko ha scritto:
> > On Tue, Jun 4, 2024 at 3:30=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote: =20
> >>
> >> Add a driver to support reading the Auxiliary ADC IP found in the
> >> MediaTek MT6357, MT6358 and MT6359 Power Management ICs, featuring
> >> a different register layout, configurationm reset and ADC reading =20
> >=20
> > configuration
> >  =20
>=20
> Oh, oops! If there's no further comment to address, can this be fixed whi=
le
> applying, please?
>=20
Yes if Rob is happy with your response to his question on the
dt-binding.

LGTM as well btw.

Jonathan

> Otherwise I can send a v3 :-)
>=20
> >> sequence from the other already supported MediaTek SoC or PMIC
> >> (aux)ADC HW.
> >>
> >> This driver provides multiple ADC channels for system monitoring,
> >> such as battery voltage, PMIC temperature, PMIC-internal voltage
> >> regulators temperature, and others. =20
> >=20
> > Seems all my concerns were addressed, so
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >  =20
>=20
> Thanks!
> Angelo


