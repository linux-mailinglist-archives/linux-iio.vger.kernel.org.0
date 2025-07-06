Return-Path: <linux-iio+bounces-21407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8CAFA678
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EB41791E1
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654D2882DC;
	Sun,  6 Jul 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiJC9TZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687C2CCC8;
	Sun,  6 Jul 2025 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818917; cv=none; b=U55CUBPQMZtDdQNfJK5g7aFzYmHSwG452PtxW4ulo0sm9+Rz2pcd7yIbLUtKHL5HzHLmOHS91SmFJOZQI4hBBHiUVp4dAzBsbyD9dBJhZhfvEEHohOTPcGqnzhBsBrf8/uh628fa91ejjxjpPh3un1cR6HBA2ybZCFwxzEu83co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818917; c=relaxed/simple;
	bh=MdkmF+lxOrXvA8gQV3LtH/NFy1tZPLWoMC+63kKWP/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLKM1IPlDRhzKod7xZMernzzJ/lt2tfgWmFEwIcItkRjnD8DORW0MzcK9UyRpoYYFKO7p766QBxT7hl04nxCqJfuKnOcIda3ljtlXHCSl3ZJIok/MgS0lbPSK+uEK4mI+Vs10Cqmnm4TAek3EwEsMvD8M0Eb/mkMdBiccggrY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiJC9TZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58811C4CEED;
	Sun,  6 Jul 2025 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818916;
	bh=MdkmF+lxOrXvA8gQV3LtH/NFy1tZPLWoMC+63kKWP/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiJC9TZsI7AyvCPkjy03TL6zK+h842kiMMxQR3oY8YmxjFHjf/QasHKhPRfiYsVtt
	 vUwjWJ9ely691TwN9mRnEhlegyc+Ly+Vrl4UePPl/ywcZBka7bD+0lxxkDs9nuTBOz
	 To+j5JLCLAklPBT1BEHtpibb/PqTD6UzCZ9fEih6BFxdecaA5RnW0hUWWGp+bVc4dW
	 CRNNw/vTIdg/EnPyRKUEmWhOzc1RshNR+8LHvYdv4uuoGnn/43X+Ob2rgLcrbIxiwh
	 /pTbksOK3wA7q2zwzJJ2xUjud7tmVl7wanMnoNUW36zLXo3GN3CLB0Hv9sHOksz9J9
	 syIt4RV8EvT9A==
Date: Sun, 6 Jul 2025 17:21:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add support for WoM (Wake-on-Motion) feature
Message-ID: <20250706172150.556972c0@jic23-huawei>
In-Reply-To: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
References: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 21:47:28 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> Similar to feature present in older chip, it compares the magnitude of
> the last 2 accel samples against a threshold and returns an interrupt
> even if the value is higher.
> 
> WoM maps best to accel x|y|z ROC event. This series add system wakeup
> functionality if WoM is on and wakeup is enabled when system suspends.
> 
> This series also prepare the driver for supporting further APEX
> features like pedometer, tilt, ... It introduces an apex structure that
> will hold all APEX settings and track the enable state.
Applied to the togreg branch of iio.git and pushed out initially as testing
for 0-day to poke at it.

Thanks,

Jonathan

> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> ---
> Changes in v6:
> - Rework scoped_guard() for not using break
> - Reword move DMA buffers initial patch to add better explanations
> - Link to v5: https://lore.kernel.org/r/20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com
> 
> Changes in v5:
> - Add preliminary patch to move DMA buffers at end of structure.
> - Check return code of devm_device_init_wakeup()
> - Rebase and rework series to use kernel types
> - Link to v4: https://lore.kernel.org/r/20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com
> 
> Changes in v4:
> - Avoid mix of gotos and scoped_guard()
> - Invert conditionals for better code readability
> - Switch to use devm_device_init_wakeup()
> - Several code readabilities improvements
> - Link to v3: https://lore.kernel.org/r/20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com
> 
> Changes in v3:
> - Rewrites following code review
> - Link to v2: https://lore.kernel.org/r/20250415-losd-3-inv-icm42600-add-wom-support-v2-0-de94dfb92b7e@tdk.com
> 
> Changes in v2:
> - change struct order to avoir DMA overflow
> - separate wom enable/disable in 2 functions
> - delete mutex rework
> - Link to v1: https://lore.kernel.org/r/20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com
> 
> ---
> Jean-Baptiste Maneyrol (3):
>       iio: imu: inv_icm42600: reorganize DMA aligned buffers in structure
>       iio: imu: inv_icm42600: add WoM support
>       iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  56 +++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 329 ++++++++++++++++++++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |  97 +++++-
>  4 files changed, 470 insertions(+), 14 deletions(-)
> ---
> base-commit: 42498420746a4db923f03d048a0ebc9bd2371f56
> change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
> 
> Best regards,


