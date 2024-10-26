Return-Path: <linux-iio+bounces-11347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB59B18D3
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751271C214BA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB251C69D;
	Sat, 26 Oct 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYbUJSKv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3AAD24;
	Sat, 26 Oct 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954551; cv=none; b=XJoLZGkZl2q0bAs6KAkvTuQbx/YNqJnsXFUfopPaLkCyVue3L74WTM7Xk+3+J7EXBEdGRoFUjZTX3rbCn4zdPRLPw0ntrWxDVTgGphCmnHq+NXSX/GK1o3Jk3WHg6C/dqrU/8AQh4EYl97egVGEJ4+xyBnE4ad4W7jfXPrUCzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954551; c=relaxed/simple;
	bh=KfL7pKpwOhrZ9vAmsvWyx1jEYgsRRAxi55xj8Lku6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWrgZGExkIs0koVKR09IBjhUV/XfxSL3bnOfnTmT8kyiVkpNzV6g9V0tM3sSBdL6kVwNm8cHadBtRZCeB2ZpPZLaNYvOo07+w5zFvlJC6kch6B/plUPr0cIR868Se+0q4nlopedwRRBCv2CtGqw2DbCzTSSC9nH++4Hbys5zQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYbUJSKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91160C4CEC6;
	Sat, 26 Oct 2024 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729954551;
	bh=KfL7pKpwOhrZ9vAmsvWyx1jEYgsRRAxi55xj8Lku6Vk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TYbUJSKvQHeCKv3jY67RackhWNrEz2cKxkYkFnnb/s6AybCI6q1VzQYbkhc28Ftd5
	 w/SJEIHkscTQ59LVNiV+9fbBna1aDj3r4MVsGFUFRyqOuuUwyJqqH4OXhUVVOWQdWK
	 19lMRMkBC+oOO+UfEdvmR5YDZDZPR0XeqcbEICEYrJMNLNXHgG/Qmt0Td1SMdof3Z7
	 JoNunm53m1/dHEi0vJYkOte6kz7BClfAG4XyxgYLCKBdNmYVMBHgt/9jIJBsPAvE/e
	 UNJlYEhka3vCbSok1kXguucSL7WU69oDoEp4GmYs3ohf98R9qDymbVzf3t+rKP4cfZ
	 Qsel/l2egLcNg==
Date: Sat, 26 Oct 2024 15:55:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] iio: use devm_regulator_get_enable_read_voltage
 round 5
Message-ID: <20241026155523.57e299a0@jic23-huawei>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 18:54:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Here comes another round of reducing boilerplate code by simplifying
> getting reference voltages and dropping more driver remove callbacks.
> 
Nice series. Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (11):
>       iio: dac: ad5380: use devm_regulator_get_enable_read_voltage()
>       iio: dac: ad5380: drop driver remove callbacks
>       iio: dac: ad5446: use devm_regulator_get_enable_read_voltage()
>       iio: dac: ad5446: drop driver remove callbacks
>       iio: dac: ad5504: use devm_regulator_get_enable_read_voltage()
>       iio: dac: ad5504: drop driver remove callback
>       iio: dac: ad5624r: use devm_regulator_get_enable_read_voltage()
>       iio: dac: ad5624r: drop driver remove callback
>       iio: dac: ad5761: use devm_regulator_get_enable_read_voltage()
>       iio: dac: ad5761: drop driver remove callback
>       iio: dac: ad5770r: use devm_regulator_get_enable_read_voltage()
> 
>  drivers/iio/dac/ad5380.c      |  85 +++++++-------------------------
>  drivers/iio/dac/ad5446.c      |  77 +++++++----------------------
>  drivers/iio/dac/ad5504.c      |  59 ++++++-----------------
>  drivers/iio/dac/ad5624r.h     |   1 -
>  drivers/iio/dac/ad5624r_spi.c |  71 +++++----------------------
>  drivers/iio/dac/ad5761.c      | 109 +++++++++---------------------------------
>  drivers/iio/dac/ad5770r.c     |  41 ++--------------
>  7 files changed, 88 insertions(+), 355 deletions(-)
> ---
> base-commit: 9090ececac9ff1e22fb7e042f3c886990a8fb090
> change-id: 20240813-iio-regulator-refactor-round-5-3248993c93b0
> 
> Best regards,


