Return-Path: <linux-iio+bounces-14808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC84CA24911
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA3D3A51C9
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C241A76D0;
	Sat,  1 Feb 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mc95LnET"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059BAD39;
	Sat,  1 Feb 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413503; cv=none; b=ig1wpidBD2b7Gm9FsVxKDYV7RYcIhnjpug1F2B3vCgqlnzmCwiKiiIaYYH0pYIvY0pj0tsL9ZYXDRM4aMoehvWCz2ZPkPlIPML6FfH4S8b5YECJ3rzdqBZMwYx12vrF4v4qdDK48VEjYdRz2ERHh7okI+xkX2Khzr03Mj0a00Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413503; c=relaxed/simple;
	bh=E26WBFF0kORXwBkWe9Y7XjxoRSVCnOAfam3cDmxVn4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjEbsxctwlhDrwwoESnR0IJisNFDhIF8BCDCQKXY38S48Wd8lwUnn7ezl7NJDja7XuR5mKcuiLcsrVsXu056VwiLGhKeTH2a+ZObe7I6h3NosSt2ophxrL/FD0ISBsEg5nxCf7amQQAwVRxkMABxjl2RlEJnoZ9YkQ8aj5vck7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mc95LnET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472A4C4CED3;
	Sat,  1 Feb 2025 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413502;
	bh=E26WBFF0kORXwBkWe9Y7XjxoRSVCnOAfam3cDmxVn4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mc95LnETFyghDXy7yHETMPDyXjNbNiKy7bPZmlWm9SDKX4Kr9u7bwh2zH1p6A5c7f
	 WSRNmYk3x+qgDrGcF+FdapMrX47CSnsmBWQXHy1Z5Fqt2cXy8kZ3YGUP3KlBvUrQut
	 R7j1BHrrnzpXqvIAhceOGYAXFQ+jnnD1FnzRHdmyrHCLW8mOWXM7u+l3wKWwLjoLfp
	 zV12DzsrTEl19SsEfBWo8KS7pkLOrlipbM2n6BbsoZGRhfY0mYSgUsJ6sepi3hQsm4
	 Dm6UTt+ZVDR4zBIWzjHF5hRY4N4EYi6W5l4akKiIM51N2XDw/vNPU6XYTcqq67MOe1
	 dwe6YT+jlJXug==
Date: Sat, 1 Feb 2025 12:38:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v5 2/2] iio: adc: ad7173: add openwire detection support
 for single conversions
Message-ID: <20250201123815.3a48a6a0@jic23-huawei>
In-Reply-To: <20250127-ad4111_openwire-v5-2-ef2db05c384f@baylibre.com>
References: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
	<20250127-ad4111_openwire-v5-2-ef2db05c384f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 14:59:33 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> Some chips of the ad7173 family supports open wire detection.
> 
> Generate a level fault event whenever an external source is disconnected
> from the system input on single conversions.
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

>  
> +/*
> + * Associative array of channel pairs for open wire detection
> + * The array is indexed by ain and gives the associated channel pair
> + * to perform the open wire detection with
> + * the channel pair [0] is for non differential and pair [1]
> + * is for differential inputs
> + */
> +static int openwire_ain_to_channel_pair[][2][2] = {
> +/*	AIN     Single    Differential */
> +	[0] = { {0, 15},  {1, 2}   },
> +	[1] = { {1, 2},   {2, 1}   },
> +	[2] = { {3, 4},   {5, 6}   },
> +	[3] = { {5, 6},   {6, 5}   },
> +	[4] = { {7, 8},   {9, 10}  },
> +	[5] = { {9, 10},  {10, 9}  },
> +	[6] = { {11, 12}, {13, 14} },
> +	[7] = { {13, 14}, {14, 13} },
Given I've been poking others this morning to add spaces after { and before }
(arbitrary choice but for IIO at least I'd prefer consistency!)
I've added those whilst applying.


Series applied to the togreg branch of iio.git.
I'll be rebasing that on rc1 once available, so for now just pushed out as
testing.

thanks,

Jonathan

