Return-Path: <linux-iio+bounces-23607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7EB3EE75
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696451A837A7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EFF25E451;
	Mon,  1 Sep 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/ccc8WV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EE1684B4;
	Mon,  1 Sep 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755146; cv=none; b=U7fCoQyZsWT8KsT/cnQYAAhcWBTNhsed65JYFsClPdLbeoSwxoEahkx/llODkD4M16nndMYmHBcnvRblzAnxVMuLur45arSxNcp5KMvpvuEfAR8wdqAAw31Yn3AsvfPEWQ+aHEj4Ma89PDfO7yvXVbx+mbp1JK0gJLbrZXZjvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755146; c=relaxed/simple;
	bh=p9ih3IFZkK1xgHDdx6md08bNTJAtkHeqiF3+RjxnHWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQre/idOLHW/p1pEmjs+oiOoZT7yAmqqn4vjntDcXm2GilFdtdQhVHSJozmEuRdgIQkT6s2mUxAKVa1H4tGp1+XD/lGqa28k4MT3ebvAaBXhg4WewPatLJAWa3tBfQ+N3ribjF7RExO+3DE0a8ZW24hQ7HonuFmhoLvtlyARHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/ccc8WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A08C4CEF0;
	Mon,  1 Sep 2025 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755146;
	bh=p9ih3IFZkK1xgHDdx6md08bNTJAtkHeqiF3+RjxnHWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/ccc8WVG6fGGf1JIqWLGAW5h8DMeA9/YBzqSWv/e0ff/5hVBGWr0m1K+jcU60vgF
	 UPSWuocywYcqtK2AmurVJtL0LUTldPZdzBSgrJGp43AMtHaroy3yzBqKkgz+bt3J+a
	 Mx8gKM9iO4kMOndF6JdU8x7oQlFkiqN9cFQsTC0GuvHtD62RjqHwSSl/4RRom9s/B7
	 FOuu1pPFEvAA0cg5R5UnvPBboHsViv7pNTQ2BXbDh2F6Kd2En3KrFRawmPgUNO5+nb
	 FCztkZa4lbLYEPpwgK3lEFVDamPbGuWZUFJCcwb0TYiERalr+B4566rDRxkEapWDkX
	 G3/2patoP/dYQ==
Date: Mon, 1 Sep 2025 20:32:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 4/5] MAINTAINERS: add entry for inv_icm20948 driver
Message-ID: <20250901203216.009b886a@jic23-huawei>
In-Reply-To: <20250831-icm20948-v1-4-1fe560a38de4@gmail.com>
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
	<20250831-icm20948-v1-4-1fe560a38de4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 00:12:48 +0530
Bharadwaj Raju <bharadwaj.raju777@gmail.com> wrote:

> Add MAINTAINERS entry for the InvenSense ICM-20948 driver in IIO.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Preferred to build this up as the code is added.
So initial entry in the DT binding patch, then add the directory
when you bring that in.

Jonathan

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..930c80c1cc40a4cfb4bf270e1ab7680b88d97ff3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12783,6 +12783,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/i2c/isil,isl79987.yaml
>  F:	drivers/media/i2c/isl7998x.c
>  
> +INVENSENSE ICM-20948 IMU DRIVER
> +M:	Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/imu/invensense,icm20948.yaml
> +F:	drivers/iio/imu/inv_icm20948/
> +
>  INVENSENSE ICM-426xx IMU DRIVER
>  M:	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>  L:	linux-iio@vger.kernel.org
> 


