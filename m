Return-Path: <linux-iio+bounces-16443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309ADA53EDC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699DA16F431
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3A36D;
	Thu,  6 Mar 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyv0f9Hi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD010E4;
	Thu,  6 Mar 2025 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219651; cv=none; b=CrO4IvAlDc1bd+hB87u7DSgfhBm4MqkpVLwoWXQ/ROrw0hPXm6D/ZgQIGJ9EJMfaLxGsdSrs8HipjSPGEaL9e8kdK1KPA4ZJ3mLMMSxGVkxT03LTc1gcrB2muVs7CblfS/ZQRrc3Hdb+S9d32vEswcE9o1SU06FtyDJ/EdvndCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219651; c=relaxed/simple;
	bh=s4L8LbIbR3L5t3u2JtJZrxB8f91I8axNv8Plf1/vuig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkFlyXib9y6Mg3kSPhiIIM6LY/nemY73JbiePllgnhgvfo4fQH1EYI8FqsvJT1WE0li8jKBKStAVBL14VzRoy1dM3wPcQQ5qDSyf3qBcG1VzJnzs5cp7tXJJ7M/DAbViHUrUyW5acD3qhUVhzs5RCAV6sSvqLxuGDZMGfWZwOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyv0f9Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1C4C4CED1;
	Thu,  6 Mar 2025 00:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219651;
	bh=s4L8LbIbR3L5t3u2JtJZrxB8f91I8axNv8Plf1/vuig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xyv0f9Hi2J6SwJFdMsLyH0V/cSnptot+yps+/3BDidAnMzsOvZ0x7ZtFvHOagRBzx
	 pghcP+TjM/QIAtd0+AAhbotdocCfstdeyheKUxGJpMnMOjRra1x+KozENU9/Jx7Nv8
	 AzgrQQVY5SFkYd5LQG9slbReu1bfNqSCmx/6NHBKu5/uXDG2ry5WQkqvOpy4DGB4KE
	 5Q73Dg7HLmIJ4BAN15YsPQYrEDcPXoIi0lZCFI47TA4AeIYvb2ZBHKgQWuMd2KkklZ
	 ArQ5TrXxkAcXhSiechyC2uVCQPcz1DStLa5Rs0wYp+TFOkdOlRBtZ+iTu2zTMdpAch
	 ZHM+Qi2r0GDUQ==
Date: Thu, 6 Mar 2025 00:07:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
Message-ID: <20250306000718.330c99db@jic23-huawei>
In-Reply-To: <20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
	<20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  3 Mar 2025 12:47:06 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Allow triggering both zero-scale and full-scale calibration via sysfs in
> the same way as it's done for ad7173.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 153 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 136 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 382f46ff2b51..5ab0d3e48c43 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright 2018 Analog Devices Inc.
>   */
> +
Stray change.  I'm in that sort of mood so I'll tweak it whilst
apply.  Rest looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing.
As the fixes are theoretical(ish) I'll not rush them in.

Thanks,

Jonathan

