Return-Path: <linux-iio+bounces-7644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4E932FA3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72E52811CB
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A171A01B7;
	Tue, 16 Jul 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGpeMa6u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DE1A00EF;
	Tue, 16 Jul 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153106; cv=none; b=St0/0vOJp5pe676GY6GVWYUblvKDFe3Rj2FjD/Nm8BDjYN1rKKCtOwvRfY6SxuDeK+BhUYEWpxtDqY3womRvRYVIJglAlaH2TarOynsCuNV10GozELmACUrR4pomAg4quRfOFnSIGYqdfiw6qpQNpi64c5xxSrYo64qphtyGAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153106; c=relaxed/simple;
	bh=ASZrSSvR1REVMHOkGE/VS4MXKISPJeRoV8+E3J8ILDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5Zbuwq1WuHyVc0w7YlaDp6pWM3mmhF6gYkODJWkMjFWc7MIQsLVSXKszL3vwBbU3mIjQ3yeVef3HPWo0Rb1TyVkekOJX1a/YWkdoMJ/qm+tRpcZlEzDgfvk2UR6e5RKq0zVw1iSTQmuwHh47plLERPR2t+K8tHugAW9KN/hswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGpeMa6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F880C4AF0B;
	Tue, 16 Jul 2024 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721153105;
	bh=ASZrSSvR1REVMHOkGE/VS4MXKISPJeRoV8+E3J8ILDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jGpeMa6uejAaurZy2Tl7K2qFNw/vbmwf3rTbXSPG/sPJyoc+8Kgs9GGnxVy/3ornN
	 uqw5xi6jfLA42cZ8MSTkc8UvLFiNl3s3rG8/XwVJExrIVjSp6RjDnrTjJYUzPAh/Zl
	 rNegSf47EJ17SjLldw4J0mIWBREJ/KGi+/+ghQf7pj5zUqkXu66SVAwgVfMP5O1Yvq
	 w52VqxNH//YbpiKsJ9W05cKVbxqVBeAU5cTqcyz6ExDbh4gtahXZAiZAhqxYC+e5Hw
	 OesR+DP9VwfGrUosg/P06ZjkJyRT79hlvdno297LN0mNte3k/IPPqI6nzn7YKRSGUG
	 qmmqv3GmYr8bw==
Date: Tue, 16 Jul 2024 19:04:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: new docs for ad7380 driver
Message-ID: <20240716190459.7cfad009@jic23-huawei>
In-Reply-To: <20240709-ad7380-add-docs-v1-1-458ced3dfcc5@baylibre.com>
References: <20240709-ad7380-add-docs-v1-1-458ced3dfcc5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jul 2024 17:16:46 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> This adds a new page to document how to use the ad7380 ADC driver.
> 
> Credit: this docs is based on ad7944 docs.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Only thing in here I wondered about is talking about what libiio supports.
That is likely to change if we get lots of devices with the sort of resolution
changing that occurs with this one.  Ah well, I guess we will probably get
stale docs if no one is paying attention.   That happens anyway for so
many other reasons I'm not that worried about one more.

Applied to the testing branch of iio.git for now as I'll be rebasing on rc1
once available.

Thanks,

Jonathan


> +Since the resolution boost feature causes 16-bit chips to now have 18-bit data
> +which means the storagebits has to change from 16 to 32 bits, we use the new
> +ext_scan_type feature to allow changing the scan_type at runtime. Unfortunately
> +libiio does not support it. So when enabling or disabling oversampling, user
> +must restart iiod using the following command:
> +
> +.. code-block:: bash
> +
> +	root:~# systemctl restart iiod
> +
> +

