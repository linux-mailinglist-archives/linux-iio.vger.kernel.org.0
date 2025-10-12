Return-Path: <linux-iio+bounces-24959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10679BD040C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7CA7347F97
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6A28C864;
	Sun, 12 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo4dNGGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF98289E17;
	Sun, 12 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279700; cv=none; b=DsM1DpEUfIv2e2m6ujLMvrUABfP//tca9uY6/Y/GT7db7Ytl4Hbn8OwMTdDE/gILmDjSdqzqvIIdZHwwWLXP/vl7/wIe0fqlBvPFMITUepi0S8gzbfX1EowXUCg1c1eV5wUVKpXXQjJq71yoozQoBkNtT2wnKdNiNXVuiwU9HdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279700; c=relaxed/simple;
	bh=l6cJBzlu9I/0I58UBpVR1NGyNtzR+Z7Gf2+2io9LKQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwDUbXyYc7yt/AUgbt+5tq4EcN4BeSDzsFXoNlG5lVlnQ/o3E84UtG3oSAJG6Rnb9Zc8VrwqgpX2hDPRH2UM3GvICRvJtKwfSejjImp3k5i+wCiNZWzUi5oLb1U6TmwIxxdhsps/z2V3bVUq7v2oLAVknwW1tZOQOoVSqTjMWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo4dNGGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0405C4CEFE;
	Sun, 12 Oct 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760279700;
	bh=l6cJBzlu9I/0I58UBpVR1NGyNtzR+Z7Gf2+2io9LKQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qo4dNGGT/5amHAH3fINTUqtfSCUQgPPX5Xy7Lfakc2HREWXHa51OIMpKlAFC5IiPs
	 SU4WauDdDVAxPX74NE8nmSLnXDzMyyN86vlvfU1qHvOEYqCZacNxNKbkGrZD5NLVz8
	 bSUzFLXyxnUIlfRAh2YC9V+EZUaLyVPeI5sUbVoVYBvLUO+vmnChTaHiOvPAUs/TP9
	 HfLrIipZlQQsD7Y3ObO5bCpkJVgIpRjQ0imYlQoIFMXERCHn5LeJkYMl3nrm+vqwbp
	 V5yWaY7vmSsKuuxdMguCj4xdKdgQ0Sgjp0f4pKqOZKEpqzvrEaH6lHjhmbqK7EP9R+
	 KbZ4SssdT4keA==
Date: Sun, 12 Oct 2025 15:34:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/19] iio: accel: bma220: cleanup includes
Message-ID: <20251012153452.15451c13@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-6-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-6-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:15 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Tweak includes based on requirements.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
see next patch. I tweaked this as below
> ---
> v4 split from bigger patch (Andy)
> ---
>  drivers/iio/accel/bma220_spi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 45ac0d7ee27de65b204bd2766f26024e4ed57f4c..abff24a48e5aaa5efb05cdf1924ffea24f4da4c5 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -6,9 +6,10 @@
>   */
>  
>  #include <linux/bits.h>

#include <linux/errno.h>

which otherwise was added in next patch with no related code changes that I could spot.
It definitely should be here for EBUSY etc.

> -#include <linux/kernel.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
>  #include <linux/types.h>
>  #include <linux/spi/spi.h>
>  
> 


