Return-Path: <linux-iio+bounces-22499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3FB1F5FE
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A5918C10F6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47331F3B87;
	Sat,  9 Aug 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b61cHcgE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51F1B423B;
	Sat,  9 Aug 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754767332; cv=none; b=QYgybX2tt84zO3ApKTSf0U56JKh/NN2ZgRoyGH7c+mVSmOW09x9R3/bNcd7aZ0onmpeHX7UChYxll9Yy2vdQUBZwpdJbIGlcujHhq31bO5eQtadpw5/R0jFBcRpgMPHLxJ+glx/Xli3fUYxb/Fr5AGhsSLm2/fX5KJPDtIhZWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754767332; c=relaxed/simple;
	bh=dTYI6HG9XhEmduuLLqVa8RT6OSYbSeqBodI5jXTWud0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ej6xUFKkMzTBf9FiyTx1yImbMDVE6SZUGEudkIxxFX7zG46X+j6hk9UOBISWBFdM49P5Ctio0RPNHCmWrglKfsyJc3aE8PzXXznFJnGjSGnIOseklJkWKmKjtP7niUAWz9bqJkGHOar19D8YQHBa9K9htqhdlbNERe2YGiCBiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b61cHcgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDFC4CEE7;
	Sat,  9 Aug 2025 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754767332;
	bh=dTYI6HG9XhEmduuLLqVa8RT6OSYbSeqBodI5jXTWud0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b61cHcgEeB2lIVpDFDD/RvevYf/pEhkCcJgZzr522b3ZpVRGuNYk7rl+Yx7RP33fH
	 RtfFS87Afl4wV0TpYICatYDeON4ZxHV6zoNCPHi6g7bY9ZH0KW+8nb7KcFBfS6/lk4
	 ZS985UvTUvGzRLQoNuSh6nYEy/Pre2IPxwJafaO+uUKolEqYZm1YbK5suObQ71MuyI
	 gIKtTnF1GQOZWmdPGKXLfErNJt9oL5y9RsnNlNfpHrbHjbaFlCDov1uqOt4WoHOony
	 ZkxeWPAUy+fuMB0OvzghOd+Oilr4CAoPpo/gAXJkJ0O7CZV5zYvXQsfGQC8PbVdSXM
	 AY+ZaVWpMXWVQ==
Date: Sat, 9 Aug 2025 20:22:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Support ROHM BD79105 ADC
Message-ID: <20250809202201.07162fab@jic23-huawei>
In-Reply-To: <CAHp75VcZtKMLByp7QYa_w_McECuDW+zA19HEiTxhYOTcOwxpHg@mail.gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
	<CAHp75VcZtKMLByp7QYa_w_McECuDW+zA19HEiTxhYOTcOwxpHg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 14:42:47 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 8, 2025 at 10:50=E2=80=AFAM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
> >
> > Add support for the ROHM BD79105 ADC
> > (and do some minor simplifications to the ad7476 driver while at it).
> >
> > The first 2 patches were originally sent as an RFC:
> > https://lore.kernel.org/all/cover.1754041258.git.mazziesaccount@gmail.c=
om/ =20
>=20
> This version LGTM
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> with the exception of patches for DT and MAINTAINERS, I haven't even
> looked at them.
>=20

I took another quick look and just a few comments on the DT patch
which also need a DT maintainer review.


Jonathan

