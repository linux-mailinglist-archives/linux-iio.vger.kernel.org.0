Return-Path: <linux-iio+bounces-26851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D645CAACC9
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 20:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51253024352
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541C308F39;
	Sat,  6 Dec 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpi/UW+r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59923308F03
	for <linux-iio@vger.kernel.org>; Sat,  6 Dec 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765048364; cv=none; b=k+9Zsumw7gojC6TMPFkYu+YWJEJ4wA7fBLIIYFTldEE7Xa2NK7fQxSPC5DfDOvNeJEABk7DeS7lPeIhl9reAgVXt0VrkSusC6al/VaIZL/PohdKRZVJDKlr0rVXLmsjcSSoDk+/mmoXQE0XD0TZrwf/TV+cDDZ9hopk+czvWgPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765048364; c=relaxed/simple;
	bh=NcKH7FuXgs8ZYHiMwORDifQQexAHitlN0tONQn9mbbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWrg0BNYxPGbIySKOQCDqIKpng+pAh/JjnHHBUfQiMU9+sZGomC5rfmz1y1o6qhcvzR0/xax1Kf8TDddCXIOtNAlbsYCGs3si4StGsxTPKc3pBhvWEEO7H1AhdMY7QzpfccKOxxSXSmqEtPvgZQZfo3+jCButoqxzQAzO3YimD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpi/UW+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6459DC4CEF5;
	Sat,  6 Dec 2025 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765048363;
	bh=NcKH7FuXgs8ZYHiMwORDifQQexAHitlN0tONQn9mbbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpi/UW+r6LyDvONNyh7bfADISORmJ62DBQSy2tDCHfDzkkttndMdXdPTyyeFq384Q
	 VSCfSzH6LCQIf4yoNGxmqeMfVMhpikjtDznuvMuLVGD36xVSGUtJInuYcIXQhd+pp3
	 hDuNmaWQmw/9sQJ3MNeM9bJnKKUPZn7RF42A2iZGv56SL0bIa5XF9BSlhgRHD/9kIR
	 AhM0JdyOGrEJ76jZqm3oEaIsIOmbw9HLIijQHtheG9lRaHBlDwdUqE/i70q12c890/
	 8sJ68iwfnPwxWnwOR99iDCEEchDea7PFfQFGkd3G1dz0PPjUJE5eotcEGZZikpW5XW
	 7oWqV3SE+XAUg==
Date: Sat, 6 Dec 2025 19:12:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: adi-axi-adc: Minor cleanups
Message-ID: <20251206191236.7449c493@jic23-huawei>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Dec 2025 15:24:16 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Small series to use dev_err_probe() and turn dev_info() into dev_dbg().
> It also simplifies axi_adc_create_platform_device() and makes it
> consistent with what we have in the adi-axi-dac driver.
>=20
> (I'm aware that the dev_err_probe() patch is not consistent with the
> series on the axi-dac. I plan to also remove the braces in there as
> David suggested).

FWIW looks fine to me, but I'm guessing you are doing a v2 to add
the local copy of the struct device as Andy suggested.
Hence I'll wait for that and mark this changes requested in patchwork.

Jonathan

>=20
> ---
> Nuno S=C3=A1 (3):
>       iio: adc: adi-axi-adc: Make use of dev_err_probe()
>       iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
>       iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_de=
vice()
>=20
>  drivers/iio/adc/adi-axi-adc.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> ---
> base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
> change-id: 20251203-iio-axi-adc-minor-change-f281c70208e8
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


