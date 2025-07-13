Return-Path: <linux-iio+bounces-21616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57FB03198
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A696166A77
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132427990B;
	Sun, 13 Jul 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYoGRir7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F072594;
	Sun, 13 Jul 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417487; cv=none; b=YiunUN/3Agb09ybO0Ojir46d7so3SYD7YD4po8oyZaJy6/k6DA68r+idA7wRmcGCjCe/9+zHVffZbYo4NcYgvUiy8CzjlKRS06I2hUnsoPZ8m/dO2uCUurwSKzjS33wgQuX3rOx0KJFKPSA1HE14i97ucV9gZE+IfBM4GSWY4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417487; c=relaxed/simple;
	bh=s7GUW74Cr2TeyuM7RuAjS8HuUisCmvF/8dXP2eJt+uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kawZs4hn+l6QiYq5dIDnTRoYjIg1YIwPCIgl8t5Hn2ThF+IQ9aacoMu8Ca2EpSxVrkTKekqn+HPpWh4F3BlMCk8fPsxqPpf2KLC3b4noPrSFvuydbmact7CHeh4+77N1sY034rF/9EniutYLyCypMKNy6g2gFNBgKtqNSqVuH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYoGRir7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46740C4CEE3;
	Sun, 13 Jul 2025 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752417487;
	bh=s7GUW74Cr2TeyuM7RuAjS8HuUisCmvF/8dXP2eJt+uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYoGRir7IA1LyOv19GnAGZndcDu4npLJiCkJV9R5Sm+fxv2H3EiqOp5sttR9ADiSB
	 0Qt7LM/kWXXkaBMec1yani57YveXxM5aEW7a7Du44TquXHEn1bGNT/uEQqBKfd9v2i
	 tRC+de7tBRDJ1tVd/riLOm2G2Ul7zM4iSz8L5oVKi2fDpvL3poobiGEuCIT8q47cZo
	 +0QmQk0XxRrxfxuIBjcD8mrNYbYLm7te/hTPIFgDiH0HWTey/wvzspr4xviU+Wf1wi
	 TCWASSp1fr2G4fq8utavEu0ItgpBM4PGSpWgq1myF39x52zi4S0HfBuGl14BoyHfwP
	 lcTWHQir3i5xw==
Date: Sun, 13 Jul 2025 15:38:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Andrea Merello <andrea.merello@iit.it>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/2] iio: imu: bno055: make bno055_sysfs_attr const
Message-ID: <20250713153800.69e59085@jic23-huawei>
In-Reply-To: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
References: <20250709-iio-const-data-19-v2-0-fb3fc9191251@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 21:19:59 -0500
David Lechner <dlechner@baylibre.com> wrote:

> v1 of this series was already applied, but we got a cryptic error
> message from the 0-day bot [1] that that made me look at the code again.
> 
> I found a potential bug that could be what triggered the build failure,
> but it is hard to say. I couldn't easily reproduce the issue locally.
> So I've included a new patch to fix this issue along with a v2 of the
> original patch so that we can see what the 0-day bot says about it.
> 
> I also noticed a mistake in the original patch where I missed one more
> place to add a const qualifier, so that is fixed as well.
> 
> [1]: https://lore.kernel.org/oe-kbuild-all/202507100510.rGt1YOOx-lkp@intel.com/
Dropped v1 and picked both of these up via the togreg branch and marked
the 1st for stable.

> 
> ---
> Changes in v2:
> - New patch to fix potential issue found by 0-day
> - Add another const qualifier that was missed in v1
> - Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-19-v1-1-a17e7c16b122@baylibre.com
> 
> ---
> David Lechner (2):
>       iio: imu: bno055: fix OOB access of hw_xlate array
>       iio: imu: bno055: make bno055_sysfs_attr const
> 
>  drivers/iio/imu/bno055/bno055.c | 56 +++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-19-298c08d506f5
> 
> Best regards,


