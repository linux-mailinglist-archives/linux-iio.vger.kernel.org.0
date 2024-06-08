Return-Path: <linux-iio+bounces-6056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63890121C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042CB1C20D57
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE03374D9;
	Sat,  8 Jun 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRbhxFFl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008B487A7
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857672; cv=none; b=DyEaCbGqB/6//2c8a1MzF/9CVoyrjVeL9AY9IcgLE9lVONMPoIFIx8cZplQx44VQDqfr+k78CHl5hfepWKBaKLY46FzrloI50+to5WGjCx8bSGpg7u8/Az8mV8LPxTHvaYnU+YsrD478jG7QhxCugYTw2QOZmFy2lM01KQ3+s58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857672; c=relaxed/simple;
	bh=WLlMzizYiiZqeMkdiyJh/LLyTAkqxWS0jtzMlFV30d8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stH5zzMl6eBLCqfN2y2+EUY8vZogdjJDBn8eY7ZLT7WgBf5X+xiuQrE/NWi6AocWbikfjkOOPALPthAIcq/0ag0C3aTVNX1jSXkfGOAsQJ5GVcXz15dYhsKO7OrzpUbQEN/kJljfOKsM0l8T5uVVgFQZNtFly/MCRLHz1Camwe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRbhxFFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F6C2BD11;
	Sat,  8 Jun 2024 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717857672;
	bh=WLlMzizYiiZqeMkdiyJh/LLyTAkqxWS0jtzMlFV30d8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YRbhxFFlfotmBlok5SaXgFDbs2rksotddL8ZNJp9QcS1y0JJ5zM8WMbIzdA2dgVhP
	 BGk7NxAkv6iYhQS9LsltR1EAtQ3sms89fS0j+fnS5mkGgW9rm4WNGg/HplCtLj/mHA
	 OoAzAV6hDYwIxV/TPElP33iAZa/IKPgvDZ99W+a/4CkhVeRL51fseY7yP8nLCBA7f1
	 +e0rrfdDUAqKI7I/fg09V6Q3PfnUBph87MMpZzBJ3EocLqJ8nD1rsxLi/77CQlT/ae
	 +tWA49+bdGVrxNOTKkt+qVbOzUQ5GOP8ddyNiKZjc/2QBzohiGC4IpFpxJNC0Vf9Ju
	 gPYy6EBJ4508w==
Date: Sat, 8 Jun 2024 15:41:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fernando Yang <hagisf@usp.br>
Cc: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de
Subject: Re: [PATCH v2 1/3] iio: adc: ad7266: Fix variable checking bug
Message-ID: <20240608154106.0b0739fa@jic23-huawei>
In-Reply-To: <20240603180757.8560-1-hagisf@usp.br>
References: <20240508155435.183850-1-hagisf@usp.br>
	<20240603180757.8560-1-hagisf@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Jun 2024 15:07:54 -0300
Fernando Yang <hagisf@usp.br> wrote:

> The ret variable was not checked after iio_device_release_direct_mode(),
> which could possibly cause errors
> 
> Signed-off-by: Fernando Yang <hagisf@usp.br>
For future reference, in IIO at least (and 'most' of the rest of the kernel)
don't send a patch set in reply to a previous one.

I can't remember who once gave a good explanation of why, but key to
limited time management when reviewing kernel patches is we start with
latest info and maybe never get back to the beginning.

Given everyone uses threading email clients, your email is a lot of
pages up from where I'd start if I wasn't aiming to clear the whole IIO
backlog this weekend...


> ---
>  drivers/iio/adc/ad7266.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 353a97f9c..13ea8a107 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  		ret = ad7266_read_single(st, val, chan->address);
>  		iio_device_release_direct_mode(indio_dev);
>  
> +		if (ret < 0)
> +			return ret;
>  		*val = (*val >> 2) & 0xfff;
>  		if (chan->scan_type.sign == 's')
>  			*val = sign_extend32(*val,


