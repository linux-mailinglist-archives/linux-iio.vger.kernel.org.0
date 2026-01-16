Return-Path: <linux-iio+bounces-27880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C270D38628
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD56C3015BFB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E53A1D1E;
	Fri, 16 Jan 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6dyfpjv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8E3939AE;
	Fri, 16 Jan 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592642; cv=none; b=OL1yWW54/sBQV1IPqX8YyiPHFrNjxIh8HSG+A6+vvSoDxoRUqlcX1NNMqveJqR9M4oy/TB4QNV4vYwFwhCT/P5knLWD3gEZWG8r36xLGh3J6sft4j3przktXgJmFQ8G7kVnADVbDWW0k0999OLR1qyPC/aYmWJyjwrTQRULg+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592642; c=relaxed/simple;
	bh=/+9YYkp5EntHVAKho7mxYc9QsiDJ4zIgFEoblfAUB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLys2O7kv8QL4TBqcK0DAVprVU0l5+oaeDzQIociXWTz+hxXgrepziaUwTcre/KbTUbOjhIy0PIbrp7qltF9HL5RoMoWd/uSshFoEUK9p/VTGbhm0e/m437FHUh2pNcd6smGFmXxZHemjamgOpvq28ZQCCWwrx9qkIeRMg2ZSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6dyfpjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF477C116C6;
	Fri, 16 Jan 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592641;
	bh=/+9YYkp5EntHVAKho7mxYc9QsiDJ4zIgFEoblfAUB9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6dyfpjvVrV34U1TidtxIWguih6Lz5RdDAguF8EPJZrmVlNPIxkLB++sKWzotdk6n
	 pYgrjotk78FYtEIeWzqJ8q9Nc0ssgsctWLRePwpDBq0bEUjAnGCNEWBSaU/C02eelw
	 TYxjThv17R8qUgqxv7tzmPN81Wb6E5O2DkonQDsAuDJXVvSbB0Zrwvza5ZCahvvi7p
	 CsgnIQDunQmvSBMkuqLgRxHAlINdnBONKy4ohGWvtK8v2LWyHLSrIPMN71C3B9fE7p
	 QtPht8LXQRI8iNW0v5ohFT2yHyzK5K5TWk7SWGonmDkBNcDEqzbddtCtar42vm9wM3
	 gqlhc77mxU26g==
Date: Fri, 16 Jan 2026 19:43:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] accel: adxl380: Add support for 1 kHz sampling
 frequency
Message-ID: <20260116194352.2595a86c@jic23-huawei>
In-Reply-To: <20260115175350.1045887-1-flavra@baylibre.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 18:53:47 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> This series adds support for 1kHz sampling frequency for sensor variants
> that implement low-power mode.
> The first patch is a preparatory step to decouple sampling frequency values
> from decimation filter settings, the second patch introduces a new helper
> function to check whether activity/inactivity detection is enabled, and the
> last patch adds support for the new sampling frequency value.
> Tested on ADXL382.

Applied with tweaks as called out in replies to individual patches to
the testing branch of iio.git. I'm rushing this a bit as I'm not sure how
early next week I'll get to IIO stuff but if Nuno or anyone else wants to
take a look (+ give tags or ask me to drop it for a v3) then that is fine!

Jonathan

> 
> Changes from v1 [1]:
> - added Nuno's reviewed-by tag to patch 1
> - modified reporting of available frequencies and setting of current
>   frequency to reflect activity detection status (Jonathan)
> 
> [1] https://lore.kernel.org/linux-iio/20260107123518.4017292-1-flavra@baylibre.com/T/
> 
> Francesco Lavra (3):
>   iio: accel: adxl380: Store sampling frequency index in odr struct
>     member
>   iio: accel: adxl380: Introduce helper function for activity detection
>   iio: accel: adxl380: Add support for 1 kHz sampling frequency
> 
>  drivers/iio/accel/adxl380.c | 122 +++++++++++++++++++++++++-----------
>  drivers/iio/accel/adxl380.h |  10 ++-
>  2 files changed, 95 insertions(+), 37 deletions(-)
> 


