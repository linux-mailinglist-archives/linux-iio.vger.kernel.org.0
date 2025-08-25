Return-Path: <linux-iio+bounces-23186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18829B338A6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E273AA9E2
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E5129BDA2;
	Mon, 25 Aug 2025 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad35EJ6/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17CD29BD90;
	Mon, 25 Aug 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110160; cv=none; b=catAlC1Aahki2F4ZAtC2rBCA6/MmoaKD/Nuv0IPYnktyt6WiJQgDBBV0Dgs85APbSt0abquIdk8yxxXXSMsYLpwkmUranDOGT7oapXuGuNeLeB5M6x8nfpXwZWODP4Mc9cZD7Mq5rSUL1HF3JIQoGgB40KcAKB/ZHGNAdIl5FJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110160; c=relaxed/simple;
	bh=UCJDBpu9eHnJcYd5TkhKW39ha/QSa5xzr2Sgk9kCDw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqJfMcSdjWKy7rELFyCQH3wJbwcwUWoxBauXCJSltGIZHprfX2i8fRXPMLsWP/P2LShYMwyXWDjlJej5q9+gm5sn87hb2N7hiSEIDdoqiOo8O6humoqq6bvBwOwhz8fPafkAufYIB1GfhJFGCHaYgXdnUtkHFB6lx6jlBKacIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad35EJ6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8603FC4CEED;
	Mon, 25 Aug 2025 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110159;
	bh=UCJDBpu9eHnJcYd5TkhKW39ha/QSa5xzr2Sgk9kCDw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ad35EJ6/Scn0yQtayEMoMd6DTGjU0WBC1pRHdsKzDyS6VxTPDcrvhqfuFT44CObP8
	 v+qJw+FAbR6y3dvJoYF35RzXcPznydDYm32MPEt3p2Q+kchSlvsmSOn/Mzg5bSnm5e
	 2+OuWh6tU+02qynrGU3xpMHaMjLMIJNq5z88hS0OQUEytkSpWfGtGRAzv0/jS5zbrj
	 Cj+bLls5J3AmCTRf/Yw1q3Hgd0+Zjb47FFDtXKF5g9LTsiCPvY3k5N8JMcgiqhSJ8d
	 GrI8hfs4Id9boYHZXWdaSpSk1sT+iqmEf5IkucsmRYZbSut015e2iO8Vz+h9LS1CR2
	 h+y9hg4ZWuRtg==
Date: Mon, 25 Aug 2025 09:22:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Markus.Elfring@web.de
Subject: Re: [PATCH v4 1/3] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
Message-ID: <20250825092231.1e02590a@jic23-huawei>
In-Reply-To: <aKXgWNBwcHrbCbFo@smile.fi.intel.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
	<20250818092740.545379-2-salah.triki@gmail.com>
	<aKXgWNBwcHrbCbFo@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Aug 2025 17:48:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 18, 2025 at 10:27:30AM +0100, Salah Triki wrote:
> > `devm_gpiod_get_optional()` may return non-NULL error pointer on failur=
e.
> > Check its return value using `IS_ERR()` and propagate the error if
> > necessary. =20
>=20
> > Fixes: df6e71256c84 ("iio: pressure: bmp280: Explicitly mark GPIO optio=
nal") =20
>=20
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Cc: Markus Elfring <Markus.Elfring@web.de> =20
>=20
> Please, next time move the Cc:s to be the after '---' line...
>=20
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> ...somewhere here.
>=20
> It will reduce a lot the noise in the commit message. The all people will=
 be
> Cc'ed anyway (assuming you use `git send-email`).
>=20
> >  drivers/iio/pressure/bmp280-core.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-) =20
>=20
> Jonathan, would it be possible to drop them from the commit you pushed?
>=20

I did so, just didn't mention it.

J


