Return-Path: <linux-iio+bounces-7378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD69292AB
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED1C20F5C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22216BFA6;
	Sat,  6 Jul 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8gldELT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB77524D6;
	Sat,  6 Jul 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263348; cv=none; b=bR0xGSq7zZr4sywivRljmE/8js0NJ30C4yX40IJT7hLREd/dAtLjzKmiS1DdMT8vz9T+70k1H/WpVO/Nh7umSBmMlo1fMtJCQ+VuKvJKtSUwgzviB/GuLq1DLE0ZjHDyl28FD3JOR8EYA4iMtfymOR4IR/Y3rvFvURRCCf072/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263348; c=relaxed/simple;
	bh=idoUi8lkJwbaUT4zm5Y4BMqTc7tuX+nE2lNVnAuRfXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJXbi9CaQEzDr3qNTZjgOew3xj5BrN0RzPQLbC5sKUZEBd8F84d5u/CrU4Cpk5yNIhmnoJj6TVltJK7RRauy7Yk/8q0NzX7ELVhcdKHD92EXi6Dn9c+xjHVO1u2UWW2ZCbiYB6TSBtLgd5SlcITwhcekkbsJEN6ziNnoit+1npo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8gldELT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E7C2BD10;
	Sat,  6 Jul 2024 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720263348;
	bh=idoUi8lkJwbaUT4zm5Y4BMqTc7tuX+nE2lNVnAuRfXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G8gldELT4REe8o8c2hAY7hI2BzJPf7179H3ikYOPF+G+R4GCSbfSDHlgwK891dQ3E
	 s3Q3C7nV60MTEVdjrcyiv2zggvR7Ku75hgC258Cy35KRrCb31roCGFtG+PI7DxX52U
	 aDDapYx6asVtGY2S5oQrGR8NjHO/6DZteKl6JmcpD/Gg3wJ+/wBsrT8sprxi8F/IfY
	 d8iX6g2+WlFyW4bk3nQ2YGT+hrbE1ry6EUrpqywzB8wk5H00IvPbU2p0aykysC2te3
	 BAZiHUw3vSke4ja5RLFL8Ktj5LV3NBuLaJVaUGDn3g6WtgOyHbatcXmDvH+s7oOW5S
	 11evVYePEY9gg==
Date: Sat, 6 Jul 2024 11:55:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dan Robertson <dan@dlrobertson.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] iio: adc: simplify with cleanup.h
Message-ID: <20240706115538.33341034@jic23-huawei>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 12:40:43 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
For now I've applied 1-5 as I think 6 needs a little more discussion.

Note applied only to the testing branch of iio.git for now.
That will become the togreg branch and get picked up by linux-next etc
after I've rebased on 6.11-rc1.

Jonathan

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (6):
>       iio: accel: bma400: simplify with cleanup.h
>       iio: adc: ad7280a: simplify with cleanup.h
>       iio: adc: at91: simplify with cleanup.h
>       iio: adc: max1363: simplify with cleanup.h
>       iio: adc: ti-tsc2046: simplify with cleanup.h
>       iio: adc: ad5755: drop redundant devm_kfree()
> 
>  drivers/iio/accel/bma400_core.c | 11 +++++------
>  drivers/iio/adc/ad7280a.c       | 10 ++++------
>  drivers/iio/adc/at91_adc.c      | 13 +++++--------
>  drivers/iio/adc/max1363.c       | 34 +++++++++++++---------------------
>  drivers/iio/adc/ti-tsc2046.c    | 29 ++++++++++++-----------------
>  drivers/iio/dac/ad5755.c        |  1 -
>  6 files changed, 39 insertions(+), 59 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240705-cleanup-h-iio-c90ca38865a4
> 
> Best regards,


