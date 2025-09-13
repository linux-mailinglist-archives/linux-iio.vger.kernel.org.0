Return-Path: <linux-iio+bounces-24058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 185ECB56184
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E537B674E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D42765D9;
	Sat, 13 Sep 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dowlIimL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA473D81;
	Sat, 13 Sep 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772992; cv=none; b=uofA5SMF72bApqG00mWzw48jz1s+I2xVPlHux7xZKlF+BLCvyIRnwRwUY3AxfdnQ1ogQHfnPhIbyC2HkIuE9DVDlaXoB73hTS43oNuERYRMni7yj1TysTDwB//GSuzRZwOvbXY5nHIUx96Jr4nE+qnX2vEdMHqEKhETxaKPk1RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772992; c=relaxed/simple;
	bh=gwgLITtI1za1PKOdQw+7Ui4Na/UGYPWWD/vcEuMktLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrnzRVkXUBtyn9NU5XeR+5FDjgzyy487QxksB2oXfvgXB7crqnUzgYgLp/NPAB4Uudc4e2nDgu0ubiimffGuFiQNyNAwQ32nLmpiipMe7SePqDdziojOWxwly+m9aKr7ggYNDqZzva6VDIvk8uU/zQy4WW+wNDvNndvT41AhQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dowlIimL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF70C4CEEB;
	Sat, 13 Sep 2025 14:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757772992;
	bh=gwgLITtI1za1PKOdQw+7Ui4Na/UGYPWWD/vcEuMktLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dowlIimL/K5PsVcRodzXHhHYlp8JYfO29kPFgqvGwDttSRDW6L86wCHoLfX0iy2Io
	 ZvmSfFaQuze9nqgdUj+5cfRJ25rh7Avo6t32N9WQtwI4UJHirr4RHu+1YKx6Kq+68s
	 osdrZHU9Ae+/FWjxpxUgMFzVhtFBL7538zjIomeRr8fFbXjRMHkY6KxosioZkjXlAq
	 L0vJfvJzCkC9yvsN60KJNXnCQXC8gGyKSuMVsf2TaVtLahRsDVLoWYrP49LKMq4hEp
	 0fZjfbRRndi10Su7/OS16IP+zo0bnjn5X6UhghId8+kLDA+AC/Su5Coc1lEjAZ6C3j
	 B8eqXE7jDp3RQ==
Date: Sat, 13 Sep 2025 15:16:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad7173: add filter support
Message-ID: <20250913151624.25515457@jic23-huawei>
In-Reply-To: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
References: <20250912-iio-adc-ad7137-add-filter-support-v2-0-bd32dfa3d761@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 14:09:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Adding yet another feature to the ad7173 driver, this time,
> filter support.
> 
> There are a couple of leading patches to rename some stuff to minimize
> the diff in the main patch where filter support is actually added.
> 
> This was tested on the EVAL-AD7173-8ARDZ evaluation board.
> 
> There is still one fix sitting on iio-fixes-for-6.17a that needs to be
> merged back into testing/togreg before this can be applied.

I was being lazy on resolving that and still had the previous version
in my to apply queue ;)

Anyhow, easy to resolve, I've merge v6.17-rc3 into my togreg branch.
That is also in char-misc-next so assuming I don't mess anything up
I should be able to send Greg a pull request vs that and everything
should fall out correctly.

Jonathan

> 
> ---
> Changes in v2:
> - Dropped filter ABI alphabetization patch that was already applied.
> - Fixed ord/odr typo.
> - Fixed typo in cover letter subject.
> - Picked up Nuno's review tags (I didn't do anything about the race
>   condition since I don't think adding locking to the filter_type
>   attribute read would actually change anything in practice).
> - Link to v1: https://lore.kernel.org/r/20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com
> 
> ---
> David Lechner (4):
>       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
>       iio: adc: ad7173: rename odr field
>       iio: adc: ad7173: support changing filter type
>       iio: ABI: add filter types for ad7173
> 
>  Documentation/ABI/testing/sysfs-bus-iio |   5 +
>  drivers/iio/adc/ad7173.c                | 204 +++++++++++++++++++++++++++++---
>  2 files changed, 195 insertions(+), 14 deletions(-)
> ---
> base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
> change-id: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
> prerequisite-patch-id: d020799a8e7fcc092607923f977b62490c83f11d
> 
> Best regards,


