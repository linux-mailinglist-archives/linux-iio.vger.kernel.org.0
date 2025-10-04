Return-Path: <linux-iio+bounces-24703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85DBB8D81
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C5584E38F3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1062273D73;
	Sat,  4 Oct 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V//TcRFZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D43207;
	Sat,  4 Oct 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583298; cv=none; b=tGmupe+DkjYsi3oPmohChpAcsI8CzlP4CNycQ43QLCGMn2fuw5daoIH89h/ILIWOYQ1SCoh3xOC+ltEoowGtZYFBpJbq3f4v0V5VvRG9RMti8YIT09fLCx3quxTN69ikpD7VdUuFdl8ba/wF9+xA07M5Kwly6p3q4jmS3Ab5Xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583298; c=relaxed/simple;
	bh=3dMS+eey+l4mLhJxlKbz+rLVRtDX+GqAqbSYUpwI5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEzuyKBvTHuW8WRrvwul6fjzVI2/W7We9cFolOG/7amPnlCLvU6IXnj1UYqF4kk0iDXvAZMk63RpYn2m7Ns/QE5RJd8w7dvNtmoHCUc8i4KbcAlWjOD7U1L7RwGbwXtPQY2a46MIHk7tY/rOxvXb0LWUZmoCqBCOeTygt7SF42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V//TcRFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE36C4CEF1;
	Sat,  4 Oct 2025 13:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759583298;
	bh=3dMS+eey+l4mLhJxlKbz+rLVRtDX+GqAqbSYUpwI5KI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V//TcRFZ4gDSHVHESlteTULowzv+1c3Ktfi2Ip7UB5AvVLNBsiRjdcZEcNnB+Kh8c
	 ihGz1216p0eoiwNb+RmU0RUTNe0qIvhW8yMebg6Exxw/FyTPLl28UjRad/wMzR7faz
	 63HM+HZjSwnJwoTripLY9qOvTZYk7fej15FQl4VJGLCGh2XTr1nXuxTMHFLwYAH6Cp
	 dkHkUfMlRtZCKUXrC1aeDn/pz6LV/3kiykhMxw045WOBw2JkHa9ChMY3k1EUCmCYlO
	 LEcpRP9tc586w1pRnmwUb75aG6sLoyEsx3uYTro3qwTEmd62pJC2XruRI5F/nG78qM
	 7fqPENCqgecTw==
Date: Sat, 4 Oct 2025 14:08:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iio: accel: bma400: Use index-based register
 addressing and lookup
Message-ID: <20251004140809.5a629545@jic23-huawei>
In-Reply-To: <20251002184120.495193-4-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
	<20251002184120.495193-4-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Oct 2025 00:11:04 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Introduce formula-based macros to compute GEN INTR configuration register
> addresses from the interrupt number and register index. This reduces the
> need for 22 explicit register macros to three base definitions.
> 
> Add a centralized lookup table keyed by IIO event direction and replace
> get_gen_config_reg() with a helper integrated with this table.
> 
> Apply these changes across the affected callbacks to ensure consistent
> access to generic interrupt registers.
> 
> No functional changes are intended.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      |  17 +++--
>  drivers/iio/accel/bma400_core.c | 131 +++++++++++++++++++-------------
>  2 files changed, 88 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 13fe2e5a3175..48fcaeeb553d 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -91,6 +91,11 @@
>  #define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
>  #define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
>  
> +enum bma400_generic_intr {
> +	BMA400_GEN1_INTR = 1,
> +	BMA400_GEN2_INTR,
Given the values matter, specify them both.

> +};


