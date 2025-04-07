Return-Path: <linux-iio+bounces-17788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F3A7ECD8
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4613BD3EC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4478A22258E;
	Mon,  7 Apr 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2jHdVOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0148D218AC7
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052471; cv=none; b=ndurVC7nR+kdJpFN1eMGl9oyg2rm+HEBrZsPSAbnS+iIR1t3/5rqFjGMl/+WBrhedwWb4uhqjV8OZ1JTWgtni05Xx542Y7hdKCm7azaTU8WUAkKAYaRvY1i35wYJrcBYmf0eQRrqR0lbabI85eKvXfkCgHSGHjYO8z+hoE0wEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052471; c=relaxed/simple;
	bh=Ayp/GUqTo1Dg+k/kaZdEwaYt/fagwBxAwFkrtI2nnhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1LstxtYOUtaTyiYkXPhmboG9LNBQHsjq79mQpmRIBLyuqFLrYvK/wvNOUUkIH6xzV7MZBUUKwgH7v8SXquDPwuhAdDdsUeR5XYqFh9Ok0P8jm+adg0e5p8tUGsXP+gLHC1pq2hq8OcV1axrW9ChjwbhO6DFSNjoJIp2LC3BpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2jHdVOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFEC4CEDD;
	Mon,  7 Apr 2025 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052470;
	bh=Ayp/GUqTo1Dg+k/kaZdEwaYt/fagwBxAwFkrtI2nnhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2jHdVOXm02ilbW0It2hUrCqkQTZ7zBSypPQP47dT4jlMTfDluiCGRdCGHrVt3JIE
	 9dzUrZC9uCDkSUlkTyK1der8ET4BUDueE/tL/QR8Q5/h9pvyKAlxo30dJwDT73G6JL
	 KANPYsN96OqeXdvEy7rwW5xkBV1p/Hxhw6el+8p5XKkDEPoH11AKrSRGNaJJMEi4TO
	 WbBp6pAAebt5/cHyU+3pkfVFzO85N9QVv0yRY49LOxu7ClF8pKhJFDbv4dQtzF5CGn
	 vRLqNzF9x7iGLl67yrrUkbKOhm+B1qevvELncfQbIKdu5GSa+GpveOnVeQsUOvAXFU
	 9bUFT0sxwptTQ==
Date: Mon, 7 Apr 2025 20:01:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: IIO: Update reviewers for the subsystem
Message-ID: <20250407200101.2c4c3fc5@jic23-huawei>
In-Reply-To: <20250406153120.2129133-1-jic23@kernel.org>
References: <20250406153120.2129133-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  6 Apr 2025 16:31:19 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Lars-Peter has not been active in IIO reviewing for some time. Without
> David, Nuno and Andy, along with many others who review IIO patches, I
> would not be able to keep up with the rate of change and would have
> become a bottleneck to development.
>=20
> Hence update the MAINTAINERS entry to more accurately reflect reality.
> This is not intended to give the 3 of them any more work or to oblige
> them to review any particular series, so if there are any series waiting
> a long time continue to poke me via the list.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.

Thanks!
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 559620786634..0762170e9740 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11518,7 +11518,9 @@ F:	drivers/iio/common/scmi_sensors/scmi_iio.c
> =20
>  IIO SUBSYSTEM AND DRIVERS
>  M:	Jonathan Cameron <jic23@kernel.org>
> -R:	Lars-Peter Clausen <lars@metafoo.de>
> +R:	David Lechner <dlechner@baylibre.com>
> +R:	Nuno S=C3=A1 <nuno.sa@analog.com>
> +R:	Andy Shevchenko <andy@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git


