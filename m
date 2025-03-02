Return-Path: <linux-iio+bounces-16233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA394A4B12D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DDE188EE48
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD521DE4D5;
	Sun,  2 Mar 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqAliAIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51B23F362;
	Sun,  2 Mar 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740914977; cv=none; b=B6bq6fmY3cL9yMVmvdz8d5HKebde4gDYajxwX/TSZ2qnuMWSGa7skIrfjV6CI2wv+ApH8DX+9LtjkafsSec5cu35Em+4Xs1kJCccD8zJ3l1vq6tPjXn6eqrgB+gvr/yuiW9aI9KJmMx06B9toV04HZFIR+VOs7RxQEVK0MeZ6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740914977; c=relaxed/simple;
	bh=B+82VRcZq/EEV89XyWjuZ2cHYEmSHbv/QFGz7kK+HZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnlgFHLO/yJTCKsFw6Ayn8SghJON4yM2aX2J0ONy5cD765pDGsyVRrSI5pBrBGTkbRJWe//ns7kMwfge4KODw9ygEXy5G0vxP7RxNbB+OK3a9V0fr5MnYTTzAHdvKY8CWk/xLlUdzjs3OU6YJHR/p5zZkn2uWpCb2J07IkUDcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqAliAIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971EEC4CED6;
	Sun,  2 Mar 2025 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740914977;
	bh=B+82VRcZq/EEV89XyWjuZ2cHYEmSHbv/QFGz7kK+HZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqAliAIvw9YffV5O5kOf6BZzvEG+YJmUV2df9DA/N6MCFPUaxyw1bqFLMLg/7enWX
	 IM6AE9AyFQgUTR0N0LmIQtAPKnIJBvUfDoGpLVttO/1L2/3N5/6cWB/NTzALTYqMtJ
	 ksRt0k7p5m2duElNUveqT2e4/eY07JzvFX+g1bHfpHxmCfQYPeZfcG0eBZ9etbd/1x
	 GOKenucw+eIXB4dDXFgd4uH4p0tXEFdd0oPvm0Ri7XVu7Igjxod2nzEId0bERQuz4u
	 rZxKGi9Lj6kkCb+Rfy5m7D67oc7JWglMqNAH3BxXV9HkV6HwgSAFyaKMTVC8LSNqJ1
	 ERXsv/KA9qwDg==
Date: Sun, 2 Mar 2025 11:29:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] BMI270 data ready interrupt support
Message-ID: <20250302112925.05d3e593@jic23-huawei>
In-Reply-To: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
References: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 20:03:47 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> This series adds support for data ready interrupt to the BMI270 driver
> using one of the available interrupt pins.
> 
> Additionally, this series includes some cleanups to simplify and improve
> consistency across the driver.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
I'd already picked up patch 1 from v1, so applied 2 and 3 from this.

Applied to the togreg branch of iio.git but I'll push out briefly as
testing to let 0-day take an initial look.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Patch 2: Updated the commit message to clarify that the variable
>   'bmi270_data::data' has also been renamed.
> - Patch 2: Fixed some line wraps after renaming variables.
> - Link to v1: https://lore.kernel.org/r/20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com
> 
> ---
> Gustavo Silva (3):
>       iio: imu: bmi270: move private struct declaration to source file
>       iio: imu: bmi270: rename variable bmi270_device to data
>       iio: imu: bmi270: add support for data ready interrupt trigger
> 
>  drivers/iio/imu/bmi270/bmi270.h      |  17 +-
>  drivers/iio/imu/bmi270/bmi270_core.c | 332 +++++++++++++++++++++++++++++------
>  2 files changed, 283 insertions(+), 66 deletions(-)
> ---
> base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
> change-id: 20250219-bmi270-irq-9a2bc41faee3
> 
> Best regards,


