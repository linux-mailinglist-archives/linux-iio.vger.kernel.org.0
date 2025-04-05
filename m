Return-Path: <linux-iio+bounces-17648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E688A7CAC6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3539618910E1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF818DB37;
	Sat,  5 Apr 2025 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t55EW1aN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12261474CC;
	Sat,  5 Apr 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873526; cv=none; b=t8QM0/DuPnOlflFbV1lGipTiOix7LTxIvu9L3LFvCpKWAFuC1fY5n6j1740LPi3ZZFT8VwTuolZ/ixMauoolMV9zg9IU7JE/Uq4JfkXUppAti4pfSKXDCQ310PhayT92zu2Z+nugyE7zy5137Ayqb5Zju5A3xiv+N7AJFtc7xOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873526; c=relaxed/simple;
	bh=tUDO7KE2LDmxNo+dRhla6N2NEHvM+6/Y3ILAr8KrEKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irerb2jRsCQkAP9R6xKqlHykKXQpaYSaQIl00evYTlsdLceRxS6Vnhk6B3pu8tTwxc+6MgfTgbRcCrVsoeKZ8zT56YykSLvhPij9yANbBUZ9l4J80Gyc+asY7TOkasnlPITlkGYTnmJKScazq3DhPWEOhRMztEHJXfnGaWdP71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t55EW1aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F45EC4CEE4;
	Sat,  5 Apr 2025 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743873525;
	bh=tUDO7KE2LDmxNo+dRhla6N2NEHvM+6/Y3ILAr8KrEKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t55EW1aNg3uWps14ROD/NcBui28NjbYS5TsP3rD3knnPCVBWO6vid5qH6hT/WLOf3
	 zTSoGhYx7rp2k+X5ElKHwN9nSr55N35U2hcKrX22mJnhHS7D/F1eQcp3ldSJ4IHSvb
	 d6gedEaQJLzlrcCQlDqq1FWPD6Olbno2BJdvskNulag4uCyTrlNc+bOLyph6WhK7Po
	 BWE1WTotwT4zc3faTx3uMaJjxzoJ6AFzxy2yRTvdrmImhxgTTm3Dor7tsc9w8W0xZB
	 90CBqYjieOlRmiWvvInaBpk+mIF4kW7Tz51sF4fi95Y8C12mXiwgBQa74QdDF2ydfR
	 zdNqRC+QHrrnA==
Date: Sat, 5 Apr 2025 18:18:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Support ROHM BD797xx DACs
Message-ID: <20250405181838.1498be04@jic23-huawei>
In-Reply-To: <cover.1743576022.git.mazziesaccount@gmail.com>
References: <cover.1743576022.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 09:44:20 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BD797xx DACs
> 
> ROHM BD79700, BD79701 and BD79702 are very similar to the already
> sipported BD79703. Main difference is the reduced number of channels.
supported.
> Also, the *00 and *01 variants lack of the separate Vfs pin.
> 
> This series adds support for the BD79700, BD79701 and BD79702.

Series was nearly perfect but I tweaked one thing...
> 
> ---
> 
> Matti Vaittinen (5):
>   dt-bindings: Add ROHM BD7970x variants
>   iio: dac: bd79703 Store device address to 'address'
>   dac: bd79703: Add chip data
>   iio: bd79703: Support BD79700 and BD79701
>   iio: dac: bd79703: Support ROHM BD79702
Made the last 4 patch titles all start with
iio: dac: bd79703: 
rather than this random mixture of prefixes.

Applied to the testing branch of iio.git which will get rebase
on rc1 sometime in next few days.

Thanks,

Jonathan

> 
>  .../bindings/iio/dac/rohm,bd79703.yaml        |  33 +++--
>  drivers/iio/dac/rohm-bd79703.c                | 116 +++++++++++++++---
>  2 files changed, 126 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 543da6252b48bbfe13e194fb980bdd2b161f6838


