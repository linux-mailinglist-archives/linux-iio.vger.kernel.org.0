Return-Path: <linux-iio+bounces-16881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49959A631F1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA0F3B936C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32496195FEC;
	Sat, 15 Mar 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg5fIfn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B04189916;
	Sat, 15 Mar 2025 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064780; cv=none; b=Or148BcmvsfXlFA8caqQv+qFNU9Nv3wk3NnNZR1l3q/6XWtBGsqoeXOSQdcqyf0wuhjnnKOMJwhBSlMVMVwUD3jdUYH3ryhIw1Ie7XD4MhnZ80gWmiQy0ZZJdP09R6vNVekbwAGuU3Pqb1E9WA36ERt8We6U8Ryz1GGyKBu5HS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064780; c=relaxed/simple;
	bh=+xH18GuVnLRJ4VD3Xww6nWNy7yq1eF6vOo1Yux6Whlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIB8sfiaVlzVTDtJBzi60WsGhuoJRpt3cPX6tb5yKPEJxm2u+B77qYnIJOKFQvukvGCNIevjSdCC/ZgoJK4DCTIKoeYjrqQHKcHHFC2DLF4lRHh354JQpsZA2loMPVK7OvvewDyZGV+M4WtjD/3oTRnOtwjvWpAj2XZzg5c3zNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg5fIfn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09BDC4CEE5;
	Sat, 15 Mar 2025 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064779;
	bh=+xH18GuVnLRJ4VD3Xww6nWNy7yq1eF6vOo1Yux6Whlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dg5fIfn+YAmpgfg4aJmCW1bkuPq8AiP7V9HmH69sCKhFbKSCO8wsTkiui9s6L/QzM
	 BsUz+HPTmTvmLzPwZjp1U3DkgxllF6FLs01EXRb2hfl2GME4njgVvSR8ljQrHdGMQE
	 p5JiMOiK8WdVS1dKoMigywPcsr8CJLSbf6+EpIW/jKWnneHxe92brqqFhJbA97rz73
	 J7X2KxuWW/dCzmAVTll7SfBnTajpFHsjqDJjOhB1yptQOvXs21xuu0sL/JRzFe+9YG
	 NvKh1jDPfGbrnMmPR1idDse3LksON20GEUAvJPuXh1CnPtY/8M3ZK5E2IQp2uBJyXn
	 qxcYFupcedP9w==
Date: Sat, 15 Mar 2025 18:52:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] iio: adc: ad7606: use devm_mutex_init()
Message-ID: <20250315185251.63fe37e8@jic23-huawei>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-5-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
	<20250312-iio-adc-ad7606-improvements-v1-5-d1ec04847aea@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 20:15:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use devm_mutex_init() in ad7606_probe(). Mutexes should be cleaned up
> on driver removal.
> 
> Also add missing include while we are touching this.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Just for the record (in case anyone other than us two is watching ;)
I'm not keen to have large numbers of patches doing this at this
point as the benefit in debug ability this brings is pretty tiny.

I'm absolutely fine with it in a series making other cleanup
type changes to a driver though - so fine here!

Note I will probably pick up the fixes soon after rc1 given
some look pretty important. That means stuff like this may have
to wait a while for the fixes to circulate around to the char-misc-next branch.

Jonathan

> ---
>  drivers/iio/adc/ad7606.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 440e1e5a9b18570dc6441bff91afbc51d20cbc47..f190269ac8ddd859e94eb24c26f5f010d0951646 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
> @@ -1332,8 +1333,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
>  	st->dev = dev;
> -	mutex_init(&st->lock);
>  	st->bops = bops;
>  	st->base_address = base_address;
>  	st->oversampling = 1;
> 


