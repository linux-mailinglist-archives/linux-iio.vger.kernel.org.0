Return-Path: <linux-iio+bounces-27706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40CD1D479
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C46F9301E112
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E2638A28F;
	Wed, 14 Jan 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKC4+V1k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68846318EF9;
	Wed, 14 Jan 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380794; cv=none; b=BCx0+gn5Ktq/x9vJEtSvYuXc6evF/khQvnI4ksA5szZUQjrVIyq9ceI1RxixVcdo0f853nKeedkRt4jHuF+WgY3ggTebSrruAP/woWTcK3se7GRp2iLWzbhBti9aEqNJdk+QHoBn+/qiDuf8AyP1iGKwx+V1ot3EPqy4LxkbOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380794; c=relaxed/simple;
	bh=maYp5iHu1cF54kNquIO/o1Q+aq8LtDTD0BrmiaqQtVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN+1urnjuexuSSlbzBbQyF843oF86+k9h0zVkoIkppXYjnuL2q8Qw9QhEOxLvqJ0DCy3EOdhuAQfpA3eQn6sTJHWSLZCXn6ccaGRBnuf4HYHVqcIGG7tjFkymaMDaFm5vICEvQ0NUhi9sXxbXYqTGGjYdB/8pMUFOWUxNzOaMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKC4+V1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44167C16AAE;
	Wed, 14 Jan 2026 08:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768380792;
	bh=maYp5iHu1cF54kNquIO/o1Q+aq8LtDTD0BrmiaqQtVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKC4+V1kQnpfrq4u9cxDvfgeRq94MWV0znDTlaZfRCOwAkObTGHNo3x3tnS0TlJW9
	 b1r5NHjbGNow+W6zF3A+51ocW3ObftPQvIKdc5l+MePWUGrNIFKW00oTb1ivUdzz/T
	 6hQM51g6WutIZL8UCsDhsvfrP+Ls0jZdlV7KT7T93yYoUf9dwBxr4+ydEGk5xzrucf
	 zcMel3L/p9dB9PqpmnoaIkdm/1h3UZAPfNhZFxJsePP5QOfGYJpt4tMIgaBkRqM3Sh
	 O/c8CfHNPWvb/8U7AHBe2FXjAX1tZy4q/34+rwTTgdp91mDAbU43l/A+np2dW7jr0f
	 oaiTxhAzTC1Nw==
Date: Wed, 14 Jan 2026 08:53:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 2/2] iio: pressure: abp2030pa: remove error message
Message-ID: <20260114085302.6650777d@jic23-huawei>
In-Reply-To: <CAHp75VeUkNEHeF5ey08AU+drZKunL5PzoSJ=0JPXzc0Z2Um3ng@mail.gmail.com>
References: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro>
	<20260114-honeywell_abp2_driver-v6-2-231c3a8c222b@subdimension.ro>
	<CAHp75VeUkNEHeF5ey08AU+drZKunL5PzoSJ=0JPXzc0Z2Um3ng@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 09:55:22 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jan 14, 2026 at 9:52=E2=80=AFAM Petre Rodan <petre.rodan@subdimen=
sion.ro> wrote:
> >
> > Do not print redundant error message if devm_request_irq() fails. =20
>=20
> the duplicate
I went with "a duplicate" as it seemed to read better to my ear.

Tweaked and applied.

Thanks,

Jonathan

>=20
> (It's not redundant, it's duplicate because that API prints something
> very similar.)
>=20
> P.S. Do not send a new version for this, I hope Jonathan can tweak
> this small detail whilst applying.
>=20


