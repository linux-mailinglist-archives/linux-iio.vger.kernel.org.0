Return-Path: <linux-iio+bounces-7382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059579292C4
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 13:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD9B1F21F74
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE966A33F;
	Sat,  6 Jul 2024 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA5e931l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C3482F6;
	Sat,  6 Jul 2024 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264851; cv=none; b=ZZe2P7rogfOW15CTd7MBN3uzgixmJfPQwjqx4+2Oz9e1tT545ISkQY4nblewJXAWsqDz7PVwk0Nnwpb7cQ9Q3hLx5r5jJfT6ZYk3HJ5x4roqA3TNtDNXsC+MUfJmZtXHm6umniq+LYr0HTSlUbUtGpCUBwV3RQqLjqPHpL7Us/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264851; c=relaxed/simple;
	bh=SDaxQ+DRRByo16W7YPXQBb8ituqmx4xzmP2nHHrpL38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5iYZDpKv/ou4pDHwivvcMk1MHASjnrQfLBkNfGmzxOiCqChSDLKv7JBUc8OpWjOTLS/C2muqdz4TbQBY84DhuzRhFkmNVw7GoIcjY8q/CQ8khMLEMvwMsI+tdn6lC/Fm0Sa2kirgLLWNFARo2rqMgy0vczE4EUoCGiGfbxWvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA5e931l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E94C2BD10;
	Sat,  6 Jul 2024 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720264851;
	bh=SDaxQ+DRRByo16W7YPXQBb8ituqmx4xzmP2nHHrpL38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mA5e931lxiIXoULYKv3c7hJHcLJOgkrnrk3CXPNOPXBK3D7BKF/5FBouRXoc2/1sN
	 2SbOUZli7ZpvXuOp4Yy4xeu6QM/JaAGznJdwK4PrXaVvuV5o+MezDthsbJ0NYTr3G5
	 h/RtXTzB/2wTSf0t7K40viGwLZ1sazGimoQ/y72U5SuKl3K/zq2Aku1kxgctHbiGKj
	 25EUs6Zwqkn9annWouEOGboBec35zO3nOsIOcIksOz9uFojqjjvxSJtxbKrtdf4VCG
	 tZ2cWNKZ1/a1bh27Jd9IWuuh4WuzGnDlVQAsIRj8zU8EiApvSx1yut9R/HmYif9v9F
	 wFmf7QVsJWWrg==
Date: Sat, 6 Jul 2024 12:20:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH 3/5] iio: adc: ad9467: don't allow reading vref if not
 available
Message-ID: <20240706122045.54344d21@jic23-huawei>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-3-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
	<20240704-dev-iio-ad9467-new-devs-v1-3-f1adfee921f7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 11:25:23 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> If there's only one possible scale, there's no way to change the Vref
> select in the device so avoid reading the register in ad9467_get_scale().
> In this case, it makes no sense to provide the .read_available()
> callback nor allowing for writing the scale attribute.
> 
> Note this is in preparation for supporting a new device that only has
> one possible scale.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Trivial comment inline. If nothing else comes up I might just tweak it
whilst applying.
>  
>  static const struct ad9467_chip_info ad9467_chip_tbl = {
> @@ -301,9 +301,13 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
>  static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
>  {
>  	const struct ad9467_chip_info *info = st->info;
> -	unsigned int i, vref_val;
> +	unsigned int i = 0, vref_val;
This time it's in new code.
	unsigned int vref_val;
	unsigned int i = 0;

preferred so the assignment isn't burried.

>  	int ret;
>  


