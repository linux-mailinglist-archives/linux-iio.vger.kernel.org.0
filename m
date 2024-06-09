Return-Path: <linux-iio+bounces-6098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B107090157F
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C38928128E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDAC208D7;
	Sun,  9 Jun 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoTDP9Ps"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83F208A0
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717927804; cv=none; b=rnCPn5k+p3p94DdwIQ9BXapf09tko9gkngroovWGzxNwtie9vtxsqIQSBjCu3SI2q4yZDNDD+Xi5EbMEcP8SslN1sLaT1GmeCtlE+nmWxHFdpumsiSZooPf3fAmy56i0xL6UBwOIjcvPYDVOFvf/cLt/HkQmBb3tZCLpH5P/7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717927804; c=relaxed/simple;
	bh=aaZ+OM3jHgDzoDYfXmAcIia1TP4mZhk/E4HNsZ8rw4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRfWy+hOU9PQ9VQM8wqJ1akXMVYStUIXfHUJwVSigewM7mcIUG9HmIGOB6pC/KxMees90ipqInbwIE0PolQ3zYl0j1SS0QncDR/BZVmIapVRTQyKfswkP0R1SyYQFeK31G97kXjB6lCgnu5ZpTN/Hxm8QT+ogrCOt88K7Joo35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoTDP9Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D31C2BD10;
	Sun,  9 Jun 2024 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717927803;
	bh=aaZ+OM3jHgDzoDYfXmAcIia1TP4mZhk/E4HNsZ8rw4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SoTDP9PsvUG8nQtSk1sXUwguafvy1VLO+6tmlkQpin1fMCQEVvLv6M2yvTRKKFnGR
	 Pat8DQ12R0HRkdnzI1h1Jk3oFc3TUich0EK9X2L91kxf48w54cisfA6kWNNY8CEF8b
	 2H/O7OXbBQbdjbTyJswA/IFyD5LCx+8v67bUbY/4UPgQ5Xfu1eTESl39PdKF6LTn6H
	 vk+zSJJAdEbU1d3lEdsX1ChUvOdc5HV2Ar1KochFFpiwSSvDLkLY4j+8nDBTXqKSI7
	 wfPNY0rk9gzjS3ICgjWTJTw3mtSOM0GYr9VzpIi4ks3kxCQJafHoRb6t5W9S8oGj9V
	 HVss8wHeqGiEQ==
Date: Sun, 9 Jun 2024 11:09:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v4 0/2] iio: imu: inv_icm42600: add support of accel low
 power
Message-ID: <20240609110930.2f40d3d3@jic23-huawei>
In-Reply-To: <20240605195949.766677-1-inv.git-commit@tdk.com>
References: <20240605195949.766677-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 19:59:47 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add accel low power support, enabling use of lower ODR below 12.5Hz.
> 
> Add new sysfs API for controlling the power mode and enforce power mode used
> when using an ODR that supports only 1 mode (ODR < 12.5Hz or ODR > 500Hz).
Applied to the togreg branch of iio.git and pushed out as testing for 0-day to
poke at it.

Thanks,

Jonathan

> 
> Changelog
> 
> V2:
> - fix patch missing Signed-off tag
> 
> V3:
> - make all ODRs available and switch power mode automatically for ODR supporting
>   only 1 mode.
>  
> V4:
> - prevent power mode setting when the ODR is not supported
> - return the actual power mode when sensor is on, otherwise the requested one.
> - add sysfs ABI documentation
> 
> Jean-Baptiste Maneyrol (1):
>   iio: imu: inv_icm42600: add support of accel low-power mode
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
>  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 124 +++++++++++++++++-
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  27 ++++
>  3 files changed, 151 insertions(+), 4 deletions(-)
> 


