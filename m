Return-Path: <linux-iio+bounces-12880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B69DF285
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FEE162EB6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4951A3AB8;
	Sat, 30 Nov 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCla0k8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5181DFF7;
	Sat, 30 Nov 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732990516; cv=none; b=mH05y/TzSnb93uiis3tw5rLTS5MCdw9vn0RUpKKtLBnDwmYnKNdp6OJFfNVl9zfE8jCnD44N24+iyzTA4VmPRLBeV/9zPtRen4FmXnIu6uEe1NSX6NSHaFV4GTU0oj4koGMAeCq6uqVmcf6SneLsf9qXs5PL10SMKf+LY6u9Kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732990516; c=relaxed/simple;
	bh=RszhouBknQd4hQJ6vbo42fXjNHDl2wVR05Hy3WJggj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Hk5/d5JWAfOoD167eAW2J4BGDnRqgCJ7/K43IPHKvhE1rDsW4wgAeRy0+uYe0zPT6PRcgM/guC25BvQ45qSlBMWfOOSTPqdmNYg8MwQmeuDMWpILDXaCV8JZOBflZ3tZhjVc7q68wpkKGUXDbjkr1joEPGksW6DFGGJubbfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCla0k8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18818C4CECC;
	Sat, 30 Nov 2024 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732990515;
	bh=RszhouBknQd4hQJ6vbo42fXjNHDl2wVR05Hy3WJggj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TCla0k8E8+6l3zgqTzNl5fQBhJro+F2XL2pSWW0l6atOWkrkYly1QU7Y/lbS7Sh/N
	 qwksffAGQ0nC45oneB2S71nqrmXd/zC3qlQ4vKQRhtpMeTnv1mHwT5qdd+y+ohB5ne
	 M+O9BjV/meh5obyDIc+WGuVKq5XX0+cEtKJpd5ijpDsUdn+iQJEuefSEV4kywAUWml
	 SFn4iaW21axSBPN+7HnYsHpo+YXJvEdayXI851nvUn8ZiyR5WSdQyVoNoBoHksoUlR
	 r1E+E60yJL/Akpib0YfXu/iijo3UMJv+8k4XZSRPXuPRkyHWkZpb22PnuHOgdcRZBt
	 bXL+9Io7oNiQg==
Date: Sat, 30 Nov 2024 18:15:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <20241130181506.27d0c72a@jic23-huawei>
In-Reply-To: <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
	<9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:03:40 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Many of the Kionix/ROHM accelerometers have a "PC1 - bit" which enables
> the accelerometer. While a sensor configuration like ODR, g-range, FIFO
> status etc. are changed, the PC1 bit must be cleared (sensor must be
> disabled). (See the description for different CNTL registers [1])
> 
> In order to ensure this the kx022a driver uses a mutex, which is locked
> when the PC1 bit is cleared, and held for the duration of the
> configuration, and released after PC1 bit is set again (enabling the
> sensor).
> 
> The locking and PC1 bit toggling was implemented using functions:
> kx022a_turn_off_lock() and kx022a_turn_on_unlock().
> 
> Based on a discussions [2], the IIO subsystem prefers open-coding the
> locking with scoped_guard() over these functions.
> 
> Drop the kx022a_turn_off_lock() and kx022a_turn_on_unlock() and use
> scoped_guard() instead.
> 
> [1]: https://fscdn.rohm.com/kionix/en/datasheet/kx022acr-z-e.pdf
> [2]: https://lore.kernel.org/all/20241126175550.4a8bedf3@jic23-huawei/
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
> v2 => v3:
>  - New patch
> 
> NOTE: This patch uses the if_not_cond_guard() which is currently missing
> the iio_testing.
> https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com/T/#m69982b23da9f71e72d84855b34e9b142cb3a1920

Looks good to me.  If no one else comments, I'll pick this up when
I have the precursor available (so hopefully just after rc1)

Thanks,

Jonathan


