Return-Path: <linux-iio+bounces-5594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491388D747C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789D91C20B66
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541028366;
	Sun,  2 Jun 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvLsxvOi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A320B35
	for <linux-iio@vger.kernel.org>; Sun,  2 Jun 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717319609; cv=none; b=Iu9jd9C/cVh1nvZGcwFwMPPQ5IqHyyXOyLT3Led0rNthSJohUzNd+ZW13Cn7Awn1I8gje3H3+ft4zJeK4+vNvnkj/EgizvVm2L9x5Itc1XUT1WPpjoV0xLZFxC1n69J6ZKvuTPhnTnMiFuPkgpP8HodqaPi/zk0SYixiF7Jsf7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717319609; c=relaxed/simple;
	bh=WJuT52xpLuA7z7jbjZJ8VDzasHNIEgUITNZGbAzpjHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR8Uro6enoOqM5D8BARKQuwOSEC9E+LymjhcuMsErDq7rA7H4jnc2Phay2DqWcPQKl92pdFdJyktsZuU339BKFnp0fQfRrK5YpbT6qm+6CMLTaghsdFFUt/IpAVlJC8VfvYICLfq6P30C1Zf4lyIPMh3xSpz6F0u0WYwAyrxijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvLsxvOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E82C2BBFC;
	Sun,  2 Jun 2024 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717319608;
	bh=WJuT52xpLuA7z7jbjZJ8VDzasHNIEgUITNZGbAzpjHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvLsxvOivLGK81NaSyFdcNRGPkImwnG08wWBrZ33jTBPgOQPiY74ZmDoWdBOJCSii
	 wVhGt628o0xVovsVV1uPT7eDQpvghrM7zrlxQFR7PMpwfpoMMnr7sxoJKMe8u9UG7p
	 zTyQtlJv/PClpt8jxayGY2xxO6wWDzzYrcLbvM8E/ObXYWzsYZNaInbcaeRFdUTYB8
	 q+noQah2s8h4m5iybRGc0Ww0DiHv5g27ZOq+Tq5nY8IgTM2D4UHnsaWBZfpOSjaZhD
	 qhvjFqEz1e5D+YwLr4dOXNMtMi55YXzEigzphI7gyIPtqqdQ88t0CfOgoU8Cp6V2z1
	 mbtcjBORPg3Yg==
Date: Sun, 2 Jun 2024 10:13:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 0/2] iio: adc: adi-axi-adc: make sure DRP is locked
 on enable
Message-ID: <20240602101316.70c62784@jic23-huawei>
In-Reply-To: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
References: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 11:41:53 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Hi Jonathan,
>=20
> Here it goes my v3. Just splits the fix (with a proper tag)  in it's own =
patch.
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Jonathan

>=20
> ---
> Changes in v3:
> - Patch 1
>   * New patch.
> - Patch 2
>   * No changes.
> - Link to v2: https://lore.kernel.org/r/20240522-dev-axi-adc-drp-v2-1-b63=
c9790a48a@analog.com
>=20
> ---
> Nuno Sa (2):
>       iio: adc: adi-axi-adc: don't allow concurrent enable/disable calls
>       iio: adc: adi-axi-adc: make sure DRP is locked on enable
>=20
>  drivers/iio/adc/adi-axi-adc.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> ---
> base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
> change-id: 20240506-dev-axi-adc-drp-ae6bd9d32617
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


