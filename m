Return-Path: <linux-iio+bounces-5297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D978CF049
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7910F1F20F7C
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7328627B;
	Sat, 25 May 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwmKST0j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129A85C77
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716656233; cv=none; b=SdxTEoz8DRZfo08U11vyq+g8tdsvT9nNF9MaD536hRwH/Vvtz5xCJ+0C4txj1AiCExpvMbsxLMZFl5FJpLXUJG/cFDX7QStEvnwIeeggiwiUV1TPZnUb+jktMlwn+Na8GF/SR4c8ANlFeT0vMIvO/5KWCJeZwUV5x6cSsTtCRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716656233; c=relaxed/simple;
	bh=5VQczdfKm/VMTk+Wa4EbC3wSzg2GZfHS/Q40saWj3gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4zIV0uq3Q9SDcUjec0c/8PX/wdSPK6JWc68nVUaR42DTVAagoOjs3t0Ia8E3jHjr/2/3GPy9JymBl4S5vHoepN5ALymXkZdN489EOtcRur7eevJXD9JFV5KlG+5appUg6CFPOHW9QwO3b6mBUKK7hfsxMFYqtPWyGRxf5tPlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwmKST0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C95C2BD11;
	Sat, 25 May 2024 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716656233;
	bh=5VQczdfKm/VMTk+Wa4EbC3wSzg2GZfHS/Q40saWj3gs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwmKST0jDyGss4vDymYl35SGM+Q8t012ZRImeLbLplIShhCpvH24ixGoDCzB9fFKz
	 hGKB8E75JTZY4pzX0p5RuFZIHcsn+60DGPXVbR1hqsr/Q+PlhMe3fvCfZtu/H0mOq/
	 aZxlAys1s7n6e+daYemYaKfMXOU5IC2xE1hQZK9fGX0wsHmYoCx3XkFe5Wxaj/uiwP
	 Lf2IMizQhEV17E89y2WXp9BhL6dh88pSo7O6oCfUsj8VDVyqmbP3G352Q75mKaRaUo
	 PDcOVXUZGqdbUfzqmKSpxYUisniP8AMDlk7rb+4bAE3rHEhCbjPm1beGuOF9Uzywyw
	 hCCePj+g1lttw==
Date: Sat, 25 May 2024 17:57:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 0/2] iio: adc: ad9467: use DMA safe buffer for spi
Message-ID: <20240525175702.423a1e0d@jic23-huawei>
In-Reply-To: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
References: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 May 2024 14:54:04 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Added a new patch to "fix" the annoying tabs alignment on struct
> members.=20
Given I don't think we have any reports of anyone having hit the
DMA safety issue and that I don't want to hang on to the second
patch for ages, I've applied them both to the togreg branch of iio.git
rather than sending the DMA fix via the togreg-testing branch.

Applied,

Thanks,

Jonathan

>=20
> ---
> Changes in v2:
> - Patch 1
>   * Don't use safe buffers for reads (uses spi_write_then_read()).
> - Patch 1
>   * New patch.
> - Link to v1: https://lore.kernel.org/r/20240506-dev-ad9467-dma-v1-1-e5c3=
1b464e8f@analog.com
>=20
> ---
> Nuno Sa (2):
>       iio: adc: ad9467: use DMA safe buffer for spi
>       iio: adc: ad9467: change struct members padding
>=20
>  drivers/iio/adc/ad9467.c | 103 +++++++++++++++++++++++------------------=
------
>  1 file changed, 50 insertions(+), 53 deletions(-)
> ---
> base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
> change-id: 20240506-dev-ad9467-dma-3114fdd27c1f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


