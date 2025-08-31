Return-Path: <linux-iio+bounces-23539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC81B3D424
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8A0189B725
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E1218580;
	Sun, 31 Aug 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaB1pGQW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF58E573;
	Sun, 31 Aug 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654076; cv=none; b=hk7QdEcMBWLYwdAX/2LATQDZ8+KAT8fQHhFcrXAcs3wJ043v9cwhOFtZRNdgq6rOx6bSYbCeOIQIzyNqHboAnsB6QfUpTuZ77mSK3Qm8lnHnzeMfPyZTcisfFURvzU5UZNAQAWx45GvAyhlnnLCW0X0qRhmrT59boj45aOVlvYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654076; c=relaxed/simple;
	bh=4OxaAuAibfUu/G+Qnft9vw0SHoJ9N0nFwteRb1o0RmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAP2QyWlTzFYwAS82mNhL+26ROzGWIFBkoBsQa5EslWH2C6geEUgLwg+zLKLVqIivBN3kXjLVmMJVMSnJftPyzcUoOVpcO8OsAA8w6FJfeCUQgh/5LabCQ6bul8hW/DmGcsoNvAQRsUr7+pFbVsGjzeNafwLZS1TSBMocRyn0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaB1pGQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50821C4CEED;
	Sun, 31 Aug 2025 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756654076;
	bh=4OxaAuAibfUu/G+Qnft9vw0SHoJ9N0nFwteRb1o0RmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DaB1pGQWkhnhkZ5Ta0x3o/69Gi+36sd8AgQEInXqnfaqxXKwlKTmxEIGgzl8kxaKO
	 T6PDF8GQQZtxVR+tIN+zMMyVqJgxauXqVKylv5+M3iY0d7eM+xKd2kENANxdR6Ng7F
	 L1BwYEdckMxHG+LTsLQ15F5OAj++8UB5PrIzlARrzEfOyz3kc2VW70mrIoGmoltv5P
	 DUgSFfw7GeEjGEUyGtoYveojslJFaSZUlw/cQNRayMHsOMrG7LBcJl4OftbSUPmzf5
	 sR5SxTk3HzcqHSV4nWtGRfLNr7Yn40RrwTJ4LTRfFBgfhHR7pkA5pz1uv5un0uthso
	 ayTx5mMKXktWg==
Date: Sun, 31 Aug 2025 16:27:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: use int instead of u32 to store error codes
Message-ID: <20250831162746.7dab74c2@jic23-huawei>
In-Reply-To: <20250826101825.248167-1-rongqianfeng@vivo.com>
References: <20250826101825.248167-1-rongqianfeng@vivo.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 18:18:25 +0800
Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> Use int instead of unsigned int for 'ret' variable to store negative error
> codes returned by ad5421_write_unlocked() and ad5360_write_unlocked().
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
This is a fix, so needs a fixes tag.

Given the two drivers were introduced in separate patches
I would suggest splitting this into two different patches so
we can call out how far to backport each one (via the appropriate
fixes tags!)

> ---
>  drivers/iio/dac/ad5360.c | 2 +-
>  drivers/iio/dac/ad5421.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index a57b0a093112..8271849b1c83 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -262,7 +262,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	unsigned int clr)
>  {
>  	struct ad5360_state *st = iio_priv(indio_dev);
> -	unsigned int ret;
> +	int ret;
>  
>  	mutex_lock(&st->lock);
>  
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 1462ee640b16..d9d7031c4432 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -186,7 +186,7 @@ static int ad5421_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	unsigned int clr)
>  {
>  	struct ad5421_state *st = iio_priv(indio_dev);
> -	unsigned int ret;
> +	int ret;
>  
>  	mutex_lock(&st->lock);
>  


