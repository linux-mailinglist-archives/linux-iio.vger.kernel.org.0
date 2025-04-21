Return-Path: <linux-iio+bounces-18435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4083A9515E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26964167066
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBE265614;
	Mon, 21 Apr 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjTaStAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68F264A9E
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240930; cv=none; b=jraTO3zu+PpMWBcBPeT7+Ey5u+DFVRLvsKthH1gbaPOuGS3kNFoB2I4iQUfbvKeZGuSTD2nXLZ5Nl/4YTX4as7nDTeA+F2rU7A7Ic3g1LhVp4V4aqmYhSYLZcZNbTNobPR87VaQXGEuoZu8o9nQrkWib6L4/yrX00O/9WcE42A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240930; c=relaxed/simple;
	bh=NNApjszw4RJiAnGWC1vZdO+OVrTvQOIdZdI8k6alXSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chCHReKpn+koo58TA/XgpBgL3h3kc36JUJGAYJBVAg8nGQXMuAsZ/2NuHDSPtriBS0zrtqP55bayOGnkl/4888dWWu+4gElB3FAObf0JHRq/QYXjEvEm9ofaMr5efGSV9RScTpYCDuEYUD38rOU7xpqOBE2/9xGrEyyGo0ZJIb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjTaStAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437BC4CEE4;
	Mon, 21 Apr 2025 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745240929;
	bh=NNApjszw4RJiAnGWC1vZdO+OVrTvQOIdZdI8k6alXSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjTaStAeaRwrAVko1Ofbgd4IxUB5O/9N2F1HjE79EI9dvB0QQlrXqgCUQdgtJrPH3
	 ERfAGaRbrRMDYPYKTr5t1t54BqjkEa786kI46v9UL6OOoxkSJz9SAB9oi88toQEIjV
	 +v9kW/krvNCTEsfU6nHfqZ6zBz4XpFj9JdNBwmQeQx3JHoyifVAgyUVxgC9WIcP7zT
	 DAigzh47DBZZAhPag5NSThN4pVhvBHa70lfM7yv2yLPRuY5A9LqAHuLQmAcfKUlaXt
	 /w5Kbw7GZNuV9QeiI0vFrScWsbSQMJrFfk2J7pRYipBJ163BabYQRYePKRKhs0k63l
	 tUWz03OjsCCMQ==
Date: Mon, 21 Apr 2025 14:08:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Pilone <art.pilone@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
 bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v2] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
Message-ID: <20250421140842.08e4d26b@jic23-huawei>
In-Reply-To: <20250420222512.173029-1-arthurpilone@usp.br>
References: <20250420222512.173029-1-arthurpilone@usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 19:25:12 -0300
Arthur Pilone <art.pilone@gmail.com> wrote:

> From: Arthur Pilone <art.pilone@gmail.com>
> 
> Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
> same test, checking whether a given 'reg' code is
> AD7091R_REG_RESULT or AD7091R_REG_ALERT. While ad7091r_volatile_reg
> returned true, ad7091r_writeable_reg returned false for the same
> condition. As such, both functions introduced duplicate code.
> 
> We chose to implement the test as the AD7091R_IS_READ_ONLY_REG
> macro to remove the duplicate code without introducing new
> function calls, which would be the case if we chose to fix the
> duplicate code with one of the two following alternatives:
> 
>  A) Extracting a new function out of the test
> 
>  B) Rewriting ad7091r_writeable_reg to call
>     ad7091r_volatile_reg or vice-versa.
> 
> Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
> Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
> Co-developed-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Andre de Lima <aschwarz@usp.br>
> Signed-off-by: Arthur Pilone <art.pilone@gmail.com>

I'm late to the game but to me, simpler to not have a macro but avoid
duplication by having one function call the other. Also a more
minimal comment can convey the point you want to make.

> ---
> V1->V2: Renamed macro and added clarifying comment
> 
>  drivers/iio/adc/ad7091r-base.c | 20 ++++++--------------
>  drivers/iio/adc/ad7091r-base.h |  2 ++
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 931ff71b2888..e07614b70d12 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -375,25 +375,17 @@ EXPORT_SYMBOL_NS_GPL(ad7091r_probe, "IIO_AD7091R");
>  
>  bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
>  {
> -	switch (reg) {
> -	case AD7091R_REG_RESULT:
> -	case AD7091R_REG_ALERT:
> -		return false;
> -	default:
> -		return true;
> -	}
> +	return !AD7091R_IS_READ_ONLY_REG(reg);
>  }

I'd keep this function as is...

>  EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
>  
>  bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -	switch (reg) {
> -	case AD7091R_REG_RESULT:
> -	case AD7091R_REG_ALERT:
> -		return true;
> -	default:
> -		return false;
> -	}
> +	/*
> +	 * The volatile ad7091r registers happen to be precisely the
> +	 * two read-only registers.
> +	 */
> +	return AD7091R_IS_READ_ONLY_REG(reg);

	 /* The volatile ad7091r registers are also the only RO ones. */
	return !ad7981r_writeable_reg(dev, reg);

>  }
>  EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, "IIO_AD7091R");
>  
> diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> index 092ddea0f395..498923801ce1 100644
> --- a/drivers/iio/adc/ad7091r-base.h
> +++ b/drivers/iio/adc/ad7091r-base.h
> @@ -17,6 +17,8 @@
>  #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
>  #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
>  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> +#define AD7091R_IS_READ_ONLY_REG(reg)                              \
> +		((reg) == AD7091R_REG_RESULT || (reg) == AD7091R_REG_ALERT)
>  
>  /* AD7091R_REG_RESULT */
>  #define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)


