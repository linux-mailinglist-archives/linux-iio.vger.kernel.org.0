Return-Path: <linux-iio+bounces-26889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB17CAB6AB
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4A8D3004D34
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962B1B983F;
	Sun,  7 Dec 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmULzGzW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEE1DEFE8;
	Sun,  7 Dec 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765121647; cv=none; b=GgfwxTrPIkxH50V3nDKWPpEipDaWftStfZB1v21XPGH/LsTHSjnIM3biv1k6fqpaezzfqu8nLLBEUjO7YsA1801P3kqGI4R750yHoeWzsITtaMu/NALFcKRvmStq5IkIps2wDx/Vg16ggC9YIFBczFcasWqaYWpjzPgFMds9YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765121647; c=relaxed/simple;
	bh=UgSBixqOiP0rF1znPFOetgqond9uhlZBZ4tAEg8CPdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSuPNRdxYso2DeDAQBwJncSj/qObC9ws6KvCKomGlqHVrKdbx4OtQ6ySyxpTP3nBVeG2DadAog9wespbBrQI3W4T+s2VVXZp4Cr4hSU0CMxT9opnqgz7ecnYzjfG7X8M7NxvjEMbCISvYOfOt4tBoSc3OPmzWafamqo0SZ7gDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmULzGzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68441C4CEFB;
	Sun,  7 Dec 2025 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765121646;
	bh=UgSBixqOiP0rF1znPFOetgqond9uhlZBZ4tAEg8CPdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hmULzGzWlmyizMkOSFKO/WoZvqCaazFdqlAJ6maROX+LlGGjuJHrJ56BWnbAgW8lx
	 iMKqmi5ZaceiPiI0rBzD/UvQf/PoOGSJ+ujzoKGP+D+0I8I44C6RkhS+2a0n6t8QzA
	 wIDQlEXjjQBeEwbWip8RUCDjVX55Uuud8qcuyJhZDs9Ua8NjxfiUwqP+bBr2h30t34
	 eeBmbIVn2FCaakKTPaLJQlQo3VPor0qolcHO/xOP8f5XSwsJvUIY4KiCrxi5ZgcGeE
	 Ei3ONU4iPKmfFj1nDi+1pflsPuNp+OT0Kp9HPtMuCjcPucw/+cfiNldX1Me4qr+eE4
	 t5CnJ5z/VYhoA==
Date: Sun, 7 Dec 2025 15:33:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 6/9] iio: imu: st_lsm6dsx: make event management
 functions generic
Message-ID: <20251207153358.49a7e515@jic23-huawei>
In-Reply-To: <20251201100018.426749-7-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-7-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:15 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In preparation for adding support for more event types, use an array
> indexed by event ID instead of a scalar value to store enabled events, and
> refactor the functions to configure and report events so that their
> implementation is not specific for wakeup events. Move the logic to update
> the global event interrupt enable flag from st_lsm6dsx_event_setup() to its
> calling function, so that it can take into account also event sources
> different from the source being configured. While changing the signature of
> the st_lsm6dsx_event_setup() function, opportunistically add the currently
> unused `axis` parameter, which will be used when adding support for
> enabling and disabling events on a per axis basis.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied.

