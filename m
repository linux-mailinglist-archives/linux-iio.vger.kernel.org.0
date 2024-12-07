Return-Path: <linux-iio+bounces-13200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E09E8169
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FDA18832AF
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D714AD29;
	Sat,  7 Dec 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq0mtIrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161361AAC4;
	Sat,  7 Dec 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733594125; cv=none; b=NrCo8pZct8HMH8+4ZbrvgxC18ia7opzX9CZq7G8eSAwqJi5C0P4UdDYsXTXNgJJTIeLQNfj0Cr3wwI4HV3ankjnrdnPzMOWbjof2Y9kpJq5nnoqykBSKdueu3RcebDb0KOmBrCT0isQHRhGWUIym9Vaure3xHsyWdjrjTyJgUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733594125; c=relaxed/simple;
	bh=Agjz48YAgWrNq7rN9/5i751iTZuEkj61Ljy85oXjCcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/EfH2L2ul12pxG28kV/RtS2PGtMMB/fYxE33PSEHSwTJufBsTZGmz3GHoF10Fq8dJt9Yte/Ki8j9Zn6wnLfUgsd8cDaKAm7QF6Tpq18dNXSnTlHDIgqHei4s0Z4Wh6kTikUbtLIFeBeIh8sF4TlyNNF4C7uQSrCaNMbGlMa3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq0mtIrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5814EC4CECD;
	Sat,  7 Dec 2024 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733594124;
	bh=Agjz48YAgWrNq7rN9/5i751iTZuEkj61Ljy85oXjCcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wq0mtIrnAbOk4usVlAQ4/5eYfslXCSdNo6e6EjGtg9n60SNfo8FfS/Eh3YuK8uxTM
	 FuWeS8cYFumB8jGCey9zv16cWY6I/mC9mmJoLUJzhwyct/lWUcJ3AQsOdA1sFcedn1
	 TEha0mYi76TOzIcePdaOj7ZBIM8yll1irjO6DjFYn+m7P/gshcFlSDxyaB1Coqqx+x
	 CtHGgrjQB9Fi9Z/w/o5dvkya5wshsymexTnhZM/NCAe1dAnUpBTlw09s8fxrB1zcdr
	 /YRapmfw1xJNUT8Co6oYT+3c1qYyPRWO9M0FhkyeHIXV0cSNddml9KPMPbY5cwhx7i
	 /mM1lufy/6dDA==
Date: Sat, 7 Dec 2024 17:55:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: Constify struct iio_info
Message-ID: <20241207175516.4b611eea@jic23-huawei>
In-Reply-To: <da4918af46fef03903ab0e9fdcb4f23e014f3821.1733522812.git.christophe.jaillet@wanadoo.fr>
References: <da4918af46fef03903ab0e9fdcb4f23e014f3821.1733522812.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 23:07:23 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct iio_info' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   17366	   1454	     16	  18836	   4994	drivers/iio/proximity/aw96103.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   17526	   1294	     16	  18836	   4994	drivers/iio/proximity/aw96103.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied. Thanks
Jonathan

> ---
> Compile tested only
> ---
>  drivers/iio/proximity/aw96103.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index cdd254da9e50..3472a2c36e44 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -433,7 +433,7 @@ static int aw96103_write_event_config(struct iio_dev *indio_dev,
>  				  state ? BIT(chan->channel) : 0);
>  }
>  
> -static struct iio_info iio_info = {
> +static const struct iio_info iio_info = {
>  	.read_raw = aw96103_read_raw,
>  	.read_event_value = aw96103_read_event_val,
>  	.write_event_value = aw96103_write_event_val,


