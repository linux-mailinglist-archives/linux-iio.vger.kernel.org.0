Return-Path: <linux-iio+bounces-12543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04819D69C9
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6486B161794
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13E381C4;
	Sat, 23 Nov 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj6C/kdI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DF2943F;
	Sat, 23 Nov 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377294; cv=none; b=oEJKcr64jFDdRzCwtYRGqQnF/LW/my+gRhfJBqcRA7wVR6egrea3EByWFSVznSuU+lHT8Qme6Dyj4q+P/8QRQGNeNAcBtHaLVVojK2B9RHgLNa9FjskevZ3+o2wuzb20E2rOyUZrToa6dQ7zy7mLk9ZRPFOCfVtsileDn9FMmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377294; c=relaxed/simple;
	bh=WVS4FAzJTzrxMbZG08ziSv2JQyBqkO+aCqwbAOyQnBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVzQ0QrpUsOQV1eoaPrKr5ZF97OtC3zEOP7O2XSLuKORHWijEBQV1igRQHkFsqBgOSq74MXsnZg8WrGx8+UiLYEOnG6HzvFtSR6Ib7pYQeI2OT+jGqJFOvf7ZkdelssghE+tgTjoxqmha6glIp/xRimzf6mH0D9Or6Khanhn/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj6C/kdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A02C4CECD;
	Sat, 23 Nov 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377294;
	bh=WVS4FAzJTzrxMbZG08ziSv2JQyBqkO+aCqwbAOyQnBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nj6C/kdI5zsz2L18o0PgWzSmSYcPjkEsnr4/M2LVJaDk67rdCCtmiVCoNKvLwsNa6
	 2KY1G+LSNsmrDvJQAKgOclIXaoygZR8zyKvFdTXkYRRCQSIRdQrGcqzLCCbaC0AlrB
	 SgklTxryp1QgXAAww1rwdUoTDfbYh2IuCciIsCXoKVaFrDV7o5eOX2ENo7XjMbYB8x
	 KlVwh/0Jm1LeH10YV2oIIQ3H8SiLGFJzkVdh4PEod4LX+LafBZ/x5w2lANcPWWjuBN
	 bhR3eTgCCZvFzWL1uW4SqbU/57DwRNcpMVti/jZuX4rTtBKFBAbH7/bMT7kxfiY/KA
	 i0AmWt9cJ60uQ==
Date: Sat, 23 Nov 2024 15:54:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] iio: dac ltc2632: drop driver remove function
Message-ID: <20241123155445.126bc8e1@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-9-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-9-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:32 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Remove driver remove callback for the ltc2632 driver.
> 
> By making use of devm_iio_device_register(), we no longer need a driver
> remove callback. Also since this was the last user of spi_get_drvdata(),
> we can drop the call to spi_set_drvdata().
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

