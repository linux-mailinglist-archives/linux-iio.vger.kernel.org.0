Return-Path: <linux-iio+bounces-17783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8DA7EC5A
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976B11885812
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56D256C8B;
	Mon,  7 Apr 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upzcL7hy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186F1B042E;
	Mon,  7 Apr 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051590; cv=none; b=W03jblO/G/lXA7HtbYwoBd1n+o0a4oKwNo6cNEUvnmitHUdUdrCeVnT7irYR1T6sx1pbG/Hfjpg/8KUg/0HIlu/7eiIxORT58pbpJ7TB32Cj+2aDUqVfSzpixmKIu5UEHHJUTGJ9DV5WgvHovbrASkgwbcyWmW9Mtmd7dVqb6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051590; c=relaxed/simple;
	bh=t93cdI/wL24j2HR4ce39FZz6lJqa0QJlRalczKG2iHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRtBdAYrua0wPcu67kvORdjiXEDiCdJFFWH1wwoKhGD3r+n0L/VsrLdN+N5HAFOicX1ub66PC6KKOFfNnsxK9LY0DhhAkeN01oqJaQEWMER3Tq11Enk0upatqhVcpwskCdK/1UPRMKYCbRlIRZmo6yDD5P2FfPv7oFXijEC0QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upzcL7hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59521C4CEDD;
	Mon,  7 Apr 2025 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051589;
	bh=t93cdI/wL24j2HR4ce39FZz6lJqa0QJlRalczKG2iHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=upzcL7hygJ/keMMrQfuERZ7goqYflE9P2ZNFyBvMwS++4GRb3FsbSPrc8ij6Il9mj
	 h/iUwF5PfmCV7Uy/m3OY+WnepzR9VBlmyzXRX8wYKLF68DoTIJIKpCvq9+KHN/hutb
	 ZPKeQRsnqXmUH4A49TYmoxucX1yPwpYtXLqZ1dQ5tdwhe9luhudB2O01dTRHiDvdA5
	 FZHzjguUtWd1tvyhky5O9Y3G21VywD6t9vYee21/qvxhM0xIai3rp1saQFuY9BPvUQ
	 V2pm9bs+ZdxNau5iAG4YX7e7/J28He7y+R19cdT/8z6IriHEfE/+AfFCoEVt3cHkKG
	 1LUtbbqogcZFg==
Date: Mon, 7 Apr 2025 19:46:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: adc: ad7380: add ad7389-4 support
Message-ID: <20250407194620.7d5e92df@jic23-huawei>
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Apr 2025 17:50:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> While developing this driver, we glossed over AD7389-4 since we didn't
> have hardware to test it. However, it should be trivial enough to add
> support without testing. It is basically the same as AD7380-4 but
> instead of no internal reference, it has no external reference. And we
> already have support for chips with internal reference only (ADAQ).
> 
> We have the typical DT bindings/driver/documentation patches for it plus
> a few patches to shuffle around the existing code for supporting chips
> with internal-reference-only to make it generic enough to support this
> chip as well.
Series applied to the togreg branch of iio.git (which I just rebased on rc1)
Will initially push out as testing though to let 0-day have a first poke
at it.

Thanks,

Jonathan

> 
> ---
> David Lechner (5):
>       dt-bindings: iio: adc: ad7380: add AD7389-4
>       iio: adc: ad7380: rename internal_ref_only
>       iio: adc: ad7380: move internal reference voltage to chip_info
>       iio: adc: ad7380: add ad7389-4
>       Documentation: iio: ad7380: add AD7389-4
> 
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 11 +++++
>  Documentation/iio/ad7380.rst                       |  7 +++
>  drivers/iio/adc/ad7380.c                           | 50 +++++++++++++++++++---
>  3 files changed, 61 insertions(+), 7 deletions(-)
> ---
> base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
> change-id: 20250401-iio-ad7380-add-ad7389-4-1f6d3d7dc749
> 
> Best regards,


