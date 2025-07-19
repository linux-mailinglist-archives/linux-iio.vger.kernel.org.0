Return-Path: <linux-iio+bounces-21775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C96B0AFB2
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1F51C20628
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A99224227;
	Sat, 19 Jul 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uexWTw21"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26C72629;
	Sat, 19 Jul 2025 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927044; cv=none; b=YRibO0MRXL1jY7aLXKGQ4UBxLcDJXWLTUhlpie/nj2fA+BhDdRf0EIsYmlHqBTaYsze0ox6dyjL+4mXp/irV6zTGAZxlEOdZabpDC77QvVQiWrw9JCW1RrdGrflPoZDYKYKJahdo65G1vL1YiMHRbcNPLUONgd5K1x8W24r8j9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927044; c=relaxed/simple;
	bh=VMUOM21ZepW7cAEO8KjJ/sFW2pU+FeWUcisSB3jueEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu7NzcVVhWFImj6tulrKyfASRikM6aLiDChZjye5bQcAEJXVdLfeAE7gBjODdJNgTkCz1tgqudbkzPCd3JVyvel1MxqIuMmOZW+5Aq0AbUvNnOMpFXuaPkstubslus6CESdzxDkHb4jeeivmKIjKlPT24mACOPa8PN299Jlb/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uexWTw21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43655C4CEE3;
	Sat, 19 Jul 2025 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752927043;
	bh=VMUOM21ZepW7cAEO8KjJ/sFW2pU+FeWUcisSB3jueEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uexWTw21wXX6pAXiS/mD3x5wF0sNXGLqmKeOXlmAKg7+0CCTdR2FxhQkWpQj4KgrG
	 82YmIx5NFXsjRmq9zfXzh1JhxUW4pUqVO891SjI9n11/2KT60yfdJYc8D7gE9cZXLQ
	 k4PFI1jWHEGtBS1IBCkVuvZKnZv4GMkm3F+8vhErLt8Fixzjq+3aHmJqP6iuFGy6PY
	 vG0l4yqQxFiYaf91WE5NYgxXp+JB3i3xwgbf9mU9XcVPUzdulj2JRwI9VGtOZIKFIk
	 OqbyPWTu/toUcd1vDNDUew7napwO/1+qWTEMp4W6/rlM5ZaQWaiOa+40ohsitQiOAp
	 fk7V+gRIzOJ2A==
Date: Sat, 19 Jul 2025 13:10:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel
 and avg sample before setting register
Message-ID: <20250719131039.07a5fb24@jic23-huawei>
In-Reply-To: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 19:13:49 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.
> 
I read this as meaning this is a hardening change against bad DT rather
than a bug fix?

As such applied for next cycle to the testing branch of iio.git.

Thanks,

Jonathan

> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> About @David comment at v2:
> 
> > For bonus points, a separate patch that cleans up and sorts the existing
> > includes would be appreciated.  
> 
> I`ll change that in a later moment.
> Tks and regards.
> 
> Changelog:
> v3: moving up include; fix indentation;
> v2: https://lore.kernel.org/linux-iio/20250701213728.32064-1-rodrigo.gobbi.7@gmail.com/
> v1: https://lore.kernel.org/linux-iio/20250621185301.9536-1-rodrigo.gobbi.7@gmail.com/#t
> ---
>  drivers/iio/adc/spear_adc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index e3a865c79686..0acc65c74221 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -17,6 +17,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/completion.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -29,9 +30,9 @@
>  
>  /* Bit definitions for SPEAR_ADC_STATUS */
>  #define SPEAR_ADC_STATUS_START_CONVERSION	BIT(0)
> -#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
> +#define SPEAR_ADC_STATUS_CHANNEL_NUM_MASK	GENMASK(3, 1)
>  #define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)
> -#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
> +#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK	GENMASK(8, 5)
>  #define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)
>  
>  #define SPEAR_ADC_DATA_MASK		0x03ff
> @@ -157,8 +158,8 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&st->lock);
>  
> -		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
> -			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
> +		status = FIELD_PREP(SPEAR_ADC_STATUS_CHANNEL_NUM_MASK, chan->channel) |
> +			FIELD_PREP(SPEAR_ADC_STATUS_AVG_SAMPLE_MASK, st->avg_samples) |
>  			SPEAR_ADC_STATUS_START_CONVERSION |
>  			SPEAR_ADC_STATUS_ADC_ENABLE;
>  		if (st->vref_external == 0)


