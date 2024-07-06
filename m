Return-Path: <linux-iio+bounces-7376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320759292A4
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13C7282D39
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAF524D6;
	Sat,  6 Jul 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpmb7dnN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE53FB96;
	Sat,  6 Jul 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263158; cv=none; b=f6EoYLUqSk2Ogl1V02wyzhK1sCDIK93jjQ2EZraW3nRcuQathw5eqCxU0e4TgrisSlklczZgfqyQ4CjnbtFvDIJu3bWQCeoouzx1cXE+XW/0oYY3uBFSiozmphkSzJTj+HjjWos6Cgt6Vl5zczDv26S0/87g0jCrmX1XFWFPdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263158; c=relaxed/simple;
	bh=efIB17EZMlXMPPwEmi+fVqnF5tydmg78Dy0ZZdC6FRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fs+xslvqtKXyf1EbaPB5uiZb5xhTHedPnVAnZC6x0JjfOAaj8QSNFl8tj8myRvRSe9UdQMWC2CP+wDK0c4iezqVz5LWab1D9qyBUBxCaDfYJHgwPL/BaY2B33KwhIAy3kkMVFKiEkxbpwagfU8O2iNOYMhJhw9bIHc45Ioc/T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpmb7dnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0194C2BD10;
	Sat,  6 Jul 2024 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720263158;
	bh=efIB17EZMlXMPPwEmi+fVqnF5tydmg78Dy0ZZdC6FRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpmb7dnNDG0IOB+Ry63fTHcdB9r9VE0uVvVgccZXfJjQ9fu5fx/2xTAMO5LDsVa5c
	 Nx37Xp0PDbkazb7hzPZLKWVf/FYBbHYzbaIJcSe84l2jBLudA6+Lp9rOKZR1TSTsFL
	 oF9B4yNO/x0hpgFodxcHhJepSRG3en9gCZ+wPcVjIGOP5bHi6fPf4oZLMno9AchxZq
	 s6BaST1EeN1ko7gyPzZtaKRKUn4CNfPnOX2Ex0G8iklvOp+V4czRlckEkwySaNroSk
	 RNMHKeuP84pS3waujmzxn3wy0KEr1ShwE75D7Tvq2FUoB5N2Os+Wdid4moQiv/SBry
	 b7OAIz1WD4p0g==
Date: Sat, 6 Jul 2024 11:52:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dan Robertson <dan@dlrobertson.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 6/6] iio: adc: ad5755: drop redundant devm_kfree()
Message-ID: <20240706115229.47b8d7fa@jic23-huawei>
In-Reply-To: <20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
	<20240705-cleanup-h-iio-v1-6-77114c7e84c5@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 12:40:49 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver calls ad5755_parse_fw() only from probe() function, so
> devm_kfree() during error path is not necessary and only makes code
> weirder.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The path this is in doesn't result in the driver failing to probe as it
falls back to a const default structure.
So whilst it's not a 'bug' to remove this free, we are removing data the driver
is not going to use - so to my eye at least this is a deliberate design
decision.

Mind you it's not a particularly big allocation so maybe worth not cleaning
up until driver remove in order to save on complexity.

Sean, your code I think.  Do you care either way?

Jonathan


> ---
>  drivers/iio/dac/ad5755.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 0b24cb19ac9d..bfbfc3c1b6a5 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -803,7 +803,6 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
>  
>   error_out:
>  	fwnode_handle_put(pp);
> -	devm_kfree(dev, pdata);
>  	return NULL;
>  }
>  
> 


