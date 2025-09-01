Return-Path: <linux-iio+bounces-23594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532ACB3ECA3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A7B481518
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245A2E041D;
	Mon,  1 Sep 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/+/gXiP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96E231827;
	Mon,  1 Sep 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745368; cv=none; b=SVHrQjiYI0crP+J2DckHRJ05z0K5VtihgyqZEgeqX4uTejwvtA9Yzhrae7swBb+BO10/DlMb9gfa/JB7oNysnKWyDRzvd9ngmPHPQTrScbYC6pc+27FWEHLbaxUPPUnCKbGCkthAOqLgY64MbRkUGHik6SguTVh60yc/D2Y97/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745368; c=relaxed/simple;
	bh=wXNt19FS1r8iJIE5qlf4LxmCtmvF8Eksl01N5CTdPJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUBznCTq18xqG8YOhntlVwkCARN7qKE602SIJSMUO7b2tYZOflMjAlhJxYpLxOOIuljyFrMHAJEiwlnXMzzKlLAWYHp027kGgDBr9UVCuRx/nnwUqcgoLgrvCiO3qhF3WsaBpzNgWxpbTthNv8E9+ACPvndhgDfZw7OmTz1U20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/+/gXiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A67C4CEF0;
	Mon,  1 Sep 2025 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756745368;
	bh=wXNt19FS1r8iJIE5qlf4LxmCtmvF8Eksl01N5CTdPJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/+/gXiPPsmyqy/OLike2rjjvf8ZFQLrJOcyn1eXoZNTExwzBr9ixaiUefIzhhuFk
	 ypsyCoe5jRGn2kFHKN4EScZaeB0iMIXAPqTKdUHKhuX9KPfpuV9tFOha68FaxtpoBy
	 d/irehS2JteBtYkQ9vL9X6F1Dh7WkbiRfme2uamomB7aEX7Apjw+1d84iSfuf6UZ6N
	 rZRN++PtBVc9IsVs/58330ExQxIXxiHedeqBalytsKK1yprGpyPdIjX/mODeGP8O0M
	 zr9h+Xjd4B4NcNL3nT5ZOBIyf1nxdS7c3fQ2x+xtzfcZrDwQP+ULQkDA5nafuBFEtk
	 +oSxSpxe+eDiw==
Date: Mon, 1 Sep 2025 17:49:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: <marius.cristea@microchip.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: Fix a null pointer dereference in
 pac1934_acpi_parse_channel_config
Message-ID: <20250901174919.4e2c7873@jic23-huawei>
In-Reply-To: <20250901064512.1554-1-hanchunchao@inspur.com>
References: <20250901064512.1554-1-hanchunchao@inspur.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 14:45:11 +0800
Charles Han <hanchunchao@inspur.com> wrote:

> Add check for the return value of devm_kmemdup()
> to prevent potential null pointer dereference.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
Good catch, but not that simple. This just leaked an ACPI resource that was
held over the loop this is in. See the ACPI_FREE() that follows it.

Jonathan

> ---
>  drivers/iio/adc/pac1934.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 2e442e46f679..95c9d14b5529 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1108,6 +1108,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
>  				     (size_t)rez->package.elements[i].string.length + 1,
>  				     GFP_KERNEL);
> +		if (!info->labels[idx])
> +			return -ENOMEM;
> +
>  		info->labels[idx][rez->package.elements[i].string.length] = '\0';
>  		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
>  		info->active_channels[idx] = (info->shunts[idx] != 0);


