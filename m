Return-Path: <linux-iio+bounces-12551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05699D6A05
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05CDB21473
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC474D9FE;
	Sat, 23 Nov 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK3NjLgY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239622331;
	Sat, 23 Nov 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378834; cv=none; b=oULt0CML0vMlK1gPMXDKrBZKu/tJ9aQ0LjTvv3B3MdBFNMuM+o6sM/YoLeAwrw9k9fV8r5RBSrAreIfiq6LTVFDxrTcvowZ53zgdzXmyU3yZj3qrm7Q4QDEDrkAVc/Mkal/AkY4Jv2sPE39tN1HXxoUEfFCDFyv57vP+B/yJ8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378834; c=relaxed/simple;
	bh=xVZr39EjXsn9ui7UOCJ/DWkjLbWgi+2mM166rQ4nkCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+jUkhlidEuKYsBX74RjsIU0iW4sW4v6SoyYKx4gNOoZtKYn7PvrhWvRazkRYdUk8ecD48aBjo0CJvc+wqstNw4k9EKZJygK7p4/ob8QmvehQtFigu9mFMoa2q6OMguRinmbCylyYZmucKYlfgkIgm71kl3brnELk7CA7LOjbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK3NjLgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9ADC4CECD;
	Sat, 23 Nov 2024 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378834;
	bh=xVZr39EjXsn9ui7UOCJ/DWkjLbWgi+2mM166rQ4nkCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aK3NjLgYNHb49bNN/ktAuOE8Iev51TiQ5YqJgaSD+xyy39ggaloOBfPbLlcSypUbE
	 NuMpfn5PaxXyfDMKW7LJMSVXmgUcahClkEGC7azMOoyoNKy9UB/LrzbfejkLAmqBd2
	 BvdsqZsfsrss3+6meioI96nhjctjuK93PZ0pLfq7YeUdtJ/S+wFiMZLnExFKgOhhuo
	 lvzI9/lvLS/JV0Ovwpf9ZIQCcZX3jYsw5WY6Ga3XR8Z7KF1dI62sx02oAtvGE/hhbW
	 9C2nqiyhoKSJdXsP3HZN+pPcmDTtfjjpuZo6zNigrD+kx/tbu8zS8sqdABQ60pAGEU
	 y0tYU+/5WUUwg==
Date: Sat, 23 Nov 2024 16:20:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <20241123162026.441ed19b@jic23-huawei>
In-Reply-To: <20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com>
References: <20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 10:30:10 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Burst write with SPI is not working for all icm42600 chips. It was
> only used for setting user offsets with regmap_bulk_write.
> 
> Add specific SPI regmap config for using only single write with SPI.
> 
> Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied to the fixes-togreg branch of iio.git.

I'll rebase that on rc1 once available.

Thanks,

Jonathan

