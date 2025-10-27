Return-Path: <linux-iio+bounces-25491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD6C0EB45
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADBC4278A9
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D115305960;
	Mon, 27 Oct 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe+pUVq1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0D2D2397;
	Mon, 27 Oct 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576743; cv=none; b=o6uj28sAvLfG4vL9Hfg5PdxE3QEy3EKH848VOZnr3GW0mhz1RjBEXQ7ViH5/ohWZZmIPZpF8hd8m3qax+YHB2n0n9fSX0gILHg+Y0dqq6kJgkke8PgGp4ZjU5XII7h9DksLED0BDfEE4iWcqPppbXPb3BMz/+KW8zVKLPZmQxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576743; c=relaxed/simple;
	bh=hMoZeN45muKbdsQekDeFF0hXb2M3KyQgu5l5pmlKZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+Nm773cDQy2GphdCK50tDreE6khYh+Ruycrk8wRmG8UP1VVe+ywhfjR7srQpo/byanp9hL4YDxfLI7LuT7FIKXqntSHdweF3W9irMA6Flk/JDFXVqkJEhBNF0dsslyDsppF55oR1AMtQdp2xYFlUvg2L2Ha3AYIVTo2ffGJYu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe+pUVq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D9C113D0;
	Mon, 27 Oct 2025 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761576741;
	bh=hMoZeN45muKbdsQekDeFF0hXb2M3KyQgu5l5pmlKZ50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fe+pUVq1tg8WkyXyBgvDaSXq0Q9GES6UBDqpbqbgLyib4H2QiXJ51g/dNQfFslicb
	 fT0/rzsvPKTRglCWyLLNsdo2+k/Jw+9vQfB3NZG+9Q0wCzhceGeKRn2kJyUQgIpnJy
	 FqFdYIgrYii05INTlFwlQtkNCtrkK9HjSwfe603b4uWAC5NLg/brS4NdnwQURoPSOd
	 o+CUqCy4wf+fakyDyQ1JUiG4RBO5xW7B5uVCipa8K6DSVsz4vAT1y+UIc/IbuuiFSv
	 LVWe637KlDOOxqmFXJWSp28uDySDzLQY27yaYAqTVCqUH9q0rKB//gdfNxo6tD9Evf
	 29jSwIgMf5mPg==
Date: Mon, 27 Oct 2025 14:52:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v1 2/6] units: Add value of =?UTF-8?B?z4A=?= *
 =?UTF-8?B?MTDigbk=?=
Message-ID: <20251027145213.7c93a3e2@jic23-huawei>
In-Reply-To: <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
	<20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 15:34:51 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There are a few drivers that want to have this value, and at least one
> known to come soon. Let's define a value for them.

Is there any way we can make the x10^9 bit obvious in the naming?  Or do
something a bit nasty like defining a macro along the lines of

PI(scale)?
e.g. PI(NANO), PI(10000)=20


>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/units.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/units.h b/include/linux/units.h
> index f626e212d4ca..82bdc2041328 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -21,6 +21,9 @@
>  #define PICO	1000000000000ULL
>  #define FEMTO	1000000000000000ULL
> =20
> +/* Value of =CF=80 * 10=E2=81=B9 */
> +#define PI	3141592653LL
> +
>  /* Hz based multipliers */
>  #define NANOHZ_PER_HZ		1000000000UL
>  #define MICROHZ_PER_HZ		1000000UL


