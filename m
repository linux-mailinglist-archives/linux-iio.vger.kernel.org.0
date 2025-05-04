Return-Path: <linux-iio+bounces-19033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBCAA86BD
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FC31745D8
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933A42A82;
	Sun,  4 May 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGmAcrDn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277E182;
	Sun,  4 May 2025 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369052; cv=none; b=CZMavTI7MH2ph4STidE7zN9oQXkC8yL+ronlQIlnGKcEcMNN/zvP2RBHVWGCE87zMAQxBLKPO9ofOkCnrPesMXDu9tErwaAMoYGrqbibfZNpyf/n8PdDyh496DFveI174QUOs3+EzsS3hUefwP4GQe8rTuDJFu49MlGyLz5fKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369052; c=relaxed/simple;
	bh=zdeODJsnDb8Xo9JIMSbsPoC/z3Hfxy6u4B+rlCofD/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar8Js3nvCu4UpKU/winFi2gne5aCvJfDWcHLBU8JQ6P3qglkmBOd8msKeoLvke6KZgWw4D5B8jyOCPVKcIsGCDWskeP54q6Mfx0MbF/AtuIeoqyn6yEfir1Cuxgv/TlOg87+49vdzCIjMCSQRbsyKZCro38lDrlRjIfG+PnXuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGmAcrDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECEBC4CEE7;
	Sun,  4 May 2025 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746369052;
	bh=zdeODJsnDb8Xo9JIMSbsPoC/z3Hfxy6u4B+rlCofD/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGmAcrDnJxDWmAyxvCrUKrfHT0UYhJevcuaagxxegGEoLzzJsfVngGk82Y8mICdWG
	 L0ZDEBeSwtgCxyFN5DIXOkY3aGAsRpl1fGrphDsqWmu3Hvc2MHgeF9qCIhOxmw2Z5C
	 5NA3ff68eW7NvEspox0QIEA7gntDgZGJ6gqPgJVmSkU4CPheDJOZLxJRJ87272DFzR
	 c1ZDYDq4isTpeD7qqA/9LOgAP2DmzZwXfkeJizVoAyAdKvqnZf7auYAnw4QK6Eiqgu
	 FjTHFfoR4D6UH6UjphFKS050ikRAkubdhI7pTQa4s/LdTeqIItMkTcCIyMAyeB3Kek
	 k8k1TB9b2NWYQ==
Date: Sun, 4 May 2025 15:30:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Remove redundant conditionals
Message-ID: <20250504153044.1109d508@jic23-huawei>
In-Reply-To: <20250503185651.29445-1-gye976@gmail.com>
References: <20250503185651.29445-1-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 May 2025 03:56:50 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Checks for null initially and return early.
> So there is no need to check for null later.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

So the key thing here is what does this path mean.  trig == NULL
means we are clearing the current trigger.  The snag is you just jumped
over the code that removes the old trigger or sets
indio_dev->trig = NULL.

So I think the new version you have here is broken.

For changes like this it is fairly easy to test them using the
dummy driver.  Please make sure to do so and make sure you trigger
all paths.  Here that would be.

No trigger -> trigger 1
trigger 1 -> trigger 2
trigger 2 -> no trigger
 

> ---
>  drivers/iio/industrialio-trigger.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..6abf2a450202 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -453,36 +453,32 @@ static ssize_t current_trigger_store(struct device *dev,
>  	}
>  
>  	trig = iio_trigger_acquire_by_name(buf);
> -	if (oldtrig == trig) {
> +	if (!trig || trig == oldtrig) {
>  		ret = len;
>  		goto out_trigger_put;
>  	}
> -
> -	if (trig && indio_dev->info->validate_trigger) {
> +	if (indio_dev->info->validate_trigger) {
>  		ret = indio_dev->info->validate_trigger(indio_dev, trig);
>  		if (ret)
>  			goto out_trigger_put;
>  	}
> -
> -	if (trig && trig->ops && trig->ops->validate_device) {
> +	if (trig->ops && trig->ops->validate_device) {
>  		ret = trig->ops->validate_device(trig, indio_dev);
>  		if (ret)
>  			goto out_trigger_put;
>  	}
>  
> -	indio_dev->trig = trig;

This and...

> -
>  	if (oldtrig) {

this need to run if oldtrig was set and trig is not.

>  		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
>  			iio_trigger_detach_poll_func(oldtrig,
>  						     indio_dev->pollfunc_event);
>  		iio_trigger_put(oldtrig);
>  	}
> -	if (indio_dev->trig) {
> -		if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> -			iio_trigger_attach_poll_func(indio_dev->trig,
> -						     indio_dev->pollfunc_event);
> -	}
> +	if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> +		iio_trigger_attach_poll_func(trig,
> +						indio_dev->pollfunc_event);
> +
> +	indio_dev->trig = trig;
>  
>  	return len;
>  


