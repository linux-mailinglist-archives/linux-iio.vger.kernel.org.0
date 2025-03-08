Return-Path: <linux-iio+bounces-16558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F9A57B2B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9791894DA0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751821DDC2D;
	Sat,  8 Mar 2025 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHpOM4ID"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA081BD000;
	Sat,  8 Mar 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445046; cv=none; b=ib/oUmtfcd1cqUpTa+T5QrepZ4GJb3HISzg4lG5OsMOTEnZk7b2lmLOryIcq2viblDhEZ+Wv9Qnyp6Wk5iCtiqWKJQT2M1Z7D/ncjMZZdKp/8t0tT9ROo+SYbmBjycsejPNYpC8AGxWtzDKPnOHJlKUpigjAiwnkA91/S9eeX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445046; c=relaxed/simple;
	bh=N10MM0HZsAu2Dv90U1Zow7WqGnmd9qBSa2vs3dWjdP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0BV6ywXrCAeKIKViK7hiNyyP8Jgvb8vf+dzqom0lIVYTWlQidSWi7VfbVtRoYm6xFf46p6fsuMBHeHtrXRAIkfaBekw7D/8PprSBHffSKWXiG6HZ/5cwk/sKEUMoJpeKuow1eheN4tx9IRUstL/MGk/UUnDg9/dLzPB3deeoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHpOM4ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF1FC4CEE0;
	Sat,  8 Mar 2025 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445045;
	bh=N10MM0HZsAu2Dv90U1Zow7WqGnmd9qBSa2vs3dWjdP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHpOM4IDfIWmOgYwKvpovnLec1YNqGY9kQgZtGFlyXbdQnrmvMlDZOPb9jmDNiCgO
	 awhaY0LZNFGDWeRxvm1OCFDdBeC3OvrdoLad+sTGDTE7/VWhpDXYq10gUUNWAACZgv
	 EgkvubHjyZbKF9Ud4XvF1pF4/mEvx4qCmf+5DbV62JSLdH2NUojiDW12NZsykcRpZc
	 3uM0gIZjsad17m+P+h5QH/kUvmKefusai2Iv9KUkNhsNUIbXLFEmc6qSev+QZz00cE
	 N6pHf9/iDPFWsVJhftME3wkB53vuY63DFzAng9tuE1nWNWkHUtrrHF76KdCOsiAlk3
	 BZHSS7kP+amBA==
Date: Sat, 8 Mar 2025 14:43:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, lars@metafoo.d
Subject: Re: [PATCH 0/2] iio: accel: adis16203: cleanup and standardization
Message-ID: <20250308144357.20f24fa6@jic23-huawei>
In-Reply-To: <20250305155712.49833-2-simeddon@gmail.com>
References: <20250305155712.49833-2-simeddon@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 20:59:10 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> This series improves the adis16203 driver by using standard unit macros
> and removing an unused spi_set_drvdata() call.
> 
> Siddharth Menon (2):
>   iio: accel: adis16203: Use units.h macros for voltage values
>   iio: accel: adis16203: Remove spi_set_drvdata()
> 
>  drivers/staging/iio/accel/adis16203.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

I'm not going to apply these because I think you correct
identified that the device support should just be added
to the adis16201 driver and this one dropped.
Good thing you were more awake on this than me ;)

Jonathan

