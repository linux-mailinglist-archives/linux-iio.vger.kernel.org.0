Return-Path: <linux-iio+bounces-27382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962CCE0074
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B5B301B2E4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370E335BA;
	Sat, 27 Dec 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foPAxL3y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E918E1F
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857652; cv=none; b=emQ7atm6LeVjjxf1yx6fU/sqikwiVXDr1dTPMkSvkT2xabeVOc5hKtjWDAy5Do2hAyjqOsM4JKnsNATQ2i0iHAV5khzSlvsiNR5hhl6LUz4Ug37AluHIm8TfGUS0NtvtgDgA9yjFMEL+yHNvmyHtN3ohA0MCp/lGUHSTevaA6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857652; c=relaxed/simple;
	bh=oMRJ+ymAakR27A7+c7X8LyE3o24VWChnJXCw1C3AxCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqzbyfIFhDxrqESY6WXfqCjY2Bbm/M0nV93v+IoJIdHL7rqzHaHCubjKr7BRCRZv5atGpBMOzkoxqtyZS26khwO6TArBO+Mmv16r6NFKwWY6algKSowSKSSosXPTW0NYnxVIe7GcY/JpbuYxs65NhJTh5W8nsYRclpiuqvFMm8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foPAxL3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7D2C4CEF1;
	Sat, 27 Dec 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766857651;
	bh=oMRJ+ymAakR27A7+c7X8LyE3o24VWChnJXCw1C3AxCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=foPAxL3yJKdJtcw3nrqVNibPq213PFfpmjJRe3bygOridL3OwKU00qRzmpYwZQBHR
	 A7BgG3lbpPfYa8ScdK0KgK2gcuu0T9Psi/g9gF6ev3oSuM8No8hRsbLFC6GswZ4woI
	 iI6K5LiOtfsQ9BoOO5VwB6B7cotgJJScRVoxnttyHYWyqirwELZ5LoBH3BJlQAIuCs
	 wVBl2cmWNt805lvbnCwm31nmXsMwR7dJ2Ym8zV84G04HJLWJvwFIK1HMcnNvj4cD0i
	 JV/FU9WuZz9HIRRwR9TdoY57Y+JZeHgQJJETSPg4Cpph59LmH4C/7wNzJ6MVDyJ2ZY
	 c+0B0F8ayEQWw==
Date: Sat, 27 Dec 2025 17:47:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 0/2] iio: dac: adi-axi-dac: Minor cleanups
Message-ID: <20251227174723.7b3105c6@jic23-huawei>
In-Reply-To: <20251222-iio-axi-dac-minor-changes-v3-0-29199f239d9c@analog.com>
References: <20251222-iio-axi-dac-minor-changes-v3-0-29199f239d9c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Dec 2025 13:48:00 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Here it's v3 with the patch split in two.
Applied.

Thanks,

Jonathan
>=20
> ---
> Changes in v3:
> - Patch 1:
>   * New patch.
> - Link to v2: https://lore.kernel.org/r/20251219-iio-axi-dac-minor-change=
s-v2-1-e9fccc019b01@analog.com
>=20
> ---
> Nuno S=C3=A1 (2):
>       iio: dac: adi-axi-dac: Make use of a local struct device variable
>       iio: dac: adi-axi-dac: Make use of dev_err_probe()
>=20
>  drivers/iio/dac/adi-axi-dac.c | 66 ++++++++++++++++++++-----------------=
------
>  1 file changed, 31 insertions(+), 35 deletions(-)
> ---
> base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
> change-id: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


