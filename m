Return-Path: <linux-iio+bounces-26893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9939CAB6D0
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E10663000B7E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FE2EA480;
	Sun,  7 Dec 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skpoi02C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9774BE1;
	Sun,  7 Dec 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765122176; cv=none; b=ZzzYG7Gk78Q99xvoXo8EqDNW30oDhoCk0diajmW+wJC5OPaJNkt6BN6xOyqv+oevXtRiMxjH+lJUkUfhHW0l8ImoVLXGUCNUj4E5kBJ/nLhaVQhTWUMKeOXqONGAfIhsLfGrE8gldgBxPSPbfSH3E8SIsU9mB/9f5Z5A5yuGvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765122176; c=relaxed/simple;
	bh=BKNEhlK+Owm1f1VjUVOQYVdoocJ9ZdJERvqyj+4uucg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2X47mcMuP+0Iu6QdMvBg3grnghXTVstRzKgPRPBgHsaLDRJCWNfzyjD1krIQwD8ueaPc57V9mHmxomUOGI9ksMz1B7/06reL0sCQORW3y19P35isuZdDyON8BawvOvuN7YqU2H8ng0AMFmUWDrf9L/gLPg0wF8JCp7uvrm8zL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skpoi02C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF30C4CEFB;
	Sun,  7 Dec 2025 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765122175;
	bh=BKNEhlK+Owm1f1VjUVOQYVdoocJ9ZdJERvqyj+4uucg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skpoi02CgyQWFQ9Gs6L2TTSUgcF3Jh4fqlLgqD1ddCautyc7J3afHNd29OzLa8cvb
	 e8x48I47huapEiwSxBuR1SdtX/sgbkhwgyaMXjc1sNAUjdNKE5TzOgnTlwEpSXTLmB
	 YijM8McE1dYdxO/ZyLrXcTjjeCVk7+QMZNMSf9Rq61C6E/tdWraxDHkPguKGd3IfUG
	 toLwl3cnpDkFJtoFAsNwu7WlEqNSPQ4/lUCFk2oTlFKH2aNU4eHW2hl753DQ47XsmI
	 IlpP5B4ejC1td3OZ437u5BEven+QEr2PMrBSwuJOVd7KHMGawzRJlw4IqoyCC8tSg/
	 tmCE4CIa7MnTA==
Date: Sun, 7 Dec 2025 15:42:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl380: fix handling of unavailable
 "INT1" interrupt
Message-ID: <20251207154247.399f49dc@jic23-huawei>
In-Reply-To: <20251128172138.257961-1-flavra@baylibre.com>
References: <20251128172138.257961-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 18:21:38 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> fwnode_irq_get_byname() returns a negative value on failure; if a negative
> value is returned, use it as `err` argument for dev_err_probe().
> While at it, add a missing trailing newline to the dev_err_probe() error
> message.
> 
> Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
Ouch.

Applied to the fixes-togreg branch of iio.git.  That one won't go out until
I can rebase on rc1 after next weekend.

Thanks,

Jonathan

> ---
> Changes from v2 [2]:
> - added missing trailing newline to the dev_err_probe() error message
>   (Andy)
> - added Andy's Reviewed-by tag
> Changes from v1 [1]:
> - added fix to `err` argument passed to dev_err_probe() (Andy)
> 
> [1] https://lore.kernel.org/linux-iio/20251126144624.24512-1-flavra@baylibre.com/T/
> [2] https://lore.kernel.org/linux-iio/20251128140726.243005-1-flavra@baylibre.com/T/
> 
>  drivers/iio/accel/adxl380.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index 0cf3c6815829..6d82873357cb 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -1728,9 +1728,9 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
>  		st->int_map[1] = ADXL380_INT0_MAP1_REG;
>  	} else {
>  		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> -		if (st->irq > 0)
> -			return dev_err_probe(st->dev, -ENODEV,
> -					     "no interrupt name specified");
> +		if (st->irq < 0)
> +			return dev_err_probe(st->dev, st->irq,
> +					     "no interrupt name specified\n");
>  		st->int_map[0] = ADXL380_INT1_MAP0_REG;
>  		st->int_map[1] = ADXL380_INT1_MAP1_REG;
>  	}


