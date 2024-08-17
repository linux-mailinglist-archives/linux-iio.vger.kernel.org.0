Return-Path: <linux-iio+bounces-8551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0583D955875
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB271F21B7C
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6611187;
	Sat, 17 Aug 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ils1jXV0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77F8BF0;
	Sat, 17 Aug 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906610; cv=none; b=f715LQZCnRZm/5vzBuUBtjbQfbzBMyzsYu7BN5rTqwxRhvP9JJBcfhycLYVwkVlkx/rC8jQ7GFkEWF5g+lBAegeFk+RoSVBIQ90X1D2ThHXw8m70MUoUi0Y5ElF05js/fsQ4HBmRqDdsTX54UofH7ksQPGr4WZv6FDjBojY4LQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906610; c=relaxed/simple;
	bh=6lpBBGZ5LxUkLHUjRn38uOj4Meny2I8tWa45tDNr44o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C33tth4te8la2UZmG6HcYx2ZGzFleH1hzFfHyhEBj3qgxkjdeLXETycNTfYNQs1wSogKoZn9M1KQMJW+QxGADDawZ8XZruWArZ73p1sOclo0Rcf/m8we5gIiUwiGvhPdg2ndciA+zDrM9esliKFpn2s9d/QH3s9stSNG2EtcJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ils1jXV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BADDC116B1;
	Sat, 17 Aug 2024 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723906609;
	bh=6lpBBGZ5LxUkLHUjRn38uOj4Meny2I8tWa45tDNr44o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ils1jXV0Tnw2XzGmUrdjQOOUE5p61e/aKEzaJErbVAYN3uxD9x4RbxM8SabMJV5cK
	 Ouf1Bu1qHYq0UEinjzWueHLisbVaqCB/lE8OzhYb3Zzft7aeKFScqY9xJq9/AdNCIA
	 8cLcH9FTFuzMzxNgQd/83Pweqr4vF9+/DSyEo/4qoQ1+eUvckkiJg/0F4EyibJuRZ5
	 M7FHlzUSnZy+4QTxQF8ajrPcDOG8NPrikrkjPicFyYlaWFgnsSQjGLFVvFZctqsAsy
	 IIyDD7wa8rxPuoBXMTzRXwIHBa+f09BpPpk8upZSnCLLufKE3mjoVWlxyW+2/unIaC
	 TLA8QOq1bQqIQ==
Date: Sat, 17 Aug 2024 15:56:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, lars@metafoo.de, gstols@baylibre.com,
 nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: adc: ad7606: move 'val' pointer to
 ad7606_scan_direct()
Message-ID: <20240817155642.6ad2fa73@jic23-huawei>
In-Reply-To: <20240817143647.15998-1-aardelean@baylibre.com>
References: <20240817142257.14470-1-aardelean@baylibre.com>
	<20240817143647.15998-1-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 17:36:47 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> The ad7606_scan_direct() function returns 'int', which is fine for 16-bit
> samples.
> But when going to 18-bit samples, these need to be implemented as 32-bit
> (or int) type.
> 
> In that case when getting samples (which can be negative), we'd get random
> error codes.
> So, the easiest thing is to just move the 'val' pointer to
> 'ad7606_scan_direct()'. This doesn't qualify as a fix, it's just a
> preparation for 18-bit ADCs (of the AD7606 family).

Send it at the start of that series then so as not to confuse me :)

> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index dba1f28782e4..68481e97e50a 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -138,7 +138,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
> +static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
> +			      int *val)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  	int ret;
> @@ -153,7 +154,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  
>  	ret = ad7606_read_samples(st);
>  	if (ret == 0)
> -		ret = st->data[ch];
> +		*val = (short)st->data[ch];
I'd rather see a sign_extend32() for that seeing as you are touching the code.
obviously it's the same thing but nicer to read!
>  
>  error_ret:
>  	gpiod_set_value(st->gpio_convst, 0);
> @@ -173,10 +174,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret = ad7606_scan_direct(indio_dev, chan->address);
> +			ret = ad7606_scan_direct(indio_dev, chan->address, val);
>  			if (ret < 0)
>  				return ret;
> -			*val = (short) ret;
>  			return IIO_VAL_INT;
>  		}
>  		unreachable();


