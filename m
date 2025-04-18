Return-Path: <linux-iio+bounces-18251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997FA938CE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0E31B65331
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466401D5174;
	Fri, 18 Apr 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAoiXPqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE71D5173;
	Fri, 18 Apr 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987513; cv=none; b=Wsai/ocjx9Sm6NxudtecBU0Y/GX3ei7NYj7aAncUqJvxUIA6K94fF0CGGlFHbLvEXfkI6J3Q5qV9c/kodLX8prOFoudSwI/WUbCi9peQGg9s6w9G+H0+0I9Rf5tY+z3NxBBd8otjM0xoytQXiPODcsltb6zUOaT7glyDaIt0iWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987513; c=relaxed/simple;
	bh=utxZwt7Wqzcm1s9IdpF2wgbei9+hqt0bzhTr8EybsA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUikfh7FSPqE5GQXM/u/ikzybhYqddyWwmMPU5xdXgFo8HEDwn9LutJVN/ynL1iKK0X/QCbVXjKRFDXy0SxLsZqgdjGJ8u+lPcK5xb2+jgmg+xX7i2002bpONO7QTOPdzO/23fk9pvwPK/X5rAis4yHOuas66SUJjQ2Jq8KJ1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAoiXPqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5757DC4CEE2;
	Fri, 18 Apr 2025 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987512;
	bh=utxZwt7Wqzcm1s9IdpF2wgbei9+hqt0bzhTr8EybsA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAoiXPqFDjte5rVJPYd2xgnWlRBcPl9S9IdtCaKbaKffdzN9+vkyRSTF5AE55fopF
	 sAyZfZqOybSZ/+h/4hUwnlVyyZdhPVSgQFmEXF4GRi5kvsyVBevhRDA4FcN+McPul+
	 tUwlCdiicfmhqYODJMbCxQQMeOudrwuOSpSRiO/D4SGQnF00TpClePd+K7ax6lYuKv
	 p3V+UEU2/Gl4qVH2dIatScCsjuk1sHO84LuL+j3NZyWWXSlqluHrcRDNUWEW13I2xZ
	 /SgxgHnZdtaXzKHdCzWDm4tZhgWQQ97QMnoonE2+4ilw3n3II+xIbZffE5EDYNa04M
	 yK7dg2a2DKEXg==
Date: Fri, 18 Apr 2025 15:45:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/8] iio: adc: mt6360-adc: use aligned_s64 for timestamp
Message-ID: <20250418154501.566138e3@jic23-huawei>
In-Reply-To: <d3800b1fc2430d897750541219e39fd43216b199.camel@gmail.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-2-eafac1e22318@baylibre.com>
	<d3800b1fc2430d897750541219e39fd43216b199.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 09:57:09 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> > Follow the pattern of other drivers and use aligned_s64 for the
> > timestamp. This will ensure that the timestamp is correctly aligned on
> > all architectures. It also ensures that the struct itself it also 8-byte
> > aligned so we can drop the explicit __aligned(8) attribute.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
>=20
> > =C2=A0drivers/iio/adc/mt6360-adc.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
> > index
> > 4eb2455d6ffacb8f09a404df4490b5a11e49660d..f8e98b6fa7e923c6b73bedf9ca1c4=
66e7a9c3c47
> > 100644
> > --- a/drivers/iio/adc/mt6360-adc.c
> > +++ b/drivers/iio/adc/mt6360-adc.c
> > @@ -263,8 +263,8 @@ static irqreturn_t mt6360_adc_trigger_handler(int i=
rq, void *p)
> > =C2=A0	struct mt6360_adc_data *mad =3D iio_priv(indio_dev);
> > =C2=A0	struct {
> > =C2=A0		u16 values[MT6360_CHAN_MAX];
> > -		int64_t timestamp;
> > -	} data __aligned(8);
> > +		aligned_s64 timestamp;
> > +	} data;
> > =C2=A0	int i =3D 0, bit, val, ret;
> > =C2=A0
> > =C2=A0	memset(&data, 0, sizeof(data));
> >  =20
>=20


