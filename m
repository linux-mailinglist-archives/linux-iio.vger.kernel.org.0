Return-Path: <linux-iio+bounces-26084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 466CEC441DD
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F7E4E64CF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA372FFDF2;
	Sun,  9 Nov 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv/TTDR8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16762FB097;
	Sun,  9 Nov 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704349; cv=none; b=OQxCVljvdiAXdI/XAgXGbd0h4NPIvRBlHlm1IswaIOryWqyzWTYmRU06iAHOfjyhPnORzXU6K+CdWK324AlKpaUe2FKIZa2QE1MtwlbnAUzpxEUWFQefA04XRE6O8DzFBIbfBmY+ffrlUJOREckrOErf5oTl/eqAbXxS1JZtFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704349; c=relaxed/simple;
	bh=sUvdDPcDcxhNCLuhjUTei3EeLv3TsAfmINm6z4b6VbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wvc2/Se4+5wVgNAUZP+uUrDr0i8dNcD7LTovmBMWzTnYTpS/YWrpn1rpmRyKlZpOpKGfGjILg2/SWGwO0G/tG6TMgpk/JGY4kbc2fhQ3C47j4G2px2f199M7JW4HCclSY/z6O0r35hpN7cV7WNp+/IGXIgaiAkS0bjFIf4+05ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv/TTDR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D37C4CEF8;
	Sun,  9 Nov 2025 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704349;
	bh=sUvdDPcDcxhNCLuhjUTei3EeLv3TsAfmINm6z4b6VbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bv/TTDR8cmPiXSu04wE2d/mFjhCGn/hDbN2y2nAYcDUHb2SxEcA+aeSjA17ryjfGQ
	 o4kn6dU1Js63jJizP5Mp38GaWTwjlHkPdMTNp0f1pKBcx25wSSYqrxT4QTDbrZ2ymg
	 YmiBgJt9p4SSItAJ9n+IGDB1egbU/pDJIIp2yYerBT6cPm/yvfIDI1MP/Of6Go1Xgu
	 LtyPjKNnd7U4cyjBOVuZYVWGm+y3DkG4JSjkVvMrZhLruVrtNsKgD1zAJ4BZ84CFjx
	 HlzRHoxF6pFy/b2QP9YPzzA718DrwMsZuwVQyCz6a9eWcZTWAXVvVGg7UhqgDt0lLL
	 PBjqrF8vtRGcA==
Date: Sun, 9 Nov 2025 16:05:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich 
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen	 <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/12] iio: dac: ad5446: Drop duplicated spi_id entry
Message-ID: <20251109160541.321a3918@jic23-huawei>
In-Reply-To: <76274ec104107516fb5b2d4e07bf95ef7c41a4cc.camel@gmail.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-3-6fe35458bf8c@analog.com>
	<aQo0AKjQUNN9FCDR@smile.fi.intel.com>
	<76274ec104107516fb5b2d4e07bf95ef7c41a4cc.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Nov 2025 10:16:07 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-11-04 at 19:12 +0200, Andy Shevchenko wrote:
> > On Tue, Nov 04, 2025 at 03:35:08PM +0000, Nuno S=C3=A1 via B4 Relay wro=
te: =20
> > >=20
> > > AD5600 and AD5541A are compatible so there's no need to have a dedica=
ted
> > > entry for ID_AD5600. =20
> >=20
> > Suggested-by? =20
>=20
> Oh sure, that would make sense yes. Maybe Jonathan can do it when applyin=
g...
Done whilst applying.

J
>=20
> - Nuno S=C3=A1
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com> =20


