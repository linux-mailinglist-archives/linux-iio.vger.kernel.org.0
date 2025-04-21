Return-Path: <linux-iio+bounces-18420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71586A9505C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEDC7A528A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF6264613;
	Mon, 21 Apr 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bsc3jUwP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFE262D29;
	Mon, 21 Apr 2025 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235850; cv=none; b=V/JlvTB5DXEe3RWY16/M9f98fEut9+fIq09CM5xezh0PVbaYi+txdrhiSDv2gfJ3vyu+pyxI4GwdbcQdLlzn6AAkxfj6jHsWYNOi/85ILInkzyj+3uWcF2GiotqDXXG1vpESLX5oDSdKaiecAty1nxfQZpQ5TfpYGP7LDNcdxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235850; c=relaxed/simple;
	bh=KFt7KVz7z+ivKXjqeTBsn4Dyd+33+BcExIfbhTDS1iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX8/5QLaroeS5oMLsMekoDI6uxuio3O84aWMvYIXhK+qkvhY3jWp8g5bmTEAe/1eS5JFvY6r4nPFp5qU9N8YJG5/Fu/SAlVbefKrvuKlMA6vmm1CapH3AOBUWlwaYRb3qF0tdo8+vVkoe+3X/dIXEOY4+r8ZMfrppkY2VJKs8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bsc3jUwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B9C4CEE4;
	Mon, 21 Apr 2025 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745235849;
	bh=KFt7KVz7z+ivKXjqeTBsn4Dyd+33+BcExIfbhTDS1iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bsc3jUwPwu0cl688/IsxDAm3p5IvXzLuH34bn5XkG3BqIVWMHJ8Orv0GhYh7UYRRp
	 Fm1tuVJKv71Q2cOCrqERDUptmbc6eSTLlrbBrf8H4Br7ldYCivPhj3v2Ivyr3xpbRJ
	 9uAVJkgUQPp29ftVxqVbgKwhrOHAyCn0RQU3yph8/qZNs0gvP9UX40Qek11VuWp3lt
	 utoIZykp8yz36KaTmXPm9HJsIM4WsIE/qlqmpKtD9lEoY0AFp+hNZPEhbXhH2eytct
	 yi8DP6MBGl83NWLD0IREMdVRoKfypDu56MdJT3pu/JA9Y//zsBqU6D/FSXk8euc82P
	 IkP08kQExrTCA==
Date: Mon, 21 Apr 2025 12:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: ad5933: Correct settling cycles
 encoding per datasheet
Message-ID: <20250421124401.0daa6a2e@jic23-huawei>
In-Reply-To: <20250420013009.847851-1-gshahrouzi@gmail.com>
References: <20250420013009.847851-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:30:09 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> The AD5933 datasheet (Table 13) lists the maximum cycles to be 0x7FC
> (2044).
> 
> Clamp the user input to the maximum effective value of 0x7FC cycles.
> 
> Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
I'm taking this the slow path as it has been wrong a very long time
and there is a lot of churn on IIO staging drivers right now so we may
have other stuff that I don't want to delay building on top of this.

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan

> ---
> Changes in v4:
> 	- Provide clear git body description.
> Changes in v3:
> 	- Only include fix (remove refactoring which will be its own
> 	  separate patch).
> Changes in v2:
>         - Fix spacing in comment around '+'.
>         - Define mask and values for settling cycle multipliers.
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index d5544fc2fe989..f8fcc10ea8150 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -411,7 +411,7 @@ static ssize_t ad5933_store(struct device *dev,
>  		ret = ad5933_cmd(st, 0);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		val = clamp(val, (u16)0, (u16)0x7FF);
> +		val = clamp(val, (u16)0, (u16)0x7FC);
>  		st->settling_cycles = val;
>  
>  		/* 2x, 4x handling, see datasheet */


