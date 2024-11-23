Return-Path: <linux-iio+bounces-12542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB09D69C7
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58C3281B83
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D63398B;
	Sat, 23 Nov 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiCJWc3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3062E64A;
	Sat, 23 Nov 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377222; cv=none; b=J11qfaNxfNLv5WLW3dhpjx1ICrxPrcYPMGZaFI2h36APV48liSwkXr4quEJel6MFeIjhSyHyq+YHD9LxdaiABbmSdRBx4RVi/1THnkF7FEQx/4Bs97IzEhpmccxDtg0boW56wwg8ZWXv81IT1pkn6fRxfpL7yXvMQpAiIrPI9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377222; c=relaxed/simple;
	bh=SYajNSADM6KMip5zx3jt7yIcz5z0/VMigPAQZj0RY+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+ahyfo8HTddCv4Vzv5ntGf8yp3NlHtec2XuuiF2raDULzsoKZnpAB1eJ3VQht+64naBUc3JaACIn48GsoBwd6H78mAUhDjf2d6y1N9mCV27iC7eHC91pEOu2AiIMhXc71tyESE2w0TnOkwTs2kEgogjnYmlIDU1HBVCKxnhlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiCJWc3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE3C4CECD;
	Sat, 23 Nov 2024 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377220;
	bh=SYajNSADM6KMip5zx3jt7yIcz5z0/VMigPAQZj0RY+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BiCJWc3Au4JgfEX3Os9Z3xQf0R990FKrsLf6uiZ98RbHdWKRh73OxD+wGu6j/cczD
	 8MJwhxoGLjXxgTC/+ZVh8OM9IrGLSiqBnBqcHLUmemNwnHrr+xFuQ8bAQUPusRCAbA
	 /pBbiy5hQY/grXj1RBy4efqsjQLokEhtT3Hc+neHzprSDdnNi3JhHq0ztSG4h0tWzH
	 ICVWB9ZxqlO+dcZUrdeFFbeYWG1mmbPch6GK4mS62ce3ezFlAfz8Av1JGpMCtwfSFl
	 kwfObAWPvbvg8LPFx4gkVc5fIV9r4I00HHgMmJkxo/RZF+csFLJhdmP23Rkd/t7THh
	 ssTpvHwuGzZbA==
Date: Sat, 23 Nov 2024 15:53:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] iio: dac: ltc2632: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20241123155334.0f09e06a@jic23-huawei>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-8-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
	<20241120-iio-regulator-cleanup-round-6-v1-8-d5a5360f7ec3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 15:33:31 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Simplify the code by using devm_regulator_get_enable_read_voltage().
> 
> Some use of dev_err() is replaced with dev_err_probe() to simplify
> things even more since we are refactoring these lines anyway.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

