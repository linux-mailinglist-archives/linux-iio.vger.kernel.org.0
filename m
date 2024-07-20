Return-Path: <linux-iio+bounces-7750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA039381F6
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09802281B59
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C638F83;
	Sat, 20 Jul 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ZyUN7i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDA1E502
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721491309; cv=none; b=MYA0JD8JEtWTTHh49ixaHadsfV5nSdor5Xddo2UQFPooGHXnslkyGoETP0g6pPOhJzGA6je2ZwZ5gOQ4k7PVk/T3rPZRVCjHpRlDZOfGFJfvVM4PGlI1JpHjoOhTZZepXkQvAue4DcOpToipP4w1Af9rZ1ixgRNzS9lmPEJ5U1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721491309; c=relaxed/simple;
	bh=x9FCTpih0ovN2atbOvqsAqwy9pyWLGa6UJ2u4i/clKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXE41W8dwTftvRwWWJxFDnEMZWEK2iC1jFfCHYCimPhpLRjZ0aRwrk/GjauCUSUzi88B7PFtjHycBgPHHB1W1zfyln42Cun+4qyXz5qIUOST/d5GpXf0lAyNMBlpdBdy6cdU6cacrvfjPabfQQUa6DELsDv6O+cYrY0PG/xoKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ZyUN7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3AAC2BD10;
	Sat, 20 Jul 2024 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721491309;
	bh=x9FCTpih0ovN2atbOvqsAqwy9pyWLGa6UJ2u4i/clKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y3ZyUN7iaHAXSVwPl3ASXkyom1grTXsZ11909n1rg7fJZwhuH+vdUDYs6/x6ibnkV
	 hDwsfQisMNlKNopVCp0XvNS+1b7cO5cOmTDAbq/ZLMo0L6RP2pUZQZti+TTyTHnDtf
	 zlOtcL7qg6wNg2QOXoF/k+GEDyxIF5y/ua5OwX4lqeG1WZpZLgecM8uASr+NJ854Cj
	 xiH0SgGtf96mOspBVkax5NEVmoeqRM6gVgoUCqCeEzGSi9RrTj66831oLi/bB5qr+T
	 xbQHkceswVq80rJnlTXS7SuRLk3bSQveTpWtxoeDRDy+57StybUqCM+oNJPCqyZecf
	 JMeP5Dj7W4b+w==
Date: Sat, 20 Jul 2024 17:01:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 03/22] iio: adc: hx711: make use of
 iio_for_each_active_channel()
Message-ID: <20240720170142.6d2c2070@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-3-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-3-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:37:49 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Even before this work from you, this code could certainly have been
less contrary!

Applied.

> ---
>  drivers/iio/adc/hx711.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index b3372ccff7d5..376f4e02de97 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -363,10 +363,7 @@ static irqreturn_t hx711_trigger(int irq, void *p)
>  
>  	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
>  
> -	for (i = 0; i < indio_dev->masklength; i++) {
> -		if (!test_bit(i, indio_dev->active_scan_mask))
> -			continue;
> -
> +	iio_for_each_active_channel(indio_dev, i) {
>  		hx711_data->buffer[j] = hx711_reset_read(hx711_data,
>  					indio_dev->channels[i].channel);
>  		j++;
> 


