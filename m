Return-Path: <linux-iio+bounces-22938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA6B2B01E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3242C1B60082
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09032D2493;
	Mon, 18 Aug 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSRmy2hC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820E32BF51;
	Mon, 18 Aug 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541182; cv=none; b=Cgg8YjnTLjvIh2yOvbyCj01ajo7CYnfWYCUQ3pCMKq3QVeVko0a6Ig0fjEY/TxvAVP5qg1aVYPR+jyVf+XiZwHCiKLsbfI2Cwlbnh1bhmaQGci4e4f2CKN9eoVwvux9oMc8PncZ440r1KiVp9XMGoetvMFcKZv+EP6ewQPBjWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541182; c=relaxed/simple;
	bh=muDSM2DZU/m3dtUC2L4Y87gha2PMNNE8QFT/hIEEopk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmoQTyqwL1Wwh5sAUI0vwsCZ6Ki8dzw3FYrgCBnOHdWlVNCTSznnnIz0L9MxQKSHQf26mypSCzyOuRbdsufOCHRHPjcCq8Hovlrg90SDMvx3aaf6WfF5coN9wNKLC/rCdQpjxlEZplW1mDbCMwi90k3sr65Gqr6pLJ/EoMy7eTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSRmy2hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA86FC4CEEB;
	Mon, 18 Aug 2025 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541182;
	bh=muDSM2DZU/m3dtUC2L4Y87gha2PMNNE8QFT/hIEEopk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSRmy2hCKx1u6sbrj2ICa3M3ZVE2sVGrUioOL8RwhmrKI5mgc6d8cIQdAzf/j6hCn
	 YHA5chHfS8zgetCUoFBgOjHpOotxzuMQBYRpcno94nZLyI/Eex9jVS559O50d5wNVC
	 mBtriYA8OZpJi1Y8L0mviamkiEIQU8S+pPgjGtQZNFu6lzEB3vyLyAcpUMbKVAdNJO
	 q8OQRBAznaGQVa7YzWvfe97gfzcBR/ik+i5yQlEQhW9lnSiJxOmdCGUagvsu9lKhfs
	 AtZuhunwnC6B9wzFmcQz6vieKqEaNZFvGJSsGHaQJvdIbQXraif92k3Tr9ZhCejlJF
	 4UjB2vMAxLHWg==
Date: Mon, 18 Aug 2025 19:19:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sukrut Bellary
 <sbellary@baylibre.com>, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v2 0/4] Support ROHM BD7910[0,1,2,3]
Message-ID: <20250818191932.42c22df3@jic23-huawei>
In-Reply-To: <cover.1755504346.git.mazziesaccount@gmail.com>
References: <cover.1755504346.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:11:56 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add support for ROHM BD7910[0,1,2,3] ADCs.
> 
> The ROHM BD79100, BD79101, BD79102 and BD79103 are ADCs derived from the
> BD79104. According to the data-sheets, the BD79103 is compatible with the
> BD79104. Rest of the ICs have different number of analog input channels.
> 
> This series adds support for these ICs using the ti-adc128s052.c.
> 
> NOTE: There has been work on couple of other patch series [1][2] touching
> this same driver. I haven't considered those changes because, AFAICS,
> there has been no new revisions of these series since mid June.
> 
> [1]: https://lore.kernel.org/all/20250614091504.575685-1-sbellary@baylibre.com/
> [2]: https://lore.kernel.org/all/20250625170218.545654-2-l.rubusch@gmail.com/

Pretty simple replies to the changes requested in v1 reviews and nice and clean
so I'll gamble (a tiny bit) that everyone is happy with this and at least
queue it up for build testing.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to have it's fun.

Jonathan

> 
> Revision history:
>   v1 => v2:
>     dt-bindings:
>     - Fix the fallback compatible for BD79103.
>     - Drop the excess 'items'
>     other:
>     - Rename the channel structs as discussed during v1 review.
> 
> Matti Vaittinen (4):
>   dt-bindings: iio: adc: Add BD7910[0,1,2,3]
>   iio: adc: adc128s052: Simplify matching chip_data
>   iio: adc: adc128s052: Rename channel structs
>   iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
> 
>  .../bindings/iio/adc/rohm,bd79104.yaml        |  10 +-
>  drivers/iio/adc/ti-adc128s052.c               | 132 ++++++++++++------
>  2 files changed, 95 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 856d7be7f3c459a6d646b1f8432c6f616ade0d10


